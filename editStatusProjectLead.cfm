<!---
            Bug Tracker - Add Employee CFM
            October 30, 2014
            Author: CF Freshers 2014
--->
 <cfif Session.roleID neq 1>
<cfquery name="bugname" datasource="#Application.dataSourceName#">
    select b.bugName as bugName,bu.userID as userID 
    from bugs b inner join bugUsers bu on  
    b.bugID=<cfqueryparam value="#url.bugID#" cfsqltype="cf_sql_tinyint"/> and b.bugID=bu.bugID;
</cfquery>
     <cfelse>
         <cfquery name="projectname" datasource="#Application.dataSourceName#">
             select projectName,userID from projects where projectID=<cfqueryparam value="#url.pid#" cfsqltype="cf_sql_tinyint"/>
         </cfquery>
</cfif>
<cfobject name="addUserObject" component="components.user">
<cfinclude template="layouts/header.cfm">
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="inactive">
        <cfset Session.highlight2="active">
        <cfset Session.highlight3="inactive">
        <cfset Session.highlight4="inactive">
        <cfset Session.highlight5="inactive">
        <cfset Session.highlight6="inactive">
        <cfinclude template="layouts/sidebar.cfm">
        <div class="span9" id="content">
            <div class="row-fluid">
                <div class="navbar navbar-inner block-header">
                    <div class="muted pull-left">
                        <cfoutput>
                        <cfif Session.roleID eq 2>
                            <a href="bugview.cfm?bid=#url.bugID#" class="btn btn-default btn-primary" style="display:inline">
                                 <i class="icon-arrow-left"></i>&nbsp;Bug Details
                            </a>
                        <cfelseif Session.roleID eq 3 or Session.roleID eq 4>
                            <a href="ownBugs.cfm" class="btn btn-default btn-primary" style="display:inline">
                                 <i class="icon-arrow-left"></i>&nbsp;Bug Details
                            </a>
                                <cfelse>
                                 <a href="projectProfile.cfm?projectID=#url.pid#" class="btn btn-default btn-primary"                                                   style="display:inline"> 
                                      <i class="icon-arrow-left"></i>&nbsp;Project Details
                            </a>
                        </cfif>
                        </cfoutput>
                    </div>
                </div>
                <div class="block">
                     <cfif Session.roleID neq 1>
                    <div class="navbar navbar-inner block-header">
                        <cfoutput>
                       <div class="muted pull-left">
                        <h3>Upadte Bug Status</h3>
                      </div>
                        </cfoutput>
                        <div class="muted pull-left"></div>
                    </div><!--- close of navbar navbar-inner block-header --->
                         <cfelse>
                             <div class="navbar navbar-inner block-header">
                        <cfoutput>
                       <div class="muted pull-left">
                        <h3>Upload Project Attachments</h3>
                      </div>
                        </cfoutput>
                        <div class="muted pull-left"></div>
                    </div><!--- close of navbar navbar-inner block-header ---> 
                    </cfif>
                    <div class="block-content collapse in">
                        <div class="span12"><cfoutput>
                             <cfif Session.roleID neq 1>
                    		<form action="editStatusProjectLead.cfm?bugID=#url.bugID#&pid=#url.pid#" id="form_sample_1"                                                       class="form-horizontal" method="post" enctype="multipart/form-data">
                                <cfelse>
                                    <form action="editStatusProjectLead.cfm?pid=#url.pid#" id="form_sample_1"                                                       class="form-horizontal" method="post" enctype="multipart/form-data">
                                    </cfif>
                                	<fieldset>
			                        <div class="alert alert-error hide">
				                        <button class="close" data-dismiss="alert"></button>
				                        You have some form errors. Please check below.
			                        </div><!--- close of alert alert-error hide --->
			                        <div class="alert alert-success hide">
				                        <button class="close" data-dismiss="alert"></button>
				                        Project status has been sucessfully updated!
			                        </div><!--- close of alert alert-error hide --->
                                      <cfif Session.roleID neq 1>  
			                        <div class="control-group">
				                        <label class="control-label">Bug Name</label>
				                        <div class="controls">
					                        <input type="text" name="bugName" data-required="1" class="span6 m-wrap" required                                                       disabled value="#bugname.bugName#" />
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group --->	
                                          <cfelse>
                                           <div class="control-group">
				                        <label class="control-label">Project Name</label>
				                        <div class="controls">
					                        <input type="text" name="bugName" data-required="1" class="span6 m-wrap" required                                                       disabled value="#projectname.projectName#" />
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group --->	   
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
					                        <textarea type="text" name="remark" data-required="1" class="span6 m-wrap" required>                                               </textarea>
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group --->		
                                    <div class="control-group">
				                        <label class="control-label">Upload attachment</label>
				                        <div class="controls">
					                        <input type="file" name="attachment" data-required="1" class="span6 m-wrap" >
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group --->	
                                       <cfif Session.roleID neq 1> 
                                           <cfoutput>
			                        <div class="form-actions">
				                        <input type="submit" class="btn btn-primary" name="submit" value="Update">
                                        <a href="bugview.cfm?bid=#url.bugID#"> <input type="submit" class="btn" name="cancel"                                                           value="Cancel"></a>
			                        </div><!--- close of form-actions ---> </cfoutput>
                                           <cfelse>
                                                 <cfoutput>
                                             <div class="form-actions">
				                        <input type="submit" class="btn btn-primary" name="submit" value="Update">
                                        <a href="projectProfile.cfm?projectID=#url.pid#"> <input type="submit" class="btn" name="cancel"                                                           value="Cancel"></a>
			                        </div><!--- close of form-actions ---> 
                                               </cfoutput>
                                           </cfif>
		                        </fieldset><!--- close of fieldset --->
                                    </cfoutput>
	                        </form><!--- close of fieldset --->
                	    </div><!--- close of span12 --->
                	</div><!--- close of block-content collapse in --->
                </div><!--- close of block --->
            </div><!--- close of row-fluid --->
        </div><!--- close of span9 --->
    </div><!--- close of row-fluid --->
</div><!--- close of container-fluid --->
<cfif isDefined('form.submit')>
        <cfoutput>
             <cfif Session.roleID neq 1>
            <cfset check = #addUserObject.fileupload()# />
                 <cfelse>
              <cfset check = #addUserObject.fileupload(#projectname.userID#)# />
                 </cfif>
        </cfoutput>
        <cfif check>
 <cfif Session.roleID neq 1>
            <cfquery name="getDetails" datasource="bugTracking" result="list"> 
                SELECT u.email as uemail, u.firstName as fname,p.projectName as pname from users as u 
                inner join projects p on u.userId=#bugname.userID#
                and p.projectID=<cfqueryparam value="#url.pid#" cfsqltype="cf_sql_tinyint"/>		;
            </cfquery>

            <cfquery name="getcurrent" datasource="bugTracking" result="current"> 
                SELECT  u.firstName as fname, d.name as dname from users u inner join designations d on 
                userID=<cfqueryparam value="#session.userID#" cfsqltype="cf_sql_tinyint"/> and u.designationID=d.designationID; 
            </cfquery>      
            <cfmail from="#session.email#" to="#getDetails.uemail#" subject="New remark" type="html">
                <cfmailpart type="html">
                    <html> 
                        <head> 
                            <style type="text/css"> 
                                body { 
                                font-family:sans-serif;
                                font-size:12px;
                                color:black;
                                }
                            </style>
                        </head>
                        <body>
                            <p>Dear #getDetails.fname#,</p> <br><br>
                            Added a new remark to your bug - "#bugname.bugName#" for the project "#getDetails.pname#"
                            <br> <br>
                            <p>Email sent by </p>               
                            <p>#getcurrent.fname#</p>              
                            <p>#getcurrent.dname#</p>              
                        </body>
                     </html>
                </cfmailpart>                     
            </cfmail>    

            <cfquery name="getProjectManager" datasource="bugTracking" result="manager"> 
                SELECT u.email as uemail, u.firstName as fname,

                p.projectName as pname from users as u 
                inner join projects p on p.projectID=#url.pid#
                and p.userID=u.userID ;
            </cfquery>

            <cfquery name="getcurrent" datasource="bugTracking" result="current"> 
                SELECT  u.firstName as fname, d.name as dname 

                from users u inner join designations d on 
                userID=#session.userID# and u.designationID=d.designationID; 
            </cfquery>
            <cfmail from="#session.email#" to="#getProjectManager.uemail#" subject="New Remark_projectManager" type="html">
                <cfmailpart type="html">
                    <html> 
                        <head> 
                            <style type="text/css"> 
                                body { 
                                font-family:sans-serif;
                                font-size:12px;
                                color:black;
                                }
                            </style>
                        </head>
                        <body>
                            <p>Dear #getProjectManager.fname#,</p> <br><br>
                            A new remark added to the bug - "#bugname.bugName#" for the project "#getDetails.pname#"
                            <br> <br>
                            <p>Email sent by </p>               
                            <p>#getcurrent.fname#</p>              
                            <p>#getcurrent.dname#</p>              
                        </body>
                    </html>
                </cfmailpart>                     
            </cfmail>
            
       
            <cfelse>
                <cfquery name="getProjectLead" datasource="bugTracking" result="manager"> 
                    select u.email as uemail, u.firstName as fname, p.projectName as pname
                    from users u inner join projects p inner
                    join projectUsers pu where p.projectID=#url.pid#
                    and pu.userID=u.userID
                    and pu.isLead=1 and p.projectID=pu.projectID;
            </cfquery>

            <cfquery name="getcurrent" datasource="bugTracking" result="current"> 
                SELECT  u.firstName as fname, d.name as dname 
                from users u inner join designations d on 
                userID=#session.userID# and u.designationID=d.designationID; 
            </cfquery>
            <cfmail from="#session.email#" to="#getProjectLead.uemail#" subject="New Remark_projectManager" type="html">
                <cfmailpart type="html">
                    <html> 
                        <head> 
                            <style type="text/css"> 
                                body { 
                                font-family:sans-serif;
                                font-size:12px;
                                color:black;
                                }
                            </style>
                        </head>
                        <body>
                            <p>Dear #getProjectLead.fname#,</p> <br><br>
                            A new attachment added to the project - "#getProjectLead.pname#" 
                            <br> <br>
                            <p>Email sent by </p>               
                            <p>#getcurrent.fname#</p>              
                            <p>#getcurrent.dname#</p>              
                        </body>
                    </html>
                </cfmailpart>                     
            </cfmail>
            
            
            
</cfif>
             
            </cfif>
            </cfif>
<cfinclude template="layouts/footer.cfm">
