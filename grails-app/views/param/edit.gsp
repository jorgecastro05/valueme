<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'param.label', default: 'Param')}" />
    <title>
        <g:message code="default.edit.label" args="[entityName]" />
    </title>
</head>

<body>
    <a href="#edit-param" class="ui hidden message" tabindex="-1">
        <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
    </a>
    <!-- messages -->
    <g:if test="${flash.message}">
        <div class="ui positive message">
            <i class="close icon"></i> ${flash.message}
        </div>
    </g:if>
    <g:hasErrors bean="${this.param}">
        <div class="ui error message">
            <i class="close icon"></i>
            <g:eachError bean="${this.param}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
                    <g:message error="${error}" />
                </li>
            </g:eachError>
        </div>
    </g:hasErrors>
    <!-- buttons -->
    <div class="ui two buttons">
        <g:link class="ui blue fluid button " action="index">
            <g:message code="default.list.label" args="[entityName]" /></g:link>
        <g:link class="ui blue fluid button " action="create">
            <g:message code="default.new.label" args="[entityName]" /></g:link>
    </div>
    <h3><g:message code="default.edit.label" args="[entityName]" /></h3>
    <!-- form -->
    <div id="edit-param" class="content scaffold-edit" role="main">
        <g:form resource="${this.param}" method="PUT" class="ui form" role="form">
            <g:hiddenField name="version" value="${this.param?.version}" />
            <div class="field">
                <label>
                    <g:message code="param.name.label" />
                </label>
                <f:input bean="param" property="name" />
            </div>
            <div class="field">
                <label>
                    <g:message code="param.description.label" />
                </label>
                <f:input bean="param" property="description" />
            </div>
            <div class="field">
                <label>
                    <g:message code="param.value.label" />
                </label>
                <f:input bean="param" property="value" />
            </div>
            <div class="field">
                <label>
                    <g:message code="param.label.label" />
                </label>
                <f:input bean="param" property="label" />
            </div>
            <input class="ui blue fluid button " type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
        </g:form>
    </div>
</body>

</html>
