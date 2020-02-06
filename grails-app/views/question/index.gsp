<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="question" />
    <title>
        <g:message code="${entityName}.list.label" />
    </title>
</head>

<body>
    <a href="#list-question" class="ui hidden message" tabindex="-1">
        <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
    </a>
    <g:if test="${flash.message}">
        <div class="ui positive message">
            <i class="close icon"></i> ${flash.message}
        </div>
    </g:if>
    <!-- buttons -->
    <div class="ui stackable grid">
        <div class="twelve wide column">
            <h3><g:message code="${entityName}.list.label"/></h3>
        </div>
        <div class="ui hidden divider"></div>
    </div>
    <!-- search form -->
    <g:form name="myForm" class="ui form" action="search">
        <div class="three fields">
            <div class="field">
                <label>
                    <g:message code="question.question.label" />
                </label>
                <input type="text" name="question" value="${question}">
            </div>
            <div class="field">
              <label>
                  &nbsp;
              </label>
                <button class="ui blue button" type="submit"><g:message code="default.search.label" /></button>
            </div>
        </div>
    </g:form>
    <div id="list-question" class="content scaffold-list" role="main">
        <table class="ui compactselectable table">
            <thead>
                <tr>
                    <g:sortableColumn class="eleven wide" property="question" title="${message(code: 'question.question.label')}" />
                    <th>
                        <g:message class="one wide" code="question.active.label" />
                    </th>
                    <th>
                        <g:message class="three wide" code="question.category.label" />
                    </th>
                    <th>
                        <g:message class="one wide" code="default.options.label" />
                    </th>
                </tr>
            </thead>
            <g:each in="${questionList}" var="question">
                <tr>
                    <td>
                        <g:link action="show" id="${question.id}">
                            ${question.question}
                        </g:link>
                    </td>
                    <td>
                        <g:formatBoolean boolean="${question.active}" />
                    </td>
                    <td>
                        ${question.category.category}
                    </td>
                    <td>
                        <g:link action="edit" id="${question.id}">
                            <g:message code="default.button.edit.label" />
                        </g:link>
                    </td>
                </tr>
            </g:each>
        </table>
        <g:paginate total="${questionCount ?: 0}" params="[question: question]" />
    </div>
</body>

</html>
