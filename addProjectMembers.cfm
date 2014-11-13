<!---
            Bug Tracker - Add Project Members CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfif isDefined("form.add")>
    <cfset A = ListToArray(#form.add_new#)/>
    <cfset n="#ArrayLen(A)#"/>
    <cfloop from="1" to="#n#" index="i">
        <cfset pid="#A[i]#"/>
        <cfset cuserID="#A[i]#"/>
        <cfquery name="getList" datasource="bugTracking" result="list"> 
            SELECT u.email as uemail, u.userName as uname,
            p.projectName as pname FROM users u 
            inner join projects p on u.userID=#cuserID# 
            and p.projectID=#url.projectID#; 
        </cfquery>
        <cfquery name="getcurrent" datasource="bugTracking" result="current"> 
            SELECT  u.userName as username, d.name as dname 
            from users u inner join designations d on 
            userID=#session.userID# and u.designationID=d.designationID; 
        </cfquery>
        <cfmail query="getList" from="my@domain.com" to="#getList.uemail#" subject="Add_project">
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
                    <p>Dear #getList.uname#,</p> <br><br>
                    You are added to the Project #getList.pname# 
                    <br> <br>
                    <p>Email sent by </p>
                
                    <p>#getcurrent.username#</p> 
                    <p>#getcurrent.dname#</p>
                </body>
            </html>
        </cfmailpart>         
    </cfmail>
        
        <cfif list.recordcount>  
            <cfoutput><p>success</p></cfoutput>
        </cfif>
        <cfquery name="empd0" datasource="bugTracking" result="check">
            select projectID from projectUsers pu inner join users u 
            where pu.userID=#pid# and pu.projectID=#url.projectID#
        </cfquery>
        <cfif check.recordcount>
            <cfquery name="empd3" datasource="bugTracking">
                update projectUsers set hide=0 where 
                userID=#pid# and projectID=#url.projectID#
            </cfquery>
            <cfelse>
                <cfquery name="empd" datasource="bugTracking">
                    insert into projectUsers(projectID, userID)
                    values('#url.projectID#','#pid#')
                </cfquery>
        </cfif>
        <cfquery name="empd2" datasource="bugTracking">
            update users set noProjects=0 where userID='#pid#'
        </cfquery>
    </cfloop>
        <cfoutput>
        <cfif isdefined('url.flag')>
                <cflocation url="editProject.cfm?projectID=#url.projectID#&flag" addtoken="false">
            <cfelse>
                <cflocation url="editProject.cfm?projectID=#url.projectID#" addtoken="false">
        </cfif>
        </cfoutput>
</cfif>
<cfinclude template="layouts/header.cfm"/><!--- including header --->
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="inactive"/>
        <cfset Session.highlight2="active"/>
        <cfset Session.highlight3="inactive"/>
        <cfset Session.highlight4="inactive"/>
        <cfset Session.highlight5="inactive"/>
        <cfset Session.highlight6="inactive"/>
        <cfinclude template="layouts/sidebar.cfm"/><!--- including sidebar --->
        <div class="span9" id="content">
            <div class="row-fluid">
                <div class="navbar navbar-inner block-header">
                    <div class="muted pull-left">
                        <cfif isdefined('url.flag')>
                            <cfoutput><a href="editProject.cfm?projectID=#url.projectID#&flag" class="btn btn-default btn-primary" style="display:inline"></cfoutput>
                                <i class="icon-arrow-left"></i>&nbsp;Edit Project
                            </a>
                            <cfelse>
                                <cfoutput><a href="editProject.cfm?projectID=#url.projectID#" class="btn btn-default btn-primary" style="display:inline"></cfoutput>
                                    <i class="icon-arrow-left"></i>&nbsp;Edit Project
                                </a>
                        </cfif>
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">
                            <form class="form-search" action=" " method="post">
                            <input type="text" class="input-medium search-query" name="search" placeholder="Search Employee"/>
                            <input class="btn btn-mini btn-primary" type="submit" name="search_btn" value="GO"/>
                            </form>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12"><cfoutput>
                            <form action=" " method="post">
                                <table class="table table bordered">
                                    <tr>
                                        <td><strong>Employee Name</strong></td>
                                        <td><strong>Employee ID</strong></td>
                                        <td><strong>Designation</strong></td>
                                        <td><strong>Working Project</strong></td>
                                        <td><strong></strong></td>
                                        <td></td>
                                    </tr>
                                    <cfquery name="emp" datasource="bugTracking">
                                        select u.userName, u.employeeID, u.userID, d.name
                                        from users u inner join designations d
                                        where d.designationID=u.designationID and 
                                        u.hide=0 and u.noProjects=0
                                    </cfquery>
                                    <cfquery name="emp2" datasource="bugTracking">
                                        select u.userName, u.employeeID, u.userID, d.name
                                        from users u inner join designations d 
                                        where u.noProjects=1 and d.designationID=u.designationID 
                                        and u.hide=0;
                                    </cfquery>
                                    <cfloop query="emp">
                                        <tr>
                                            <cfquery name="check" result="c" datasource="bugTracking">
                                                select userID from projectUsers
                                                where userID=#emp.userID# and
                                                projectID=#url.projectID# and hide=0
                                            </cfquery>
                                            <cfquery name="projectNameValues" datasource="bugTracking">
                                                select p.projectName,p.projectID from projects p 
                                                inner join projectUsers pu
                                                on pu.userID=#emp.userID# and p.projectID=pu.projectID;
                                            </cfquery>
                                                            
                                            <cfif !c.recordcount>
                                                <td>#emp.userName #</td>
                                                <td>#emp.employeeID#</td>
                                                <td>#emp.name#</td>
                                            <td><cfloop query="projectNameValues">
                                                <a href="projectProfile.cfm?projectID=#projectNameValues.projectID#">
                                                #projectNameValues.projectName#</a> |
                                            </cfloop></td>
                                                <td><input type="checkbox" name="add_new" value="#emp.userID#"/></td>
                                            </cfif>
                                        </tr>
                                    </cfloop>
                                    <cfloop query="emp2">
                                        <tr>
                                            <td>#emp2.userName #</td>
                                            <td>#emp2.employeeID#</td>
                                            <td>#emp2.name#</td>
                                            <td></td>
                                            <td><input type="checkbox" name="add_new" value="#emp2.userID#"/></td>
                                        </tr>
                                    </cfloop>
                                </table>
                                <div class="form-actions">
                                        <input type="submit" class="btn btn-primary" name="add"  value="ADD">
                                </div>
                            </form></cfoutput>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<cfinclude template="layouts/footer.cfm"/>
