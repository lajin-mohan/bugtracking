<!---
            Bug Tracker - Edit Status CFM
            November 5, 2014
            Author: CF Freshers 2014
--->

<cfquery name="getData" datasource="bugTracking">
    select bugName from bugs where bugID=#url.bugID#;
</cfquery>

<cfobject name="addUserObject" component="components.user">
<cfinclude template="layouts/header.cfm">
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="inactive"/>
        <cfset Session.highlight2="active"/>
        <cfset Session.highlight3="inactive"/>
        <cfset Session.highlight4="inactive"/>
        <cfset Session.highlight5="inactive"/>
        <cfset Session.highlight6="inactive"/>
        <cfinclude template="layouts/sidebar.cfm">
        <div class="span9" id="content">
            <div class="row-fluid">
                <div class="navbar navbar-inner block-header">
                    <div class="muted pull-left">
                        <cfoutput>
                            <a href="ownBugs.cfm" class="btn btn-default btn-primary" style="display:inline">
                                <i class="icon-arrow-left"></i>&nbsp;Back
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
                        <cfoutput>
                    		<form action="editStatus.cfm?bugID=#url.bugID#" id="form_sample_1" class="form-horizontal" method="post" enctype="multipart/form-data">
                        </cfoutput>
                    			<fieldset>
                                    <legend>Update status of project</legend>
			                        <div class="alert alert-error hide">
				                        <button class="close" data-dismiss="alert"></button>
				                        You have some form errors. Please check below.
			                        </div><!--- close of alert alert-error hide --->
			                        <div class="alert alert-success hide">
				                        <button class="close" data-dismiss="alert"></button>
				                        Project status has been sucessfully updated!
			                        </div><!--- close of alert alert-error hide --->
			                        <div class="control-group">
				                        <label class="control-label">Bug Name</label>
				                        <div class="controls">
					             <cfoutput>           <input type="text" name="bugName" data-required="1" class="span6 m-wrap" value="#getData.bugName#" required disabled />   </cfoutput>
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group --->	

                                    <cfif Session.roleID neq 1 or Session.roleID neq 2> 
                                    <cfif Session.roleID eq 3>     		                        
			                        <div class="control-group">
				                        <label class="control-label">Status<span class="required">*</span></label>
				                        <div class="controls">
					                        <select class="span6 m-wrap" name="status">
                                            <cfset loopName1= #addUserObject.getDesignation("status")#>
                                            <cfloop query="loopName1">
                                                <cfoutput>
                                                <cfif loopName1.name eq "testing" or loopName1.name eq "pending" or loopName1.name eq "ongoing">
                                                    <option value="#loopName1.statusID#">#loopName1.name#</option>
                                                </cfif>
                                                </cfoutput>
                                            </cfloop>
					                        </select>
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group --->	               

                                    <cfelseif Session.roleID eq 4>    		                        
			                        <div class="control-group">
				                        <label class="control-label">Status<span class="required">*</span></label>
				                        <div class="controls">
					                        <select class="span6 m-wrap" name="status">
                                            <cfset loopName1= #addUserObject.getDesignation("status")#>
                                            <cfloop query="loopName1">
                                                <cfoutput>
                                                <cfif loopName1.name eq "testing" or loopName1.name eq "resolved" or loopName1.name eq "unresolved">
                                                    <option value="#loopName1.statusID#">#loopName1.name#</option>
                                                </cfif>
                                                </cfoutput>
                                            </cfloop>
					                        </select>
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group --->	
                                    </cfif>
                                    </cfif>
			                        
                                    <div class="control-group">
				                        <label class="control-label">Subject</label>
				                        <div class="controls">
					                        <input type="text" name="subject" data-required="1" class="span6 m-wrap" required />
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group --->	
                                    <div class="control-group">
				                        <label class="control-label">Leave a remark</label>
				                        <div class="controls">
					                        <textarea type="text" name="remark" data-required="1" class="span6 m-wrap"></textarea>
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group --->		
                                    <div class="control-group">
				                        <label class="control-label">Upload attachment</label>
				                        <div class="controls">
					                        <input type="file" name="attachment" data-required="1" class="span6 m-wrap"/>
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group --->			                        
			                        <div class="form-actions">
				                        <input type="submit" class="btn btn-primary" name="submit" value="Update">
				                        <input type="submit" class="btn" name="cancel" value="Cancel">
			                        </div><!--- close of form-actions --->
		                        </fieldset><!--- close of fieldset --->
	                        </form><!--- close of fieldset --->
                	    </div><!--- close of span12 --->
                	</div><!--- close of block-content collapse in --->
                </div><!--- close of block --->
            </div><!--- close of row-fluid --->
        </div><!--- close of span9 --->
    </div><!--- close of row-fluid --->
</div><!--- close of container-fluid --->
<cfif isDefined('form.submit')>
    <cfoutput>#addUserObject.fileupload()#</cfoutput>
</cfif>
<cfinclude template="layouts/footer.cfm">
