<cfcomponent displayname="projectDtls">
    <cffunction name="selectUserBugs" access="public" output="false" returnType="query">
        <cfquery name="selectbugs" datasource="bugTracking">
        select bugs.bugName,bugs.bugID from bugs inner join bugUsers on bugs.bugID=bugUsers.bugID and bugUsers.userID="#session.userID#" 
        </cfquery>
        <cfreturn selectbugs>
    </cffunction>
    <cffunction name="addTimeSheet">
        <cfquery name="addTimeSheet" datasource="bugTracking">
            insert into timeSheet (description,workingHour,dateTime,bugID,userID,productiveHours,statusID) values ('#form.description#',#form.hours#,'#DateFormat(now(),'yyyy/mm/dd')#',#form.bug#,#session.userID#,#form.productiveHours#,'#form.status#')
        </cfquery>
    </cffunction>
    <cffunction name="selectBugDetails" access="public" output="false" returnType="query">
        <cfquery name="selectbugs" datasource="bugTracking">
            select timeSheet.dateTime,timeSheet.description,timeSheet.workingHour,bugs.bugName,projects.projectName,status.name,users.userName,bugs.bugID,timeSheet.productiveHours from timeSheet inner join bugs on timeSheet.bugID=bugs.bugID inner join projects on projects.projectID=bugs.projectID inner join status on timeSheet.statusID=status.statusID inner join users on timeSheet.userID=users.userID and users.userID="#session.userID#" order by timeSheet.dateTime desc
        </cfquery>
        <cfreturn selectbugs>
    </cffunction>
  <cffunction name="selectBugOnDate" access="public" output="false" returnType="query">'
      <cfargument name="fromDate" required="true" type="string">
      <cfargument name="toDate" required="true" type="string">
        <cfquery name="selectbugs" datasource="bugTracking">
            select timeSheet.dateTime,timeSheet.description,timeSheet.workingHour,bugs.bugName,projects.projectName,status.name,users.userName,bugs.bugID,timeSheet.productiveHours from timeSheet inner join bugs on timeSheet.bugID=bugs.bugID inner join projects on projects.projectID=bugs.projectID inner join status on timeSheet.statusID=status.statusID inner join users on timeSheet.userID=users.userID and users.userID="#session.userID#" and timeSheet.dateTime between "#fromDate#" and "#toDate#"
        </cfquery>
        <cfreturn selectbugs>
    </cffunction>       
</cfcomponent>