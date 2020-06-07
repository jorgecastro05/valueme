<!DOCTYPE html>
<html>

    <head>
        <meta name="layout" content="main"/>
        <g:set var="entityName" value="${message(code: 'survey.label', default: 'Survey')}"/>
        <title>
            <g:message code="default.show.label" args="[entityName]"/>
        </title>
    </head>

    <body>
        <a href="#show-survey" class="ui hidden message" tabindex="-1">
            <g:message code="default.link.skip.label" default="Skip to content&hellip;"/>
        </a>
        <!-- messages -->
        <g:if test="${flash.message}">
            <div class="ui positive message">
                <i class="close icon"></i>
                ${flash.message}
            </div>
        </g:if>
        <!-- buttons -->
        <div class="ui two buttons">
            <g:link class="ui blue fluid button " action="index">
                <g:message code="default.list.label" args="[entityName]"/></g:link>
            <g:link class="ui blue fluid button " action="create">
                <g:message code="default.new.label" args="[entityName]"/></g:link>
        </div>
        <h3><g:message code="default.show.label" args="[entityName]"/></h3>
        <!-- form -->
        <div id="show-survey" class="content scaffold-show" role="main">
            <div class="ui celled list">
                <div class="item">
                    <div class="header">
                        <g:message code="survey.vigency.label"/>
                    </div>
                    ${survey.vigency}
                </div>
                <div class="item">
                    <div class="header">
                        <g:message code="survey.category.label"/>
                    </div>
                    ${survey.category.type.name} ${survey.category.name}
                </div>
                <div class="item">
                    <div class="header">
                        <g:message code="survey.questions.label"/>
                    </div>
                    <!-- List of questions -->
                    <g:set var="edit" value="${false}"/>
                    <ol lass="ui list">
                        <g:each in="${categories}" var="category">
                            <li class="category" style="color: ${category.color};">
                                ${category.type.name} ${category.name}
                            </li>
                            <g:render template="stepQuestions" model="${[category: category]}"/>
                        </g:each>
                    </ol>
                </div>
                <g:form resource="${this.survey}" method="DELETE">
                    <div class="ui two buttons">
                        <g:link class="ui blue fluid button " action="edit" resource="${this.survey}">
                            <g:message code="default.button.edit.label" default="Edit"/></g:link>
                        <input class="ui blue fluid button " type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                    </div>
                </g:form>

            </div>
            <div class="ui blue fluid button" id="print-survey">Imprimir</div>
        </body>

    </html>
