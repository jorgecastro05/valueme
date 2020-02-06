<div class="ui simple dropdown item">
    <g:message code="score.label"/>
    <div class="menu">
        <g:link class="item" controller="score" action="getScore">
            <g:message code="score.total.label"/>
        </g:link>
        <g:link class="item" controller="score" action="compareScore">
            <g:message code="score.compare.label"/>
        </g:link>
        <sec:access controller='score' action="individualScore">
            <g:link class="item" controller='score' action="individualScore">
                <g:message code="score.individual.label"/>
            </g:link>
        </sec:access>
        <sec:access controller='score' action="scoreFiltered">
            <g:link class="item" controller='score' action="scoreFiltered">
                <g:message code="score.scoreFiltered.label"/>
            </g:link>
        </sec:access>
    </div>
</div>
