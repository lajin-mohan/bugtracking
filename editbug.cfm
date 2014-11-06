
<cfquery name="sample" datasource="bugTracking">
select b.bugID,b.bugName,b.bugDescription,b.estimatedstartDate,b.actualStartDate,b.estimatedEndDate,b.actualEndDate,s.name as sname,p.name as pname,se.name as sename,b.projectID as prid,proj.projectName as prname  from bugs as b inner join priorities as p  inner join status as s inner join severities as se inner join projects as proj on b.priorityID=p.priorityID and b.projectID=proj.projectID and b.statusID=s.statusID and b.severityID=se.severityID and b.bugID=#url.bgid# order by b.bugName asc;
</cfquery>
<cfquery name="bugviewmember" datasource="bugTracking">
select u.userID as uID , u.userName as uname  from bugUsers as bu inner join users as u  on  bu.bugId=#url.bgid# and bu.userID=u.userID;
</cfquery>
 <cfquery name="bugaddmember" datasource="bugTracking">
select pu.userID,u.userName as uname from projectUsers as pu inner join users as u on pu.isLead=0 and pu.projectId=#url.p# and pu.userID=u.userID;
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
        alert(myDate);
        alert(today);
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
            <cfset Session.highlight2="inactive"/>
            <cfset Session.highlight3="active"/>
            <cfset Session.highlight4="inactive"/>
            <cfinclude template="layouts/sidebar.cfm"/><!--- including sidebar --->
            <div class="span9" id="content">
                <div class="row-fluid">
                    <div class="navbar navbar-inner block-header">
                    <div class="muted pull-left"> <cfoutput>
                        <a href="bugDetails.cfm?pid=#sample.prid#" class="btn btn-default btn-primary" style="display:inline">
                            <i class="icon-arrow-left"></i>&nbsp;Bug Details
                            </cfoutput>
                        </a>
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">Update Bug Information</div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <cfoutput>
                                <form action="editbug.cfm?bgid=#url.bgid#&p=#url.p#" class="form-horizontal" method="post" onsubmit="return checkDate()">
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
                                                <input type="text" name="bname" data-required="1" class="span6 m-wrap" value="#sample.bugName#" required/>
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
                                                    <option value="#loopName0.userID#">#loopName0.uname#</option>
                                                </cfoutput>
                                            </cfloop>
					                        </select>
				                        </div>
			                        </div>
                                        
                                          <div class="control-group">
                                            <label class="control-label">Bug Description:</label>
                                            <div class="controls">
                                                <input type="text" name="bugdes" data-required="1" class="span6 m-wrap" value="#sample.bugDescription#" required/>
                                            </div>
                                        </div>
                                        
                                           <div class="control-group">
                                            <label class="control-label">Project Name:</label>
                                            <div class="controls">
                                                <input type="text" name="projectname" data-required="1" class="span6 m-wrap"  disabled value="#sample.prname#"/>
                                            </div>
                                        </div>
                                             <div class="control-group">
                                            <label class="control-label">Estimated Start Date:</label>
                                            <div class="controls">
                                                <input name="esd" type="date" class="span6 m-wrap" disabled value="#dateformat(sample.estimatedStartDate)#"/>              									
                                            </div>
                                        </div>
                                             <div class="control-group">
                                            <label class="control-label">Actual Start Date:</label>
                                            <div class="controls">
                                                <input name="asd" type="date" class="txtdate span6 m-wrap"  value="#lsdateformat(sample.actualStartDate,'mm/dd/yyyy')#"/>              									
                                            </div>
                                        </div>
                                          <div class="control-group">
                                            <label class="control-label">Estimated End Date:</label>
                                            <div class="controls">
                                                <input name="eed" type="date" class="span6 m-wrap" disabled value="#dateformat(sample.estimatedEndDate)#"/>              									
                                            </div>
                                        </div>
                                        <div class="control-group">
				                        <label class="control-label">
                                            Priority:
                                        </label>
				                        <div class="controls">
					                        <select class="span6 m-wrap" name="priorityID">
                                            <cfset loopName2= #addUserObject.getDesignation("priorities")#>
                                                    <option value="0">#sample.pname#</option>
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
                                            Severity:
                                        </label>
				                        <div class="controls">
					                        <select class="span6 m-wrap" name="severityID">
                                            <cfset loopName3= #addUserObject.getDesignation("severities")#>
                                                    <option value="0">#sample.sename#</option>
                                            <cfloop query="loopName3">
                                                <cfoutput>
                                                    <option value="#loopName3.severityID#">#loopName3.name#</option>
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
                                                    <option value="0">#sample.sname#</option>
                                            <cfloop query="loopName4">
                                                <cfoutput>
                                                    <option value="#loopName4.statusID#">#loopName4.name#</option>
                                                </cfoutput>
                                            </cfloop>
					                        </select>
				                        </div>
			                        </div>
                                             <div class="form-actions">
                                            <input  type="submit" class="btn btn-primary" name="save" value="Save" />
                                            <button type="button" class="btn">Cancel</button>
                                        </div>
                                          <div class="control-group" style="visibility:hidden">
                                            <label class="control-label">Estimated End Date:</label>
                                            <div class="controls">
                                                <input name="aed" type="text" class=" txtdate2 span6 m-wrap" value="#lsdateformat(sample.estimatedEndDate,'mm/dd/yyyy')#"/>              									
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
       
    <cfoutput>#updateObject.bug("#sample.bugID#")#</cfoutput>
</cfif>
<cfinclude template="layouts/footer.cfm" />
