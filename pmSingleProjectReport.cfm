
<cfdocument format="PDF">
   <cfoutput>
       <cfquery name="selectData" datasource="bugTracking">
           select  projects.projectName,projects.estimatedStartDate,
           projects.actualStartDate,users.userName,status.name,
           projects.projectDescription from projects 
           inner join users on users.userID=projects.userID 
           inner join status on status.statusID=projects.statusID and                                          projects.projectID="#url.pid#"
       </cfquery>
       <html>
           <head><link href="report.css" rel="stylesheet"></head>
           <body>
               <div class="divHeading"><h2>Project Report</h2></div>
               <div>
                   <cfquery name="totalHours" datasource="bugTracking">
                       select sum(productiveHours) as totalProductive,
                       sum(workingHour) as totalTimeSpent from timeSheet 
                       where projectID="#url.pid#"
                    </cfquery><br />
                    <table>
                        <tr> <td class="tdAlign"><b> <label>Project Name</b></label></td> 
                              <td class="tdAlign">                                                                               <b><cfoutput>:#selectData.projectName#</cfoutput></b></td>                                   </tr>
                        <tr><td class="tdAlign"> <b><label>Estimated Start Date</label></b></td>
                            <td class="tdAlign"><b>
                                <cfoutput>
                                    :#DateFormat(selectData.estimatedStartDate,'dd-mm-yyyy')#
                                </cfoutput></b></td>
                        </tr>
                        <tr><td class="tdAlign"> <b><label>Actual Start Date</label></b></td>
                            <td class="tdAlign"><b>
                                <cfoutput>
                                    :#DateFormat(selectData.actualStartDate,'dd-mm-yyyy')#                                         </cfoutput></b></td>
                        </tr>
                    </table>
                    <br /><br />
                    <hr>
                    <table class="report">
                        <tr class="trBackground">
                            <th class="tdClass">Project Name</th>
                            <th class="tdClass">Project Description</th>
                            <th class="tdClass">Estimated Start Date</th>
                            <th class="tdClass">Actual Start Date</th>
                            <th class="tdClass">Project Lead</th>
                            <th class="tdClass">Status</th>
                        </tr>
                        <cfloop query="selectData">
                            <cfoutput>
                                <tr> 
                                    <td class="tdClass">#projectName#</td>
                                    <td class="tdClass">#projectDescription#</td>
                                    <td class="tdClass">
                                        #DateFormat(estimatedStartDate,'dd/mm/yyyy')#
                                    </td>
                                    <td class="tdClass">
                                        #DateFormat(actualStartDate,'dd/mm/yyyy')#
                                    </td>
                                    <td class="tdClass">#userName#</td>
                                    <td class="tdClass">#name#</td>                                                                 </tr>
                            </cfoutput>
                        </cfloop>
                    </table>
                       
                </div>
            </body>
       </html>
   </cfoutput>
</cfdocument>