<ol>
    <g:each in="${category.childs.sort{it.order}}" var="child">
        <h5>
            <li class="category" style="color: ${child.color}">
                ${child.type.name} ${child.name}
            </li>
        </h5>
        <p>
            ${child.description}
        </p>
        <g:set var="questions" value="${assessment.survey.questions.findAll{it?.category?.id == child.id}}" />
        <g:if test="${questions}">
            <div class="ui form">
                <g:each var="question" in="${questions}">
                    <div class="field">
                        <label>${question.text}</label>
                        <g:hiddenField class="questionName" name="assessment.answers[${i}].question"
                            value="${question.id}" />
                        <g:radioGroup name="assessment.answers[${i}].valueScale" values="${0..5}" labels="${0..5}"
                            value="${assessment.answers?.getAt(i)?.valueScale}" readonly="${edit}" required="true">
                            <div class="field">
                                <div class="ui checkbox">
                                    ${it.radio}
                                    <label>${message(code:'answer.scale.'+ it.label +'.label')}</label>
                                </div>
                            </div>
                        </g:radioGroup>
                    </div>
                    <!--custom fields-->
                    <g:each in="${valueme.CustomField.findAllBySection('content')}" var="customField" status="c">
                        <label>
                            ${customField.name}
                            <g:hiddenField name="assessment.answers[${i}].customFields[${c}].name"
                                value="${customField.name}" />
                        </label>
                        <g:if test="${customField.type == 'text'}">
                            <g:field type="text" name="assessment.answers[${i}].customFields[${c}].value"
                                value="${assessment.answers?.getAt(i)?.customFields?.getAt(c)?.value?.getAt(0)}"
                                readonly="${edit}" />
                        </g:if>
                        <g:if test="${customField.type == 'list'}">
                            <g:select class="ui search fluid dropdown"
                                name="assessment.answers[${i}].customFields[${c}].value" from="${customField.value}"
                                value="${assessment.answers?.getAt(i)?.customFields?.getAt(c)?.value?.getAt(0)}"
                                readonly="${edit}" />
                        </g:if>
                    </g:each>
                    <% i++ %>
                </g:each>

            </div>
        </g:if>
        <g:render template="step" model="${[category: child]}" />
    </g:each>
</ol>