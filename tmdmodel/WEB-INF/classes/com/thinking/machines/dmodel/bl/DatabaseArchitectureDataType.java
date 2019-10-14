package com.thinking.machines.dmodel.bl;
public class DatabaseArchitectureDataType implements java.io.Serializable,Comparable<DatabaseArchitectureDataType>
{
private String dataType;
private int maxWidth;
private int defaultSize;
private int maxWidthOfPrecision;
private Boolean allowAutoIncrement;
public DatabaseArchitectureDataType()
{
this.dataType=" ";
this.maxWidth=0;
this.defaultSize=0;
this.maxWidthOfPrecision=0;
this.allowAutoIncrement=false;
}
public void setDataType(String dataType)
{
this.dataType=dataType;
}
public String getDataType()
{
return this.dataType;
}
public void setMaxWidth(int maxWidth)
{
this.maxWidth=maxWidth;
}
public int getMaxWidth()
{
return this.maxWidth;
}
public void setDefaultSize(int defaultSize)
{
this.defaultSize=defaultSize;
}
public int getDefaultSize()
{
return this.defaultSize;
}
public void setMaxWidthOfPrecision(int maxWidthOfPrecision)
{
this.maxWidthOfPrecision=maxWidthOfPrecision;
}
public int getMaxWidthOfPrecision()
{
return this.maxWidthOfPrecision;
}
public void setAllowAutoIncrement(Boolean allowAutoIncrement)
{
this.allowAutoIncrement=allowAutoIncrement;
}
public Boolean getAllowAutoIncrement()
{
return this.allowAutoIncrement;
}

public boolean equals(Object object)
{
if(object==null) return false;
if(!(object instanceof DatabaseArchitectureDataType)) return false;
DatabaseArchitectureDataType anotherDatabaseArchitectureDataType=(DatabaseArchitectureDataType)object;

return this.dataType.equalsIgnoreCase(anotherDatabaseArchitectureDataType.dataType);
}
public int compareTo(DatabaseArchitectureDataType anotherDatabaseArchitectureDataType)
{
if(anotherDatabaseArchitectureDataType==null) return 1;
if(anotherDatabaseArchitectureDataType.dataType==null)return 1;
int difference;
difference=(this.dataType.toUpperCase()).compareTo((anotherDatabaseArchitectureDataType.dataType.toUpperCase()));
return difference;
}
}