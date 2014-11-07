<!---
            Bug Tracker - Index CFM
            October 30, 2014
            Author: CF Freshers 2014
--->
<cfquery name="getbugID" datasource="bugTracking">
select projectID from projectUsers where userID=#session.userID# and isLead=1 and hide=0;
</cfquery>
<cfinclude template="layouts/header.cfm"/><!--- including header --->
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="inactive"/>
        <cfset Session.highlight2="inactive"/>
        <cfset Session.highlight3="active"/>
        <cfset Session.highlight4="inactive"/>
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
                                    <th>Designation</th>
                                    <th>Bug Name</th>
                                    <th>Project Name</th>
                                    <th></th>
                                </tr>
                                 <cfloop query="getbugID">
                                <cfquery name="viewdetails" datasource="bugTracking">
                                    select u.userName uname, u.userID uid, d.name dname, b.bugName bugname,
                                    p.projectName projname, b.bugID bid, p.projectID pid
                                    from users u inner join projectUsers pu inner join
                                    bugUsers bu inner join bugs b inner join projects p
                                    inner join designations d
                                    where p.projectID=#getbugID.projectID# and u.userID=pu.userID 
                                    and u.designationID=d.designationID and pu.isLead=0 and
                                    b.projectID=pu.projectID and b.bugID=bu.bugID 
                                    and bu.userID=pu.userID and p.projectID=b.projectID 
                                    group by #getbugID.projectID#
                                </cfquery>
                               
                                <cfoutput query="viewdetails">
                                    <tr>
                                        <td><a href="userView.cfm?userID=#viewdetails.uid#">#viewdetails.uname#</a></td>
                                        <td>#viewdetails.dname#</td>
                                        <td><a href="bugDetailsView.cfm?bid=#viewdetails.bid#"                                                                                    onclick="project_return()">#viewdetails.bugname# </a></td>
                                        <td><a href="projectDetailsView.cfm?pid=#viewdetails.pid#"                                                                                    onclick="project_return()">#viewdetails.projname#</a></td>
                                         </tr>   
                                </cfoutput> </cfloop>
					       </table> 
                        </div>
                    </div>
                </div>   
            </div>
        </div>
    </div>
</div>
<cfinclude template="layouts/footer.cfm"/>








