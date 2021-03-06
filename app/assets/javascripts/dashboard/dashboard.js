var last_clicked_item = null;

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

$(document).on("click", ".project-li a", function (){
  $('#new-issues').slideUp(500);
  $('#dashboard-analytics').slideUp(500);

  $(this).addClass('active');
  var project_id = $(this).parent()[0].dataset.projectId;
  $.ajax({
    url: '/projects/' + project_id,
    dataType: 'json'
  }).success(function(data){
    $('#project-details').html("");
    $('#project-details').append(data.template);

    url = this.url;
    get_activity_feed(url);
    get_language_statistics(url);
  });

  if (last_clicked_item) {
    $(last_clicked_item).removeClass('active')
  }
  last_clicked_item = this;
})

$(document).on("click", ".mark-inactive", function (){
  var project_id = $(this).parent()[0].dataset.projectId;
  $.ajax({
    url: '/projects/' + project_id,
    method: 'patch',
    data: {mark_inactive: true},
    dataType: 'json'
  }).success(function(data){
    var el = $('.project-li[data-project-id='+data+']')
    el.remove();
  });

  $('#graph1').html("");
  trigger_collaborators_chart();
})

function get_activity_feed(url){
  $.ajax({
    url: url+'/get_recent_activity',
    datatype: 'json'
  }).success(function(data){
    $('#feed').append(data.html);
  })
}

function get_language_statistics(url){
  $.ajax({
    url: url+'/get_language_statistics',
    datatype: 'json'
  }).success(function(data){
    $('#languages').append(data.html);
  })
}
