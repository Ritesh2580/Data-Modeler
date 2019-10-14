package com.thinking.machines.dmodel.services.pojo;
import java.util.*;
import java.io.*;
import com.thinking.machines.dmodel.services.exceptions.*;
public class Member extends ServiceException implements Serializable 
{
private int code;
private String firstName;
private String lastName;
private String address;
private String password;
private String mobileNumber;
private String status;
private String emailId;
private int numberOfProjects;
public Member()
{
this.code=0;
this.firstName=" ";
this.lastName=" ";
this.address=" ";
this.password=" ";
this.mobileNumber=" ";
this.status=" ";
this.emailId=" ";
this.numberOfProjects=0;
}
public void setCode(int code)
{
this.code=code;
}
public void setFirstName(String firstName)
{
this.firstName=firstName;
}
public void setLastName(String lastName)
{
this.lastName=lastName;
}
public void setAddress(String address)
{
this.address=address;
}
public void setPassword(String password)
{
this.password=password;
}
public void setMobileNumber(String mobileNumber)
{
this.mobileNumber=mobileNumber;
}
public void setEmailId(String emailId)
{
this.emailId=emailId;
}
public void setStatus(String status)
{
this.status=status;
}
public void setNumberOfProjects(int numberOfProjects)
{
this.numberOfProjects=numberOfProjects;
}
public int getCode()
{
return this.code;
}
public String getFirstName()
{
return this.firstName;
}
public String getLastName()
{
return this.lastName;
}
public String getAddress()
{
return this.address;
}
public String getPassword()
{
return this.password;
}
public String getMobileNumber()
{
return this.mobileNumber;
}
public String getEmailId()
{
return this.emailId;
}
public String getStatus()
{
return this.status;
}
public int getNumberOfProjects()
{
return this.numberOfProjects;
}
private Boolean hasError()
{
int errors=0;
if((firstName.trim()).length()==0||firstName==null)
{
errors++;
setError("firstName","Invalid entry");
}
if((lastName.trim()).length()==0||lastName==null)
{
errors++;
setError("EmailId","Invalid last name");
}
if((emailId.trim()).length()==0||emailId==null)
{
errors++;
setError("EmailId","Invalid email address");
}
if((mobileNumber.trim()).length()==0||mobileNumber==null)
{
errors++;
setError("MobileNumber","Invalid mobile number");
}
if((password.trim()).length()==0||password==null)
{
errors++;
setError("Password","Invalid password");
}
if(errors==0)return false;
else return true;
}
public ServiceException getError()
{
if(hasError())return new ServiceException(getErrors());
return new ServiceException();
}
}