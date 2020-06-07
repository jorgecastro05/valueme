<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'schedule.label', default: 'Schedule')}" />
    <title>
        <g:message code="default.create.label" args="[entityName]" />
    </title>
</head>

<body>
    <a href="#edit-schedule" class="ui hidden message" tabindex="-1">
        <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
    </a>
    <!-- messages -->
    <g:if test="${flash.message}">
        <div class="ui positive message">
            <i class="close icon"></i> ${flash.message}
        </div>
    </g:if>
    <g:hasErrors bean="${this.schedule}">
        <div class="ui error message">
            <i class="close icon"></i>
            <g:eachError bean="${this.schedule}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
                    <g:message error="${error}" />
                </li>
            </g:eachError>
        </div>
    </g:hasErrors>
    <!-- buttons -->
    <g:link class="ui blue fluid button " action="index">
        <g:message code="default.list.label" args="[entityName]" /></g:link>
    <h3 class="text-center"><g:message code="default.create.label" args="[entityName]" /></h3>
    <!-- form -->
    <div id="create-schedule">
        <g:form action="save" class="ui form" role="form">
            <div class="field">
                <label>
                    <g:message code="schedule.vigency.label" />
                </label>
                <div class="ui calendar" id="yearDate">
                    <div class="ui input left icon">
                        <i class="calendar icon"></i>
                        <g:field type="text" name="vigency" />
                    </div>
                </div>
            </div>
            <div class="two fields">
                <div class="field">
                    <label>
                        <g:message code="schedule.startDate.label" />
                    </label>
                    <div class="ui calendar" id="rangestart">
                        <div class="ui input left icon">
                            <i class="calendar icon"></i>
                            <g:field type="text" name="startDate" />
                        </div>
                    </div>
                </div>
                <div class="field">
                    <label>
                        <g:message code="schedule.endDate.label" />
                    </label>
                    <div class="ui calendar" id="rangeend">
                        <div class="ui input left icon">
                            <i class="calendar icon"></i>
                            <g:field type="text" name="endDate" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="field">
                <label>
                    <g:message code="schedule.active.label" />
                </label>
                <div class="ui checkbox">
                    <f:input bean="schedule" property="active" value="${true}" />
                </div>
            </div>
            <g:submitButton name="create" class="ui blue fluid button " value="${message(code: 'default.button.create.label', default: 'Create')}" />
        </g:form>
    </div>
</body>

</html>
