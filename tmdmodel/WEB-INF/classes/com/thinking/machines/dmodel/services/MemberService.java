package com.thinking.machines.dmodel.services;
import com.thinking.machines.dmodel.services.pojo.*;
import com.thinking.machines.dmframework.*;
import com.thinking.machines.dmodel.beans.*;
import com.thinking.machines.dmodel.utility.*;
import com.thinking.machines.tmws.annotations.*;
import com.thinking.machines.tmws.*;
import com.thinking.machines.tmws.captcha.*;
import com.thinking.machines.dmframework.exceptions.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
@Path("/memberService")
public class MemberService
{
private HttpSession httpSession;
private String verificationToken;
private ServletContext servletContext;
private HttpServletRequest httpServletRequest;
public MemberService()
{
this.httpSession=null;
this.verificationToken="";
}
public void setHttpRequest(HttpServletRequest httpServletRequest)
{
this.httpServletRequest=httpServletRequest;
}
public void setHttpSession(HttpSession httpSession)
{
this.httpSession=httpSession;
}
public void setServletContext(ServletContext servletContext)
{

this.servletContext=servletContext;
}

public void sendEmail(String from,String []to,String subject,String message)
{
PostMail pm=new PostMail();
pm.postMail(from,to,subject,message);
return;
}
@Post
@InjectSession
@Path("authenticateCaptcha")
public Object authenticateCaptcha(String captchaCode)
{
try
{
Captcha c=(Captcha)this.httpSession.getAttribute(Captcha.CAPTCHA_NAME);
this.httpSession.removeAttribute(Captcha.CAPTCHA_NAME);
if(c.isValid(captchaCode))return true;
return false;
}catch(Exception e)
{
System.out.println(e);
return false;
}
}

@Post
@InjectRequest
@Path("add")
public Boolean create(Member member)
{
ErrorBean errorBean=new ErrorBean();
try
{
com.thinking.machines.dmodel.services.exceptions.ServiceException e=member.getError();
if(e.hasErrors())return false;
List<com.thinking.machines.dmodel.dl.Member> dlMembers;
DataManager dm=new DataManager();
dm.begin();
dlMembers=dm.select(com.thinking.machines.dmodel.dl.Member.class).where("emailId").eq(member.getEmailId()).query(); 
dm.end();
if(dlMembers.size()>0)
{
return false;
}
dm.begin();
dlMembers=dm.select(com.thinking.machines.dmodel.dl.Member.class).where("mobileNumber").eq(member.getMobileNumber()).query(); 
dm.end();
if(dlMembers.size()>0)
{
return false;
}
String encryptedPassword=Encryptor.encrypt(member.getPassword(),member.getFirstName());
com.thinking.machines.dmodel.dl.Member dlMember=new com.thinking.machines.dmodel.dl.Member();
dlMember.setFirstName(member.getFirstName());
dlMember.setLastName(member.getLastName());
dlMember.setPassword(encryptedPassword);
dlMember.setEmailId(member.getEmailId());
dlMember.setPasswordKey(member.getFirstName());
dlMember.setNumberOfProjects(0);
dlMember.setMobileNumber(member.getMobileNumber());
dlMember.setStatus("A");
dm.begin();
dm.insert(dlMember);
dm.end();
return true;
}
catch(Exception e)
{
System.out.println(e);
return false;
}
}


@Post
@InjectApplication
@InjectRequest
@InjectSession
@Path("memberLoginFormAuthenticator")
public  TMForward memberLoginFormAuthenticator(String emailId,String password)
{
List<com.thinking.machines.dmodel.bl.Project> blProjects=new LinkedList<>();
List<com.thinking.machines.dmodel.bl.DatabaseArchitecture> blDatabaseArchitectures;
List<com.thinking.machines.dmodel.dl.Member> dlMembers=new LinkedList<com.thinking.machines.dmodel.dl.Member>();
try
{
DataManager dataManager=new DataManager();
dataManager.begin();
dlMembers=dataManager.select(com.thinking.machines.dmodel.dl.Member.class).where("emailId").eq(emailId).query();
ErrorBean errorBean=new ErrorBean();
if(dlMembers.size()==0)
{
errorBean.setEmailId("Invalid email address");
errorBean.setPassword("Invalid password");
errorBean.setClassName("is-invalid");
this.httpServletRequest.setAttribute("errorBean",errorBean);
return new TMForward("/login.jsp");
}
com.thinking.machines.dmodel.dl.Member dlMember=dlMembers.get(0);
String vPassword=Encryptor.decrypt(dlMember.getPassword(),dlMember.getPasswordKey());
if(!(password.trim()).equals(vPassword.trim()))
{
errorBean.setPassword("Incorrect password");
errorBean.setClassName("is-invalid");
this.httpServletRequest.setAttribute("errorBean",errorBean);
return new TMForward("/login.jsp");
}
if(dlMember.getStatus()=="N")
{
return new TMForward("/verify.html");
}
this.httpSession.setAttribute("member",dlMember);
List<com.thinking.machines.dmodel.dl.Project> dlProject;
dataManager.begin();
dlProject=dataManager.select(com.thinking.machines.dmodel.dl.Project.class).where("memberCode").eq(dlMember.getCode()).query();
dataManager.end();
if(dlProject.size()!=0)
{
com.thinking.machines.dmodel.bl.Project blProject;
for(com.thinking.machines.dmodel.dl.Project p:dlProject)
{
blProject=new com.thinking.machines.dmodel.bl.Project();
blProject.setTitle(p.getTitle());
blProject.setDateOfCreation(p.getDateOfCreation());
blProject.setTimeOfCreation(p.getTimeOfCreation());
blProject.setNumberOfTable(p.getNumberOfTable());
blProject.setCanvasHeight(p.getCanvasHeight());
blProject.setCanvasWidth(p.getCanvasWidth());
blDatabaseArchitectures=(List<com.thinking.machines.dmodel.bl.DatabaseArchitecture>)this.servletContext.getAttribute("architectures");
com.thinking.machines.dmodel.bl.DatabaseArchitecture bldba=null;
for(com.thinking.machines.dmodel.bl.DatabaseArchitecture dba:blDatabaseArchitectures)
{
int e,f;
e=dba.getCode();
f=p.getDatabaseArchitectureCode();
if(e==f)
{

bldba=dba;
}
}
blProject.setDatabaseArchitecture(bldba);
blProjects.add(blProject);
}
}
System.out.println("bl projects hai:  "+blProjects);
this.httpSession.setAttribute("memberProjects",blProjects);
return new TMForward("/homePage.jsp");
}
catch(Exception e)
{
System.out.println(e);
ErrorBean errorBean=new ErrorBean();
errorBean.setClassName("is-invalid");
errorBean.setEmailId("Invalid email address");
return new TMForward("/login.jsp");
}
}
}
