// <!-- jQuery Form Validation code -->

  // When the browser is ready...
  $(function() {
  
    // Setup form validation on the #register-form element
    $("form").validate({
    
        // Specify the validation rules
        rules: {
            projectName:{
                RegExp:true,
            required:true},
            estimatedStartDate: {
            required:true,
             date:true},
            estimatedEndDate: {
            required:true,
             date:true},
            projectDescription: "required",
            priorityID: "required"
        },
        
        // Specify the validation error messages
        messages: {
            projectName :{
            required: "Should not be blank"
            },
            estimatedStartDate: {
            required: "Should not be blank",
            date: "Please enter Date "
        },
            estimatedEndDate: {
            required: "Should not be blank",
            date: "Please enter Date "
        },
           
            projectDescription: {
            required: "Should not be blank"
        },
            priorityID: {
            required: "Should not be blank"
        }
        },
        
        submitHandler: function(form) {
            form.submit();
        }
    });
       
 
jQuery.validator.addMethod("RegExp", function(value, element) {
  return this.optional(element) || /^[a-zA-Z0-9]+$/.test(value);
}, "Please Enter Characters");
 });
