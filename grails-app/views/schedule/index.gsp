<!DOCTYPE html>
<html>

<head>
    <meta content="main" name="layout" />
    <g:set value="${message(code: 'schedule.label', default: 'Schedule')}" var="entityName">
    </g:set>
    <title>
        <g:message args="[entityName]" code="default.list.label">
        </g:message>
    </title>
</head>

<body>
    <a class="ui hidden message" href="#list-schedule" tabindex="-1">
        <g:message code="default.link.skip.label" default="Skip to content…">
        </g:message>
    </a>
    <g:if test="${flash.message}">
        <div class="ui positive message">
            <i class="close icon">
                </i> ${flash.message}
        </div>
    </g:if>
    <!-- buttons -->
    <div class="ui stackable grid">
        <div class="twelve wide column">
            <h3><g:message code="default.list.label" args="[entityName]"/></h3>
        </div>
        <div class="four wide column">
            <g:link class="fluid ui blue fluid button " action="create">
                <g:message code="default.new.label" args="[entityName]" />
            </g:link>
        </div>
        <div class="ui hidden divider"></div>
    </div>
    <!-- form -->
    <div class="content scaffold-list" id="list-schedule" role="main">
        <table class="ui compact selectable table">
            <thead>
                <tr>
                    <g:sortableColumn property="vigency" title="${message(code: 'schedule.vigency.label')}" />
                    <g:sortableColumn property="active" title="${message(code: 'schedule.active.label')}" />
                    <th>
                        <g:message code="schedule.startDate.label"></g:message>
                    </th>
                    <th>
                        <g:message code="schedule.endDate.label"></g:message>
                    </th>
                    <th>
                        <g:message code="default.options.label">
                        </g:message>
                    </th>
                </tr>
            </thead>
            <g:each in="${scheduleList}" var="schedule">
                <tr>
                    <td>
                        <g:link action="show" id="${schedule.id}">
                            ${schedule.vigency}
                        </g:link>
                    </td>
                    <td>
                        <g:formatBoolean boolean="${schedule.active}" />
                    </td>
                    <td>
                        <g:formatDate format="dd MMMM yyyy" date="${schedule.startDate}" />
                    </td>
                    <td>
                        <g:formatDate format="dd MMMM yyyy" date="${schedule.endDate}" />
                    </td>
                    <td>
                        <g:link action="edit" id="${schedule.id}">
                            <g:message code="default.button.edit.label">
                            </g:message>
                        </g:link>
                    </td>
                </tr>
            </g:each>
        </table>
        <div class="pagination">
            <g:paginate total="${scheduleCount ?: 0}">
            </g:paginate>
        </div>
    </div>
</body>

</html>
