<div class="ui simple dropdown item">
    <g:message code="score.label"/>
    <div class="menu">
        <g:link class="item" controller="score" action="indexScore">
            <g:message code="score.total.label"/>
        </g:link>
        <g:link class="item" controller="score" action="indexCompareScore">
            <g:message code="score.compare.label"/>
        </g:link>
        <sec:access controller='score' action="indexIndividualScore">
            <g:link class="item" controller='score' action="indexIndividualScore">
                <g:message code="score.individual.label"/>
            </g:link>
        </sec:access>
    </div>
</div>
