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
                        
                        <center> <h3>PROJECT MEMBERS </h3></center>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                          <table class="table table-striped">
                                <tr>
					               
                                    <td> Name</td>
                                    <td> Designation</td>
                                    
                                     <td>Bug Name</td>
                                    <td> Project Name </td>
                                    <td></td>
                                </tr>
                                 <cfloop query="getbugID">
                                <cfquery name="viewdetails" datasource="bugTracking">
                            select b.bugID as bid,proj.projectID as pid,bu.bugName as bugname, pu.userID as puID, u.userName as uname,d.name as dname,proj.projectName as projname from users as u inner join designations as d inner join projectUsers as pu inner join bugUsers as b inner join bugs as bu inner join projects as proj on u.userID=pu.userID and u.designationID=d.designationID and pu.projectID=#getbugID.projectID# and isLead=0 and b.userID=pu.userID and b.bugID=bu.bugID and proj.projectID=pu.projectID and pu.hide=0;
                                </cfquery>
                               
                                <cfoutput query="viewdetails">
                                    <tr>
                                        <td><a href="userView.cfm?userID=#viewdetails.puID#"                                                                                    onclick="project_return()">#viewdetails.uname#</a></td>
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








