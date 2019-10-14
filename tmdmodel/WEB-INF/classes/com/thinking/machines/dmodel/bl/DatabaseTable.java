package com.thinking.machines.dmodel.bl;
import com.thinking.machines.dmodel.bl.*;
import java.util.*;
public class DatabaseTable implements java.io.Serializable
{
private int code;
private String name;
private String note;
private int x;
private int y;
private List<DatabaseTableField> fields;
private DatabaseArchitectureDataType databaseArchitectureDataType;
private DatabaseEngine engine;
private List<DatabaseTableRelationship> databaseTableRelationships;
public DatabaseTable()
{
this.code=0;
this.name=" ";
this.note=" ";
this.x=0;
this.y=0;
this.fields=new LinkedList<>();
this.engine=null;
this.databaseArchitectureDataType=null;
this.databaseTableRelationships=new LinkedList<>();
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
public void setEngine(DatabaseEngine engine)
{
this.engine=engine;
}
public DatabaseEngine getEngine()
{
return this.engine;
}
public void addField(DatabaseTableField databaseTableField)
{
this.fields.add(databaseTableField);
}
public void setNote(String note)
{
this.note=note;
}
public String getNote()
{
return this.note;
}
public void setDatabaseTableField(DatabaseTableField databaseTableField)
{
this.fields.add(databaseTableField);
}
public List<DatabaseTableField> getFields()
{
return this.fields;
}
public void setDatabaseArchitectureDataType(DatabaseArchitectureDataType databaseArchitectureDataType)
{
this.databaseArchitectureDataType=databaseArchitectureDataType;
}
public DatabaseArchitectureDataType getDatabaseArchitectureDataType()
{
return this.databaseArchitectureDataType;
}
public void setDatabaseTableRelationships(List<DatabaseTableRelationship>  databaseTableRelationships)
{
this.databaseTableRelationships=databaseTableRelationships;
}
public List<DatabaseTableRelationship> getDatabaseTableRelationships()
{
return this.databaseTableRelationships;
}
public void setX(int x)
{
this.x=x;
}
public void setY(int y)
{
this.y=y;
}
public int getX()
{
return this.x;
}
public int getY()
{
return this.y;
}
}