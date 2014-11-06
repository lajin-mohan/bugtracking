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
        <cfinclude template="layouts/sidebar.cfm"/><!--- including sidebar --->
        <div class="span9" id="content">
            <div class="row-fluid">
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <center> <h3>PROJECTS</h3></center>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
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
                                                <td>#dateformat(viewproject.eed,"yyyy-mm-dd")#</td>
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
                        <center> <h3>TEAM MEMBERS </h3></center>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                             <table class="table table-striped">
                                <tr>
					                <td><strong>Name</strong></td>
                                    <td><strong>Designation</strong></td>
                                    <td><strong>Bug Name</strong></td>
                                    <td><strong>Project Name</strong></td>
                                </tr>
                                 <cfloop query="getbugID">
                                    <cfquery name="viewdetails" datasource="bugTracking">
select b.bugID,bu.bugName as bugname, pu.userID as puID, u.userName as uname,d.name as dname,proj.projectName as projname from users as u inner join designations as d inner join projectUsers as pu inner join bugUsers as b inner join bugs as bu inner join projects as proj on u.userID=pu.userID and u.designationID=d.designationID and pu.projectID=#getbugID.projectID# and isLead=0 and b.userID=pu.userID and b.bugID=bu.bugID and proj.projectID=#getbugID.projectID# ;
                                    </cfquery>
                                    <cfoutput query="viewdetails">
                                        <tr>
                                            <td>#viewdetails.uname#</td>
                                            <td>#viewdetails.dname#</td>
                                            <td>#viewdetails.bugname#</td>
                                            <td>#viewdetails.projname#</td>
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








