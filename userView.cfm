<!---
            Bug Tracker - Index CFM
            October 30, 2014
            Author: CF Freshers 2014
--->
<cfquery name="memberview" datasource="#Application.dataSourceName#">
select u.firstName as uname,u.employeeID as ueid,u.email as uemail,u.contactNumber1 as contact1,u.contactNumber2 as contact2,d.name as dname from users as u inner join designations as d on u.userID=#url.userID# and u.designationID=d.designationID;
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
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-right">
                        <cfif memberview.uemail eq Session.email>
                            <cfoutput>
                                <a href="editEmployee.cfm?userID=#Session.userID#" class="btn btn-default btn-primary" style="display:inline">
                                    <i class="icon-pencil"></i>&nbsp;Edit Profile
                                </a>
                            </cfoutput>
                        </cfif>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <form action=" " class="form-horizontal" method="post">
                                    <fieldset>
                                        <legend>Project Member Profile</legend>
                                        <cfoutput>


                                        <div class="control-group">
                                            <label class="control-label">Name:</label>
                                            <div class="controls">
                                                <input type="text" name="bname" data-required="1" class="span6 m-wrap"  disabled value="#memberview.uname#"/>
                                            </div>
                                        </div>
                                        
                                         <div class="control-group">
                                            <label class="control-label">Employee ID:</label>
                                            <div class="controls">
                                                <input type="text" name="prjname" data-required="1" class="span6 m-wrap"  disabled value="#memberview.ueid#"/>
                                            </div>
                                        </div>
                                            
                                            <div class="control-group">
                                            <label class="control-label">Designation:</label>
                                            <div class="controls">
                                                <input name="asd" type="text" class="span6 m-wrap" disabled value="#memberview.dname#"/>              									
                                            </div>
                                        </div>
                                             
                                        
                                         <div class="control-group">
                                            <label class="control-label">Email:</label>
                                            <div class="controls">
                                                <input type="text" name="bugdesc" data-required="1" class="span6 m-wrap"  disabled value="#memberview.uemail#"/>
                                            </div>
                                        </div>

                                          <div class="control-group">
                                            <label class="control-label">Contact Number 1 </label>
                                            <div class="controls">
                                                <input name="prjname" type="text" class="span6 m-wrap" required disabled value="#memberview.contact1#"/>
                                            </div>
                                        </div>
                                        
                                        
                                        <div class="control-group">
                                            <label class="control-label">Contact Number 2:</label>
                                            <div class="controls">
                                                <input name="esd" type="text" class="span6 m-wrap" disabled value="#memberview.contact2#"/>              									
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








