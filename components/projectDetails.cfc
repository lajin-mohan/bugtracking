<cfcomponent displayname="projectDetails">
    <cffunction name="selectBug" access="public" output="false" returnType="query">
        <cfquery name="bugs" datasource="#dsn#">
            select bugs.*,status.name,projects.projectName,severities.name s,priorities.name p
            from bugs inner join status on status.statusID=bugs.statusID 
            inner join priorities on priorities.priorityID=bugs.priorityID
            inner join severities on severities.severityID=bugs.severityID 
            inner join projects on projects.projectID=bugs.projectID
        </cfquery>
        <cfreturn bugs>
    </cffunction>
    <cffunction name="bugStatus" access="public" output="false" returnType="query">
        <cfargument name="value" required="true" type="string">
        <cfquery name="bugStatus" datasource="#dsn#">
             select bugs.*,status.name,projects.projectName,severities.name s,priorities.name p                  from bugs inner join status on status.statusID=bugs.statusID 
             inner join priorities on priorities.priorityID=bugs.priorityID 
             inner join severities on severities.severityID=bugs.severityID 
             inner join projects on projects.projectID=bugs.projectID and status.statusID="#value#"
        </cfquery>
        <cfreturn bugStatus>
    </cffunction>
 <cffunction name="selectStatus" access="public" output="false" returnType="query">
        <cfquery name="status" datasource="#dsn#">
            select * from status
        </cfquery>
        <cfreturn status>
    </cffunction>
     <cffunction name="selectUserBugs" access="public" output="false" returnType="query">
        <cfquery name="bugs" datasource="#dsn#">
            select bugs.bugName, bugs.bugDescription, bugs.estimatedStartDate,                                 bugs.actualStartDate, bugs.estimatedEndDate,bugs.actualEndDate, status.name from bugs               inner join bugUsers on bugs.bugID=bugUsers.bugID inner join status on  	 	   	                   status.statusID=bugs.statusID and 
            userID=<cfqueryparam value="#session.userID#" cfsqltype="cf_sql_tinyint"/>
            order by bugs.estimatedStartDate desc
        </cfquery>
        <cfreturn bugs>
    </cffunction>
</cfcomponent>
