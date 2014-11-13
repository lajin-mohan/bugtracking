<!---
            Bug Tracker - Index CFM
            October 30, 2014
            Author: CF Freshers 2014
--->
<cfquery name="getProjects" datasource="bugTracking">
    select projectID from projectUsers where userID=#Session.userID# and hide=0
</cfquery>

<cfinclude template="layouts/header.cfm"/><!--- including header --->
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="inactive"/>
        <cfset Session.highlight2="inactive"/>
        <cfset Session.highlight3="inactive"/>
        <cfset Session.highlight4="inactive"/>
        <cfset Session.highlight4="active"/>
        <cfset Session.highlight4="inactive"/>
        <cfinclude template="layouts/sidebar.cfm"/><!--- including sidebar --->
        <div class="span9" id="content">
            <div class="row-fluid">
                <div class="navbar navbar-inner block-header"></div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-right">
                            <form class="form-search" action=" " method="post">
                                <input type="text" class="input-medium search-query" name="search" placeholder=""/>
                                <input class="btn btn-mini btn-primary" type="submit" name="search_btn" value="GO"/>
                            </form>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <legend>Team Members</legend>
                            <table class="table table-striped">
                                <cfoutput>
                                <cfloop query="getProjects">
                                    <cfquery name="getTeamMembers" datasource='bugTracking'>
                                        select u.userName name,u.userID id,p.projectName from users u 
                                        inner join projectUsers pu inner join projects p 
                                        on u.userID=pu.userID and pu.projectID=p.projectID and 
                                        p.projectID=#getProjects.projectID#;
                                    </cfquery>
                                    <tr><td>
                                        <div class="navbar navbar-inner block-header">
                                             <div class="muted pull-left">
                                                <strong>Project Name: #getTeamMembers.projectName#</strong>
                                            </div>
                                        </div>
                                    </td><td>
                                        <div class="navbar navbar-inner block-header">
                                             <div class="muted pull-right">
                                                <strong>View Information</strong>
                                            </div>
                                        </div>
                                    </td></tr>
                                    <cfloop query="getTeamMembers">
                                        <cfif getTeamMembers.id neq Session.userID>
                                            <tr>
                                                <td>#getTeamMembers.name#</td>
                                                <td>
                                                    <a href="userView.cfm?userID=#getTeamMembers.id#" class="btn  btn-mini btn-primary">
                                                    <i class="icon-edit"></i>View Profile</a>
                                                </td>
                                            </tr> 
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
