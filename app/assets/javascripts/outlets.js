(function() {
	// declare default languages array
	var defaultLanguages = {languages: [
							{value: "English", name: "English"},
							{value: "Spanish", name: "Spanish"},
							{value: "Mandarin", name: "Mandarin"},
							{value: "Arabic", name: "Arabic"},
							{value: "Hindu-Urdu", name: "Hindu-Urdu"},
							{value: "Russian", name: "Russian"},
							{value: "French", name: "French"}
						]};
	var searchTimeout;
	var activeResult;
	
	function checkLanguageField(){
		var query = $("#language").val().toLowerCase();
		var str = "";
		var forward = false;
		var results = Array();
		if (query != ""){
			// NOT the most effective way but we have so few languages, it doesn't matter that much
			for(i=0;i<=(defaultLanguages.languages.length)-1;i++){
				var langName = defaultLanguages.languages[i].name.toLowerCase();
				if (langName.indexOf(query) > -1){
					forward=true;
					results.push(defaultLanguages.languages[i].name);
				}
			}
			if(forward){
				if ($("#languageSearchResults").length){
					$("#languageSearchResults").remove();
				}
				html = "<div id='languageSearchResults'><ul>";
				for(i=0;i<=results.length-1;i++){
					html += "<li><a href='#'>"+results[i]+"</a></li>";
				}
				html += "</ul></div>";
				$("#language").after(html);
			}	
		}
	}
	function removeLanguageDrop(){
		$("#languageSearchResults").remove();
	}
	function hideLanguageDrop(){
		$("#languageSearchResults").hide();
	}
	function showLanguageDrop(){
		$("#languageSearchResults").show();
	}
	function selectResult(dir){
		var nextResult;
		var current = $("#languageSearchResults ul li.active").index();
		var total = $("#languageSearchResults ul li").length;
		
		if (!current){ current = 0; }
		
		if (dir == "down"){
			nextResult = current+1;
			// if we're within our bounds, highlight next
			if (nextResult <= total){
				$("#languageSearchResults ul li").removeClass("active").find("a").removeClass("hover");
				$("#languageSearchResults ul li:eq("+nextResult+")").addClass("active").find("a").addClass("hover");
			}
		} else if (dir == "up"){
			nextResult = current -1;
			// console.log("UP!" + nextResult);
			if (nextResult > -1){
				$("#languageSearchResults ul li").removeClass("active").find("a").removeClass("hover");
				$("#languageSearchResults ul li:eq("+nextResult+")").addClass("active").find("a").addClass("hover");
			}
		} else if (dir == "enter"){
			$("#language").val(	$("#languageSearchResults ul li:eq("+current+") a").html());
			removeLanguageDrop();
		}
	}
	// wait for DOM ready to fire the following
	$(document).ready(function(){
		
		// active "Chosen" plugin - Agencies dropdown
		$(".chzn-select").chosen();
		
		
		// activate the AutoSuggest for tags
		//DEV ONLY: 
		//var jsonTagEndpoint = "add-form_files/tags.php";
		// LIVE (script automagically adds ?q= for typed query
		var jsonTagEndpoint = "/tags.json";
		var tagPlaceholder = "";
		var prefillString = $("#tags").val();
		if (prefillString){
			var prefills = prefillString.split(",");
			var prefillArray = [];
			for(i=0;i<=prefills.length-1;i++){
				var preObj = {}
				preObj = {"tag_id": prefills[i], "tag_text":prefills[i]};
				prefillArray[i] = preObj;
			}
		}
		$("#tags").autoSuggest(jsonTagEndpoint, {preFill: prefillArray, asHtmlID:"tags",minChars: 2, matchCase:false, emptyText:"", selectionLimit: false, startText:tagPlaceholder, resultsHighlight: false, neverSubmit:true, selectedItemProp: "tag_text", selectedValuesProp:"tag_id",searchObjProps: "tag_text"});
		$("#tags").keydown(function(event){
			if (event.which == 9){
				// they pressed tab from the input field, if there is a value here, we should save it
				if ($("#tags").val()){
					$("#as-values-tags").val($("#as-values-tags").val() + $("#tags").val() +",");
				}
			}
		});
		
		// activate the AutoSuggest for languages 
		var languagePlaceholder = "";//$("#language").attr("placeholder");
		/*$("#language").autoSuggest(
				defaultLanguages.languages, 
				{
					asHtmlID: "language", 
					emptyText:"", 
					selectionLimit: 1, 
					minChars: 1, 
					startText:languagePlaceholder, 
					resultsHighlight: false, 
					neverSubmit:true, 
					selectedItemProp: "name", 
					searchObjProps: "value"
				}
			);*/
		$("#language").blur(function(){ setTimeout(function(){ hideLanguageDrop() },300);  });
		$("#language").focus(function(){ if ($("#languageSearchResults").length){ showLanguageDrop(); }});
		$("#language").keydown(function(event){
			if (searchTimeout){
				clearTimeout(searchTimeout);
			}		
			// console.log(event.which);
			if (event.which != 40 && event.which != 38 && event.which != 13){
				searchTimeout = setTimeout(function(){ checkLanguageField(); },200);	
			}
			// only do this if there is a dropdown
			if ($("#languageSearchResults").length){
				if (event.which == 40){
					selectResult("down");
					return false;
				} else if (event.which == 38){
					selectResult("up");
					return false;
				} else if (event.which == 13){
					selectResult("enter");	
					return false;
				}
					
			}
			
			
		});
		// setup functionality for selector
		$("#languageSearchResults ul li a").live('click',function(){
			$("#language").val($(this).html());
			// console.log($(this).html());
			removeLanguageDrop();
			return false;
		});
		$("#languageSearchResults ul li a").live('mouseenter',
			function(){
				$(this).addClass("hover");
				$(this).parent("li").addClass("active");
			})
			.live('mouseleave',
			function(){
				$(this).removeClass("hover");
				$(this).parent("li").removeClass("active");
			});
		
		
		// when the form is submitted, grab the values from the AutoSuggest fields and pop them into a more friendly-named input 
		$("form.validate").submit(function(){
			var destinationFields = Array("tags");
			// loop through desired endpoints
			for (i=0;i<=destinationFields.length-1;i++){
				var fieldName = destinationFields[i];
				var fieldValue = $("#as-values-"+fieldName).val();
				// does this input already exist in the DOM (and, thus, will be submitted as a POST var)
				if ($("#"+fieldName).length){
					// already exists, so lets just pop the right value in there
					$("#"+fieldName).val(fieldValue);
				} else {
					$("<input />").attr({"type":"hidden","name":fieldName}).val(fieldValue).appendTo($(this));
				}
			}
		});
		
	});
	
	
}).call(this);
