<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'categoryType.label', default: 'categoryType')}" />
    <title>
        <g:message code="default.show.label" args="[entityName]" />
    </title>
</head>

<body>
    <a href="#show-categoryType" class="ui hidden message" tabindex="-1">
        <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
    </a>
    <!-- messages -->
    <g:if test="${flash.message}">
        <div class="ui positive message">
            <i class="close icon"></i> ${flash.message}
        </div>
    </g:if>
    <!-- buttons -->
    <div class="ui two buttons">
        <g:link class="ui blue fluid button " action="index">
            <g:message code="default.list.label" args="[entityName]" /></g:link>
        <g:link class="ui blue fluid button " action="create">
            <g:message code="default.new.label" args="[entityName]" /></g:link>
    </div>
    <h3><g:message code="default.show.label" args="[entityName]" /></h3>
    <!-- form -->
    <div id="show-categoryType" class="content scaffold-show" role="main">
        <div class="ui list celled">
            <div class="item">
                <div class="header">
                    <g:message code="categoryType.label" />
                </div>
                ${categoryType.name}
            </div>
            <div class="item">
                <div class="header">
                    <g:message code="categoryType.meta.label" />
                </div>
                ${categoryType.applyTo}
            </div>
        </div>
        <g:form resource="${this.categoryType}" method="DELETE">
            <div class="ui two buttons">
                <g:link class="ui blue fluid button " action="edit" resource="${this.categoryType}">
                    <g:message code="default.button.edit.label" default="Edit" /></g:link>
                <input class="ui blue fluid button " type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
            </div>
        </g:form>
    </div>
</body>

</html>
