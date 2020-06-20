<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'userAccount.label', default: 'UserAccount')}" />
    <title>
        <g:message code="default.edit.label" args="[entityName]" />
    </title>
</head>
<g:if test="${flash.message}">
    <div class="ui positive message">
        <i class="close icon"></i> ${flash.message}
    </div>
</g:if>
<g:if test="${flash.error}">
        <div class="ui negative message">
            <i class="close icon"></i> ${flash.error}
        </div>
</g:if>
<g:hasErrors bean="${this.userAccount}">
    <div class="ui error message">
        <i class="close icon"></i>
        <g:eachError bean="${this.userAccount}" var="error">
            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
                <g:message error="${error}" />
            </li>
        </g:eachError>
    </div>
</g:hasErrors>
<!-- buttons -->
<sec:access controller="userAccount">
    <g:link class="ui blue fluid button " action="index">
        <g:message code="default.list.label" args="[entityName]" /></g:link>
</sec:access>
<h3><g:message code="default.edit.label" args="[entityName]" /></h3>
<g:form resource="${this.userAccount}" method="PUT" class="ui form">
    <g:hiddenField name="editPassword" value="true" />
    <div class="field">
        <label>
            <g:message code="userAccount.password.label" />
            <g:help message="help.userAccount.password.new" />
        </label>
        <input id="password" name="password" type="password">
    </div>
    <div class="field">
        <label>
            <g:message code="userAccount.passwordRetype.label" />
        </label>
        <input id="passwordRetype" name="passwordRetype" type="password">
    </div>
    <div class="error"></div>
    <div class="ui error message"></div>
    <input class="ui blue fluid button " type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
</g:form>
</body>

</html>
