<!---
                Bug Tracker - Project Profile CFM
                October 30, 2014
                Author: CF Freshers 2014
    --->

<cfinclude template="layouts/header.cfm" /><!---including header--->
<cfobject name="addUserObject" component="components.user"/>
<script>
    $(document).ready(function () {
        $(function () {
            var progressbar = $("#progressbar-5");
            progressLabel = $(".progress-label");
            $("#progressbar-5").progressbar({
                value: false,
                change: function () {
                    progressLabel.text(
                        progressbar.progressbar("value") + "%");
                },
                complete: function () {
                    progressLabel.text(limit + "%");
                }
            });

            function progress() {
                var val = progressbar.progressbar("value") || 0;
                progressbar.progressbar("value", val + 1);
                if (val < limit - 1) {
                    setTimeout(progress, 30);
                }
            }
            setTimeout(progress, 0);
        });
    });
</script>
<style>
    .ui-widget-header {
        background: #0088CC;
        border: 1px solid #DDDDDD;
        color: #333333;
        font-weight: bold;
    }
    .progress-label {
        position: absolute;
        left: 60%;
        font-weight: bold;
        color: #303030;
    }
</style>
    <div class="container-fluid">
        <div class="row-fluid">
            <cfset Session.highlight1="inactive" />
            <cfset Session.highlight3="inactive" />
            <cfset Session.highlight4="inactive" />
            <cfset Session.highlight5="inactive" />
            <cfinclude template="layouts/sidebar.cfm" /><!--- including sidebar --->
            <div class="span9" id="content">
                <div class="row-fluid">
                    <div class="navbar navbar-inner block-header">
                        <cfoutput>
                            <div class="muted pull-right"></div>
                            <div class="muted pull-left">
                                <cfif isdefined( 'url.flag')>
                                    <a href="projectManagerHistory.cfm"
                                       class="btn btn-default btn-primary"
                                       style="display:inline">
                                        <i class="icon-arrow-left"></i>
                                        &nbsp;Project History
                                    </a>
                                    <cfset Session.highlight2="inactive" />
                                    <cfset Session.highlight6="active" />
                                    <cfelse>
                                        <a href="projectDetails.cfm"
                                           class="btn btn-default btn-primary"
                                           style="display:inline">
                                            <i class="icon-arrow-left"></i>
                                            &nbsp;Project Details
                                        </a>
                                        <cfset Session.highlight2="active" />
                                        <cfset Session.highlight6="inactive" />
                                </cfif>
                            </div>
                            <div class="muted pull-right">
                                 <a href="editStatusProjectLead.cfm?pid=#url.projectID#" 
                                    class="btn btn-default btn-primary" 
                                    style="display:inline">
                                    <i class="icon-plus-sign"></i>&nbsp;Remarks
                               </a>&nbsp; &nbsp;
                                <a href="pmSingleProjectReport.cfm?pid=#url.projectID#"
                                   class="btn btn-default btn-primary"
                                   style="display:inline">
                                    Report
                                </a>&nbsp; &nbsp;
                                <a href="editProject.cfm?projectID=#url.projectID#&flag"
                                   class="btn btn-default btn-primary"
                                   style="display:inline">
                                    <i class="icon-plus-sign"></i>
                                    &nbsp;Edit Project
                                </a>
                            </div>
                        </cfoutput>
                    </div>
                </div>
                <cfquery name="project" datasource="#Application.dataSourceName#">
                    select p.projectName, p.projectDescription, p.estimatedStartDate,
                    p.actualStartDate, p.estimatedEndDate, p.actualEndDate, p.userID,
                    s.name statusName, pr.name priorityname, u.firstName from projects p
                    inner join status s inner join priorities pr inner join users u where p.projectID=
                    <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
                    and p.statusID=s.statusID and p.userID=u.userID and p.priorityID=pr.priorityID
                </cfquery>
                <div class="block">
                        <div class="navbar navbar-inner block-header">
                            <div class="muted pull-left">
                                <h3>Project Profile</h3>
                            </div>
                        </div>
                    <div id="progressbar-5">
                        <div class="progress-label">
                            Loading...
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <fieldset>
                                <cfoutput>
                                    <form action=" " class="form-horizontal" method="post">
                                        <div class="control-group">
                                            <label class="control-label">Name:</label>
                                            <div class="controls">
                                                <input type="text"
                                                       data-required="1"
                                                       class="span6 m-wrap"
                                                       disabled
                                                       value="#project.projectName#"/>
                                            </div>
                                        </div>
                                        <br/>
                                        <div class="control-group">
                                            <label class="control-label">Description:</label>
                                            <div class="controls">
                                                <input type="text"
                                                       class="span6 m-wrap"
                                                       disabled
                                                       value="#project.projectDescription#"/>
                                            </div>
                                        </div>
                                        <br/>
                                        <div class="control-group">
                                            <label class="control-label">Estimated Start Date:</label>
                                            <div class="controls">
                                                <input type="text"
                                                       class="span6 m-wrap"
                                                       disabled
                                                       value="#LSDateformat(project.estimatedStartDate," yyyy-mm-dd ")#"/>
                                            </div>
                                        </div>
                                        <br/>
                                        <div class="control-group">
                                            <label class="control-label">Actual Start Date:</label>
                                            <div class="controls">
                                                <input type="text"
                                                       class="span6 m-wrap"
                                                       value="#LSDateformat(project.actualStartDate," yyyy-mm-dd ")#"
                                                       disabled/>
                                            </div>
                                        </div>
                                        <br/>
                                        <div class="control-group">
                                            <label class="control-label">Estimated End Date:</label>
                                            <div class="controls">
                                                <input type="text"
                                                       class="span6 m-wrap"
                                                       value="#LSDateformat(project.estimatedEndDate," yyyy-mm-dd ")#"
                                                       disabled/>
                                            </div>
                                        </div>
                                        <br/>
                                        <div class="control-group">
                                            <label class="control-label">Actual End Date:</label>
                                            <div class="controls">
                                                <input type="text"
                                                       class="span6 m-wrap"
                                                       value="#LSDateformat(project.actualEndDate," yyyy-mm-dd ")#"
                                                       disabled/>
                                            </div>
                                        </div>
                                        <br/>
                                        <div class="control-group">
                                            <label class="control-label">Status:</label>
                                            <div class="controls">
                                                <input type="text"
                                                       class="span6 m-wrap"
                                                       value="#project.statusName#"
                                                       disabled/>
                                            </div>
                                        </div>
                                        <br/>
                                        <div class="control-group">
                                            <label class="control-label">Priority:</label>
                                            <div class="controls">
                                                <input type="text"
                                                       class="span6 m-wrap"
                                                       value="#project.priorityName#"
                                                       disabled/>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">Project Manager:</label>
                                            <div class="controls">
                                                <input type="text"
                                                       class="span6 m-wrap"
                                                       value="#project.firstName#"
                                                       disabled/>
                                            </div>
                                        </div>
                                    </form>
                                </cfoutput>
                                <cfquery name="pUsers" datasource="#Application.dataSourceName#">
                                    select u.userID, u.firstName, u.lastName, u.employeeID, d.name, pu.hide
                                    from projectUsers pu inner join users u inner join designations d
                                    where pu.userID=u.userID and d.designationID=u.designationID
                                    and pu.projectID=
                                    <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
                                </cfquery>
                                <cfquery name="m1" datasource="#Application.dataSourceName#">
                                    select milestoneStatus from milestones where projectID=
                                    <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
                                    and milestoneStatus="completed" and milestoneHide=0
                                </cfquery>
                                <cfset mcount=0/>
                                <cfoutput query="m1">
                                    <cfset mcount="#mcount+1#"/>
                                </cfoutput>
                                <cfquery name="milestones" datasource="#Application.dataSourceName#">
                                    select * from milestones where projectID=
                                    <cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
                                    and milestoneHide=0 order by milestoneStatus
                                </cfquery>
                                <div class="control-group">
                                    <label class="control-label">
                                        <span class="required"></span>
                                    </label>
                                    <div class="controls">
                                        <table class="table table-bordered">
                                            <tr>
                                                <th><strong>SL Nos</strong></th>
                                                <th><strong>Milestone</strong></th>
                                                <th><strong>Date</strong></th>
                                                <th><strong>Status</strong></th>
                                            </tr>
                                            <cfset mtotal=1/>
                                            <cfif #milestones.projectID# eq #url.projectID#>
                                                <cfoutput query='milestones'>
                                                    <cfset mtotal="#mtotal+1#"/>
                                                    <tr>
                                                        <td>#mtotal-1#</td>
                                                        <td>
                                                            <a href="milestoneHome.cfm? milestoneID=#milestones.milestoneID#&projectID=#url.projectID#">
                                                                #milestones.milestoneName#
                                                            </a>
                                                        </td>
                                                        <td>#dateformat(milestones.milestoneDate)#</td>
                                                        <td>
                                                            <cfif isdefined( 'flag')>
                                                                <a href="milestone.cfm?mID=#milestones.milestoneID#&mstatus=#milestones.milestoneStatus#&projectID=#url.projectID#&removeProjectMember&flag" 
                                                                   class="btn  btn-mini btn-success">
                                                                    <cfif #milestones.milestoneStatus# eq "completed">
                                                                        completed
                                                                        <cfelse>
                                                                            progress
                                                                    </cfif>
                                                                </a>
                                                                <cfelse>
                                                                    <a href="milestone.cfm?mID=#milestones.milestoneID#&mstatus=#milestones.milestoneStatus#&projectID=#url.projectID#"
                                                                       class="btn  btn-mini btn-success">
                                                                        <cfif #milestones.milestoneStatus# eq "progress">
                                                                            progress
                                                                            <cfelse>
                                                                                completed
                                                                        </cfif>
                                                                    </a>
                                                            </cfif> 
                                                        </td>
                                                    </tr>
                                                </cfoutput>
                                                <cfset mtotal="#mtotal-1#"/>
                                            </cfif>
                                        </table>
                                    </div>
                                </div>
                                <cfset mpercent="#(mcount*100)/mtotal#"/>
                                <script>
                                    < cfoutput >
                                        var #toscript(mpercent, "limit")#; < /cfoutput>
                                </script>
                                <div class="control-group">
                                    <label class="control-label">
                                        <span class="required"></span>
                                    </label>
                                    <div class="controls">
                                        <table class="table table-bordered">
                                            <tr>
                                                <th><strong>SL Nos</strong></th>
                                                <th><strong>Employee Name</strong></th>
                                                <th><strong>Employee ID</strong></th>
                                                <th><strong>Designation</strong></th>
                                                <th><strong>Status</strong></th>
                                            </tr>
                                            <cfset etotal=0/>
                                            <cfoutput query='pUsers'>
                                                <tr>
                                                    <cfset etotal="#etotal+1#"/>
                                                    <td>#etotal#</td>
                                                    <td>
                                                        <a href="employeeProfile.cfm?userID=#pUsers.userID#&projectID=#url.projectID#">
                                                            #pUsers.firstName# #pUsers.lastName#
                                                        </a>
                                                    </td>
                                                    <td>#pUsers.employeeID#</td>
                                                    <td>#pUsers.name#</td>
                                                    <td>
                                                        <cfif #pUsers.hide# eq 1>
                                                            Inactive
                                                            <cfelse>
                                                                Active
                                                        </cfif>
                                                    </td>
                                                </tr>
                                            </cfoutput>
                                        </table>
                                    </div>
                                </div> <br> <br>
                                       
                                    <div class="controls"><cfoutput>
                                        <table class="table table-striped">
                                            <tr>
					                            <td><strong>Subject</strong></td>
                                                <td><strong>Description</strong></td>
                                                <td><strong>File Name</strong></td>
                                            </tr>
                                            <cfquery name="attachmentView" datasource="#Application.dataSourceName#" 
                                             result="aCheck">
                                               select r.name as subject, r.description as des,a.fileName as fname
                                               from remarks as r inner join attachments as a on 
                                               r.projectID=<cfqueryparam value="#url.projectID#" cfsqltype="cf_sql_tinyint"/>
                                               and r.remarkID=a.remarkID;                                                                                                 </cfquery>
                                             <cfif aCheck.recordcount>
                                                 <cfloop query="attachmentView">
                                                     <tr>
                                                         <td>#attachmentView.subject#</td>
                                                         <td>#attachmentView.des#</td>
                                                         <td>
                                                             <a href="#expandPath('images/#attachmentView.fname#')#">
                                                                #attachmentView.fname#</a>
                                                         </td>
                                                     </tr>
                                                 </cfloop>
                                            <cfelse>
                                             <tr>
                                            <td></td>
                                            <td>
                                                No attachments or comments available
                                            </td>
                                            <td></td>
                                        </tr>

                                     </cfif></cfoutput>
                                            </div> 
                                            
                                        
                                        
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<cfinclude template="layouts/footer.cfm" />
