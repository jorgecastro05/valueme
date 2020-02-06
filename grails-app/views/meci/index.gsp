<!DOCTYPE html>
<html>

    <head>
        <meta name="layout" content="main"/>
        <title>
            <g:message code="meci.index.label"/>
        </title>
    </head>

    <body>
       <g:if test="${flash.error}">
        <div class="ui negative message">
            <i class="close icon"></i> ${flash.error}
        </div>
       </g:if>
        <div class="ui blue segment">
            <div class="ui grid centered">
                <div class="row">
                ${raw(valueme.Param.findByName('html.meci').value)}
                </div>
                <div class="row">
                <img src="${resource(dir: 'images', file: 'meci.png')}" alt="MECI"/>
                </div>
                <div class="row">
                    <g:link controller="assessment" action="create" class="ui right labeled blue icon button fluid">
                        <i class="right arrow icon"></i>
                        <g:message code="meci.continue.label"/>
                    </g:link>
                </div>
            </div>
        </div>
    </body>

</html>
