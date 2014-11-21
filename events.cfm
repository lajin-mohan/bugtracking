<cfoutput>
    <cfset remainderDate=#dateformat(url.date,'yyyy-mm-dd')#/>
    <cfquery name="projectManagerRemainders" datasource="#Application.dataSourceName#" result="pmr">
        insert into remainders(name, date, userID)
        values('#url.name#', '#remainderDate#', #Session.userID#)
    </cfquery>
    <cflocation url="calendar.cfm" addtoken="false"/>
</cfoutput>