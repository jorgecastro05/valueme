<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'customField.label', default: 'CustomField')}" />
    <title>
        <g:message code="default.show.label" args="[entityName]" />
    </title>
</head>

<body>
    <a href="#show-customField" class="ui hidden message" tabindex="-1">
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
    <div id="show-customField" class="content scaffold-show" role="main">
        <div class="ui list celled">
            <div class="item">
                <div class="header">
                    <g:message code="customField.name.label" />
                </div>
                ${customField.name}
            </div>
            <div class="item">
                <div class="header">
                    <g:message code="customField.description.label" />
                </div>
                ${customField.description}
            </div>
            <div class="item">
                <div class="header">
                    <g:message code="customField.type.label" />
                </div>
                <g:message code="customField.${customField.type}"/>
            </div>
            <div class="item">
                <div class="header">
                    <g:message code="customField.section.label" />
                </div>
                <g:message code="customField.${customField.section}"/>
            </div>
            <div class="item">
                <div class="header">
                    <g:message code="customField.active.label" />
                </div>
                <g:formatBoolean boolean="${customField.active}" />
            </div>
            <div class="item">
                <div class="header">
                    <g:message code="customField.required.label" />
                </div>
                <g:formatBoolean boolean="${customField.required}" />
            </div>
            <div class="item">
                <div class="header">
                    <g:message code="customField.value.label" />
                </div>
                <ul class="ui list">
                <g:each var="item" in="${customField.value}">
                <li>${item}</li>
                </g:each>
                </ul>
            </div>

            <g:form resource="${this.customField}" method="DELETE">
                <div class="ui two buttons">
                    <g:link class="ui blue fluid button " action="edit" resource="${this.customField}">
                        <g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="ui blue fluid button " type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </div>
            </g:form>
        </div>
</body>

</html>
