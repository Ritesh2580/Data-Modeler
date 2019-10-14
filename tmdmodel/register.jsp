<jsp:useBean id='errorBean' scope='request' class='com.thinking.machines.dmodel.beans.ErrorBean' />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Member Signup</title>
<link href="/tmdmodel/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom fonts for this template-->
<link href="/tmdmodel/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<!-- Custom styles for this template-->
<link href="/tmdmodel/css/sb-admin.css" rel="stylesheet">
<!--<link href="/tmdmodel/site/css/styles.css" rel="stylesheet">-->
<script src='/tmdmodel/webservice/js/memberService.js'></script>
<script src='/tmdmodel/webservice/js/TMService.js'></script><script>
function changeCaptcha()
{
document.getElementById('captcha').src = document.getElementById('captcha').src+ '?' +new Date();
}
function processSignUpForm()
{
var signUpForm=$("#signUpForm");
var firstName=signUpForm.find("#firstName");
var lastName=signUpForm.find("#lastName");
var emailAddress=signUpForm.find("#emailAddress");
var mobileNumber=signUpForm.find("#mobileNumber");
var password=signUpForm.find("#password");
var rePassword=signUpForm.find("#rePassword");
var captcha=signUpForm.find("#captchaCode");
var errors=0;
if((firstName.val().trim()).length==0||firstName.val()==null)
{
firstName.addClass("is-invalid");
errors++;
firstName.focus();
}
else
{
firstName.removeClass("is-invalid");
}
if((lastName.val().trim()).length==0||lastName.val()==null)
{
lastName.addClass("is-invalid");
errors++;
lastName.focus();
}
else
{
lastName.removeClass("is-invalid");
}
if((emailAddress.val().trim()).length==0||emailAddress.val()==null)
{
emailAddress.addClass("is-invalid");
errors++;
emailAddress.focus();
}
else
{
emailAddress.removeClass("is-invalid");
}
if((mobileNumber.val().trim()).length==0||mobileNumber.val()==null)
{
mobileNumber.addClass("is-invalid");
errors++;
mobileNumber.focus();
}
else
{
mobileNumber.removeClass("is-invalid");
}
if((password.val().trim()).length==0||password.val()==null)
{
password.addClass("is-invalid");
errors++;
password.focus();
}
else
{
password.removeClass("is-invalid");
}
if((rePassword.val().trim()).length==0||rePassword.val()==null)
{
rePassword.addClass("is-invalid");
errors++;
rePassword.focus();
}
else
{
rePassword.removeClass("is-invalid");
}

if(password.val()!=rePassword.val())
{
errors++;
password.addClass("is-invalid");
rePassword.addClass("is-invalid");
}
if((captcha.val().trim()).length==0||captcha.val()==null)
{
captcha.addClass("is-invalid");
errors++;
captcha.focus();
}
else
{
captcha.removeClass("is-invalid");
}

if(!(errors==0))
{
var e=errors+"hai";
}
else
{
memberServiceManager.authenticateCaptcha(captcha.val(),function(success)
{
if(success)
{
var member=new Member();
member.firstName=firstName.val();
member.lastName=lastName.val();
member.emailId=emailAddress.val();
member.mobileNumber=mobileNumber.val();
member.password=password.val();
memberServiceManager.create(member,function(success){
window.location.assign('http://localhost:8080/tmdmodel/login.jsp');

},function(faliure)
{

});

}
else
{
captcha.addClass("is-invalid");
changeCaptcha();
}
},
function(faliure)
{

});
}

}
</script>
</head>
<body class="bg-light">
<div class="container">
<div class="card card-register mx-auto mt-5">
<div class="card-header">Signup</div>
<div class="card-body">
<form id='signUpForm' novalidate>
<div class="card card-register mx-auto mt-1">
<div class="card-header">Member Information</div>
<div class="card-body">
<div class='form-group has-error' id='memberInformationGroup'>
<div class='form-row'>
<div class='col-md-6'>
<div class='form-label-group'>
<input type='text' id='firstName' class='form-control ${errorBean.className}'  placeholder='First name' required='required' autofocus='autofocus'>
<label for='firstName'>First name</label>
<div class="invalid-feedback">First name required</div>
</div>
</div>
<div class='col-md-6'>
<div class='form-label-group'>
<input type='text' id='lastName' class='form-control ${errorBean.className}' placeholder='Last name' required='required' autofocus='autofocus'>
<label for='lastName'>Last name</label>
<div class="invalid-feedback" >Last name required</div>
</div>
</div>
</div>
</div>
<div class='form-group' id='emailAddressGroup'>
<div class='form-label-group'>
<input type='text' id='emailAddress' placeholder='Email address' required='required' class='form-control ${errorBean.className}'>
<label for='emailAddress'>Email address</label>
<div class="invalid-feedback">Email address required</div>
</div>
</div>
<div class='form-group' id='mobileNumberGroup'>
<div class='form-label-group'>
<input type='number' id='mobileNumber' placeholder='mobileNumber' required='required' class='form-control ${errorBean.className}'>
<label for='mobileNumber'> Mobile number</label>
<div class="invalid-feedback">Mobile number required</div>
</div>
</div>
<div class='form-group' id='passwordGroup'>
<div class='form-row'>
<div class='col-md-6'>
<div class='form-label-group'>
<input type='text' id='password' placeholder='password' required='required' class='form-control ${errorBean.className}'>
<label for='password'>Password</label>
<div class="invalid-feedback" id='passwordDiv'>Password required</div>
</div>
</div>
<div class='col-md-6'>
<div class='form-label-group'>
<input type='text' id='rePassword' placeholder='Re-enter password' required='required' class='form-control' >
<label for='rePassword'>Confirm password</label>
<div class="invalid-feedback" id='rePasswordDiv'>Re-Password required</div>
</div>
</div>
</div>
</div>

<div class='form-group' id='captchaGroup'>
<div class='form-row'>
<div class='col-md-5' >
<div class='form-label-group'>
<img src='/tmdmodel/webservice/captcha' id='captcha' style="width:220px;height:100px;" />
</div>
</div>
<div class='col-md-1 mt-3' >
<div class='form-label-group'>
<img src="/tmdmodel/images/refreshIcon.png" onclick=changeCaptcha()  />
<i class="fa fa-volume-up" style="padding-top:26px;" onclick=speakCaptcha()></i>
</div>
</div>

<div class='col-md-6 ml-auto' " style="padding-top:20px;">
<div class='form-label-group'>
<input type='text' id='captchaCode' placeholder='Captcha' required='required' class='form-control'>
<label for='captchaCode'>Captcha</label>
<div class="invalid-feedback" id='captchaCode'>Wrong captcha</div>
</div>

</div>
</div>


</div>
</div>
<button type='button' onclick='processSignUpForm()' class="btn btn-primary btn-block">Register</button>
</form>
</div>
</div>
</div>
<!-- Bootstrap core JavaScript-->
<script src="/tmdmodel/vendor/jquery/jquery.min.js"></script>
<script src="/tmdmodel/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin JavaScript-->
<script src="/tmdmodel/vendor/jquery-easing/jquery.easing.min.js"></script>
<!-- Page level plugin JavaScript-->
<script src="/tmdmodel/vendor/datatables/jquery.dataTables.js"></script>
<script src="/tmdmodel/vendor/datatables/dataTables.bootstrap4.js"></script>
<!-- Custom scripts for all pages-->
<script src="/tmdmodel/js/sb-admin.min.js"></script>
<!-- Demo scripts for this page-->
<script src="/tmdmodel/js/demo/datatables-demo.js"></script>
</body>
</html>