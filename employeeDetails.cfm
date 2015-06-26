<!---
            Bug Tracker - Employee Details CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfobject name="addUserObject" component="components.user"/>
<cfinclude template="layouts/header.cfm"/><!--- including header --->
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="inactive"/>
        <cfset Session.highlight2="inactive"/>
        <cfset Session.highlight3="inactive"/>
        <cfset Session.highlight4="inactive"/>
        <cfset Session.highlight5="active"/>
        <cfset Session.highlight6="inactive"/>
        <cfinclude template="layouts/sidebar.cfm"/><!--- including sidebar --->
        <div class="span9" id="content">
            <div class="row-fluid">                
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-right">
                            <a href="addEmployee.cfm" class="btn btn-default btn-primary" style="display:inline">
                                <i class="icon-plus-sign"></i>&nbsp;Add Employee
                            </a>&nbsp;
                            <a href="pmWholeEmployeeReport.cfm" class="btn btn-default btn-primary" 
                                style="display:inline">
                                <i class='icon-list-alt'></i>&nbsp;Generate Report
                            </a>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table bordered">
                                <tr>
                                    <td>Employee Name</td>
                                    <td>Employee ID</td>
                                    <td>Designation</td>
                                    <td></td>
                                </tr>
                                <cfoutput>
                                    <cfquery name="user" datasource="#Application.dataSourceName#">
                                        select u.firstName, u.lastName, u.employeeID, u.userID, d.name
                                        from users u inner join designations d
                                        where u.designationID=d.designationID and u.hide=0
                                        and u.userID!= <cfqueryparam value="#Session.userID#" 
                                                            CFSQLType="CF_SQL_TINYINT">;
                                    </cfquery>
                                </cfoutput>
                                <cfoutput query="user">
                                    <tr>
                                        <td><a href="employeeProfile.cfm?userID=#user.userID#"  
                                                onclick="project_return()">
                                                #user.firstName# #user.lastName#
                                        </a></td>
                                        <td>#user.employeeID#</td>
                                        <td>#user.name#</td>
                                        <td>
                                            <a href="editEmployee.cfm?userID=#user.userID#" 
                                                class="btn  btn-mini btn-primary">
                                                <i class="icon-edit"></i>
                                            </a>&nbsp;&nbsp;
                                            <a href="deleteRecord.cfm?userID=#user.userID#" 
                                                class="btn  btn-mini btn-danger" 
                                                onclick="return confirmDelete()">
                                                <i class="icon-remove"></i>
                                            </a>
                                        </td>
                                    </tr>   
                                </cfoutput>
					       </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<cfinclude template="layouts/footer.cfm"/>
