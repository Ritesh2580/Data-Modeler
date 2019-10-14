function TMForward()
{
}
function Member()
{
this.code=0;
this.firstName="";
this.lastName="";
this.address="";
this.password="";
this.mobileNumber="";
this.status="";
this.emailId="";
this.numberOfProjects=0;
}
function MemberServiceManager()
{
this.create=function(argument1,successHandler,exceptionHandler)
{
service.postJSON('memberService/add',{
'argument-1': argument1
},
function(result){
successHandler(result);
},function(exception){
exceptionHandler(exception);
});
}
this.authenticateCaptcha=function(argument1,successHandler,exceptionHandler)
{
service.postJSON('memberService/authenticateCaptcha',{
'argument-1': argument1
},
function(result){
successHandler(result);
},function(exception){
exceptionHandler(exception);
});
}
this.memberLoginFormAuthenticator=function(argument1,argument2,successHandler,exceptionHandler)
{
service.postJSON('memberService/memberLoginFormAuthenticator',{
'argument-1': argument1,
'argument-2': argument2
},
function(result){
successHandler(result);
},function(exception){
exceptionHandler(exception);
});
}
}
var memberServiceManager=new MemberServiceManager();
