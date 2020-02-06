<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'customField.label', default: 'CustomField')}" />
    <title>
        <g:message code="default.edit.label" args="[entityName]" />
    </title>
</head>

<body>
    <a href="#edit-customField" class="ui hidden message" tabindex="-1">
        <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
    </a>
    <!-- messages -->
    <g:if test="${flash.message}">
        <div class="ui positive message">
            <i class="close icon"></i> ${flash.message}
        </div>
    </g:if>
    <g:hasErrors bean="${this.customField}">
        <div class="ui error message">
            <i class="close icon"></i>
            <g:eachError bean="${this.customField}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
                    <g:message error="${error}" />
                </li>
            </g:eachError>
        </div>
    </g:hasErrors>
    <!-- buttons -->
    <div class="ui two buttons">
        <g:link class="ui blue fluid button " action="index">
            <g:message code="default.list.label" args="[entityName]" /></g:link>
        <g:link class="ui blue fluid button " action="create">
            <g:message code="default.new.label" args="[entityName]" /></g:link>
    </div>
    <h3><g:message code="default.edit.label" args="[entityName]" /></h3>
    <!-- form -->
    <div id="edit-customField" class="content scaffold-edit" role="main">
        <g:form resource="${this.customField}" method="PUT" class="ui form" name="jftForm" role="form">
            <g:hiddenField name="version" value="${this.customField?.version}" />
            <g:hiddenField name="value" value="" />
            <div class="field">
                <label>
                    <g:message code="customField.name.label" />
                </label>
                <g:field type="text" name="customField.name" value="${customField.name}" />
            </div>
            <div class="field">
                <label>
                    <g:message code="customField.description.label" />
                </label>
                <g:field type="text" name="customField.description" value="${customField.description}" />
            </div>
            <div class="field">
                <label>
                    <g:message code="customField.type.label" />
                </label>
                <g:select class="ui dropdown" name="customField.type" from="${['text','list']}" value="${customField.type}" valueMessagePrefix="customField" />
            </div>
            <div class="field">
                <label>
                    <g:message code="customField.section.label" />
                </label>
                <g:select class="ui dropdown" name="customField.section" from="${['header','content']}" value="${customField.section}" valueMessagePrefix="customField" />
            </div>
            <div class="inline field">
                <label>
                    <g:message code="customField.active.label" />
                </label>
                <div class="ui checkbox">
                    <g:checkBox name="customField.active" checked="${customField.active}" />
                </div>
            </div>
            <div class="inline field">
                <label>
                    <g:message code="customField.required.label" />
                </label>
                <div class="ui checkbox">
                    <g:checkBox name="customField.required" checked="${customField.required}" />
                </div>
            </div>
            <div class="fields">
                <div class="fourteen wide field">
                    <label>
                        <g:message code="customField.value.label" />
                    </label>
                    <input id="currentValue" type="text" />
                </div>
                <div class="two wide field">
                    <label>
                        <g:message code="default.options.label" />
                    </label>
                    <button class="ui blue button" type="button" onclick="addElement()">Add</button>
                </div>
            </div>
            <table class="ui very basic table" id="tableOptions">
                <thead>
                    <tr>
                        <th>
                            <g:message code="customField.value.label" />
                        </th>
                        <th>
                            <g:message code="default.options.label" />
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <g:each var="cvalue" in="${customField.value}">
                        <tr>
                            <td>
                                ${cvalue}
                            </td>
                            <td>
                                <button class="ui mini button" type="button" onclick="deleteElement(this)">Eliminar </button>
                            </td>
                            <td>
                                <i class="move-up link arrow up icon"></i>
                            </td>
                            <td>
                                <i class="move-down link arrow down icon"></i>
                            </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
            <input class="ui blue fluid button " type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
        </g:form>
    </div>
</body>

</html>
