<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'userAccount.label', default: 'UserAccount')}" />
    <title>
        <g:message code="default.show.label" args="[entityName]" />
    </title>
</head>

<body>
    <a href="#show-userAccount" class="ui hidden message" tabindex="-1">
        <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
    </a>
    <!-- messages -->
    <g:if test="${flash.message}">
        <div class="ui positive message">
            <i class="close icon"></i> ${flash.message}
        </div>
    </g:if>
    <!-- buttons -->
    <sec:access controller="userAccount">
        <div class="two ui fluid buttons">
            <g:link class="ui blue button " action="index">
                <g:message code="default.list.label" args="[entityName]" /></g:link>
            <g:link class="ui blue button " action="create">
                <g:message code="default.new.label" args="[entityName]" /></g:link>
        </div>
    </sec:access>
    <h3><g:message code="default.show.label" args="[entityName]" /></h3>
    <!-- form -->
    <div id="show-userAccount" class="content scaffold-show" role="main">
        <div class="ui celled list">
            <div class="item">
                <div class="header">
                    <g:message code="userAccount.label" />
                </div>
                ${userAccount.username}
            </div>
            <div class="item">
                <div class="header">
                    <g:message code="userAccount.roles.label" />
                </div>
                ${userAccount.getAuthorities().name}
            </div>
            <div class="item">
                <div class="header">
                    <g:message code="userAccount.fullName.label" />
                </div>
                ${userAccount.fullName}
            </div>
            <div class="item">
                <div class="header">
                    <g:message code="userAccount.enabled.label" />
                </div>
                <g:formatBoolean boolean="${userAccount.enabled}" />
            </div>
            <div class="item">
                <div class="header">
                    <g:message code="category.label" />
                </div>
                ${userAccount.category?.name}
            </div>
        </div>
        <g:form resource="${this.userAccount}" method="DELETE">
            <div class="three ui fluid buttons">
                <g:link class="ui blue fluid button " action="changePassword" resource="${this.userAccount}">
                    <g:message code="default.button.changePassword.label" /></g:link>
                <sec:access controller="userAccount">
                    <g:link class="ui blue fluid button " action="edit" resource="${this.userAccount}">
                        <g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="ui blue fluid button " type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </sec:access>
            </div>
        </g:form>
    </div>
</body>

</html>
