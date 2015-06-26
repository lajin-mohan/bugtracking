<cfcomponent displayname="projectDtls">
    <cffunction name="selectBug" access="public" output="false" returnType="query">
         <cfargument name="pjctID" required="false" type="string">
        <cfquery name="bugs" datasource="#Application.dataSourceName#">
            select bugs.*,status.name,projects.projectName,severities.name s,priorities.name p from bugs inner join status on status.statusID=bugs.statusID inner join priorities on priorities.priorityID=bugs.priorityID inner join severities on severities.severityID=bugs.severityID inner join projects on projects.projectID=bugs.projectID and bugs.projectID="#pjctID#"
        </cfquery>
        <cfreturn bugs>
    </cffunction>
    <cffunction name="bugStatus" access="public" output="false" returnType="query">
        <cfargument name="value" required="true" type="string">
            <cfargument name="pjctID" required="true" type="string">
        <cfquery name="bugStatus" datasource="#Application.dataSourceName#">
             select bugs.*,status.name,projects.projectName,severities.name s,priorities.name p from bugs inner join status on status.statusID=bugs.statusID inner join priorities on priorities.priorityID=bugs.priorityID inner join severities on severities.severityID=bugs.severityID inner join projects on projects.projectID=bugs.projectID and status.statusID="#value#" and bugs.projectID="#pjctID#"
        </cfquery>
        <cfreturn bugStatus>
    </cffunction>
 <cffunction name="selectStatus" access="public" output="false" returnType="query">
        <cfquery name="status" datasource="#Application.dataSourceName#">
            select * from status
        </cfquery>
        <cfreturn status>
    </cffunction>
     <cffunction name="teamLeadProjectDetails" access="public" output="false" returnType="query">
        <cfquery name="projects" datasource="#Application.dataSourceName#">
            select projects.projectID, projects.projectName,status.name,projects.estimatedStartDate,projects.actualEndDate               from projects inner join status on status.statusID=projects.statusID inner join                     projectUsers on projects.projectID=projectUsers.projectID and projectUsers.userId="#session.userID#" and projectUsers.hide=0;
        </cfquery>
        <cfreturn projects>
    </cffunction>
          <cffunction name="teamLeadProjectDetailsOnStatus" access="public" output="false" returnType="query">
        <cfquery name="projects" datasource="#Application.dataSourceName#">
            select projects.projectID, projects.projectName,status.name,projects.estimatedStartDate,projects.actualEndDate from projects inner join status on status.statusID=projects.statusID inner join projectUsers on projects.projectID=projectUsers.projectID and projectUsers.userId="#session.userID#" and status.statusID="#value#" and projectUsers.hide=0
        </cfquery>
        <cfreturn projects>
    </cffunction>
</cfcomponent>
