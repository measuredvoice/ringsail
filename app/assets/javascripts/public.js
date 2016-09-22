//= require jquery
//= require handlebars-2.0.0
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
