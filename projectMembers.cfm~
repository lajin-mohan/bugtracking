<!---
            Bug Tracker - Index CFM
            October 30, 2014
            Author: CF Freshers 2014
--->
<cfquery name="getbugID" datasource="bugTracking">
select projectID from projectUsers where userID=#session.userID# and isLead=1 and hide=0
</cfquery>
<cfinclude template="layouts/header.cfm"/><!--- including header --->
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="inactive"/>
        <cfset Session.highlight2="inactive"/>
        <cfset Session.highlight3="inactive"/>
        <cfset Session.highlight4="inactive"/>
        <cfset Session.highlight5="active"/>
        <cfset Session.highlight6="inactive"/>
        <cfinclude template="layouts/sidebar.cfm"/><!--- including sidebar --->
        <div class="span9" id="content">
            <div class="row-fluid">
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <legend>Team Members</legend>
                            <table class="table table-striped">
                                <tr>
                                    <th>Name</th>
                                    <th>Assigned Bugs</th>
                                </tr>
                                <cfoutput>
                                    <cfloop query="getbugID">
                                        <cfquery name="viewdetails" datasource="bugTracking">
                                            select u.userName name,u.userID id,p.projectName, p.projectID pid
                                            from users u inner join projectUsers pu inner join projects p
                                            on u.userID=pu.userID and pu.projectID=p.projectID and 
                                            p.projectID=#getbugID.projectID#;
                                        </cfquery>
                                        <tr><td>
                                            <div class="navbar navbar-inner block-header">
                                                <div class="muted pull-left">
                                                    <strong>Project Name: #viewdetails.projectName#</strong>
                                                </div>
                                            </div>
                                        </td><td>
                                            <div class="navbar navbar-inner block-header">
                                                <div class="muted pull-right">
                                                    <strong>View Information</strong>
                                                </div>
                                            </div>
                                        </td></tr>
                               
                                        <cfloop query="viewdetails">
                                            <cfif viewdetails.id neq Session.userID>
                                                <cfquery name="listBugs" datasource="bugTracking">
                                                    select b.bugID bid, b.bugName, b.projectID from bugs b
                                                    inner join bugUsers bu on b.bugID=bu.bugID 
                                                    and bu.userID=#viewdetails.id#;
                                                </cfquery>
                                                <tr><td>
                                                    <a href="userView.cfm?userID=#viewdetails.id#">#viewdetails.name#</a>
                                                </td><td>
                                                    <cfloop query="listBugs">
                                                        <cfif viewdetails.pid eq listBugs.projectID>
                                                            <a href="bugDetailsView.cfm?bid=#listBugs.bid#"  onclick="project_return()">#listBugs.bugName#</a> |
                                                        </cfif>
                                                    </cfloop>
                                                </td></tr>   
                                            </cfif>
                                        </cfloop> 
                                    </cfloop> 
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








