/*
 * Copyright 2012 CarCV Development Team
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.carcv.web.test;

import org.carcv.core.model.Address;
import org.carcv.core.model.CarData;
import org.carcv.core.model.NumberPlate;
import org.carcv.core.model.Speed;
import org.carcv.core.model.SpeedUnit;
import org.carcv.core.model.file.FileCarImage;
import org.carcv.core.model.file.FileEntry;
import org.carcv.web.beans.EntryBean;
import org.jboss.arquillian.container.test.api.Deployment;
import org.jboss.arquillian.junit.Arquillian;
import org.jboss.shrinkwrap.api.spec.WebArchive;
import static org.junit.Assert.*;
import org.junit.Test;
import org.junit.runner.RunWith;

import javax.ejb.EJB;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.Date;

@RunWith(Arquillian.class)
public class PersistenceIT {

    @EJB
    private EntryBean entryBean;

    @Deployment
    public static WebArchive createDeployment() {
        return AbstractIT.createGenericDeployment();
    }

    @Test
    public void persistenceTest() {
        // Entity code
        Speed speed = new Speed(80d, SpeedUnit.KPH);
        Address address = new Address("Myjava", "90701", "Jablonská", "Slovakia", 27, 860);
        NumberPlate licencePlate = new NumberPlate("MY-077AU", "SK");
        Date timestamp = new Date(System.currentTimeMillis());
        FileCarImage carImage = new FileCarImage(Paths.get("/tmp/test/video.h264"));
        CarData carData = new CarData(speed, address, licencePlate, timestamp);
        FileEntry fileEntry = new FileEntry(carData, Arrays.asList(carImage));
        assertNotNull(fileEntry);
        // End entity code

        // Persist
        assertNotNull(entryBean);
        entryBean.persist(fileEntry);

        // Get
        FileEntry got = entryBean.getAll().get(0);
        assertEquals(fileEntry, got);

        // Check
        assertEquals(carImage, got.getCarImages().get(0));
        assertEquals(speed, got.getCarData().getSpeed());
        assertEquals(address, got.getCarData().getAddress());
        assertEquals(licencePlate, got.getCarData().getNumberPlate());
        assertEquals(carData, got.getCarData());
        assertEquals(timestamp, got.getCarData().getTimestamp());
        assertEquals(fileEntry, got);

        // Remove
        entryBean.remove(fileEntry.getId());
        assertEquals(0, entryBean.getAll().size());
        assertEquals(null, entryBean.findById(fileEntry.getId()));
    }
}
