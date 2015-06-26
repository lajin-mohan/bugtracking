<!---
            Bug Tracker - Project Details View CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfquery name="projview" datasource="#Application.dataSourceName#">
    select p.projectName as pname, p.projectDescription as pdes, 
    p.estimatedStartDate as esd,p.actualStartDate as asd,
    p.estimatedEndDate as eed,p.actualEndDate as aed,
    s.name as status,prior.name as priority from projects as p
    inner join status as s inner join priorities as prior on p.projectID=
    <cfqueryparam value="#url.pid#" cfsqltype="cf_sql_tinyint"/>
    and s.statusID=p.statusID and prior.priorityID=p.priorityID
</cfquery>
<cfinclude template="layouts/header.cfm"/><!--- including header --->
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
                            <a href="#listlast(cgi.http_referer,"/")#"
                               class="btn btn-default btn-primary"
                               style="display:inline">
                                <i class="icon-arrow-left"></i>&nbsp;Back
                            </a> 
                        </cfoutput>
                    </div>
                </div> 
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <cfoutput>
                            <div class="muted pull-left">
                                <h3><b>Project Profile </b> - #projview.pname#</h3>
                            </div>
                        </cfoutput>
                    </div> <br> <br>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <form action=" " class="form-horizontal" method="post">
                                <fieldset>
                                  
                                    <cfoutput>
                                        <div class="control-group">
                                            <label class="control-label">Project Name:</label>
                                            <div class="controls">
                                                <input type="text"
                                                       name="pname"
                                                       data-required="1"
                                                       class="span6 m-wrap"
                                                       disabled value="#projview.pname#"/>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">Estimated start Date:</label>
                                            <div class="controls">
                                                <input type="text"
                                                       name="prjname"
                                                       data-required="1"
                                                       class="span6 m-wrap"
                                                       disabled value="#dateformat(projview.esd)#"/>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">Actual start Date:</label>
                                            <div class="controls">
                                                <input name="asd"
                                                       type="text"
                                                       class="span6 m-wrap"
                                                       disabled
                                                       value="#dateformat(projview.asd)#"/>					
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">
                                                Estimated End Date:
                                            </label>
                                            <div class="controls">
                                                <input type="text"
                                                       name="prjname"
                                                       data-required="1"
                                                       class="span6 m-wrap"
                                                       disabled
                                                       value="#dateformat(projview.eed)#"/>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">
                                                Actual End Date:
                                            </label>
                                            <div class="controls">
                                                <input name="asd"
                                                       type="text"
                                                       class="span6 m-wrap"
                                                       disabled
                                                       value="#dateformat(projview.aed)#"/>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">
                                                Status:
                                            </label>
                                            <div class="controls">
                                                <input type="text"
                                                       name="bugdesc"
                                                       data-required="1"
                                                       class="span6 m-wrap"
                                                       disabled
                                                       value="#projview.status#"/>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">
                                                Priority
                                            </label>
                                            <div class="controls">
                                                <input name="prjname"
                                                       type="text"
                                                       class="span6 m-wrap"
                                                       required disabled
                                                       value="#projview.priority#"/>
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
<cfinclude template="layouts/footer.cfm"/><!---including footer--->
