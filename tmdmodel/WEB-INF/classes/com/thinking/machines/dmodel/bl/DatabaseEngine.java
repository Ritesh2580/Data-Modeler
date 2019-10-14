package com.thinking.machines.dmodel.bl;
public class DatabaseEngine implements java.io.Serializable
{
private String name;
private int code;
private int architectureCode;
public DatabaseEngine()
{
this.name=" ";
this.code=0;
this.architectureCode=0;
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
public void setArchitectureCode(int architectureCode)
{
this.architectureCode=architectureCode;
}
public int getArchitectureCode()
{
return this.architectureCode;
}
}