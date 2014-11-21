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

        <cfif isdefined("exception.rootcause")> 
            <cfoutput>  
                Root Cause Message: #exception.rootcause.message#
            </cfoutput> 
        </cfif> 
 
        <cfif NOT (Arguments.EventName IS onSessionEnd) OR  
            (Arguments.EventName IS onApplicationEnd)> 
            <cfoutput> 
                <h2>An unexpected error occurred.</h2> 
                <p>Please provide the following information to technical support:</p> 
                <p>Error Event: #EventName#</p> 
                <p>Error details:<br> 
                <cfdump var=#exception#></p> 
            </cfoutput> 
        </cfif>    
    </cffunction> 
</cfcomponent>

