$("div[id$='filterbox-popover2']").hide();

$(document).popover({
  trigger: 'click',
  container: 'body',
  placement: 'right',
  html: true,
  sanitize: false,
  selector: '[data-toggle="popover2"]',
  content: function() {
            return $(this).parent().find('.content2').html();
  },
 }).on("show.bs.popover", function(e){
  $(document).on("click", "div[id$='-datadownload']", function(e) {
    console.log("pups")
    e.stopImmediatePropagation();
    let card_element = $(this).attr('id');    
    let card = card_element.replace("-datadownload", ""); 
    const file_format = $(this).closest('.popover').find('select#list').val();
    console.log(card)
    Shiny.setInputValue("table_download_select", {tbldl_select: card,
                                                  file_format: file_format,
                                                  nonce: Math.random()})
  });
  
});