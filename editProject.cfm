<!---
            Bug Tracker - Edit Project CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfinclude template="layouts/header.cfm"/><!--- including header --->
<cfscript>
    function checkDate() {
        var EnteredDate = $(".txtdate").val();
        var year = EnteredDate.substring(0, 4);
        var month = EnteredDate.substring(5, 7);
        var date = EnteredDate.substring(8, 10);
        date++;
        var myDate = new Date(year, month - 1, date);
        var EnteredDate2 = $(".txtdate2").val();
        var year2 = EnteredDate2.substring(0, 4);
        var month2 = EnteredDate2.substring(5, 7);
        var date2 = EnteredDate2.substring(8, 10);
        var myDate2 = new Date(year2, month2 - 1, date2);
        var today = new Date();
        if (myDate2 >= myDate) {
            return true;
        } else {
            alert("Estimated end date should be greater than or equal to estimated start date");
            return false;
        }
    }
    function fun_delete(element) {
        var e = element;
    }
</cfscript>
<cfoutput>
    <div class="container-fluid">
        <div class="row-fluid">
            <cfset Session.highlight1="inactive" />
            <cfset Session.highlight2="active" />
            <cfset Session.highlight3="inactive" />
            <cfset Session.highlight4="inactive" />
            <cfset Session.highlight5="inactive" />
            <cfset Session.highlight6="inactive" />
            <cfinclude template="layouts/sidebar.cfm" /><!--- including sidebar --->
            <div class="span9" id="content">
                <div class="row-fluid">
                    <cfif isdefined( 'flag')>
                        <div class="navbar navbar-inner block-header">
                            <div class="muted pull-left">
                                <a href="projectProfile.cfm?projectID=#url.projectID#"
                                   class="btn btn-default btn-primary"
                                   style="display:inline">
                                    <i class="icon-arrow-left"></i>
                                    &nbsp;Project Profile
                                </a>
                            </div>
                            <div class="muted pull-right">
                                <a href="addmilestone.cfm?projectID=#url.projectID#&flag"
                                   class="btn btn-default btn-primary"
                                   style="display:inline">
                                    <i class="icon-plus-sign"></i>
                                    &nbsp;Milestone
                                </a>&nbsp;&nbsp;&nbsp;&nbsp;
                                <a href="addProjectMembers.cfm?projectID=#url.projectID#&flag"
                                   class="btn btn-default btn-primary"
                                   style="display:inline">
                                    <i class="icon-plus-sign"></i>
                                    &nbsp;Project Members
                                </a>
                            </div>
                        </div>
                        <cfelse>
                            <div class="navbar navbar-inner block-header">
                                <div class="muted pull-left">
                                    <a href="projectDetails.cfm"
                                       class="btn btn-default btn-primary"
                                       style="display:inline">
                                        <i class="icon-arrow-left"></i>
                                        &nbsp;Project Details
                                    </a>
                                </div>
                                <div class="muted pull-right">
                                    <a href="addProjectMembers.cfm?projectID=#url.projectID#"
                                       class="btn btn-default btn-primary"
                                       style="display:inline">
                                        <i class="icon-plus-sign"></i>
                                        &nbsp;Project Members
                                    </a>
                                </div>
                            </div>
                    </cfif>
                    <div class="block">
                        <div class="navbar navbar-inner block-header">
                            <div class="muted pull-left"></div>
                        </div>
                        <div class="block-content collapse in">
                            <div class="span12">
                                <cfquery name="project" datasource="#Application.dataSourceName#">
                                    select p.projectID, p.projectName, p.projectDescription,
                                    p.estimatedStartDate, p.estimatedEndDate, p.statusID,
                                    p.priorityID, s.name as statusName, pr.name as priorityName
                                    from projects as p inner join status as s inner join priorities pr
                                    on p.statusID=s.statusID and p.projectID=
                                    <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
                                    and p.priorityID=pr.priorityID
                                </cfquery>
                                <cfquery name="status" datasource="#Application.dataSourceName#">
                                    select * from status;
                                </cfquery>
                                <cfquery name="priority" datasource="#Application.dataSourceName#">
                                    select * from priorities;
                                </cfquery>
                                <cfquery name="pUsers" datasource="#Application.dataSourceName#">
                                    select u.userID, u.firstName, u.employeeID, d.name, pu.isLead
                                    from projectUsers pu inner join users u inner join designations d
                                    where pu.userID=u.userID and d.designationID=u.designationID
                                    and pu.hide=0 and pu.projectID=
                                    <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
                                </cfquery>
                                <form action="editProject.cfm?projectID=#url.projectID#"
                                      class="form-horizontal"
                                      method="post"
                                      onsubmit="return checkDate()">
                                    <fieldset>
                                        <legend>Edit Project</legend>
                                        <div class="alert alert-error hide">
                                            <button class="close" data-dismiss="alert"></button>
                                            You have some form errors. Please check below.
                                        </div>
                                        <div class="alert alert-success hide">
                                            <button class="close" data-dismiss="alert"></button>
                                            Project has been successfully edited.
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">
                                                Project Name
                                                <span class="required">*</span>
                                            </label>
                                            <div class="controls">
                                                <input type="text"
                                                       name="projectName"
                                                       value="#project.projectName#"
                                                       data-required="1"
                                                       class="span6 m-wrap"
                                                       required/>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">
                                                Estimated Start Date
                                                <span class="required">*</span>
                                            </label>
                                            <div class="controls">
                                                <input id="txtdate"
                                                       name="estimatedStartDate"
                                                       type="date"
                                                       value="#dateformat(project.estimatedStartDate)#"
                                                       class="txtdate span6 m-wrap"
                                                       required/>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">
                                                Estimated End Date
                                                <span class="required">*</span>
                                            </label>
                                            <div class="controls">
                                                <input name="estimatedEndDate"
                                                       type="date"
                                                       value="#dateformat(project.estimatedEndDate)#"
                                                       class="txtdate2 span6 m-wrap"
                                                       required/>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">
                                                Project Description
                                                <span class="required"></span>
                                            </label>
                                            <div class="controls">
                                                <textarea name="projectDescription"
                                                           value="#project.projectDescription#"
                                                           class="span6 m-wrap"/>
                                                </textarea>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">
                                                Project Status
                                                <span class="required">*</span>
                                            </label>
                                            <div class="controls">
                                                <select class="input-medium" name="statusID">
                                                    <option value="#project.statusID#">
                                                        #project.statusName#
                                                    </option>
                                                    <cfloop query="status">
                                                        <cfif status.statusID neq project.statusID>
                                                            <option value="#status.statusID#">
                                                                #status.name#
                                                            </option>
                                                        </cfif> 
                                                    </cfloop>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">
                                                Project Priority
                                                <span class="required">*</span>
                                            </label>
                                            <div class="controls">
                                                <select class="input-medium" name="priorityID">
                                                    <option value="#project.priorityID#">
                                                        #project.priorityName#
                                                    </option>
                                                    <cfloop query="priority">
                                                        <cfif priority.priorityID neq project.priorityID>
                                                            <option value="#priority.priorityID#">
                                                                #priority.name#
                                                            </option>
                                                        </cfif>
                                                    </cfloop>
                                                </select>
                                            </div>
                                        </div>                                        
                                        <div class="form-actions">
                                            <button type="submit"
                                                    class="btn btn-primary"
                                                    name="submit">
                                                Add Details
                                            </button>
                                            <a href="projectDetails.cfm">
                                                <button type="button" class="btn">
                                                    Cancel
                                                </button>
                                            </a>
                                        </div>
                                    </fieldset>
                                </form>
                                <div class="control-group">
                                    <label class="control-label">
                                        <span class="required"></span>
                                    </label>
                                    <div class="controls">
                                        <table class="table table-bordered">
                                            <tr>
                                                <td>Employee ID</td>
                                                <td>Employee Name</td>
                                                <td>Designation</td>
                                                <td></td>
                                            </tr>
                                            </cfoutput>
                                        <cfoutput query="pUsers">
                                            <tr>
                                                <td>
                                                    <a href="employeeProfile.cfm?
                                                             userID=#pUsers.userID#
                                                             &projectID=#url.projectID#">
                                                        #pUsers.firstName#
                                                    </a>
                                                </td>
                                                <td>#pUsers.employeeID#</td>
                                                <td>#pUsers.name#</td>
                                                <td>
                                                    <cfif isdefined( 'flag')>
                                                        <a href="lead.cfm?userID=#pUsers.userID#&projectID=#url.projectID#&removeProjectMember&flag"
                                                           class="btn  btn-mini btn-success">
                                                            <cfif pUsers.isLead eq 1>
                                                                Team Lead
                                                                <cfelse>
                                                                    Team Member
                                                            </cfif>
                                                        </a>
                                                        <cfelse>
                                                            <a href="lead.cfm?userID=#pUsers.userID#&projectID=#url.projectID#"
                                                               class="btn  btn-mini btn-success">
                                                                <cfif pUsers.isLead eq 1>
                                                                    Team Lead
                                                                    <cfelse>
                                                                        Team Member
                                                                </cfif>
                                                            </a>
                                                    </cfif>
                                                </td>
                                                <td>
                                                    <cfif isdefined( 'flag')>
                                                        <a href="deleteRecord.cfm?userID=#pUsers.userID#&projectID=#url.projectID#&removeProjectMember&flag"
                                                           class="btn btn-danger btn-mini">
                                                            <i class="icon-remove"></i>
                                                        </a>
                                                        <cfelse>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a href="deleteRecord.cfm?userID=#pUsers.userID#&projectID=#url.projectID#&removeProjectMember"
                                                               class="btn btn-danger btn-mini">
                                                                <i class="icon-remove"></i>
                                                            </a>
                                                    </cfif>
                                                </td>
                                            </tr>
                                        </cfoutput>
                                    </table>
                                </div>
                            </div>
                            <cfquery name="milestones" datasource="#Application.dataSourceName#">
                                select * from milestones where projectID=
                                <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
                                and milestoneHide=0 order by milestoneStatus
                            </cfquery>
                            <div class="control-group">
                                <label class="control-label">
                                    <span class="required"></span>
                                </label>
                                <div class="controls">
                                    <table class="table table-bordered">
                                        <tr>
                                            <th>
                                                <strong>Milestone</strong>
                                            </th>
                                            <th>
                                                <strong>Date</strong>
                                            </th>
                                            <th>
                                                <strong>Status</strong>
                                            </th>
                                            <th></th>
                                        </tr>
                                        <cfset mtotal=0/>
                                        <cfoutput query='milestones'>
                                            <cfset mtotal="#mtotal+1#"/>
                                            <tr>
                                                <td>#milestones.milestoneName#</td>
                                                <td>#dateformat(milestones.milestoneDate)#</td>
                                                <td>
                                                    <cfif isdefined( 'flag')>
                                                        <a href="milestone.cfm?mID=#milestones.milestoneID#&mstatus=#milestones.milestoneStatus#&projectID=#url.projectID#&removeProjectMember&flag"
                                                           class="btn btn-mini btn-success">
                                                            <cfif #milestones.milestoneStatus# eq "completed">
                                                                completed
                                                                <cfelse>
                                                                    progress
                                                            </cfif>
                                                        </a>
                                                        <cfelse>
                                                            <a href="milestone.cfm?mID=#milestones.milestoneID#&mstatus=#milestones.milestoneStatus#&projectID=#url.projectID#"
                                                               class="btn btn-mini btn-success">
                                                                <cfif #milestones.milestoneStatus# eq "progress">
                                                                    progress
                                                                    <cfelse>
                                                                        completed
                                                                </cfif>
                                                            </a>
                                                    </cfif>
                                                </td>
                                                <td>
                                                    <a href="deleteRecord.cfm?milestoneID=#milestones.milestoneID#&projectID=#url.projectID#&milestones"
                                                       class="btn btn-danger btn-mini">
                                                        <i class="icon-remove "></i>
                                                    </a>
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
    </div>
</div>
<cfif structkeyexists(form, 'submit')>
    <cfquery name="editProject" datasource="#Application.dataSourceName#" result="ep">
        update projects set projectName=
        <cfqueryparam value="#form.projectName#" cfsqltype="cf_sql_tinyint"/>,
        projectDescription=
        <cfqueryparam value="#form.projectDescription#" cfsqltype="cf_sql_tinyint"/>,
        estimatedStartDate=
        <cfqueryparam value="#form.estimatedStartDate#" cfsqltype="cf_sql_tinyint"/>,
        estimatedEndDate=
        <cfqueryparam value="#form.estimatedEndDate#" cfsqltype="cf_sql_tinyint"/>,
        statusID=
        <cfqueryparam value="#form.statusID#" cfsqltype="cf_sql_tinyint"/>,
        priorityID=
        <cfqueryparam value="#form.priorityID#" cfsqltype="cf_sql_tinyint"/>, userID=#Session.userID# where projectID=#url.projectID#
    </cfquery>
    <cfif ep.recordcount>
        <cflocation url="projectProfile.cfm?projectID=#url.projectID#" addtoken="false"/>
    </cfif>
</cfif>
<cfinclude template="layouts/footer.cfm" />
