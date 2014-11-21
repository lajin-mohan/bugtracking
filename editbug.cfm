<cfquery name="sample" datasource="#Application.dataSourceName#">
    select b.bugID, b.bugName, b.bugDescription, b.estimatedstartDate, b.actualStartDate, 
    b.estimatedEndDate, b.actualEndDate, b.statusID as sid, b.severityID as seid, 
    b.priorityID as pid, s.name as sname, p.name as pname, se.name as sename, b.projectID as prid, 
    proj.projectName as prname  from bugs as b inner join priorities as p inner join status as s 
    inner join severities as se inner join projects as proj on b.priorityID=p.priorityID and 
    b.projectID=proj.projectID and b.statusID=s.statusID and b.severityID=se.severityID and 
    b.bugID=<cfqueryparam value="#url.bgid#" cfsqltype="cf_sql_tinyint"/> order by b.bugName asc;
</cfquery>
<cfquery name="bugviewmember" datasource="#Application.dataSourceName#">
    select u.userID as uID, u.firstName as uname  from bugUsers as bu 
    inner join users as u  on  bu.bugId=<cfqueryparam value="#url.bgid#" cfsqltype="cf_sql_tinyint"/> and bu.userID=u.userID;
</cfquery>
<cfquery name="bugaddmember" datasource="#Application.dataSourceName#">
    select pu.userID, u.firstName as uname, pu.hide as phide from projectUsers as pu 
    inner join users as u on pu.isLead=0 and pu.projectId=<cfqueryparam value="#url.p#" cfsqltype="cf_sql_tinyint"/> and pu.userID=u.userID;
</cfquery>
<script>
    function checkDate() {
        var EnteredDate = $(".txtdate").val();
        var year = EnteredDate.substring(0, 4);
        var month = EnteredDate.substring(5, 7);
        var date = EnteredDate.substring(8, 10);
        date++;
        /*var myDate = new Date(year, month-1, date);
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
        //alert(myDate);
        //alert(today);
        if (myDate >= today) {
            alert("Estimated end date should be greater than or equal to actual start date");
            return false;
        }
        else {
            alert("Actual start date is less than today's date ");
            return false;
        }
    }
</script>                                 
<cfobject name="addUserObject" component="components.user">
<cfinclude template="layouts/header.cfm" />
<div class="container-fluid">
        <div class="row-fluid">
            <cfset Session.highlight1="inactive"/>
            <cfset Session.highlight2="active"/>
            <cfset Session.highlight3="inactive"/>
            <cfset Session.highlight4="inactive"/>
            <cfset Session.highlight5="inactive"/>
            <cfset Session.highlight6="inactive"/>
            <cfinclude template="layouts/sidebar.cfm"/><!--- including sidebar --->
            <div class="span9" id="content">
                <div class="row-fluid">
                    <div class="navbar navbar-inner block-header">
                    <div class="muted pull-left">
                            <cfoutput>
                        <cfif isdefined('url.bugview')>
                                <a href="bugview.cfm?bid=#url.bgid#" class="btn btn-default btn-primary" style="display:inline">
                                <i class="icon-arrow-left"></i>&nbsp;Bug Profile
                            </a>
                            <cfelse>
                        <a href="bugDetails.cfm?pid=#sample.prid#" class="btn btn-default btn-primary" style="display:inline">
                            <i class="icon-arrow-left"></i>&nbsp;Bug Details
                        </a>
                        </cfif>
                            </cfoutput>
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <cfoutput>
                       <div class="muted pull-left">
                        <h3>Edit Bug Details</h3>
                      </div>
                        </cfoutput>
                        <div class="muted pull-left"></div>
                    </div>
                    <br> <br>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <cfoutput>
                                <form action="editbug.cfm?bgid=#url.bgid#&p=#url.p#" class="form-horizontal" method="post"                                                          onsubmit="return checkDate()">
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
                                            <label class="control-label">Bug Name:</label>
                                            <div class="controls">
                                                <input type="text" name="bname" data-required="1" class="span6 m-wrap"                                                                          value="#sample.bugName#" required/>
                                            </div>
                                        </div>
                                         <div class="control-group">
				                        <label class="control-label">
                                            Project Member Name:
                                        </label>
				                        <div class="controls">
					                        <select class="span6 m-wrap" name="teamMemberID">
                                            <cfset loopName0= #bugaddmember#>
                                                    <option value="0">#bugviewmember.uname#</option>
                                            <cfloop query="loopName0">
                                                <cfoutput>
                                                <cfif (loopname0.uname neq bugviewmember.uname) and (phide eq 0)> 
                                                    <option value="#loopName0.userID#">#loopName0.uname#</option>
                                                </cfif>
                                                </cfoutput>
                                            </cfloop>
					                        </select>
				                        </div>
			                        </div>
                                          <div class="control-group">
                                            <label class="control-label">Bug Description:</label>
                                            <div class="controls">
                                                <input type="text" name="bugdes" data-required="1" class="span6 m-wrap"                                                                                     value="#sample.bugDescription#" required/>
                                            </div>
                                        </div>
                                        
                                           <div class="control-group">
                                            <label class="control-label">Project Name:</label>
                                            <div class="controls">
                                                <input type="text" name="projectname" data-required="1" class="span6 m-wrap"                                                                     disabled  value="#sample.prname#"/>
                                            </div>
                                        </div>
                                             <div class="control-group">
                                            <label class="control-label">Estimated Start Date:</label>
                                            <div class="controls">
                                                <input name="esd" type="date" class="span6 m-wrap" disabled                                                                                                     value="#dateformat(sample.estimatedStartDate)#"/> 
                                            </div>
                                        </div>
                                             <div class="control-group">
                                            <label class="control-label">Actual Start Date:</label>
                                            <div class="controls">
                                                <input name="asd" type="date" class="txtdate span6 m-wrap"                                                                                                      value="#dateformat(sample.actualStartDate)#"/>
                                            </div>
                                        </div>
                                          <div class="control-group">
                                            <label class="control-label">Estimated End Date:</label>
                                            <div class="controls">
                                                <input name="eed" type="date" class="span6 m-wrap" disabled                                                                                                 value="#dateformat(sample.estimatedEndDate)#"/>              									
                                            </div>
                                        </div>
                                        <div class="control-group">
				                        <label class="control-label">
                                            Priority:
                                        </label>
				                        <div class="controls">
					                        <select class="span6 m-wrap" name="priorityID">
                                            <cfset loopName2= #addUserObject.getDesignation("priorities")#>
                                                    <option value="sample.pid">#sample.pname#</option>
                                            <cfloop query="loopName2">
                                                <cfoutput>
                                                <cfif loopName2.priorityID neq sample.pid>
                                                    <option value="#loopName2.priorityID#">#loopName2.name#</option>
                                                </cfif>
                                                </cfoutput>
                                            </cfloop>
					                        </select>
				                        </div>
			                        </div>
                                        <div class="control-group">
				                        <label class="control-label">
                                            Severity:
                                        </label>
				                        <div class="controls">
					                        <select class="span6 m-wrap" name="severityID">
                                            <cfset loopName3= #addUserObject.getDesignation("severities")#>
                                                    <option value="sample.seid">#sample.sename#</option>
                                            <cfloop query="loopName3">
                                                <cfoutput>
                                                <cfif loopName3.severityID neq sample.seid>
                                                    <option value="#loopName3.severityID#">#loopName3.name#</option>
                                                </cfif>
                                                </cfoutput>
                                            </cfloop>
					                        </select>
				                        </div>
			                        </div>
                                      <div class="control-group">
				                        <label class="control-label">
                                            Status:
                                        </label>
				                        <div class="controls">
					                        <select class="span6 m-wrap" name="statusID">
                                            <cfset loopName4= #addUserObject.getDesignation("status")#>
                                                    <option value="sample.sid">#sample.sname#</option>
                                            <cfloop query="loopName4">
                                                <cfoutput>
                                                <cfif loopName4.statusID neq sample.sid>
                                                    <option value="#loopName4.statusID#">#loopName4.name#</option>
                                                </cfif>
                                                </cfoutput>
                                            </cfloop>
					                        </select>
				                        </div>
			                        </div> <br>
                                             <div class="form-actions">
                                            <input  type="submit" class="btn btn-primary" name="save" value="Save" />
                                                 <a href="bugview.cfm?bid=#url.bgid#"><button type="button"                                                                                  class="btn">Cancel</button></a>
                                        </div>
                                          <div class="control-group" style="visibility:hidden">
                                            <label class="control-label">Estimated End Date:</label>
                                            <div class="controls">
                                                <input name="aed" type="text" class=" txtdate2 span6 m-wrap"                                                                                            value="#lsdateformat(sample.estimatedEndDate,'mm/dd/yyyy')#"/>
                                            </div>
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
    <cfoutput>
            <cfset check=#updateObject.bug("#sample.bugID#")#>
    </cfoutput>
    <cfif check> 
        <cfquery name="bugusercheck" datasource="#Application.dataSourceName#" result="checkbuguser">
             select userID from bugUsers where bugID = #sample.bugID#;
        </cfquery>
        <cfif form.teamMemberID eq 0 >
           <cfset teamMemberID = "#bugusercheck.userID#" />
        <cfelse>
             <cfset teamMemberID = "#form.teamMemberID#" />
        </cfif>           

        <cfquery name="getDetails" datasource="bugTracking" result=list> 
            SELECT u.email as uemail, u.firstName as uname,

       
            p.projectName as pname from users as u 
            inner join projects p on u.userId=#teamMemberID#
            and p.projectID=<cfqueryparam value="#url.p#" cfsqltype="cf_sql_tinyint"/>;
        </cfquery>

        <cfquery name="getcurrent" datasource="bugTracking" result=current> 
           SELECT  u.firstName as username, d.name as dname 

           from users u inner join designations d
           on userID=<cfqueryparam value="#session.userID#" cfsqltype="cf_sql_tinyint"/> and u.designationID=d.designationID; 
        </cfquery>
            <cfmail from="#Session.email#" to="#getDetails.uemail#" subject="Add_bug" type="html">
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
                        bug #form.bname#  in your  project #getDetails.pname# edited
                        <br> <br>
                        <p>Email sent by </p>               
                        <p>#getcurrent.firstName#</p>              
                        <p>#getcurrent.dname#</p>              
                    </body>
                </html>
            </cfmailpart>                     
        </cfmail>        

        <cfquery name="getProjectManager" datasource="bugTracking" result=manager> 
            SELECT u.email as uemail, u.firstName as uname,

            p.projectName as pname from users as u 
            inner join projects p on p.projectID=#url.p#
            and p.userID=u.userID ;
        </cfquery>

        <cfquery name="getcurrent" datasource="bugTracking" result=current> 
            SELECT  u.firstName as username, d.name as dname 

            from users u inner join designations d
                on userID=<cfqueryparam value="#session.userID#" cfsqltype="cf_sql_tinyint"/> and u.designationID=d.designationID; 
        </cfquery>
            <cfmail from="#Session.email#" to="#getProjectManager.uemail#" subject="Add_bug_projectManager" type="html">
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
                        A bug - "#form.bname#" has been edited in the project "#getDetails.pname#"
                       <br> <br>
                       <p>Email sent by </p>               
                        <p>#getcurrent.firstName#</p>              
                        <p>#getcurrent.dname#</p>              
                   </body>
               </html>
           </cfmailpart>                     
       </cfmail>
       <cflocation url="bugDetails.cfm?pid=#url.p#" addtoken="false">                                
    </cfif>
</cfif>
<cfinclude template="layouts/footer.cfm" />
                                    
