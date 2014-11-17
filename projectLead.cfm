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
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                        <legend>Projects</legend>
                           <table class="table table-striped">
                                <tr>
					                <td><strong>Project Name</strong></td>
                                    <td><strong>Dead Line</strong></td>
                                    <td><strong>Status</strong></td>
                                </tr>
                                    <cfloop query="getbugID">
                                        <cfquery name="viewproject" datasource="bugTracking">
select p.projectName as pname,p.projectID,p.estimatedEndDate as eed,s.name as status from projects as p inner join status as s on p.statusID=s.statusID and p.projectID=#getbugID.projectID#  order by p.projectName asc;
                                        </cfquery>
                                        <cfoutput query="viewproject">
                                            <tr>
                                                <td><a href="projectDetailsView.cfm?pid=#viewproject.projectID#">#viewproject.pname#</a></td>
                                                <td>#dateformat(viewproject.eed)#</td>
                                                <td>#viewproject.status#</td>
                                            </tr>   
                                       </cfoutput>
                                   </cfloop>
					       </table> 
                        </div>
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <legend>Assigned Bugs</legend>
                             <table class="table table-striped">
                                <tr>
					                <td><strong>Name</strong></td>
                                    <td><strong>Designation</strong></td>
                                    <td><strong>Bug Name</strong></td>
                                    <td><strong>Project Name</strong></td>
                                </tr>
                                 <cfloop query="getbugID">
                                    <cfquery name="viewdetails" datasource="bugTracking">
                                        select u.userName uname, d.name dname, b.bugName bugname,
                                        p.projectName projname, u.userID, p.projectID, b.bugID
                                        from users u inner join projectUsers pu inner join
                                        bugUsers bu inner join bugs b inner join projects p
                                        inner join designations d
                                        where p.projectID=#getbugID.projectID# and u.userID=pu.userID 
                                        and u.designationID=d.designationID and pu.isLead=0 and
                                        b.projectID=pu.projectID and b.bugID=bu.bugID 
                                        and bu.userID=pu.userID and p.projectID=b.projectID and b.statusID!=6;
                                    </cfquery>
                                    <cfoutput query="viewdetails">
                                        <tr>
                                            <td><a href="userView.cfm?userID=#viewdetails.userID#">#viewdetails.uname#</a></td>
                                            <td>#viewdetails.dname#</td>
                                            <td><a href="bugview.cfm?bid=#viewdetails.bugID#">#viewdetails.bugname#</a></td>
                                            <td><a href="projectDetailsView.cfm?pid=#viewdetails.projectID#">#viewdetails.projname#</a></td>
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








