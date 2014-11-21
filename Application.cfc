<!---
            Bug Tracker - Application CFC
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfcomponent>
    <cfset this.name="bugTracking">
    <cfset this.datasource = "bugTracking" >
    <cfset this.Sessionmanagement=true>
    <cfset this.Sessiontimeout="#createtimespan(0,10,0,0)#">
    <cfset this.applicationtimeout="#createtimespan(0,0,0,5)#">

    <cffunction name="onApplicationStart">
        <cfset Application.dataSourceName = "bugTracking" />
        <cfreturn True> 
    </cffunction>

    <cffunction name="onApplicationEnd">
        <cfargument name="ApplicationScope" required=true/>
    </cffunction>  

    <cffunction name="onSessionEnd">
        <cfargument name = "SessionScope" required=true/>
    </cffunction> 

    <cffunction name="onError"> 
        <cfargument name="Exception" required=true/> 
        <cfargument type="String" name = "EventName" required=true/> 
 
            <cfif NOT (Arguments.EventName IS onSessionEnd) OR  
                (Arguments.EventName IS onApplicationEnd)> 
            <cflocation url="error.cfm" addToken="false"/>
        </cfif> 
    </cffunction> 
</cfcomponent>

