<!---
            Bug Tracker - Edit Remainder CFM
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
                    </div>
                    <cfquery name="remainder" datasource="#Application.dataSourceName#">
                        select * from remainders where remainderID=#url.remainderID#
                    </cfquery>
                    <div class="block">
                        <div class="navbar navbar-inner block-header"></div>
                        <div class="block-content collapse in">
                            <div class="span12">
                                <form method="post" action="">
                                    <fieldset>
                                        <legend>Remainder Details</legend>
                                        <div class="control-group">
                                            <label class="control-label">Name:</label>
                                            <div class="controls">
                                                <input name="name" type="text" data-required="1" class="span6 m-wrap"  value="#remainder.name#"/>
                                            </div>
                                        </div>
                                        <br/>
                                        <div class="control-group">
                                            <label class="control-label">Description:</label>
                                            <div class="controls">
                                                <input name="description" type="text" class="span6 m-wrap" value="#remainder.description#"/>              									
                                            </div>
                                        </div>
                                        <br/>
                                        <div class="control-group">
                                            <label class="control-label">Date:</label>
                                            <div class="controls">
                                                <input name="date" type="date" class="span6 m-wrap" required value="#Dateformat(remainder.date,'yyyy-mm-dd')#"/>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <button type="submit" class="btn btn-primary" name="submit">Edit Details</button>
                                            <a href="remainders.cfm?remainderID=#url.remainderID#"><button type="button" class="btn">Cancel</button></a>
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
    <cfif structkeyexists(form,'submit')>
        <cfset remainderDate=#dateformat(form.date,'yyyy-mm-dd')#/>
        <cfquery name="remainderEdit" datasource="#Application.dataSourceName#">
            update remainders set name='#form.name#', description='#form.description#',
            date='#form.date#' where remainderID=#url.remainderID#
        </cfquery>
        <cflocation url="remainders.cfm?remainderID=#url.remainderID#" addtoken="false"/>
    </cfif>
</cfoutput>
<cfinclude template="layouts/footer.cfm" />