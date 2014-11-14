<!---
            Bug Tracker - Project Profile CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfinclude template="layouts/header.cfm" />
<cfobject name="addUserObject" component="components.user">
<cfoutput>
    <div class="container-fluid">
        <div class="row-fluid">
            <cfset Session.highlight1="inactive"/>
            <cfset Session.highlight3="inactive"/>
            <cfset Session.highlight4="inactive"/>
            <cfset Session.highlight5="inactive"/>
            <cfinclude template="layouts/sidebar.cfm"/><!--- including sidebar --->
            <div class="span9" id="content">
                <div class="row-fluid">
                    <div class="navbar navbar-inner block-header">
                    <div class="muted pull-left">
                        <cfif isdefined('url.flag')>
                            <a href="projectManagerHistory.cfm" class="btn btn-default btn-primary" style="display:inline">
                                <i class="icon-arrow-left"></i>&nbsp;Project History
                            </a>
                            <cfset Session.highlight2="inactive"/>
                            <cfset Session.highlight6="active"/>
                            <cfelse>
                                <a href="projectDetails.cfm" class="btn btn-default btn-primary" style="display:inline">
                                    <i class="icon-arrow-left"></i>&nbsp;Project Details
                                    <cfset Session.highlight2="active"/>
                                    <cfset Session.highlight6="inactive"/>
                                </a>
                        </cfif>
                    </div>
                    <div class="muted pull-right">
                        <a href="editProject.cfm?projectID=#url.projectID#&flag" class="btn btn-default btn-primary" style="display:inline">
                            <i class="icon-plus-sign"></i>&nbsp;Edit Project
                        </a>
                    </div>
                </div>
                    <cfquery name="project" datasource="bugtracking">
                        select p.projectName, p.projectDescription, 
                        p.estimatedStartDate, p.actualStartDate, 
                        p.estimatedEndDate, p.actualEndDate, p.userID,
                        s.name statusName, pr.name priorityname, u.userName
                        from projects p inner join status s inner join priorities pr 
                        inner join users u where p.projectID=#url.projectID#
                        and p.statusID=s.statusID and p.userID=u.userID and
                        p.priorityID=pr.priorityID
                    </cfquery>
                    <div class="block">
                        <div class="navbar navbar-inner block-header">
                            <div class="muted pull-left"></div>
                        </div>
                        <div class="block-content collapse in">
                            <div class="span12">
                                <fieldset>
                                    <legend>Project Profile</legend>
                                    <div class="control-group">
                                        <label class="control-label">Name:</label>
                                        <div class="controls">
                                            <input type="text" data-required="1" class="span6 m-wrap"  disabled value="#project.projectName#"/>
                                        </div>
                                    </div>
                                    <br/>
                                    <div class="control-group">
                                        <label class="control-label">Description:</label>
                                        <div class="controls">
                                            <input type="text" class="span6 m-wrap" disabled value="#project.projectDescription#"/>              									
                                        </div>
                                    </div>
                                    <br/>
                                    <div class="control-group">
                                        <label class="control-label">Estimated Start Date:</label>
                                        <div class="controls">
                                            <input type="text" class="span6 m-wrap" required disabled value="#LSDateformat(project.estimatedStartDate,"yyyy-mm-dd")#"/>
                                        </div>
                                    </div>
                                    <br/>
                                    <div class="control-group">
                                        <label class="control-label">Actual Start Date:</label>
                                        <div class="controls">
                                             <input type="text" class="span6 m-wrap" value="#LSDateformat(project.actualStartDate,"yyyy-mm-dd")#" disabled/>
                                        </div>
                                    </div>
                                    <br/>
                                    <div class="control-group">
                                        <label class="control-label">Estimated End Date:</label>
                                        <div class="controls">
                                            <input type="text" class="span6 m-wrap" value="#LSDateformat(project.estimatedEndDate,"yyyy-mm-dd")#" disabled/>                                 
                                        </div>
                                    </div>
                                    <br/>
                                    <div class="control-group">
                                        <label class="control-label">Actual End Date:</label>
                                        <div class="controls">
                                            <input type="text" class="span6 m-wrap" value="#LSDateformat(project.actualEndDate,"yyyy-mm-dd")#" disabled/>
                                        </div>
                                    </div>
                                    <br/>
                                    <div class="control-group">
                                        <label class="control-label">Status:</label>
                                        <div class="controls">
                                            <input type="text" class="span6 m-wrap" value="#project.statusName#" disabled/>
                                        </div>
                                    </div>
                                    <br/>
                                    <div class="control-group">
                                        <label class="control-label">Priority:</label>
                                        <div class="controls">
                                            <input type="text" class="span6 m-wrap" value="#project.priorityName#" disabled/>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">Project Manager:</label>
                                        <div class="controls">
                                            <input type="text" class="span6 m-wrap" value="#project.userName#" disabled/>
                                        </div>
                                    </div>
                                    <cfquery name="pUsers" datasource="bugtracking">
                                        select u.userID, u.userName, u.employeeID, d.name,
                                        pu.hide from projectUsers pu inner join users u
                                        inner join designations d where
                                        pu.userID=u.userID and d.designationID=u.designationID
                                        and pu.projectID=#url.projectID#
                                    </cfquery>
                                    <div class="control-group">
                                        <label class="control-label"><span class="required"></span></label>
                                        <div class="controls">
                                            <table class="table table bordered">
                                                <tr>
                                                    <th><strong>Employee Name</strong></th>
                                                    <th><strong>Employee ID</strong></th>
                                                    <th><strong>Designation</strong></th>
                                                    <th><strong>Status</strong></th>                                                    
                                                </tr>
                                                </cfoutput>
                                            <cfoutput query='pUsers'>
                                                <tr>
                                                    <td><a href="employeeProfile.cfm?userID=#pUsers.userID#&projectID=#url.projectID#">#pUsers.userName#</a></td>
                                                    <td>#pUsers.employeeID#</td>
                                                    <td>#pUsers.name#</td>
                                                    <td>
                                                        <cfif #pUsers.hide# eq 1>
                                                            Inactive
                                                            <cfelse>
                                                                Active
                                                        </cfif>
                                                    </td>
                                                </tr>
                                            </cfoutput>
                                        </table>
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<cfinclude template="layouts/footer.cfm" />