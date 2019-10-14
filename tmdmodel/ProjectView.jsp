<%@ taglib prefix="tm"  uri="/WEB-INF/tlds/c.tld" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>SB Admin - Dashboard</title>
    <!-- Bootstrap core CSS-->
    <link href="/tmdmodel/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom fonts for this template-->
<link rel="stylesheet" href="/tmdmodel/vendor/fontawesome-free/css/fontawesome1.min.css"   type="text/css">
<link href="/tmdmodel/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <!-- Page level plugin CSS-->
    <link href="/tmdmodel/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
    <!-- Custom styles for this template-->
    <link href="/tmdmodel/css/sb-admin.css" rel="stylesheet">
<script src='/tmdmodel/webservice/js/TMService.js'></script>
<script src='/tmdmodel/webservice/js/projectService.js'></script>
<script>
function XDatabaseTable()
{
this.note="";
this.x;
this.y;
this.fields=null;
this.name=" ";
var engine;
this.engine=new DatabaseEngine();
this.databaseTableRelationships=new Array();
}
function Project()
{
this.title=" ";
this.dateOfCreation=null;
this.timeOfCreation=null;
this.numberOfTable=0;
this.canvasHeight=0;
this.canvasWidth=0;
this.databaseArchitecture=null;
}
function TMForward()
{
}
function ProjectServiceManager()
{
this.generateScript=function(argument1,successHandler,exceptionHandler)
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
}
var projectServiceManager=new ProjectServiceManager();
</script>
<script> 
function copyScript()
{
var textArea=document.getElementById("scriptTextarea");
textArea.select();
document.execCommand("copy");

}

function getCanvasImage()
{
var canvas=document.getElementById("myCanvas");
var context = canvas.getContext("2d");
context.fillStyle="#FFFFFF";
context.fillRect(0, 0,canvas.width,canvas.height);
context.fillStyle="#00000";
databaseTables.forEach(function(element){
element.draw();
});
var image=canvas.toDataURL("image/jpg");
var x=document.getElementById("downloadImage");
x.href=image;
x.download=document.getElementById("getProjectTitle").innerHTML.trim();

context.fillStyle= "";
}
function changeDropdown()
{ 
var dropdownButton=document.getElementById('dataTypesList');
var value=dropdownButton.value.toUpperCase();

document.getElementById("autoIncrement").disabled=false;
document.getElementById("editSectionAutoIncrement").disabled=false;
if(value=="INT"||value=="SMALLINT"||value=="BIGINT"||value=="MEDIUMINT")
{
document.getElementById("autoIncrement").disabled=false;
document.getElementById("editSectionAutoIncrement").disabled=false;
}
else
{
document.getElementById("autoIncrement").disabled=true;
document.getElementById("editSectionAutoIncrement").disabled=true;

}

}

function processProjectForm()
{
var projectForm=$('#projectModalForm');
var title=projectForm.find('#projectTitle');
var dropDown=projectForm.find('#dropdownButton');
var errors=0;
if((title.val().trim()).length==0||title.val()==null)
{
errors++;
title.addClass("is-invalid");
title.focus();
}
else
{
title.removeClass("is-invalid");
}
if((dropDown.val().trim()).length==0||dropDown.val()==null||(dropDown.val()).upper()=='DATABASE ARCHITECTURE')
{
errors++;
dropDown.addClass("is-invalid");
dropDown.focus();
}
else
{
dropDown.removeClass("is-invalid");
}
if(errors==0)
{
return true;
}
else 
{
return false;
}
return false;
}
</script>
<script>
var databaseTableRelationshipNames=new Array();
var databaseTables=new Array();
var databaseTableNames=new Array();
var databaseTableRelationships=new Array();
var dummyTableFields=[ ];
var selectedColumn;
var selectedTable;
var tbody;
var canvas;
var selectedTr=null;
var count=0;
var x1;
var y1;
var mode=null;
var rect;
var tableForDelete;
function createTableMode(a)
{
selectedColumn=a;
a.style.border='solid #CDD0EC';
a.style.borderRadius='5px';
mode='CREATETABLE';
addCanvasListener();
}
function addCanvasListener()
{
canvas=document.getElementById('myCanvas');
canvasContext=canvas.getContext("2d");
canvas.addEventListener('mousedown',mouseDown);
canvas.addEventListener('contextmenu',function(event)
{
event.preventDefault();
});
}
function changeMode(typeOfMode)
{
mode=typeOfMode.toUpperCase();
addCanvasListener();
}
function mouseDown(event)
{
rect=canvas.getBoundingClientRect();
x1=event.clientX-rect.left
y1=event.clientY - rect.top;
//canvas.height=rect.bottom-rect.top;
//canvas.width=rect.right-rect.left;
if(mode!=null&&mode=='CREATETABLE')
{
var name;
if(databaseTableNames==null||databaseTableNames.length==0)
{
count++;
name='Table'+count;
databaseTableNames.push(name);
}
else
{
count++;
name='Table'+count;
databaseTableNames.forEach(function (element){
for(var i=0;i<databaseTableNames.length;i++)
{
if(name==databaseTableNames[i])
{
name='Table'+(i+1);
count++;
break;
}
}
});
databaseTableNames.push(name);
}

var tableComponent=new TableComponent(x1,y1,name);
databaseTables.push(tableComponent);
}
databaseTables.forEach(function(element)
{
checkTableOverflow(element);
});
canvasContext.clearRect(0, 0, canvasContext.canvas.width, canvasContext.canvas.height);
databaseTables.forEach(function(element)
{
var a=element.getX();
var b=element.getY();
var e=a+element.getWidth();
var f=b+element.getHeight();
if((x1<=e && y1<=f)&& (x1>=a && y1>=b) && (f>y1))
{
selectedTable=element;
tableForDelete=element;
}
element.draw();
});
if(mode=='CREATETABLE')removeSelection();
selectedTable=null;
}

function DatabaseTableField()
{
var name;
var width;
var isPrimaryKey;
var isNotNull;
var isUnique;
var isAutoIncrement;
var checkConstraint;
var note;
var defaultValue;
var numberOfDecimalPlaces;
var databaseArchitectureDataType;
this.name=" ";
this.width=0;
this.isPrimaryKey=false;
this.isNotNull=false;
this.isUnique=false;
this.isAutoIncrement=false;
this.checkConstraint=" ";
this.note=" ";
this.defaultValue=" ";
this.numberOfDecimalPlaces=0;
this.databaseArchitectureDataType=new DatabaseArchitectureDataType();
}
function DatabaseArchitectureDataType()
{
var dataType;
this.dataType="";
}
function DatabaseEngine()
{
var code;
var name;
var architectureCode;
this.code=0;
this.name="InnoDB";
this.architectureCode=0;
}
function DatabaseTableRelationship()
{
var name;
var parentTable;
var parentTableField;
var childTable;
var childTableFields;
this.name;
this.childTable;
this.parentTable;
this.parentTableField;
this.childTableFields=new Array();
}
function DatabaseTable(name)
{
var tableFields;
var fieldCount;
var name;
var note;
var databaseEngine;
this.databaseEngine=new DatabaseEngine();
var databaseTableRelationships;
this.databaseTableRelationships=new Array();
this.note="";
this.tableFields=[];
this.name=name;
this.fieldCount=0;
}

function TableComponent(x,y,name)
{
var databaseTable;
this.databaseTable=new DatabaseTable(name);
var drawableTable;
this.drawableTable=new DrawableTable(x,y,this.databaseTable);
this.getX=function()
{
return this.drawableTable.x;
}
this.getY=function()
{
return this.drawableTable.y;
}
this.getHeight=function()
{
return this.drawableTable.height;
}
this.getWidth=function()
{
return this.drawableTable.width;
}
this.draw=function()
{
this.drawableTable.draw();
}
}
function DrawableTable(x,y,databaseTable)
{
var x;
var y;
this.x=x;
this.y=y;
var height;
var width;
this.height=100;
this.width=100;
var formedStrings;
this.formedStrings=[];
var databaseTable;
this.databaseTable=databaseTable;
var heightDifference;
this.heightDifference=20;
var tableNameWidth;
this.tableNameWidth=100;
var THIS=this;
this.draw=function()
{
canvasContext.fillStyle="#000000";
canvasContext.lineJoin="round";
canvasContext.lineWidth=1.5;	
if(THIS.databaseTable.fieldCount!=0&&THIS.databaseTable.fieldCount!=null)
{
THIS.height=THIS.heightDifference;
THIS.tableNameWidth=Math.floor(canvasContext.measureText(databaseTable.name).width);
var maxWidth=calculateMaximumWidth();
if(maxWidth>THIS.tableNameWidth)THIS.width=maxWidth+8;
else THIS.width=THIS.tableNameWidth+8;
}
else
{
this.height=100;
this.width=100;
THIS.tableNameWidth=Math.floor(canvasContext.measureText(databaseTable.name).width);
if(THIS.tableNameWidth>THIS.width)THIS.width=THIS.tableNameWidth+8;
}
canvasContext.beginPath();
canvasContext.moveTo(THIS.x,THIS.y+THIS.heightDifference);
canvasContext.lineTo(THIS.x+THIS.width,THIS.y+THIS.heightDifference);
canvasContext.font = "16px Arial";
if(THIS.tableNameWidth<=100)canvasContext.fillText(THIS.databaseTable.name,(THIS.x+THIS.width/2-25),(THIS.y+THIS.heightDifference-4));
else canvasContext.fillText(THIS.databaseTable.name,(THIS.x+5),(THIS.y+THIS.heightDifference-4));
if(THIS.databaseTable.fieldCount!=0&&THIS.databaseTable.fieldCount!=null)
{
for(var i=0;i<THIS.formedStrings.length;i++)
{
THIS.height=THIS.height+THIS.heightDifference;
canvasContext.moveTo(THIS.x,THIS.y+THIS.height);
canvasContext.lineTo(THIS.x+THIS.width,THIS.y+THIS.height);
canvasContext.font = "16px Arial";
canvasContext.fillText(THIS.formedStrings[i],THIS.x+3,THIS.y+THIS.height-4);
canvasContext.stroke();
}
THIS.formedStrings=[];
}

if(mode==null&&selectedTable!=undefined &&THIS.databaseTable.name.toUpperCase()==selectedTable.databaseTable.name.toUpperCase())
{
canvasContext.fillStyle ="#DAE1E2  "; 

canvasContext.fillRect(THIS.x-1,THIS.y, THIS.width+1,20);
canvasContext.fillStyle = "#000000";

if(THIS.tableNameWidth<=100)canvasContext.fillText(THIS.databaseTable.name,(THIS.x+THIS.width/2-25),(THIS.y+THIS.heightDifference-4));
else canvasContext.fillText(THIS.databaseTable.name,(THIS.x+5),(THIS.y+THIS.heightDifference-4));

canvasContext.fillRect(THIS.x-3,THIS.y-3, 5,5);

canvasContext.fillRect(THIS.x+THIS.width-2,THIS.y-3, 5,5);
canvasContext.fillRect(THIS.x-3,THIS.y+THIS.height-1, 5,5);
canvasContext.fillRect(THIS.x+THIS.width-2,THIS.y+THIS.height-1, 5,5);
canvasContext.rect(THIS.x,THIS.y,THIS.width,THIS.height);
}
else
{
canvasContext.rect(THIS.x,THIS.y,THIS.width,THIS.height);
canvasContext.stroke();
}
canvasContext.closePath();
canvasContext.stroke();
}
function calculateMaximumWidth()
{
var f=[];
var temp;
var tableField;
var formedString;
var databaseTableRealtionship;
for(var i=0;i<THIS.databaseTable.tableFields.length;i++)
{
canvasContext.font = "16px Arial";
tableField=THIS.databaseTable.tableFields[i];
databaseTableRelationships=THIS.databaseTable.databaseTableRelationships;
formedString=tableField.name+" "+tableField.databaseArchitectureDataType.dataType;
if(tableField.width!=0)formedString=formedString+"("+tableField.width+")";
if(tableField.isPrimaryKey)formedString=formedString+" "+"PK";
if(tableField.isNotNull)formedString=formedString+" "+"NN";
if(tableField.isAutoIncrement)formedString=formedString+" "+"Inc";

if(databaseTableRelationships!=null && databaseTableRelationships!=undefined && databaseTableRelationships.length!=0)
{
databaseTableRelationships.forEach(
function(relationship){
if(relationship.childTable.trim()==THIS.databaseTable.name.trim())
{

var field=relationship.childTableFields;

field.forEach(function(f){
if(f.trim()==tableField.name.trim())
{
formedString=formedString+" "+"FK";
}
});
}
});
}
var j=Math.floor(canvasContext.measureText(formedString).width);
f.push(j);
THIS.formedStrings.push(formedString);
}
var largest=f[0];
for (var i=1;i<f.length; i++)
{
if(largest < f[i] )
{
largest = f[i];
}
}
return largest;
}
}
function checkTableOverflow(element)
{
if((element.getX()+element.getWidth())>canvas.width || (element.getY()+element.getHeight())>canvas.height)
{
if((element.getX()+element.getWidth())>canvas.width)
{
canvas.width=element.getX()+element.getWidth()+200;
document.getElementById('canvasDiv').style.overflowX="scroll";
}
if((element.getY()+element.getHeight())>canvas.height)
{
canvas.height=element.getY()+element.getHeight()+100;
document.getElementById('canvasDiv').style.overflowY="scroll";

}

}
if(mode!=null)document.getElementById('canvasDiv').scroll({
  top:element.getY(),
  left:element.getX(),
  behavior: 'smooth' 
});

}



function saveProject(save)
{
var project=new Project();
var dummyList=[];
var xd
databaseTables.forEach(function(element)
{
xd=new XDatabaseTable();
xd.x=element.getX();
xd.y=element.getY();
xd.name=element.databaseTable.name;
xd.note=element.databaseTable.note;
xd.engine=element.databaseTable.databaseEngine;
xd.fields=element.databaseTable.tableFields;
xd.fields.databaseArchitectureDataType=element.databaseTable.tableFields.databaseArchitectureDataType;
if(element.databaseTable.databaseTableRelationships.length!=0)
{
xd.databaseTableRelationships=element.databaseTable.databaseTableRelationships;

}
dummyList.push(xd);
});
var k=document.getElementById('getProjectTitle').innerHTML;
var c=document.getElementById('myCanvas');
project.title=k;
dummyList.forEach(function(element){
element.fields.forEach(function(e){
});
});
project.canvasHeight=c.height;
project.canvasWidth=c.width;
project.numberOfTable=dummyList.length;
$('#closeProjectModal').modal("hide");
waitingDialog.show("Saving project......");
setTimeout(function(){
projectServiceManager.saveProject(project,dummyList,function(success){


},function(failure){
});
waitingDialog.hide();
if(!save)
{
setTimeout(function(){
window.location.assign('http://localhost:8080/tmdmodel/homePage.jsp');
},1000);
}
},2000);

}

function deleteTable(event)
{
if(event.keyCode==46)
{
var table;
var index=null;
for(index=0;index<databaseTables.length;index++)
{
table=databaseTables[index].databaseTable;
if(tableForDelete.databaseTable.name==table.name)
{
break;
}
}
if(index!=null)
{
databaseTables.splice(index,1);
canvasContext.clearRect(0, 0, canvasContext.canvas.width, canvasContext.canvas.height);
if(databaseTables.length!=0)
{
databaseTables.forEach(function(element)
{
element.draw();
});
}

}

}
}

function openTableProperties(event)
{
var x=event.clientX-rect.left;
var y=event.clientY-rect.top;
databaseTables.forEach(function(element){
var a=element.getX();
var b=element.getY();
var e=a+element.getWidth();
var f=b+element.getHeight();
if((x<e && y<f)&& (x>=a && y>=b) && f>y)
{
selectedTable=element;
var tbody=document.getElementById('tableBody');
var tr;
var td1,td2,td3,td4,td5,td6;
var field;
var a1,a2;
document.getElementById("tableName").value=element.databaseTable.name;
if(element.databaseTable.tableFields.length!=0)
{
for(var i=0;i<element.databaseTable.tableFields.length;i++)
{
field=element.databaseTable.tableFields[i];

tr=document.createElement('tr');
td1=document.createElement('td');
td2=document.createElement('td');
td3=document.createElement('td');
td4=document.createElement('td');
td5=document.createElement('td');
td6=document.createElement('td');
td1.innerHTML=i+1;
td2.innerHTML=field.name;
if(field.width!=0)
{
td3.innerHTML=field.databaseArchitectureDataType.dataType+'('+field.width+')';
}
else
{
td3.innerHTML=field.databaseArchitectureDataType.dataType;
}
var constraints=' ';
if(field.isUnique)
{
constraints='UNN';
}
if(field.isNotNull)
{
constraints=constraints+" "+"NN";
}
if(field.isPrimaryKey)
{
constraints=constraints+" "+" PK";
}
if(field.isAutoIncrement)
{
constraints=constraints+" "+"Inc";
}
var databaseTableRelationships=element.databaseTable.databaseTableRelationships;
databaseTableRelationships.forEach(function(relation){
var x=relation.childTableFields;
if(field.name==x)constraints=constraints+" FK";
});


td4.innerHTML=constraints;
td5.innerHTML='F';

a1=document.createElement('img');
a1.style.zIndex=1;
a1.src='/tmdmodel/images/edit.png';
a1.style.height='20px';
a1.style.width='20px';
a1.onclick = (function() {
var current= td2.innerHTML;
return function() { 
editEntity(current);
}
})();

a2=document.createElement('img');
a2.style.zIndex=2;
a2.src="/tmdmodel/images/delete.png";
a2.style.height='20px';
a2.style.width='20px';
a2.onclick=(function(){
var current= td2.innerHTML;
return function() 
{ 
deleteEntity(current);
}})();
var v=document.createElement("td");
v.appendChild(a1);
td6.appendChild(v);
v=document.createElement("td");
v.appendChild(a2);

td6.appendChild(v);
tr.appendChild(td1);
tr.appendChild(td2);
tr.appendChild(td3);
tr.appendChild(td4);
tr.appendChild(td5);
tr.appendChild(td6);
tbody.appendChild(tr);
}
}
$('#changeTablePropertiesModal').modal(
{
backdrop:'static',
keyboard:false,
});
$("#changeTablePropertiesModal").appendTo("body");
}
});

}

function AddEntity()
{
var databaseTableField=new DatabaseTableField();
var databaseArchitectureDataType=new DatabaseArchitectureDataType();
var entity=document.getElementById('AttributeName');
var dataType=document.getElementById('dataTypesList');
var attributeSize=document.getElementById('AttributeLength');
var isUnique=document.getElementById('unique');
var isNotNull=document.getElementById('notNull');
var isPrimaryKey=document.getElementById('primaryKey');
var isAutoIncrement=document.getElementById('autoIncrement');
var engine=document.getElementById("enginesList");
var tableName=document.getElementById("tableName").value.trim();
var errors=0;
if(tableName!=null&&tableName!=undefined&&tableName.length!=0)selectedTable.databaseTable.name=tableName;
var fields=selectedTable.databaseTable.tableFields;
if(dataType.value==null||dataType.value.length==0)
{
errors++;
}
else
{
databaseTableField.databaseArchitectureDataType.dataType=dataType.value.trim();
}
if(entity.value.trim().length==0||entity==null)
{
entity.className+="  is-invalid";
errors++;
return;
}
else
{
databaseTableField.name=entity.value.trim();
}
databaseTableField.width=attributeSize.value.trim();
selectedTable.databaseTable.databaseEngine.name=engine.value.trim();
if(errors>0)return;
databaseTableField.isUnique=isUnique.checked;
databaseTableField.isNotNull=isNotNull.checked;
databaseTableField.isPrimaryKey=isPrimaryKey.checked;
databaseTableField.isAutoIncrement=isAutoIncrement.checked;
var tbody=document.getElementById('tableBody');
var tr,td1,td2,td3,td4,td5,td6;
tr=document.createElement('tr');
td1=document.createElement('td');
td2=document.createElement('td');
td3=document.createElement('td');
td4=document.createElement('td');
td5=document.createElement('td');
td6=document.createElement('td');
var count=selectedTable.databaseTable.fieldCount;
if(count==0)
{
count=count+1;
td1.innerHTML=count;
}
else{
td1.innerHTML=count+1;
}
td2.innerHTML=entity.value.trim();
if(attributeSize.value!=0)
{
td3.innerHTML=dataType.value.trim()+'('+attributeSize.value.trim()+')';
}
else
{
td3.innerHTML=dataType.value.trim();
}
var constraints=' ';
if(isUnique.checked)
{
constraints='UNN';
}
if(isNotNull.checked)
{
constraints=constraints+" "+"NN";
}
if(isPrimaryKey.checked)
{
constraints=constraints+" "+" PK";
}
if(isAutoIncrement.checked)
{
constraints=constraints+" "+"Inc";
}
td4.innerHTML=constraints;
td5.innerHTML='F';
tr.appendChild(td1);
tr.appendChild(td2);
tr.appendChild(td3);
tr.appendChild(td4);
tr.appendChild(td5);
var a1=document.createElement('img');
a1.src="/tmdmodel/images/edit.png";
a1.style.height='20px';
a1.style.width='20px';
a1.onclick = (function() {
var currentI = td2.innerHTML;
return function(){ 
editEntity(currentI);
}
})();
var a2=document.createElement('img');
a2.src='/tmdmodel/images/delete.png';
a2.style.height='20px';
a2.style.width='20px';
a2.onclick = (function() {
var currentI = td2.innerHTML;
return function() 
{ 
deleteEntity(currentI);
}
})();

var v=document.createElement("td");
v.appendChild(a1);
td6.appendChild(v);
v=document.createElement("td");
v.appendChild(a2);

td6.appendChild(v);
tr.appendChild(td6);
tbody.appendChild(tr);
entity.value=null;
var tableComponent=selectedTable;
tableComponent.databaseTable.fieldCount++;
tableComponent.databaseTable.tableFields.push(databaseTableField);	
isUnique.checked=false;
isNotNull.checked=false;
isAutoIncrement.checked=false;
isPrimaryKey.checked=false;
attributeSize.value=0;
dataType.value='Bit';
databaseTables.forEach(function(element)
{
checkTableOverflow(element);
});
canvasContext.clearRect(0, 0, canvasContext.canvas.width, canvasContext.canvas.height);
databaseTables.forEach(function(element)
{
element.draw();
});
entity.className="form-control";
}
function deleteEntity(entity)
{
var table=null;
var tableBody=document.getElementById('tableBody');
for(var k=0;k<databaseTables.length;++k)
{
table=databaseTables[k];
if(selectedTable.databaseTable.name==table.databaseTable.name)
{
var fields=table.databaseTable.tableFields;
var field;
var index=0;
for(;index<fields.length;index++)
{
field=fields[index];
if(field.name==entity)
{
break;
}
}
if(field.isPrimaryKey==true)
{
document.getElementById('primaryKey').disabled=false;
}
table.databaseTable.tableFields.splice(index,1);
var trToDelete=null;
var childrens=tableBody.children;
var tdList;
for(var p=0;p<childrens.length;p++)
{
tdList=childrens[p].children;
if(tdList[1].innerHTML==entity)
{
trToDelete=childrens[p];
break;
}
if(trToDelete!=null)
{
break;
}
}
tableBody.removeChild(trToDelete);
canvasContext.clearRect(0, 0, canvasContext.canvas.width, canvasContext.canvas.height);
databaseTables.forEach(
function(tableComponent){
tableComponent.draw();
});
return;
}
}
}

function closeTable()
{
var tableName=document.getElementById("tableName");
var errors=0;
tableName.className="form-control";
if(tableName.value.length==0||tableName==null)
{
tableName.className+='is-invalid';
errors++;
}


databaseTables.forEach(
function(element)
{
if(element.databaseTable.name==tableName.value && selectedTable.databaseTable.name!=tableName.value)
{
tableName.className+=' is-invalid';
document.getElementById("tableNameError").innerHTML="Table:"+element.databaseTable.name+"exists";
errors++;
}
});
if(errors>0)return;

canvasContext.clearRect(0, 0, canvasContext.canvas.width, canvasContext.canvas.height);
databaseTables.forEach(
function(element)
{
if(element.databaseTable.name==selectedTable.databaseTable.name)
{
element.databaseTable.name=tableName.value;
}
});

databaseTables.forEach(function(element){
element.draw();
});

$('#changeTablePropertiesModal').modal("hide");
var table=document.getElementById('attributeDataTable');
table.removeChild(document.getElementById('tableBody'));
var c=document.createElement('tbody')
c.setAttribute("id","tableBody");
table.appendChild(c);
selectedTable=null;
}

function editEntity(name)
{
var v=document.getElementById("forEdit");
v.innerHTML=name;
changeViewOfModal();
}
function changeViewOfModal()
{
var name=document.getElementById("forEdit").innerHTML;
var attributeName=document.getElementById("editSectionAttributeName");
attributeName.value=name;
document.getElementById("addSection").style.display="none";
document.getElementById("editSection").style.display="block";
var table=null;
var field=null;
for(var k=0;k<databaseTables.length;++k)
{
table=databaseTables[k];
if(selectedTable.databaseTable.name==table.databaseTable.name)
{
var fields=table.databaseTable.tableFields;
var index=0;
for(;index<fields.length;index++)
{
field=fields[index];
if(field.name==name)
{
break;
}
}
if(field.isPrimaryKey==true)
{
document.getElementById('editSectionPrimaryKey').checked=true;
}
if(field.isUnique==true)
{
document.getElementById('editSectionUnique').checked=true;
}
if(field.isNotNull==true)
{
document.getElementById('editSectionNotNull').checked=true;
}
if(field.isAutoIncrement==true)
{
document.getElementById('editSectionAutoIncrement').checked=true;
}
}
}
document.getElementById("editSectionDataTypesList").value=field.databaseArchitectureDataType.dataType;
}

function vEditEntity()
{
var name=document.getElementById("forEdit").innerHTML;
var table=null;
var databaseTableField;
var databaseArchitectureDataType;
var entity;
var dataType;
var attributeSize;
var isUnique;
var isNotNull;
var isPrimaryKey;
var isAutoIncrement;
for(var k=0;k<databaseTables.length;++k)
{
table=databaseTables[k];
if(selectedTable.databaseTable.name==table.databaseTable.name)
{
var fields=table.databaseTable.tableFields;
var field;
var index=0;
for(;index<fields.length;index++)
{
field=fields[index];
if(field.name==name)
{
databaseTableField=new DatabaseTableField();
databaseArchitectureDataType=new DatabaseArchitectureDataType();
entity=document.getElementById('editSectionAttributeName');
dataType=document.getElementById('editSectionDataTypesList');
attributeSize=document.getElementById('editSectionAttributeLength');
isUnique=document.getElementById('editSectionUnique');
isNotNull=document.getElementById('editSectionNotNull');
isPrimaryKey=document.getElementById('editSectionPrimaryKey');
isAutoIncrement=document.getElementById('editSectionAutoIncrement');
var engine=document.getElementById("enginesList");
if(dataType!=null)
{
databaseArchitectureDataType.dataType=dataType.value;
}
databaseTableField.name=entity.value;
if(attributeSize.value!=0)
{
databaseTableField.width=attributeSize;
}
if(isUnique.checked)
{
databaseTableField.isUnique=true;
}
if(isNotNull.checked)
{
databaseTableField.isNotNull=true;
}
if(isPrimaryKey.checked)
{
databaseTableField.isPrimaryKey=true;
}
if(isAutoIncrement.checked)
{
databaseTableField.isAutoIncrement=true;
}
databaseTableField.databaseArchitectureDataType=databaseArchitectureDataType;
var databaseEngine=new DatabaseEngine();
databaseEngine.name=engine.value;
databaseTables[k].databaseTable.databaseEngine=databaseEngine;
databaseTables[k].databaseTable.tableFields[index]=databaseTableField;

}
}
}
}

var tableBody=document.getElementById('tableBody');
var tr,td1,td2,td3,td4,td5,td6;
tr=document.createElement('tr');
td1=document.createElement('td');
td2=document.createElement('td');
td3=document.createElement('td');
td4=document.createElement('td');
td5=document.createElement('td');
td6=document.createElement('td');
var trToDelete=null;
var childrens=tableBody.children;
var tdList;
for(var p=0;p<childrens.length;p++)
{
tdList=childrens[p].children;
if(tdList[1].innerHTML==name)
{
trToDelete=childrens[p];
break;
}
if(trToDelete!=null)
{
break;
}
}

tableBody.removeChild(trToDelete);
td1.innerHTML=childrens.length;
td2.innerHTML=databaseTableField.name;
if(attributeSize.value!=0)
{
td3.innerHTML=dataType.value+'('+attributeSize.value+')';
}
else
{
td3.innerHTML=dataType.value;
}
var constraints=' ';
if(isUnique.checked)
{
constraints='UNN';
}
if(isNotNull.checked)
{
constraints=constraints+" "+"NN";
}
if(isPrimaryKey.checked)
{
constraints=constraints+" "+" PK";
}
if(isAutoIncrement.checked)
{
constraints=constraints+" "+"Inc";
}
td4.innerHTML=constraints;
td5.innerHTML="F";

var a1=document.createElement('img');
a1.src="/tmdmodel/images/edit.png";
a1.style.height='20px';
a1.style.width='20px';
a1.onclick = (function() {
var currentI = td2.innerHTML;
return function(){ 
editEntity(currentI);
}
})();
var a2=document.createElement('img');
a2.src="/tmdmodel/images/delete.png";
a2.style.height='20px';
a2.style.width='20px';
a2.onclick = (function() {
var currentI = td2.innerHTML;
return function() 
{ 
deleteEntity(currentI);
}
})();
var v=document.createElement("td");
v.appendChild(a1);
td6.appendChild(v);
v=document.createElement("td");
v.appendChild(a2);

td6.appendChild(v);
tr.appendChild(td1);
tr.appendChild(td2);
tr.appendChild(td3);
tr.appendChild(td4);
tr.appendChild(td5);
tr.appendChild(td6);

tableBody.appendChild(tr);
canvasContext.clearRect(0, 0, canvasContext.canvas.width, canvasContext.canvas.height);
databaseTables.forEach(
function(tableComponent){
tableComponent.draw();
});


var attributeName=document.getElementById("editSectionAttributeName");
attributeName.value=" ";
document.getElementById("addSection").style.display="block";
document.getElementById("editSection").style.display="none";
document.getElementById('editSectionPrimaryKey').checked=false;
document.getElementById('editSectionUnique').checked=false;
document.getElementById('editSectionNotNull').checked=false;
document.getElementById('editSectionAutoIncrement').checked=false;
document.getElementById("editSectionDataTypesList").value="Data types";


return;
}




function removeSelection()
{
if(selectedColumn!=null)
{
selectedColumn.style.border='none';
selectedColumn.style.borderRadius='none';
mode=null;
}
selectedTable=null;
}

function loadMyProject()
{
mode='CREATETABLE';
var projectTitle=document.getElementById("getProjectTitle").innerHTML;
service.postJSON('projectService/loadProject',{
'argument-1': projectTitle
},
function(result){
var project=result;
canvas=document.getElementById('myCanvas');

if(project.canvasWidth==0 || project.canvasHeight==0)
{
canvas.width=1290;
document.getElementById('canvasDiv').style.overflowX="scroll";
canvas.height=690;
document.getElementById('canvasDiv').style.overflowY="scroll";
}
var tables=project.tables;

var tableCompnent;
tables.forEach(function(table)
{
tableComponent=new TableComponent(table.x,table.y,table.name);
tableComponent.databaseTable.databaseEngine=table.engine;
var field;
table.fields.forEach(function(vField)
{
field=new DatabaseTableField();
field.name=vField.name;
field.width=vField.width;
field.isPrimaryKey=vField.isPrimaryKey;
field.isNotNull=vField.isNotNull;
field.isUnique=vField.isUnique;
field.isAutoIncrement=vField.isAutoIncrement;
field.checkConstraint=vField.checkConstraint;
field.note=vField.note;
field.defaultValue=vField.defaultValue;
field.numberOfDecimalPlaces=vField.numberOfDecimalPlaces;
field.databaseArchitectureDataType=vField.databaseArchitectureDataType;
tableComponent.databaseTable.fieldCount++;
tableComponent.databaseTable.tableFields.push(field);
});
if(table.databaseTableRelationships.length!=0)
{
tableComponent.databaseTable.databaseTableRelationships=table.databaseTableRelationships;
table.databaseTableRelationships.forEach(
function(e){
});
}
databaseTables.push(tableComponent);
});
canvasContext=canvas.getContext("2d");
databaseTables.forEach(function(element)
{
checkTableOverflow(element);
});
databaseTables.forEach(function(vTableComponent)
{
vTableComponent.draw();
databaseTableNames.push(vTableComponent.databaseTable.name);
});

mode=null;
addCanvasListener();
},function(exception){
alert(exception)
});

}
function generateScript()
{
var div=document.getElementById("tablesNameList");
var  input;
var label;
databaseTables.forEach(function(tableComponent)
{
input=document.createElement("input");
input.setAttribute("type","checkbox");
input.className="form-check-input";
input.style.borderRadius="50px";
input.setAttribute("id",tableComponent.databaseTable.name);
label=document.createElement("label");
label.setAttribute("for",tableComponent.databaseTable.name);
label.className="form-check-label";
label.innerHTML=tableComponent.databaseTable.name;
div.appendChild(input);
div.appendChild(label);
div.appendChild(document.createElement("br"));
div.appendChild(document.createElement("br"));
});
$('#generateScript').modal(
{
backdrop:'static',
keyboard:false
});
$("#generateModal").appendTo("body");
}

function closeScriptModal()
{
var divToDelete=document.getElementById("tablesNameList");
var parentDiv=document.getElementById("tablesNameListContainer");
parentDiv.removeChild(divToDelete);
var divToAdd=document.createElement("div");
divToAdd.setAttribute("id","tablesNameList");
divToAdd.className="form-check";
parentDiv.appendChild(divToAdd);
$('#generateScript').modal("hide");
}

function collectTableName()
{
var v=document.getElementById("tablesNameList").children;
var input;
var label;
var tableNameList=[];
var tableList=[];
for(var i=0;i<v.length;i=i+4)
{
input=v[i];
label=v[i+1];
if(input.checked==true)
{
tableNameList.push(label.innerHTML);
}
}

var table;
for(var i=0;i<tableNameList.length;i++)
{
var x;
databaseTables.forEach(function(element){
if(element.databaseTable.name==tableNameList[i])
{
x=new XDatabaseTable();
x.note=element.databaseTable.note;
x.x=element.databaseTable.x;
x.y=element.databaseTable.y;
if(element.databaseTable.databaseTableRelationships.length!=0)x.databaseTableRelationships=element.databaseTable.databaseTableRelationships;
if(element.databaseTable.tableFields.length!=0)x.fields=element.databaseTable.tableFields;
else x.fields=new Array();
x.name=element.databaseTable.name;
x.engine=element.databaseTable.databaseEngine;
tableList.push(x);
}
});
}
$('#generateScript').modal("hide");
waitingDialog.show("Generating script......");
setTimeout(function(){
projectServiceManager.generateScript(tableList,function(success){

waitingDialog.hide();
var x=JSON.stringify(success);
x=x.replace(/tereName/g,"\n");
x=x.substring(1,x.length-1);
setTimeout(function(){
document.getElementById("scriptTextarea").innerHTML=x;
$('#testingScriptModal').modal({
backdrop:'static',
keyboard:false
});
$("#testingScriptModal").appendTo("body");
}
,2000)
},
function(exception)
{
alert(JSON.stringify(exception));
});
}
,3000);
}

function closeProject()
{
$('#closeProjectModal').modal({
backdrop:"static",
keyboard:false
});
}



function createRelationship()
{
var databaseTableRelationship=new DatabaseTableRelationship();
var relationship=document.getElementById("relationshipTextArea");
var tableName=document.getElementById("tableName");
var v;
var tableIndex=0;
var isInvalid=false;

var table,fields,field;
var i=0;
var fieldError;

try 
{
v=JSON.parse(relationship.value);
}
catch(error) 
{
relationship.style.color="#EB3003";
return;
}
if(v.parentTable==undefined||v.parentTable==null||v.parentTable.length==0)
{
relationship.style.color="#EB3003";
return;
}
if(v.parentTableField==undefined||v.parentTableField==null||v.parentTableField.length==0)
{
relationship.style.color="#EB3003";
return;
}
if(v.childTableFields==undefined||v.childTableFields==null||v.childTableFields.length==0)
{
relationship.style.color="#EB3003";
return;
}
if(v.name==undefined||v.name==null||v.name.length==0)
{
relationship.style.color="#EB3003";
return;
}
databaseTableRelationshipNames.forEach(function(name){
if(name==v.name)
{
isInvalid=true;
}});
if(isInvalid)
{
relationship.style.color="#EB3003";
return;
}
isInvalid=false;

fieldError=true;
for(i=0;i<databaseTables.length;i++)
{
table=databaseTables[i].databaseTable;
if(table.name.trim()==tableName.value.trim())
{

tableIndex=i;
}
if(table.name.trim()==v.parentTable.trim())
{
fields=table.tableFields;
for(var j=0;j<fields.length;j++)
{
field=fields[j];

if(field.name.trim()==v.parentTableField.trim())
{
fieldError=false;
if(field.isPrimaryKey==false)
{
isInvalid=true;
}
}
}
}
}
if(fieldError)
{
relationship.style.color="#EB3003";
return;
}
if(isInvalid)
{
relationship.style.color="#EB3003";
return;
}
else
{
databaseTableRelationship.parentTable=v.parentTable;
databaseTableRelationship.name=v.name;
databaseTableRelationship.parentTableField=v.parentTableField;
databaseTableRelationship.childTable=tableName.value;
databaseTableRelationship.childTableFields=v.childTableFields;

if(isInvalid)
{
relationship.style.color="#EB3003";
return;
}
databaseTables[tableIndex].databaseTable.databaseTableRelationships.push(databaseTableRelationship);
}
relationship.value=" ";
canvasContext.clearRect(0, 0, canvasContext.canvas.width, canvasContext.canvas.height);
databaseTables.forEach(
function(tableComponent){
tableComponent.draw();
});
databaseTableRelationshipNames.push(v.name);
}

function textAreaInput()
{
document.getElementById("relationshipTextArea").style.color="";
}
function getPackageName()
{
$('#packageName').modal(
{
backdrop:"static",
keyboard:false
});
$("#packageName").appendTo("body");


}

function createZip()
{
var packageName=document.getElementById("packageNameValue");
packageName.className="form-control";
if(packageName.value==null|| packageName.value==undefined || packageName.value.length==0)
{
packageName.className+=" is-invalid";
return;
}

var tableList=[];
var x;
databaseTables.forEach(function(element){
x=new XDatabaseTable();
x.note=element.databaseTable.note;
x.x=element.databaseTable.x;
x.y=element.databaseTable.y;
if(element.databaseTable.databaseTableRelationships.length!=0)x.databaseTableRelationships=element.databaseTable.databaseTableRelationships;
if(element.databaseTable.tableFields.length!=0)x.fields=element.databaseTable.tableFields;
else x.fields=new Array();
x.name=element.databaseTable.name;
x.engine=element.databaseTable.databaseEngine;
tableList.push(x);
});


$('#packageName').modal("hide");
waitingDialog.show("Generating zip......");
setTimeout(function(){
projectServiceManager.createZip(tableList,packageName.value,function(success){
alert(JSON.stringify(success));
if(success)
{
var a = document.createElement("a");
document.body.appendChild(a);
a.style = "display: none";
a.href ="/tmdmodel/getZipFile";
a.click();
document.body.removeChild(a);
waitingDialog.hide();
}

},function(failure){
alert("fail"+"  "+JSON.stringify(failure));
}
);
},1000);


}

function DeleteRelationship()
{
var relationship=document.getElementById("createRelationshipTextArea");
var tableName=document.getElementById("tableName");
var v;
var tableIndex=0;
var isInvalid=false;
var table,fields,field;
var i=0;
var fieldError;
try 
{
v=JSON.parse(relationship.value);
}
catch(error) 
{
relationship.style.color="#EB3003";
return;
}
if(v.parentTable==undefined||v.parentTable==null||v.parentTable.length==0)
{
relationship.style.color="#EB3003";
return;
}
if(v.parentTableField==undefined||v.parentTableField==null||v.parentTableField.length==0)
{
relationship.style.color="#EB3003";
return;
}
if(v.childTableFields==undefined||v.childTableFields==null||v.childTableFields.length==0)
{
relationship.style.color="#EB3003";
return;
}
if(v.name==undefined||v.name==null||v.name.length==0)
{
relationship.style.color="#EB3003";
return;
}
databaseTableRelationshipNames.forEach(function(name){
if(name==v.name)
{
isInvalid=true;
}
});
if(isInvalid)
{
relationship.style.color="#EB3003";
return;
}
isInvalid=false;
databaseTables.forEach(function(element){
element.databaseTableRealtionships.forEach(function(relationship){
if(relationship.name==v.name.trim()&&relationship.parentTable==v.parentTable.trim()&&relationship.childTable==v.childTable.trim()&&relationship.parentTableField==v.parentTableField.trim())
{

for(var i=0;i<relationship.childTableFields.length;i++)
{
if(r==v.childTableField.trim())
{ 
index=i;
}
}
relationship.childTableFields.splice(index,1);
}
});
});
relationship.value="";
relationship.innerHTML="";
databaseTables.forEach(function(element){
element.draw();
});
}



function viewRelationship()
{
document.getElementById("addRelationshipDiv").style.display="none";
var textArea=document.getElementById("viewRelationshipTextArea");
document.getElementById("viewRelationshipDiv").style.display="block";
var tableName=document.getElementById("tableName");
textArea.innerHTML="&nbsp;";
databaseTables.forEach(function(element){
if(element.databaseTable.name==tableName.value)
{
var relations=element.databaseTable.databaseTableRelationships;
relations.forEach(function(relation)
{
textArea.innerHTML=textArea.innerHTML+"{&#13;&#10;"+"'name':";	
textArea.innerHTML=textArea.innerHTML+"'"+relation.name+"',&#13;&#10;";
textArea.innerHTML=textArea.innerHTML+"'parentTable':"+"'"+relation.parentTable+"'&#13;&#10;";
textArea.innerHTML=textArea.innerHTML+"'parentTableField':"+"'"+relation.parentTableField+"'&#13;&#10;";
textArea.innerHTML=textArea.innerHTML+"'childTableFields':"+JSON.stringify(relation.childTableFields)+"&#13;&#10;}&#13;&#10;";
});
}
});

}
window.addEventListener("load",loadMyProject);
</script>

<style>



.heading
{
color: grey;
left: 560px;
}
.canvasdiv
{ 
width:1310px;
height:720px;
}
.myCanvasClass
{
border:1px solid #000000;
}

</style>
</head>

<body id="page-top">
<nav class="navbar navbar-expand navbar-dark bg-dark static-top" style="height:40px;">
<a class="navbar-brand mr-1" href="index.html">Data modeler</a>

      <ul class="navbar-nav ml-auto ml-md-9">
      
        <li class="nav-item dropdown no-arrow">
          <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
         <i class="fas fa-user-circle fa-fw"></i>${member.firstName}
          </a>
          <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
            <a class="dropdown-item" href="#">Number of projects: ${member.numberOfProjects}</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#" onclick=closeProject()>Close project</a>
          
          </div>
        </li>
      </ul>

    </nav>




<nav class="navbar navbar-expand navbar-light bg-light static-top"   style="background-color:##AFB1C3;">
   <div class = "btn-toolbar" role = "toolbar">
         <div class="btn-group" role="group" aria-label="Basic example">
  <button type="button" class="btn btn-light">
<i class="fa fa-table"  style="font-size:30px;" onclick=createTableMode(this) data-toggle="tooltip" title="Creates a new table" ></i>
</button>
&nbsp;
<button type="button" class="btn btn-light" > <i class="far fa-save"  style="font-size:25px;" onclick=saveProject(true)  data-toggle="tooltip" title="Save current work"></i></button>
<button type="button" class="btn btn-light" > <i class="fa fa-file-code-o "  style="font-size:25px;" onclick=generateScript()  data-toggle="tooltip" title="Generates SQL statements"></i></button>
<button type="button" class="btn btn-light"><a href=" #" class="fa fa-file-image-o text-dark" aria-hidden="true"  style="font-size:25px;"  id='downloadImage'  download="Design.jpg"   onclick=getCanvasImage() data-toggle="tooltip" title="Download image"></a></button>
<button type="button" class="btn btn-light"><i class="fas fa-database"  style="font-size:25px;" title="Generates hibernate classes" data-toggle="tooltip"  data-target="#packageName" onclick=getPackageName()></i></button>

</div>	
</div>
</nav>


<div class="card ml-1 mr-1">
<div class="card-header "  style="height:20px;background-color:#A3A4B2;">
<button class="close" type="button" onclick=closeProject() aria-label="Close" style="position:absolute;left:1310px;top:0px;">
<span aria-hidden="true" class="text-white">×</span>
</button>

</div>
<div class="card-body">
<div class='row'>
<div class='col-md-12'>
<div id='canvasDiv'  class='canvasdiv'>
<canvas id='myCanvas' width='1240' height='690'   tabindex="1" ondblclick=openTableProperties(event) onkeyup=deleteTable(event)></canvas>
</div>
</div></div>
</div>
</div>
<!-- /.container-fluid -->

<!-- /#wrapper -->









<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog" role="document">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
<button class="close" type="button" data-dismiss="modal" aria-label="Close">
<span aria-hidden="true">×</span>
</button>
</div>
<div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
<div class="modal-footer">
<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
<a class="btn btn-primary" href="login.jsp">Logout</a>
</div>
</div>
</div>
</div>




<!--Close project modal-->
<div class="modal fade" id="closeProjectModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog" role="document">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title" id="closeProjectModalHeader">Would you like to save your project ?</h5>
<button class="close" type="button" data-dismiss="modal" aria-label="Close">
<span aria-hidden="true">×</span>
</button>
</div>
<div class="modal-body">Click on save to save your current work.</div>
<div class="modal-footer">
<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
<a class="btn btn-primary"  onclick=saveProject()>Save</a>
</div>
</div>
</div>
</div>






<!--Script modal 1-->
<div class="modal fade" id="generateScript" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered" role="document">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title" id="exampleModalLabel">Select tables.</h5>
<button class="close" type="button" onclick=closeScriptModal() aria-label="Close">
<span aria-hidden="true">×</span>
</button>
</div>
<div class="modal-body">
<div class='card'>
<div class='card-body' style="height:300px; overflow-y: scroll;">
<div class='form-row'>
<div class='col-md-5' id="tablesNameListContainer">
<div class="form-check" id="tablesNameList">
</div>
</div>
</div>
</div>
</div>
<div class="modal-footer">
<button class="btn btn-secondary" type="button" onclick=closeScriptModal()>Cancel</button>
<a class="btn btn-primary" href="#" onclick=collectTableName()>Generate</a>
</div>
</div>
</div>
</div>

<div class="modal fade" id="packageName" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-lg " role="document">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title" id="exampleModalLabel">Package name</h5>
<button class="close" type="button" data-dismiss="modal" aria-label="Close">
<span aria-hidden="true">×</span>
</button>
</div>
<div class="modal-body">
<div class='card'>
<div class="card-body ">
<div class='form-row'>
<div class='col-md-9' >
<input type='text' id='packageNameValue' placeholder='package' required='required' class='form-control'>
</div>
<div class='col-md-3 ' >
<input type='button' class="btn btn-primary"  value='Create zip'  onclick=createZip()>
</div>
</div>
</div>
</div>
<div class="modal-footer">
</div>
</div>
</div>
</div>



<!--Script modal 2-->
<div class="modal fade" id="testingScriptModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog-centered " style="width: 90%;height: 80%;margin: 0;padding-left:130px;padding-top:10px;" role="document">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title" id="exampleModalLabel">Generated script</h5>
<button class="close" type="button" data-dismiss="modal" aria-label="Close" onclick=closeScriptModal()>
<span aria-hidden="true" onclick=closeScriptModal()>×</span>
</button>
</div>
<div class="modal-body">
<div class='card'>
<div class="card-body ">

<div class='form-row'>
<div class='col-lg-*'>
<div class="form-group" id="scriptTextAreaContainer">
<div style="padding-left:970px;padding-bottom:10px;">
<button class="btn btn-secondary" onclick=copyScript()><i class="far fa-copy" data-toggle="tooltip" title="Copies script to clipboard."></i></button>
</div>

<textarea class="form-control rounded-3" id="scriptTextarea" rows="10" cols="200" style="font-size:20px; overflow:auto;resize:none;"  readonly></textarea>
</div>
</div>
</div>
</div>
</div>
<div class="modal-footer">
</div>
</div>
</div>
</div>



<div class="modal fade" id="changeTablePropertiesModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
<form action='/tmdmodel/webservice/projectService/openProject' id='projectModalForm' method='post' onsubmit='return processOpenProjectForm()' novalidate>
<div class="modal-dialog modal-lg"  role="document">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title" id="exampleModalLabel">Table Properties</h5>
<button class="close" type="button" data-dismiss="modal" aria-label="Close" onclick=closeTable()>
<span aria-hidden="true" >×</span>
</button>
</div>
<div class="modal-body ">
<div class='card mb-3'>
<div class='card-body' >
<div class='form-group' id='attributeNameGroup'>
<div class='form-label-group'>
<input type='text' id='tableName' placeholder='Name' required='required' class='form-control'>
<label for='tableName'>Table Name</label>
<div class="invalid-feedback" id="tableNameError">Table name required</div>
</div>
</div>
<div class='form-row'>
<div class='col-md-12'>
 <div class='card-header'>
 <ul class="nav nav-tabs">
    <li class=" nav-item">
      <a class="nav-link active" role="tab" data-toggle="tab" href="#attribute">Attributes</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" role="tab" data-toggle="tab" href="#engines">Options</a>
    </li>
  <li class="nav-item">
      <a class="nav-link" role="tab" data-toggle="tab" href="#relationship">Relationships</a>
    </li>
  </ul>
</div>
</div>
</div>

<div class="tab-content "  >
<div id='attribute' class='tab-pane active' >
<div style="height:auto;max-height:200px;overflow-y:scroll;">
<table id='attributeDataTable' class='table table-bordered' width="100%" cellspacing="0" >
<thead>
<tr>
<th>S.No</th>
<th>Fields</th>
<th>Type</th>
<th>Constraints</th>
<th>Default Check</th>
<th>Update/Delete</th>
</tr>
<tbody id='tableBody'>
</tbody>
</thead>
</table>
</div>
<br/>
<div id="addSection">
<div class='form-group' id='addentity'>
<input type='text' id='AttributeName' placeholder='Field name' required='required' class='form-control'>
</div>

<div class="form-group">
<div class="form-row">

<div class='col-md-3'>

<select class="form-control" id="dataTypesList" onchange=changeDropdown()>
<tm:forEach items='${architectures}' var='architecture'> 
<tm:forEach items='${architecture.databaseArchitectureDataTypes}' var='dt'>
<option ><a class="nav-link" href='#' >${dt.dataType}</a></option>
</tm:forEach>
</tm:forEach>
</select>
</div>

&nbsp;&nbsp;&nbsp;
<div class='col-md-2' style="padding:6px;">
<input class="form-control form-control-sm" placeholder='length' id='AttributeLength' type="number" value='0'; >
</div>

<div class='col-md-6 ml-auto'  >
<input type='checkbox' name='Primary key' id='primaryKey' ><span>Primary key</span>&nbsp;&nbsp;
<input type='checkbox' name='Auto-increment' id='autoIncrement' disabled ><span>Auto increment</span></br>
<input type='checkbox' name='Unique' id='unique'><span>Unique</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type='checkbox' name='Not Null' id='notNull'><span>Not Null</span></br>
</div>
</div>
</div>


<div class='form-group ml-2' >
<div class='form-row'>
<input type='button' class="btn btn-primary"  id="changeableButton"  value='Add' onclick=AddEntity()>
</div>
</div>
</div>
</div>

<div style="display:none;" id="editSection">
<div class='form-group' id='editEntitySection'   >
<input type='text' id='editSectionAttributeName' placeholder='Field name' required='required' class='form-control'>
</div>


<div class="form-group">
<div class="form-row">

<div class='col-md-3'>
<select class="form-control" id="editSectionDataTypesList" onchange=changeDropdown()>
<tm:forEach items='${architectures}' var='architecture'> 
<tm:forEach items='${architecture.databaseArchitectureDataTypes}' var='dt'>
<option ><a class="nav-link" href='#' >${dt.dataType}</a></option>
</tm:forEach>
</tm:forEach>
</select>
</div>

&nbsp;&nbsp;&nbsp;
<div class='col-md-2' style="padding:6px;">
<input class="form-control form-control-sm" placeholder='length' id='editSectionAttributeLength' type="number" value='0'; >
</div>
<div class='col-md-6 ml-auto'  >
<input type='checkbox' name='Primary key' id='editSectionPrimaryKey' ><span>Primary key</span>&nbsp;&nbsp;
<input type='checkbox' name='Auto-increment' id='editSectionAutoIncrement' disabled ><span>Auto increment</span></br>
<input type='checkbox' name='Unique' id='editSectionUnique'><span>Unique</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type='checkbox' name='Not Null' id='editSectionNotNull'><span>Not Null</span></br>
</div>
</div>
</div>

 
<div class='form-group ml-2' >
<div class='form-row'>
<input type='button' class="btn btn-primary"  id="editSectionChangeableButton"  value='Edit' onclick=vEditEntity() >
</div>
</div>
</div>





<div id='engines' class='tab-pane'>
<div class='dropdown'>
<div class='form-row'>

<div class='col-md-2 col-lg-2' > 
<label  style="padding:5px;">Engines</label>
<div class='form-label-group' style="padding-top:4px;" >
<select class="form-control " id="enginesList" >
<tm:forEach items='${architectures}' var='architecture'> 
<tm:forEach items='${architecture.databaseEngines}' var='engine'>
<option ><a href='#' ><tm:out value="${engine.name}"/></a></option>
</tm:forEach>
</tm:forEach>
</select>
</div>
</div>

<div class='form-row'>
<div class='col-md-* col-lg-*' style="padding:10px;"> 
<label for="tableNote">Note</label>
<textarea class="form-control rounded-3" id="tableNote" style="overflow:auto;resize:none;"  rows="9" cols="70" ></textarea>
</div>
</div>

</div>
</div>
</div>

<div id='relationship' class='tab-pane'>
<div class='form-row' id="addRelationshipDiv">
<div class='col-md-* col-lg-*' style="padding:10px;"> 
<label for="relationshipTextArea">Relationship</label>
<div class="invalid-feedback" id="addRelationshipError" ></div>
<textarea class="form-control rounded-3" id="relationshipTextArea" style="overflow:auto;resize:none;font-size:20px;"  rows="9" cols="100" onfocus=textAreaInput()></textarea>
</div>
</div>

<div class='form-row' id="viewRelationshipDiv" style="display:none;">
<div class='col-md-* col-lg-*' style="padding:10px;"> 
<label for="viewRelationshipTextArea" >Relationship</label>
<div class="invalid-feedback" id="viewRelationshipError"></div>
<textarea class="form-control rounded-3" id="viewRelationshipTextArea" style="overflow:auto;resize:none;font-size:20px;"  rows="9" cols="100" onfocus=textAreaInput() style="display:none'"></textarea>
</div>
</div>


<div class='form-row' id="deleteRelationshipDiv" style="display:none;">
<div class='col-md-* col-lg-*' style="padding:10px;"> 
<label for="deleteRelationshipTextArea" >Delete Relationship</label>
<div class="invalid-feedback" id="deleteRelationshipError"></div>
<textarea class="form-control rounded-3" id="deleteRelationshipTextArea" style="overflow:auto;resize:none;font-size:20px;"  rows="9" cols="100" onfocus=textAreaInput() style="display:none'"></textarea>
</div>
</div>



<div class='form-row'>
<div class='col-md-0 ml-2' > 
<input type='button' class="btn btn-primary"    value='Create' onclick=createRelationship() >
</div>

<div class='col-md-0 ml-2' > 
<input type='button' class="btn btn-primary"    value='View' onclick=viewRelationship() >
</div>

<div class='col-md-0 ml-2'' > 
<input type='button' class="btn btn-primary"    value='Delete'  onclick=deleteRelationship()>
</div>


</div>
</div>


</div>
</div>
</div>
</div>



<div class="modal-footer" >
<button class="btn btn-secondary" type="button"  onclick=closeTable()>Close</button>
<input type='button' class="btn btn-primary"  value='Ok'  onclick=closeTable()>
</div>
</div>
</div>
</form>
</div>




<span style='display:none;'  id='getProjectTitle' >${project.title}</span>
<span style='display:none;'  id='forEdit' >" "</span>


<!-- Bootstrap core JavaScript-->
<script src="/tmdmodel/vendor/jquery/jquery.min.js"></script>
<script src="/tmdmodel/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin JavaScript-->
<script src="/tmdmodel/vendor/jquery-easing/jquery.easing.min.js"></script>
<!-- Page level plugin JavaScript-->
<script src="/tmdmodel/vendor/datatables/jquery.dataTables.js"></script>
<script src="/tmdmodel/vendor/datatables/dataTables.bootstrap4.js"></script>
<script src="/tmdmodel/vendor/waiting/bootstrap-waitingfor.js"></script>
<!-- Custom scripts for all pages-->
<script src="/tmdmodel/js/sb-admin.min.js"></script>
<!-- Demo scripts for this page-->
<script src="/tmdmodel/js/demo/datatables-demo.js"></script>
<script>
$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip();   
});
</script>
<a href=" " id="downloadZip"></a>
</body>

</html>
