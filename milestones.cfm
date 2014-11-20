<cfoutput>
    <cfif isdefined('url.mstatus')>
    <cfif #url.mstatus# eq "progress">
    <cfquery name="ms" datasource="bugtracking" result="r">
        update milestones set milestoneStatus="completed" where milestoneID=#url.mID#
    </cfquery>
    </cfif>
        <cfelse>
    <cfquery name="ms" datasource="bugtracking" result="r">
        update milestones set milestoneStatus="progress" where milestoneID=#url.milestoneID#
    </cfquery>
        </cfif>
        <cfif isdefined('flag')>
            <cflocation url="projectProfile.cfm?&projectID=#url.projectID#&flag" addtoken="false"/>
            <cfelse>
                <cflocation url="projectProfile.cfm?&projectID=#url.projectID#" addtoken="false"/>
        </cfif>
</cfoutput>