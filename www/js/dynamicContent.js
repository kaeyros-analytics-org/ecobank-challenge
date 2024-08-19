$(document).ready(function(){
  let counter = 0;
  let iconClick = 0;
  let previousWidth;
  let width = $(window).width();
  // get screen size
  let hamburgerHTML = '<a href="#" style="font-weight: bold; font-size: 2rem; position: relative; top: -5px;"><i class="bi bi-text-indent-left"></i></a>';
  let closeHTML = '<a href="#">&#10006;</a>';
  let widthSidebar = $("#sidebar-wrapper").width();
  var previewlogo = document.getElementById("previewlogo");

  function toggleHamburgerHTML() {
    if($("#hamburgerCloseToggle").html() == closeHTML) {
      $("#hamburgerCloseToggle").html(hamburgerHTML);
    } else {
      $("#hamburgerCloseToggle").html(closeHTML);
    }
  }
  
  if (widthSidebar > 0) {
    $("#hamburgerCloseToggle").html(closeHTML);
  } else {
    $("#hamburgerCloseToggle").html(hamburgerHTML);
  }
  
  $(window).resize(function() {
    if (previousWidth) {
      
      if ((previousWidth > 768) && (width <= 768) && ($("#sidebar-wrapper").width() > 0)) {
        if ($("#hamburgerCloseToggle").html().length > 45) {
          $("#hamburgerCloseToggle").html(closeHTML);
        } else {
          $("#hamburgerCloseToggle").html(hamburgerHTML);
        }
      }
      
      if ((previousWidth <= 768) && (width > 768)) {
        if ($("#hamburgerCloseToggle").html().length > 45) {
          $("#hamburgerCloseToggle").html(closeHTML);
        } else {
          $("#hamburgerCloseToggle").html(hamburgerHTML);
        }
      }
    
    }
    previousWidth = $(window).width();
  });
  
  $('li.nav-item').click(function(e) {
    let navItemText = $(this).children().html();
    let possibilities = ["Home", "Map", "Customer Service", "Recommendation", "Claims Analytics"];
    let nav_for_filter = ["Map", "Customer Service", "Recommendation", "Claims Analytics"];
    let iconChoices = ['class="bi bi-clipboard"', 'class="bi bi-chat-left-text"', 'class="bi bi-info-circle"', 'class="bi bi-file-earmark-text"', 'class="bi bi-question-circle"'];
    let iconTranslator = ["A propos de l'application", 'Feedback / Disclaimer', 'Methodische Hinweise', "Datenquellen", 'Virtueller Rundgang'];

    if (possibilities.indexOf(navItemText) !== -1) {
      Shiny.setInputValue("datasetNav", navItemText);
      Shiny.setInputValue("allNav", nav_for_filter);
  	  $('li.nav-item.active').removeClass('active');
  	  $(this).addClass('active');

      if ($("button[class='navbar-toggler']").is(':visible')) {
        $("button[class='navbar-toggler']").click();
      }
        
    } else {
      for (let i = 0; i < iconChoices.length; i++) {
        if (navItemText.indexOf(iconChoices[i]) !== -1) {
          iconClick += 1;
          let message = [iconTranslator[i], iconClick];
          Shiny.setInputValue("iconSelection", message);
          if ($("button[class='navbar-toggler']").is(':visible')) {
            $("button[class='navbar-toggler']").click();
          }
        }
      }
    }
  	e.preventDefault();
  });
  
  // tooltips //
  $('[data-toggle="tooltip"]').tooltip();

  // show navbar description on mobile only. 
  if (typeof window.orientation !== 'undefined') { 
    $("span[class='navSpan']").css('display', 'block')
  };
  
  // toggle sidebar //
  $(document).on("click", "#sidebar-toggle", function() {

    let width = $(window).width();

    $("#wrapper").toggleClass("toggled");
    if ($("#hamburgerCloseToggle").html().length > 45) {
      $("#hamburgerCloseToggle").html(closeHTML);
      if (width <= 768){
        previewlogo.style.display = "none";
      }
    } else {
      $("#hamburgerCloseToggle").html(hamburgerHTML);
      if (width <= 768){
        previewlogo.style.display = "block";
      }
    }
  });

  // Daten filtern schließt Sidebar //
  $(document).on("click", "button[id*='actionFilter']", function() {
    if (width <= 768){
       $("#hamburgerCloseToggle").trigger("click"); 
    }
  });

  // toggle navbar //

  if (typeof window.orientation !== 'undefined') { 
    $(document).on("click", "#walkthrough-helpAllgemein", function() {
      $("button[class='navbar-toggler']").trigger("click");  
    });  
  };

  
  // click on acled dropdown //
  $(document).on("click", "#dropdown_acled", function() {
    let navItemText = $("a[id='nav_rss']").html();
    console.log("click");
    Shiny.setInputValue("datasetNav", navItemText);
    $('li.nav-item.active').removeClass('active');
    $("a[id='nav_rss']").addClass('active');
  });

  // click on gtd dropdown //
  $(document).on("click", "#dropdown_gtd", function() {
    let navItemText = $("a[id='nav_ree']").html();
    Shiny.setInputValue("datasetNav", navItemText);
    $('li.nav-item.active').removeClass('active');
    $("a[id='nav_ree']").addClass('active');
  });

  // click on ucdp dropdown //
  $(document).on("click", "#dropdown_ucdp", function() {
    let navItemText = $("a[id='nav_rec']").html();
    Shiny.setInputValue("datasetNav", navItemText);
    $('li.nav-item.active').removeClass('active');
    $("a[id='nav_rec']").addClass('active');
  });
  
    // click on ucdp dropdown //
  $(document).on("click", "#dropdown_ucdp", function() {
    let navItemText = $("a[id='nav_pro']").html();
    Shiny.setInputValue("datasetNav", navItemText);
    $('li.nav-item.active').removeClass('active');
    $("a[id='nav_pro']").addClass('active');
  });

    
  /* trigger model when icon clicked in allgemeines*/
  $(document).on("click", "#allgemeinesmeta", function() {
    console.log("pups")
    $("span[title='Datenquellenbeschreibung']").trigger("click");  
  });  

  /* trigger model when icon clicked in allgemeines*/
  $(document).on("click", "#allgemeinesumfrage", function() {
     console.log("pups")
     $("span[title='A propos de l'application']").trigger("click");  
  });  
});