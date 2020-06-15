<sec:ifNotLoggedIn>
    <g:render template="/login/login" />
</sec:ifNotLoggedIn>
<sec:ifLoggedIn>
    <div class="ui message">
        <div class="header">
            New Site Features
        </div>
        <ul class="list">
            <li>Improved UI performance</li>
            <li>Updated Authentication framework and platform</li>
        </ul>
    </div>
</sec:ifLoggedIn>