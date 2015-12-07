$(function(){
  $.ajax({
    url: '/projects/dashboard',
    dataType: 'json'
  }).success(function(data){
    var source   = $("#entry-template").html();
		var template = Handlebars.compile(source);
    $('#projects_board').append(template({projects: data}));
  });
})
