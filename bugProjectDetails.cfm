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
        <cfset Session.highlight2="active"/>
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
					               <td><h5>Project Name</h5></td>
                                        <td><h5>Dead Line</h5></td>
                                            <td><h5>Status</h5></td>
                                    
                                </tr>
                                <cfloop query="getbugID">
                                    <cfquery name="viewproject" datasource="bugTracking">
select p.projectName as pname,p.estimatedEndDate as eed,s.name as status from projects as p inner join status as s on p.statusID=s.statusID and p.projectID=#getbugID.projectID#  order by p.projectName asc;
                                    </cfquery>
                                    <cfoutput query="viewproject">
                                    <tr>
                                        <td><a href="bugDetails.cfm?pid=#getbugID.projectID#"                                                                                    onclick="project_return()">#viewproject.pname# </a></td>
                                            <td>#dateformat(viewproject.eed,"yyyy-mm-dd")#</td>
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








