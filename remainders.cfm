<!---
            Bug Tracker - Remainders CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfinclude template="layouts/header.cfm" />
<cfobject name="addUserObject" component="components.user">
<cfoutput>
    <div class="container-fluid">
        <div class="row-fluid">
            <cfset Session.highlight1="inactive"/>
            <cfset Session.highlight3="inactive"/>
            <cfset Session.highlight4="active"/>
            <cfset Session.highlight5="inactive"/>
            <cfset Session.highlight2="inactive"/>
            <cfset Session.highlight6="inactive"/>
            <cfinclude template="layouts/sidebar.cfm"/><!--- including sidebar --->
            <div class="span9" id="content">
                <div class="row-fluid">
                    <div class="navbar navbar-inner block-header">
                    <div class="muted pull-left">
                        <a href="calendar.cfm" class="btn btn-default btn-primary" style="display:inline">
                            <i class="icon-arrow-left"></i>&nbsp;Calendar
                        </a>
                    </div>
                    <div class="muted pull-right">
                        <a href="editRemainder.cfm?remainderID=#url.remainderID#" class="btn btn-default btn-primary" style="display:inline">
                            <i class="icon-plus-sign"></i>&nbsp;Edit Remainder
                        </a>&nbsp;
                        <a href="deleteRecord.cfm?remainderID=#url.remainderID#" class="btn btn-default btn-primary" style="display:inline"> 
                            <i class="icon-remove"></i>&nbsp;Delete Remainder
                        </a>
                    </div>
                </div>
                    <cfquery name="remainder" datasource="#Application.dataSourceName#">
                        select * from remainders where remainderID=#url.remainderID#
                    </cfquery>
                    <div class="block">
                        <div class="navbar navbar-inner block-header"></div>
                        <div class="block-content collapse in">
                            <div class="span12">
                                <fieldset>
                                    <legend>Remainder Details</legend>
                                    <div class="control-group">
                                        <label class="control-label">Title:</label>
                                        <div class="controls">
                                            <input type="text" data-required="1" class="span6 m-wrap"  disabled value="#remainder.name#"/>
                                        </div>
                                    </div>
                                    <br/>
                                    <div class="control-group">
                                        <label class="control-label">Description:</label>
                                        <div class="controls">
                                            <input type="text" class="span6 m-wrap" disabled value="#remainder.description#"/>              									
                                        </div>
                                    </div>
                                    <br/>
                                    <div class="control-group">
                                        <label class="control-label">Date:</label>
                                        <div class="controls">
                                            <input type="text" class="span6 m-wrap" required disabled value="#Dateformat(remainder.date)#"/>
                                        </div>
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</cfoutput>
<cfinclude template="layouts/footer.cfm" />
