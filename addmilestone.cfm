<!---
            Bug Tracker - Add Project Members CFM
            October 30, 2014
            Author: CF Freshers 2014
--->
<cfif isDefined("form.add")>
    <cfif len(trim(form.formMilestoneName)) and (form.formMilestoneStatus neq "select")>
        <cfquery name="mins" datasource="#Application.dataSourceName#">
            insert into milestones 
            (projectID,milestoneName,milestoneDescription,milestoneDate,milestoneStatus)
            values(
            <cfqueryparam cfsqltype="cf_sql_tinyint" value="#url.projectID#">,
            <cfqueryparam value='#form.formMilestoneName#' cfsqltype="cf_sql_varchar">,
            <cfqueryparam value='#form.formMilestoneDescription#' cfsqltype="cf_sql_varchar">,
            <cfqueryparam value='#form.formMilestoneDate#' cfsqltype="cf_sql_date">,
            <cfqueryparam value='#form.formMilestoneStatus#' cfsqltype="cf_sql_varchar"> )
        </cfquery>
    <cfelse>
        <p>Fields cannot be left blank</p>
    </cfif>
</cfif>
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
                <div class="navbar navbar-inner block-header">
                    <div class="muted pull-left">
                        <cfif isdefined('url.flag')>
                            <cfoutput><a href="editProject.cfm?projectID=#url.projectID#&flag" class="btn btn-default btn-primary" style="display:inline"></cfoutput>
                                <i class="icon-arrow-left"></i>&nbsp;Edit Project
                            </a>
                            <cfelse>
                                <cfoutput><a href="editProject.cfm?projectID=#url.projectID#" class="btn btn-default btn-primary" style="display:inline"></cfoutput>
                                    <i class="icon-arrow-left"></i>&nbsp;Edit Project
                                </a>
                        </cfif>
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">
                            <form class="form-search" action=" " method="post">
                            <input type="text" class="input-medium search-query" name="search" placeholder="Search Employee"/>
                            <input class="btn btn-mini btn-primary" type="submit" name="search_btn" value="GO"/>
                            </form>
                        </div>
                    </div>                    
                    <div class="block-content collapse in">
                        <div class="span12">
                            
                             <form action=" " method="post">
                                <fieldset>
                                    <legend>Add Milestone</legend>
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
                                            Milestone Name
                                            <span class="required">*</span>
                                        </label>
                                        <div class="controls">
                                            <input type="text" class="form-control  span6 m-wrap" name="formMilestoneName" placeholder=" Milestone Name" required>
                                        </div>
                                    </div>
                                  
                                    <div class="control-group">
                                        <label class="control-label">
                                            Milestone Date
                                            <span class="required">*</span>
                                        </label>
                                        <div class="controls">
                                             <input type="date" class="form-control   span6 m-wrap" name="formMilestoneDate" placeholder=" Date" required>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">
                                            Milestone Description
                                            <span class="required">*</span>
                                        </label>
                                        <div class="controls">
                                            <textarea class=" span6 m-wrap" name="formMilestoneDescription" placeholder="Milestone Description" required></textarea>	
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">
                                            Milestone Status
                                            <span class="required">*</span>
                                        </label>
                                        <div class="controls">
                                            <select name="formMilestoneStatus"  class=" span6 m-wrap" required>
                                           
                                        <option value="select" >-- Select --</option>
                                        <option value="Progress" >Progress</option>
                                        <option value="Completed">Completed</option>
                                               
                                     </select>
                                        </div>
                                    </div>
                                   
                                    <div class="form-actions">
                                        <input type="submit" class="btn btn-primary  hide-element" id="add" name="add"  value="ADD">
                             <button type="reset" class="btn " id="mcancel">Cancel</button>
                                    </div>
                                </fieldset>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<cfinclude template="layouts/footer.cfm"/>
