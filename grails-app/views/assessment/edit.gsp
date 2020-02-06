<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'assessment.label', default: 'Assessment')}" />
    <title>
        <g:message code="default.edit.label" args="[entityName]" />
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
    <!-- buttons -->
    <div class="ui two buttons">
        <g:link class="ui blue fluid button " action="index">
            <g:message code="default.list.label" args="[entityName]" /></g:link>
        <g:link class="ui blue fluid button " action="create">
            <g:message code="default.new.label" args="[entityName]" /></g:link>
    </div>
    <h3><g:message code="default.edit.label" args="[entityName]" /></h3>
    <!-- form -->
    <div id="edit-assessment" class="content scaffold-edit" role="main">
        <g:form resource="${this.assessment}" method="PUT" class="ui equal width form" role="form">
            <g:hiddenField name="version" value="${this.assessment?.version}" />
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
                                <g:message code="category.label" />
                            </label>
                            ${assessment.userAccount?.category?.category}
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
                                    <input type="text" name="assessment.customFields[${i}].value" value="${assessment.customFields?.getAt(i)?.value?.getAt(0)}">
                                </g:if>
                                <g:if test="${customField.type == 'list'}">
                                    <g:select class="ui search fluid dropdown" name="assessment.customFields[${i}].value" from="${customField.value}" value="${assessment.customFields?.getAt(i)?.value?.getAt(0)}" />
                                </g:if>
                            </div>
                        </g:each>
                    </div>
                </div>
            </div>
            <!-- Questions -->
            <h4 class="ui dividing header"><g:message code="assessment.questions.label"/>
            <g:help message="help.assessment.questions"/>
            </h4>
            <!-- List of questions -->
            <g:set var="i" value="${0}" />
            <g:set var="edit" value="${false}" />
            <div class="field">
                <div class="ui segment">
                    <ol>
                        <g:each in="${valueme.Category.findAllByType('Módulo').sort{it.order}}" var="category">
                            <li style="color: ${category.color};">
                                <h4>${category.type} ${category.category}</h4>
                            </li>
                            <g:render template="stepShow" model="${[category: category]}" />
                        </g:each>
                    </ol>
                </div>
            </div>
            <div class="ui two buttons">
                <g:actionSubmit action="saveTemporarily" class="ui blue fluid button " value="${message(code: 'assessment.saveTemporarily.label')}" />
                <input class="ui blue fluid button " type="submit" value="${message(code: 'assessment.create.label')}" />
            </div>
        </g:form>
    </div>
</body>

</html>
