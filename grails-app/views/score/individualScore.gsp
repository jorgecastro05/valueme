<%@page expressionCodec="none" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta name="layout" content="main" />
        <title>
            <g:message code="score.individual.label" />
        </title>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
        var scoreData = ${scoreData.encodeAsJSON()};
        var categoryType = "${categoryType}";
        </script>
    </head>

    <body>
    <h3 class="text-center"><g:message code="score.individual.label" /></h3>
            <div class=" ui segment">
                <g:form class="ui form" action="individualScore">
                    <div class="field">
                        <label>
                            <g:message code="score.group.label" />
                            <g:help message="help.score.calculate" />
                        </label>
                        <g:select class="ui search fluid dropdown" name="categoryType" from='${['Módulo','Componente','Elemento']}' value="${categoryType}"></g:select>
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
                     <div class="field">
                    <label>
                        <g:message code="userAccount.label" />
                    </label>
                    <g:select class="ui search dropdown" optionKey="id" optionValue="${{it.userAccount + (it.category ? ' - '+it.category.category : '')}}" from="${valueme.UserAccount.findAllByActive(true)}" value="${userAccount}" name="userAccount" />
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
              <div class="ui segment">
                <h4 class="ui horizontal divider header">
                    Resultado por pregunta
               </h4>
                    <ol>
                        <g:each in="${valueme.Category.findAllByType(valueme.Param.findByName('question.categoryType')?.value)}" var="category">
                            <li class="category" style="color: ${category.color};">
                                ${category.type} ${category.category}
                            </li>
                            <g:render template="step" model="${[category: category]}"/>
                        </g:each>
                    </ol>
                </div>
            </div>
        </div>
    </body>

    </html>
