<cfinclude template="layouts/header.cfm">

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

<!-- Add Project Details -->
    <div class="row-fluid">
    <!-- block -->
        <div class="block">
            <div class="navbar navbar-inner block-header">
                <div class="muted pull-left">Team Lead History</div>
            </div>
            <div class="block-content collapse in">
                <div class="span12">
		<!-- BEGIN FORM-->
	            <form method="post" action="tleadhistory.cfm"  class="form-horizontal">
		        <fieldset>
		            <div class="control-group">
  	                        <label class="control-label">Bugs<span class="required"></span></label>
  	                        <div class="controls">
                                     
  	                            <select class="span6 m-wrap" name="category" id="slct">
                                         <cfinvoke component="projectDetails" 
                                                   method="selectStatus"  returnVariable="getdetails">
                                                  </cfinvoke> 
                                         
                                         <option value="0">All</option>
                                        <cfloop query="getdetails">
                                            
                                           <cfoutput> <option value="#statusID#">#name#</option></cfoutput>
                                        </cfloop>
  	                            </select>
                                <input type="submit" name="submit" value="submit" />
  	                        </div>
  	                     </div>
                             <div>
                                 
	                </fieldset>
  
		    </form>
                    <cfif isDefined("form.category") and #form.category# GT 0>
                        <cfinvoke component="projectDetails" 
                           method="bugStatus" value="#form.category#" returnVariable="getdetails">
                        </cfinvoke>
                    
                  <cfelseif !isDefined("form.category") or #form.category# EQ 0>
                    
                          <cfinvoke component="projectDetails" 
                             method="selectBug" returnVariable="getdetails">
                          </cfinvoke> 
                               
                    </cfif>
                    
                    <table class="table table-bordered">
                       
                          <th>Bug Name</th>
                          <th>Bug Description</th>
                          <th>Estimated Start Date</th>
                          <th>Actual Start Date</th>
                          <th>Estimated End Date</th>
                          <th>Status</th>
                          <th>Priority</th>
                          <th>Severity</th>
                          <th>Project</th>
                                  
                                                               
                        <cfloop query="getdetails">
                            <tr>
                            <cfoutput>
                                      <td>#bugName#</td>
                                      <td>#bugDescription#</td>
                                      <td>#DateFormat(estimatedStartDate,'dd/mm/yyyy')#</td>
                                      <td>#DateFormat(actualStartDate,'dd/mm/yyyy')#</td> 
                                      <td>#DateFormat(estimatedEndDate,'dd/mm/yyyy')#</td>
                                      <td>#name#</td>
                                      <td>#p#</td>
                                      <td>#s#</td>
                                      <td>#projectName#</td>
                               
                            </cfoutput>         
                        </cfloop>        
                              
		<!-- END FORM-->
		</div>
	    </div>
	</div>
                     	<!-- /block -->
    </div>
                     <!-- End of Add Project dtails -->
    
<cfinclude template="layouts/footer.cfm">   










