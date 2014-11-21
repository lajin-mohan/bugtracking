<cfinclude template="layouts/header.cfm">
<cfobject name="cfc" component="bug.components.projectDetails" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

<!-- Add Project Details -->
<div class="container-fluid">
    <cfset Session.highlight1="inactive"/>
    <cfset Session.highlight2="inactive"/>
    <cfset Session.highlight3="inactive"/>
    <cfset Session.highlight4="inactive"/>
    <cfset Session.highlight5="active"/>

    <cfinclude template="layouts/sidebar.cfm"/><!--- including sidebar --->
    <div class="span9" id="content">
        <div class="row-fluid">
    <!-- block -->
            <div class="block">
                <div class="navbar navbar-inner block-header">
                    <div class="muted pull-left">Bug History</div>
                </div>
                <div class="block-content collapse in">
                    <div class="span12">
		<!-- BEGIN FORM-->
	                    <form method="post" action="userHistory.cfm" class="form-horizontal">
		                    <fieldset>
		                        <div class="control-group">
  	                                <label class="control-label">Projects<span class="required">                                       </span></label>
  	                                <div class="controls">
                                        <select class="span6 m-wrap" name="category" id="slct">
                                            <cfinvoke component="components.projectDetails" 
                                             method="selectStatus"  returnVariable="getdetails">
                                            </cfinvoke> 
                                            <option value="0">All</option>
                                            <cfloop query="getdetails">
                                                <cfoutput> 
                                                    <option value="#statusID#">#name#</option>                                                     </cfoutput>
                                            </cfloop>
  	                                    </select>
                                        <input type="submit" name="submit" value="submit" />
  	                                </div>
  	                            </div>
                            </fieldset>
                        </form>
		                <cfif #session.roleID# EQ 1>
                            <cfif isDefined("form.category") and #form.category# GT 0 >
                                <cfinvoke component="components.projectDetails" 
                                  method="adminBugs" value="#form.category#"                                                         returnVariable="getdetails">
                                </cfinvoke> 
                            <cfelseif !isDefined("form.category") or #form.category# EQ 0 >
                                 <cfinvoke component="components.projectDetails" 
                                 method="selectAdminBugs" returnVariable="getdetails">
                                 </cfinvoke> 
                            </cfif>
                            <cfelse>
                            <cfif isDefined("form.category") and #form.category# GT 0 >
                                 <cfinvoke component="components.projectDetails" 
                                  method="selectBugs" value="#form.category#"                                                         returnVariable="getdetails">
                                 </cfinvoke> 
                             <cfelseif !isDefined("form.category") or #form.category# EQ 0 >
                                 <cfinvoke component="components.projectDetails" 
                                 method="selectUserBugs" returnVariable="getdetails">
                                 </cfinvoke> 
                             </cfif>
                       </cfif> 
                       <table class="table table-bordered">
                            <th>Bug</th>
                            <th>Bug Description</th>
                            <th>Estimated Start Date</th>
                            <th>Actual Start Date</th>
                            <th>Estimated End Date</th>
                            <th>Actual End Date</th>
                            <th>Status</th>
                            <cfloop query="getdetails">
                                <tr>
                                    <cfoutput>
                                      <td>#bugName#</td>
                                      <td>#bugDescription#</td>
                                      <td>#DateFormat(estimatedStartDate,'dd/mm/yyyy')#</td>
                                      <td>#DateFormat(actualStartDate,'dd/mm/yyyy')#</td> 
                                      <td>#DateFormat(estimatedEndDate,'dd/mm/yyyy')#</td>
                                      <td>#DateFormat(actualEndDate,'dd/mm/yyyy')#</td>
                                      <td>#name#</td>
                                    </cfoutput>
                                </tr>
                           </cfloop>        
                        </table>  
                </div>    
		<!-- END FORM--> 
             </div>
	       </div>
	    </div>
    </div> 
</div><!-- /block -->
                       <!-- End of Add Project dtails -->
 <cfinclude template="layouts/footer.cfm">   