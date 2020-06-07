<div class="ui fitted divider"></div>
<ol>
    <g:each in="${category.childs.sort{it.order}}" var="child">
        <li>
            <div class="category" style="color: ${child.color}">
                ${child.type.name} ${child.name}
            </div>

            <g:if test="${edit == true}">
                  <g:set var="questions" value="${valueme.Question.findAllByCategory(child)}" />
            </g:if>
            <g:else>
                <g:set var="questions" value="${survey.questions.findAll{it?.category?.id == child.id}}" />
            </g:else>

            <g:each var="question" in="${questions}" <div class="ui form">
                <div class="grouped fields">
                    <div class="field">
                        <div class="ui checkbox">
                            <g:checkBox name="survey.questions" value="${question.id}" checked="${survey.questions?.id?.contains(question.id)}" readonly="${!edit}" />
                            <label>${question.text}</label>
                        </div>
                    </div>
                </div>
            </g:each>
            <g:render template="stepQuestions" model="${[category: child]}" />
        </li>
    </g:each>
</ol>
