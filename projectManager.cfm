<!---
            Bug Tracker - Project Manager CFM
            October 30, 2014
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
                        <center><h3>Projects In This Week</h3></center>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table bordered">
                                <tr>
                                    <td><strong>Project Name</strong></td>
                                    <td><strong>Estimated Start Date</strong></td>
                                    <td><strong>Estimated End Date</strong></td>
                                    <td><strong>Project Status</strong></td>
                                </tr>
                                <cfquery name="project" datasource="#Application.dataSourceName#">
                                    select p.projectName, p.projectDescription,p.projectID,  
                                    p.estimatedStartDate, p.actualStartDate, p.estimatedEndDate, 
                                    s.name from projects p inner join status s 
                                    on p.statusID=s.statusID order by p.estimatedEndDate desc;
                                </cfquery> 
                                <cfoutput query="project">
                                    <cfif #LSDateformat(project.estimatedEndDate ,"yyyy-mm-dd")#
                                          LT Dateadd("d",7,now())
                                          and #LSDateformat(project.estimatedEndDate ,"yyyy-mm-dd")#
                                          GT now()>
                                        <tr>
                                            <td>
                                                <a href="projectProfile.cfm?projectID=#project.projectID#"
                                                   onclick="project_return()">
                                                    #project.projectName#
                                                </a>
                                            </td>
                                            <td>#dateformat(project.estimatedStartDate)#</td>
                                            <td>#dateformat(project.estimatedEndDate)#</td>
                                            <td>#project.name#</td>
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
<cfinclude template="layouts/footer.cfm"/><!---including footer--->
