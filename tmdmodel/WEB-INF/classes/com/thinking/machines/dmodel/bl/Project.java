package com.thinking.machines.dmodel.bl;
import com.thinking.machines.dmodel.bl.*;
import java.sql.*;
public class Project implements java.io.Serializable
{
private String title;
private Date dateOfCreation;
private Time timeOfCreation;
private int numberOfTable;
private int canvasHeight;
private int canvasWidth;
private int memberCode;
private java.util.LinkedList<DatabaseTable> tables;
private DatabaseArchitecture databaseArchitecture;
public Project()
{
this.title="";
this.dateOfCreation=null;
this.timeOfCreation=null;
this.numberOfTable=0;
this.memberCode=0;
this.canvasHeight=0;
this.canvasWidth=0;
this.databaseArchitecture=null;
this.tables=new java.util.LinkedList<>();
}
public void setDatabaseArchitecture(DatabaseArchitecture databaseArchitecture)
{
this.databaseArchitecture=databaseArchitecture;
}
public DatabaseArchitecture getDatabaseArchitecture()
{
return this.databaseArchitecture;
}
public void setTables(DatabaseTable databaseTable)
{
this.tables.add(databaseTable);
}
public java.util.List<DatabaseTable> getTables()
{
return this.tables;
}
public void setTitle(String title)
{
this.title=title;
}
public String getTitle()
{
return this.title;
}
public void setDateOfCreation(Date dateOfCreation)
{
this.dateOfCreation=dateOfCreation;
}
public Date getDateOfCreation()
{
return this.dateOfCreation;
}
public void setTimeOfCreation(Time timeOfCreation)
{
this.timeOfCreation=timeOfCreation;
}
public Time getTimeOfCreation()
{
return this.timeOfCreation;
}
public void setNumberOfTable(int numberOfTables)
{
this.numberOfTable=numberOfTable;
}
public int getNumberOfTable()
{
return this.numberOfTable;
}
public void setCanvasHeight(int canvasHeight)
{
this.canvasHeight=canvasHeight;
}
public int getCanvasHeight()
{
return this.canvasHeight;
}
public void setCanvasWidth(int canvasWidth)
{
this.canvasWidth=canvasWidth;
}
public int getCanvasWidth()
{
return this.canvasWidth;
}
}