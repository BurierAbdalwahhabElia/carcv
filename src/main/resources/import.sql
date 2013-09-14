
    alter table cardata 
        drop 
        foreign key FK_1mmwmtg5huovdu8mt86a2akf9

    alter table cardata 
        drop 
        foreign key FK_994012bbkvn5j2pltr75s4anr

    alter table cardata 
        drop 
        foreign key FK_864eext49yh9ovraaytj6twc1

    alter table cardata 
        drop 
        foreign key FK_kph3s3fumkloeo2cewum7q0w1

    alter table entry 
        drop 
        foreign key FK_lqvihkmhrpp5h6fjuqus6iahp

    alter table entry 
        drop 
        foreign key FK_2jkxkctbl544jojwx6wu8aj2c

    drop table if exists address

    drop table if exists cardata

    drop table if exists entry

    drop table if exists licenceplate

    drop table if exists mediaobject

    drop table if exists speed

    create table address (
        id bigint not null auto_increment,
        city varchar(255),
        country varchar(255),
        latitude double precision,
        longitude double precision,
        postalcode varchar(255),
        referenceNumber integer,
        street varchar(255),
        streetNumber integer,
        primary key (id)
    )

    create table cardata (
        id bigint not null auto_increment,
        timestamp datetime,
        licencePlate_id bigint,
        location_id bigint,
        speed_id bigint,
        video_id bigint,
        primary key (id)
    )

    create table entry (
        id bigint not null auto_increment,
        data_id bigint,
        preview_id bigint,
        primary key (id)
    )

    create table licenceplate (
        id bigint not null auto_increment,
        origin varchar(255),
        text varchar(255),
        primary key (id)
    )

    create table mediaobject (
        id bigint not null auto_increment,
        URL varchar(255),
        mediatype integer,
        primary key (id)
    )

    create table speed (
        id bigint not null auto_increment,
        speed double precision,
        unit integer,
        primary key (id)
    )

    alter table cardata 
        add index FK_1mmwmtg5huovdu8mt86a2akf9 (licencePlate_id), 
        add constraint FK_1mmwmtg5huovdu8mt86a2akf9 
        foreign key (licencePlate_id) 
        references licenceplate (id)

    alter table cardata 
        add index FK_994012bbkvn5j2pltr75s4anr (location_id), 
        add constraint FK_994012bbkvn5j2pltr75s4anr 
        foreign key (location_id) 
        references address (id)

    alter table cardata 
        add index FK_864eext49yh9ovraaytj6twc1 (speed_id), 
        add constraint FK_864eext49yh9ovraaytj6twc1 
        foreign key (speed_id) 
        references speed (id)

    alter table cardata 
        add index FK_kph3s3fumkloeo2cewum7q0w1 (video_id), 
        add constraint FK_kph3s3fumkloeo2cewum7q0w1 
        foreign key (video_id) 
        references mediaobject (id)

    alter table entry 
        add index FK_lqvihkmhrpp5h6fjuqus6iahp (data_id), 
        add constraint FK_lqvihkmhrpp5h6fjuqus6iahp 
        foreign key (data_id) 
        references cardata (id)

    alter table entry 
        add index FK_2jkxkctbl544jojwx6wu8aj2c (preview_id), 
        add constraint FK_2jkxkctbl544jojwx6wu8aj2c 
        foreign key (preview_id) 
        references mediaobject (id)
