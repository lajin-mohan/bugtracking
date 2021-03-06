<!---
            Bug Tracker - Index CFM
            October 30, 2014
            Author: CF Freshers 2014
--->
<cfinclude template="layouts/header.cfm"/><!--- including header --->
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="inactive"/>
        <cfset Session.highlight2="active"/>
        <cfset Session.highlight3="inactive"/>
        <cfset Session.highlight4="inactive"/>
        <cfinclude template="layouts/sidebar.cfm"/><!--- including sidebar --->
        <div class="span9" id="content">
            <div class="row-fluid">
                <div class="navbar navbar-inner block-header">
                    <div class="muted pull-right">
                      <cfoutput>
                        <a href="addBug.cfm?p=#url.pid#" class="btn btn-default btn-primary" style="display:inline"> </cfoutput>
                            <i class="icon-plus-sign"></i>&nbsp;BUG
                        </a>
                    </div>
                     <div class="muted pull-left"> <cfoutput>
                        <a href="bugProjectDetails.cfm?p=#url.pid#" class="btn btn-default btn-primary" style="display:inline">
                            <i class="icon-arrow-left"></i>&nbsp;Project Details
                            </cfoutput>
                        </a>
                    </div>
                </div>
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <div class="muted pull-right">
                            <form class="form-search" action=" " method="post">
                                <input type="text" class="input-medium search-query" name="search" placeholder="Search Bug"/>
                                <input class="btn btn-mini btn-primary" type="submit" name="search_btn" value="GO"/>
                            </form>
                        </div>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table-striped">
                                <tr>
					               
                                    <td>Bug Name</td>
                                    <td>End Date</td>
                                    <td>Priority</td>
                                   
                                    <td>Status</td>
                                    <td></td>
                                </tr>
                                <cfquery name="bug" datasource="bugTracking">
select b.bugID, b.bugName,b.estimatedEndDate,p.name as n ,s.name as s from bugs as b inner join priorities as p inner join status as s on b.priorityID=p.priorityID and  b.statusID=s.statusID and b.projectID=#url.pid#  order by b.bugName desc;
                                </cfquery>
                                <cfoutput query="bug">
                                    <tr>
                                        <td> <a href="bugview.cfm?bid=#bug.bugID#" onclick="project_return()">#bug.bugName#</a></td>
                                        <td>#dateformat(bug.estimatedEndDate,"yyyy-mm-dd")#</td>
                                        <td>#bug.n#</td>
                                        <td>#bug.s#</td>
                                        <td>
                                           
                                            
                                            <a href="editbug.cfm?bgid=#bug.bugID#&p=#url.pid#" class="btn  btn-mini btn-primary">
                                            <i class="icon-edit"></i></a>&nbsp;&nbsp;
                                            <a href=" " class="btn  btn-mini btn-danger">
                                            <i class="icon-remove"></i></a>
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