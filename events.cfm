<cfoutput>
    <cfquery name="projectManagerRemainders" datasource="#Application.dataSourceName#" result="pmr">
        insert into remainders(name, date, userID) values(
        <cfqueryparam value='#url.name#' CFSQLType='CF_SQL_VARCHAR'/>, 
        <cfqueryparam value='#url.date#' CFSQLType='CF_SQL_DATE'/>, 
        <cfqueryparam value='#Session.userID#' CFSQLType='CF_SQL_TINYINT'/>
        );
    </cfquery>
    <cflocation url="calendar.cfm" addtoken="false"/>
</cfoutput>
