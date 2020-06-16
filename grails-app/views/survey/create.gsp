<!DOCTYPE html>
<html>

    <head>
        <meta name="layout" content="main"/>
        <g:set var="entityName" value="${message(code: 'survey.label', default: 'Survey')}"/>
        <title>
            <g:message code="default.create.label" args="[entityName]"/>
        </title>
    </head>

    <body>
        <a href="#edit-survey" class="ui hidden message" tabindex="-1">
            <g:message code="default.link.skip.label" default="Skip to content&hellip;"/>
        </a>
        <!-- messages -->
        <g:if test="${flash.message}">
            <div class="ui positive message">
                <i class="close icon"></i>
                ${flash.message}
            </div>
        </g:if>
        <g:hasErrors bean="${this.survey}">
            <div class="ui error message">
                <i class="close icon"></i>
                <g:eachError bean="${this.survey}" var="error"><li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
                <g:message error="${error}"/>
            </li>
        </g:eachError>
    </div>
</g:hasErrors>
<!-- buttons -->
<g:link class="ui blue fluid button " action="index">
    <g:message code="default.list.label" args="[entityName]"/></g:link>
<h3><g:message code="default.create.label" args="[entityName]"/></h3>
<!-- form -->
<div id="create-survey">
    <g:form action="saveFromQuestions" class="ui form" role="form">
        <div class="field">
            <label>
                <g:message code="survey.vigency.label"/>
            </label>
            <div class="ui calendar" id="yearDate">
                <div class="ui input left icon">
                    <i class="calendar icon"></i>
                    <g:field type="text" name="survey.vigency" required="true"/>
                </div>
            </div>
        </div>
        <div class="field">
            <label>
                <g:message code="survey.category.label"/>
            </label>
            <g:select class="ui search dropdown" optionKey="id" optionValue="name" from="${categoryTypes}" name="survey.category"/>
        </div>
        <!-- List of questions -->
        <div class="field" ng-controller="survey">
            <label>
                <g:message code="survey.questions.label"/>
            </label>
            <ol lass="ui list">
                <div class="ui accordion fluid">
                    <g:each in="${categories}" var="category">
                        <div class="item">
                            <div class="title" style="color: ${category.color};">
                                <li class="category">
                                    <i class="dropdown icon"></i>
                                    ${category.type.name} ${category.name}
                                </li>
                            </div>
                            <div class="content">
                                <g:render template="stepQuestions" model="${[category: category, questions: questions]}"/>
                            </div>
                        </div>
                    </g:each>
                </div>
            </ol>
        </div>
        <g:submitButton name="create" class="ui blue fluid button " value="${message(code: 'default.button.create.label', default: 'Create')}"/>
    </g:form>
</div>
</body>

</html>
