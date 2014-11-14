<!---
            Bug Tracker - Add Employee CFM
            October 30, 2014
            Author: CF Freshers 2014
--->
<cfquery name="bugname" datasource="bugTracking">
    select b.bugName as bugName,bu.userID as userID 
    from bugs b inner join bugUsers bu on  
    b.bugID=#url.bugID# and b.bugID=bu.bugID;
</cfquery>
<cfobject name="addUserObject" component="components.user">
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
                <div class="navbar navbar-inner block-header">
                    <div class="muted pull-left">
                        <cfoutput>
                        <cfif Session.roleID eq 2>
                            <a href="bugProjectDetails.cfm" class="btn btn-default btn-primary" style="display:inline">
                        <cfelseif Session.roleID eq 3 or Session.roleID eq 4>
                            <a href="ownBugs.cfm" class="btn btn-default btn-primary" style="display:inline">
                        </cfif>
                                <i class="icon-arrow-left"></i>&nbsp;Bug Details
                            </a>
                        </cfoutput>
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left"></div>
                    </div><!--- close of navbar navbar-inner block-header --->
                    <div class="block-content collapse in">
                        <div class="span12"><cfoutput>
                    		<form action="editStatusProjectLead.cfm?bugID=#url.bugID#&pid=#url.pid#" id="form_sample_1" class="form-horizontal" method="post" enctype="multipart/form-data">
                                
                    			<fieldset>
                                    <legend>Update status of Bug</legend>
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
					                        <input type="text" name="bugName" data-required="1" class="span6 m-wrap" required disabled value="#bugname.bugName#" />
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group --->			                        
			                        <div class="control-group">
				                        <label class="control-label">Subject</label>
				                        <div class="controls">
					                        <input type="text" name="subject" data-required="1" class="span6 m-wrap" />
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
					                        <input type="file" name="attachment" data-required="1" class="span6 m-wrap" >
				                        </div><!--- close of control-label --->
			                        </div><!--- close of control-group --->			                        
			                        <div class="form-actions">
				                        <input type="submit" class="btn btn-primary" name="submit" value="Update">
				                        <input type="submit" class="btn" name="cancel" value="Cancel">
			                        </div><!--- close of form-actions --->
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
            <cfset check = #addUserObject.fileupload()# />
        </cfoutput>
        <cfif check>
            <cfquery name="getDetails" datasource="bugTracking" result="list"> 
                SELECT u.email as uemail, u.userName as uname,
                p.projectName as pname from users as u 
                inner join projects p on u.userId=#bugname.userID#
                and p.projectID=#url.pid#;
            </cfquery>
            <cfquery name="getcurrent" datasource="bugTracking" result="current"> 
                SELECT  u.userName as username, d.name as dname 
                from users u inner join designations d on 
                userID=#session.userID# and u.designationID=d.designationID; 
            </cfquery>      
            <cfmail from="mynew@domain.com" to="#getDetails.uemail#" subject="New remark" type="html">
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
                            <p>Dear #getDetails.uname#,</p> <br><br>
                            Added a new remark to your bug - "#bugname.bugName#" for the project "#getDetails.pname#"
                            <br> <br>
                            <p>Email sent by </p>               
                            <p>#getcurrent.username#</p>              
                            <p>#getcurrent.dname#</p>              
                        </body>
                     </html>
                </cfmailpart>                     
            </cfmail>                                   
            <cfquery name="getProjectManager" datasource="bugTracking" result="manager"> 
                SELECT u.email as uemail, u.userName as uname,
                p.projectName as pname from users as u 
                inner join projects p on p.projectID=#url.pid#
                and p.userID=u.userID ;
            </cfquery>
            <cfquery name="getcurrent" datasource="bugTracking" result="current"> 
                SELECT  u.userName as username, d.name as dname 
                from users u inner join designations d on 
                userID=#session.userID# and u.designationID=d.designationID; 
            </cfquery>
            <cfmail from="mynew@domain.com" to="#getProjectManager.uemail#" subject="New Remark_projectManager" type="html">
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
                            <p>Dear #getProjectManager.uname#,</p> <br><br>
                            A new remark added to the bug - "#bugname.bugName#" for the project "#getDetails.pname#"
                            <br> <br>
                            <p>Email sent by </p>               
                            <p>#getcurrent.username#</p>              
                            <p>#getcurrent.dname#</p>              
                        </body>
                    </html>
                </cfmailpart>                     
            </cfmail>
        <cfelse>
            <cfoutput>failed</cfoutput>        
        </cfif>
<cfelseif isDefined('form.cancel')>
    <cflocation url="#CGI.HTTP_REFERER#" addToken="false" />
</cfif>
<cfinclude template="layouts/footer.cfm">
