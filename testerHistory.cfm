<cfinclude template="layouts/header.cfm">

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="inactive"/>
        <cfset Session.highlight2="inactive"/>
        <cfset Session.highlight3="inactive"/>
        <cfset Session.highlight4="inactive"/>
        <cfset Session.highlight5="inactive"/>
        <cfset Session.highlight6="active"/>
        <cfinclude template="layouts/sidebar.cfm"><!--- including sidebar --->

        <div class="span9" id="content">
            <div class="row-fluid"> 
                <div class="block"> <!-- block -->
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">Tester History</div>
                    </div>
                <div class="block-content collapse in">
                    <div class="span12">
		              <!-- BEGIN FORM-->
                    <form method="post" action="testerHistory.cfm"  class="form-horizontal">
                        <fieldset>
                            <div class="control-group">
  	                             <label class="control-label">Bugs<span class="required"></span></label>
  	                             <div class="controls">
                                    <select class="span6 m-wrap" name="category" id="slct">
                                         <option value="0">All</option>
                                         <option value="1">Resolved</option>
                                         <option value="2">Unresolved</option>
                                    </select>
                                    <input type="submit" name="submit" value="submit" />
  	                             </div>
                            </div>                                 
	                   </fieldset> 
                    </form>
                        
                    <cfif isDefined("form.category") and #form.category# GT 0>
                        <cfinvoke component="components.testerHistory" 
                           method="bugStatus" value="#form.category#" returnVariable="getdetails">
                        </cfinvoke>                     
                    <cfelseif !isDefined("form.category") or #form.category# EQ 0>                   
                          <cfinvoke component="components.testerHistory" 
                             method="selectBug" returnVariable="getdetails">
                          </cfinvoke>                               
                    </cfif>
                   
                    <table class="table table-bordered">                       
                        <th>Bug Name</th>
                        <th>Status</th>
                        <th>Last Reviewed On</th>                      
                        <cfloop query="getdetails">
                            <tr>
                            <cfoutput>
                                <td>#bugName#</td>
                                <td>#name#</td>
                                <td>#loggedTime#</td>         
                            </cfoutput>
                            </tr> 
                        </cfloop>        
                    </table>             
		<!-- END FORM-->
		            </div>
	            </div>
                </div>  <!-- /block -->
            </div>
        </div>                    	
    </div>
</div>
                     <!-- End of Add Project dtails -->
    
<cfinclude template="layouts/footer.cfm">   










