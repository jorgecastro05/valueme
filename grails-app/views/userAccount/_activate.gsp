<div class="ui modal">
    <i class="close icon"></i>
    <div class="header">
        <g:message code="userAccount.activate.label" />
    </div>
     <div class="content">
        <g:form name="form_activate" class="ui form" action="activate">
            <g:hiddenField name="user" id="userAccount" />
            <div class="field">
                <label>
                    <g:message code="userAccount.passwordHash.label" />
                </label>
                <input id="passwordHash" name="passwordHash" type="password" required="">
            </div>
            <div class="field">
                <label>
                    <g:message code="userAccount.passwordHashRetype.label" />
                </label>
                <input id="passwordHash2" name="passwordHash2" type="password" required="">
            </div>
        </g:form>
          <div class="ui small success message">
            <div class="header">Nota</div>
             Se informará al usuario de la activación por correo electronico
        </div>
        <div class="actions">
          <div class="ui black deny button">
            <g:message code="default.button.cancel.label" />
          </div>
          <input type="submit" form="form_activate" class="ui positive right button" value="${message(code: 'default.button.accept.label')}" />
       </div> 
    </div>
</div>
