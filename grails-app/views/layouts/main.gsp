<!doctype html>
<html>

<head>
    <!-- Standard Meta -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <asset:link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <title>
        <g:layoutTitle default="ValueMe app" />
    </title>
    <asset:stylesheet src="application.css" />
    <g:layoutHead />
</head>

<body class="Site" ng-app="valueme">
    <div class="Site-content">
        <!-- banner -->
        <div class="ui center aligned container grid">
            <div class="eight wide column">
                <div class="eight wide column">
                    <h1 class="ui banner">
                        <g:message code="default.banner.text" />
                    </h1>
                </div>
                <img class="ui image">
            </div>
        </div>
        <div class="ui blue stackable inverted menu">
            <g:applyLayout name="menu" />
        </div>
        <div class="ui fluid container">
            <g:layoutBody />
        </div>
    </div>
    <footer>
        <div class="ui stackable blue inverted borderless menu">
            <div class="item">
                <a href="/?lang=es">Español</a>
                <i class="co flag"></i>
                <a href="/?lang=en">English</a>
                <i class="us flag"></i>
            </div>
            <div class="item">
                <div class="ui instant move reveal">
                    <div class="visible content">
                        <div class="ui teal label">
                            <i class="code icon"></i>
                            Powered by Grails
                        </div>
                    </div>
                    <div class="hidden content">
                        <div class="ui teal label">
                            <i class="game icon"></i>
                            Jorge Castro
                        </div>
                    </div>
                </div>
            </div>
            <div class="item">
                <div class="ui teal label">
                    <i class="book icon"></i>
                    Company
                </div>
            </div>
        </div>
    </footer>
    <asset:javascript src="application.js" />
</body>

</html>