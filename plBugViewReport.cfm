
<cfdocument format="PDF">
   <cfoutput>
       <cfquery name="selectData" datasource="#Application.dataSourceName#">
      select b.projectID,b.bugID,b.bugName,b.bugDescription,b.estimatedstartDate,b.actualStartDate,b.estimatedEndDate,b.actualEndDate,s.name as sname,p.name as pname,se.name as sename,b.projectID as prid, proj.projectName as prname from bugs as b inner join priorities as p inner join status as s  inner join projects as proj inner join severities as se  on b.priorityID=p.priorityID and  b.statusID=s.statusID and b.projectID=proj.projectID and b.severityID=se.severityID and b.bugID="#url.bugID#"  order by b.bugName desc;  
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
                            <th class="tdClass">Bug Name</th>
                            <th class="tdClass">Bug Description</th>
                            <th class="tdClass">Estimated End Date</th>
                            <th class="tdClass">Status</th>
                        </tr>
                        <cfloop query="selectData">
                            <cfoutput>
                                <tr> 
                                    <td class="tdClass">#bugName#</td>
                                    <td class="tdClass">#bugDescription#</td>
                                    <td class="tdClass">
                                        #DateFormat(estimatedEndDate,'dd/mm/yyyy')#
                                    </td>
                                    <td class="tdClass">#sname#</td>                                                                 </tr>
                            </cfoutput>
                        </cfloop>
                    </table>
                       
                </div>
            </body>
       </html>
   </cfoutput>
</cfdocument>