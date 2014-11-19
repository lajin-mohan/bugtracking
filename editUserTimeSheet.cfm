<!---
            Bug Tracker - Add Employee CFM
            October 30, 2014
            Author: CF Freshers 2014
--->
<cfobject name="obj" component="components.user">
<cfquery name="selectDetails" datasource="bugTracking">
     select timeSheet.dateTime,timeSheet.description,timeSheet.workingHour,bugs.bugName,projects.projectName,status.name,users.userName,bugs.bugID,timeSheet.productiveHours,timeSheet.statusID from timeSheet inner join bugs on timeSheet.bugID=bugs.bugID inner join projects on projects.projectID=bugs.projectID inner join status on timeSheet.statusID=status.statusID inner join users on timeSheet.userID=users.userID and users.userID="#session.userID#" and timeSheet.bugID="#url.bugID#"
</cfquery>
<cfquery name="getbugs" datasource="bugTracking">
     select bugs.bugName,bugs.bugID from bugs inner join bugUsers on bugs.bugID=bugUsers.bugID and bugUsers.userID="#session.userID#" 
</cfquery>
<cfquery name="getStatus" datasource="bugTracking">
    select * from status where statusID=4 or statusID=3 or statusID=5 or statusID=7
</cfquery>
    
<cfobject name="addDetails" component="components.timeSheet">
<cfinclude template="layouts/header.cfm">
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="inactive">
        <cfset Session.highlight2="inactive">
        <cfset Session.highlight3="active">
        <cfset Session.highlight4="inactive">
        <cfset Session.highlight5="inactive">
        <cfset Session.highlight6="inactive">
        <cfinclude template="layouts/sidebar.cfm">
        <div class="span9" id="content">
            <div class="row-fluid">
               
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                       
                    </div><!--- close of navbar navbar-inner block-header --->
                    <div class="block-content collapse in">
                        <div class="span12">
                    		<form action="" id="form_sample_1" class="form-horizontal" method="post">
                    			<fieldset>
                    			    <legend>Time Sheet</legend>
			                        <div class="alert alert-error hide">
				                        <button class="close" data-dismiss="alert"></button>
				                        You have some form errors. Please check below.
			                        </div><!--- close of alert alert-error hide --->
			                        <div class="alert alert-success hide">
				                        <button class="close" data-dismiss="alert"></button>
				                        Employee has been successfully added to the database!
			                        </div><!--- close of alert alert-error hide --->
                                     <div class="control-group">
				                          <label class="control-label">Bug</label>
				                        <div class="controls">
					                       <cfoutput> <input type="textarea" name="description" data-required="1" class="span6 m-wrap" value="#selectDetails.bugName#" disabled></cfoutput>
				                        </div><!--- close of control-label --->
                                        
                              <div class="muted pull-right">         
                                  <a href="http://localhost/bugTracking/timeSheetHistory.cfm" class="btn btn-default btn-primary " style="display:inline">View Time Sheet</a></div></div>
			                       <!--- close of control-group --->
			                        <div class="control-group">
				                        <label class="control-label">Bug Description<span class="required">*</span></label>
				                        <div class="controls">
					                       <cfoutput> <input type="textarea" name="description" data-required="1" class="span6 m-wrap" value="#selectDetails.description#" required></cfoutput>
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group --->
			                        <div class="control-group">
				                        <label class="control-label">Hours Worked<span class="required">*</span></label>
				                    <div class="controls">
                                        <cfoutput><input name="hours" type="text" class="span6 m-wrap" value="#selectDetails.workingHour#" required></cfoutput>
                                           
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group --->
			                         <div class="control-group">
				                     <label class="control-label">Productive Hours<span class="required">*</span></label>
				                        <div class="controls">
					                       
                                            <cfoutput> <input name="productiveHours" type="text" class="span6 m-wrap" value="#selectDetails.productiveHours#" required></cfoutput>
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group ---> 
                                      <div class="control-group">
				                        <label class="control-label">Date<span class="required">*</span></label>
				                        <div class="controls">
					                       
                                            <cfoutput> <input name="editedDate" type="date" class="txtdate span6 m-wrap" value="#DateFormat(selectDetails.dateTime,'dd/mm/yyyy')#" required/></cfoutput>
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group ---> 
				                       <div class="control-group">
				                        <label class="control-label">Status<span class="required">*</span></label>
				                        <div class="controls">
					                       
                                         <select name="status"> 
                                                                                                                                                <cfoutput><option value="#selectDetails.statusID#">#selectDetails.name#</option></cfoutput>
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
                          
			                        </div><!--- close of control-group --->
			                    	                    
			                        <div class="form-actions">
				                        <input type="submit" class="btn btn-primary" name="submit" value="Submit">
				                       
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
   
    <cfoutput>#addDetails.updateUserTimeSheet()#</cfoutput>
            <cflocation url="timeSheetHistory.cfm">
   
</cfif>

<cfinclude template="layouts/footer.cfm">
