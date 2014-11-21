<!---
            Bug Tracker - Index CFM
            October 30, 2014
            Author: CF Freshers 2014
--->
<cfquery name="getbugID" datasource="#Application.dataSourceName#">
select projectID from projectUsers where userID=#session.userID# and isLead=1 and hide=0;
</cfquery>
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
            <div class="block">
            <div class="row-fluid">
              
                    <div class="navbar navbar-inner block-header"></div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <legend>My Projects
                                <div class="muted pull-right">
                                    <a href="plTeamMembersReport.cfm" class="muted pull-right btn btn-default btn-primary" style="display:inline">
                                        <i class="icon-list-alt"></i>&nbsp;Generate Report
                                    </a>
                                </div>
                            </legend>
                           <table class="table table-striped">
                                <tr>
					               <td><h5>Project Name</h5></td>
                                        <td><h5>Dead Line</h5></td>
                                            <td><h5>Status</h5></td>
                                    
                                </tr>
                                <cfloop query="getbugID">
                                    <cfquery name="viewproject" datasource="#Application.dataSourceName#">
select p.projectName as pname,p.estimatedEndDate as eed,s.name as status from projects as p inner join status as s on p.statusID=s.statusID and p.projectID=#getbugID.projectID#  order by p.projectName asc;
                                    </cfquery>
                                    <cfoutput query="viewproject">
                                    <tr>
                                        <td><a href="bugDetails.cfm?pid=#getbugID.projectID#"                                                                                    onclick="project_return()">#viewproject.pname# </a></td>
                                            <td>#dateformat(viewproject.eed)#</td>
                                                <td>#viewproject.status#</td>
                                        
                                        
                                        
                                    </tr>   
                                    </cfoutput>
                                </cfloop>
					       </table> 
                        </div>
                    </div>
         
                </div>
            </div>
        </div>
    </div>
</div>
<cfinclude template="layouts/footer.cfm"/>








