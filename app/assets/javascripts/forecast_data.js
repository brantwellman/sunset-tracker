var radar = {}

radar.init = function(){
  radar.container = $('.forecast-data');
  if (radar.container.length > 0) {
    radar.build_chart();
  }
}

radar.margin = function() {
  return { top: 100, right: 100, bottom: 100, left: 100}
}

radar.width = function() {
  return Math.min(700, window.innerWidth - 10) - radar.margin().left - radar.margin().right
}

radar.height = function() {
  return Math.min(radar.width(), window.innerHeight - radar.margin().top - radar.margin().bottom - 20);
}

radar.build_chart = function() {

  $.get("/favorites/"+user_id, function(data){

    var color = d3.scale.ordinal()
      .range(["#EDC951","#CC333F","#00A0B0"]);

    var radarChartOptions = {
      w: radar.width(),
      h: radar.height(),
      margin: radar.margin(),
      maxValue: 0.5,
      levels: 5,
      roundStrokes: true,
      color: color
    };

    //Call function to draw the Radar chart
    RadarChart(".radarChart", data, radarChartOptions);

  });
  //clean up data

  //return

      // [iPhone
      // {axis:"Battery Life",value:0.22},
      // {axis:"Brand",value:0.28},
      // {axis:"Contract Cost",value:0.29},
      // {axis:"Design And Quality",value:0.17},
      // {axis:"Have Internet Connectivity",value:0.22},
      // {axis:"Large Screen",value:0.02},
      // {axis:"Price Of Device",value:0.21},
      // {axis:"To Be A Smartphone",value:0.50}
      // ],
    //   [//Samsung
    //   {axis:"Battery Life",value:0.27},
    //   {axis:"Brand",value:0.16},
    //   {axis:"Contract Cost",value:0.35},
    //   {axis:"Design And Quality",value:0.13},
    //   {axis:"Have Internet Connectivity",value:0.20},
    //   {axis:"Large Screen",value:0.13},
    //   {axis:"Price Of Device",value:0.35},
    //   {axis:"To Be A Smartphone",value:0.38}
    //   ],[//Nokia Smartphone
    //   {axis:"Battery Life",value:0.26},
    //   {axis:"Brand",value:0.10},
    //   {axis:"Contract Cost",value:0.30},
    //   {axis:"Design And Quality",value:0.14},
    //   {axis:"Have Internet Connectivity",value:0.22},
    //   {axis:"Large Screen",value:0.04},
    //   {axis:"Price Of Device",value:0.41},
    //   {axis:"To Be A Smartphone",value:0.30}
    //   ]
    // ];
}

$(document).ready(function(){
  radar.init();
});
