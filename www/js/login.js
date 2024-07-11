$(document).ready(function() {
  jQuery("input[id='auth-user_pwd']").after('<i class="toggle-password fa fa-eye"></i>');
  $(".toggle-password").click(function() {


    $(this).toggleClass("fa-eye fa-eye-slash");
    input = $(this).parent().find("input");
    if (input.attr("type") == "password") {
        input.attr("type", "text");
    } else {
        input.attr("type", "password");
    }
      });
  });