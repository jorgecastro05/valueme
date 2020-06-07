<html>

<head>
    <meta name="layout" content="main" />
    <title> Gracias !!
    </title>
</head>

<body>
    <div class="ui massive success message">
        <div class="header">¡Gracias por completar la encuesta!
        </div>
        <div class="content">
            Agradecemos su participación
        </div>
    </div>
    <form class="ui form" name="logout" method="POST" action="${createLink(controller:'logout')}">
        <input type="submit" value="salir" class="ui fluid blue button" />
    </form>
</body>

</html>
