var elementCounter = 0;

function toggleFullscreen(elem) {
  let parentId = elem.closest('.card').attr('id');
  
  if (elem.children('i').hasClass('bi-arrows-angle-expand')) {
    elem.children('i').removeClass('bi-arrows-angle-expand');
    elem.children('i').addClass('bi-arrows-angle-contract');
    if($("[id$='coBasemap']").closest('.card').attr('id') === parentId) {
      $("[id$='coBasemap']").css('height', '100vh').css('height', '-=55px');
    }
    if($("[id$='poBasemap']").closest('.card').attr('id') === parentId) {
      $("[id$='poBasemap']").css('height', '100vh').css('height', '-=55px');
    }
    if($("[id$='eoBasemap']").closest('.card').attr('id') === parentId) {
      $("[id$='eoBasemap']").css('height', '100vh').css('height', '-=80px');
    }
    if($("[id$='naNetwork']").closest('.card').attr('id') === parentId) {
      $("[id$='naNetwork']").css('height', '100vh').css('height', '-=80px');
    }
  } else if (elem.children('i').hasClass('bi-arrows-angle-contract')) {
    elem.children('i').removeClass('bi-arrows-angle-contract');
    elem.children('i').addClass('bi-arrows-angle-expand');
    if($("[id$='coBasemap']").closest('.card').attr('id') === parentId) {
      $("[id$='coBasemap']").css('height', '500px');
    }
    if($("[id$='poBasemap']").closest('.card').attr('id') === parentId) {
      $("[id$='poBasemap']").css('height', '500px');
    }
    if($("[id$='eoBasemap']").closest('.card').attr('id') === parentId) {
      $("[id$='eoBasemap']").css('height', '500px');
    }
    if($("[id$='naNetwork']").closest('.card').attr('id') === parentId) {
      $("[id$='naNetwork']").css('height', '500px');
    }
  }

  elem.closest('.card').toggleClass('panel-fullscreen');
}

$("div[id$='-fullscreen']").off().on("click", function() {
    
    $(this).trigger("shown");
    toggleFullscreen($(this));
      
    $('[data-toggle="popover"]').popover("dispose");
    $(".popover").remove();  
});

$('[data-toggle="tooltip"]').tooltip();
