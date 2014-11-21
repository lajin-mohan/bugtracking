<!---
            Bug Tracker - Add Employee CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfobject name="addUserObject" component="components.user"/>
<cfinclude template="layouts/header.cfm"/><!--including header-->
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="inactive"/>
        <cfset Session.highlight2="inactive"/>
        <cfset Session.highlight3="inactive"/>
        <cfset Session.highlight4="inactive"/>
        <cfset Session.highlight5="active"/>
        <cfset Session.highlight6="inactive"/>
        <cfinclude template="layouts/sidebar.cfm"/><!--including sidebar-->
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
                        <div class="muted pull-left">
                            <center><h3>Add New Employee</h3></center>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                    		<form action="addEmployee.cfm" id="form_sample_1" 
                                  class="form-horizontal" method="post"><!--add employee form-->
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
				                        <label class="control-label">First Name<span class="required">*</span></label>
				                        <div class="controls">
					                        <input type="text" name="firstName" data-required="1" class="span6 m-wrap" required/>
				                        </div>
			                        </div>
			                        <div class="control-group">
				                        <label class="control-label">Last Name<span class="required">*</span></label>
				                        <div class="controls">
					                        <input type="text" name="lastName" data-required="1" class="span6 m-wrap" required/>
				                        </div>
			                        </div>
			                        <div class="control-group">
				                        <label class="control-label">Email<span class="required">*</span></label>
				                        <div class="controls">
					                        <input name="email" type="text" class="span6 m-wrap" required/>
				                        </div>
			                        </div>
			                        <div class="control-group">
				                        <label class="control-label">Employee Code<span class="required">*</span></label>
				                        <div class="controls">
					                        <input name="empCode" type="text" class="span6 m-wrap" required/>
					                    </div>
			                        </div>
			                        <div class="control-group">
				                        <label class="control-label">Password<span class="required">*</span></label>
				                        <div class="controls">
					                        <input name="password" type="password" class="span6 m-wrap" required/>
				                        </div>
			                        </div>
			                        <div class="control-group">
				                        <label class="control-label">Designation<span class="required">*</span></label>
				                        <div class="controls">
					                        <select class="span6 m-wrap" name="designation">
                                                <cfset loopName1=#addUserObject.getDesignation
                                                       ("designations")#/><!--function to display all values in a table-->
                                                <option value="">Select.....</option>
                                                <cfloop query="loopName1">
                                                    <cfoutput>
                                                        <option value="#loopName1.designationID#">#loopName1.name#</option>
                                                    </cfoutput>
                                                </cfloop>
					                        </select>
				                        </div>
			                        </div>
			                        <div class="control-group">
				                        <label class="control-label">User Role<span class="required">*</span></label>
				                        <div class="controls">
					                        <select class="span6 m-wrap" name="role">
                                                <cfset loopName2= #addUserObject.getDesignation
                                                       ("roles")#/><!--function to display all values in a table-->
                                                <option value="">Select.....</option>
                                                <cfloop query="loopName2">
                                                    <cfoutput>
                                                        <option value="#loopName2.roleID#">#loopName2.name#</option>
                                                    </cfoutput>
                                                </cfloop>
					                        </select>
				                        </div>
			                        </div>
			                        <div class="form-actions">
				                        <input type="submit" class="btn btn-primary" name="submit" value="Add User">
				                        <a href="employeeDetails.cfm">
                                            <input type="button" class="btn" name="cancel" value="Cancel"/>
                                        </a>
			                        </div>
		                        </fieldset>
	                        </form><!--close of form-->
                	    </div>
                	</div>
                </div>
            </div>
        </div>
    </div>
</div>
<cfif isDefined('form.submit')>
    <cfoutput>#addUserObject.addUser()#</cfoutput><!--calling function to add employee-->
    <cfelse>
        Error
</cfif>
<cfinclude template="layouts/footer.cfm">
