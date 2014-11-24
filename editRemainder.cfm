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
                        select * from remainders where 
                        remainderID = <cfqueryparam value="#url.remainderID#" CFSQLType="CF_SQL_TINYINT">;
                    </cfquery>
                    <div class="block">
                        <div class="navbar navbar-inner block-header">
                            <div class="muted pull-left">
                                <h3>Remainder Details</h3>
                            </div>
                        </div>
                        <div class="block-content collapse in">
                            <div class="span12">
                                <form method="post" action="">
                                    <fieldset>
                                        <div class="control-group">
                                            <label class="control-label">Name:</label>
                                            <div class="controls">
                                                <input name="name" type="text" data-required="1" class="span6 m-wrap"  
                                                        value="#remainder.name#" required />
                                            </div>
                                        </div>
                                        <br/>
                                        <div class="control-group">
                                            <label class="control-label">Description:</label>
                                            <div class="controls">
                                                <input name="description" type="text" class="span6 m-wrap" 
                                                        value="#remainder.description#"/> 					
                                            </div>
                                        </div>
                                        <br/>
                                        <div class="control-group">
                                            <label class="control-label">Date:</label>
                                            <div class="controls">
                                                <input name="date" type="date" class="span6 m-wrap" required 
                                                        value="#Dateformat(remainder.date,'yyyy-mm-dd')#"/>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <button type="submit" class="btn btn-primary" name="submit">
                                                Edit Details
                                            </button>
                                            <a href="remainders.cfm?remainderID=#url.remainderID#">
                                                <button type="button" class="btn">Cancel</button>
                                            </a>
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
        <cfif len(trim(#form.name#)) LTE 32 and len(trim(#form.description#)) LTE 512>
            <cfquery name="remainderEdit" datasource="#Application.dataSourceName#">
                update remainders set 
                name = <cfqueryparam value='#form.name#' CFSQLType="CF_SQL_VARCHAR">,
                description = <cfqueryparam value='#form.description#' CFSQLType="CF_SQL_VARCHAR">,
                date = <cfqueryparam value='#form.date#' CFSQLType="CF_SQL_DATE">
                where remainderID = <cfqueryparam value='#url.remainderID#' CFSQLType="CF_SQL_TINYINT">;
            </cfquery>
        </cfif>
        <cflocation url="remainders.cfm?remainderID=#url.remainderID#" addtoken="false"/>
    </cfif>
</cfoutput>
<cfinclude template="layouts/footer.cfm" />
