<!---
            Bug Tracker - Application CFC
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfcomponent>
    <cfset this.name="bugTracking">
    <cfset this.Sessionmanagement=true>
    <cfset this.Sessiontimeout="#createtimespan(0,10,0,0)#">
    <cfset this.applicationtimeout="#createtimespan(5,0,0,0)#">
</cfcomponent>

