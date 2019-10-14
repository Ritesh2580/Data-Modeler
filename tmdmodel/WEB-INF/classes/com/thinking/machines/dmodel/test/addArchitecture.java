import com.thinking.machines.dmframework.*;
import com.thinking.machines.tmws.annotations.*;
import com.thinking.machines.tmws.*;
import com.thinking.machines.dmframework.exceptions.*;
import java.util.*;
class architecture
{
public static void main(String gg[])
{
String name=gg[0];
int maxColumnNameWidth=Integer.parseInt(gg[1]);
int maxTableNameWidth=Integer.parseInt(gg[2]);
int maxRelationShipNameWidth=Integer.parseInt(gg[3]);
try
{
com.thinking.machines.dmodel.dl.DatabaseArchitecture db=new com.thinking.machines.dmodel.dl.DatabaseArchitecture();
db.setName(name);
db.setMaxWidthOfColumnName(maxColumnNameWidth);
db.setMaxWidthOfTableName(maxTableNameWidth);
db.setMaxWidthOfRelationshipName(maxRelationShipNameWidth);
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