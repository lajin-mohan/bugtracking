
<cfdocument format="PDF">
   <cfoutput>
       <cfquery name="selectData" datasource="bugTracking">
           select users.userName,designations.name d,bugs.bugName,projects.projectName,
           bugs.actualStartDate,status.name s from users 
           inner join bugUsers on users.userID=bugUsers.userID 
           inner join bugs on bugs.bugID=bugUsers.bugID 
           inner join projectUsers on projectUsers.projectID=bugs.projectID 
           inner join projects on projects.projectID=projectUsers.projectID
           inner join designations on designations.designationID=users.designationID inner join                status on status.statusID=bugs.statusID and users.userID="#url.uid#" 
           order by bugs.actualStartDate desc
       </cfquery>
    
       
       <html>
           <head><link href="report.css" rel="stylesheet"></head>
           <body>
               <div class="divHeading"><h2>Project Report</h2></div>
               <div>
                   <table>
                       <tr><td class="tdAlign"><b> <label>Employee Name</b></label></td> 
                           <td class="tdAlign">                                                                                <b><cfoutput>:#selectData.userName#</cfoutput></b></td>                                        </tr>
                       <tr> <td class="tdAlign"><b> 
                             <label>Designation</b>                                                                              </label></td> 
                            <td class="tdAlign">                                                                               <b><cfoutput>:#selectData.d#</cfoutput>                                                             </b></td>
                       </tr> 
                   </table>
                       <br /><br />
                       <hr>
                           <table class="report" align="center">
                               <tr class="trBackground">
                                   <th class="tdClass">Name</th>
                                   <th class="tdClass">Project Name</th>
                                   <th class="tdClass">Bug Name</th>
                                   <th class="tdClass">Start Date</th>
                                   <th class="tdClass">Status</th>
                               </tr>
                               <cfloop query="selectData">
                                    <cfoutput>
                                        <tr> 
                                            <td class="tdClass">#userName#</td>
                                            <td class="tdClass">#projectName#</td>
                                            <td class="tdClass">#bugName#</td>
                                            <td class="tdClass">
                                                #DateFormat(actualStartDate,'dd/mm/yyyy')#
                                            </td>
                                            <td class="tdClass">#s#</td>                                                                   </tr>
                                    </cfoutput>
                                </cfloop>
                            </table>
                </div>
            </body>
       </html>
   </cfoutput>
</cfdocument>
