package com.thinking.machines.dmodel.beans;
import java.util.*;
public class ErrorBean implements java.io.Serializable
{
private String emailId;
private String password;
private String passwordKey;
private String firstName;
private String lastName;
private String mobileNumber;
private String className;
public ErrorBean()
{
this.emailId=null;
this.password=null;
this.passwordKey=null;
this.firstName=null;
this.lastName=null;
this.mobileNumber=null;
this.className=" ";
}
public void setClassName(String className)
{
this.className=className;
}
public String getClassName()
{
return this.className;
}
public void setEmailId(String emailId)
{
this.emailId=emailId;
}
public String getEmailId()
{
return this.emailId;
}
public void setPassword(String password)
{
this.password=password;
}
public String getPassword()
{
return this.password;
}
public void setPasswordKey(String passwordKey)
{
this.passwordKey=passwordKey;
}
public String getPasswordKey()
{
return this.passwordKey;
}
public void setFirstName(String firstName)
{
this.firstName=firstName;
}
public String getFirstName()
{
return this.firstName;
}
public void setLastName(String lastName)
{
this.lastName=lastName;
}
public String getLastName()
{
return this.lastName;
}
public void setMobileNumber(String mobileNumber)
{
this.mobileNumber=mobileNumber;
}
public String getMobileNumber()
{
return this.mobileNumber;
}


}
