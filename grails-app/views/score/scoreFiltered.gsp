<%@page expressionCodec="none" %>
<!DOCTYPE html>
<html>

    <head>
        <meta name="layout" content="main"/>
        <title>
            <g:message code="score.compare.label"/>
        </title>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
        var scoreData = ${scoreData.encodeAsJSON()};
        var categoryType = "${categoryName}";
        </script>
    </head>

    <body>
        <h3 class="text-center"><g:message code="score.scoreFiltered.label"/></h3>
        <g:form class="ui form" action="scoreFiltered">
            <div class="field">
                <label>
                    <g:message code="survey.vigency.label"/>
                </label>
                <div class="ui calendar" id="yearDate">
                    <div class="ui input left icon">
                        <i class="calendar icon"></i>
                        <g:field type="text" name="vigency" value="${vigency}" required="true"/>
                    </div>
                </div>
            </div>
            <div class="field">
                <label>
                    <g:message code="score.category.label"/>
                </label>
                <g:select class="ui search dropdown" optionKey="id" 
                optionValue="${{it.type + " - " + it.category}}" from="${valueme.Category.findAllByTypeInList(['Módulo','Componente'], [sort: "type", order: "desc"])}" value="${category}" name="category"/>
            </div>
            <div class=" ui segment">
                <h4 class="ui horizontal divider header">
                    <i class="bar chart icon"></i>Resultados Consolidados</h4>
                <g:if test="${scoreData}">
                    <div id="chart_total"></div>
                    <b>Escala de valoración:</b> <i> Bajo: 1.0 a 3.0, Medio: 3.1 - 4.0, Alto: 4.1 - 5.0 </i>
                </g:if>
            </div>
            <button class="ui blue fluid button" type="submit">
                <g:message code="score.getResults.label"/>
            </button>
        </g:form>
    </body>

</html>
