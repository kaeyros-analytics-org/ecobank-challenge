
function takeSavescreen(elem, file_format, file_scale, extr_title, extr_filter) {
  
    let ua = window.navigator.userAgent;
    let msie = ua.indexOf("MSIE ");
    if (msie > 0 || !!ua.match(/Trident.*rv\:11\./)) {
      alert(
        "Screenshot Funktionalität ist nicht verfügbar im Internet Explorer."
      );
      return;
    }  
   
    let toCapture = elem.attr("data-selector");
    
    let virtual_node = document.querySelector(toCapture); 
    let node = virtual_node.cloneNode(true);
  
    let position = node.style.position;
    let left = node.style.left;
  
    node.style.position = 'absolute';
    node.style.left = '-9999px';
  
    $( node ).width( virtual_node.clientWidth);
    $( node ).height( virtual_node.clientheight);
  
    virtual_node.appendChild(node);
  
    let fileName = elem.attr("data-filename");
    replace_cardheader = node.childNodes[1];
  
    // get selected dataset
    
    var source = document.getElementsByClassName("nav-item active")[0].innerText;
    
    var selected_data = source;
  
    // get title value
    var title = extr_title;
  
    // create logo div above screenshot 
    var logo_div = document.createElement('div');    
    logo_div.style.height = "50px";
    logo_div.style.backgroundColor = "white";  
  
    // create preview image
    var url = "./images/logo_preview_klein.png";  
    var image = new Image(150,50);
    image.src = url;
    image.style.zIndex = "2";
    image.style.position = "absolute";  
    image.style.top = "2px";
    image.style.right = "0";   
    
    logo_div.appendChild(image);    
  
    node.replaceChild(logo_div, node.childNodes[1]);
  
    // display selected dataset in plot
  
    if (selected_data == "ACLED") {
  
      var datadiv = document.createElement('div');    
      datadiv.style.height = "25px";
      datadiv.style.backgroundColor = "white";
  
      datadiv.innerHTML += '<span style="font-size: 12px">Datenquelle: Armed Conflict Location & Event Data Project (ACLED); acleddata.com</span>';
  
      node.appendChild(datadiv);      
  
    }
  
    if (selected_data == "GTD") {
  
      var datadiv = document.createElement('div');    
      datadiv.style.height = "50px";
      datadiv.style.backgroundColor = "white";
  
      datadiv.innerHTML += '<span style="font-size: 12px">Datenquelle: National Consortium for the Study of Terrorism and Responses to Terrorism (START). (2018). Global Terrorism Database [Data file]. Retrieved from https://www.start.umd.edu/gtd</span>';
  
      node.appendChild(datadiv);      
  
    } 
  
    if (selected_data == "UCDP GED") {
  
      var datadiv = document.createElement('div');    
      datadiv.style.height = "50px";
      datadiv.style.backgroundColor = "white";
  
      datadiv.innerHTML += '<span style="font-size: 12px">Datenquelle: Sundberg, Ralph, and Erik Melander, 2013, "Introducing the UCDP Georeferenced Event Dataset", Journal of Peace Research, vol.50, no.4, 523-532; Croicu, Mihai and Ralph Sundberg, 2017, "UCDP GED Codebook version 18.1", Department of Peace and Conflict Research, Uppsala University</span>';
  
      node.appendChild(datadiv);      
  
    }
  
    // check if title is checked in the popover
    if (extr_title){    
  
      var filter_div = $(document).find('.card-header')[0]
      var filter_title = filter_div.childNodes[1].textContent;  
      replace_cardheader = node.childNodes[1];   
      logo_div.innerHTML += '<span class="dltitle" style="font-weight:bold" >'+title+'</span>';
  
    }
  
    // check if filter is checked in the popover
    if (extr_filter){    
      
      
      //filterdiv old code for grabbing the title
      //var filter_div = $(document).find("div[id$='-filterCard']");
      
      //var filter_title = filter_div.childNodes[1].textContent;
      //console.log(filter_title);
  
      var div2 = $(document).find("div[id$='-filterCard']").clone()[0] 

      var div3 = document.createElement('div');    
      div3.style.height = "50px";
      div3.style.backgroundColor = "white";
      //div3.innerHTML += '<span class="dltitle" style="font-weight:bold" >'+filter_title+'</span>';
      
      div2.replaceChild(div3, div2.childNodes[1]);
  
      node.appendChild(div2); 
  
    } 
  
    // pass information to dom-to-image depending on the file format
    if (file_format == ".jpeg") {
      domtoimage
      .toJpeg(node, {
        width: node.clientWidth*file_scale,
        height: node.clientHeight*file_scale, 
        style: {
          'transform': 'scale('+file_scale+')',
          'transform-origin': 'top left',
          'box-shadow': 'none', 
          'position': position,
          'left': left
          }})
      .then(function(blob) {      
        window.saveAs(blob, fileName);
        virtual_node.removeChild(node);      
        $("[data-toggle='popover']").popover('dispose');
      })
      .catch(function(error) {
        console.error("Screenshot fehlgeschlagen:", error);
      });
    }
  
    if (file_format == ".png") {
      domtoimage
      .toPng(node, {
        width: node.clientWidth*file_scale,
        height: node.clientHeight*file_scale,
        style: {
          'transform': 'scale('+file_scale+')',
          'transform-origin': 'top left',
          'box-shadow': 'none', 
          'position': position,
          'left': left
          }})
      .then(function(blob) {
        window.saveAs(blob, fileName);
        virtual_node.removeChild(node);
        $("[data-toggle='popover']").popover('dispose');
      })
      .catch(function(error) {
        console.error("Screenshot fehlgeschlagen:", error);
      });
    }
  
    if (file_format == ".svg") {
      domtoimage
      .toSvg(node, {
        width: node.clientWidth*file_scale,
        height: node.clientHeight*file_scale,
        style: {
          'transform': 'scale('+file_scale+')',
          'transform-origin': 'top left',
          'box-shadow': 'none', 
          'position': position,
          'left': left
          }})
      .then(function(blob) {
        window.saveAs(blob, fileName);
        virtual_node.removeChild(node);
        $("[data-toggle='popover']").popover('dispose');
      })
      .catch(function(error) {
        console.error("Screenshot fehlgeschlagen:", error);
      });
    }
  
  }
  
$('body').popover({
  trigger: 'click',
  container: 'body',
  placement: 'right',
  html: true,
  sanitize: false,
  selector: '[data-toggle="popover"]',
  content: function() {
            return $(this).parent().find('.content').html();
  },
  template: '<div class="popover"><div class="arrow"></div><div class="popover-header"><div id={{ saveScreenId }} class = "card-savescreen" data-selector = {{ accordionIdConcat }} data-filename = {{ saveScreenName }} style="text-align:center"><i class="bi bi-save" style="text-align:center; font-weight: bold; cursor:pointer;"></i> </div><h3 class="popover-title"></h3></div><div class="popover-body"></div></div><div class="popover-footer"><a href="#" class="btn btn-info btn-sm">Close</a></div></div>'
}).on("show.bs.popover", function(e){
  
  $(document).on("click", "div[id$='-savescreen']", function(e) {
    e.stopImmediatePropagation();
       
    let extr_title = $(this).closest('.popover').find("input[name*='title']").val();    

    const extr_filter = $(this).closest('.popover').find('#scr_filter').prop('checked');    
    
    const file_format = $(this).closest('.popover').find('select#list').val();  
  
    const file_scale = $(this).closest('.popover').find('input#Scale.slider-popover').val();
    
    
    takeSavescreen($(this), file_format, file_scale, extr_title, extr_filter);
    
    
  });

  $('[data-toggle="popover"]').not(e.target).popover("dispose");
  $(".popover").remove();     

});

$("html").on("mouseup", function (e) {
  var l = $(e.target);

  try {
      if (l[0].className.indexOf("popover") == -1) {
        $(".popover").each(function () {
            $(this).popover("hide");
        });
      }
  } catch (e) {

  }

});
