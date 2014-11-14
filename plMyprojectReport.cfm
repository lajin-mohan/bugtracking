
<cfdocument format="PDF">
   <cfoutput>

      <cfquery name="selectData" datasource="bugTracking">
         select projects.projectName,projects.estimatedEndDate,status.name from projects 
          inner join projectUsers on projects.projectID=projectUsers.projectID 
          inner join status on status.statusID=projects.statusID 
          inner join users on users.userID=projectUsers.userID 
          and users.userID="#session.userID#" and isLead=1
        
       </cfquery>
                <html>
                    <head><link href="report.css" rel="stylesheet"></head>
                    <body>
                        <div class="divHeading"><h2>Project Report</h2></div>
                        <div>
                            
                            <br /><br />
                            <hr>
                            <table class="report" align="center">
                                <tr class="trBackground">
                                
                                <th class="tdClass">Project Name</th>
                                <th class="tdClass">Dead Line</th>
                               
                                <th class="tdClass">Status</th>
                                   </tr>
                                
                                <cfloop query="selectData">
                                    <cfoutput>
                                        <tr> 
                                           <td class="tdClass">#projectName#</td>
                            <td class="tdClass">#DateFormat(estimatedEndDate,'dd/mm/yyyy')#</td>
                         
                                            <td class="tdClass">#name#</td>                                                                 </tr>
                                    </cfoutput>
                                 </cfloop>
                            </table>
                       
                        </div>
                    </body>
       </html>
   </cfoutput>
</cfdocument>