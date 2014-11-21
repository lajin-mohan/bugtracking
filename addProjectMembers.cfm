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
        <cfquery name="getList" datasource="#Application.dataSourceName#" result="list">
            <!---to get members mail id--->
            SELECT u.email as uemail, u.firstName as uname,
            p.projectName as pname FROM users u 
            inner join projects p on u.userID=
            <cfqueryparam value="#cuserID#" cfsqltype="cf_sql_tinyint"/>
            and p.projectID=
            <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
        </cfquery>
        <cfquery name="getcurrent" datasource="#Application.dataSourceName#" result="current">
            <!---to get user details--->
            SELECT u.firstName as firstName, d.name as dname 
            from users u inner join designations d on 
            userID=
            <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_tinyint"/>
            and u.designationID=d.designationID; 
        </cfquery>
        <cfmail query="getList" from="#session.email#" to="#getList.uemail#" subject="Add_project">
            <!---to send mail to newly added members--->
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
                        <p>#getcurrent.firstName#</p> 
                        <p>#getcurrent.dname#</p>
                    </body>
                </html>
            </cfmailpart>
        </cfmail>
        <cfif list.recordcount>  
            <cfoutput><p>success</p></cfoutput>
        </cfif>
        <cfquery name="empd0" datasource="#Application.dataSourceName#" result="check">
            select projectID from projectUsers pu inner join users u 
            where pu.userID=
            <cfqueryparam value="#pid#" cfsqltype="cf_sql_tinyint"/>
            and pu.projectID=
            <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
        </cfquery>
        <cfif check.recordcount>
            <cfquery name="empd3" datasource="#Application.dataSourceName#">
                update projectUsers set hide=0 where 
                userID=
                <cfqueryparam value="#pid#" cfsqltype="cf_sql_tinyint"/>
                and projectID=
                <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
            </cfquery>
            <cfelse>
                <cfquery name="empd" datasource="#Application.dataSourceName#">
                    insert into projectUsers(projectID, userID)
                    values(
                    <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
                    <cfqueryparam value="#pid#" cfsqltype="cf_sql_tinyint"/>)
                </cfquery>
        </cfif>
        <cfquery name="empd2" datasource="#Application.dataSourceName#">
            update users set noProjects=0 where userID=
            <cfqueryparam value="#pid#" cfsqltype="cf_sql_tinyint"/>
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
<cfinclude template="layouts/header.cfm"/><!---including header--->
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="inactive"/>
        <cfset Session.highlight2="active"/>
        <cfset Session.highlight3="inactive"/>
        <cfset Session.highlight4="inactive"/>
        <cfset Session.highlight5="inactive"/>
        <cfset Session.highlight6="inactive"/>
        <cfinclude template="layouts/sidebar.cfm"/><!---including sidebar--->
        <div class="span9" id="content">
            <div class="row-fluid">
                <div class="navbar navbar-inner block-header">
                    <div class="muted pull-left">
                        <cfif isdefined('url.flag')>
                            <cfoutput>
                                <a href="editProject.cfm?projectID=#url.projectID#&flag"
                                   class="btn btn-default btn-primary" style="display:inline">
                                    <i class="icon-arrow-left"></i>&nbsp;Edit Project
                                </a>
                            </cfoutput>
                            <cfelse>
                                <cfoutput>
                                    <a href="editProject.cfm?projectID=#url.projectID#"
                                       class="btn btn-default btn-primary" style="display:inline">
                                        <i class="icon-arrow-left"></i>&nbsp;Edit Project
                                    </a>
                                </cfoutput>
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
                        <div class="span12">
                            <cfoutput>
                                <form action=" " method="post"><!---form to add project members--->
                                    <table class="table table bordered">
                                        <tr>
                                            <td><strong>Employee Name</strong></td> 
                                            <td><strong>Employee ID</strong></td>
                                            <td><strong>Designation</strong></td>
                                            <td><strong>Working Project</strong></td>
                                            <td><strong></strong></td>
                                            <td></td>
                                        </tr>
                                        <cfquery name="emp" datasource="#Application.dataSourceName#">
                                            <!---selecting all employees who are engaged in other projects--->
                                            select u.firstName, u.employeeID, u.userID, d.name
                                            from users u inner join designations d
                                            where d.designationID=u.designationID and 
                                            u.hide=0 and u.noProjects=0 and u.userID!=
                                            <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_tinyint"/>
                                        </cfquery>
                                        <cfquery name="emp2" datasource="#Application.dataSourceName#">
                                            <!---selecting all employees who do not have projetcs--->
                                            select u.firstName, u.employeeID, u.userID, d.name
                                            from users u inner join designations d 
                                            where u.noProjects=1 and d.designationID=u.designationID 
                                            and u.hide=0 and u.userID!=
                                            <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_tinyint"/>
                                        </cfquery>
                                        <cfloop query="emp"><!---loop to display employees with live projects--->
                                            <tr>
                                                <cfquery name="check" result="c"
                                                         datasource="#Application.dataSourceName#">
                                                    select userID from projectUsers
                                                    where userID=
                                                    <cfqueryparam value="#emp.userID#" cfsqltype="cf_sql_tinyint"/>
                                                    and projectID=
                                                    <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
                                                    and hide=0
                                                </cfquery>
                                                <cfquery name="projectNameValues" datasource=
                                                         "#Application.dataSourceName#">
                                                    select p.projectName,p.projectID from projects p 
                                                    inner join projectUsers pu
                                                    on pu.userID=
                                                    <cfqueryparam value="#emp.userID#" cfsqltype="cf_sql_tinyint"/>
                                                    and p.projectID=pu.projectID;
                                                </cfquery>
                                                <cfif !c.recordcount>
                                                    <!---to check if the particular user is already added to project--->
                                                    <td>#emp.firstName #</td>
                                                    <td>#emp.employeeID#</td>
                                                    <td>#emp.name#</td>
                                                    <td>
                                                        <cfloop query="projectNameValues">
                                                            <a href="projectProfile.cfm?projectID=#projectNameValues.projectID#">
                                                                #projectNameValues.projectName#
                                                            </a>
                                                            &nbsp;|
                                                        </cfloop>
                                                    </td>
                                                    <td>
                                                        <input type="checkbox" name="add_new" value="#emp.userID#"/>
                                                    </td>
                                                </cfif>
                                            </tr>
                                        </cfloop>
                                        <cfloop query="emp2"><!---to display employees with no live projects--->
                                            <tr>
                                                <td>#emp2.firstName #</td>
                                                <td>#emp2.employeeID#</td>
                                                <td>#emp2.name#</td>
                                                <td></td>
                                                <td>
                                                    <input type="checkbox" name="add_new" value="#emp2.userID#"/>
                                                </td>
                                            </tr>
                                        </cfloop>
                                    </table>
                                    <div class="form-actions">
                                        <input type="submit" class="btn btn-primary" name="add" value="ADD"/>
                                    </div>
                                </form>
                            </cfoutput>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<cfinclude template="layouts/footer.cfm"/><!---including footer--->
