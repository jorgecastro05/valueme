<div class="grouped fields">
    <g:each in="${category.childs}" var="child">
        <g:if test="${child != null}">
            <div class="ui radio checkbox">
                <g:radio name="category" text="${child?.name}" value="${child?.id}" checked="${userAccount.category == child}" />
                <label for="child.name">${child?.name}</label>
            </div>
            <g:render template="step" model="${[category: child]}" />
        </g:if>
    </g:each>
</div>