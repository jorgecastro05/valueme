<div class="grouped fields">
    <g:each in="${category.childs.sort{it.order}}" var="child">
        <div class="ui checkbox">
        	<g:checkBox name="categorySurvey" value="${child.id}" readonly="${edit}" checked="false" />
        	<label for="child.name">${child.name}</label>
        </div>
        <g:render template="category" model="${[category: child]}" />
    </g:each>
</div>
