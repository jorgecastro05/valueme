<div class="grouped fields">
    <g:each in="${category.childs}" var="child">
        <div class="ui radio checkbox">
            <g:radio name="category" text="${child.category}" value="${child.id}" checked="${userAccount.category == child}" readonly="${edit}" />
            <label for="child.category">${child.category}</label>
        </div>
        <g:render template="step" model="${[category: child]}" />
    </g:each>
</div>
