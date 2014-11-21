
<cfcomponent displayname="projectDtls">
    <cffunction name="selectUserBugs" access="public" output="false" returnType="query">
        <cfquery name="selectbugs" datasource="#Application.dataSourceName#">
        select bugs.bugName,bugs.bugID from bugs inner join bugUsers on bugs.bugID=bugUsers.bugID and bugUsers.userID="#session.userID#" 
        </cfquery>
        <cfreturn selectbugs>
    </cffunction>
    <cffunction name="addTimeSheet">
        <cfquery name="projectid" datasource="#Application.dataSourceName#">
             select projectID from bugs where bugID="#form.bug#"
        </cfquery>
        <cfquery name="addTimeSheet" datasource="#Application.dataSourceName#">
           
            insert into timeSheet (description,workingHour,dateTime,bugID,userID,productiveHours,statusID,projectID) values ('#form.description#',#form.hours#,'#DateFormat(form.editedDate,'yyyy/mm/dd')#',#form.bug#,#session.userID#,#form.productiveHours#,'#form.status#','#projectid.projectID#')
        </cfquery>
    </cffunction>
    <cffunction name="selectBugDetails" access="public" output="false" returnType="query">
        <cfquery name="selectBugDetails" datasource="#Application.dataSourceName#">
            select timeSheet.dateTime,timeSheet.description,timeSheet.workingHour,bugs.bugName,projects.projectName,status.name,users.firstName,bugs.bugID,timeSheet.productiveHours from timeSheet inner join bugs on timeSheet.bugID=bugs.bugID inner join projects on projects.projectID=bugs.projectID inner join status on timeSheet.statusID=status.statusID inner join users on timeSheet.userID=users.userID and users.userID="#session.userID#" order by timeSheet.dateTime desc
        </cfquery>
        <cfreturn selectBugDetails>
    </cffunction>
  <cffunction name="selectBugOnDate" access="public" output="false" returnType="query">'
      <cfargument name="fromDate" required="true" type="string">
      <cfargument name="toDate" required="true" type="string">
        <cfquery name="selectBugOnDate" datasource="#Application.dataSourceName#">
            select timeSheet.dateTime,timeSheet.description,timeSheet.workingHour,bugs.bugName,projects.projectName,status.name,users.firstName,bugs.bugID,timeSheet.productiveHours from timeSheet inner join bugs on timeSheet.bugID=bugs.bugID inner join projects on projects.projectID=bugs.projectID inner join status on timeSheet.statusID=status.statusID inner join users on timeSheet.userID=users.userID and users.userID="#session.userID#" and timeSheet.dateTime between "#fromDate#" and "#toDate#"
        </cfquery>
        <cfreturn selectBugOnDate>
    </cffunction> 
    <cffunction name="pmDetails" access="public" output="false" returnType="query">
         <cfquery name="getdetails" datasource="#Application.dataSourceName#">
                                   select timeSheet.dateTime,projects.projectName,timeSheet.description,timeSheet.workingHour,timeSheet.productiveHours,status.name,projects.projectID,timeSheet.timeSheetID from timeSheet inner join status on timeSheet.statusID=status.statusID inner join projectUsers on timeSheet.userID=projectUsers.userID inner join projects on projects.projectID=timeSheet.projectID and timeSheet.userID="#Session.userID#" and timeSheet.hide=0 and projectUsers.projectID=projects.projectID
       </cfquery>
        <cfreturn getdetails>
    </cffunction>
           <cffunction name="pmDetailsOnDate" access="public" output="false" returnType="query">
               <cfargument name="fromDate" required="true" type="string">
      <cfargument name="toDate" required="true" type="string">
         <cfquery name="getdetails" datasource="#Application.dataSourceName#">
                                   select timeSheet.dateTime,projects.projectName,timeSheet.description,timeSheet.workingHour,timeSheet.productiveHours,status.name,projects.projectID,timeSheet.timeSheetID from timeSheet inner join status on timeSheet.statusID=status.statusID inner join projectUsers on timeSheet.userID=projectUsers.userID inner join projects on projects.projectID=timeSheet.projectID and timeSheet.userID="#session.userID#" and timeSheet.dateTime between "#fromDate#" and "#toDate#" and timeSheet.hide=0 and projectUsers.projectID=projects.projectID
       </cfquery>
    <cfreturn getdetails>
    </cffunction>
<cffunction name="plDetails" access="public" output="false" returnType="query">
         <cfquery name="getdetails" datasource="#Application.dataSourceName#">
                                   select timeSheet.dateTime,projects.projectName,timeSheet.description,timeSheet.workingHour,timeSheet.productiveHours,status.name,projects.projectID,timeSheet.timeSheetID from timeSheet inner join status on timeSheet.statusID=status.statusID inner join users on timeSheet.userID=users.userID inner join projects on projects.projectID=timeSheet.projectID and timeSheet.userID="#session.userID#" and timeSheet.hide=0 
       </cfquery>
        <cfreturn getdetails>
    </cffunction>
 <cffunction name="plDetailsOnDate" access="public" output="false" returnType="query">
    <cfargument name="fromDate" required="true" type="string">
    <cfargument name="toDate" required="true" type="string">
         <cfquery name="getdetails" datasource="#Application.dataSourceName#">
                               select timeSheet.dateTime,projects.projectName,timeSheet.description,timeSheet.workingHour,timeSheet.productiveHours,status.name,projects.projectID,timeSheet.timeSheetID from timeSheet inner join status on timeSheet.statusID=status.statusID inner join users on timeSheet.userID=users.userID inner join projects on projects.projectID=timeSheet.projectID and timeSheet.userID=#session.userID# and  timeSheet.hide=0 and timeSheet.dateTime between "#DateFormat(fromDate,'yyyy/mm/dd')#" and "#DateFormat(toDate,'yyyy/mm/dd')#"
       </cfquery>
     <cfreturn getdetails>
    </cffunction>
<cffunction name="updateUserTimeSheet">
    <cfquery name="value" datasource="#Application.dataSourceName#">
       update timeSheet set description='#form.description#',workingHour='#form.hours#',productiveHours='#form.productiveHours#',statusID='#form.status#',dateTime='#DateFormat(form.editedDate,'yyyy/mm/dd')#' where bugId="#url.bugID#" and userID="#session.userID#"
    </cfquery>
</cffunction>    
<cffunction name="updatePlTimeSheet">
    <cfquery name="value" datasource="#Application.dataSourceName#">
       update timeSheet set description='#form.description#',workingHour='#form.hours#',productiveHours='#form.productiveHours#',statusID='#form.status#',dateTime='#DateFormat(form.editedDate,'yyyy/mm/dd')#' where bugId="#url.bugID#" and userID="#session.userID#" and projectID="#url.pid#"
    </cfquery>
</cffunction>  
<cffunction name="updatePmTimeSheet">
    <cfquery name="value" datasource="#Application.dataSourceName#">
       update timeSheet set description='#form.description#',workingHour='#form.hours#',productiveHours='#form.productiveHours#',statusID='#form.status#',dateTime='#DateFormat(form.editedDate,'yyyy/mm/dd')#' where userID="#session.userID#" and projectID="#url.pid#"
    </cfquery>
</cffunction>     
</cfcomponent>
