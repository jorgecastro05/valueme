<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
    <title>
        <g:message code="default.show.label" args="[entityName]" />
    </title>
</head>

<body>
    <a href="#show-question" class="ui hidden message" tabindex="-1">
        <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
    </a>
    <!-- messages -->
    <g:if test="${flash.message}">
        <div class="ui positive message">
            <i class="close icon"></i> ${flash.message}
        </div>
    </g:if>
    <!-- buttons -->

        <g:link class="ui blue fluid button " action="index">
            <g:message code="default.list.label" args="[entityName]" /></g:link>
    <h3><g:message code="default.show.label" args="[entityName]" /></h3>
    <!-- form -->
    <div id="show-question" class="content scaffold-show" role="main">
        <div class="ui list celled">
            <div class="item">
                <div class="header">
                    <g:message code="question.label" />
                </div>
                ${question.question}
            </div>
            <div class="item">
                <div class="header">
                    <g:message code="question.active.label" />
                </div>
                <g:formatBoolean boolean="${question.active}" />
            </div>

            <div class="item">
                <div class="header">
                    <g:message code="question.id.label" />
                </div>
                ${question.id}
            </div>

            <div class="item">
                <div class="header">
                    <g:message code="question.surveys" />
                </div>
                 ${valueme.Survey.findAll(question: question.id ,{questions}).category.category}
            </div>

            <div class="item">
                <div class="header">
                    <g:message code="question.category.label" />
                </div>
                <ol lass="ui list">
                <g:set var="edit" value="${true}" />
                    <g:each in="${valueme.Category.findAllByType(valueme.Param.findByName('question.categoryType')?.value)}" var="category">
                        <li>
                            <div class="category" style="color: ${category.color};">
                                ${category.type} ${category.category}
                            </div>
                            <g:render template="step" model="${[category: category]}" />
                        </li>
                    </g:each>
                </ol>
            </div>
        </div>
        <g:form resource="${this.question}" method="DELETE">
            <div class="ui two buttons">
                <g:link class="ui blue fluid button " action="edit" resource="${this.question}">
                    <g:message code="default.button.edit.label" default="Edit" /></g:link>
                <input class="ui blue fluid button " type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
            </div>
        </g:form>
    </div>
</body>

</html>
