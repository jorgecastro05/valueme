 /*
 * # Valueme App
 * Table Custom Field extension code
 * For views create - edit custom field values of type List
 */

var value = [];

function addElement() {
    var tbl = document.getElementById("tableOptions");
    var vl = document.getElementById("currentValue");
    var row = tbl.insertRow(-1);
    var cell1 = row.insertCell(0);
    var cell2 = row.insertCell(1);
    var cell3 = row.insertCell(2);
    var cell4 = row.insertCell(3);
    cell1.innerHTML = vl.value;
    cell2.innerHTML = "<button class=\"ui mini button\" type=\"button\" onclick=\"deleteElement(this)\">Eliminar </button>";
    cell3.innerHTML = "<i class=\"move-up link arrow up icon\"></i>";
    cell4.innerHTML = "<i class=\"move-down link arrow down icon\"></i>";
    vl.value = "";
}

function deleteElement(r) {
    var i = r.parentNode.parentNode.rowIndex;
    document.getElementById("tableOptions").deleteRow(i);
}

$("[name='jftForm']").submit(function() {

    var table = document.getElementById("tableOptions");
    for (var i = 1, row; row = table.rows[i]; i++) {
        row.cells[0].innerHTML = row.cells[0].innerHTML.replace(/(\r\n|\n|\r)/gm,"");
        row.cells[0].innerHTML = row.cells[0].innerHTML.replace(/ +(?= )/g,'');
        row.cells[0].innerHTML = row.cells[0].innerHTML.trim();
        value.push(row.cells[0].innerHTML + '*')
    }

    $("[name='value']").val(value);
});


$('table').on('click', '.move-up', function() {
    var thisRow = $(this).closest('tr');
    var prevRow = thisRow.prev();
    if (prevRow.length) {
        prevRow.before(thisRow);
    }
});

$('table').on('click', '.move-down', function() {
    var thisRow = $(this).closest('tr');
    var nextRow = thisRow.next();
    if (nextRow.length) {
        nextRow.after(thisRow);
    }
});
