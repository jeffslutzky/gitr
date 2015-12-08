$(function(){
  $.ajax({
    url: '/projects/dashboard',
    dataType: 'json'
  }).success(function(data){
    var source   = $("#entry-template").html();
		var template = Handlebars.compile(source);
    $('#projects-board').append(template({projects: data}));
  });
})


$(document).on("click", ".project-li", function (){
 
  var project_id = this.dataset.projectId;
  $.ajax({
    url: '/projects/' + project_id,
    dataType: 'json'
  }).success(function(data){
  $('#project-details').html("");
  $('#project-details').append(data.template);
  });
})



// $().beforeReady(function() {});

// $("button").click(function(){
//     $.ajax({url: "demo_test.txt", success: function(result){
//         $("#div1").html(result);
//     }});
// });