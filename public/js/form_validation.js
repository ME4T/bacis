$(document).ready(function() {

    $('.new_event').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        live: 'enabled',
        fields: {
            "event[title]": {
                message: 'The title is not valid',
                validators: {
                    notEmpty: {
                        message: 'The title is required and cannot be empty'
                    }
                }
            },
            "event[description_input]": {
                message: 'The description is not valid',
                validators: {
                    notEmpty: {
                        message: 'The description is required and cannot be empty'
                    }
                }
            },
            "event[website]":{
                message: 'The URL is not valid. Ensure presence of http://',
                validators: {
                    uri: {
                        message: 'The URL is not valid.'
                    }
                }                
            },
            "event[facebook_url]":{
                message: 'The URL is not valid. Ensure presence of http://',
                validators: {
                    uri: {
                        message: 'The URL is not valid.'
                    }
                }                
            },
            "event[twitter_url]":{
                message: 'The URL is not valid. Ensure presence of http://',
                validators: {
                    uri: {
                        message: 'The URL is not valid.'
                    }
                }                
            }

        }
    });
    $('form#contact').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        live: 'enabled',
        fields: {
            "email": {
                message: 'The title is not valid',
                validators: {
                    notEmpty: {
                        message: 'The title is required and cannot be empty'
                    },emailAddress: {
                        message: 'The value is not a valid email address'
                    }
                }
            },
            "contents": {
                message: 'The description is not valid',
                validators: {
                    notEmpty: {
                        message: 'The description is required and cannot be empty'
                    }
                }
            }

        }
    });
    $('form.edit_user').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        live: 'enabled',
        fields: {
            "user[username]": {
                message: 'The username is not valid',
                validators: {
                    notEmpty: {
                        message: 'Username is required'
                    }
                   
                }
            },
            "user[email]": {
                message: 'The email is not valid',
                validators: {
                    notEmpty: {
                        message: 'Email is required'
                    }
                }
            },
            "user[password]": {
                message: 'The password is not valid',
                validators: {
                    stringLength:{
                        min: 6,
                        max: 128,
                        message: 'Password must be between 6 and 128 characters long.'

                    }
                }
            },
            "user[password_confirmation]": {
                message: 'The password confirmation is not valid',
                validators: {
                    identical: {
                        field: 'user[password]',
                        message: 'The password and its confirmation are not the same'
                    }
                }
            },
            "user[current_password]": {
                message: 'The password confirmation is not valid',
                validators: {
                    notEmpty: {
                        message: 'Current Password is required in order to make any changes.'
                    }
                }
            }

        }
    });


    $('.registration form').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        live: 'enabled',
        fields: {
            "user[username]": {
                message: 'The username is not valid',
                validators: {
                    notEmpty: {
                        message: 'Username is required'
                    },
                    remote:{
                        message: "That username is already taken",
                        url: "/users/username_exists.json",
                        data: function(validator){
                            return{
                                "username": validator.getFieldElements('user[username]').val()
                            }
                        }
                    }
                   
                }
            },
            "user[email]": {
                message: 'The email is not valid',
                validators: {
                    notEmpty: {
                        message: 'Email is required'
                    },
                    remote:{
                        message: "That email is already taken.",
                        url: "/users/email_exists.json",
                        data: function(validator){
                            return{
                                "email": validator.getFieldElements('user[email]').val()
                            }
                        }
                    }
                }
            },
            "user[password]": {
                message: 'The password is not valid',
                validators: {
                    notEmpty: {
                        message: 'Password is required'
                    },stringLength:{
                        min: 6,
                        max: 128,
                        message: 'Password must be between 6 and 128 characters long.'

                    }
                }
            },
            "user[password_confirmation]": {
                message: 'The password confirmation is not valid',
                validators: {
                    notEmpty: {
                        message: 'Password confirmation is required'
                    },
                    identical: {
                        field: 'user[password]',
                        message: 'The password and its confirmation are not the same'
                    }
                }
            }

        }
    });

    var isOnline = $(".is-online input").is(':checked');

    if(isOnline){
        $(".location-wrap").hide();
    }else{
        $(".location-wrap").show();
    }

    $(".is-online input").on("change", function(e){
        var $currentTarget = $(e.currentTarget);
        var isOnlineChecked = $currentTarget.is(':checked');
        if(isOnlineChecked){
            $(".location-wrap").hide();
        }else{
            $(".location-wrap").show();

        }

    });

    $('.input-group.date').datepicker({
        startDate: ""+new Date()+"",
        todayHighlight: true
    });
    // $('body').on('focus', '#wysiwyg', function() {
    //     var $this = $(this);
    //     $this.data('before', $this.html());
    //     return $this;
    // }).on('blur keyup paste input', '#wysiwyg', function() {
    //     var $this = $(this);
    //     if ($this.data('before') != $this.html()) {
    //         $this.data('before', $this.html());
    //         $this.trigger('change');
    //     }
    //     return $this;
    // });

    // $("#wysiwyg").on("change", function(e){
    //     var foo = $("#wysiwyg").html();
    //     $("#wysiwyg").cleanHtml();
    //     $("#wysiwyg").val(foo);
    //     console.log($("#wysiwyg").val());

    //     $("#hidden-desc").val(foo);
    //     $("#hidden-desc").trigger("change");
    // });
});