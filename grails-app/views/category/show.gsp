<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'category.label', default: 'Category')}" />
    <title>
        <g:message code="default.show.label" args="[entityName]" />
    </title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
    google.charts.load('current', {
        packages: ["orgchart"]
    });
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Name');
        data.addColumn('string', 'Manager');
        data.addColumn('string', 'ToolTip');

        // For each orgchart box, provide the name, manager, and tooltip to show.
        <%
        for(category in categoryList) { %>
        data.addRow(['${category.name}', '${category.parent.name}', '${category.type.name}']);
        <% }%>

        // Create the chart.
        var chart = new google.visualization.OrgChart(document.getElementById('chart_div'));
        // Draw the chart, setting the allowHtml option to true for the tooltips.
        chart.draw(data, {
            allowHtml: true
        });
    }
    </script>
    <style>
    table {
        border-collapse: separate !important;
    }
    </style>
</head>

<body>
    <a href="#show-category" class="ui hidden message" tabindex="-1">
        <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
    </a>
    <!-- messages -->
    <g:if test="${flash.message}">
        <div class="ui positive message">
            <i class="close icon"></i> ${flash.message}
        </div>
    </g:if>
    <!-- buttons -->
        <g:link class="ui blue fluid button " action="create">
            <g:message code="default.new.label" args="[entityName]" /></g:link>
    <h3 class="text-center"><g:message code="default.show.label" args="[entityName]" /></h3>
    <!-- form -->
    <div id="show-category" class="content scaffold-show" role="main">
        <div class="ui celled list">
            <div class="item">
                <div class="header">
                    <g:message code="category.label" />
                </div>
                ${category.name}
            </div>
            <div class="item">
                <div class="header">
                    <g:message code="category.type.label" />
                </div>
                ${category.type.name}
            </div>
            <div class="item">
                <div class="header">
                    <g:message code="category.order.label" />
                </div>
                ${category.order}
            </div>
            <div class="item">
                <div class="header">
                    <g:message code="category.active.label" />
                </div>
                <g:formatBoolean boolean="${category.active}" />
            </div>
            <div class="item">
                <div class="header">
                    <g:message code="category.description.label" />
                </div>
                ${category.description}
            </div>
            <div class="item">
                <div class="header">
                    <g:message code="category.color.label" />
                </div>
                <div class="ui label circular" style="background: ${category.color}">
                </div>
            </div>
            <div class="item">
                <div class="header">
                    <g:message code="category.childs.label" />
                </div>
                ${category.childs?.name}
            </div>
            <div class="item">
                <div class="header">
                    <g:message code="category.parent.label" />
                </div>
                ${category.parent?.name}
            </div>
            <div class="item">
                <div class="header">
                </div>
                <div id="chart_div"></div>
            </div>
            <g:form resource="${this.category}" method="DELETE">
            <g:hiddenField name="categoryType" value="${categoryType}" />
                <div class="ui two buttons">
                    <g:link class="ui blue fluid button " action="edit" resource="${this.category}" params="[categoryType: flash.categoryType]">
                        <g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="ui blue fluid button " type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </div>
            </g:form>
        </div>
</body>

</html>
