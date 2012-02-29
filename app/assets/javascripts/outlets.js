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
		
		
		// activate the AutoSuggest for languages 
		var languagePlaceholder = "";//$("#language").attr("placeholder");
		$("#language").autoSuggest(
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
			);
		
		
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
