<div class="grouped fields">
    <g:each in="${category.childs}" var="child">
        <div class="ui radio checkbox">
            <g:radio name="name" text="${child.name}" value="${child.id}" checked="${userAccount.category == child}" readonly="${edit}" />
            <label for="child.name">${child.name}</label>
        </div>
        <g:render template="step" model="${[category: child]}" />
    </g:each>
</div>
