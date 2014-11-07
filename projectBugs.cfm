
<cfinclude template="layouts/header.cfm"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="inactive"/>
        <cfset Session.highlight2="active"/>
        <cfset Session.highlight3="inactive"/>
        <cfset Session.highlight4="inactive"/>
        <cfinclude template="layouts/sidebar.cfm"/><!--- including sidebar --->
        <div class="span9" id="content">
            <div class="row-fluid">
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left"></div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <form method="post" action="projectBugs.cfm?projectID=#url.projectID#"  class="form-horizontal">
                                <fieldset>
                                    <legend>Project History</legend>
                                    <div class="control-group">
                                        <label class="control-label">Bugs<span class="required"></span></label>
                                        <div class="controls">
                                            <select class="span6 m-wrap" name="category" id="slct">
                                                <cfinvoke component="components.projectDtls" 
                                                          method="selectStatus"  returnVariable="getdetails">
                                                </cfinvoke> 
                                                <option value="0">All</option>
                                                <cfloop query="getdetails">
                                                    <cfif statusID eq 2 or statusID eq 6>
                                                        <cfoutput><option value="#statusID#">#name#                                                     </option></cfoutput>
                                                    </cfif>
                                                </cfloop>
                                            </select>
                                            <input type="submit" name="submit" value="submit" />
                                        </div>
                                    </div>
                                </fieldset>
                            </form>
                            
                            <cfif isDefined("form.category") and #form.category# GT 0>
                                <cfinvoke component="components.projectDtls" 
                                          method="bugStatus" value="#form.category#"  pjctID="#url.projectID#"                                                        returnVariable="getdetails">
                                </cfinvoke>
                                <cfelseif !isDefined("form.category") or #form.category# EQ 0>
                                   
                                    <cfoutput><cfinvoke component="components.projectDtls" 
                                              method="selectBug" pjctID="#url.projectID#"  returnVariable="getdetails">
                                        </cfinvoke> </cfoutput>
                            </cfif>
                            <table class="table table-bordered">
                                <th><strong>Bug Name</strong></th>
                                <th><strong>Estimated Start Date</strong></th>
                                <th><strong>Actual End Date</strong></th>
                                <th><strong>Status</strong></th>
                                <th><strong>Project</strong></th>
                                <cfloop query="getdetails">
                                    <tr>
                                        <cfoutput>
                                            <td><a href="bugDetailsView.cfm?bid=#bugID#">#bugName#</a></td>
                                            <td>#lsDateFormat(estimatedStartDate)#</td>
                                            <td>#lsDateFormat(actualEndDate)#</td>
                                            <td>#name#</td>
                                            <td>#projectName#</td>
                                        </cfoutput>
                                    </tr>
                                </cfloop>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<cfinclude template="layouts/footer.cfm">   










