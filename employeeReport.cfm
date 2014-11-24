<cfdocument format="PDF">
    <cfoutput>
<cfinvoke component="components.timeSheet" method="selectBugDetails" returnVariable="getdetails"></cfinvoke> 
                <html>
                    <head><link href="report.css" rel="stylesheet"></head>
                    <body>
                        <div class="divHeading"><h2>Time Sheet Report</h2></div>
                        <div>
                            <table class="report">
                                <tr class="trBackground">
                                <th class="tdClass">Date</th>
                                <th class="tdClass">Project Name</th>
                                <th class="tdClass">Bug</th>
                                <th class="tdClass">Description</th>
                                <th class="tdClass">Developer</th>
                                <th class="tdClass">Time Spent</th>
                                <th class="tdClass">Productive Hours</th>
                                <th class="tdClass">Status</th>
                                   </tr>
                                
                                <cfloop query="getdetails">
                                    <cfoutput>
                                        <tr> 
                                    <td class="tdClass">#DateFormat(dateTime,'dd/mm/yyyy')#</td>
                                            <td class="tdClass">#projectName#</td>
                                            <td class="tdClass">#bugName#</td>
                                            <td class="tdClass">#description#</td>
                                            <td class="tdClass">#userName#</td>
                                            <td class="tdClass">#workingHour#</td>
                                            <td class="tdClass">#productiveHours#</td>
                                            <td class="tdClass">#name#</td>                                                                                 </tr>
                                    </cfoutput>
                                 </cfloop>
                                                    
                             </table>
                        </div>
                    </body>
       </html>
   </cfoutput>
</cfdocument>