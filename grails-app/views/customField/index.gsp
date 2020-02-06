<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="customField" />
    <title>
        <g:message code="default.list.label" args="[entityName]" />
    </title>
</head>

<body>
    <a href="#list-customField" class="ui hidden message" tabindex="-1">
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
            <h3><g:message code="${entityName}.list.label"/></h3>
        </div>
        <div class="four wide column">
            <g:link class="fluid ui blue fluid button " action="create">
                <g:message code="default.new.label" />
            </g:link>
        </div>
        <div class="ui hidden divider"></div>
    </div>
    <!-- form -->
    <div id="list-customField" class="content scaffold-list" role="main">
        <table class="ui compact selectable table">
            <thead>
                <tr>
                    <g:sortableColumn property="name" title="${message(code: 'customField.name.label')}" />
                    <g:sortableColumn property="type" title="${message(code: 'customField.type.label')}" />
                    <g:sortableColumn property="section" title="${message(code: 'customField.section.label')}" />
                    <th>
                        <g:message code="customField.description.label" />
                    </th>
                    <th>
                        <g:message code="customField.active.label" />
                    </th>
                    <th>
                        <g:message code="customField.required.label" />
                    </th>
                    <th>
                        <g:message code="default.options.label" />
                    </th>
                </tr>
            </thead>
            <g:each in="${customFieldList}" var="customField">
                <tr>
                    <td>
                        <g:link action="show" id="${customField.id}">
                            ${customField.name}
                        </g:link>
                    </td>
                    <td>
                        <g:message code="customField.${customField.type}" />
                    </td>
                    <td>
                        <g:message code="customField.${customField.section}" />
                    </td>
                    <td>
                        ${customField.description}
                    </td>
                    <td>
                        <g:formatBoolean boolean="${customField.active}" />
                    </td>
                    <td>
                        <g:formatBoolean boolean="${customField.required}" />
                    </td>
                    <td>
                        <g:link action="edit" id="${customField.id}">
                            <g:message code="default.button.edit.label" />
                        </g:link>
                    </td>
                </tr>
            </g:each>
        </table>
        <div class="pagination">
            <g:paginate total="${customFieldCount ?: 0}" />
        </div>
    </div>
</body>

</html>
