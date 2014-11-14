
<cfdocument format="PDF">
   <cfoutput>

      <cfquery name="selectData" datasource="bugTracking">
         select projects.projectName,projects.estimatedStartDate,projects.actualStartDate,users.userName,status.name from projects inner join users on users.userID=projects.userID inner join status on status.statusID=projects.statusID 
        
       </cfquery>
                <html>
                    <head><link href="report.css" rel="stylesheet"></head>
                    <body>
                        <div class="divHeading"><h2>Project Report</h2></div>
                        <div>
                            
                            <br /><br />
                            <hr>
                            <table class="report">
                                <tr class="trBackground">
                                
                                <th class="tdClass">Project Name</th>
                                <th class="tdClass">Estimated Start Date</th>
                                <th class="tdClass">Actual Start Date</th>
                                <th class="tdClass">Project Lead</th>
                                <th class="tdClass">Status</th>
                                   </tr>
                                
                                <cfloop query="selectData">
                                    <cfoutput>
                                        <tr> 
                                           <td class="tdClass">#projectName#</td>
                            <td class="tdClass">#DateFormat(estimatedStartDate,'dd/mm/yyyy')#</td>
                            <td class="tdClass">#DateFormat(actualStartDate,'dd/mm/yyyy')#</td>
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