<!---
            Bug Tracker - Index CFM
            October 30, 2014
            Author: CF Freshers 2014
--->
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
            <div class="row-fluid">
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">
                            <h3>Bug Details</h3>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">                            
                            <table class="table table-striped">
                                <tr>
					               
                                    <td>Bug Name</td>
                                    <td>End Date</td>
                                    <td>Priority</td>
                                   
                                    <td>Status</td>
                                    <td></td>
                                </tr>
                                <cfif Session.roleID eq 3>
                                    <cfquery name="bug" datasource="#Application.dataSourceName#">
                                        select b.bugID, b.bugName, b.projectID, b.estimatedEndDate,
                                        p.name as n ,s.name as s from bugs as b 
                                        inner join priorities as p 
                                        inner join status as s 
                                        inner join bugUsers as bu
                                        on b.priorityID=p.priorityID and  b.statusID=s.statusID 
                                        and b.statusID!=6 and b.bugID=bu.bugID
                                        and bu.userID=<cfqueryparam value="#session.userID#" cfsqltype="cf_sql_tinyint"/>
                                        order by b.bugName desc;
                                    </cfquery>
                                    <cfelseif Session.roleID eq 4>
                                    <cfquery name="bug" datasource="#Application.dataSourceName#">
                                        select b.bugID, b.bugName, b.projectID, b.estimatedEndDate,
                                        p.name as n ,s.name as s from bugs as b 
                                        inner join priorities as p 
                                        inner join status as s
                                        inner join projectUsers as pu 
                                        on b.priorityID=p.priorityID and  b.statusID=s.statusID
                                        and pu.userID=<cfqueryparam value="#session.userID#" cfsqltype="cf_sql_tinyint"/>
                                        and b.statusID=5 
                                        and pu.projectID=b.projectID 
                                        order by b.bugName desc;
                                    </cfquery>
                                </cfif>
                                <cfoutput query="bug">
                                    <tr>
                                        <td><a href="bugview.cfm?bid=#bug.bugID#" 
                                                onclick="project_return()">#bug.bugName#</a></td>
                                        <td>#dateformat(bug.estimatedEndDate,"yyyy-mm-dd")#</td>
                                        <td>#bug.n#</td>
                                        <td>#bug.s#</td>
                                        <td> 
                                            <a href="editStatus.cfm?bugID=#bug.bugID#"
                                               class="btn  btn-mini btn-primary">
                      <i class="icon-edit"></i>Edit Status
                                            </a>&nbsp;&nbsp;                                            
                                        </td>
                                    </tr>   
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
