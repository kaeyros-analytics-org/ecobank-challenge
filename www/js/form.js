$('ul.vRadioUl > li').click(function() {
    let idUl = $(this).parent().attr('id');
    $('#' + idUl + '>li.vRadioActive').removeClass('vRadioActive');
    $(this).addClass("vRadioActive");
});

checkboxClick = function() {
  $(this).click();
}

let form_login_open = 0;
$(document).on('click', ".vueLoginOpen", function() {
  form_login_open += 1;
  Shiny.setInputValue("vueFormLoginOpen", form_login_open);
})

let form_login_trials = 0;
$(document).on('click', "#vueLoginSubmit", function() {
  let user = $("#vueLoginUser").val();
  let password = $("#vueLoginPassword").val();
  form_login_trials += 1;
  console.log(user);
  console.log(password);
  
  Shiny.setInputValue("vueFormLoginSubmit", {
    user: user,
    password: password,
    submits: form_login_trials
  });
})

let form_logout = 0;
$(document).on('click', "#vueFormLogout", function() {
  form_logout += 1;
  Shiny.setInputValue("vueFormLogout", form_logout);
  console.log("pups")
  $('#shiny-modal').modal('hide');
})
let pushVueFormLoginButton = 0;

$(document).on('click', '.vueLoginButton', function() {  
  pushVueFormLoginButton += 1;
  Shiny.setInputValue(id="pushVueFormLoginButton", pushVueFormLoginButton);
});

$(document).on('click', '#vueLoginConfirm', function() {  
  console.log("Absenden geklickt");
});

$(document).on('click', '#Sonstiges', function() {  
  
  if ($('#Sonstiges').is(":checked")) {         
        $('#textarea_q2').removeAttr('disabled');
        $('#textarea_q2').css('background-color', '#fff');  
    } else {     
       $('#textarea_q2').attr('disabled','disabled');
       $('#textarea_q2').css('background-color', '#cccccc'); 
    }
   }
);

$(document).on('click', '#Sonstiges_q3', function(){  
  if ($('#Sonstiges_q3').is(":checked")) {         
        $('#textarea_q3').removeAttr('disabled');
        $('#textarea_q3').css('background-color', '#fff');   
    } else {       
       $('#textarea_q3').attr('disabled','disabled');
       $('#textarea_q3').css('background-color', '#cccccc'); 
    } 
   }
);

$(document).on('click', "input[id$='geholfen_q3']", function(){  
   
    if ($("input[id$='geholfen_q3']").is(":checked")) {         
            $('#textarea2_q3').css('display', 'inline-block');
            
        } else {       
            $('#textarea2_q3').css('display','none'); 
        }   
    }
);

$(document).on('click', '.form-submit', function(){

    /* Question1 */
    let question1 = $(this)
                        .closest('.modal')
                        .find("ul[id='Question1']")
                        .find("li[class$='vFormActive']")
                        .text(); 

    /* Question2 */
    let question2 = $(this)
                        .closest('.modal')
                        .find("label.container-checkbox")
                        .find("input[type=checkbox]:checked").map(function(){return $(this).val()}).get()
    
    /* Question2TextArea */
    let question2TextArea = $(this)
                                .closest('.modal')
                                .find("div[id='Question2']")
                                .find("textarea")
                                .val(); 
    /* Question3 */
    let question3 = $(this)
                        .closest('.modal')
                        .find("ul[id='Question3']")
                        .find("li[class$='vRadioActive']")
                        .text();

    /* Question3a */
    let question3a = $(this)
                        .closest('.modal')
                        .find("div[id='q3_additions']")
                        .find("input[type=checkbox]:checked").map(function(){return $(this).val()}).get()                        

    /* Question3aTextArea */
    let question3aTextArea = $(this)
                                .closest('.modal')
                                .find("div[id='Question3']")
                                .find("textarea[id='textarea_q3']")
                                .val(); 

    /* Question3b */
    let question3b = $(this)
                                .closest('.modal')
                                .find("textarea[id='textarea2_q3']")
                                .val(); 
    /* Question4 */
    let question4 = $(this)
                        .closest('.modal')
                        .find("ul[id='Question4']")
                        .find("li[class$='vFormActive']")
                        .text(); 

    /* Question5 */
    let question5 = $(this)
                        .closest('.modal')
                        .find("ul[id='Question5']")
                        .find("li[class$='vRadioActive']")
                        .text();

    /* Question6 */
    let question6 = $(this)
                        .closest('.modal')
                        .find("ul[id='Question6']")
                        .find("li[class$='vRadioActive']")
                        .text(); 

    /* Question7*/
    let question7 = $(this)
                        .closest('.modal')
                        .find("textarea[v-model='Question7']")
                        .val(); 

    /* Question8*/
    let question8 = $(this)
                        .closest('.modal')
                        .find("textarea[v-model='Question8']")
                        .val(); 

    /* Question9 */
    let question9 = $(this)
                        .closest('.modal')
                        .find("ul[id='Question9']")
                        .find("li[class$='vRadioActive']")
                        .text(); 

    /* Question9a */
    let question9a = $(this)
                        .closest('.modal')
                        .find("ul[id='Question9a']")
                        .find("li[class$='vFormActive']")
                        .text(); 

    /* Question1 */
    let question9b = $(this)
                        .closest('.modal')
                        .find("ul[id='Question9b']")
                        .find("li[class$='vFormActive']")
                        .text(); 

    /* Question1 */
    let question9c = $(this)
                        .closest('.modal')
                        .find("ul[id='Question9c']")
                        .find("li[class$='vFormActive']")
                        .text(); 

    /* Question10*/
    let question10 = $(this)
    .closest('.modal')
    .find("textarea[v-model='Question10']")
    .val(); 

    /* Question11*/
    let question11 = $(this)
                        .closest('.modal')
                        .find("textarea[v-model='Question11']")
                        .val(); 

    /* Send it back to shiny */
    Shiny.setInputValue("form_results", {question1: question1,
                                         question2: question2,
                                         question2TextArea: question2TextArea,
                                         question3: question3,
                                         question3a: question3a,
                                         question3aTextarea: question3aTextArea,
                                         question3b: question3b,
                                         question4: question4,
                                         question5: question5,
                                         question6: question6,
                                         question7: question7,
                                         question8: question8,
                                         question9: question9,
                                         question9a: question9a,
                                         question9b: question9b,
                                         question9c: question9c,
                                         question10: question10,
                                         question11: question11,
                                         nonce: Math.random()})

});
