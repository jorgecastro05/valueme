<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="categoryType" />
    <title>
        <g:message code="default.list.label" args="[entityName]" />
    </title>
</head>

<body>
    <a href="#list-categoryType" class="ui hidden message" tabindex="-1">
        <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
    </a>
    <g:if test="${flash.message}">
        <div class="ui positive message">
            <i class="close icon"></i> ${flash.message}
        </div>
    </g:if>
    <!-- buttons -->
    <div class="ui stackable grid">
        <div class="twelve wide column">
            <h3>
                <g:message code="${entityName}.list.label" />
            </h3>
        </div>
        <div class="four wide column">
            <g:link class="fluid ui blue fluid button " action="create">
                <g:message code="default.new.label" />
            </g:link>
        </div>
        <div class="ui hidden divider"></div>
    </div>
    <!-- form -->
    <div id="list-categoryType" class="content scaffold-list" role="main">
        <table class="ui compact selectable table">
            <thead>
                <tr>
                    <g:sortableColumn property="categoryType" title="${message(code: 'categoryType.name.label')}" />
                    <th>
                        <g:message code="categoryType.meta.label" />
                    </th>
                    <th>
                        <g:message code="default.options.label" />
                    </th>
                </tr>
            </thead>
            <g:each in="${categoryTypeList}" var="categoryType">
                <tr>
                    <td>
                        <g:link action="show" id="${categoryType.id}">
                            ${categoryType.name}
                        </g:link>
                    </td>
                    <td>
                        ${categoryType.applyTo}
                    </td>
                    <td>
                        <g:link action="edit" id="${categoryType.id}">
                            <g:message code="default.button.edit.label" />
                        </g:link>
                    </td>
                </tr>
            </g:each>
        </table>
        <div class="pagination">
            <g:paginate total="${categoryTypeCount ?: 0}" />
        </div>
    </div>
</body>

</html>