<!---
            Bug Tracker - Project Manager History CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfobject name="cfc" component="components.user" />
<cfinclude template="layouts/header.cfm"/><!---including header--->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="inactive"/>
        <cfset Session.highlight2="inactive"/>
        <cfset Session.highlight3="inactive"/>
        <cfset Session.highlight4="inactive"/>
        <cfset Session.highlight5="inactive"/>
        <cfset Session.highlight6="active"/>
        <cfinclude template="layouts/sidebar.cfm"/><!--- including sidebar --->
        <div class="span9" id="content">
            <div class="row-fluid">
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left"><h3>Project History</h3></div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <form method="post" action="projectManagerHistory.cfm" class="form-horizontal">
                                <fieldset>
                                    <div class="control-group">
                                        <label class="control-label">
                                            Project Status
                                            <span class="required"></span>
                                        </label>
                                        <div class="controls">
                                            <select class="span6 m-wrap" name="category" id="slct">
                                                <cfinvoke component="components.user"
                                                          method="selectStatus"
                                                          returnVariable="getdetails">
                                                </cfinvoke> 
                                                <option value="0">All</option>
                                                <cfloop query="getdetails">
                                                    <cfoutput>
                                                        <option value="#statusID#">#name#</option>
                                                    </cfoutput>
                                                </cfloop>
                                            </select>
                                            <div class="muted" style="display:inline">
                                            <input class="btn btn-mini btn-primary"
                                                   type="submit" name="search_btn"
                                                   value="Search"/>
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>
                            </form>
                            <cfif isDefined("form.category") and #form.category# GT 0>
                                <cfinvoke component="components.user"
                                          method="projectStatus"
                                          value="#form.category#"
                                          returnVariable="getdetails">
                                </cfinvoke> 
                                <cfelseif !isDefined("form.category") or #form.category# EQ 0>
                                    <cfinvoke component="components.user"
                                              method="selectProject"
                                              returnVariable="getdetails">
                                    </cfinvoke>
                            </cfif>
                            <table class="table table-bordered">
                                <th><strong>Project Name</strong></th>
                                <th><strong>Estimated Start Date</strong></th>
                                <th><strong>Actual End Date</strong></th>
                                <th><strong>Status</strong></th>
                                <cfloop query="getdetails">
                                    <cfoutput>
                                        <tr>
                                            <td>
                                                <a href="projectProfile.cfm?projectID=#projectID#&flag=1">
                                                    #projectName#
                                                </a>
                                            </td>
                                            <td>#DateFormat(estimatedStartDate,'dd/mm/yyyy')#</td>
                                            <td>#DateFormat(actualEndDate,'dd/mm/yyyy')#</td>
                                            <td>#name#</td>
                                        </tr>
                                    </cfoutput>
                                </cfloop>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<cfinclude template="layouts/footer.cfm"><!---including footer--->