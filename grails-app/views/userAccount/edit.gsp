<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'userAccount.label', default: 'UserAccount')}" />
    <title>
        <g:message code="default.edit.label" args="[entityName]" />
    </title>
</head>

<body>
    <div ng-controller="userAccount">
        <a href="#edit-userAccount" class="ui hidden message" tabindex="-1">
            <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
        </a>
        <!-- messages -->
        <g:if test="${flash.message}">
            <div class="ui positive message">
                <i class="close icon"></i> ${flash.message}
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
        <div class="text-center">
            <div class="ui two buttons">
                <g:link class="ui  button " action="index">
                    <g:message code="default.list.label" args="[entityName]" /></g:link>
                <g:link class="ui  button " action="create">
                    <g:message code="default.new.label" args="[entityName]" /></g:link>
            </div>
        </div>
        <h3 class="text-center"><g:message code="default.edit.label" args="[entityName]" /></h3>
        <!-- form -->
        <div id="edit-userAccount" class="content scaffold-edit" role="main">
            <g:form resource="${this.userAccount}" method="PUT" class="ui form">
                <g:hiddenField name="version" value="${this.userAccount?.version}" />
                <div class="field">
                    <label>
                        <g:message code="userAccount.userAccount.label" />
                    </label>
                    <f:input bean="userAccount" property="username" />
                </div>
                <div class="field">
                    <label>
                        <g:message code="userAccount.fullName.label" />
                    </label>
                    <f:input bean="userAccount" property="fullName" />
                </div>
                <div class="inline field">
                    <label>
                        <g:message code="userAccount.enabled.label" />
                    </label>
                    <div class="ui checkbox">
                        <f:input bean="userAccount" property="enabled" />
                    </div>
                </div>
                <div class="field">
                    <label>
                        <g:message code="category.label" />
                        <div class="selected category">
                            ${userAccount.category?.name}
                        </div>
                    </label>
                    <div class="ui horizontal accordion menu">
                        <g:each in="${categories}" var="category">
                            <div class="item">
                                <div class="title">
                                    <i class="dropdown icon"></i> ${category.name}
                                </div>
                                <div class="content">
                                    <g:render template="step" model="${[category: category]}" />
                                </div>
                            </div>
                        </g:each>
                    </div>
                </div>
                <div class="field">
                    <label>
                        <g:message code="userAccount.roles.label" />
                    </label>
                    <g:select class="ui search dropdown" optionKey="id" optionValue="name" multiple="true" name="selRoles" from="${roles}" value="${userAccount.getAuthorities()}" />
                </div>
                <input class="ui blue fluid button " type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
            </g:form>
        </div>
    </div>
</body>

</html>
