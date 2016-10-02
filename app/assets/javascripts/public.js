//= require swagger/jquery-1.8.0.min
//= require jquery_ujs
//= require handlebars-4.0.0
//= require swagger/lodash.min
//= require swagger/backbone-min
//= require swagger/marked
//= require swagger/es5-shim
//= require swagger/jsoneditor.min
//= require swagger/highlight.9.1.0.pack
//= require swagger/jquery.wiggle.min
//= require swagger/jquery.ba-bbq.min
//= require swagger/jquery.slideto.min
//= require swagger-ui.min
//= require digitalgovtheme/flexslider
//= require digitalgovtheme/superfish
//= require digitalgovtheme/hoverintent
//= require bootstrap/tab
//= require bootstrap/collapse
//= require digitalgovtheme/jsmenus
//= require digitalgovtheme/jquery.mobilemenu
//= require jquery.tipsy.js

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
