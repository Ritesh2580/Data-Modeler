package com.thinking.machines.dmodel.services;
import com.thinking.machines.dmodel.services.pojo.*;
import com.thinking.machines.dmframework.*;
import com.thinking.machines.dmodel.beans.*;
import com.thinking.machines.dmodel.utility.*;
import com.thinking.machines.tmws.annotations.*;
import com.thinking.machines.tmws.*;
import com.thinking.machines.tmws.captcha.*;
import com.thinking.machines.dmframework.exceptions.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.text.SimpleDateFormat;
import com.fasterxml.jackson.databind.ObjectMapper.*;
import com.fasterxml.jackson.core.type.TypeReference.*;
import com.google.common.base.CaseFormat;
import java.io.*;
import java.util.zip.*;


@Path("/projectService")
public class ProjectService
{
private HttpSession httpSession;
private ServletContext servletContext;
private List<com.thinking.machines.dmodel.bl.Project> blProjects;
private HttpServletRequest httpServletRequest;
private HttpServletResponse httpServletResponse;

public ProjectService()
{
this.httpSession=null;
this.httpServletRequest=null;
this.httpServletResponse=null;
this.blProjects=new LinkedList<>();
}
public void setServletContext(ServletContext servletContext)
{
this.servletContext=servletContext;
}
public void setHttpRequest(HttpServletRequest httpServletRequest)
{
this.httpServletRequest=httpServletRequest;
}
public void setHttpSession(HttpSession httpSession)
{
this.httpSession=httpSession;
}
public void setHttpResponse(HttpServletResponse httpServletResponse)
{
this.httpServletResponse=httpServletResponse;
}

@Post
@InjectApplication
@InjectSession
@Path("createProject")
public TMForward createProject(String title,String databaseArchitecture)
{
long millis;
List<com.thinking.machines.dmodel.dl.DatabaseArchitecture> vDatabaseArchitecture;
List<com.thinking.machines.dmodel.bl.DatabaseArchitecture> blDatabaseArchitectures;
Boolean isDuplicate=false;
java.sql.Date d;
java.sql.Time t;
try
{
if(title.length()==0||title==null)
{
return new TMForward("/homePage.jsp");
}
if(databaseArchitecture.length()==0||databaseArchitecture==null||databaseArchitecture.equals("DATABASE"))
{
return new TMForward("/homePage.jsp");
}


List<com.thinking.machines.dmodel.dl.Project> c=new LinkedList<>();

com.thinking.machines.dmodel.dl.Member member=(com.thinking.machines.dmodel.dl.Member)this.httpSession.getAttribute("member");
DataManager dataManager=new DataManager();
dataManager.begin();
c=dataManager.select(com.thinking.machines.dmodel.dl.Project.class).where("memberCode").eq(member.getCode()).query();
dataManager.end();

if(c.size()!=0)
{
for(com.thinking.machines.dmodel.dl.Project p:c)
{
if(p.getTitle().trim().equalsIgnoreCase(title.trim()))
{
isDuplicate=true;
}
}
}

if(isDuplicate)
{
return new TMForward("/homePage.jsp");
}
millis=System.currentTimeMillis(); 
com.thinking.machines.dmodel.bl.Project blProject=new com.thinking.machines.dmodel.bl.Project();
blProject.setTitle(title);
d=new java.sql.Date(millis);
blProject.setDateOfCreation(d);
t=new java.sql.Time(millis);
blProject.setTimeOfCreation(t);
blProject.setNumberOfTable(0);
blProject.setCanvasHeight(0);
blProject.setCanvasWidth(0);
blDatabaseArchitectures=(List<com.thinking.machines.dmodel.bl.DatabaseArchitecture>)this.servletContext.getAttribute("architectures");
com.thinking.machines.dmodel.bl.DatabaseArchitecture bldba=null;

if(blDatabaseArchitectures.size()!=0)
{
for(com.thinking.machines.dmodel.bl.DatabaseArchitecture dba:blDatabaseArchitectures)
{
if(((dba.getName()).trim()).equalsIgnoreCase(databaseArchitecture))
{
bldba=dba;
}
}
}
this.blProjects=(List<com.thinking.machines.dmodel.bl.Project>)this.httpSession.getAttribute("memberProjects");

blProject.setDatabaseArchitecture(bldba);
this.blProjects.add(blProject);
this.httpSession.setAttribute("blProjects",blProjects);
this.httpSession.removeAttribute("memberProjects");
this.httpSession.setAttribute("memberProjects",blProjects);

vDatabaseArchitecture=new  LinkedList<com.thinking.machines.dmodel.dl.DatabaseArchitecture>();
dataManager.begin();
vDatabaseArchitecture=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseArchitecture.class).where("name").eq(databaseArchitecture).query();
dataManager.end();
com.thinking.machines.dmodel.dl.Project project=new com.thinking.machines.dmodel.dl.Project();
project.setTitle(title);
project.setMemberCode(member.getCode());
project.setDatabaseArchitectureCode((vDatabaseArchitecture.get(0)).getCode());
project.setDateOfCreation(d);
project.setTimeOfCreation(t);
project.setNumberOfTable(0);
project.setCanvasHeight(0);
project.setCanvasWidth(0);
dataManager.begin();
dataManager.insert(project);
dataManager.end();
com.thinking.machines.dmodel.dl.Member dlMember=(com.thinking.machines.dmodel.dl.Member)this.httpSession.getAttribute("member");
member.setNumberOfProjects(member.getNumberOfProjects()+1);
this.httpSession.removeAttribute("member");
this.httpSession.setAttribute("member",dlMember);
dataManager.begin();
dataManager.update(dlMember);
dataManager.end();
return openProject(title);
}
catch(ValidatorException ve)
{
System.out.println(ve.getMessage());
return new TMForward("homePage.jsp");
}
catch(Exception e)
{
System.out.println(e);
return new TMForward("homePage.jsp");
}
}


@Post
@InjectApplication
@InjectSession
@Path("saveProject")
public Object saveProject(com.thinking.machines.dmodel.bl.Project project,LinkedList<com.thinking.machines.dmodel.bl.DatabaseTable> vDatabaseTables)
{
List<com.thinking.machines.dmodel.dl.Project> dlProjects;
com.thinking.machines.dmodel.dl.Project dlProject1,dlProject2;
com.thinking.machines.dmodel.dl.Member member;
dlProject1=null;
dlProject2=null;
int numberOfTables=0;
int numberOfFields=0;
Boolean invalid=true;
try
{
DataManager dataManager=new DataManager();
member=(com.thinking.machines.dmodel.dl.Member)this.httpSession.getAttribute("member");

dataManager.begin();
dlProjects=dataManager.select(com.thinking.machines.dmodel.dl.Project.class).where("memberCode").eq(member.getCode()).query();
dataManager.end();

for(com.thinking.machines.dmodel.dl.Project p:dlProjects)
{
if(p.getTitle().trim().equalsIgnoreCase(project.getTitle()))
{
dlProject1=p;
invalid=false;
}
}
if(dlProjects.size()==0)System.out.println("Number of project : 0");
if(invalid)return false;

dlProject2=new com.thinking.machines.dmodel.dl.Project();
dlProject2.setCode(dlProject1.getCode());
dlProject2.setTitle(dlProject1.getTitle());
dlProject2.setMemberCode(dlProject1.getMemberCode());
dlProject2.setDateOfCreation(dlProject1.getDateOfCreation());
dlProject2.setTimeOfCreation(dlProject1.getTimeOfCreation());
dlProject2.setCanvasHeight(project.getCanvasHeight());
dlProject2.setCanvasWidth(project.getCanvasWidth());
dlProject2.setDatabaseArchitectureCode(dlProject1.getDatabaseArchitectureCode());
List<com.thinking.machines.dmodel.bl.DatabaseTable> databaseTables=vDatabaseTables;
com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
List<com.thinking.machines.dmodel.bl.DatabaseTable> dt=mapper.convertValue(vDatabaseTables,new com.fasterxml.jackson.core.type.TypeReference<List<com.thinking.machines.dmodel.bl.DatabaseTable>>(){ });
List<com.thinking.machines.dmodel.dl.DatabaseTable> dlDatabaseTables=new LinkedList<>();
List<com.thinking.machines.dmodel.dl.DatabaseTableField> dlDatabaseTableFields=new LinkedList<>();
List<com.thinking.machines.dmodel.dl.DatabaseEngine> engines=new LinkedList<>();
List<com.thinking.machines.dmodel.dl.DatabaseTableRelationship> dlDatabaseTableRelationship=new LinkedList<>();
List<com.thinking.machines.dmodel.dl.DatabaseTableRelationshipKey> dlDatabaseTableRelationshipKey=new LinkedList<>();
com.thinking.machines.dmodel.bl.DatabaseTable dddt;
dataManager.begin();
dlDatabaseTables=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTable.class).where("projectCode").eq(dlProject1.getCode()).query();
dataManager.end();




if(dlDatabaseTables.size()!=0)
{
for(com.thinking.machines.dmodel.dl.DatabaseTable ddt:dlDatabaseTables)
{
dataManager.begin();
dlDatabaseTableFields=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTableField.class).where("tableCode").eq(ddt.getCode()).query();
dataManager.end();
if(dlDatabaseTableFields.size()!=0)
{
for(com.thinking.machines.dmodel.dl.DatabaseTableField ddtf:dlDatabaseTableFields)
{
dataManager.begin();
dlDatabaseTableRelationship=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTableRelationship.class).where("childDatabaseTableCode").eq(ddt.getCode()).query();
dataManager.end();


if(dlDatabaseTableRelationship.size()!=0)
{
for(com.thinking.machines.dmodel.dl.DatabaseTableRelationship ddtr:dlDatabaseTableRelationship)
{
dataManager.begin();
dlDatabaseTableRelationshipKey=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTableRelationshipKey.class).where("databaseTableRelationshipCode").eq(ddtr.getCode()).query();
dataManager.end();
if(dlDatabaseTableRelationshipKey.size()!=0)
{
for(com.thinking.machines.dmodel.dl.DatabaseTableRelationshipKey dtrk:dlDatabaseTableRelationshipKey)
{

dataManager.begin();
dataManager.delete(dtrk);
dataManager.end();
}
}
dataManager.begin();
dataManager.delete(ddtr);
dataManager.end();
}
}
}
}
}
}



if(dlDatabaseTables.size()!=0)
{
for(com.thinking.machines.dmodel.dl.DatabaseTable ddt:dlDatabaseTables)
{
dataManager.begin();
dlDatabaseTableFields=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTableField.class).where("tableCode").eq(ddt.getCode()).query();
dataManager.end();
if(dlDatabaseTableFields.size()!=0)
{
for(com.thinking.machines.dmodel.dl.DatabaseTableField ddtf:dlDatabaseTableFields)
{
dataManager.begin();
dataManager.delete(ddtf);
dataManager.end();
}
}
dataManager.begin();
dataManager.delete(ddt);
dataManager.end();
}
}



//all tables and its fields , relationship has been deleted
for(int i=0;i<dt.size();i++)
{
dddt=dt.get(i);
com.thinking.machines.dmodel.dl.DatabaseTable dlDatabaseTable=new com.thinking.machines.dmodel.dl.DatabaseTable();
dlDatabaseTable.setProjectCode(dlProject1.getCode());
dlDatabaseTable.setName(dddt.getName());
dlDatabaseTable.setXCoordinate(dddt.getX());
dlDatabaseTable.setYCoordinate(dddt.getY());
dataManager.begin();
engines=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseEngine.class).where("name").eq(dddt.getEngine().getName()).query();
dataManager.end();

if(engines.size()==0)
{
return false;
}
dlDatabaseTable.setDatabaseEngineCode(engines.get(0).getCode());
dlDatabaseTable.setNote("  ");
List<com.thinking.machines.dmodel.bl.DatabaseTableField> databaseTableFields=dddt.getFields();
dlDatabaseTable.setNumberOfFields(databaseTableFields.size());
dataManager.begin();
dataManager.insert(dlDatabaseTable);
dataManager.end();
dt.get(i).setCode(dlDatabaseTable.getCode());
numberOfTables++;
for(com.thinking.machines.dmodel.bl.DatabaseTableField dtf:databaseTableFields)
{
numberOfFields++;
com.thinking.machines.dmodel.dl.DatabaseTableField dldtf=new com.thinking.machines.dmodel.dl.DatabaseTableField();
List<com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType> dbadt;
dataManager.begin();
dbadt=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType.class).where("dataType").eq(dtf.getDatabaseArchitectureDataType().getDataType()).query();
dataManager.end();
com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType dba=dbadt.get(0);
dldtf.setName(dtf.getName());
dldtf.setDatabaseArchitectureDataTypeCode(dba.getCode());
dldtf.setWidth(dtf.getWidth());
dldtf.setTableCode(dlDatabaseTable.getCode());
dldtf.setNumberOfDecimalPlaces(dtf.getNumberOfDecimalPlaces());
dldtf.setIsPrimaryKey(dtf.getIsPrimaryKey());
dldtf.setIsAutoIncrement(dtf.getIsAutoIncrement());
dldtf.setIsUnique(dtf.getIsUnique());
dldtf.setIsNotNull(dtf.getIsNotNull());
if(dldtf.getDefaultValue()==null||dldtf.getDefaultValue().trim().length()==0)
{
dldtf.setDefaultValue("nothing");
}
else
{
dldtf.setDefaultValue(dtf.getDefaultValue());
}
if(dldtf.getNote()==null||dldtf.getNote().trim().length()==0)
{
dldtf.setNote("nothing");
}
else
{
dldtf.setNote(dtf.getNote());
}
if(dldtf.getCheckConstraint()==null||dldtf.getCheckConstraint().trim().length()==0)
{
dldtf.setCheckConstraint("nothing");
}
else
{
dldtf.setCheckConstraint(dtf.getCheckConstraint());
}
dataManager.begin();
List<com.thinking.machines.dmodel.dl.DatabaseTableField> ff=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTableField.class).where("name").eq(dtf.getName()).query();
dataManager.end();
dataManager.begin();
dataManager.insert(dldtf);
dataManager.end();
dtf.setCode(dldtf.getCode());

}
}


com.thinking.machines.dmodel.dl.DatabaseTable childTable=null,parentTable=null;
com.thinking.machines.dmodel.dl.DatabaseTableField field=null;
boolean valid=false;
for(int i=0;i<dt.size();i++)
{
dddt=dt.get(i);
List<com.thinking.machines.dmodel.bl.DatabaseTableRelationship> blDatabaseTableRelationships=dddt.getDatabaseTableRelationships();
if(blDatabaseTableRelationships.size()!=0)
{
for(com.thinking.machines.dmodel.bl.DatabaseTableRelationship blDatabaseTableRelationship: blDatabaseTableRelationships)
{
com.thinking.machines.dmodel.dl.DatabaseTableRelationship ddlDatabaseTableRelationship=new com.thinking.machines.dmodel.dl.DatabaseTableRelationship();
dataManager.begin();
dlDatabaseTables=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTable.class).where("name").eq(blDatabaseTableRelationship.getParentTable()).query();
dataManager.end();
if(dlDatabaseTables.size()!=0)
{
for(com.thinking.machines.dmodel.dl.DatabaseTable f: dlDatabaseTables)
{

if(f.getProjectCode()==dlProject1.getCode())
{
parentTable=f;
valid=true;
}
}
}
if(valid)ddlDatabaseTableRelationship.setParentDatabaseTableCode(parentTable.getCode());
valid=false;
dataManager.begin();
dlDatabaseTables=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTable.class).where("name").eq(blDatabaseTableRelationship.getChildTable()).query();
dataManager.end();
if(dlDatabaseTables.size()!=0)
{
for(com.thinking.machines.dmodel.dl.DatabaseTable f: dlDatabaseTables)
{
if(f.getProjectCode()==dlProject1.getCode())
{
childTable=f;
valid=true;
}
}
}
if(valid)
{
ddlDatabaseTableRelationship.setChildDatabaseTableCode(childTable.getCode());
ddlDatabaseTableRelationship.setName(blDatabaseTableRelationship.getName());
}
dataManager.begin();
dataManager.insert(ddlDatabaseTableRelationship);
dataManager.end();
valid=false;

com.thinking.machines.dmodel.dl.DatabaseTableRelationshipKey ddlDatabaseTableRelationshipKey=new com.thinking.machines.dmodel.dl.DatabaseTableRelationshipKey();
ddlDatabaseTableRelationshipKey.setDatabaseTableRelationshipCode(ddlDatabaseTableRelationship.getCode());
dataManager.begin();
dlDatabaseTableFields=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTableField.class).where("name").eq(blDatabaseTableRelationship.getParentTableField()).query();
dataManager.end();

if(dlDatabaseTableFields.size()!=0)
{
for(com.thinking.machines.dmodel.dl.DatabaseTableField f: dlDatabaseTableFields)
{
int x,y;
x=(int)f.getTableCode();
y=(int)parentTable.getCode();
if(x==y)
{
field=f;
valid=true;
}

}
}


if(valid)
{
ddlDatabaseTableRelationshipKey.setParentDatabaseTableFieldCode(field.getCode());
valid=false;
}

for(String  name:blDatabaseTableRelationship.getChildTableFields())
{
dataManager.begin();
dlDatabaseTableFields=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTableField.class).where("name").eq(name).query();
dataManager.end();
if(dlDatabaseTableFields.size()!=0)
{
for(com.thinking.machines.dmodel.dl.DatabaseTableField f: dlDatabaseTableFields)
{
int x,y;
x=(int)f.getTableCode();
y=(int)childTable.getCode();
if(x==y)
{
field=f;
valid=true;

}
}
}

if(valid)
{
ddlDatabaseTableRelationshipKey.setChildDatabaseTableFieldCode(field.getCode());
ddlDatabaseTableRelationshipKey.setCode(0);
dataManager.begin();
dataManager.insert(ddlDatabaseTableRelationshipKey);
dataManager.end();
}
valid=false;
}


}
}
}







dlProject2.setNumberOfTable(numberOfTables);
dataManager.begin();
dataManager.update(dlProject2);
dataManager.end();
return true;
}
catch(ValidatorException ve)
{
System.out.println(ve);
return false;
}
catch(Exception e)
{
System.out.println(e);
return false;
}
}

@Post
@InjectApplication
@InjectSession
@Path("loadProject")
public Object loadProject(String projectTitle)
{
List<com.thinking.machines.dmodel.dl.Project> dlProjects;
com.thinking.machines.dmodel.dl.Project dlProject=null;
List<com.thinking.machines.dmodel.dl.DatabaseTable> dlTables;
com.thinking.machines.dmodel.bl.Project project;
com.thinking.machines.dmodel.dl.Member member;
Boolean invalid=true;
try
{
if(projectTitle==null||projectTitle.length()==0)System.out.println("Empty title");
member=(com.thinking.machines.dmodel.dl.Member)this.httpSession.getAttribute("member");
DataManager dataManager=new DataManager();
dataManager.begin();
dlProjects=dataManager.select(com.thinking.machines.dmodel.dl.Project.class).where("memberCode").eq(member.getCode()).query();
dataManager.end();
for(com.thinking.machines.dmodel.dl.Project p:dlProjects)
{
if(p.getTitle().trim().equalsIgnoreCase(projectTitle))
{
dlProject=p;
invalid=false;
}
}
if(invalid)return new Exception("Invalid title");
if(dlProject==null)return new Exception("Unable to load project");
project=new com.thinking.machines.dmodel.bl.Project();
project.setTitle(dlProject.getTitle());
project.setCanvasHeight(dlProject.getCanvasHeight());
project.setCanvasWidth(dlProject.getCanvasWidth());
project.setNumberOfTable(dlProject.getNumberOfTable());
project.setDateOfCreation(dlProject.getDateOfCreation());
project.setTimeOfCreation(dlProject.getTimeOfCreation());
dataManager.begin();
dlTables=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTable.class).where("projectCode").eq(dlProject.getCode()).query();
dataManager.end();

List<com.thinking.machines.dmodel.bl.DatabaseTable> blTables;
List<com.thinking.machines.dmodel.bl.DatabaseTableField> blTableFields;
List<com.thinking.machines.dmodel.dl.DatabaseTableField> dlTableFields;
List<com.thinking.machines.dmodel.dl.DatabaseTableRelationship> dlDatabaseTableRelationships;
List<com.thinking.machines.dmodel.dl.DatabaseTableRelationshipKey> dlDatabaseTableRelationshipKeys;
List<com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType> dlArchitecureDataTypes;
List<com.thinking.machines.dmodel.dl.DatabaseEngine> dlEngines;
com.thinking.machines.dmodel.bl.DatabaseTableField bldtf;
com.thinking.machines.dmodel.dl.DatabaseTableField dldtf;
com.thinking.machines.dmodel.bl.DatabaseTable blTable;
com.thinking.machines.dmodel.bl.DatabaseEngine blEngine;
com.thinking.machines.dmodel.bl.DatabaseTableRelationship blDatabaseTableRelationship;
List<com.thinking.machines.dmodel.bl.DatabaseTableRelationship > blDatabaseTableRelationships;
for(com.thinking.machines.dmodel.dl.DatabaseTable dt:dlTables)
{
blTable=new com.thinking.machines.dmodel.bl.DatabaseTable();
blTable.setName(dt.getName());
dataManager.begin();
dlEngines=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseEngine.class).where("code").eq(dt.getDatabaseEngineCode()).query();
dataManager.end();
blEngine=new com.thinking.machines.dmodel.bl.DatabaseEngine();
blEngine.setName(dlEngines.get(0).getName());
blTable.setEngine(blEngine);
blTable.setNote(dt.getNote());
blTable.setX(dt.getXCoordinate());
blTable.setY(dt.getYCoordinate());
dataManager.begin();
dlTableFields=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTableField.class).where("tableCode").eq(dt.getCode()).query();
dataManager.end();
for(com.thinking.machines.dmodel.dl.DatabaseTableField dtf:dlTableFields)
{
dldtf=dtf;
dataManager.begin();
dlArchitecureDataTypes=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType.class).where("code").eq(dldtf.getDatabaseArchitectureDataTypeCode()).query();
dataManager.end();
bldtf=new com.thinking.machines.dmodel.bl.DatabaseTableField();
bldtf.setName(dldtf.getName());
bldtf.setWidth(dldtf.getWidth());
bldtf.setIsPrimaryKey(dldtf.getIsPrimaryKey());
bldtf.setIsUnique(dldtf.getIsUnique());
bldtf.setIsAutoIncrement(dldtf.getIsAutoIncrement());
bldtf.setIsNotNull(dldtf.getIsNotNull());
bldtf.setCheckConstraint(dldtf.getCheckConstraint());
com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType dldtdt=dlArchitecureDataTypes.get(0);
com.thinking.machines.dmodel.bl.DatabaseArchitectureDataType dtdt=new com.thinking.machines.dmodel.bl.DatabaseArchitectureDataType();
dtdt.setDataType(dldtdt.getDataType());
bldtf.setDatabaseAchitectureDataType(dtdt);
blTable.setDatabaseTableField(bldtf);
}
dataManager.begin();
dlDatabaseTableRelationships=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTableRelationship.class).where("childDatabaseTableCode").eq(dt.getCode()).query();
dataManager.end();
blDatabaseTableRelationships=new LinkedList<>();
if(dlDatabaseTableRelationships.size()!=0)
{
for(com.thinking.machines.dmodel.dl.DatabaseTableRelationship d:dlDatabaseTableRelationships)
{
blDatabaseTableRelationship=new com.thinking.machines.dmodel.bl.DatabaseTableRelationship();
blDatabaseTableRelationship.setName(d.getName());
dataManager.begin();
dlTables=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTable.class).where("code").eq(d.getParentDatabaseTableCode()).query();
dataManager.end();
if(dlTables.size()!=0)
{
blDatabaseTableRelationship.setParentTable(dlTables.get(0).getName());
}
dataManager.begin();
dlTables=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTable.class).where("code").eq(d.getChildDatabaseTableCode()).query();
dataManager.end();

if(dlTables.size()!=0)
{
blDatabaseTableRelationship.setChildTable(dlTables.get(0).getName());
}

dataManager.begin();
dlDatabaseTableRelationshipKeys=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTableRelationshipKey.class).where("databaseTableRelationshipCode").eq(d.getCode()).query();
dataManager.end();




List<String > fieldNames=new LinkedList<>();



if(dlDatabaseTableRelationshipKeys.size()!=0)
{
dataManager.begin();
dlTableFields=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTableField.class).where("code").eq(dlDatabaseTableRelationshipKeys.get(0).getParentDatabaseTableFieldCode()).query();
dataManager.end();

if(dlTableFields.size()!=0)blDatabaseTableRelationship.setParentTableField(dlTableFields.get(0).getName());

for(com.thinking.machines.dmodel.dl.DatabaseTableRelationshipKey k:dlDatabaseTableRelationshipKeys)
{
dataManager.begin();
dlTableFields=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseTableField.class).where("code").eq(k.getChildDatabaseTableFieldCode()).query();
dataManager.end();
if(dlTableFields.size()!=0)
{
fieldNames.add(dlTableFields.get(0).getName());
}
}
}
blDatabaseTableRelationship.setChildTableFields(fieldNames);
blDatabaseTableRelationships.add(blDatabaseTableRelationship);

}
blTable.setDatabaseTableRelationships(blDatabaseTableRelationships);
}
project.setTables(blTable);
}
return project;
}
catch(Exception e)
{
System.out.println(e);
return new com.thinking.machines.dmodel.bl.Project();
}
}

@Post
@InjectApplication
@InjectSession
@Path("openProject")
public TMForward openProject(String projectTitle)
{
List<com.thinking.machines.dmodel.bl.DatabaseArchitecture> blDatabaseArchitectures;
com.thinking.machines.dmodel.bl.Project blProject=null;
List<com.thinking.machines.dmodel.dl.Project> dlProjects=null;
com.thinking.machines.dmodel.dl.Project dlProject=null;
com.thinking.machines.dmodel.bl.Project project=null;
try
{
if(projectTitle==null||projectTitle.length()==0)return new TMForward("/homePage.jsp");
DataManager dm=new DataManager();
dm.begin();
dlProjects=dm.select(com.thinking.machines.dmodel.dl.Project.class).where("title").eq(projectTitle).query();
dm.end();
if(dlProjects.size()==0)
{
System.out.println("Invalid title");
return new TMForward("/homePage.jsp");
}
dlProject=dlProjects.get(0);
blProject=new com.thinking.machines.dmodel.bl.Project();
blProject.setTitle(dlProject.getTitle());
blProject.setDateOfCreation(dlProject.getDateOfCreation());
blProject.setTimeOfCreation(dlProject.getTimeOfCreation());
blProject.setNumberOfTable(dlProject.getNumberOfTable());
blProject.setCanvasHeight(dlProject.getCanvasHeight());
blProject.setCanvasWidth(dlProject.getCanvasWidth());
blDatabaseArchitectures=(List<com.thinking.machines.dmodel.bl.DatabaseArchitecture>)this.servletContext.getAttribute("architectures");
com.thinking.machines.dmodel.bl.DatabaseArchitecture bldba=null;
for(com.thinking.machines.dmodel.bl.DatabaseArchitecture dba:blDatabaseArchitectures)
{
int e,f;
e=dba.getCode();
f=dlProject.getDatabaseArchitectureCode();
if(e==f)
{
bldba=dba;
}
}
blProject.setDatabaseArchitecture(bldba);
project=blProject;
if(project==null)
{
System.out.println("Invalid request");
return new TMForward("/homePage.jsp");
}
this.httpSession.setAttribute("project",project);
return new TMForward("/ProjectView.jsp");
}
catch(Exception e)
{
System.out.println(e.getMessage());
return new TMForward("/homePage.jsp");
}
}
@Post
@InjectApplication
@InjectSession
@Path("generateScript")
public Object genrateScript(List<com.thinking.machines.dmodel.bl.DatabaseTable> kddt)
{
try
{

com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
List<com.thinking.machines.dmodel.bl.DatabaseTable> tables=mapper.convertValue(kddt,new com.fasterxml.jackson.core.type.TypeReference<List<com.thinking.machines.dmodel.bl.DatabaseTable>>(){ });

if(tables.size()==0)
{
return " ";
}

StringBuffer dropStatements=new StringBuffer();
StringBuffer createStatements=new StringBuffer();
StringBuffer uniqueStatements=new StringBuffer();
StringBuffer keyStatements=new StringBuffer();
StringBuffer relationshipsBuffer=new StringBuffer();
StringBuffer script=new StringBuffer();
String temp;
for(com.thinking.machines.dmodel.bl.DatabaseTable dt:tables)
{
dropStatements.append("drop table IF EXISTS "+dt.getName()+";tereName");
temp="Create table "+dt.getName()+"(tereName";
if(dt.getFields().size()!=0)
{
List<com.thinking.machines.dmodel.bl.DatabaseTableField> fields=dt.getFields();
for(com.thinking.machines.dmodel.bl.DatabaseTableField dtf:fields)
{
int width=dtf.getWidth();
if(width!=0)
{
temp+=dtf.getName()+" "+dtf.getDatabaseArchitectureDataType().getDataType()+"("+width+")  ";
if(dtf.getIsNotNull())
{
temp+="NOT NULL ";
}
if(dtf.getIsAutoIncrement())
{
temp+="AUTO_INCREMENT ,tereName";
}
if(dtf.getIsUnique())
{
uniqueStatements.append("UNIQUE("+dtf.getName()+"),tereName");
}
if(dtf.getIsPrimaryKey())
{
keyStatements.append("Primary Key ("+dtf.getName()+")tereName");
}
temp+=", tereName";
}
else
{
temp+=dtf.getName()+" "+dtf.getDatabaseArchitectureDataType().getDataType()+"  ";
if(dtf.getIsNotNull())
{
temp+="NOT NULL ";
}
if(dtf.getIsAutoIncrement())
{
temp+="AUTO_INCREMENT ";
}
if(dtf.getIsUnique())
{
uniqueStatements.append("UNIQUE("+dtf.getName()+"),tereName");
}
if(dtf.getIsPrimaryKey())
{
keyStatements.append("Primary Key ("+dtf.getName()+")");
}
temp+=", tereName";
}
}
List<com.thinking.machines.dmodel.bl.DatabaseTableRelationship> blDatabaseTableRelationships=dt.getDatabaseTableRelationships();
if(blDatabaseTableRelationships.size()!=0)
{
for(com.thinking.machines.dmodel.bl.DatabaseTableRelationship d:blDatabaseTableRelationships)
{
List<String > childTableFields=d.getChildTableFields();
for(String s : childTableFields)
{
String dummy="Alter table "+d.getChildTable()+" add  Foreign Key ("+s+" ) references "+ d.getParentTable() +"("+d.getParentTableField() +")" +"on delete  restrict on update  restrict;tereName";
relationshipsBuffer.append(dummy);
}
}
}
}

if(keyStatements.toString().length()==0 && uniqueStatements.toString().length()!=0)
{
temp+=(uniqueStatements.toString()).substring(0,uniqueStatements.toString().length()-1);
temp+=")ENGINE="+dt.getEngine().getName()+";";
}
else
{
if(keyStatements.toString().length()!=0 && uniqueStatements.toString().length()==0)
{
temp+=(keyStatements.toString()).substring(0,keyStatements.toString().length());
temp+=")ENGINE="+dt.getEngine().getName()+";";
}
else
{
if(uniqueStatements.toString().length()==0 && keyStatements.toString().length()==0)temp+=")ENGINE="+dt.getEngine().getName()+";";
else
{
temp+=(keyStatements.toString()).substring(0,keyStatements.toString().length());
temp+=")ENGINE="+dt.getEngine().getName()+";";
}
}
}
uniqueStatements.setLength(0);
keyStatements.setLength(0);
script.append(temp+"tereNametereNametereNametereName");
}
String finalScript=dropStatements.toString()+"tereName"+script.toString()+"tereName"+relationshipsBuffer.toString();
return finalScript;
}catch(Exception e)
{
System.out.println(e);
return e.getMessage();
}
}
private static String toCamelCase(String s)
{
return CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.UPPER_CAMEL,s);
}

private void writeToZipFile(File aFile, String name,ZipOutputStream zipStream)throws Exception
{
FileInputStream fis = new FileInputStream(aFile); 
ZipEntry zipEntry = new ZipEntry(name); 
zipStream.putNextEntry(zipEntry); 
byte[] bytes = new byte[1024]; 
int length; 
while ((length = fis.read(bytes)) >= 0) 
{
zipStream.write(bytes, 0, length);
} 
zipStream.closeEntry(); 
fis.close();
}


@Post
@InjectApplication
@Path("createZip")
public Object createZip(List<com.thinking.machines.dmodel.bl.DatabaseTable> ddt, String packageName)
{
java.nio.file.Path currentRelativePath = java.nio.file.Paths.get("");
String path=currentRelativePath.toAbsolutePath().toString();
System.out.println(path);
//path=path.substring(0,path.indexOf("bin"));
//path=path+"\\webapps\\tmdmodel\\temp\\";
try
{
com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
List<com.thinking.machines.dmodel.bl.DatabaseTable> tables=mapper.convertValue(ddt,new com.fasterxml.jackson.core.type.TypeReference<List<com.thinking.machines.dmodel.bl.DatabaseTable>>(){ });
if(tables.size()==0)
{
return false;
}

File file;
RandomAccessFile raf;
List<File> files=new LinkedList<>();
List<String> names=new LinkedList<>();
StringBuffer sb;
for(com.thinking.machines.dmodel.bl.DatabaseTable t:tables)
{
sb=new StringBuffer();
sb.append(("package "+packageName+";"+"\r\nimport java.sql.*;\r\n"));
sb.append(("\r\nimport javax.persistence.*;\r\n"));
String input1=ProjectService.toCamelCase(t.getName());
String c1=Character.toUpperCase(input1.charAt(0)) +(input1.length() > 1 ? input1.substring(1) : "");
String j=c1+".java";
file=new File(j);
if(file.exists())file.delete();
file.createNewFile();
raf=new RandomAccessFile(file,"rw");
sb.append("@Entity\r\n");
sb.append("@Table(name="+t.getName()+")\r\n");
sb.append("public class "+c1+ " implements java.io.Serializable\r\n{ \r\n");
StringBuffer cb=new StringBuffer();
List<com.thinking.machines.dmodel.bl.DatabaseTableField> fields=t.getFields();
if(fields.size()!=0)
{
for(com.thinking.machines.dmodel.bl.DatabaseTableField dtf:fields)
{
String input=ProjectService.toCamelCase(dtf.getName());
String c=Character.toLowerCase(input.charAt(0)) +(input.length() > 1 ? input.substring(1) : "");
if(dtf.getIsPrimaryKey())
{
sb.append("@Id\r\n");
}
if(dtf.getIsAutoIncrement())
{
sb.append("@GeneratedValue(strategy=GenerationType.IDENTITY)\r\n");
}

String cc="@Column(name="+c;
if(dtf.getIsUnique())
{
cc+=",unique=true";
}
else
{
cc+=",unique=false";
}
if(dtf.getIsNotNull())
{
cc+=",nullable=true";
}
else
{
cc+=",nullable=false";
}
cc+=")\r\n";
sb.append(cc);
String y=ProjectService.toCamelCase(dtf.getName());
if(dtf.getWidth()==0)
{
String dataType=dtf.getDatabaseArchitectureDataType().getDataType();
dataType=dataType.toLowerCase();
if(dataType.equalsIgnoreCase("char"))dataType="char";
if(dataType.equalsIgnoreCase("varchar")||dataType.equalsIgnoreCase("mediumtext"))dataType="String";
if(dataType.equalsIgnoreCase("BIT"))dataType="byte";
if(dataType.equalsIgnoreCase("DATE"))dataType="Date";
if(dataType.equalsIgnoreCase("TIME"))dataType="Time";

sb.append("private "+dataType+" "+c+";\r\n");
String x="public void set"+y+"("+dataType+" "+c+" )"+"\r\n"+"{\r\n"+"this."+c+"="+c+";"+"\r\n}";
cb.append(x);
cb.append("\r\n");
x="public "+ dataType+ " get"+y+"()"+"\r\n"+"{\r\n"+"return this."+c+";"+"\r\n}";
cb.append(x);
cb.append("\r\n");
}
else
{
String dataType=dtf.getDatabaseArchitectureDataType().getDataType();
if(dataType.equalsIgnoreCase("BIT"))dataType="byte";
if(dataType.equalsIgnoreCase("char")||dataType.equalsIgnoreCase("varchar")||dataType.equalsIgnoreCase("mediumtext"))dataType="String ";
if(dataType.equalsIgnoreCase("BIT"))dataType="byte ";
if(dataType.equalsIgnoreCase("DATE"))dataType="Date";
if(dataType.equalsIgnoreCase("TIME"))dataType="Time";

sb.append("private "+dataType+" "+c+";\r\n");
String x="public void set"+y+"("+dataType+c+" )"+"\r\n"+"{\r\n"+"this."+c+"="+c+";"+"\r\n}";
cb.append(x);
cb.append("\r\n");
x="public "+dataType+" get"+y+"()"+"\r\n"+"{\r\n"+"return this."+c+";"+"\r\n}";
cb.append(x);
cb.append("\r\n");
}
}
}
raf.writeBytes(sb.toString()+cb.toString()+"}");

names.add(c1);
files.add(file);

sb.setLength(0);
cb.setLength(0);
}
file=new File(path+"Classes.zip");
if(file.exists())file.delete();
FileOutputStream fos = new FileOutputStream(path+"Classes.zip"); 
ZipOutputStream zipOS = new ZipOutputStream(fos); 
for(int i=0;i<files.size()&&i<names.size(); i++)
{
writeToZipFile(files.get(i),(names.get(i)+".java"),zipOS);
}
zipOS.close();
fos.close();
return true;
}
catch(Exception e)
{
e.printStackTrace();
return false;
}
}
}