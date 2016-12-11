/* global $, Stripe */
//document ready
$(document).on('turbolinks:load', function(){
  var theForm = $('#pro_form');
  var submitBtn = $('#form-submit-btn');

  //set stripe public key
  Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') );
  
  //when user clicks submit prevent default action
  submitBtn.click(function(event){
    event.preventDefault();
    submitBtn.val("Processing").prop('disable', true);
  
    //collect the credit card fields
    var ccNum = $('#card_number').val(),
        cvcNum = $('#card_code').val(),
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();
    
    //use stripe library to check for card errors
    var error = false;
    
    //validate card number
    if(!Stripe.card.validateCardNumber(ccNum)){
      error = true;
      alert('The credit card number appears to be invalid.');
    }
    
    //validate cvc number
    if(!Stripe.card.validateCVC(cvcNum)){
      error = true;
      alert('The CVC number appears to be invalid.');
    }
    
    //Validate expiry date
    if(!Stripe.card.validateExpiry(expMonth, expYear)){
      error = true;
      alert('The expiration date appears to be invalid.');
    }
    
    if (error) {
      //if there are card errors, dont send to stripe
      submitBtn.prop('disabled', false).val("Sign Up");
    } else {
      //send the info to stripe
      Stripe.createToken({
        number: ccNum,
        cvc: cvcNum,
        exp_month: expMonth,
        exp_year: expYear
        }, stripeResponseHandler);
    }
    return false;
  });
  
  //we should get back a card token
  function stripeResponseHandler(status, response) {
    //get token from response
    var token = response.id;
  
    //inject card token as a hidden field
    theForm.append( $('<input type="hidden" name="user[stripe_card_token]">').val(token) );
    
    //submit form to our rails append
    theForm.get(0).submit();
  }
});