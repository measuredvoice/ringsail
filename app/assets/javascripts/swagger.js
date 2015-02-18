//= require swagger/shred.bundle.js
//= require swagger/jquery-1.8.0.min
//= require jquery_ujs
//= require swagger/jquery.slideto.min
//= require swagger/jquery.wiggle.min
//= require swagger/jquery.ba-bbq.min
//= require swagger/handlebars-1.0.0
//= require swagger/underscore-min
//= require swagger/backbone-min
//= require swagger/swagger.js
//= require swagger/swagger-ui
//= require swagger/highlight.7.3.pack
//= require bootstrap-sprockets
//= require digitalgovtheme/jquery.ui.min
//= require digitalgovtheme/flexslider
//= require digitalgovtheme/superfish
//= require digitalgovtheme/hoverintent
//= require digitalgovtheme/jsmenus
//= require digitalgovtheme/jquery.mobilemenu

$(document).ready(function() { 
    $('#topnav ul.nav').superfish({ 
      delay:    300,        // delay on mouseout 
      animation:  {opacity:'show',height:'show'}, // fade-in and slide-down animation 
      speed:    'fast',       // faster animation speed
      cssArrows:  false       // disable generation of arrow mark-up
    });  
  });  
  

$(document).ready(function() { 
  $('#catnav ul.catnav').superfish({ 
    delay:    300,        // delay on mouseout 
    animation:  {opacity:'show',height:'show'}, // fade-in and slide-down animation 
    speed:    'fast',       // faster animation speed
    cssArrows:  false       // disable generation of arrow mark-up
  }); 
});  
