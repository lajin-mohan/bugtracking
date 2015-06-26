<cfcomponent displayname="testerHistory">
    <cffunction name="selectBug" access="public" output="false" returnType="query">
        <cfquery name="bugs" datasource="#Application.dataSourceName#">
       select bugs.bugName,status.name,logs.loggedTime from bugs inner join status on
status.statusID=bugs.statusID inner join logs on logs.bugID=bugs.bugID  
        </cfquery>
        
        <cfreturn bugs>
    </cffunction>
    <cffunction name="bugStatus" access="public" output="false" returnType="query">
        <cfargument name="value" required="true" type="string">
        <cfquery name="bugStatus" datasource="#Application.dataSourceName#">
              select bugs.bugName,status.name,logs.loggedTime from bugs inner join status on status.statusID=bugs.statusID inner join logs on logs.bugID=bugs.bugID and status.statusID="#value#" </cfquery>
        <cfreturn bugStatus>
    </cffunction>
 
</cfcomponent>
