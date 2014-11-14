
<cfdocument format="PDF">
   <cfoutput>

      <cfquery name="selectData" datasource="bugTracking">
          select timeSheet.dateTime,timeSheet.description,timeSheet.workingHour,bugs.bugName,projects.projectName,status.name,users.userName,bugs.bugID,timeSheet.productiveHours,bugs.estimatedStartDate,bugs.actualStartDate from timeSheet inner join bugs on timeSheet.bugID=bugs.bugID inner join projects on projects.projectID=bugs.projectID inner join status on timeSheet.statusID=status.statusID inner join users on timeSheet.userID=users.userID and users.userID="#session.userID#" and bugs.bugID="#url.bugID#" and users.roleID=3 or users.roleID=4 order by timeSheet.dateTime desc 
       </cfquery>
                <html>
                    <head><link href="report.css" rel="stylesheet"></head>
                    <body>
                        <div class="divHeading"><h2>Time Sheet Report</h2></div>
                        <div>
                             <cfquery name="totalHours" datasource="bugTracking">
                            select sum(productiveHours) as totalProductive,sum(workingHour) as totalTimeSpent from timeSheet where bugID="#url.bugID#" and userID="#session.userID#"
                            </cfquery><br />
                            <table>
                                 <tr> <td class="tdAlign"><b> <label>Name</b></label></td> 
                                    <td class="tdAlign">                                                                                       <b><cfoutput>:#selectData.userName#</cfoutput></b></td>                                  </tr>
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
                                
                                <cfloop query="selectData">
                                    <cfoutput>
                                        <tr> 
                                    <td class="tdClass">#DateFormat(dateTime,'dd/mm/yyyy')#</td>
                                            <td class="tdClass">#projectName#</td>
                                            <td class="tdClass">#bugName#</td>
                                            <td class="tdClass">#description#</td>
                                            
                                            <td class="tdClass">#workingHour#</td>
                                            <td class="tdClass">#productiveHours#</td>
                                            <td class="tdClass">#name#</td>                                                                 </tr>
                                    </cfoutput>
                                 </cfloop>
                            </table>
                       
                        </div>
                    </body>
       </html>
   </cfoutput>
</cfdocument>