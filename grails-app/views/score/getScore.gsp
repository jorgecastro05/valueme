<%@page expressionCodec="none" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta name="layout" content="main" />
        <title>
            <g:message code="score.total.label" />
        </title>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
        var scoreData = ${scoreData.encodeAsJSON()};
        var categoryType = "${categoryType}";
        </script>
    </head>

    <body>
    <h3 class="text-center"><g:message code="score.total.label" /></h3>
    <g:helpLink page="score"/>
        <div class="ui segments">
            <div class="ui stackable equal width grid segment">
                <div class="column">
                 <h3>Encuestas realizadas ${assesments}</h3>
                </div>
                <div class="column">
                 <h3>Preguntas Evaluadas ${questions?.size()}</h3>
                </div>
            </div>
            <div class=" ui segment">
                <g:form class="ui form" action="getScore">
                    <div class="field">
                        <label>
                            <g:message code="score.group.label" />
                            <g:help message="help.score.calculate" />
                        </label>
                        <g:select class="ui search fluid dropdown" name="categoryType" from='${categoryTypes}' optionKey="name" optionValue="name"></g:select>
                    </div>
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
                    <button class="ui blue fluid button" type="submit">
                        <g:message code="score.getResults.label" />
                    </button>
                </g:form>
                <h4 class="ui horizontal divider header">
                <i class="bar chart icon"></i>
                    Resultados Consolidados
            </h4>
                <g:if test="${scoreData}">
                    <div id="chart_total"></div>
                    <b>Escala de valoración:</b> <i> Bajo: 1.0 a 3.0, Medio: 3.1 - 4.0, Alto: 4.1 - 5.0 </i>
                </g:if>
            </div>
            <div class="ui segment">
              <h4 class="ui horizontal divider header">
                  Resultado por pregunta
             </h4>
                  <ol>
                      <g:each in="${categories}" var="category">
                          <li class="category" style="color: ${category.color};">
                              ${category.type} ${category.name}
                          </li>
                          <g:render template="step" model="${[category: category]}"/>
                      </g:each>
                  </ol>
              </div>
            </div>
        </div>
        </div>
    </body>
</html>
