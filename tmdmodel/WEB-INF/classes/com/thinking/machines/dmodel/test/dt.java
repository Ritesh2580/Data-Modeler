import com.thinking.machines.dmframework.*;
import com.thinking.machines.tmws.annotations.*;
import com.thinking.machines.tmws.*;
import com.thinking.machines.dmframework.exceptions.*;
import java.util.*;
class dt
{
public static void main(String gg[])
{
String name=gg[0];
int architectureCode=Integer.parseInt(gg[1]);
int maxWidth=Integer.parseInt(gg[2]);
int defaultSize=Integer.parseInt(gg[3]);
int maxWidthofp=Integer.parseInt(gg[4]);
int b=Integer.parseInt(gg[5]);
try
{
com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType db=new com.thinking.machines.dmodel.dl.DatabaseArchitectureDataType();
db.setDataType(name);
db.setDatabaseArchitectureCode(architectureCode);
db.setMaxWidth(maxWidth);
db.setDefaultSize(defaultSize);
db.setMaxWidthOfPrecision(maxWidthofp);
if(b==1)db.setAllowAutoIncrement(true);
else db.setAllowAutoIncrement(false);
DataManager dm=new DataManager();
dm.begin();
dm.insert(db);
dm.end();
System.out.println("Successfully Add");
}
catch(Exception e)
{
System.out.println(e);
}
}
}