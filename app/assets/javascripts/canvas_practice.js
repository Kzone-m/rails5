$(document).ready(function() {
  //var stage = document.getElementById('stage');
  var stage = $('#stage')[0];
  var ctx;
  var width = 480;
  var height = 260;
  if (typeof stage.getContext === 'undefined'){
    // console.log("HERE");
    return;
  }
  ctx = stage.getContext('2d');
  stage.width = width;
  stage.height = height;
});
