<!---
            Bug Tracker - Software Tester CFM
            November 04, 2014
            Author: CF Freshers 2014
--->

<cfinclude template="layouts/header.cfm"/><!--- including header --->
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="active"/>
        <cfset Session.highlight2="inactive"/>
        <cfset Session.highlight3="inactive"/>
        <cfset Session.highlight4="inactive"/>
        <cfset Session.highlight5="inactive"/>
        <cfset Session.highlight6="inactive"/>
        <cfinclude template="layouts/sidebar.cfm"/><!--- including sidebar --->
        <div class="span9" id="content">
            <div class="row-fluid">
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <center><h3>Projects to be Reviewed</h3></center>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table bordered">
                                <tr>
                                    <td><strong>Project ID</strong></td>
                                    <td><strong>Project Name</strong></td>
                                    <td><strong>Project Lead</strong></td>
                                    <td><strong>Marked for Review On</strong></td>
                                </tr>
                                <cfquery name="project" datasource="#Application.dataSourceName#">
                                    select projects.projectID, projects.projectName, users.firstName,  
                                    users.lastName, logs.loggedTime from projects inner join bugs on 
                                    bugs.projectID=projects.projectID inner join logs on 
                                    logs.bugID=bugs.bugID inner join users on logs.userID=users.userID 
                                    and logs.activityID=10 and users.roleID=2;
                                </cfquery> 
                                <cfoutput query="project">
                                    <cfif #LSDateformat(project.loggedTime ,"yyyy-mm-dd")# LT Dateadd("d",7,now()) 
                                            and #LSDateformat(project.loggedTime ,"yyyy-mm-dd")# GT now()>
                                        <tr>
                                            <td>#project.projectID#</td>
                                            <td>#project.projectName#</td>
                                            <td>#project.firstName#</td>
                                            <td>#project.lastName#</td>
                                            <td>#LSDateformat(project.loggedTime,"yyyy-mm-dd")#</td>
                                        </tr>   
                                    </cfif>
                                </cfoutput>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<cfinclude template="layouts/footer.cfm"/>
