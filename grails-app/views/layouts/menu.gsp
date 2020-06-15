<sec:ifLoggedIn>
    <g:link class="header item" controller="meci" action="index">
        <g:message code="default.home.label"/>
    </g:link>
</sec:ifLoggedIn>
<sec:access controller='userAccount'>
    <g:applyLayout name="admin"/>
</sec:access>
<sec:access controller='category'>
    <g:applyLayout name="params"/>
</sec:access>
<sec:access controller='assessment' action="index">
    <g:applyLayout name="survey"/>
</sec:access>
<sec:access controller='schedule'>
    <g:applyLayout name="schedule"/>
</sec:access>
<sec:access controller='score'>
    <g:applyLayout name="score"/>
</sec:access>
<div class="right menu">
    <form name="logout" method="POST" action="${createLink(controller:'logout')}">
    <sec:ifLoggedIn>
        <div class="ui simple dropdown item">
            <sec:username/>
            <div class="menu">
                    <g:link class="item" controller="userAccount" action="show" params="[userAccount: sec.loggedInUserInfo(field:'id')]">
                        <g:message code="userAccount.myAccount.label"/>
                    </g:link>
                    <input type="submit" value="salir" class="ui item fluid basic button"/>
            </div>
        </div>
    </sec:ifLoggedIn>
    </form>
</div>
