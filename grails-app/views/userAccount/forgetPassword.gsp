<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <title>
        <g:message code="userAccount.forgetPassword.label" />
    </title>
</head>
<g:if test="${flash.success}">
    <div class="ui positive message">
        <i class="close icon"></i> ${flash.success}
    </div>
</g:if>
<g:if test="${flash.error}">
    <div class="ui error message">
        <i class="close icon"></i> ${flash.error}
    </div>
</g:if>
<h3><g:message code="userAccount.resetPassword.label"/></h3>
<g:help message="help.userAccount.resetPassword"/>
<g:form class="ui form" action="resetPassword">
        <div class="field">
                <label>
                    <g:message code="userAccount.label" />
                </label>
                <g:field type="email" name="userAccount" />
            </div>
    <input class="ui blue fluid button " type="submit" value="${message(code: 'userAccount.resetPassword.label')}" />
</g:form>
</body>

</html>
