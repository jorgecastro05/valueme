<%@page expressionCodec="none" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta name="layout" content="main" />
        <title>
            <g:message code="score.compare.label" />
        </title>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
        var scoreDataA = ${scoreA.encodeAsJSON()};
        var scoreDataB = ${scoreB.encodeAsJSON()};
        var categoryType = "${categoryType}";
        </script>
    </head>

    <body>
    <h3 class="text-center"><g:message code="score.compare.label" /></h3>
            <g:form class="ui form" action="compareScore">
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
                        <g:message code="score.group.label" />
                        <g:help message="help.score.calculate" />
                    </label>
                    <g:select class="ui search fluid dropdown" name="categoryType" from='${['Módulo','Componente','Elemento']}' value="${categoryType}"></g:select>
                </div>
                 <div class=" ui segment">
                <div class="field">
                    <label>
                        <g:message code="score.category.compareFirst.label" />
                    </label>
                    <g:select class="ui search dropdown" optionKey="id" optionValue="name" from="${categories}" value="${categoryA}" name="categoryA" />
                </div>
                <h4 class="ui horizontal divider header"><i class="bar chart icon"></i>Resultados Consolidados</h4>
                <g:if test="${scoreA}">
                    <div id="chart_a"></div>
                    <b>Escala de valoración:</b> <i> Bajo: 1.0 a 3.0, Medio: 3.1 - 4.0, Alto: 4.1 - 5.0 </i>
                </g:if>
                </div>
                 <div class=" ui segment">
                <div class="field">
                    <label>
                        <g:message code="score.category.compareAll.label" />
                    </label>
                    <g:select class="ui search dropdown" multiple="true" optionKey="id" optionValue="name" from="${categories}" value="${categoryB}" name="categoryB" />
                </div>
                <h4 class="ui horizontal divider header"><i class="bar chart icon"></i>Resultados Consolidados</h4>
                <g:if test="${scoreB}">
                    <div id="chart_b"></div>
                    <b>Escala de valoración:</b> <i> Bajo: 1.0 a 3.0, Medio: 3.1 - 4.0, Alto: 4.1 - 5.0 </i>
                </g:if>
                </div>
                <button class="ui blue fluid button" type="submit">
                    <g:message code="score.getResults.label" />
                </button>
            </g:form>
    </body>

    </html>
