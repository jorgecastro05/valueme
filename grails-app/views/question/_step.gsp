<ol>
    <g:each in="${category.childs}" var="child">
        <li>
            <div class="ui radio checkbox">
                <g:radio name="category" value="${child.id}" checked="${question.category == child}" readonly="${!edit}" />
                <label class="category" for="child.name">${child.type.name} ${child.name}</label>
            </div>
        </li>
        <g:render template="step" model="${[category: child]}" />
    </g:each>
</ol>
