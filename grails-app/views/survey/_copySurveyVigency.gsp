<div class="ui modal" id="copySurveyVigency">
    <i class="close icon"></i>
    <div class="header">
        <g:message code="survey.copySurveyVigency.label" />
    </div>
    <div class=" content">
        <g:form name="form.copysurvey" class="ui form" action="copysurvey">
            <div class="field">
                <label>
                    <g:message code="survey.beforevigency.label" />
                </label>
                <g:set var="year" value="${java.time.LocalDate.now().getYear()}"/>
               <g:select name="beforeVigency" from="${year-3..year+3}" class="ui dropdown" />
            </div>
            <div class="field">
                <label>
                    <g:message code="survey.aftervigency.label" />
                </label>
                <g:select name="afterVigency" from="${year-3..year+3}" class="ui dropdown" />
            </div>
        </g:form>
        <div class="ui small warning message">
            <div class="header">
                Advertencia
            </div>
            Esta acción no se puede deshacer
        </div>
    </div>
    <div class="actions">
        <div class="ui black deny button">
            <g:message code="default.button.cancel.label" />
        </div>
        <input type="submit" form="form.copysurvey" class="ui positive right button" value="${message(code: 'default.button.accept.label')}" />
    </div>
</div>
