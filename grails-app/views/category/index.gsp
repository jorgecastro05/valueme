<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="category" />
    <title>
        <g:message code="default.list.label" args="[entityName]" />
    </title>
</head>

<body>
    <a href="#list-category" class="ui hidden message" tabindex="-1">
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
            <h3></h3>
        </div>
        <div class="four wide column">
            <g:link class="fluid ui blue fluid button " action="create" params="[categoryType: categoryType]">
                <g:message code="default.new.label" />
            </g:link>
        </div>
        <div class="ui hidden divider"></div>
    </div>
    <!-- form -->
    <div id="list-category" class="content scaffold-list" role="main">
        <table class="ui compact selectable table">
            <thead>
                <tr>
                    <th>
                        <g:message code="category.category.label" />
                    </th>
                    <th>
                        <g:message code="category.type.label" />
                    </th>
                    <th>
                        <g:message code="category.active.label" />
                    </th>
                    <th>
                        <g:message code="category.order.label" />
                    </th>
                    <th>
                        <g:message code="default.options.label" />
                    </th>
                    <th>
                    </th>
                </tr>
            </thead>
            <g:each in="${categoryList}" var="category">
                <tr>
                    <td>
                        <g:if test="${category.childs}">
                            <g:link action="filterByParent" id="${category.id}">
                                ${category.category}
                            </g:link>
                        </g:if>
                        <g:else>
                            ${category.category}
                        </g:else>
                    </td>
                    <td>
                        ${category.type}
                    </td>
                    <td>
                        <g:formatBoolean boolean="${category.active}" />
                    </td>
                    <td>
                        ${category.order}
                    </td>
                    <td>
                        <g:link action="edit" id="${category.id}" params="[categoryType: categoryType]">
                            <g:message code="default.button.edit.label" />
                        </g:link>
                    </td>
                    <td>
                        <g:link action="show" id="${category.id}" params="[categoryType: categoryType]">
                            <g:message code="default.button.details.label" />
                        </g:link>
                    </td>
                </tr>
            </g:each>
        </table>
        <g:paginate total="${categoryCount ?: 0}" />
    </div>
</body>

</html>
