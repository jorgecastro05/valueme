<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
    <title>
        <g:message code="default.edit.label" args="[entityName]" />
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

    <h3><g:message code="default.edit.label" args="[entityName]" /></h3>
    <!-- form -->
    <div id="edit-question" class="content scaffold-edit" role="main">
        <g:form resource="${this.question}" method="PUT" class="ui form" role="form">
            <g:hiddenField name="version" value="${this.question?.version}" />
            <div class="field">
                <label>
                    <g:message code="question.question.label" />
                </label>
                <f:input bean="question" property="text" />
            </div>
            <div class="inline field">
                <label>
                    <g:message code="question.active.label" />
                </label>
                <div class="ui checkbox">
                    <f:input bean="question" property="active" />
                </div>
            </div>
            <div class="field">
                <label>
                    <g:message code="question.category.label" />
                </label>
                <ol lass="ui list">
                <g:set var="edit" value="${true}" />
                    <g:each var="category" in="${categories}">
                        <li>
                            <div class="category" style="color: ${category.color};">
                                ${category.type.name} ${category.name}
                            </div>
                            <g:render template="step" model="${[category: category]}" />
                        </li>
                    </g:each>
                </ol>
            </div>
            <input class="ui blue fluid button " type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
        </g:form>
</body>

</html>
