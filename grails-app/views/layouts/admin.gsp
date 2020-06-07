<div class="ui simple dropdown item">
    <g:message code="userManagement.label"/>
    <div class="menu">
        <sec:access controller='userAccount'>
            <g:link class="item" controller='userAccount'>
                <g:message code="userAccount.list.label"/>
            </g:link>
        </sec:access>
        <sec:access controller='role'>
            <g:link class="item" controller='role'>
                <g:message code="role.list.label"/>
            </g:link>
        </sec:access>
        <sec:access controller='permission'>
            <g:link class="item" controller='permission'>
                <g:message code="permission.list.label"/>
            </g:link>
        </sec:access>
    </div>
</div>
