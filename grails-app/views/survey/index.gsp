<!DOCTYPE html>
<html>

    <head>
        <meta name="layout" content="main"/>
        <g:set var="entityName" value="survey"/>
        <title>
            <g:message code="${entityName}.list.label"/>
        </title>
    </head>

    <body>
        <a href="#list-survey" class="ui hidden message" tabindex="-1">
            <g:message code="default.link.skip.label" default="Skip to content&hellip;"/>
        </a>
        <g:if test="${flash.message}">
            <div class="ui positive message">
                <i class="close icon"></i>
                ${flash.message}
            </div>
        </g:if>
        <!-- buttons -->
        <div class="ui stackable grid">
            <div class="seven wide column">
                <h3><g:message code="${entityName}.list.label"/></h3>
            </div>
            <div class="four wide column">
                <g:link class="fluid ui blue fluid button " action="create">
                    <g:message code="default.new.label"/>
                </g:link>
            </div>
            <div class="five wide column">
                <g:link class="fluid ui blue fluid button " action="createFromQuestions">
                    <g:message code="default.newFromQuestions.label"/>
                </g:link>
            </div>
        </div>
        <g:helpLink page="assessment"/>
        <p>
          <!-- search form -->
          <g:form name="myForm" class="ui form" action="search">
              <div class="two fields">
                  <div class="field">
                      <label>
                          <g:message code="survey.vigency.label" />
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
                        &nbsp;
                    </label>
                      <button class="ui blue button" type="submit"><g:message code="default.search.label" /></button>
                  </div>
              </div>
          </g:form>
            <div id="list-survey" class="content scaffold-list" role="main">
                <table class="ui compact selectable table">
                    <thead>
                        <tr>
                            <g:sortableColumn property="category.parent.category" title="${message(code: 'process.type.label')}" params="[vigency: vigency]"/>
                            <g:sortableColumn property="category" title="${message(code: 'process.label')}" params="[vigency: vigency]"/>
                            <g:sortableColumn property="vigency" title="${message(code: 'survey.vigency.label')}" params="[vigency: vigency]"/>
                            <th>
                                <g:message code="default.options.label"/>
                            </th>
                        </tr>
                    </thead>
                    <g:each in="${surveyList}" var="survey">
                        <tr>
                            <td>
                                ${survey.category.parent.category}
                            </td>
                            <td>
                                <g:link action="show" id="${survey.id}">
                                    ${survey.category.category}
                                </g:link>
                            </td>
                            <td>
                                ${survey.vigency}
                            </td>
                            <td>
                                <g:link action="edit" id="${survey.id}">
                                    <g:message code="default.button.edit.label"/>
                                </g:link>
                            </td>
                        </tr>
                    </g:each>
                </table>
                <g:paginate total="${surveyCount ?: 0}" params="[vigency: vigency]" />
            </div>
            <br>
                <button class="ui blue fluid button copySurveyVigency">
                    <g:message code="survey.copySurveyVigency.label"/>
                </button>
            </div>
            <g:render template="copySurveyVigency"/>
        </body>

    </html>
