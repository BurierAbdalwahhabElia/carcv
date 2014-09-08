<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link rel="SHORTCUT ICON" href="http://upload.wikimedia.org/wikipedia/commons/f/f0/Car_with_Driver-Silhouette.svg">
<link rel="icon" href="http://upload.wikimedia.org/wikipedia/commons/f/f0/Car_with_Driver-Silhouette.svg" type="image/ico">
<title>CarCV Car Table</title>
<link rel="stylesheet" type="text/css" href="/resources/site.css">
<link rel="stylesheet" type="text/css" href="/resources/jquery.dataTables.css">
<style type="text/css">
#tabulator {
    text-align: center;
    height: 25px
}
</style>

<script type="text/javascript" language="javascript" src="/resources/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="/resources/jquery.dataTables.min.js"></script>
<script type="text/javascript" class="init">
$(document).ready(function () {
    $('#carTable').dataTable({
        "scrollY": "100%",
        "scrollCollapse": false,
        "paging": false
    });

    var table = $('#carTable').DataTable();

    $('#carTable tbody').on('click', 'tr', function () {
        $(this).toggleClass('selected');
    });

    $('#deleteButton').click(function () {
        if (!confirm("Are you sure you want to delete?")) {
            return;
        }
        var rows = table.rows('.selected');
        console.log(table.rows('.selected').length);
        console.log(rows.length);
        console.log("INTERMEZZO");
        if (rows.data().length <= 0) {
            alert("The selection is empty!");
            return;
        }
        var idString = "";
        var idColumnData = rows.column(0).data();
        console.log(table.rows('.selected').column(0).data());
        console.log(rows.column(0).data());
        console.log(idColumnData);
        for (var id in idColumnData) {
            idString += idColumnData[id] + ",";
        }
        console.log("idString: " + idString);
        idString = idString.substring(0, idString.length - 1);
        console.log("idString: " + idString);
        window.parent.location.replace("/admin/servlet/RemoveEntry?entry_id=" + idString);
        //table.rows('.selected').remove().draw( false ); //TODO 3 Make table editable w/o reload
    });
});
	</script>

</head>
<body>
    <c:if test="${isAdmin}"><button id="deleteButton">Delete selected rows</button></c:if><br>
    <table id="carTable" class="display" cellspacing="0" width="100%">
    <thead>
        <tr>
            <th>ID</th>
            <th>Picture</th>
            <th>Date</th>
            <th>License plate</th>
            <th>Location</th>
            <th>Video</th>
            <th>Report</th>
        </tr>
    </thead>

    <tfoot>
        <tr>
            <th>ID</th>
            <th>Picture</th>
            <th>Date</th>
            <th>License plate</th>
            <th>Location</th>
            <th>Video</th>
            <th>Report</th>
        </tr>
    </tfoot>

    <tbody>
        <c:forEach var="member" items="${wrtmList}">
            <tr>
                <td>${member.entryId}</td>
                <td><a href="/servlet/DisplayImage?path=${member.previewPath}" target="_top">
                <img src="/servlet/DisplayImage?path=${member.previewPath}&width=200" style="border: 2px; width: 100%"
                    alt="Car"></a></td>
                <td>${member.date}<br> ${member.time}</td>
                <td>${member.licensePlate}</td>
                <td>${member.location}</td>
                <td><a href="/servlet/GenerateVideo?entry_id=${member.entryId}" target="_top">View</a></td>
                <td><a href="/servlet/GenerateReport?entry_id=${member.entryId}&timezone=${member.timeZone}" target="_top">Generate</a></td>
            </tr>
        </c:forEach>
    </tbody>
    </table>
</body>
</html>