<div class="ui fitted divider"></div>
<ol>
    <g:each in="${category.childs.sort{it.order}}" var="child">
        <li>
            <div class="category" style="color: ${child.color}">
                ${child.type.name} ${child.name}
            </div>
            <g:each var="question" in="${questions.findAll{it.category == child}}">
                <div class="ui form">
                    <div class="grouped fields">
                        <div class="field">
                            <div class="ui checkbox">
                                <g:checkBox name="survey.questions" value="${question.id}"
                                    checked="${survey.questions?.contains(question)}" readonly="${!edit}" />
                                <label>${question.text}</label>
                            </div>
                        </div>
                    </div>
            </g:each>
            <g:render template="stepQuestions" model="${[category: child, questions: questions]}" />
        </li>
    </g:each>
</ol>