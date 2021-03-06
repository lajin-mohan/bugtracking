<cfcomponent displayname="projectDetails">
    <cffunction name="selectBug" access="public" output="false" returnType="query">
        <cfquery name="bugs" datasource="bugTracking">
            select bugs.*,status.name,projects.projectName,severities.name s,priorities.name p from bugs inner join status on status.statusID=bugs.statusID inner join priorities on priorities.priorityID=bugs.priorityID inner join severities on severities.severityID=bugs.severityID inner join projects on projects.projectID=bugs.projectID
        </cfquery>
        <cfreturn bugs>
    </cffunction>
    <cffunction name="bugStatus" access="public" output="false" returnType="query">
        <cfargument name="value" required="true" type="string">
        <cfquery name="bugStatus" datasource="bugTracking">
             select bugs.*,status.name,projects.projectName,severities.name s,priorities.name p from bugs inner join status on status.statusID=bugs.statusID inner join priorities on priorities.priorityID=bugs.priorityID inner join severities on severities.severityID=bugs.severityID inner join projects on projects.projectID=bugs.projectID and status.statusID="#value#"
        </cfquery>
        <cfreturn bugStatus>
    </cffunction>
 <cffunction name="selectStatus" access="public" output="false" returnType="query">
        <cfquery name="status" datasource="bugTracking">
            select * from status
        </cfquery>
        <cfreturn status>
    </cffunction>
</cfcomponent>
