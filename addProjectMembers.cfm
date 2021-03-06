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
                        <div class="span12">
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
                                        select u.userName, u.employeeID, u.userID, d.name, 
                                        p.projectName , pu.hide
                                        from users u inner join designations d 
                                        inner join projectUsers pu inner join projects p
                                        where u.userID=pu.userID and 
                                        d.designationID=u.designationID and 
                                        pu.projectID=p.projectID and u.hide=0 and 
                                        pu.projectID!=#url.projectID# and u.noProjects=0
                                    </cfquery>
                                    <cfquery name="emp2" datasource="bugTracking">
                                        select u.userName, u.employeeID, u.userID, d.name
                                        from users u inner join designations d 
                                        where u.noProjects=1 and d.designationID=u.designationID 
                                        and u.hide=0;
                                    </cfquery>
                                    <cfoutput query="emp">
                                        <tr>
                                            <cfquery name="check" result="c" datasource="bugTracking">
                                                select userID from projectUsers
                                                where userID=#emp.userID# and
                                                projectID=#url.projectID# and hide=0
                                            </cfquery>
                                            <cfif !c.recordcount>
                                                <td>#emp.userName #</td>
                                                <td>#emp.employeeID#</td>
                                                <td>#emp.name#</td>
                                                <td>#emp.projectName#</td>
                                                <td><input type="checkbox" name="add_new" value="#emp.userID#"/></td>
                                            </cfif>
                                        </tr>
                                    </cfoutput>
                                    <cfoutput query="emp2">
                                        <tr>
                                            <td>#emp2.userName #</td>
                                            <td>#emp2.employeeID#</td>
                                            <td>#emp2.name#</td>
                                            <td>No Projects</td>
                                            <td><input type="checkbox" name="add_new" value="#emp2.userID#"/></td>
                                        </tr>
                                    </cfoutput>
                                </table>
                                <div class="form-actions">
                                        <input type="submit" class="btn btn-primary" name="add"  value="ADD">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<cfinclude template="layouts/footer.cfm"/>