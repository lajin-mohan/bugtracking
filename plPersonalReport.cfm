
<cfdocument format="PDF">
   <cfoutput>

      <cfquery name="selectData" datasource="#Application.dataSourceName#">
          select timeSheet.dateTime,timeSheet.description,timeSheet.workingHour,projects.projectName,status.name,users.firstName,projects.projectID,timeSheet.productiveHours,projects.estimatedStartDate,projects.actualStartDate,timeSheet.timeSheetID from timeSheet inner join projects on timeSheet.projectID=projects.projectID inner join status on timeSheet.statusID=status.statusID inner join users on timeSheet.userID=users.userID and users.userID="#session.userID#" and projects.projectID="#url.projectID#" and users.roleID=2 order by timeSheet.dateTime desc 
       </cfquery>
                <html>
                    <head><link href="report.css" rel="stylesheet"></head>
                    <body>
                        <div class="divHeading"><h2>Time Sheet Report</h2></div>
                        <div>
                             <cfquery name="totalHours" datasource="#Application.dataSourceName#">
                            select sum(productiveHours) as totalProductive,sum(workingHour) as totalTimeSpent from timeSheet where projectID="#url.projectID#" and userID="#session.userID#"
                            </cfquery><br />
                            <table>
                                 <tr> <td class="tdAlign"><b> <label>Name</b></label></td> 
                                    <td class="tdAlign">                                                                                       <b><cfoutput>:#selectData.firstName#</cfoutput></b></td>                                  </tr>
                                <tr> <td class="tdAlign"><b> <label>Total Productive Hours</b>                                    </label></td> 
                                    <td class="tdAlign">                                                                                       <b><cfoutput>:#totalHours.totalProductive#</cfoutput>                                  </b></td></tr> 
                                <tr><td class="tdAlign"> <b><label>Total times spend</label></b></td><td class="tdAlign"><b><cfoutput>:#totalHours.totalTimeSpent#</cfoutput></b></td></tr>
                                 <tr><td class="tdAlign"> <b><label>Estimated Start Date</label></b></td><td class="tdAlign"><b><cfoutput>:#DateFormat(selectData.estimatedStartDate,'dd-mm-yyyy')#</cfoutput></b></td></tr>
                                 <tr><td class="tdAlign"> <b><label>Actual Start Date</label></b></td><td class="tdAlign"><b><cfoutput>:#DateFormat(selectData.actualStartDate,'dd-mm-yyyy')#</cfoutput></b></td></tr>
                            </table>
                            <br /><br />
                            <hr>
                            <table class="report">
                                <tr class="trBackground">
                                <th class="tdClass">Date</th>
                                <th class="tdClass">Project Name</th>
                                <th class="tdClass">Bug</th>
                                <th class="tdClass">Description</th>
                                
                                <th class="tdClass">Time Spent</th>
                                <th class="tdClass">Productive Hours</th>
                                <th class="tdClass">Status</th>
                                   </tr>
                                <cfif #selectData.RecordCount# neq 0>
                                <cfloop query="selectData">
                                     <cfquery name="bug" datasource="#Application.dataSourceName#">
                                   select bugs.bugName,bugs.bugID,timeSheet.timeSheetID from bugs,timeSheet where timeSheet.bugID=bugs.bugID and timeSheet.projectID="#selectData.projectID#" and timeSheet.userID="#session.userID#" and timeSheet.timeSheetID="#selectData.timeSheetID#"
                               </cfquery>
                                    <cfoutput>
                                        <tr> 
                                    <td class="tdClass">#DateFormat(dateTime,'dd/mm/yyyy')#</td>
                                            <td class="tdClass">#projectName#</td>
                                            <cfif #bug.RecordCount# GT 0 and #bug.timeSheetID# eq #selectData.timeSheetID#>
                                                <td class="tdClass">#bug.bugName#</td>
                                                <cfelse>
                                                     <td class="tdClass">------</td>
                                                </cfif>
                                            <td class="tdClass">#description#</td>
                                            
                                            <td class="tdClass">#workingHour#</td>
                                            <td class="tdClass">#productiveHours#</td>
                                            <td class="tdClass">#name#</td>                                                                 </tr>
                                    </cfoutput>
                                 </cfloop>
                                </cfif>
                            </table>
                       
                        </div>
                    </body>
       </html>
   </cfoutput>
</cfdocument>