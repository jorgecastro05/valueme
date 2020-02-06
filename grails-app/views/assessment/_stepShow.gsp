<ol>
    <g:each in="${category.childs.sort{it.order}}" var="child">
        <h5>
            <li class="category" style="color: ${child.color}">
                ${child.type} ${child.category}
            </li>
        </h5>
      <p>
        ${child.description}
      </p>
        <g:set var="questions" value="${assessment.answers.question.findAll{it?.category?.id == child.id}.sort{it.order}}"/>
        <g:if test="${questions}">
            <table class="ui very compact celled structured table">
                <thead>
                    <tr>
                        <th rowspan="2" class="center aligned question">
                            <g:message code="answer.question.label"/>
                        </th>
                        <th colspan="6" class="center aligned">
                            <g:message code="answer.valueScale.label"/>
                        </th>
                        <th rowspan="2"></th>
                    </tr>
                    <tr>
                        <g:each in="${0..5}">
                            <th class="small text center aligned">
                                <g:message code="answer.scale.${it}.label"/>
                            </th>
                        </g:each>
                    </tr>
                </thead>
                <tbody>
                    <g:each var="question" in="${questions}">
                        <tr>
                            <td class="justified aligned">
                                ${question.question}
                                <g:hiddenField class="questionName" name="assessment.answers[${i}].question" value="${question.id}"/>
                            </td>
                            <g:radioGroup name="assessment.answers[${i}].valueScale" values="${0..5}" labels="${0..5}" value="${assessment.answers?.getAt(i)?.valueScale}" readonly="${edit}">
                                <td class="center aligned radioArea" data-content="${message(code:    'answer.scale.'+ it.label +'.label')}">
                                    <div class="ui radio checkbox">
                                        ${it.radio}
                                    </div>
                                </td>
                            </g:radioGroup>
                            <td>
                                <!--custom fields-->
                                <g:each in="${valueme.CustomField.findAllBySection('content')}" var="customField" status="c">
                                    <label>
                                        ${customField.name}
                                        <g:hiddenField name="assessment.answers[${i}].customFields[${c}].name" value="${customField.name}"/>
                                    </label>
                                    <g:if test="${customField.type == 'text'}">
                                        <g:textField type="text" name="assessment.answers[${i}].customFields[${c}].value" value="${assessment.answers?.getAt(i)?.customFields?.getAt(c)?.value?.getAt(0)}" readonly="${edit}"/>
                                    </g:if>
                                    <g:if test="${customField.type == 'list'}">
                                        <g:select class="ui search fluid dropdown" name="assessment.answers[${i}].customFields[${c}].value" from="${customField.value}" value="${assessment.answers?.getAt(i)?.customFields?.getAt(c)?.value?.getAt(0)}" readonly="${edit}"/>
                                    </g:if>
                                </g:each>
                            </td>
                        </tr>
                        <% i++ %>
                    </g:each>
                </tbody>
            </table>
        </g:if>
        <g:render template="stepShow" model="${[category: child]}"/>
    </g:each>
</ol>
