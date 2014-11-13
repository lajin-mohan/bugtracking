<!---
            Bug Tracker - Edit Employee CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfquery name="sample" datasource="bugTracking">
    select * from users u inner join designations d 
    where u.userID=#url.userID# and
    u.designationID=d.designationID;
</cfquery>
<cfquery name="sample2" datasource="bugTracking">
    select * from users u 
    inner join roles r where u.userID=#url.userID# and
    u.roleID=r.roleID;
</cfquery>
<cfobject name="addUserObject" component="components.user">
<cfinclude template="layouts/header.cfm" />
<div class="container-fluid">
        <div class="row-fluid">
            <cfset Session.highlight1="inactive"/>
            <cfset Session.highlight3="inactive"/>
            <cfset Session.highlight4="inactive"/>
            <cfset Session.highlight6="inactive"/>
            <cfinclude template="layouts/sidebar.cfm"/><!--- including sidebar --->
            <div class="span9" id="content">
                <div class="row-fluid">
                    <div class="navbar navbar-inner block-header">
                    <div class="muted pull-left">
                        <cfif isdefined('flag') or isdefined('projectID')>
                            <cfoutput><a href="employeeProfile.cfm?userID=#url.userID#&projectID=#url.projectID#" class="btn btn-default btn-primary" style="display:inline"></cfoutput>
                                <i class="icon-arrow-left"></i>&nbsp;Employee Profile
                                <cfset Session.highlight2="active"/>
                                <cfset Session.highlight5="inactive"/>
                            </a>
                            <cfelse>
                                <a href="employeeDetails.cfm" class="btn btn-default btn-primary" style="display:inline">
                                    <i class="icon-arrow-left"></i>&nbsp;Employee Details
                                    <cfset Session.highlight2="inactive"/>
                                    <cfset Session.highlight5="active"/>
                                </a>
                        </cfif>
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header"></div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <cfoutput>
                                <form action="editEmployee.cfm?userID=#url.userID#" class="form-horizontal" method="post">
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
                                            <label class="control-label">User Name:<span class="required">*</span></label>
                                            <div class="controls">
                                                <input type="text" name="uname" data-required="1" class="span6 m-wrap" value="#sample.userName#" required/>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">Employee ID:<span class="required">*</span></label>
                                            <div class="controls">
                                                <input name="empid" type="text" class="span6 m-wrap" value="#sample.employeeID#" required/>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">Email:<span class="required">*</span></label>
                                            <div class="controls">
                                                <input name="email" type="text" class="span6 m-wrap" value="#sample.email#" required/>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">Password:</label>
                                            <div class="controls"> 
                                                 <input name="pwd" type="password" class="span6 m-wrap" disabled  value="#sample.password#"/>
                                                 <input type="button" id="but" value="Change" />
                                            </div>
                                        </div>
                                        <div id="edit_pwd">            
                                            <div class="control-group">
                                                <label class="control-label">Password:<span class="required">*</span></label>
                                                <div class="controls">
                                                    <input name="newPassword" type="password" class="span3 m-wrap" />
                                                </div>
                                            </div>
                                        </div>

                                        <div class="control-group">
                                            <label class="control-label">Contact Number 1:</label>
                                            <div class="controls">
                                                <input name="co1" type="text" class="span6 m-wrap" value="#sample.contactNumber1#"/>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">Contact Number 2:</label>
                                            <div class="controls">
                                                <input name="co2" type="text" class="span6 m-wrap"  value="#sample.contactNumber2#"/>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">User Role:<span class="required">*</span></label>
                                            <div class="controls">
                                                <select class="span6 m-wrap" name="role">
                                                <cfset loopName2= #addUserObject.getDesignation("roles")#>
                                                        <option value="#sample2.roleID#">#sample2.name#</option>
                                                <cfloop query="loopName2">
                                                    <cfoutput>
                                                        <cfif loopName2.roleID neq sample.roleID>
                                                            <option value="#loopName2.roleID#">#loopName2.name#</option>
                                                        </cfif>
                                                    </cfoutput>
                                                </cfloop>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">Designation:<span class="required">*</span></label>
                                            <div class="controls">
                                                <select class="span6 m-wrap" name="designation">
                                                <cfset loopName1= #addUserObject.getDesignation("designations")#>
                                                        <option value="#sample.designationID#">#sample.name#</option>
                                                <cfloop query="loopName1">
                                                    <cfoutput>
                                                        <cfif loopName1.designationID neq sample.designationID>
                                                            <option value="#loopName1.designationID#">#loopName1.name#</option>
                                                        </cfif>
                                                    </cfoutput>
                                                </cfloop>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <input  type="submit" class="btn btn-primary" name="save" value="Save" />
                                            <a href="employeeDetails.cfm"><button type="button" class="btn">Cancel</button></a>
                                        </div>
                                    </fieldset>
                                </form>
                            </cfoutput>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<cfif isDefined('form.save')>
    <cfobject name="updateObject" component="components.user">
    <cfoutput>#updateObject.updateProfile(userID)#</cfoutput>
</cfif>
<cfinclude template="layouts/footer.cfm" />