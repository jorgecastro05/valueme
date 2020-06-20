<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="userAccount" />
    <title>
        <g:message code="${entityName}.list.label" />
    </title>
</head>

<body>
    <a href="#list-userAccount" class="ui hidden message" tabindex="-1">
        <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
    </a>
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
    <!-- buttons -->
    <div class="ui stackable grid">
        <div class="ui column">
            <h3>
                <g:message code="${entityName}.list.label" />
            </h3>
        </div>
    </div>
    <!-- search form -->
    <g:form name="myForm" class="ui form" action="search">
        <div class="fields">
            <div class="field">
                <label>
                    <g:message code="userAccount.email.label" />
                </label>
                <input type="text" name="username" value="${username}">
            </div>
            <div class="field">
                <label>
                    <g:message code="userAccount.fullName.label" />
                </label>
                <input type="text" name="fullName" value="${fullName}">
            </div>
            <div class="field">
                <label>
                    &nbsp;
                </label>
                <button class="ui blue button" type="submit">
                    <g:message code="default.search.label" /></button>
            </div>
            <div class="field">
                <label>
                    &nbsp;
                </label>
                <g:link class="ui blue fluid button " action="create">
                <g:message code="default.new.label" />
            </g:link>
            </div>
        </div>
    </g:form>
    <div id="list-userAccount" class="content scaffold-list" role="main">
        <table class="ui very compact selectable table">
            <thead>
                <tr>
                    <g:sortableColumn property="username" title="${message(code: 'userAccount.username.label')}"
                        params="[userAccount: userAccount, fullName: fullName]" />
                    <g:sortableColumn property="fullName" title="${message(code: 'userAccount.fullName.label')}"
                        params="[userAccount: userAccount, fullName: fullName]" />
                    <g:sortableColumn property="category" title="${message(code: 'userAccount.category.label')}"
                        params="[userAccount: userAccount, fullName: fullName]" />
                    <g:sortableColumn property="enabled" title="${message(code: 'userAccount.enabled.label')}"
                        params="[userAccount: userAccount, fullName: fullName]" />
                    <th colspan="2">
                        <g:message code="default.options.label" />
                    </th>
                </tr>
            </thead>
            <g:each in="${userAccountList}" var="userAccount">
                <tr>
                    <td>
                        <g:link action="show" id="${userAccount.id}">
                            ${userAccount.username}
                        </g:link>
                    </td>
                    <td>
                        ${userAccount.fullName}
                    </td>
                    <td>
                        ${userAccount.category?.name}
                    </td>
                    <td>
                        <g:formatBoolean boolean="${userAccount.enabled}" />
                    </td>
                    <td>
                        <g:link action="edit" id="${userAccount.id}">
                            <g:message code="default.button.edit.label" />
                        </g:link>
                    </td>
                    <td>
                        <div ng-controller="userAccount">
                            <a href="#" ng-click="activate('${userAccount.id}')">
                                <g:message code="userAccount.activate.label" />
                            </a>
                        </div>
                    </td>
                </tr>
            </g:each>
        </table>
        <g:paginate total="${userAccountCount ?: 0}" params="[userAccount: userAccount, fullName: fullName]" />
    </div>
    <g:render template="activate" />
</body>

</html>