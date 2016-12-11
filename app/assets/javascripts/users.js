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
  
    //collect the credit card fields
    var ccNum = $('#card_number').val(),
        cvcNum = $('#card_code').val(),
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();
    
    //send the info to stripe
    Stripe.createToken({
      number: ccNum,
      cvc: cvcNum,
      exp_month: expMonth,
      exp_year: expYear
      }, stripeResponseHandler)
  });
  
  //we should get back a card token
  //inject card token as a hidden field
  //submit form to our rails app
});