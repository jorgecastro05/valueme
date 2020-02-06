<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="\${message(code: '${propertyName}.label', default: '${className}')}" />
    <title>
        <g:message code="default.create.label" args="[entityName]" />
    </title>
</head>

<body>
    <a href="#edit-${propertyName}" class="ui hidden message" tabindex="-1">
        <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
    </a>
    <!-- messages -->
    <g:if test="\${flash.message}">
        <div class="ui positive message">
            <i class="close icon"></i> \${flash.message}
        </div>
    </g:if>
    <g:hasErrors bean="\${this.${propertyName}}">
        <div class="ui error message">
            <i class="close icon"></i>
            <g:eachError bean="\${this.${propertyName}}" var="error">
                <li <g:if test="\${error in org.springframework.validation.FieldError}">data-field-id="\${error.field}"</g:if>>
                    <g:message error="\${error}" />
                </li>
            </g:eachError>
        </div>
    </g:hasErrors>
    <!-- buttons -->
    <g:link class="ui fluid button " action="index">
        <g:message code="default.list.label" args="[entityName]" /></g:link>
    <h3 class="text-center"><g:message code="default.create.label" args="[entityName]" /></h3>
    <!-- form -->
    <div id="create-${propertyName}">
        <g:form action="save" class="ui form" role="form">
            <fieldset class="form">
                <f:all bean="${propertyName}" />
            </fieldset>
            <g:submitButton name="create" class="ui fluid button " value="\${message(code: 'default.button.create.label', default: 'Create')}" />
        </g:form>
    </div>
</body>

</html>
