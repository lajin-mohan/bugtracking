<!---
            Bug Tracker - Index CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfquery name="bugview" datasource="bugTracking">
select b.projectID,b.bugName as bname,b.estimatedStartDate as esd,b.actualStartDate as asd,b.estimatedEndDate as eed,b.actualEndDate as aed,s.name as status,p.name as priority,se.name as severity from bugs b inner join status as s inner join priorities as p inner join  severities as se on b.bugID=#url.bid# and s.statusID=b.statusID and p.priorityID=b.priorityID and se.severityID=b.severityID;
</cfquery>
<cfinclude template="layouts/header.cfm"/><!--- including header --->
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="inactive"/>
        <cfset Session.highlight2="active"/>
        <cfset Session.highlight3="inactive"/>
        <cfset Session.highlight4="inactive"/>
        <cfinclude template="layouts/sidebar.cfm"/><!--- including sidebar --->
        <div class="span9" id="content">
            <div class="row-fluid">
                <div class="navbar navbar-inner block-header">
                     <div class="muted pull-right">
                         <cfif isdefined('url.flag')>
                            <cfoutput><a href="editbug.cfm?bgid=#url.bid#&p=#bugview.projectID#" class="btn btn-default btn-primary" style="display:inline"></cfoutput>
                                <i class="icon-arrow-left"></i>&nbsp;Edit Bug
                            </a>
                            <cfelse>
                                <cfoutput><a href="editbug.cfm?bgid=#url.bid#&p=#bugview.projectID#" class="btn btn-default btn-primary" style="display:inline"></cfoutput>
                                    <i class="icon-plus-sign"></i>&nbsp;Edit Bug
                                </a>
                        </cfif>
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <legend>Bug Profile</legend>
                          <form action=" " class="form-horizontal" method="post">
                                    <fieldset>
                                        <cfoutput>


                                        <div class="control-group">
                                            <label class="control-label">Bug Name:</label>
                                            <div class="controls">
                                                <input type="text" name="bname" data-required="1" class="span6 m-wrap"  disabled value="#bugview.bname#"/>
                                            </div>
                                        </div>
                                        
                                         <div class="control-group">
                                            <label class="control-label">Estimated start Date</label>
                                            <div class="controls">
                                                <input type="text" name="prjname" data-required="1" class="span6 m-wrap"  disabled value="#dateformat(bugview.esd,"yyyy-mm-dd")#"/>
                                            </div>
                                        </div>
                                            
                                            <div class="control-group">
                                            <label class="control-label">Actual start  date</label>
                                            <div class="controls">
                                                <input name="asd" type="text" class="span6 m-wrap" disabled value="#dateformat(bugview.asd,"yyyy-mm-dd")#"/>              									
                                            </div>
                                        </div>
                                            
                                             <div class="control-group">
                                            <label class="control-label">Estimated End Date</label>
                                            <div class="controls">
                                                <input type="text" name="prjname" data-required="1" class="span6 m-wrap"  disabled value="#dateformat(bugview.eed,"yyyy-mm-dd")#"/>
                                            </div>
                                        </div>
                                            
                                            <div class="control-group">
                                            <label class="control-label">Actual End  date</label>
                                            <div class="controls">
                                                <input name="asd" type="text" class="span6 m-wrap" disabled value="#dateformat(bugview.aed,"yyyy-mm-dd")#"/>              									
                                            </div>
                                        </div>
                                             
                                        
                                         <div class="control-group">
                                            <label class="control-label">status</label>
                                            <div class="controls">
                                                <input type="text" name="bugdesc" data-required="1" class="span6 m-wrap"  disabled value="#bugview.status#"/>
                                            </div>
                                        </div>

                                          <div class="control-group">
                                            <label class="control-label">Priority </label>
                                            <div class="controls">
                                                <input name="prjname" type="text" class="span6 m-wrap" required disabled value="#bugview.priority#"/>
                                            </div>
                                        </div>
                                        
                                        
                                        <div class="control-group">
                                            <label class="control-label">Severity</label>
                                            <div class="controls">
                                                <input name="esd" type="text" class="span6 m-wrap" disabled value="#bugview.severity#"/>              									
                                            </div>
                                        </div>
                                             
                                          
                                     </cfoutput>
                                    </fieldset>
                                </form> 
                        </div>
                    </div>
                </div>   
            </div>
        </div>
    </div>
</div>
<cfinclude template="layouts/footer.cfm"/>








