<cfoutput>
    <cfif #url.mstatus# eq "progress">
        <cfquery name="ms" datasource="#Application.dataSourceName#" result="r">
            update milestones set milestoneStatus="completed" where 
            milestoneID = <cfqueryparam value='#url.mID#' CFSQLType='CF_SQL_TINYINT'>
        </cfquery>
            <cfelse>
        <cfquery name="ms" datasource="#Application.dataSourceName#" result="r">
            update milestones set milestoneStatus="progress" where 
            milestoneID = <cfqueryparam value='#url.mID#' CFSQLType='CF_SQL_TINYINT'>
        </cfquery>
    </cfif>
    <cfif r.recordcount>
        <cfif isdefined('flag')>
            <cflocation url="projectProfile.cfm?&projectID=#url.projectID#&flag" addtoken="false"/>
        <cfelse>
            <cflocation url="projectProfile.cfm?&projectID=#url.projectID#" addtoken="false"/>
        </cfif>
    </cfif>
</cfoutput>
