<!---
            Bug Tracker - Add Project Members CFM
            October 30, 2014
            Author: CF Freshers 2014
--->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
    $(".hide-element").hide();
  $("#mnew").click(function(){
    $(".hide-element").show();
      $("#mnew").hide();
  });
    $("#mcancel").click(function(){
    $(".hide-element").hide();
      $("#mnew").show();
  });
});
</script>

<cfif isDefined("form.add") and len(trim(form.formMilestoneName))>
    <cfquery name="mins" datasource="bugtracking">
        insert into milestones 
        (projectID,milestoneName,milestoneDescription,milestoneDate,milestoneStatus)
        values(
        <cfqueryparam cfsqltype="cf_sql_tinyint" value="#url.projectID#">,
        <cfqueryparam value='#form.formMilestoneName#' cfsqltype="cf_sql_varchar">,
            <cfqueryparam value='#form.formMilestoneDescription#' cfsqltype="cf_sql_varchar">,
                <cfqueryparam value='#form.formMilestoneDate#' cfsqltype="cf_sql_date">,
                    <cfqueryparam value='#form.formMilestoneStatus#' cfsqltype="cf_sql_varchar"> )
    </cfquery>
</cfif>
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
                        <cfif isdefined('url.flag')>
                            <cfoutput><a href="editProject.cfm?projectID=#url.projectID#&flag" class="btn btn-default btn-primary" style="display:inline"></cfoutput>
                                <i class="icon-arrow-left"></i>&nbsp;Edit Project
                            </a>
                            <cfelse>
                                <cfoutput><a href="editProject.cfm?projectID=#url.projectID#" class="btn btn-default btn-primary" style="display:inline"></cfoutput>
                                    <i class="icon-arrow-left"></i>&nbsp;Edit Project
                                </a>
                        </cfif>
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">
                            <form class="form-search" action=" " method="post">
                            <input type="text" class="input-medium search-query" name="search" placeholder="Search Employee"/>
                            <input class="btn btn-mini btn-primary" type="submit" name="search_btn" value="GO"/>
                            </form>
                        </div>
                    </div>
                    
                     <cfquery name="milestones" datasource="bugtracking">
                                        select * from milestones
                                        where
                                        projectID=#url.projectID# 
                         order by milestoneStatus;
                                    </cfquery>
                    <div class="block-content collapse in">
                        <div class="span12">
                                <table class="table table bordered">
                                    
                                      <div class="control-group">
                                        <label class="control-label"><span class="required"></span></label>
                                        <div class="controls">
                                            <table class="table table bordered">
                                                <tr>
                                                    <th><strong>Name</strong></th>
                                                
                                                    <th><strong>Date</strong></th> 
                                                    <th><strong>Status</strong></th>
                                                </tr>
                                            
                                            <cfoutput query='milestones'>
                                                <tr>
                                                    <td>#milestones.milestoneName#</td>    
                                                    <td>#milestones.milestoneDate#</td>
                                                    <td>#milestones.milestoneStatus#</td>
                                                </tr>
                                            </cfoutput>
                                        </table>
                                    </div>
                                </div> 
                                    
                                </table>
                                 <form action=" " method="post">
                                 <div class="form-actions">
                                     <button id="mnew" type="button" class="btn btn-info">NEW</button></br>
                                        <input type="text" class="form-control  hide-element" name="formMilestoneName" placeholder=" Milestone Name" required></br>
                                        <input type="date" class="form-control   hide-element" name="formMilestoneDate" placeholder=" Date" required></br>
                                        <textarea class=" hide-element" name="formMilestoneDescription" placeholder="Milestone Description" required></textarea></br>
                                        <select name="formMilestoneStatus"  class=" hide-element" required>
                                            <optgroup label="Milestone Status" >
                                        <option value="Progress" >Progress</option>
                                        <option value="Completed">Completed</option>
                                                </optgroup>
                                     </select>
                                          
                                        </br><input type="submit" class="btn btn-primary  hide-element" id="add" name="add"  value="ADD">
                             <button type="reset" class="btn  hide-element" id="mcancel">Cancel</button>
                                </div>
                                     </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<cfinclude template="layouts/footer.cfm"/>