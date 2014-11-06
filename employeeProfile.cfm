<!---
            Bug Tracker - Employee Profile CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfquery name="sample" datasource="bugTracking">
    select * from users u inner join designations d
    where u.userID=#url.userID# and
    u.designationID=d.designationID;
</cfquery>
<cfquery name="sample2" datasource="bugTracking">
    select * from users u inner join roles 
    r where u.userID=#url.userID# and
    u.roleID=r.roleID;
</cfquery>
<cfinclude template="layouts/header.cfm" />
<cfobject name="addUserObject" component="components.user">
<cfoutput>
    <div class="container-fluid">
        <div class="row-fluid">
            <cfset Session.highlight1="inactive"/>
            <cfset Session.highlight4="inactive"/>
            <cfinclude template="layouts/sidebar.cfm"/><!--- including sidebar --->
            <div class="span9" id="content">
                <div class="row-fluid">
                    <div class="navbar navbar-inner block-header">
                        <cfif isdefined('url.projectID')>
                            <div class="muted pull-left">
                                <cfset Session.highlight2="active"/>
                                <cfset Session.highlight3="inactive"/>
                                <a href="editProject.cfm?projectID=#url.projectID#" class="btn btn-default btn-primary" style="display:inline">
                                    <i class="icon-arrow-left"></i>&nbsp;Edit Project
                                </a>
                            </div>
                            <div class="muted pull-right">
                                <a href="editEmployee.cfm?userID=#url.userID#&projectID=#url.projectID#" class="btn btn-default btn-primary" style="display:inline">
                                    <i class="icon-plus-sign"></i>&nbsp;Edit Employee Details
                                </a>
                            </div>
                            <cfelse>
                                <div class="muted pull-left">
                                    <cfset Session.highlight2="inactive"/>
                                    <cfset Session.highlight3="active"/>
                                    <a href="employeeDetails.cfm" class="btn btn-default btn-primary" style="display:inline">
                                        <i class="icon-arrow-left"></i>&nbsp;Employee Details
                                    </a>
                                </div>
                                <div class="muted pull-right">
                                    <a href="editEmployee.cfm?userID=#url.userID#" class="btn btn-default btn-primary" style="display:inline">
                                        <i class="icon-plus-sign"></i>&nbsp;Edit Employee Details
                                    </a>
                                </div>
                        </cfif>
                    </div>
                    <div class="block">
                        <div class="navbar navbar-inner block-header">
                            <div class="muted pull-left"></div>
                        </div>
                        <div class="block-content collapse in">
                            <div class="span12">
                                <fieldset>
                                    <legend>User Profile</legend>
                                    <div class="control-group">
                                        <label class="control-label">User Name:</label>
                                        <div class="controls">
                                            <input type="text" name="uname" data-required="1" class="span6 m-wrap"  disabled value="#sample.userName#"/>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">Employee ID:</label>
                                        <div class="controls">
                                            <input name="empid" type="text" class="span6 m-wrap" disabled value="#sample.employeeID#"/>              									
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">Email:</label>
                                        <div class="controls">
                                            <input name="email" type="text" class="span6 m-wrap" required disabled value="#sample.email#"/>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">Contact Number 1:</label>
                                        <div class="controls">
                                             <input name="co1" type="text" class="span6 m-wrap" value="#sample.contactNumber1#" disabled/>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">Contact Number 2:</label>
                                        <div class="controls">
                                            <input name="co2" type="text" class="span6 m-wrap" value="#sample.contactNumber2#" disabled/>                                 
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">User Role:</label>
                                        <div class="controls">
                                            <input name="co2" type="text" class="span6 m-wrap" value="#sample2.name#" disabled/>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">Designation:</label>
                                        <div class="controls">
                                            <input name="co2" type="text" class="span6 m-wrap" value="#sample.name#" disabled/>
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
</cfoutput>
<cfif isDefined('form.save')>
    <cfobject name="updateObject" component="components.user">
    <cfoutput>#updateObject.updateProfile()#</cfoutput>
</cfif>
<cfinclude template="layouts/footer.cfm" />