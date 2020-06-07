<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'permission.label', default: 'Permission')}" />
    <title>
        <g:message code="default.edit.label" args="[entityName]" />
    </title>
</head>

<body>
    <div class="btn-group" role="group">
        <g:link class="ui blue fluid button " action="create">
            <g:message code="default.new.label" args="[entityName]" /></g:link>
    </div>
    <div id="edit-permission" class="content scaffold-edit" role="main">
        <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
        <g:if test="${flash.message}">
            <div class="ui positive message">
                <i class="close icon"></i> ${flash.message}
            </div>
        </g:if>
        <g:hasErrors bean="${this.permission}">
            <div class="ui error message">
                <i class="close icon"></i>
                <g:eachError bean="${this.permission}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
                        <g:message error="${error}" />
                    </li>
                </g:eachError>
            </div>
        </g:hasErrors>
        <g:form resource="${this.permission}" method="PUT" class="ui form">
            <g:hiddenField name="version" value="${this.permission?.version}" />
            <g:hiddenField name="oldPermission" value="${oldPermission}" />
           <div class="field">
                <label>
                    <g:message code="permission.label" />
                </label>
                <f:input bean="permission" property="permission" />
            </div>
            
            <input class="ui blue fluid button " type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
        </g:form>
    </div>
</body>

</html>
