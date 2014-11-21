
<cfdocument format="PDF">
   <cfoutput>
       <cfquery name="empDetails" datasource="#Application.dataSourceName#">
           select users.userName,designations.name d from users 
           inner join designations on designations.designationID=users.designationID and                      users.userID="#url.uid#" 
       </cfquery>
       <cfquery name="projectlist" datasource="#Application.dataSourceName#">
           select projects.projectName,
           projects.actualStartDate,status.name s,projects.projectID from                                      status,projects,projectUsers where projects.projectID=projectUsers.projectID and                    status.statusID=projects.statusID and
           projectUsers.userID="#url.uid#" 
       </cfquery>
     
      
       <html>
           <head><link href="report.css" rel="stylesheet"></head>
           <body>
               <div class="divHeading"><h2>Project Report</h2></div>
               <div>
                   <table>
                       <tr><td class="tdAlign"><b> <label>Employee Name</b></label></td> 
                           <td class="tdAlign">                                                                                <b><cfoutput>:#empDetails.userName#</cfoutput></b></td>                                        </tr>
                       <tr> <td class="tdAlign"><b> 
                             <label>Designation</b>                                                                              </label></td> 
                            <td class="tdAlign">                                                                               <b><cfoutput>:#empDetails.d#</cfoutput>                                                             </b></td>
                       </tr> 
                   </table>
                       <br /><br />
                       <hr>
                   <cfloop query="projectlist">
                       <table><tr><td class="tdAlign"><b><label>Project:</label></b></td>
                       <td class="tdAlign"><b><label>#projectlist.projectName#</label></b></td>                            </tr></table>
                       <cfquery name="selectData" datasource="#Application.dataSourceName#">
                       select users.userName,designations.name d,bugs.bugName,projects.projectName,
                       bugs.estimatedStartDate,status.name s,projects.projectID from users 
                       inner join bugUsers on users.userID=bugUsers.userID 
                       inner join bugs on bugs.bugID=bugUsers.bugID 
                       inner join projects on projects.projectID=bugs.projectID
                       inner join designations on designations.designationID=users.designationID                          inner join status on status.statusID=bugs.statusID and                                              users.userID="#url.uid#" and bugs.projectID=#projectlist.projectID#
                       order by bugs.actualStartDate desc
                       </cfquery>
                          <cfif selectData.RecordCount neq 0 and (#projectlist.projectID# eq #selectData.projectID#)>
                           <table class="report" align="center">
                               <tr class="trBackground">
                                   <th class="tdClass">Bug Name</th>
                                   <th class="tdClass">Start Date</th>
                                   <th class="tdClass">Status</th>
                               </tr>
                              
                               <cfloop query="selectData">
                                    <cfoutput>
                                        <tr> 
                                            <td class="tdClass">#bugName#</td>
                                            <td class="tdClass">
                                                #DateFormat(estimatedStartDate,'dd/mm/yyyy')#
                                            </td>
                                            <td class="tdClass">#s#</td>                                                                   </tr>
                                    </cfoutput>
                                </cfloop>
                          
                            </table>
                            <cfelse>
                            &nbsp;<cfoutput>Bugs not assigned</cfoutput>
                      </cfif><hr>
                    </cfloop>
                </div>
            </body>
       </html>
    </cfoutput>
</cfdocument>
