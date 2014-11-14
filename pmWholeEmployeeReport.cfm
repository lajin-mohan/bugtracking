
<cfdocument format="PDF">
   <cfoutput>
       <cfquery name="selectData" datasource="bugTracking">
              select users.userName,designations.name,logs.loggedTime from users 
              inner join designations on users.designationID=designations.designationID 
              inner join logs on users.userID=logs.userID
       </cfquery>
       <html>
           <head><link href="report.css" rel="stylesheet"></head>
           <body>
               <div class="divHeading"><h2>Employee Report</h2></div>
               <div>
                   <br /><br />
                   <hr>
                   <table class="report" align="center">
                       <tr class="trBackground">
                           <th class="tdClass">Employee Name</th>
                           <th class="tdClass">Designation</th>
                           <th class="tdClass">Added Date</th>
                       </tr>   
                       <cfloop query="selectData">
                           <cfoutput>
                               <tr> 
                                   <td class="tdClass">#userName#</td>
                                   <td class="tdClass">#name#</td>
                                   <td class="tdClass">#DateFormat(loggedTime,'dd/mm/yyyy')#</td>
                               </tr>
                           </cfoutput>
                       </cfloop>
                  </table>
                       
               </div>
            </body>
       </html>
   </cfoutput>
</cfdocument>