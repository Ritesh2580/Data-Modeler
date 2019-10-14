import com.thinking.machines.dmodel.dl.*;
import com.thinking.machines.tmws.annotations.*;
import com.thinking.machines.dmframework.*;
import com.thinking.machines.dmframework.exceptions.*;
import java.util.*;
class abcd 
{
public static void main(String gg[])
{
try
{
DataManager dataManager=new DataManager();
dataManager.begin();
List<com.thinking.machines.dmodel.dl.Project> project=dataManager.select(com.thinking.machines.dmodel.dl.Project.class).query();
dataManager.end();
System.out.println(" project  ki size : "+project.size());
System.out.println("Done");
}
catch(Exception e)
{
System.out.println(e);
}
}
}