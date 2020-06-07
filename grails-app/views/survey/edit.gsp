<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'survey.label', default: 'Survey')}" />
    <title>
        <g:message code="default.edit.label" args="[entityName]" />
    </title>
</head>

<body>
    <a href="#edit-survey" class="ui hidden message" tabindex="-1">
        <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
    </a>
    <!-- messages -->
    <g:if test="${flash.message}">
        <div class="ui positive message">
            <i class="close icon"></i> ${flash.message}
        </div>
    </g:if>
    <g:hasErrors bean="${this.survey}">
        <div class="ui error message">
            <i class="close icon"></i>
            <g:eachError bean="${this.survey}" var="error">
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
    <div id="edit-survey" class="content scaffold-edit" role="main">
        <g:form resource="${this.survey}" method="PUT" class="ui form" role="form">
            <g:hiddenField name="version" value="${this.survey?.version}" />
            <div class="field">
                <label>
                    <g:message code="survey.vigency.label" />
                </label>
                <div class="ui calendar" id="yearDate">
                    <div class="ui input left icon">
                        <i class="calendar icon"></i>
                        <g:field type="text" name="survey.vigency" required="true" value="${survey.vigency}" />
                    </div>
                </div>
            </div>
            <div class="field">
                <label>
                    <g:message code="survey.category.label" />
                </label>
                <g:select class="ui search dropdown" optionKey="id" optionValue="name" from="${categoriesSurveys}" value="${survey.category.id}" name="survey.category" />
            </div>
            <!-- List of questions -->
            <g:set var="edit" value="${true}" />
            <div class="field" ng-controller="survey">
                <label>
                    <g:message code="survey.questions.label" />
                </label>
                <ol lass="ui list">
                    <div class="ui accordion fluid">
                        <g:each in="${categoriesQuestions}" var="category">
                            <div class="item">
                                <div class="title" style="color: ${category.color};">
                                    <li>
                                        <i class="dropdown icon category"></i>
                                        ${category.type.name} ${category.name}
                                    </li>
                                </div>
                                <div class="content">
                                    <g:render template="stepQuestions" model="${[category: category]}" />
                                </div>
                            </div>
                        </g:each>
                    </div>
                </ol>
            </div>
            <input class="ui blue fluid button " type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
        </g:form>
    </div>
</body>

</html>
