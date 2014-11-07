<cfif isdefined('url.userID') and isdefined('url.removeProjectMember')>
    <cfquery name="deleteEmployee" datasource="bugTracking">
        update projectUsers set hide=1 where userID=#url.userID#
        and projectID=#url.projectID#;
    </cfquery>
    <cfquery name="deleteEmployee2" datasource="bugTracking" result="de2">
        select projectID from projectUsers where userID=#url.userID#
        and projectID=#url.projectID#
    </cfquery>
    <cfif !de2.recordcount>
        <cfquery name="deleteEmployee3" datasource="bugTracking">
            update users set noProjects=1 where userID=#url.userID#
        </cfquery>
    </cfif>
    <cfif isdefined('flag')>
        <cflocation url="editProject.cfm?projectID=#url.projectID#&flag" addToken="false"/>
        <cfelse>
            <cflocation url="editProject.cfm?projectID=#url.projectID#" addToken="false"/>
    </cfif>
    <cfelseif isdefined('url.userID')>
        <cfquery name="deleteEmployee" datasource="bugTracking">
            update users set hide=1 where userID=#url.userID#;
        </cfquery>
        <cflocation url="employeeDetails.cfm" addToken="false"/>
    <cfelseif isdefined('url.bugID')>
        <cfquery name="deleteBug" datasource="bugTracking">
            update bugs set statusID=6 where bugID=#url.bugID#;
        </cfquery>
        <cflocation url="bugDetails.cfm?pid=#url.projectID#" addToken="false"/>
    <cfelseif isdefined('url.projectID')>
        <cfquery name="deleteProject" datasource="bugTracking">
            update projects set statusID=6 where projectID=#url.projectID#;
        </cfquery>
        <cflocation url="projectDetails.cfm" addToken="false"/>
        
</cfif>