<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="param" />
    <title>
        <g:message code="default.list.label" args="[entityName]" />
    </title>
</head>

<body>
    <a href="#list-param" class="ui hidden message" tabindex="-1">
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
            <h3><g:message code="${entityName}.list.label" /></h3>
        </div>
        <div class="four wide column">
            <g:link class="fluid ui blue fluid button " action="create">
                <g:message code="default.new.label" />
            </g:link>
        </div>
        <div class="ui hidden divider"></div>
    </div>
    <!-- form -->
    <div id="list-param" class="content scaffold-list" role="main">
        <table class="ui fixed single line selectable table">
            <thead>
                <tr>
                    <g:sortableColumn property="name" title="${message(code: 'param.name.label')}" />

                    <g:sortableColumn property="description" title="${message(code: 'param.description.label')}" />
                    <g:sortableColumn property="value" title="${message(code: 'param.value.label')}" />
                    <g:sortableColumn property="label" title="${message(code: 'param.label.label')}" />
                    <th>
                        <g:message code="default.options.label" />
                    </th>
                </tr>
            </thead>
            <g:each in="${paramList}" var="param">
                <tr>
                    <td>
                        <g:link action="show" id="${param.id}">
                            ${param.name}
                        </g:link>
                    </td>
                    <td>
                        ${param.description}
                    </td>
                    <td>
                        ${param.value}
                    </td>
                    <td>
                        ${param.label}
                    </td>
                    <td>
                        <g:link action="edit" id="${param.id}">
                            <g:message code="default.button.edit.label" />
                        </g:link>
                    </td>
                </tr>
            </g:each>
        </table>
        <div class="pagination">
            <g:paginate total="${paramCount ?: 0}" />
        </div>
    </div>
</body>

</html>
