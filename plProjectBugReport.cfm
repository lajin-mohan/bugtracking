
<cfdocument format="PDF">
   <cfoutput>
       <cfquery name="selectData" datasource="#Application.dataSourceName#">
        select b.bugID, b.bugName,b.bugDescription,b.projectID,b.estimatedEndDate,p.name as n ,s.name as s from bugs as b inner join priorities as p inner join status as s on b.priorityID=p.priorityID and  b.statusID=s.statusID and b.projectID="#url.p#" and b.statusID!=6 order by b.bugName desc;
                             
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
                                    <td class="tdClass">#s#</td>                                                                 </tr>
                            </cfoutput>
                        </cfloop>
                    </table>
                       
                </div>
            </body>
       </html>
   </cfoutput>
</cfdocument>