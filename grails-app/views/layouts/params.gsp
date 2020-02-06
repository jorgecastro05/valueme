<div class="ui simple dropdown item">
    <g:message code="evalParameters.label"/>
    <div class="menu">
        <sec:access controller='category'>
            <g:link class="item" controller='category' params="[categoryType:'survey']">
                ${valueme.Param.findByName('survey.categoryType')?.label}
            </g:link>
        </sec:access>
        <sec:access controller='category'>
            <g:link class="item" controller='category' params="[categoryType:'question']">
                <g:message code="category.questions.label"/>
            </g:link>
        </sec:access>
        <sec:access controller='categoryType'>
            <g:link class="item" controller='categoryType'>
                <g:message code="categoryType.list.label"/>
            </g:link>
        </sec:access>
        <sec:access controller='question'>
            <g:link class="item" controller='question'>
                <g:message code="question.list.label"/>
            </g:link>
        </sec:access>
        <sec:access controller='customField'>
            <g:link class="item" controller='customField'>
                <g:message code="customField.list.label"/>
            </g:link>
        </sec:access>
        <sec:access controller='param'>
            <g:link class="item" controller='param'>
                <g:message code="param.list.label"/>
            </g:link>
        </sec:access>
        <sec:access controller='appInfo'>
            <g:link class="item" controller='appInfo'>
                <g:message code="about.label"/>
            </g:link>
        </sec:access>
    </div>
</div>
