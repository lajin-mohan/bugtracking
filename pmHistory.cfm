<cfdocument format="PDF">
    <cfoutput>

                <html>
                    <head>
                    <body>
                      <center><h2>Project Lead Report</h2></center>
                        <div>
                            <table>
                                <tr>
                                    
                                
                                <th class="tdClass">My Projects</th>
                                <th class="tdClass">Status</th>
                              
                               
                                </tr>   
                                
                                <cfquery name="report" datasource="bugTracking">
                                select projects.projectName,status.name from projects inner join status on projects.statusID=status.statusID;              
                                </cfquery>
                                
                                 <cfloop query="report">
                                
                                 <cfoutput>
                                        <tr> 
                                   
                                            <td class="tdClass">#projectName#</td>
                                            <td class="tdClass">#name#</td>
                                                                                                                 
                                        </tr>
                                    </cfoutput>
                                     
                                </cfloop>
                                
                             </table>
                        </div>
                    </body>
       </html>
   </cfoutput>
</cfdocument>