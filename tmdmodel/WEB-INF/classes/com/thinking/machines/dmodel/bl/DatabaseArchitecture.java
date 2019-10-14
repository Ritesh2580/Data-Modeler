package com.thinking.machines.dmodel.bl;
import com.thinking.machines.dmodel.bl.*;
import java.util.*;
public class DatabaseArchitecture implements java.io.Serializable
{
private int code;
private String name;
private List<DatabaseArchitectureDataType> databaseArchitectureDataTypes;
private int maxWidthOfTableName;
private int maxWidthOfColumnName;
private int maxWidthOfRelationshipName;
private List<DatabaseEngine> databaseEngines;
public DatabaseArchitecture()
{
this.code=0;
this.name="";
this.databaseArchitectureDataTypes=new LinkedList<>();
this.maxWidthOfTableName=0;
this.maxWidthOfColumnName=0;
this.maxWidthOfRelationshipName=0;
this.databaseEngines=new LinkedList<>();
}
public void setCode(int code)
{
this.code=code;
}
public int getCode()
{
return this.code;
}
public void setName(String name)
{
this.name=name;
}
public String getName()
{
return this.name;
}
public void setMaxWidthOfColumnName(int maxWidthOfColumnName)
{
this.maxWidthOfColumnName=maxWidthOfColumnName;
}
public int getMaxWidthOfColumnName()
{
return this.maxWidthOfColumnName;
}
public void setMaxWidthOfTableName(int maxWidthOfTableName)
{
this.maxWidthOfTableName=maxWidthOfTableName;
}
public int getMaxWidthOfTableName()
{
return this.maxWidthOfTableName;
}
public void setMaxWidthOfRelationshipName(int maxWidthOfRelationshipName)
{
this.maxWidthOfRelationshipName=maxWidthOfRelationshipName;
}
public int getMaxWidthOfRelationshipName()
{
return this.maxWidthOfRelationshipName;
}
public void setDatabaseAchitectureDataType(DatabaseArchitectureDataType databaseArchitectureDataType)
{
this.databaseArchitectureDataTypes.add(databaseArchitectureDataType);
}
public List<DatabaseArchitectureDataType> getDatabaseArchitectureDataTypes()
{
return this.databaseArchitectureDataTypes;
}
public void setDatabaseEngine(DatabaseEngine databaseEngine)
{
this.databaseEngines.add(databaseEngine);
}
public List<DatabaseEngine> getDatabaseEngines()
{
return this.databaseEngines;
}
}