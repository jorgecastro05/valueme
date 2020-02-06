<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'assessment.label', default: 'Assessment')}" />
    <title>
        <g:message code="default.list.label" args="[entityName]" />
    </title>
</head>

<body>
    <a href="#list-assessment" class="ui hidden message" tabindex="-1">
        <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
    </a>
    <g:if test="${flash.message}">
        <div class="ui positive message">
            <i class="close icon"></i> ${flash.message}
        </div>
    </g:if>
    <g:if test="${flash.error}">
        <div class="ui error message">
            <i class="close icon"></i> ${flash.error}
        </div>
    </g:if>
    <!-- search form -->
    <g:form name="myForm" class="ui form" action="search">
        <div class="two fields">
            <div class="field">
                <label>
                    <g:message code="assessment.vigency.label" />
                </label>
                <div class="ui calendar" id="yearDate">
                    <div class="ui input left icon">
                        <i class="calendar icon"></i>
                        <g:field type="text" name="vigency" value="${vigency}" required="true" />
                    </div>
                </div>
            </div>
            <div class="field">
                <label>
                    <g:message code="assessment.category.label" />
                </label>
                <g:select class="ui dropdown" name="category" from="${categories}" optionKey="id" optionValue="category" noSelection="${['':'Todas']}" value="${category?.id}"/>
            </div>
            <div class="field">
              <label>
                  &nbsp;
              </label>
                <button class="ui blue button" type="submit"><g:message code="default.search.label" /></button>
            </div>
        </div>
    </g:form>
    <div id="list-assessment" class="content scaffold-list" role="main">
        <table class="ui compact selectable table">
            <thead>
                <tr>
                    <g:sortableColumn property="userAccount" title="${message(code: 'userAccount.userAccount.label')}"  params="[vigency: vigency, category: category?.id]"/>
                    <g:sortableColumn property="category" title="${message(code: 'process.label')}" params="[vigency: vigency, category: category?.id]"  />
                    <g:sortableColumn property="vigency" title="${message(code: 'survey.vigency.label')}" params="[vigency: vigency, category: category?.id]"  />
                    <g:sortableColumn property="finished" title="${message(code: 'assessment.finished.label')}"  params="[vigency: vigency, category: category?.id]" />
                    <th>
                        <g:message code="default.options.label" />
                    </th>
                </tr>
            </thead>
            <g:each in="${assessmentList}" var="assessment">
                <tr>
                    <td>
                        <g:link action="show" id="${assessment.id}">
                            ${assessment.userAccount.userAccount}
                        </g:link>
                    </td>
                    <td>
                        ${assessment.category.category}
                    </td>
                    <td>
                        ${assessment.vigency}
                    </td>
                    <td>
                        <g:formatBoolean boolean="${assessment.finished}" />
                    </td>
                    <g:if test="${!assessment.finished}">
                        <td>
                            <g:link action="edit" id="${assessment.id}">
                                <g:message code="assessment.continue.label" />
                            </g:link>
                        </td>
                    </g:if>
                    <g:else>
                        <td></td>
                    </g:else>
                </tr>
            </g:each>
        </table>
        <div class="pagination">
            <g:paginate total="${assessmentCount ?: 0}" params="[vigency: vigency, category: category?.id]" />
        </div>
    </div>
</body>

</html>
