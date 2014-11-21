<!---
            Bug Tracker - Edit Project CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfoutput>
    <cfquery name="lead" datasource="#Application.dataSourceName#" result="l">
        update projectUsers set islead=1 where userID=#url.userID#
    </cfquery>
    <cfquery name="lead2" datasource="#Application.dataSourceName#" result="l2">
        update projectUsers set islead=0 where userID!=#url.userID#
    </cfquery>
    <cfif l.recordcount>
        <cfif isdefined('flag')>
            <cflocation url="editProject.cfm?projectID=#url.projectID#&flag" addtoken="false"/>
            <cfelse>
                <cflocation url="editProject.cfm?projectID=#url.projectID#" addtoken="false"/>
        </cfif>
    </cfif>
</cfoutput>