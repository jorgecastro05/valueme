<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="permission" />
    <title>
        <g:message code="default.list.label" args="[entityName]" />
    </title>
</head>

<body>
    <g:if test="${flash.message}">
        <div class="ui positive message">
            <i class="close icon"></i> ${flash.message}
        </div>
    </g:if>
    <div class="ui stackable grid">
        <div class="twelve wide column">
            <h3><g:message code="${entityName}.list.label" /></h3>
        </div>
        <div class="four wide column">
            <g:link class="fluid ui blue fluid button " action="create">
                <g:message code="default.new.label" />
            </g:link>
        </div>
        <div class="ui hidden divider"></div>
    </div>
    <table class="ui compact selectable table">
        <thead>
            <tr>
                <g:sortableColumn property="permission" title="${message(code: 'permission.permission.label')}" />
                <th>
                    <g:message code="default.options.label" />
                </th>
            </tr>
        </thead>
        <g:each in="${permissionList}" var="permission">
            <tr>
                <td>
                    <g:link action="show" id="${permission.id}">
                        ${permission.permission}
                    </g:link>
                </td>
                <td>
                    <g:link action="edit" id="${permission.id}">
                        <g:message code="default.button.edit.label" />
                    </g:link>
                </td>
            </tr>
        </g:each>
    </table>
    <div class="pagination">
        <g:paginate total="${permissionCount ?: 0}" />
    </div>
    </div>
</body>

</html>
