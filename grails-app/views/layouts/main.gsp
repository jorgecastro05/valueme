<!doctype html>
<html>
    <head>
        <!-- Standard Meta -->
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
            <asset:link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
            <title>
                <g:layoutTitle default="ValueMe app"/>
            </title>
            <asset:stylesheet src="application.css"/>
            <g:layoutHead/>
        </head>

        <body class="Site" ng-app="valueme">
            <div class="Site-content">
                <!-- banner -->
                <div class="ui center aligned container grid">
                    <div class="eight wide column">
                        <div class="eight wide column">
                            <h1 class="ui banner"><g:message code="default.banner.text"/></h1>
                        </div>
                        <img class="ui image"></div>
                    </div>
                    <div class="ui stackable menu">
                        <div class="ui center aligned container grid">
                            <div class="one column row ">
                                <g:applyLayout name="menu"/>
                            </div>
                        </div>
                    </div>
                    <div class="ui fluid container">
                        <g:layoutBody/>
                    </div>
                </div>
                <br/>
                <footer>
                    <div class="ui footer segment">
                        <div class="ui stackable grid container">
                            <div class="five wide column">
                                <a href="/?lang=es">Español</a>
                                <i class="co flag"></i>
                                <a href="/?lang=en">English</a>
                                <i class="us flag"></i>



                            </div>
                            <div class="three wide column">
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
                            <div class="three wide column">
                                <div class="ui teal label">
                                    <i class="book icon"></i>
                                    Company
                                </div>
                            </div>
                            <div class="four wide column">
                                <a href="https://www.google.es/chrome/browser/desktop/" target="_blank">
                                    <i class="large link disabled chrome icon"></i>
                                </a>
                                <a href="https://www.mozilla.org/es-ES/firefox/new/" target="_blank">
                                    <i class="large disabled firefox icon"></i>
                                </a>
                                <i class="big disabled laptop icon"></i>
                                <i class="big disabled tablet icon"></i>
                                <i class="big disabled mobile icon"></i>
                            </div>
                        </div>
                    </div>
                </footer>
                <asset:javascript src="application.js"/>
            </body>
        </html>
