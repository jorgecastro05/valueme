<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'survey.label', default: 'Survey')}" />
    <title>
        <g:message code="default.create.label" args="[entityName]" />
    </title>
</head>

<body>
    <a href="#edit-question" class="ui hidden message" tabindex="-1">
        <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
    </a>
    <!-- messages -->
    <g:if test="${flash.message}">
        <div class="ui positive message">
            <i class="close icon"></i> ${flash.message}
        </div>
    </g:if>
    <g:hasErrors bean="${this.question}">
        <div class="ui error message">
            <i class="close icon"></i>
            <g:eachError bean="${this.question}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <g:message error="${error}" />
                </li>
            </g:eachError>
        </div>
    </g:hasErrors>
    <!-- buttons -->
    <g:link class="ui blue fluid button " action="index">
        <g:message code="default.list.label" args="[entityName]" /></g:link>
    <h3><g:message code="default.create.label" args="[entityName]" /></h3>
    <!-- form -->
    <div id="create-question">
        <g:form action="save" class="ui form" role="form">
            <div class="field">
                <label>
                    <g:message code="survey.categories.label" />
                    <div class="selected category"></div>
                </label>
                <div class="ui horizontal accordion menu">
                    <g:each in="${valueme.Category.findAllByTypeAndParentIsNull(valueme.Param.findByName('survey.categoryType')?.value)}" var="category">
                        <div class="item">
                            <div class="active title">
                                <i class="dropdown icon"></i> ${category.category}
                            </div>
                            <div class="active content">
                                <g:render template="category" model="${[category: category]}" />
                            </div>
                        </div>
                    </g:each>
                </div>
            </div>
            <div class="field">
                <label>
                    <g:message code="question.question.label" />
                </label>
                 <f:input bean="question" property="question" />
            </div>
            <div class="inline field">
                <label>
                    <g:message code="question.active.label" />
                </label>
                <div class="ui checkbox">
                    <f:input bean="question" property="active" value="${true}" />
                </div>
            </div>
            <div class="field">
                <label>
                    <g:message code="survey.vigency.label" />
                </label>
                <div class="ui calendar" id="yearDate">
                    <div class="ui input left icon">
                        <i class="calendar icon"></i>
                        <g:field name="vigency" value="${currentYear()}" />
                    </div>
                </div>
            </div>
            <div class="field">
                <label>
                    <g:message code="question.category.label" />
                </label>
                <ol lass="ui list">
                    <g:each in="${valueme.Category.findAllByType(valueme.Param.findByName('question.categoryType')?.value)}" var="category">
                        <li>
                            <div  class="category" style="color: ${category.color};">
                                ${category.type} ${category.category}
                            </div>
                            <g:render template="step" model="${[category: category]}" />
                        </li>
                    </g:each>
                </ol>
            </div>
            <g:submitButton name="create" class="ui blue fluid button " value="${message(code: 'default.button.create.label', default: 'Create')}" />
        </g:form>
    </div>
</body>

</html>
