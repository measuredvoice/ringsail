$(function() {
    $( "#tags" ).autocomplete({
      source: "/agencies/autocomplete.json",
      minLength: 2,
      autoFocus: true
    });

  });
