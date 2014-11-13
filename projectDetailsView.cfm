<!---
            Bug Tracker - Index CFM
            October 30, 2014
            Author: CF Freshers 2014
--->
<cfquery name="projview" datasource="bugTracking">
select p.projectName as pname,p.projectDescription as pdes,p.estimatedStartDate as esd,p.actualStartDate as asd,p.estimatedEndDate as eed,p.actualEndDate as aed,s.name as status,prior.name as priority from projects as p inner join status as s inner join priorities as prior on p.projectID=#url.pid# and s.statusID=p.statusID and prior.priorityID=p.priorityID
</cfquery>
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
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        
                        <center> <h3>Project Details  </h3></center>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                          <form action=" " class="form-horizontal" method="post">
                                    <fieldset>
                                        <legend>Project Profile</legend>
                                        <cfoutput>


                                        <div class="control-group">
                                            <label class="control-label">Project Name:</label>
                                            <div class="controls">
                                                <input type="text" name="pname" data-required="1" class="span6 m-wrap"  disabled value="#projview.pname#"/>
                                            </div>
                                        </div>
                                            
                                            
                                        
                                         <div class="control-group">
                                            <label class="control-label">Estimated start Date:</label>
                                            <div class="controls">
                                                <input type="text" name="prjname" data-required="1" class="span6 m-wrap"  disabled value="#dateformat(projview.esd,"yyyy-mm-dd")#"/>
                                            </div>
                                        </div>
                                            
                                            <div class="control-group">
                                            <label class="control-label">Actual start Date:</label>
                                            <div class="controls">
                                                <input name="asd" type="text" class="span6 m-wrap" disabled value="#dateformat(projview.asd,"yyyy-mm-dd")#"/>              									
                                            </div>
                                        </div>
                                            
                                             <div class="control-group">
                                            <label class="control-label">Estimated End Date:</label>
                                            <div class="controls">
                                                <input type="text" name="prjname" data-required="1" class="span6 m-wrap"  disabled value="#dateformat(projview.eed,"yyyy-mm-dd")#"/>
                                            </div>
                                        </div>
                                            
                                            <div class="control-group">
                                            <label class="control-label">Actual End Date:</label>
                                            <div class="controls">
                                                <input name="asd" type="text" class="span6 m-wrap" disabled value="#dateformat(projview.aed,"yyyy-mm-dd")#"/>              									
                                            </div>
                                        </div>
                                             
                                        
                                         <div class="control-group">
                                            <label class="control-label">Status:</label>
                                            <div class="controls">
                                                <input type="text" name="bugdesc" data-required="1" class="span6 m-wrap"  disabled value="#projview.status#"/>
                                            </div>
                                        </div>

                                          <div class="control-group">
                                            <label class="control-label">Priority </label>
                                            <div class="controls">
                                                <input name="prjname" type="text" class="span6 m-wrap" required disabled value="#projview.priority#"/>
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
<cfinclude template="layouts/footer.cfm"/>








