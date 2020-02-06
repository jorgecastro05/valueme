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
    <sec:ifLoggedIn>
        <div class="ui simple dropdown item">
            <sec:username/>
            <div class="menu">
                <form class="ui form" name="logout" method="POST" action="${createLink(controller:'logout')}">
                    <g:link class="ui item fluid basic button" controller="userAccount" action="show" params="[userAccount: sec.loggedInUserInfo(field:'id')]">
                        <g:message code="userAccount.myAccount.label"/>
                    </g:link>
                    <input type="submit" value="salir" class="ui item fluid basic button"/>
                </form>
            </div>
        </div>
    </sec:ifLoggedIn>
</div>
