$(function(){
  $.ajax({
    url: '/projects/dashboard',
    dataType: 'json'
  }).success(function(data){
    $('#projects_board').append(data.template)
  });
})
