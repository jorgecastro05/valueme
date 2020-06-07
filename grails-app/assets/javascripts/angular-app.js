// init angular application
var app = angular.module('valueme', ['ngRoute'])
    .config(["$httpProvider", function($httpProvider) {
        // loader ajax inserts an loading cursor
        $httpProvider.interceptors.push(["$document", function($document) {
            return {
                'request': function(config) {
                    // here ajax start
                    // here we can for example add some class or show somethin
                    $document.find("body").css("cursor", "wait");

                    return config;
                },

                'response': function(response) {
                    // here ajax ends
                    //here we should remove classes added on request start

                    $document.find("body").css("cursor", "auto");

                    return response;
                }
            };
        }]);
    }]);

//controlador de cuentas de usuario
app.controller('userAccount', ["$scope", "$compile", "$http", function($scope, $compile, $http) {

    // funcion al hacer click en activar y cambiar contrasena de usuarios
    $scope.activate = function(userId) {
        $('.ui.modal').modal('show'); //show modal
        $("#userAccount").attr('value', userId); //establish userAccount field
    };

    // funcion al hacer click en una categoria para mostrarla en el modelo
    $(':radio').change(function() {
        $('.selected.category').text($(this).attr('text'));
    });

}]);

//controlador de encuesta
app.controller('survey', ["$scope", "$compile", "$http", function($scope, $compile, $http) {

    // funcion al cargar completamente la pagina que establece los id de las preguntas de la encuesta
    $scope.$watch('$viewContentLoaded', function() { //al cargar la pagina

        $(":checkbox").each(function(index) {
            $(this).attr('id', 'survey.questions[' + index + ']');
        });
    });
}]);


//controlador de la evaluación
app.controller('assessment', ["$scope", "$compile", "$http", function($scope, $compile, $http) {

    // click on a tabel data activates radio for assesments
    $('td').click(function(){
        $(this).find(':radio').click();
    });

    $(":radio").click(function(e) {
     e.stopPropagation();
    });


    



}]);
