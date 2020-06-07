<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'assessment.label', default: 'Assessment')}" />
    <title>
        <g:message code="default.show.label" args="[entityName]" />
    </title>
</head>

<body>
    <a href="#show-assessment" class="ui hidden message" tabindex="-1">
        <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
    </a>
    <!-- messages -->
    <g:if test="${flash.message}">
        <div class="ui positive message">
            <i class="close icon"></i> ${flash.message}
        </div>
    </g:if>
    <!-- buttons -->
    <sec:access controller="assessment" action="delete">
        <div class="ui two buttons">
            <g:link class="ui blue fluid button " action="index">
                <g:message code="default.list.label" args="[entityName]" /></g:link>
            <g:link class="ui blue fluid button " action="create">
                <g:message code="default.new.label" args="[entityName]" /></g:link>
        </div>
    </sec:access>
    <h3><g:message code="default.show.label" args="[entityName]" /></h3>
    <!-- form -->
    <div id="show-assessment" class="ui equal width form" role="main">
        <!-- show assessment -->
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
                        ${assessment.category?.category}
                    </div>
                </div>
                <!-- custom fields -->
                <div class="fields">
                    <g:each in="${assessment.customFields}" var="customField">
                        <div class="field">
                            <label>
                                ${customField.name}
                            </label>
                            ${customField.value?.getAt(0)}
                        </div>
                    </g:each>
                </div>
            </div>
        </div>
        <h4 class="ui dividing header"><g:message code="assessment.questions.label"/></h4>
        <!-- Questions -->
        <g:set var="edit" value="${true}" />
        <g:set var="i" value="${0}" />
        <div class="field">
            <label>
                <g:message code="assessment.questions.label" />
                <g:help message="help.assessment.questions" />
            </label>
            <div class="ui segment">
                <ol>
                    <g:each in="${valueme.Category.findAllByType('Módulo').sort{it.order}}" var="category">
                        <li style="color: ${category.color};">
                            <h4 class="category">${category.type} ${category.category}</h4>
                        </li>
                        <g:render template="stepShow" model="${[category: category]}" />
                    </g:each>
                </ol>
            </div>
        </div>
        <sec:access controller="assessment" action="delete">
            <g:form resource="${this.assessment}" method="DELETE">
                <div class="ui two buttons">
                    <g:link class="ui blue fluid button " action="edit" resource="${this.assessment}">
                        <g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="ui blue fluid button " type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </div>
            </g:form>
        </sec:access>
    </div>
</body>

</html>
