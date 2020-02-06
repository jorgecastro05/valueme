<div class="ui middle aligned center aligned grid">
        <div class="column">
            <g:if test='${flash.message}'>
                <div class="ui error message">
                    <i class="close icon"></i> ${flash.message}
                </div>
            </g:if>
            <h3 class="ui header"> <g:message code='springSecurity.login.header' /></h3>
            <g:form controller="login" action="authenticate" method="POST" class="ui large form" autocomplete="off">
                <div class="ui basic segment">
                    <div class="field">
                        <label for="username">
                            <g:message code='springSecurity.login.username.label' />:
                        </label>
                        <input type="email" name="${usernameParameter ?: 'username'}" id="username" autocapitalize=off />
                    </div>
                    <div class="field">
                        <label for="password">
                            <g:message code='springSecurity.login.password.label' />:
                        </label>
                        <input type="password" name="${passwordParameter ?: 'password'}" id="password" />
                    </div>
                    <div class="inline field">
                        <div class="ui checkbox">
                            <input type="checkbox" name="${rememberMeParameter ?: 'remember-me'}" id="remember_me" <g:if test='${hasCookie}'>checked="checked"</g:if>/>
                            <label for="remember_me">
                                <g:message code='springSecurity.login.remember.me.label' />
                            </label>
                        </div>
                    </div>
                    <input class="ui blue fluid button" type="submit" id="submit" value="${message(code: 'springSecurity.login.button')}" />
                </div>
            </g:form>
            <g:link class="ui basic button" controller="UserAccount" action="forgetPassword"><g:message code="userAccount.forgetPassword.label" /></g:link>
        </div>
    </div>
    <script>
    (function() {
        document.forms['loginForm'].elements['${usernameParameter ?: 'username'}'].focus();
    })();
    </script>