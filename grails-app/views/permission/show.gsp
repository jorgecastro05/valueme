<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'permission.label', default: 'Permission')}" />
    <title>
        <g:message code="default.show.label" args="[entityName]" />
    </title>
</head>

<body>
    <g:if test="${flash.message}">
        <div class="ui positive message">
            <i class="close icon"></i> ${flash.message}
        </div>
    </g:if>
    <div class="ui two buttons">
        <g:link class="ui blue fluid button " action="index">
            <g:message code="default.list.label" args="[entityName]" /></g:link>
        <g:link class="ui blue fluid button " action="create">
            <g:message code="default.new.label" args="[entityName]" /></g:link>
    </div>
    <h3><g:message code="default.show.label" args="[entityName]" /></h3>
    <dl class="dl-horizontal">
        <div class="ui celled list">
            <div class="item">
                <div class="header">
                    <g:message code="permission.label" />
                </div>
                ${permission.permission}
            </div>
        </div>
        <g:form resource="${this.permission}" method="DELETE">
            <div class="text-center">
                <div class="ui two buttons">
                    <g:link class="ui blue fluid button " action="edit" resource="${this.permission}">
                        <g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="ui blue fluid button " type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </div>
            </div>
        </g:form>
</body>

</html>
