package com.thinking.machines.dmodel.services.exceptions;
import java.util.*;
public class ServiceException extends RuntimeException
{
private Map<String,String> errors;
public ServiceException(Map<String,String> errors)
{
this.errors=errors;
}
public ServiceException()
{
this.errors=new HashMap<>();
}
public ServiceException(String message)
{
super(message);
}
public void setError(String key,String error)
{
this.errors.put(key,error);
}
public String getError(String key)
{
return this.errors.get(key);
}
public Map<String,String> getErrors()
{
return this.errors;
}
public Boolean hasErrors()
{
if(this.errors.size()==0)return false;
else return true;
}
}