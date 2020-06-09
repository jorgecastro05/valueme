<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'assessment.label', default: 'Assessment')}" />
    <title>
        <g:message code="assessment.create.label" args="[entityName]" />
    </title>
</head>

<body>
    <a href="#edit-assessment" class="ui hidden message" tabindex="-1">
        <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
    </a>
    <!-- messages -->
    <g:if test="${flash.message}">
        <div class="ui positive message">
            <i class="close icon"></i> ${flash.message}
        </div>
    </g:if>
    <g:hasErrors bean="${this.assessment}">
        <div class="ui error message">
            <i class="close icon"></i>
            <g:eachError bean="${this.assessment}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
                    <g:message error="${error}" />
                </li>
            </g:eachError>
        </div>
    </g:hasErrors>
    <g:if test="${flash.error}">
        <div class="ui error message">
            <i class="close icon"></i> ${flash.error}
        </div>
    </g:if>
    <!-- form -->
    <div id="create-assessment">
        <g:form class="ui equal width form" role="form">
            <!-- concrete survey -->
            <!-- read only fields-->
            <g:hiddenField name="assessment.userAccount" value="${assessment.userAccount.id}" />
            <g:hiddenField name="assessment.category" value="${assessment.category.id}" />
            <g:hiddenField name="assessment.survey" value="${assessment.survey.id}" />
            <g:hiddenField name="assessment.vigency" value="${assessment.vigency}" />
            <div class="ui accordion">
                <div class="active title">
                    <h4 class="ui dividing header">
                        <i class="dropdown icon"></i>
                    <g:message code="assessment.generalData.label" /></h4>
                </div>
                <div class="active content">
                    <div class="fields">
                        <div class="inline field">
                            <label>
                                <g:message code="assessment.responsible.label" />
                            </label>
                            ${assessment.userAccount?.fullName}
                        </div>
                        <div class="inline field">
                            <label>
                                ${assessment.category?.type.name}:
                            </label>
                            ${assessment.category?.name}
                        </div>
                        <div class="inline field">
                            <label>
                                <g:message code="assessment.vigency.label" />
                            </label>
                            ${assessment.vigency}
                        </div>
                    </div>
                    <!-- custom fields -->
                    <div class="fields">
                        <g:each in="${valueme.CustomField.findAllBySection('header')}" var="customField" status="i">
                            <div class="field">
                                <label>
                                    ${customField.name}
                                    <g:hiddenField name="assessment.customFields[${i}].name" value="${customField.name}" />
                                </label>
                                <g:if test="${customField.type == 'text'}">
                                    <g:field type="text" name="assessment.customFields[${i}].value" value='${assessment.customFields?.getAt(i)?.value?.getAt(0)}'/>
                                </g:if>
                                <g:if test="${customField.type == 'list'}">
                                    <g:select class="ui search fluid dropdown" name="assessment.customFields[${i}].value" from="${customField.value}" value='${assessment.customFields?.getAt(i)?.value?.getAt(0)}'/>
                                </g:if>
                            </div>
                        </g:each>
                    </div>
                </div>
            </div>
            <!-- Questions -->
            <g:set var="i" value="${0}" />
            <g:set var="edit" value="${false}" />
            <div class="field" ng-controller="assessment">
                <label>
                    <g:message code="assessment.questions.label" />
                </label>
                <div class="ui segment questions">
                    <ol>
                        <g:each in="${categories.sort{it.order}}" var="category">
                            <li style="color: ${category.color};">
                                <h4 class="category">${category.type.name} ${category.name}</h4>
                            </li>
                            <g:render template="step" model="${[category: category]}" />
                        </g:each>
                    </ol>
                </div>
            </div>
            <div class="ui two buttons">
                <g:actionSubmit action="save" class="ui blue fluid button help" value="${message(code: 'assessment.create.label')}" data-content="${message(code: 'help.assessment.create')}" />
            </div>
        </g:form>
    </div>
</body>

</html>
