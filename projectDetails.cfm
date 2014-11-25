<!---
            Bug Tracker - Project Details CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

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
                    <div class="muted pull-right">
                        <a href="addProject.cfm"
                           class="btn btn-default btn-primary"
                           style="display:inline">
                            <i class="icon-plus-sign"></i>&nbsp;Project
                        </a>&nbsp; 
                        <a href="pmProjectBasedReport.cfm"
                           class="btn btn-default btn-primary"
                           style="display:inline">
                            Report
                        </a>
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header"></div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table bordered">
                                <tr>
                                    <td><strong>Project Name</strong></td>
                                    <td><strong>Estimated Start Date</strong></td>
                                    <td><strong>Actual Start Date</strong></td>
                                    <td><strong>Estimated End Date</strong></td>
                                    <td><strong>ProjecStatus</strong></td>
                                    <td></td>
                                </tr>
                                <cfquery name="project" datasource="#Application.dataSourceName#">
                                    select p.projectID, p.projectName, p.actualStartDate, 
                                    p.estimatedStartDate, p.estimatedEndDate, 
                                    s.name from projects as p inner join status as s 
                                    on p.statusID=s.statusID and p.statusID!=1 and 
                                    p.statusID!=6 and p.userID=
                                    <cfqueryparam value="#Session.userID#" cfsqltype="cf_sql_tinyint"/>
                                    order by p.projectID desc
                                </cfquery>
                                <cfoutput query="project">
                                    <tr>
                                        <td>
                                            <a href="projectProfile.cfm?projectID=#project.projectID#"
                                               onclick="project_return()">
                                                #project.projectName#
                                            </a>
                                        </td>
                                        <td>#dateformat(project.estimatedStartDate)#</td>
                                        <td>#Dateformat(project.actualStartDate)#</td>
                                        <td>#dateformat(project.estimatedEndDate)#</td>
                                        <td>#project.name#</td>
                                        <td>
                                            <a href="editProject.cfm?projectID=#project.projectID#"
                                               class="btn btn-mini btn-primary">
                                            <i class="icon-edit"></i>
                                            </a>&nbsp;&nbsp;
                                            <a href="deleteRecord.cfm?projectID=#project.projectID#"
                                               class="btn btn-mini btn-danger">
                                            <i class="icon-remove"></i>
                                            </a>
                                        </td>
                                    </tr>   
                                </cfoutput>
					       </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<cfinclude template="layouts/footer.cfm"/><!---including footer--->
