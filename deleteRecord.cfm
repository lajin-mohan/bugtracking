<!---
            Bug Tracker - Delete Record CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfif isdefined('url.userID') and isdefined('url.removeProjectMember')>
    <cfquery name="removeProjectMember" datasource="#Application.dataSourceName#">
        <!---hiding from projectUsre table--->
        update projectUsers set hide=1 where userID=
        <cfqueryparam value="#url.userID#" cfsqltype="cf_sql_tinyint"/>
        and projectID=
        <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
    </cfquery>
    <cfquery name="removeProjectMember2" datasource="#Application.dataSourceName#"
             result="de2"><!---to check if removed employee has any other projects--->
        select projectID from projectUsers where hide=0 and userID=
        <cfqueryparam value="#url.userID#" cfsqltype="cf_sql_tinyint"/>
    </cfquery>
    <cfif !de2.recordcount>
        <cfquery name="removeProjectMember3" datasource="#Application.dataSourceName#">
            update users set noProjects=1 where userID=
            <cfqueryparam value="#url.userID#" cfsqltype="cf_sql_tinyint"/>
        </cfquery>
    </cfif>
    <cfquery name="getDetails" datasource="#Application.dataSourceName#"
             result=list><!---getting details of removed project member--->
        SELECT u.email as uemail, u.firstName as uname,
        p.projectName as pname from users as u 
        inner join projectUsers as pu inner join projects p on pu.projectID=
        <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
        and u.userId=
        <cfqueryparam value="#url.userID#" cfsqltype="cf_sql_tinyint"/>
        and p.projectID=
        <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
    </cfquery>
    <cfquery name="getcurrent" datasource="#Application.dataSourceName#"
             result=current><!---getting details of user--->
        SELECT  u.firstName as firstName, d.name as dname 
        from users u inner join designations d on userID=
        <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_tinyint"/>
        and u.designationID=d.designationID; 
    </cfquery>  
    <cfmail from="#session.email#" to="#getDetails.uemail#"
            subject="Edit_project" type="html"><!---to send mail to removed project member--->
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
                    <p>#getcurrent.firstName#</p>              
                    <p>#getcurrent.dname#</p>              
                </body>
            </html>
        </cfmailpart>                     
    </cfmail>
    <cfif isdefined('flag')>
        <cflocation url="editProject.cfm?projectID=#url.projectID#&flag" addToken="false"/>
        <cfelse>
            <cflocation url="editProject.cfm?projectID=#url.projectID#" addToken="false"/>
    </cfif>
    <cfelseif isdefined('url.userID')>
        <cfquery name="deleteEmployee" datasource="#Application.dataSourceName#">
            <!---hiding employee from user table--->
            update users set hide=1 where userID=
            <cfqueryparam value="#url.userID#" cfsqltype="cf_sql_tinyint"/>
        </cfquery>
        <cfquery name="deleteEmployee2" datasource="#Application.dataSourceName#">
            <!---hiding employee from projectUsers table--->
            update projectUsers set hide=1 where userID=
            <cfqueryparam value="#url.userID#" cfsqltype="cf_sql_tinyint"/>
        </cfquery>
        <cflocation url="employeeDetails.cfm" addToken="false"/>
    <cfelseif isdefined('url.bugID')>
        <cfquery name="deleteBug" datasource="#Application.dataSourceName#">
            <!---hiding bug from bugs table--->
            update bugs set statusID=6 where bugID=
            <cfqueryparam value="#url.bugID#" cfsqltype="cf_sql_tinyint"/>
        </cfquery>
        <cfquery name="getDetails" datasource="#Application.dataSourceName#" result="list">
            <!---getting detais of bug members--->
            SELECT u.email as uemail, u.firstName as uname, p.projectName as pname,
            b.bugName as bname from users as u inner join projects p inner join bugs b
            inner join bugUsers bu on u.userID=bu.userID and p.projectID=
            <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
            and b.projectID=
            <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
        </cfquery>
        <cfquery name="getcurrent" datasource="#Application.dataSourceName#" result="current">
            <!---getting details of user--->
            SELECT  u.firstName as firstName, d.name as dname 
            from users u inner join designations d
            on userID=
            <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_tinyint"/>
            and u.designationID=d.designationID; 
        </cfquery>      
        <cfmail from="#session.email#" to="#getDetails.uemail#" subject="Delete_bug" type="html">
            <!---sending mail to bug user--->
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
                        your bug - "#getDetails.bname#" has been deleted from the project "#getDetails.pname#"
                        <br> <br>
                        <p>Email sent by </p>               
                        <p>#getcurrent.firstName#</p>              
                        <p>#getcurrent.dname#</p>              
                    </body>
                </html>
            </cfmailpart>
        </cfmail>
        <cfquery name="getProjectManager" datasource="#Application.dataSourceName#" result=manager>
            <!---selecting details of project manager--->
            SELECT u.email as uemail, u.firstName as uname,
            p.projectName as pname, b.bugName as bname  from users as u 
            inner join projects p inner join bugs b on p.projectID=
            <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
            and b.projectID=
            <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
            and p.userID=u.userID ;
        </cfquery>
        <cfquery name="getcurrent" datasource="#Application.dataSourceName#" result=current> 
            <!---selecting details of user--->
            SELECT  u.firstName as firstName, d.name as dname 
            from users u inner join designations d on userID=
            <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_tinyint"/>
            and u.designationID=d.designationID; 
        </cfquery>
        <cfmail from="#session.email#" to="#getProjectManager.uemail#"
                subject="Delete_bug_projectManager" type="html">
            <!---sending mail to project manager--->
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
                        <p>#getcurrent.firstName#    </p>              
                        <p>#getcurrent.dname#</p>              
                    </body>
                </html>
            </cfmailpart>                     
        </cfmail>
        <cflocation url="bugDetails.cfm?pid=#url.projectID#" addToken="false"/>
    <cfelseif isdefined('url.milestones')>
        <cfquery name="delelteMilestone" datasource="#Application.dataSourceName#">
            <!---hiding milestone from milestones table--->
            update milestones set milestoneHide=1 where milestoneID=
            <cfqueryparam value="#url.milestoneID#" cfsqltype="cf_sql_tinyint"/>
        </cfquery>
        <cflocation url="editProject.cfm?projectID=#url.projectID#" addToken="false"/>
    <cfelseif isdefined('url.projectID')>
        <cfquery name="deleteProject" datasource="#Application.dataSourceName#">
            <!---droppng project from projects table--->
            update projects set statusID=6 where projectID=
            <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
        </cfquery>
        <cfquery name="delelteMilestone" datasource="#Application.dataSourceName#">
            <!---hiding milestones from milestones table--->
            update milestones set milestoneHide=1 where projectID=#url.projectID#;
        </cfquery>
        <cfquery name="getDetails" datasource="#Application.dataSourceName#" result="list"> 
            <!---getting details of project members--->
            SELECT u.email as uemail, u.firstName as uname,
            p.projectName as pname from users as u 
            inner join projectUsers as pu 
            inner join projects p on pu.projectID=
            <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
            and pu.userID=u.userID and pu.hide=0
            and p.projectID=
            <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
        </cfquery>
        <cfquery name="getcurrent" datasource="#Application.dataSourceName#" result=current>
            <!---getting details of user--->
            SELECT  u.firstName as firstName, d.name as dname 
            from users u inner join designations d on userID=
            <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_tinyint"/>
            and u.designationID=d.designationID; 
        </cfquery>
        <cfloop query="getDetails">
            <cfmail from="#session.email#" to="#getDetails.uemail#" subject="Delete_project" type="html">
                <!---sending mail to project users--->
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
                            <p>#getcurrent.firstName#</p>              
                            <p>#getcurrent.dname#</p>              
                        </body>
                    </html>
                </cfmailpart>                     
            </cfmail>
        </cfloop>   
        <cflocation url="projectDetails.cfm" addToken="false"/>
    <cfelseif isdefined('url.remainderID')>
        <cfquery name="deleteRemainder" datasource="#Application.dataSourceName#">
            <!---hiding remainder from reminders table--->
            update remainders set hide=1 where remainderID=
            <cfqueryparam value="#url.remainderID#" cfsqltype="cf_sql_tinyint"/>
        </cfquery>
        <cflocation url="calendar.cfm" addToken="false"/>
    <cfelseif isDefined('url.timesheetbugID')>
        <cfquery name="deleteTimeSheet" datasource="#Application.dataSourceName#">
            <!---hiding timesheet entry from timesheet table--->
            update timeSheet set hide=1 where bugID=
            <cfqueryparam value="#url.timesheetbugID#" cfsqltype="cf_sql_tinyint"/>
            and userID=
            <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_tinyint"/>
        </cfquery>
        <cflocation url="timeSheetHistory.cfm" addToken="false"/>
    <cfelseif isDefined('url.pltimeSheetID') and isDefined('url.pltimesheetprojectID')>
        <cfquery name="deleteTimeSheet" datasource="#Application.dataSourceName#">
            <!---hiding timesheet entry from timesheet table--->
            update timeSheet set hide=1 where userID=
            <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_tinyint"/>
            and projectID=
            <cfqueryparam value="#url.pltimesheetprojectID#" cfsqltype="cf_sql_tinyint"/>
            and timeSheetID=
            <cfqueryparam value="#url.pltimeSheetID#" cfsqltype="cf_sql_tinyint"/>
        </cfquery>
        <cflocation url="plTimeSheetHistory.cfm" addToken="false"/>
    <cfelseif isDefined('url.timesheetpID')>
        <!---hiding timesheet entry from timesheet table--->
        <cfquery name="deleteTimeSheet" datasource="#Application.dataSourceName#">
            update timeSheet set hide=1 where userID=
            <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_tinyint"/>
            and projectID=
            <cfqueryparam value="#url.timesheetpID#" cfsqltype="cf_sql_tinyint"/>
            and timeSheetID=
            <cfqueryparam value="#url.pmTimeSheetID#" cfsqltype="cf_sql_tinyint"/>
        </cfquery>
        <cflocation url="pmTimeSheetHistory.cfm" addToken="false"/>
</cfif>