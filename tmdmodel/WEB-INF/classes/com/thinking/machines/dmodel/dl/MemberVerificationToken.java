package com.thinking.machines.dmodel.dl;
import com.thinking.machines.dmframework.annotations.*;
@Display(value="Member Verification Token")
@Table(name="member_verification_token")
public class MemberVerificationToken implements java.io.Serializable,Comparable<MemberVerificationToken>
{
@Sort(priority=1)
@Display(value="member code")
@Column(name="member_code")
private Integer memberCode;
@Display(value="token")
@Column(name="token")
private String token;
public MemberVerificationToken()
{
this.memberCode=null;
this.token=null;
}
public void setMemberCode(Integer memberCode)
{
this.memberCode=memberCode;
}
public Integer getMemberCode()
{
return this.memberCode;
}
public void setToken(String token)
{
this.token=token;
}
public String getToken()
{
return this.token;
}
public boolean equals(Object object)
{
if(object==null) return false;
if(!(object instanceof MemberVerificationToken)) return false;
MemberVerificationToken anotherMemberVerificationToken=(MemberVerificationToken)object;
if(this.memberCode==null && anotherMemberVerificationToken.memberCode==null) return true;
if(this.memberCode==null || anotherMemberVerificationToken.memberCode==null) return false;
return this.memberCode.equals(anotherMemberVerificationToken.memberCode);
}
public int compareTo(MemberVerificationToken anotherMemberVerificationToken)
{
if(anotherMemberVerificationToken==null) return 1;
if(this.memberCode==null && anotherMemberVerificationToken.memberCode==null) return 0;
int difference;
if(this.memberCode==null && anotherMemberVerificationToken.memberCode!=null) return 1;
if(this.memberCode!=null && anotherMemberVerificationToken.memberCode==null) return -1;
difference=this.memberCode.compareTo(anotherMemberVerificationToken.memberCode);
return difference;
}
public int hashCode()
{
if(this.memberCode==null) return 0;
return this.memberCode.hashCode();
}
}
