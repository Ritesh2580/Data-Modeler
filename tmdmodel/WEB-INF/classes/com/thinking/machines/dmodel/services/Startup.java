package com.thinking.machines.dmodel.services;
import com.thinking.machines.dmframework.*;
import com.thinking.machines.dmodel.dl.*;
import com.thinking.machines.tmws.annotations.*;
import com.thinking.machines.tmws.*;
import com.thinking.machines.dmframework.exceptions.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
public class Startup
{
private ServletContext servletContext;
public void setServletContext(ServletContext servletContext)
{
this.servletContext=servletContext;

}
@OnStart(1)
@InjectApplication
public void populateDataStructure()
{
try
{
List<com.thinking.machines.dmodel.bl.DatabaseArchitecture> blDatabaseArchitectures=new LinkedList<>();
List<DatabaseArchitecture> dlDatabaseArchitectures=new LinkedList<>();
List<DatabaseArchitectureDataType> dlDatabaseArchitectureDataTypes=new LinkedList<>();
List<DatabaseEngine> dlDatabaseEngines=new LinkedList<>();
DataManager dataManager=new DataManager();
dataManager.begin();
dlDatabaseArchitectures=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseArchitecture.class).query();
dlDatabaseArchitectureDataTypes=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType.class).query();
dlDatabaseEngines=dataManager.select(com.thinking.machines.dmodel.dl.DatabaseEngine.class).query();
dataManager.end();
if(dlDatabaseArchitectures.size()!=0)
{
for(DatabaseArchitecture da:dlDatabaseArchitectures)
{
System.out.println("architecture ke if me    "+da.getName());
com.thinking.machines.dmodel.bl.DatabaseArchitecture blDatabaseArchitecture=new com.thinking.machines.dmodel.bl.DatabaseArchitecture();
blDatabaseArchitecture.setCode(da.getCode());
blDatabaseArchitecture.setName(da.getName());
blDatabaseArchitecture.setMaxWidthOfTableName(da.getMaxWidthOfTableName());
blDatabaseArchitecture.setMaxWidthOfColumnName(da.getMaxWidthOfColumnName());
blDatabaseArchitecture.setMaxWidthOfRelationshipName(da.getMaxWidthOfRelationshipName());
if(dlDatabaseArchitectureDataTypes.size()!=0)
{
System.out.println("if me data type ke");
for(DatabaseArchitectureDataType dt:dlDatabaseArchitectureDataTypes)
{
com.thinking.machines.dmodel.bl.DatabaseArchitectureDataType blDatabaseArchitectureDataType=new com.thinking.machines.dmodel.bl.DatabaseArchitectureDataType();
int re=dt.getDatabaseArchitectureCode();
int fe=da.getCode();
if(re==fe)
{
System.out.println("if me");
blDatabaseArchitectureDataType.setDataType(dt.getDataType());
blDatabaseArchitectureDataType.setMaxWidth(dt.getMaxWidth());
blDatabaseArchitectureDataType.setDefaultSize(dt.getDefaultSize());
blDatabaseArchitectureDataType.setMaxWidthOfPrecision(dt.getMaxWidthOfPrecision());
blDatabaseArchitectureDataType.setAllowAutoIncrement(dt.getAllowAutoIncrement());
blDatabaseArchitecture.setDatabaseAchitectureDataType(blDatabaseArchitectureDataType);
}
}
}
if(dlDatabaseEngines.size()!=0)
{
System.out.println("Engines me");
for(DatabaseEngine de:dlDatabaseEngines)
{
com.thinking.machines.dmodel.bl.DatabaseEngine blDatabaseEngine=new com.thinking.machines.dmodel.bl.DatabaseEngine();
int  j=da.getCode();
int l=de.getDatabaseArchitectureCode();
System.out.println(j+"  "+l);
if(l==j)
{
blDatabaseEngine.setCode(de.getCode());
blDatabaseEngine.setName(de.getName());
blDatabaseEngine.setArchitectureCode(de.getDatabaseArchitectureCode());
blDatabaseArchitecture.setDatabaseEngine(blDatabaseEngine);
}
}
}
blDatabaseArchitectures.add(blDatabaseArchitecture);
}
}
for(com.thinking.machines.dmodel.bl.DatabaseArchitecture d:blDatabaseArchitectures)
{
System.out.println("name: "+d.getName());
}
this.servletContext.setAttribute("architectures",blDatabaseArchitectures);
}
catch(DMFrameworkException dmFrameworkException)
{
System.out.println(dmFrameworkException.getMessage());
throw new ServiceException(dmFrameworkException.getMessage());
}
catch(Exception validatorException)
{
System.out.println(validatorException.getMessage());
throw new ServiceException(validatorException.getMessage());
}
}
}