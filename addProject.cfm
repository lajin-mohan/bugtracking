<!---
            Bug Tracker - Project Details CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfobject name="addUserObject" component="components.user"/>
<cfinclude template="layouts/header.cfm"/><!--including header-->
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="inactive"/>
        <cfset Session.highlight2="active"/>
        <cfset Session.highlight3="inactive"/>
        <cfset Session.highlight4="inactive"/>
        <cfset Session.highlight5="inactive"/>
        <cfset Session.highlight6="inactive"/>
        <cfinclude template="layouts/sidebar.cfm"/><!--including sidebar-->
        <div class="span9" id="content">
            <div class="row-fluid">
                <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">
                            <cfoutput>
                                <a href="projectDetails.cfm" class="btn btn-default btn-primary" style="display:inline">
                                    <i class="icon-arrow-left"></i>&nbsp;Project Details
                                </a>
                            </cfoutput>
                        </div>
                    </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">
                            <center><h3>Add New Project</h3></center>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <form action="addProject.cfm" method="post" class="form-horizontal"><!--form to add project-->
                                <fieldset>
                                    <div class="alert alert-error hide">
                                        <button class="close" data-dismiss="alert"></button>
                                        You have some form errors. Please check below.
                                    </div>
                                    <div class="alert alert-success hide">
                                        <button class="close" data-dismiss="alert"></button>
                                        Project has been successfully added to the database!
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">
                                            Project Name
                                            <span class="required">*</span>
                                        </label>
                                        <div class="controls">
                                            <input type="text" name="projectName" data-required="1" class="span6 m-wrap" required/>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">
                                            Estimated Start Date
                                            <span class="required">*</span>
                                        </label>
                                        <div class="controls">
                                            <input name="estimatedStartDate" type="date" class="txtdate span6 m-wrap" required/>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">
                                            Estimated End Date
                                            <span class="required">*</span>
                                        </label>
                                        <div class="controls">
                                            <input name="estimatedEndDate" type="date" class="txtdate span6 m-wrap" required/>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">
                                            Project Description
                                            <span class="required"></span>
                                        </label>
                                        <div class="controls">
                                            <input name="projectDescription" type="textarea" class="span6 m-wrap" />	
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">
                                            Project Status
                                            <span class="required"></span>
                                        </label>
                                        <div class="controls">
                                            <input type="text" value="Pending" class="span6 m-wrap" disabled/>
                                        </div>
                                    </div>
                                    <div class="control-group">
				                        <label class="control-label">
                                            Priority
                                            <span class="required">*</span>
                                        </label>
				                        <div class="controls">
					                        <select class="span6 m-wrap" name="priorityID">
                                            <cfset loopName2= #addUserObject.getDesignation("priorities")#>
                                                    <option value="">Select.....</option>
                                            <cfloop query="loopName2">
                                                <cfoutput>
                                                    <option value="#loopName2.priorityID#">#loopName2.name#</option>
                                                </cfoutput>
                                            </cfloop>
					                        </select>
				                        </div>
			                        </div>
                                    <div class="form-actions">
                                        <button type="submit" class="btn btn-primary" name="submit">Add Project</button>
                                        <button type="button" class="btn">Cancel</button>
                                    </div>
                                </fieldset>
                            </form><!--close of form-->
                            <cfif structkeyexists(form,"submit")>
                                <cfquery result="checkEmail" datasource="#Application.dataSourceName#">
                                    select projectName from projects where projectName=
                                    <cfqueryparam value="#form.projectName#" cfsqltype="cf_sql_varchar"/>
                                </cfquery>
                                <cfif checkEmail.recordcount><!--checking if project with same name exists-->
                                    <p>Project already exists on database</p>
                                    <cfelse>
                                        <cfquery name="project" datasource="#Application.dataSourceName#">
                                            insert into projects(projectName, estimatedStartDate, 
                                            estimatedEndDate, projectDescription, statusID, 
                                            priorityID , userID) values(
                                            <cfqueryparam value="#form.projectName#" cfsqltype="cf_sql_varchar"/>,
                                            <cfqueryparam value="#form.estimatedStartDate#" cfsqltype="cf_sql_date"/>,
                                            <cfqueryparam value="#form.estimatedEndDate#" cfsqltype="cf_sql_date"/>,
                                            <cfqueryparam value="#form.projectDescription#" cfsqltype="cf_sql_varchar"/>,
                                            <cfqueryparam value="3" cfsqltype="cf_sql_tinyint"/>,
                                            <cfqueryparam value="#form.priorityID#" cfsqltype="cf_sql_tinyint"/>,
                                            <cfqueryparam value="#Session.userID#" cfsqltype="cf_sql_tinyint"/>);
                                        </cfquery>
                                        <cflocation url="projectDetails.cfm" addtoken="false"/>
                                </cfif>
                            </cfif>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<cfinclude template="layouts/footer.cfm"><!--- including footer --->
