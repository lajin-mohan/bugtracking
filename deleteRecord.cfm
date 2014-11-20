<cfif isdefined('url.userID') and isdefined('url.removeProjectMember')>
    <cfquery name="deleteEmployee" datasource="bugTracking">
        update projectUsers set hide=1 where userID=#url.userID#
        and projectID=#url.projectID#;
    </cfquery>
    <cfquery name="deleteEmployee2" datasource="bugTracking" result="de2">
        select projectID from projectUsers where userID=#url.userID#
        and projectID=#url.projectID#
    </cfquery>
    <cfquery name="getDetails" datasource="bugTracking" result=list> 
        SELECT u.email as uemail, u.userName as uname,
        p.projectName as pname from users as u 
        inner join projectUsers as pu inner join projects p
        on pu.projectID=#url.projectID#  and u.userId=#url.userID#
        and p.projectID=#url.projectID#;
    </cfquery>
    <cfquery name="getcurrent" datasource="bugTracking" result=current> 
        SELECT  u.userName as username, d.name as dname 
        from users u inner join designations d
        on userID=#session.userID# and u.designationID=d.designationID; 
    </cfquery>  
    <cfmail from="#session.email#" to="#getDetails.uemail#" subject="Edit_project" type="html">
        <cfmailpart type="html">
            <html> 
                <head> 
                    <style type="text/css"> 
                        body { 
                            font-family:sans-serif;
                            font-size:12px;
                            color:black;
                        }
                    </style>
                </head>
                <body>
                    <p>Dear #getDetails.uname#,</p> <br><br>
                    You are removed from the project "#getDetails.pname#"
                    <br> <br>
                    <p>Email sent by </p>               
                    <p>#getcurrent.username#</p>              
                    <p>#getcurrent.dname#</p>              
                </body>
            </html>
        </cfmailpart>                     
    </cfmail>
    <cfif !de2.recordcount>
        <cfquery name="deleteEmployee3" datasource="bugTracking">
            update users set noProjects=1 where userID=#url.userID#
        </cfquery>
    </cfif>
    <cfif isdefined('flag')>
        <cflocation url="editProject.cfm?projectID=#url.projectID#&flag" addToken="false"/>
        <cfelse>
            <cflocation url="editProject.cfm?projectID=#url.projectID#" addToken="false"/>
    </cfif>
    <cfelseif isdefined('url.userID')>
        <cfquery name="deleteEmployee" datasource="bugTracking">
            update users set hide=1 where userID=#url.userID#
        </cfquery>
        <cfquery name="deleteEmployee" datasource="bugTracking">
            update projectUsers set hide=1 where userID=#url.userID#
        </cfquery>
        <cflocation url="employeeDetails.cfm" addToken="false"/>
    <cfelseif isdefined('url.bugID')>
        <cfquery name="deleteBug" datasource="bugTracking">
            update bugs set statusID=6 where bugID=#url.bugID#
        </cfquery>
       <cfquery name="getDetails" datasource="bugTracking" result="list"> 
            SELECT u.email as uemail, u.userName as uname,
            p.projectName as pname, b.bugName as bname from users as u 
            inner join projects p inner join bugs b inner join bugUsers bu on u.userID=bu.userID
            and p.projectID=#url.projectID# and b.projectID=#url.projectID#
       </cfquery>
       <cfquery name="getcurrent" datasource="bugTracking" result="current"> 
           SELECT  u.userName as username, d.name as dname 
           from users u inner join designations d
           on userID=#session.userID# and u.designationID=d.designationID; 
       </cfquery>      
       <cfmail from="#session.email#" to="#getDetails.uemail#" subject="Delete_bug" type="html">
           <cfmailpart type="html">
                <html> 
                    <head> 
                        <style type="text/css"> 
                            body { 
                            font-family:sans-serif;
                            font-size:12px;
                            color:black;
                            }
                        </style>
                    </head>
                    <body>
                        <p>Dear #getDetails.uname#,</p> <br><br>
                        your bug - "#getDetails.bname#" has been deleted from the  project "#getDetails.pname#"
                        <br> <br>
                        <p>Email sent by </p>               
                        <p>#getcurrent.username#</p>              
                        <p>#getcurrent.dname#</p>              
                    </body>
                </html>
            </cfmailpart>                     
       </cfmail>                             
       <cfquery name="getProjectManager" datasource="bugTracking" result=manager> 
            SELECT u.email as uemail, u.userName as uname,
            p.projectName as pname, b.bugName as bname  from users as u 
            inner join projects p inner join bugs b on p.projectID=#url.projectID#
            and b.projectID=#url.projectID# and p.userID=u.userID ;
       </cfquery>
       <cfquery name="getcurrent" datasource="bugTracking" result=current> 
            SELECT  u.userName as username, d.name as dname 
            from users u inner join designations d
            on userID=#session.userID# and u.designationID=d.designationID; 
       </cfquery>
       <cfmail from="#session.email#" to="#getProjectManager.uemail#" subject="Delete_bug_projectManager" type="html">
           <cfmailpart type="html">
                <html> 
                    <head> 
                        <style type="text/css"> 
                            body { 
                            font-family:sans-serif;
                            font-size:12px;
                            color:black;
                            }
                        </style>
                    </head>
                    <body>
                        <p>Dear #getProjectManager.uname#,</p> <br><br>
                        A bug - "#getProjectManager.bname#" has been deleted from the project "#getDetails.pname#"
                        <br> <br>
                        <p>Email sent by </p>               
                        <p>#getcurrent.username#</p>              
                        <p>#getcurrent.dname#</p>              
                    </body>
                </html>
            </cfmailpart>                     
        </cfmail>    
        <cflocation url="bugDetails.cfm?pid=#url.projectID#" addToken="false"/>
        <cfelseif isdefined('url.milestones')>
        <cfquery name="delelteMilestone" datasource="bugTracking">
            update milestones set milestoneHide=1 where milestoneID=#url.milestoneID#;
        </cfquery>
        <cflocation url="editProject.cfm?projectID=#url.projectID#" addToken="false"/>
    <cfelseif isdefined('url.projectID')>
        <cfquery name="deleteProject" datasource="bugTracking">
           update projects set statusID=6 where projectID=#url.projectID#;
        </cfquery>
        <cfquery name="delelteMilestone" datasource="bugTracking">
            update milestones set milestoneHide=1 where projectID=#url.projectID#;
        </cfquery>
       <cfquery name="getDetails" datasource="bugTracking" result="list"> 
           SELECT u.email as uemail, u.userName as uname,
           p.projectName as pname from users as u 
           inner join projectUsers as pu 
           inner join projects p on pu.projectID=#url.projectID# 
           and pu.userID=u.userID and pu.hide=0
           and p.projectID=#url.projectID#; 
       </cfquery>
       <cfquery name="getcurrent" datasource="bugTracking" result=current> 
            SELECT  u.userName as username, d.name as dname 
            from users u inner join designations d
            on userID=#session.userID# and u.designationID=d.designationID; 
       </cfquery>
       <cfloop query="getDetails">
            <cfmail from="#session.email#" to="#getDetails.uemail#" subject="Delete_project" type="html">
                <cfmailpart type="html">
                    <html> 
                        <head> 
                           <style type="text/css"> 
                               body { 
                               font-family:sans-serif;
                               font-size:12px;
                               color:black;
                               }
                           </style>
                        </head>
                        <body>
                            <p>Dear #getDetails.uname#,</p> <br><br>
                            Your project "#getDetails.pname#" has been deleted 
                            <br> <br>
                            <p>Email sent by </p>               
                            <p>#getcurrent.username#</p>              
                            <p>#getcurrent.dname#</p>              
                        </body>
                    </html>
                </cfmailpart>                     
            </cfmail>
        </cfloop>   
    <cflocation url="projectDetails.cfm" addToken="false"/>
    <cfelseif isdefined('url.remainderID')>
        <cfquery name="deleteRemainder" datasource="bugTracking">
            update remainders set hide=1 where remainderID=#url.remainderID#;
        </cfquery>
        <cflocation url="calendar.cfm" addToken="false"/>
    <cfelseif isDefined('url.timesheetbugID')>
        <cfquery name="deleteTimeSheet" datasource="bugTracking">
            update timeSheet set hide=1 where bugID="#url.timesheetbugID#" and userID="#session.userID#"
        </cfquery>
        <cflocation url="timeSheetHistory.cfm" addToken="false"/>
    <cfelseif isDefined('url.pltimesheetbID') and isDefined('url.pltimesheetprojectID')>
        <cfquery name="deleteTimeSheet" datasource="bugTracking">
           update timeSheet set hide=1 where bugID="#url.pltimesheetbID#" and userID="#session.userID#" and projectID="#url.pltimesheetprojectID#" and timeSheetID="#url.pltimeSheetID#"
        </cfquery>
        <cflocation url="plTimeSheetHistory.cfm" addToken="false"/>
    <cfelseif isDefined('url.timesheetpID')>
        <cfquery name="deleteTimeSheet" datasource="bugTracking">
           update timeSheet set hide=1 where userID="#session.userID#" and projectID="#url.timesheetpID#" and timeSheetID="#url.pmTimeSheetID#"
        </cfquery>
        <cflocation url="pmTimeSheetHistory.cfm" addToken="false"/>
</cfif>