<!---
            Bug Tracker - Add Employee CFM
            October 30, 2014
            Author: CF Freshers 2014
--->
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
                       
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                    		<form action="plTimeSheet.cfm" class="form-horizontal" method="post">
                    			<fieldset>
                    			    <legend>Time Sheet
                                        <div class="muted pull-right">         
                                            <a href="plTimeSheetHistory.cfm"
                                               class="btn btn-default btn-primary"
                                               style="display:inline">
                                                <i class="icon-eye-open"></i>&nbsp;View
                                            </a>
			                            </div>
                                    </legend>
			                        <div class="alert alert-error hide">
				                        <button class="close" data-dismiss="alert"></button>
				                        You have some form errors. Please check below.
			                        </div>
			                        <div class="alert alert-success hide">
				                        <button class="close" data-dismiss="alert"></button>
				                        Employee has been successfully added to the database!
			                        </div>
                                        <div class="control-group">
                                            <label class="control-label">Project
                                                <span class="required">*</span></label>
				                         <div class="controls">

                                         <select name="project"> 
                                            <cfquery name="selectProject"
                                            datasource="#Application.dataSourceName#">
                                            select projects.projectName,projects.projectID from                                                                           projects inner join projectUsers 
                                            on projectUsers.projectID=projects.projectID and                                                                             projectUsers.userID="#session.userID#" and                                                                                   projectUsers.hide=0;
                                             </cfquery>
                                             <option value="0">Select</option>
                                             <cfloop query="selectProject">
                                             <cfoutput>
                                                 <option value="#projectID#">#projectName#</option>                                                                         </cfoutput>
                                             </cfloop>
                                             </select>
                                             <span style="display:none;color:red"                                                                   class="sp">Required</span>
                                   </div>
                                </div>
                                    <div class="control-group">
                                    <label class="control-label">Bug</label>
				                     <div class="controls">
                                         <select name="bug"> 
                                            <cfinvoke component="components.timeSheet"                                                                                   method="selectUserBugs" 
                                            returnVariable="getdetails"></cfinvoke>
                                             <option value="0">Select</option>
                                             <cfloop query="getbug">
                                             <cfoutput><option value="#bugID#">#bugName#</option>                                                                          </cfoutput>
                                             </cfloop>
                                             </select>
                                             <span style="display:none;color:red"
                                                   class="sp">Required</span>
                                    </div>
                                </div>
			                    <div class="control-group">
				                        <label class="control-label">Description
                                            <span class="required">*</span>
                                        </label>
				                        <div class="controls">
					                        <input type="textarea" name="description" 
                                                   data-required="1" class="span6 m-wrap" required>
				                        </div>
			                    </div>
			                    <div class="control-group">
				                        <label class="control-label">Hours Worked
                                            <span class="required">*</span></label>
				                        <div class="controls">
					                        <input name="hours" type="number" 
                                                   class="span6 m-wrap" required>
                                        </div>
			                     </div>
			                     <div class="control-group">
				                        <label class="control-label">Productive Hours
                                            <span class="required">*</span>
                                        </label>
				                        <div class="controls">
				                            <input name="productiveHours" type="number" 
                                            class="span6 m-wrap" required>
				                        </div>
			                     </div>
                                 <div class="control-group">
				                        <label class="control-label">Date
                                            <span class="required">*</span>
                                        </label>
				                        <div class="controls">
					                         <input name="editedDate" type="date" 
                                             class="txtdate span6 m-wrap" required/>
				                        </div>
			                        </div>
                                    <div class="control-group">
				                        <label class="control-label">Status
                                            <span class="required">*</span>
                                        </label>
				                        <div class="controls">
					                       <select name="status"> 
                                             <option value="0">Status</option>
                                             <option value="4">Ongoing</option>
                                             <option value="3">Pending</option>
                                             <option value="5">Testing</option>
                                             <option value="7">Completed</option>
                                           </select>
                                           <span style="display:none;color:red" 
                                                    class="sp">Required
                                           </span>
                                           </div>
                                     </div>
			                    	 <div class="form-actions">
				                        <input type="submit" class="btn btn-primary" 
                                               name="submit" value="Submit">
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
    <cfif #form.project# neq 0 and #form.status# neq 0>
        <cfif #form.bug# neq 0>
            <cfquery name="addTimeSheet" datasource="#Application.dataSourceName#">
                insert into timeSheet (description,workingHour,dateTime,userID,
                productiveHours,statusID,projectID,bugID) values                                                                             ('#form.description#',#form.hours#,'#DateFormat(form.editedDate,'yyyy/mm/dd')#',
                #session.userID#,#form.productiveHours#,'#form.status#',
                '#form.project#','#form.bug#')
            </cfquery>
            <cflocation url="plTimeSheetHistory.cfm">
   <cfelse>
       <cfquery name="addTimeSheet" datasource="#Application.dataSourceName#">
           insert into timeSheet (description,workingHour,dateTime,userID,
           productiveHours,statusID,projectID) values                                                                                    ('#form.description#',#form.hours#,'#DateFormat(form.editedDate,'yyyy/mm/dd')#',
           #session.userID#,#form.productiveHours#,'#form.status#','#form.project#')
       </cfquery>
       <cflocation url="plTimeSheetHistory.cfm">  
    </cfif>
 <cfelse>
      <script>
          $(document).ready(function(){
          $(".sp").css('display','inline');
          });
      </script>
       </cfif>
    </cfif>
<cfinclude template="layouts/footer.cfm">
