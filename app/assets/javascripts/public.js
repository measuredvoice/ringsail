//= require jquery-3.4.1.min
//= require jquery_ujs
//= require handlebars-v4.7.3
//= require uswds

$(document).ready(function(){
	$('.usa-banner__header-action').on('click',function(){
		$('.usa-banner__content').toggle();
	});

	$('.btn-learn-more ').on('click',function(){
		$('#org-details').toggle();
	});

});
