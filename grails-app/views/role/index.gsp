<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}" />
    <title>
        <g:message code="default.list.label" args="[entityName]" />
    </title>
</head>

<body>
    <a href="#list-role" class="ui hidden message" tabindex="-1">
        <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
    </a>
    <g:if test="${flash.message}">
        <div class="ui positive message">
            <i class="close icon"></i> ${flash.message}
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
    <div id="list-role" class="content scaffold-list" role="main">
        <table class="ui compact selectable table">
            <thead>
                <tr>
                    <g:sortableColumn property="role" title="${message(code: 'role.role.label')}" />
                    <th>
                        <g:message code="default.options.label" />
                    </th>
                </tr>
            </thead>
            <g:each in="${roleList}" var="role">
                <tr>
                    <td>
                        <g:link action="show" id="${role.id}">
                            ${role.role}
                        </g:link>
                    </td>
                    <td>
                        <g:link action="edit" id="${role.id}">
                            <g:message code="default.button.edit.label" />
                        </g:link>
                    </td>
                </tr>
            </g:each>
        </table>
        <g:paginate total="${roleCount ?: 0}" />
    </div>
</body>

</html>
