<html>

<head>
    <meta name="layout" content="main" />
    <title> App Info and Testing
    </title>
</head>

<body>
    <div class="ui segment">
        <table class="ui very basic table">
            <tbody>
                <tr>
                    <td>
                        Application version
                    </td>
                    <td>
                        <g:meta name="info.app.version" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Grails Version
                    </td>
                    <td>
                        <g:meta name="info.app.grailsVersion" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Database
                    </td>
                    <td>
                    <g:if env="development">
                    	<g:meta name="environments.development" />
                    </g:if>
					<g:if env="production">
                    	<g:meta name="environments.production" />
                    </g:if>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</body>

</html>
