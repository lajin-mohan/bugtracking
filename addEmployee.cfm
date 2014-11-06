<!---
            Bug Tracker - Add Employee CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfobject name="addUserObject" component="components.user">
<cfinclude template="layouts/header.cfm">
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="inactive">
        <cfset Session.highlight2="inactive">
        <cfset Session.highlight3="active">
        <cfset Session.highlight4="inactive">
        <cfinclude template="layouts/sidebar.cfm">
        <div class="span9" id="content">
            <div class="row-fluid">
                <div class="navbar navbar-inner block-header">
                    <div class="muted pull-left">
                        <cfoutput>
                            <a href="employeeDetails.cfm" class="btn btn-default btn-primary" style="display:inline">
                                <i class="icon-arrow-left"></i>&nbsp;Employee Details
                            </a>
                        </cfoutput>
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left"></div>
                    </div><!--- close of navbar navbar-inner block-header --->
                    <div class="block-content collapse in">
                        <div class="span12">
                    		<form action="addEmployee.cfm" id="form_sample_1" class="form-horizontal" method="post">
                    			<fieldset>
                    			    <legend>Add New Employee</legend>
			                        <div class="alert alert-error hide">
				                        <button class="close" data-dismiss="alert"></button>
				                        You have some form errors. Please check below.
			                        </div><!--- close of alert alert-error hide --->
			                        <div class="alert alert-success hide">
				                        <button class="close" data-dismiss="alert"></button>
				                        Employee has been successfully added to the database!
			                        </div><!--- close of alert alert-error hide --->
			                        <div class="control-group">
				                        <label class="control-label">Name<span class="required">*</span></label>
				                        <div class="controls">
					                        <input type="text" name="name" data-required="1" class="span6 m-wrap" required>
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group --->
			                        <div class="control-group">
				                        <label class="control-label">Email<span class="required">*</span></label>
				                        <div class="controls">
					                        <input name="email" type="text" class="span6 m-wrap" required>
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group --->
			                        <div class="control-group">
				                        <label class="control-label">Employee Code<span class="required">*</span></label>
				                        <div class="controls">
					                        <input name="empCode" type="text" class="span6 m-wrap" required>
					                    </div><!--- close of control-label --->
			                        </div><!--- close of control-group --->
			                        <div class="control-group">
				                        <label class="control-label">Password<span class="required">*</span></label>
				                        <div class="controls">
					                        <input name="password" type="password" class="span6 m-wrap" required>
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group --->
			                        <div class="control-group">
				                        <label class="control-label">Designation<span class="required">*</span></label>
				                        <div class="controls">
					                        <select class="span6 m-wrap" name="designation">
                                            <cfset loopName1= #addUserObject.getDesignation("designations")#>
                                                    <option value="">Select.....</option>
                                            <cfloop query="loopName1">
                                                <cfoutput>
                                                    <option value="#loopName1.designationID#">#loopName1.name#</option>
                                                </cfoutput>
                                            </cfloop>
					                        </select>
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group --->
			                        <div class="control-group">
				                        <label class="control-label">User Role<span class="required">*</span></label>
				                        <div class="controls">
					                        <select class="span6 m-wrap" name="role">
                                            <cfset loopName2= #addUserObject.getDesignation("roles")#>
                                                    <option value="">Select.....</option>
                                            <cfloop query="loopName2">
                                                <cfoutput>
                                                    <option value="#loopName2.roleID#">#loopName2.name#</option>
                                                </cfoutput>
                                            </cfloop>
					                        </select>
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group --->
			                        <div class="form-actions">
				                        <input type="submit" class="btn btn-primary" name="submit" value="Add User">
				                        <a href="employeeDetails.cfm"><input type="button" class="btn" name="cancel" value="Cancel"></a>
			                        </div><!--- close of form-actions --->
		                        </fieldset><!--- close of fieldset --->
	                        </form><!--- close of fieldset --->
                	    </div><!--- close of span12 --->
                	</div><!--- close of block-content collapse in --->
                </div><!--- close of block --->
            </div><!--- close of row-fluid --->
        </div><!--- close of span9 --->
    </div><!--- close of row-fluid --->
</div><!--- close of container-fluid ---><
<cfif isDefined('form.submit')>
    <cfoutput>#addUserObject.addUser()#</cfoutput>
    <cfelse>
        Error
</cfif>
<cfinclude template="layouts/footer.cfm">
