function List()
{
}
function TMForward()
{
}
function Project()
{
this.title="";
this.dateOfCreation=null;
this.timeOfCreation=null;
this.numberOfTable=0;
this.canvasHeight=0;
this.canvasWidth=0;
this.databaseArchitecture=null;
}
function LinkedList()
{
}
function ProjectServiceManager()
{
this.genrateScript=function(argument1,successHandler,exceptionHandler)
{
service.postJSON('projectService/generateScript',{
'argument-1': argument1
},
function(result){
successHandler(result);
},function(exception){
exceptionHandler(exception);
});
}
this.loadProject=function(argument1,successHandler,exceptionHandler)
{
service.postJSON('projectService/loadProject',{
'argument-1': argument1
},
function(result){
successHandler(result);
},function(exception){
exceptionHandler(exception);
});
}
this.saveProject=function(argument1,argument2,successHandler,exceptionHandler)
{
service.postJSON('projectService/saveProject',{
'argument-1': argument1,
'argument-2': argument2
},
function(result){
successHandler(result);
},function(exception){
exceptionHandler(exception);
});
}
this.createZip=function(argument1,argument2,successHandler,exceptionHandler)
{
service.postJSON('projectService/createZip',{
'argument-1': argument1,
'argument-2': argument2
},
function(result){
successHandler(result);
},function(exception){
exceptionHandler(exception);
});
}
this.createProject=function(argument1,argument2,successHandler,exceptionHandler)
{
service.postJSON('projectService/createProject',{
'argument-1': argument1,
'argument-2': argument2
},
function(result){
successHandler(result);
},function(exception){
exceptionHandler(exception);
});
}
this.openProject=function(argument1,successHandler,exceptionHandler)
{
service.postJSON('projectService/openProject',{
'argument-1': argument1
},
function(result){
successHandler(result);
},function(exception){
exceptionHandler(exception);
});
}
}
var projectServiceManager=new ProjectServiceManager();
