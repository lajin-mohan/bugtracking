<cfquery name="sample" datasource="bugTracking">
select b.bugID,b.bugName,b.bugDescription,b.estimatedstartDate,b.actualStartDate,b.estimatedEndDate,b.actualEndDate,s.name as sname,p.name as pname,se.name as sename,b.projectID as prid, proj.projectName as prname from bugs as b inner join priorities as p inner join status as s  inner join projects as proj inner join severities as se  on b.priorityID=p.priorityID and  b.statusID=s.statusID and b.projectID=proj.projectID and b.severityID=se.severityID and b.bugID=#url.bid#  order by b.bugName desc;
</cfquery>
<cfquery name="bugviewmember" datasource="bugTracking">
select u.userID as uID , u.userName as uname  from bugUsers as bu inner join users as u  on  bu.bugId=#url.bid# and bu.userID=u.userID;
</cfquery>

<cfinclude template="layouts/header.cfm" />
<cfobject name="addUserObject" component="components.user">
<cfoutput>
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
                    <div class="muted pull-left">
                      
                        <a href="bugDetails.cfm?pid=#sample.prid#" class="btn btn-default btn-primary" style="display:inline">
                            <i class="icon-arrow-left"></i>&nbsp;Bug Details
                        </a>
                    </div>
                </div>
                    <div class="block">
                        <div class="navbar navbar-inner block-header">
                            <div class="muted pull-left"></div>
                        </div>
                        <div class="block-content collapse in">
                            <div class="span12">
                                <form action=" " class="form-horizontal" method="post">
                                    <fieldset>
                                        <legend>Bug Details</legend>
                                        <div class="alert alert-error hide">
                                            <button class="close" data-dismiss="alert"></button>
                                                You have some form errors. Please check below.
                                        </div>
                                        <div class="alert alert-success hide">
                                            <button class="close" data-dismiss="alert"></button>
                                                Employee has been successfully added to the database!
                                        </div>


                                        <div class="control-group">
                                            <label class="control-label">Bug Name :</label>
                                            <div class="controls">
                                                <input type="text" name="bname" data-required="1" class="span6 m-wrap"  disabled value="#sample.bugName#"/>
                                            </div>
                                        </div>
                                        
                                         <div class="control-group">
                                            <label class="control-label">Project Member Name :</label>
                                            <div class="controls">
                                                <input type="text" name="prjname" data-required="1" class="span6 m-wrap"  disabled value="#bugviewmember.uname#"/>
                                            </div>
                                        </div>
                                        
                                         <div class="control-group">
                                            <label class="control-label">Bug Description :</label>
                                            <div class="controls">
                                                <input type="text" name="bugdesc" data-required="1" class="span6 m-wrap"  disabled value="#sample.bugDescription#"/>
                                            </div>
                                        </div>

                                          <div class="control-group">
                                            <label class="control-label">Project Name </label>
                                            <div class="controls">
                                                <input name="prjname" type="text" class="span6 m-wrap" required disabled value="#sample.prname#"/>
                                            </div>
                                        </div>
                                        
                                        
                                        <div class="control-group">
                                            <label class="control-label">Estimated Start Date :</label>
                                            <div class="controls">
                                                <input name="esd" type="text" class="span6 m-wrap" disabled value="#lsdateformat(sample.estimatedStartDate)#"/>              									
                                            </div>
                                        </div>
                                             <div class="control-group">
                                            <label class="control-label">Actual Start Date :</label>
                                            <div class="controls">
                                                <input name="asd" type="text" class="span6 m-wrap" disabled value="#lsdateformat(sample.actualStartDate)#"/>
                                            </div>
                                        </div>
                                             <div class="control-group">
                                            <label class="control-label">Estimated End Date :</label>
                                            <div class="controls">
                                                <input name="eed" type="text" class="span6 m-wrap" disabled value="#lsdateformat(sample.estimatedEndDate)#"/>              									
                                            </div>
                                        </div>
                                             <div class="control-group">
                                            <label class="control-label">Actual End Date :</label>
                                            <div class="controls">
                                                <input name="aed" type="text" class="span6 m-wrap" disabled value="#lsdateformat(sample.actualEndDate)#"/>              									
                                            </div>
                                        </div>
                                            
                                        <div class="control-group">
                                            <label class="control-label">Status </label>
                                            <div class="controls">
                                                <input name="status" type="text" class="span6 m-wrap" required disabled value="#sample.sname#"/>
                                            </div>
                                        </div>
                                        
                                         <div class="control-group">
                                            <label class="control-label">Priority </label>
                                            <div class="controls">
                                                <input name="severity" type="text" class="span6 m-wrap" required disabled value="#sample.pname#"/>
                                            </div>
                                        </div>
                                         <div class="control-group">
                                            <label class="control-label">Severity </label>
                                            <div class="controls">
                                                <input name="severity" type="text" class="span6 m-wrap" required disabled value="#sample.sename#"/>
                                            </div>
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
</cfoutput>
<cfif isDefined('form.save')>
    <cfobject name="updateObject" component="components.user">
    <cfoutput>#updateObject.updateProfile()#</cfoutput>
</cfif>
<cfinclude template="layouts/footer.cfm" />