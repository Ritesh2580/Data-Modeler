import com.thinking.machines.dmodel.dl.*;
import com.thinking.machines.tmws.annotations.*;
import com.thinking.machines.dmframework.*;
import com.thinking.machines.dmframework.exceptions.*;
public class abcd 
{
public static void main(String gg[])
{
String password=java.util.UUID.randomUUID().toString();
if(password.length()>100)password=password.substring(0,100);
String password_key="password";
Administrator administrator=new Administrator();
administrator.setUsername("Ritesh2580");
administrator.setEmailId("riteshshakya2580@gmail.com");
administrator.setFirstName("Ritesh");
administrator.setLastName("Shakya");
administrator.setPassword(password);
administrator.setPasswordKey("abcd");
administrator.setMobileNumber("7692981889");
System.out.println("try");
try
{
DataManager dataManager=new DataManager();
dataManager.begin();
dataManager.insert(administrator);
dataManager.end();
System.out.println("Done");
}
catch(Exception e)
{
System.out.println(e);
}
}
}