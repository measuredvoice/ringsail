//= require jquery-3.4.1.min
//= require jquery_ujs
//= require handlebars-v4.7.3
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
//= require bootstrap/tab
//= require bootstrap/collapse
//= require jquery.tipsy.js
//= require datatables
//= require datatables.bootstrap

$(document).ready(function(){
	$('.usa-banner__header-action').on('click',function(){
		$('.usa-banner__content').toggle();
	});

	$('.btn-learn-more ').on('click',function(){
		$('#org-details').toggle();
	});

});
