<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'userAccount.label', default: 'UserAccount')}" />
    <title>
        <g:message code="default.create.label" args="[entityName]" />
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
        <g:link class="ui blue button " action="index">
            <g:message code="default.list.label" args="[entityName]" /></g:link>
        <h3><g:message code="default.create.label" args="[entityName]" /></h3>
        <!-- form -->
        <div id="create-userAccount">
            <g:form action="save" class="ui form">
                <div class="field">
                    <label>
                        <g:message code="userAccount.fullName.label" />
                    </label>
                    <f:input bean="userAccount" property="fullName" />
                </div>
                <div class="field">
                    <label>
                        <g:message code="userAccount.userAccount.label" />
                    </label>
                    <f:input bean="userAccount" property="userAccount" />
                </div>
                <div class="field">
                    <label>
                        <g:message code="userAccount.passwordHash.label" />
                        <g:help message="help.userAccount.password" />
                    </label>
                    <f:input bean="userAccount" property="passwordHash" />
                </div>
                <div class="inline field">
                    <label>
                        <g:message code="userAccount.active.label" />
                    </label>
                    <div class="ui checkbox">
                        <f:input bean="userAccount" property="active" />
                    </div>
                </div>
                <div class="field">
                    <label>
                        <g:message code="userAccount.vigencyStart.label" />
                    </label>
                    <div class="ui calendar" id="yearDate">
                        <div class="ui input left icon">
                            <i class="calendar icon"></i>
                            <g:field name="vigencyStart" value="${currentYear()}" />
                        </div>
                    </div>
                </div>
                <div class="field">
                    <label>
                        <g:message code="category.label" />
                        <div class="selected category"></div>
                    </label>
                    <div class="ui horizontal accordion menu">
                        <g:each in="${valueme.Category.findAllByTypeAndParentIsNull(valueme.Param.findByName('survey.categoryType')?.value)}" var="category">
                            <div class="item">
                                <div class="title">
                                    <i class="dropdown icon"></i> ${category.category}
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
                    <g:select class="ui search dropdown" optionKey="role" optionValue="role" multiple="true" name="selRoles" from="${roles}" value="${userAccount.roles}" />
                </div>
                <g:submitButton name="create" class="ui blue fluid button " value="${message(code: 'default.button.create.label', default: 'Create')}" />
            </g:form>
        </div>
    </div>
</body>

</html>
