package com.thinking.machines.dmodel.beans;
import java.sql.*;
public class ProjectBean implements java.io.Serializable
{
private String title;
private String databaseArchitecture;
private Date dateOfCreation;
private Time timeOfCreation;
private int numberOfTable;
public ProjectBean()
{
this.title=" ";
this.databaseArchitecture=" ";
this.dateOfCreation=null;
this.timeOfCreation=null;
this.numberOfTable=0;
}
public void setTitle(String title)
{
this.title=title;
}
public String getTitle()
{
return this.title;
}
public void setDatabaseArchitecture(String databaseArchitecture)
{
this.databaseArchitecture=databaseArchitecture;
}
public String getDatabaseArchitectureCode()
{
return this.databaseArchitecture;
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
public void setNumberOfTable(int numberOfTable)
{
this.numberOfTable=numberOfTable;
}
public int getNumberOfTable()
{
return this.numberOfTable;
}
}
