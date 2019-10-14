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
<script src='/tmdmodel/webservice/js/TMService.js'></script>

<!-- Bootstrap core JavaScript-->
<script src="/tmdmodel/vendor/jquery/jquery.min.js"></script>
<script src="/tmdmodel/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin JavaScript-->
<script src="/tmdmodel/vendor/jquery-easing/jquery.easing.min.js"></script>
<!-- waiting for plugin -->
<script src="/tmdmodel/vendor/waiting/bootstrap-waitingfor.js"></script>
<script>
function speakCaptcha()
{
alert("Cpatcha");
}
function clearDiv(option)
{
if(option==1)
{
var x=document.getElementById("emailErrorDiv");
x.innerHTML=""
document.getElementById("emailId").className="form-control";
return;
}
document.getElementById("passwordErrorDiv").innerHTML=""
document.getElementById("password").className="form-control";
}
function changeCaptcha()
{
document.getElementById('captcha').src = document.getElementById('captcha').src+ '?' +new Date();
return false;
}

function processLoginForm()
{
var loginForm=$("#loginForm");
var emailAddress=loginForm.find("#emailId");
var password=loginForm.find("#password");
var captcha=loginForm.find("#captchaCode");
var errors=0;
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
if(errors!=0)return false;
else 
{
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
errors=0;
memberServiceManager.authenticateCaptcha(captcha.val(),function(success)
{
if(success)
{
return true;
}
else
{
changeCaptcha();
captcha.addClass("is-invalid");
errors=1;
return false;
}
},
function(faliure)
{
errors=1;
return false;
});
}
if(errors!=0)return false;
}

</script>
</head>


<body class="bg-light">
<div class="container" >
<form id='loginForm' autocomplete='off' method='post' action='/tmdmodel/webservice/memberService/memberLoginFormAuthenticator' onsubmit='return processLoginForm()' novalidate>
<div class="card  mx-auto mt-3" style="width:500px;">
<div class="card-header">Member Login</div>
<div class="card-body">
<div class='form-group has-error' id='memberInformationGroup'>
<div class='form-group' id='emailAddressGroup'>
<div class='form-row'>
<div class='col-md-12'>
<div class='form-label-group'>
<input type='text' name='argument-1' id='emailId' placeholder='emailAddress' required='required' scope='request' property='className' class='form-control ${errorBean.className}' onfocus=clearDiv(1)>
<label for='emailId'>Email Address</label>
<div class="invalid-feedback" id='emailErrorDiv'>${errorBean.emailId}</div>
</div>
</div>
</div>	
</div>
<div class='form-group' id='passwordGroup'>
<div class='form-row'>
<div class='col-md-12'>
<div class='form-label-group'>
<input type='password' name='argument-2' id='password' placeholder='Password' required='required' scope='request' property='className' class='form-control ${errorBean.className}' onfocus=clearDiv(2)>
<label for='password'>Password</label>
<div class="invalid-feedback" id='passwordErrorDiv'>${errorBean.password}</div>
</div>
</div>
</div>
</div>



<div class='form-group' id='captchaGroup'>
<div class='form-row'>
<div class='col-md-6' >
<div class='form-label-group'>
<img src='/tmdmodel/webservice/captcha'  id='captcha' style="width:220px;height:100px;" />
</div>
</div>

<div class='col-md-1 mt-3' >
<div class='form-label-group'>
<img src="/tmdmodel/images/refreshIcon.png" onclick=changeCaptcha()  />
<i class="fa fa-volume-up" style="padding-top:26px;" onclick=speakCaptcha()></i>
</div>
</div>
</div>
</div>


<div class='form-group' id='captchaGroup'>
<div class='form-row'>
<div class='col-md-12'>
<div class='form-label-group'>
<input type='text' id='captchaCode' placeholder='Captcha' required='required' class='form-control'>
<label for='captchaCode'>Captcha</label>
<div class="invalid-feedback" id='captchaCode'>Wrong captcha</div>
</div>
</div>
</div>
</div>

<div class='form-group' id='notAMemberGroup'>
<div class='form-row'>
<div class='col-md-12'>
<div class='form-label-group'>
<span><a href="/tmdmodel/register.jsp">Not a member Sign-Up</a></span>
</div>
</div>
</div>
</div>
<input type='submit' class="btn btn-primary btn-block" value='Login'>
</form>

</body>
</html>