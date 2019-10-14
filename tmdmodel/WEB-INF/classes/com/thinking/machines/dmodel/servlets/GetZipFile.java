package com.thinking.machines.dmodel.servlets;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.text.*;
import com.google.gson.*;

public class GetZipFile extends HttpServlet
{
public void doGet(HttpServletRequest request,HttpServletResponse response)
{
try
{

java.nio.file.Path currentRelativePath=java.nio.file.Paths.get("");
String path=currentRelativePath.toAbsolutePath().toString();
System.out.println(path);
//path=path.substring(0,path.indexOf("bin"));
//path=path+"\\webapps\\tmdmodel\\temp\\";
File file=new File(path+"Classes.zip");
InputStream fis = new FileInputStream(file);
ServletContext ctx=getServletContext();
String mimeType = ctx.getMimeType(file.getAbsolutePath());
response.setContentType(mimeType != null? mimeType:"application/octet-stream");
response.setContentLength((int) file.length());
response.setHeader("Content-Disposition", "attachment; filename=\"" + "dlClasses.zip" + "\"");
ServletOutputStream os = response.getOutputStream();
byte[] bufferData = new byte[1024];
int read=0;
while((read = fis.read(bufferData))!= -1)
{
os.write(bufferData, 0, read);
}
os.flush();
os.close();
fis.close();
file.delete();
System.out.println("File uploaded to client successfully");
}catch(Exception exception)
{
}
}


}
