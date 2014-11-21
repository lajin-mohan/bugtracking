<!---
                Bug Tracker - Project Profile CFM
                October 30, 2014
                Author: CF Freshers 2014
    --->

<cfif isDefined( "form.subn")>
    <cfquery name="mins" datasource="#Application.dataSourceName#">
        update milestones set 
        projectID = <cfqueryparam cfsqltype="cf_sql_tinyint" value="#url.projectID#">, 
        milestoneName = <cfqueryparam value='#form.milestoneName#' cfsqltype="cf_sql_varchar">, 
        milestoneDescription = <cfqueryparam value='#form.milestoneDescription#' cfsqltype="cf_sql_varchar">, 
        milestoneDate = <cfqueryparam value='#form.milestoneDate#' cfsqltype="cf_sql_date">, 
        milestoneStatus = <cfqueryparam value='#form.milestoneStatus#' cfsqltype="cf_sql_varchar">
        where milestoneID=<cfqueryparam value='#url.milestoneID#' cfsqltype="cf_sql_tinyint">
     </cfquery>
</cfif>
<cfinclude template="layouts/header.cfm" />
<cfobject name="addUserObject" component="components.user">

    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
    <script>
        $(document).ready(function () {
            $(function () {
                $("#datepicker").datepicker();
            });
            $(function () {
                $(".form_content").prop("disabled", true)
                $(".form_btn").hide();
                $("#Edit").click(function () {
                    $(".form_content").prop("disabled", false)
                    $(".form_btn").show();
                });
                $("#form_cancel").click(function () {
                    $(".form_content").prop("disabled", true)
                    $(".form_btn").hide();
                });
            });
        });
    </script>
    <cfoutput>
        <div class="container-fluid">
            <div class="row-fluid">
                <cfset Session.highlight1="inactive" />
                <cfset Session.highlight3="inactive" />
                <cfset Session.highlight4="inactive" />
                <cfset Session.highlight5="inactive" />
                <cfinclude template="layouts/sidebar.cfm" />
                <!--- including sidebar --->
                <div class="span9" id="content">
                    <div class="row-fluid">
                        <div class="navbar navbar-inner block-header">
                            <div class="muted pull-left">
                                <a href="projectProfile.cfm?projectID=#url.projectID#" 
                                    class="btn btn-default btn-primary" style="display:inline">
                                    <i class="icon-arrow-left"></i>&nbsp;Back
                                    <cfset Session.highlight2="active" />
                                    <cfset Session.highlight6="inactive" />
                                </a>
                            </div>
                            <div class="muted pull-right">
                                <button type="button" class="btn btn-default btn-primary" id="Edit">
                                    <i class="icon-plus-sign"></i>&nbsp;Edit
                                </button>
                            </div>
                        </div>
                        <cfquery name="m" datasource="#Application.dataSourceName#">
                            select * from milestones where 
                            milestoneID = <cfqueryparam value='#url.milestoneID#' cfsqltype="cf_sql_tinyint">;
                        </cfquery>
                        <div class="block">
                            <div class="block-content collapse in">
                                <div class="span12">
                                    <form action=" " method="post">
                                        <fieldset>
                                            <legend>Project Profile</legend>

                                            <div class="control-group">
                                                <label class="control-label">Name:</label>
                                                <div class="controls">
                                                    <input type="text" class="span6 m-wrap form_content" 
                                                            required value="#m.milestoneName#" 
                                                            name="milestoneName" />
                                                </div>
                                            </div>
                                            <br/>
                                            <div class="control-group">
                                                <label class="control-label">Description:</label>
                                                <div class="controls">
                                                    <input type="text" class="span6 m-wrap form_content" 
                                                            value="#m.milestoneDescription#" 
                                                            name="milestoneDescription" />
                                                </div>
                                            </div>
                                            <br/>
                                            <div class="control-group">
                                                <label class="control-label">Date:</label>
                                                <div class="controls">
                                                    <input type="text" class="span6 m-wrap form_content " 
                                                            id="datepicker" required 
                                                            value="#Dateformat(m.milestoneDate," yyyy-mm-dd ")#" 
                                                            name="milestoneDate" />
                                                </div>
                                            </div>
                                            <br/>
                                            <div class="control-group">
                                                <label class="control-label">Status:</label>
                                                <div class="controls">
                                                    <cfif m.milestoneStatus eq "Progress">
                                                        <select name="milestoneStatus" 
                                                                class="span6 m-wrap form_content" 
                                                                value="#m.milestoneStatus#">
                                                            <optgroup label="Milestone Status">
                                                                <option value="Progress">Progress</option>
                                                                <option value="Completed">Completed</option>
                                                            </optgroup>
                                                        </select>
                                                    <cfelse>
                                                        <select name="milestoneStatus" 
                                                                class="span6 m-wrap form_content" 
                                                                value="#m.milestoneStatus#">
                                                            <optgroup label="Milestone Status">
                                                                <option value="Completed">Completed</option>
                                                                <option value="Progress">Progress</option>
                                                            </optgroup>
                                                        </select>
                                                    </cfif>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <div class="controls">
                                                    <input type="submit" 
                                                            class="btn btn-default btn-primary form_btn" 
                                                            name="subn" value="Save" />
                                                    <button type="button" class="btn btn-default form_btn" 
                                                            id="form_cancel">Cancel</button>
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
<cfinclude template="layouts/footer.cfm" />
