<!---
            Bug Tracker - Logout CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfset StructDelete(Session,'userID')/>
<cfset StructDelete(Session,'roleID')/>
<cfset StructDelete(Session,'email')/>
<cfset StructDelete(Session,'firstName')/>
<cfset StructDelete(Session,'highlight1')/>
<cfset StructDelete(Session,'highlight2')/>
<cfset StructDelete(Session,'highlight3')/>
<cfset StructDelete(Session,'highlight4')/>
<cfset StructDelete(Session,'highlight5')/>
<cfset StructDelete(Session,'highlight6')/>
<cfset StructDelete(Session,'menu1')/>
<cfset StructDelete(Session,'menu2')/>
<cfset StructDelete(Session,'menu3')/>
<cfset StructDelete(Session,'menu4')/>
<cfset StructDelete(Session,'menu5')/>
<cfset StructDelete(Session,'menu6')/>
<cflocation url="index.cfm" addToken="false"/>
