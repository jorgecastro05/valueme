<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="\${message(code: '${propertyName}.label', default: '${className}')}" />
    <title>
        <g:message code="default.list.label" args="[entityName]" />
    </title>
</head>

<body>
    <a href="#list-${propertyName}" class="ui hidden message" tabindex="-1">
        <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
    </a>
    <g:if test="\${flash.message}">
        <div class="ui positive message">
            <i class="close icon"></i> \${flash.message}
        </div>
    </g:if>
    <!-- buttons -->
    <g:link class="ui fluid button " action="create">
        <g:message code="default.new.label" args="[entityName]" /></g:link>
    <h3><g:message code="default.list.label" args="[entityName]" /></h3>
    <!-- form -->
    <div id="list-${propertyName}" class="content scaffold-list" role="main">
        <f:table collection="\${${propertyName}List}" />
        <div class="pagination">
            <g:paginate total="\${${propertyName}Count ?: 0}" />
        </div>
    </div>
</body>

</html>
