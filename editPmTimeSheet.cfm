<!---
            Bug Tracker - Edit PM Time Sheet CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfobject name="obj" component="components.user"/>
<cfquery name="selectDetails" datasource="#Application.dataSourceName#">
    select timeSheet.dateTime, projects.projectName, timeSheet.description, 
    timeSheet.workingHour, timeSheet.productiveHours, status.name, status.statusID
    from timeSheet inner join status on timeSheet.statusID=status.statusID 
    inner join projectUsers on timeSheet.userID=projectUsers.userID 
    inner join projects on projects.projectID=timeSheet.projectID 
    and timeSheet.userID=
    <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_tinyint"/>
    and timeSheet.projectID=
    <cfqueryparam value="#url.pid#" cfsqltype="cf_sql_tinyint"/>
</cfquery>
<cfquery name="getbugs" datasource="#Application.dataSourceName#">
    select bugs.bugName,bugs.bugID from bugs inner join bugUsers on
    bugs.bugID=bugUsers.bugID and bugUsers.userID=
    <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_tinyint"/>
</cfquery>
<cfquery name="getStatus" datasource="#Application.dataSourceName#">
    select * from status where statusID=4 or statusID=3 or statusID=5 or statusID=7
</cfquery>
<cfobject name="addDetails" component="components.timeSheet"/>
<cfinclude template="layouts/header.cfm"/>
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="inactive"/>
        <cfset Session.highlight2="inactive"/>
        <cfset Session.highlight3="active"/>
        <cfset Session.highlight4="inactive"/>
        <cfset Session.highlight5="inactive"/>
        <cfset Session.highlight6="inactive"/>
        <cfinclude template="layouts/sidebar.cfm"/><!---including sidebar--->
        <div class="span9" id="content">
            <div class="row-fluid">
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">Time Sheet</div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <form action="" 
                                  id="form_sample_1" 
                                  class="form-horizontal"
                                  method="post">
                                <fieldset>
                                    <div class="alert alert-error hide">
                                        <button class="close" data-dismiss="alert"></button>
                                        You have some form errors. Please check below.
                                    </div>
                                    <div class="alert alert-success hide">
                                        <button class="close" data-dismiss="alert"></button>
                                        Employee has been successfully added to the database!
                                    </div>
                                    <div class="control-group">
                                        <div class="muted pull-right">         
                                            <a href="timeSheetHistory.cfm"
                                               class="btn btn-default btn-primary"
                                               style="display:inline"/>
                                                View Time Sheet
                                            </a>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">
                                            Project
                                            <span class="required">*</span>
                                        </label>
                                        <div class="controls">
                                            <cfoutput>
                                                <input type="textarea"
                                                       name="description"
                                                       data-required="1"
                                                       class="span6 m-wrap"
                                                       value="#selectDetails.projectName#"
                                                       disabled/>
                                            </cfoutput>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">
                                            Bug Description
                                            <span class="required">*</span>
                                        </label>
                                        <div class="controls">
                                            <cfoutput>
                                                <input type="textarea"
                                                       name="description"
                                                       data-required="1"
                                                       class="span6 m-wrap"
                                                       value="#selectDetails.description#"
                                                       required/>
                                            </cfoutput>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">
                                            Hours Worked
                                            <span class="required">*</span>
                                        </label>
                                        <div class="controls">
                                            <cfoutput>
                                                <input name="hours"
                                                       type="text"
                                                       class="span6 m-wrap"
                                                       value="#selectDetails.workingHour#"
                                                       required/>
                                            </cfoutput>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">
                                            Productive Hours
                                            <span class="required">*</span>
                                        </label>
                                        <div class="controls">
                                            <cfoutput>
                                                <input name="productiveHours"
                                                       type="text"
                                                       class="span6 m-wrap"
                                                       value="#selectDetails.productiveHours#"
                                                       required/>
                                            </cfoutput>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">
                                            Date
                                            <span class="required">*</span>
                                        </label>
                                        <div class="controls">                                         
                                            <cfoutput>
                                                <input name="editedDate"
                                                       type="date"
                                                       class="txtdate span6 m-wrap"
                                                       value="#DateFormat(selectDetails.dateTime,'dd/mm/yyyy')#"
                                                       required/>
                                            </cfoutput>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">
                                            Status
                                            <span class="required">*</span>
                                        </label>
                                        <div class="controls">  
                                            <select name="status"> 
                                                <cfoutput>
                                                    <option value="#selectDetails.statusID#">
                                                        #selectDetails.name#
                                                    </option>
                                                </cfoutput>
                                                <cfloop query="getStatus">
                                                    <cfoutput>
                                                        <cfif #selectDetails.statusID# neq #getStatus.statusID#>
                                                            <option value="#getStatus.statusID#">
                                                                #getStatus.name#
                                                            </option>
                                                        </cfif>
                                                    </cfoutput>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-actions">
                                        <input type="submit"
                                               class="btn btn-primary"
                                               name="submit"
                                               value="Submit"/>
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
<cfif isDefined('form.submit')>
    <cfoutput>#addDetails.updatePmTimeSheet()#</cfoutput>
    <cflocation url="pmTimeSheetHistory.cfm"/>
</cfif>
<cfinclude template="layouts/footer.cfm"/><!---including footer--->
