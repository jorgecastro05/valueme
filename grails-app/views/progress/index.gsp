<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <title>
        <g:message code="progress.label" />
    </title>
</head>

<body>
    <h3 class="text-center"><g:message code="progress.description.label" /></h3>
    <g:form class="ui form">
        <div class="field">
            <label>
                <g:message code="survey.vigency.label" />
            </label>
            <div class="ui calendar" id="yearDate">
                <div class="ui input left icon">
                    <i class="calendar icon"></i>
                    <g:field type="text" name="vigency" />
                </div>
            </div>
        </div>
        <g:submitButton name="index" class="ui blue fluid button " value="${message(code: 'default.show.label')}" />
    </g:form>
    <g:if test="${vigency !=0}">
        <h4>${vigency}</h4>
    </g:if>
    <table class="ui celled table">
        <thead>
            <tr>
                <th>Cuenta usuario</th>
                <th>Nombre</th>
                <th>Categoria</th>
                <th>Encuesta realizada</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${userAccountList}" var="userAccount">
                <tr>
                    <td>
                        ${userAccount.userAccount}
                    </td>
                    <td>
                        ${userAccount.fullName}
                    </td>
                    <td>
                        ${userAccount.category?.category}
                    </td>
                    <td>
                        <g:formatBoolean boolean="${userAccount.finished}" />
                    </td>
                </tr>
            </g:each>
        </tbody>
    </table>
</body>

</html>
