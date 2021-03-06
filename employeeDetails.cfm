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
        <cfset Session.highlight3="active"/>
        <cfset Session.highlight4="inactive"/>
        <cfinclude template="layouts/sidebar.cfm"/><!--- including sidebar --->
        <div class="span9" id="content">
            <div class="row-fluid">
                <div class="navbar navbar-inner block-header">
                    <div class="muted pull-right">
                        <a href="addEmployee.cfm" class="btn btn-default btn-primary" style="display:inline">
                            <i class="icon-plus-sign"></i>&nbsp;Add Employee
                        </a>
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
                                    <cfquery name="user" datasource="bugTracking">
                                        select u.userName, u.employeeID, u.userID, d.name
                                        from users u inner join designations d
                                        where u.designationID=d.designationID and u.hide=0
                                        and u.userID!=#Session.userID#;
                                    </cfquery>
                                </cfoutput>
                                <cfoutput query="user">
                                    <tr>
                                        <td><a href="employeeProfile.cfm?userID=#user.userID#"  onclick="project_return()">#user.userName#</a></td>
                                        <td>#user.employeeID#</td>
                                        <td>#user.name#</td>
                                        <td>
                                            <a href="editEmployee.cfm?userID=#user.userID#" class="btn  btn-mini btn-primary"><i class="icon-edit"></i></a>&nbsp;&nbsp;
                                            <a href="deleteRecord.cfm?userID=#user.userID#" class="btn  btn-mini btn-danger" onclick="return confirmDelete()"><i class="icon-remove"></i></a>
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
<script>
</script>
<cfinclude template="layouts/footer.cfm"/>