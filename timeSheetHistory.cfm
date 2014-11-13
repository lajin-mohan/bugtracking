<!---
            Bug Tracker - Edit Project CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfobject name="cfc" component="components.user" />
<cfinclude template="layouts/header.cfm"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="inactive"/>
        <cfset Session.highlight2="inactive"/>
        <cfset Session.highlight3="active"/>
        <cfset Session.highlight4="inactive"/>
        <cfset Session.highlight5="inactive"/>
        <cfset Session.highlight6="inactive"/>
        <cfinclude template="layouts/sidebar.cfm"/><!--- including sidebar --->
        <div class="span9" id="content">
            <div class="row-fluid">
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left"></div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <form method="post" action="timeSheetHistory.cfm" class="form-horizontal">
                                <fieldset>
                                    <legend>Time Sheet History</legend>
                                    <div class="control-group">
                                       
                                        <div class="controls">
                                           
                                            <input name="fromDate" type="date" placeholder="From" />
                                            <input name="toDate" type="date" placeholder="To" />
                                       
                                            <div class="muted" style="display:inline">
                                            <input class="btn btn-mini btn-primary" type="submit" name="submit" value="Search"/>
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>
                            </form>
                           <cfif isDefined("form.fromDate") and isDefined("form.toDate")>
                               
                                <cfinvoke component="components.timeSheet" method="selectBugOnDate" returnVariable="getdetails" fromDate="#form.fromDate#" toDate="#form.toDate#"></cfinvoke> 
                              
                               <cfelse>
                                <cfinvoke component="components.timeSheet" method="selectBugDetails" returnVariable="getdetails"></cfinvoke> 
                            </cfif>   
                            <table class="table table-bordered">
                                
                                <th><strong>Date</strong></th>
                                <th><strong>Project Name</strong></th>
                                <th><strong>Bug</strong></th>
                                <th><strong>Description</strong></th>
                                <th><strong>Developer</strong></th>
                                <th><strong>Time Spent</strong></th>
                                <th><strong>Productive Hours</strong></th>
                                <th><strong>Status</strong></th>
                                
                            <cfif #getdetails.RecordCount# GT 0>
                                <cfloop query="getdetails">
                                    <cfoutput>
                                        <tr> 
                                            <td>#DateFormat(dateTime,'dd/mm/yyyy')#</td>
                                            <td>#projectName#</td>
                                            <td>#bugName#</td>
                                            <td>#description#</td>
                                            <td>#userName#</td>
                                            <td>#workingHour#</td>
                                            <td>#productiveHours#</td>
                                            <td>#name#</td>                                                                                 </tr>
                                    </cfoutput>
                                 </cfloop>
                                <cfelse>
                                    Record not found
                            </cfif>  
                         </table>
                
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<cfinclude template="layouts/footer.cfm">