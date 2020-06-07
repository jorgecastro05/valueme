 /*
  * # Valueme App
  * Reports charts Generator custom code
  * generate charts for scores in all scores views
  */


 if (document.getElementById("chart_total")) {
     // Draw the chart total score
     google.charts.load('current', { packages: ['corechart', 'bar'] });
     google.charts.setOnLoadCallback(drawTotalChart);
 }
 if (document.getElementById("chart_a")) {
     // Draw the chart categoryA score compare view
     google.charts.load('current', { packages: ['corechart', 'bar'] });
     google.charts.setOnLoadCallback(drawCategoryAChart);
 }
 if (document.getElementById("chart_b")) {
     // Draw the chart categoryB score compare view
     google.charts.setOnLoadCallback(drawCAtegoryBChart);
 }


 function drawTotalChart() {

     var data = new google.visualization.DataTable();
     data.addColumn('string', 'Categoria');
     data.addColumn('number', 'Valoración');
     data.addColumn({
         type: 'string',
         role: 'style'
     });
     data.addColumn('string', 'criteria');

     data.addRows(scoreData);

     // calculate all score based on data
     var score = 0;
     for (var i = scoreData.length - 1; i >= 0; i--) {
         score += scoreData[i][1];
     }
     score = score / scoreData.length;


     var options = {
       chartArea: {
       top: 28
        },
         title: 'Resultado por ' + categoryType,
         legend: 'none',
         height:350,
         hAxis: {
             title: 'Puntuación ' + score.toFixed(2),
             titleTextStyle: {
                 opacity: 0.8
             },
             showTextEvery: 1
         },
         vAxis: {
            viewWindowMode:'explicit',
            viewWindow: {
              max:5,
              min:1
            }
          },
          annotations: {
             textStyle: {
            color: '#000000'
          },
          highContrast: false
        }};

     var view = new google.visualization.DataView(data);
     view.setColumns([0, 1, {
             calc: "stringify",
             sourceColumn: 3,
             type: "string",
             role: "annotation"
         },
         2
     ]);

     var chart = new google.visualization.ColumnChart(
         document.getElementById('chart_total'));

     chart.draw(view, options);
 }


 function drawCategoryAChart() {

     var data = new google.visualization.DataTable();
     data.addColumn('string', 'Categoria');
     data.addColumn('number', 'Valoración');
     data.addColumn({
         type: 'string',
         role: 'style'
     });
     data.addColumn('string', 'criteria');

     data.addRows(scoreDataA);

     // calculate all score based on data
     var score = 0;
     for (var i = scoreDataA.length - 1; i >= 0; i--) {
         score += scoreDataA[i][1];
     }
     score = score / scoreDataA.length;

     var options = {
       chartArea: {
       top: 28,
       height: '40%'
        },
         title: 'Resultado por ' + categoryType,
         legend: 'none',
         hAxis: {
             title: 'Puntuación ' + score.toFixed(2),
             titleTextStyle: {
                 opacity: 0.8
             },
             showTextEvery: 1
         },
         vAxis: {
            viewWindowMode:'explicit',
            viewWindow: {
              max:5,
              min:1
            }
          },
          annotations: {
             textStyle: {
            color: '#000000'
          },
          highContrast: false
        }};

     var view = new google.visualization.DataView(data);
     view.setColumns([0, 1, {
             calc: "stringify",
             sourceColumn: 3,
             type: "string",
             role: "annotation"
         },
         2
     ]);

     var chart = new google.visualization.ColumnChart(
         document.getElementById('chart_a'));

     chart.draw(view, options);
 }

 function drawCAtegoryBChart() {

     var data = new google.visualization.DataTable();
     data.addColumn('string', 'Categoria');
     data.addColumn('number', 'Valoración');
     data.addColumn({
         type: 'string',
         role: 'style'
     });
     data.addColumn('string', 'criteria');

     data.addRows(scoreDataB);

     // calculate all score based on data
     var score = 0;
     for (var i = scoreDataB.length - 1; i >= 0; i--) {
         score += scoreDataB[i][1];
     }
     score = score / scoreDataB.length;

     var options = {
       chartArea: {
       top: 28,
       height: '40%'
        },
         title: 'Resultado por ' + categoryType,
         legend: 'none',
         hAxis: {
             title: 'Puntuación ' + score.toFixed(2),
             titleTextStyle: {
                 opacity: 0.8
             },
             showTextEvery: 1
         },
         vAxis: {
            viewWindowMode:'explicit',
            viewWindow: {
              max:5,
              min:1
            }
          },
          annotations: {
             textStyle: {
            color: '#000000'
          },
          highContrast: false
        }};

     var view = new google.visualization.DataView(data);
     view.setColumns([0, 1, {
             calc: "stringify",
             sourceColumn: 3,
             type: "string",
             role: "annotation"
         },
         2
     ]);

     var chart = new google.visualization.ColumnChart(
         document.getElementById('chart_b'));

     chart.draw(view, options);
 }
