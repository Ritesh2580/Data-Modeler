package com.thinking.machines.dmodel.bl;
import com.thinking.machines.dmodel.bl.*;
import java.util.*;
public class DatabaseTableRelationship implements java.io.Serializable
{
private String name;
private String parentTable;
private String parentTableField;
private String childTable;
private List<String> childTableFields;
public DatabaseTableRelationship()
{
this.name=" ";
this.parentTable=null;
this.parentTableField=null;
this.childTableFields=new LinkedList<String>();
}
public void setParentTable(String parentTable)
{
this.parentTable=parentTable;
}
public String getParentTable()
{
return this.parentTable;
}
public void setParentTableField(String parentTableField)
{
this.parentTableField=parentTableField;
}
public String getParentTableField()
{
return this.parentTableField;
}
public void setChildTableFields(List<String> childTableFields)
{
this.childTableFields=childTableFields;
}
public List<String> getChildTableFields()
{
return this.childTableFields;
} 
public void setChildTable(String childTable)
{
this.childTable=childTable;
}
public String getChildTable()
{
return this.childTable;
}
public void setName(String name)
{
this.name=name;
}
public String getName()
{
return this.name;
}
}