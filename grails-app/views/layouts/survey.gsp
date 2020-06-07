<div class="ui simple dropdown item">
    <g:message code="evaluation.label"/>
    <div class="menu">
        <sec:access controller='survey'>
            <g:link class="item" controller='survey'>
                <g:message code="MakeSurvey.label"/>
            </g:link>
        </sec:access>
        <sec:access controller='assessment'>
            <g:link class="item" controller='assessment'>
                <g:message code="makeAssessment.label"/>
            </g:link>
        </sec:access>
    </div>
</div>
