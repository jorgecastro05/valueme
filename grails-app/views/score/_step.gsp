<ol>
    <g:each in="${category.childs.sort{it.order}}" var="child">
        <li>
            <div class="category" style="color: ${child.color}">
                ${child.type.name} ${child.name}
            </div>
            <g:set var="question" value="${questions.findAll{it.key?.category?.id == child.id}}"/>
            <g:if test="${question}">
                <table class="ui very compact unstackable table">
                    <tr>
                        <th>
                            Pregunta
                        </th>
                        <th class="right aligned">
                            Valoración
                        </th>
                    </tr>
                    <g:each var="q" in="${question}">
                        <tr>
                            <td>
                                ${q.key.text}
                            </td>
                            <td class="right aligned">
                                <g:criteria value="${q.value}"/>
                            </td>
                        </tr>
                    </g:each>
                </table>
            </g:if>
            <g:render template="step" model="${[category: child]}"/>
        </li>
    </g:each>
</ol>
