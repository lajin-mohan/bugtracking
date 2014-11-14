<!---
            Bug Tracker - Project Details CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<script>
    function checkDate() {
        var EnteredDate = $(".txtdate").val();
        var year = EnteredDate.substring(0, 4);
        var month = EnteredDate.substring(5, 7);
        var date = EnteredDate.substring(8, 10);
        date++;
        var myDate = new Date(year, month-1, date);
        var EnteredDate2 = $(".txtdate2").val();
        var year2 = EnteredDate2.substring(0, 4);
        var month2 = EnteredDate2.substring(5, 7);
        var date2 = EnteredDate2.substring(8, 10);
        var myDate2 = new Date(year2, month2-1, date2);
        /*var EnteredDate = $("#txtdate").val();
        var year = EnteredDate.substring(0, 4);
        var month = EnteredDate.substring(5, 7);
        var date = EnteredDate.substring(8, 10)+1;
        var myDate = new Date(year, month-1, date);*/
        var today = new Date();
        alert(myDate);
        alert(today);
        if (myDate2 >= myDate) {
            return true;
        }
        else {
            alert("Estimated end date should be greater than or equal to estimated start date");
            return false;
        }
    }
</script>     
<cfobject name="addUserObject" component="components.user">
<cfinclude template="layouts/header.cfm"><!--- including header --->
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="inactive">
        <cfset Session.highlight2="active">
        <cfset Session.highlight3="inactive">
        <cfset Session.highlight4="inactive">
        <cfset Session.highlight5="inactive">
        <cfset Session.highlight6="inactive">
        <cfinclude template="layouts/sidebar.cfm"><!--- including sidebar --->
        <div class="span9" id="content">
            <div class="row-fluid">
                <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">
                            <cfoutput>
                                <a href="bugDetails.cfm?pid=#url.p#" class="btn btn-default btn-primary" style="display:inline">
                                    <i class="icon-arrow-left"></i>&nbsp;Bug Details
                                </a>
                            </cfoutput>
                        </div>
                    </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header"></div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <form action=" " method="post" class="form-horizontal" onsubmit="return checkDate()">
                                <fieldset>
                                     
                                    
                                    <legend>Bug Details</legend>
                                    <div class="alert alert-error hide">
                                        <button class="close" data-dismiss="alert"></button>
                                        You have some form errors. Please check below.
                                    </div>
                                    <div class="alert alert-success hide">
                                        <button class="close" data-dismiss="alert"></button>
                                        Buga has been successfully added to the database!
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">
                                            Bug Name
                                            <span class="required">*</span>
                                        </label>
                                        <div class="controls">
                                            <input type="text" name="bugName" data-required="1" class="span6 m-wrap" required/>
                                        </div>
                                    </div>
                                    
                                    <cfquery name="bugaddmember" datasource="bugTracking">
select pu.userID,u.userName as uname  from projectUsers as pu inner join users as u  on pu.isLead=0 and pu.projectId=#url.p# and pu.userID=u.userID;
                                </cfquery>
                                    
                                    
                                    
                                     <div class="control-group">
				                        <label class="control-label">
                                            Team Member
                                          <span class="required">*</span>  
                                        </label>
				                        <div class="controls">
					                        <select class="span6 m-wrap" name="teamMemberID">
                                            <cfset loopName0= #bugaddmember#>
                                                    <option value="">Select Member .....</option>
                                            <cfloop query="loopName0">
                                                <cfoutput>
                                                    <option value="#loopName0.userID#">#loopName0.uname#</option>
                                                </cfoutput>
                                            </cfloop>
					                        </select>
				                        </div>
			                        </div>
                                    
                                    
                                    <div class="control-group">
                                        <label class="control-label">
                                            Bug Description
                                            <span class="required">*</span>
                                        </label>
                                        <div class="controls">
                                            <input type="text" name="bugDescription" data-required="1" class="span6 m-wrap" required/>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">
                                            Estimated Start Date
                                            <span class="required">*</span>
                                        </label>
                                        <div class="controls">
                                            <input name="estimatedStartDate" type="date" class="txtdate span6 m-wrap" required/>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">
                                            Estimated End Date
                                            <span class="required">*</span>
                                        </label>
                                        <div class="controls">
                                            <input name="estimatedEndDate" type="date" class="txtdate2 span6 m-wrap" required/>
                                        </div>
                                    </div>
                                    
                                   
                                    <div class="control-group">
                                        <label class="control-label">
                                            Bug Status
                                            <span class="required"></span>
                                        </label>
                                        <div class="controls">
                                            <input type="text" value="Pending" class="span6 m-wrap" disabled/>
                                        </div>
                                    </div>
                                    <div class="control-group">
				                        <label class="control-label">
                                            Priority
                                            <span class="required">*</span>
                                        </label>
				                        <div class="controls">
					                        <select class="span6 m-wrap" name="priorityID">
                                            <cfset loopName2= #addUserObject.getDesignation("priorities")#>
                                                    <option value="">Select.....</option>
                                            <cfloop query="loopName2">
                                                <cfoutput>
                                                    <option value="#loopName2.priorityID#">#loopName2.name#</option>
                                                </cfoutput>
                                            </cfloop>
					                        </select>
				                        </div>
			                        </div>
                                        <div class="control-group">
				                        <label class="control-label">
                                            Severity
                                            <span class="required">*</span>
                                        </label>
				                        <div class="controls">
					                        <select class="span6 m-wrap" name="severityID">
                                            <cfset loopName3= #addUserObject.getDesignation("severities")#>
                                                    <option value="">Select.....</option>
                                            <cfloop query="loopName3">
                                                <cfoutput>
                                                    <option value="#loopName3.severityID#">#loopName3.name#</option>
                                                </cfoutput>
                                            </cfloop>
					                        </select>
				                        </div>
			                        </div>
                                    <div class="form-actions">
                                        <button type="submit" class="btn btn-primary" name="submit">Add Bug</button>
                                        <button type="button" class="btn">Cancel</button>
                                    </div>
                                </fieldset>
                            </form>
                            <cfif structkeyexists(form,"submit")>
                                  <cfquery name="Bug" datasource="bugTracking" result="insertbug">
                                            insert into bugs(bugName, bugDescription, estimatedStartDate, 
                                            estimatedEndDate,statusID, 
                                            priorityID , severityID ,projectID) values(
                                            <cfqueryparam value="#form.bugName#" cfsqltype="cf_sql_varchar"/>,
                                            <cfqueryparam value="#form.bugDescription#" cfsqltype="cf_sql_varchar"/>,
                                            <cfqueryparam value="#form.estimatedStartDate#" cfsqltype="cf_sql_date"/>,
                                            <cfqueryparam value="#form.estimatedEndDate#" cfsqltype="cf_sql_date"/>,
                                            <cfqueryparam value="3" cfsqltype="cf_sql_tinyint"/>,
                                            <cfqueryparam value="#form.priorityID#" cfsqltype="cf_sql_tinyint"/>,
                                            <cfqueryparam value="#form.severityID#" cfsqltype="cf_sql_tinyint"/>,
                                            <cfqueryparam value="#LSParseNumber(url.p)#" cfsqltype="cf_sql_tinyint"/>,
                                            <cfqueryparam value="#Session.userID#" cfsqltype="cf_sql_tinyint"/>);
                                        </cfquery>
                                
                                     <cfquery name="getbugID" datasource="bugTracking">
                                    select bugID from bugs where bugName="#form.bugName#";
                                </cfquery>
                                  <cfquery name="insertbuguser" datasource="bugTracking" result="insertbuser">
                                   insert into bugUsers(bugID,userID) values (
                                      <cfqueryparam value="#getbugID.bugID#" cfsqltype="cf_sql_tinyint"/>,
                                      <cfqueryparam value="#form.teamMemberID#" cfsqltype="cf_sql_tinyint"/> );
                                </cfquery>
                                <cfif insertbug.recordcount eq 1 and insertbuser.recordcount eq 1 >
                                    <cfquery name="getDetails" datasource="bugTracking" result=list>
                                        SELECT u.email as uemail,
                                        u.userName as uname,
                                        p.projectName as pname 
                                        from users as u 
                                        inner join projects p
                                        on u.userId=#form.teamMemberID#
                                        and p.projectID=#url.p#;
                                    </cfquery>
                                    <cfquery name="getcurrent" datasource="bugTracking" result=current> 
                                        SELECT  u.userName as username,
                                        d.name as dname from users u
                                        inner join designations d
                                        on userID=#session.userID# and u.designationID=d.designationID; 
                                    </cfquery>
                                    <cfmail from="mynew@domain.com" to="#getDetails.uemail#" subject="Add_bug" type="html">
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
                                                        Added a new bug #form.bugName#    to your project #getDetails.pname#
                                                      <br> <br>
                                                    <p>Email sent by </p>               
                                                    <p>#getcurrent.username#</p>              
                                                    <p>#getcurrent.dname#</p>              
                                                </body>
                                            </html>
                                        </cfmailpart>                     
                                    </cfmail>                                 
                                    <cfquery name="getProjectManager" datasource="bugTracking" result=manager> 
                                        SELECT u.email as uemail,
                                        u.userName as uname,
                                        p.projectName as pname 
                                        from users as u 
                                        inner join projects p on    
                                        p.projectID=#url.p# and
                                        p.userID=u.userID ;
                                    </cfquery>
                                    <cfquery name="getcurrent" datasource="bugTracking" result=current> 
                                        SELECT  u.userName as username, d.name as dname 
                                        from users u inner join designations d on 
                                        userID=#session.userID# and u.designationID=d.designationID; 
                                    </cfquery>
                                    <cfmail from="mynew@domain.com" to="#getProjectManager.uemail#" subject="Add_bug_projectManager" type="html">
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
                                                        A new bug #form.bugName#   added to the project #getDetails.pname#
                                                        <br> <br>
                                                    <p>Email sent by </p>               
                                                    <p>#getcurrent.username#</p>              
                                                    <p>#getcurrent.dname#</p>              
                                                </body>
                                            </html>
                                    </cfmailpart>                     
                                 </cfmail>
  
                                 <cflocation url="bugDetails.cfm?pid=#url.p#" addtoken="false"/>
                                 </cfif>        
                            </cfif>
                        </div>
                    </div>
                </div>
            </div><!--- close of row-fluid --->
        </div><!--- close of span9 --->
    </div><!--- close of row-fluid --->
</div><!--- close of container-fluid --->
<cfinclude template="layouts/footer.cfm"><!--- including footer --->
