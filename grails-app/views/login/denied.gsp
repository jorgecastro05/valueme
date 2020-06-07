<html>

<head>
    <meta name="layout" content="${gspLayout ?: 'main'}" />
    <title>
        <g:message code='springSecurity.denied.title' />
    </title>
</head>

<body>
    <div class="ui icon message">
        <i class="warning icon"></i>
        <div class="content">
                <g:message code='springSecurity.denied.message' />
        </div>
    </div>
</body>

</html>
