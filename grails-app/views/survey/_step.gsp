<ol>
    <g:each in="${category.childs.sort{it.order}}" var="child">
        <li>
            <div class="ui radio checkbox">
                <g:radio name="category" value="${child.id}" checked="${question.category == child}" readonly="${edit}" />
                <label class="category" style="color: ${category.color};" for="child.category">${child.type} ${child.category}</label>
            </div>
        </li>
        <g:render template="step" model="${[category: child]}" />
    </g:each>
</ol>
