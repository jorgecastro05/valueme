<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'categoryType.label', default: 'categoryType')}" />
    <title>
        <g:message code="default.create.label" args="[entityName]" />
    </title>
</head>

<body>
    <a href="#edit-categoryType" class="ui hidden message" tabindex="-1">
        <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
    </a>
    <!-- messages -->
    <g:if test="${flash.message}">
        <div class="ui positive message">
            <i class="close icon"></i> ${flash.message}
        </div>
    </g:if>
    <g:hasErrors bean="${this.categoryType}">
        <div class="ui error message">
            <i class="close icon"></i>
            <g:eachError bean="${this.categoryType}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <g:message error="${error}" />
                </li>
            </g:eachError>
        </div>
    </g:hasErrors>
    <!-- buttons -->
    <g:link class="ui blue fluid button " action="index">
        <g:message code="default.list.label" args="[entityName]" /></g:link>
    <h3><g:message code="default.create.label" args="[entityName]" /></h3>
    <!-- form -->
    <div id="create-categoryType">
        <g:form action="save" class="ui form" role="form">
            <div class="field">
                <label>
                    <g:message code="categoryType.name.label" />
                </label>
                <f:input bean="categoryType" property="name"/>
            </div>
            <g:submitButton name="create" class="ui blue fluid button " value="${message(code: 'default.button.create.label', default: 'Create')}" />
        </g:form>
</body>

</html>
