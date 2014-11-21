<!---
            Bug Tracker - Software Developer CFM
            November 04, 2014
            Author: CF Freshers 2014
--->

<cfinclude template="layouts/header.cfm"/><!--- including header --->
<div class="container-fluid">
    <div class="row-fluid">
        <cfset Session.highlight1="active"/>
        <cfset Session.highlight2="inactive"/>
        <cfset Session.highlight3="inactive"/>
        <cfset Session.highlight4="inactive"/>
        <cfset Session.highlight5="inactive"/>
        <cfset Session.highlight6="inactive"/>
        <cfinclude template="layouts/sidebar.cfm"/><!--- including sidebar --->
        <div class="span9" id="content">
            <div class="row-fluid">
                <div class="block">
                    <div class="navbar navbar-inner block-header">
                        <center><h3>Task to be completed</h3></center>
                    </div>
                    <div class="block-content collapse in">
                        <div class="span12">
                            <table class="table table bordered">
                                <tr>
                                  
                                    <td><strong>Bug Name</strong></td>
                                    <td><strong>End Date</strong></td>
                                    <td><strong>Priority</strong></td>
                                    <td><strong>Status</strong></td>
                                </tr>
                                <cfquery name="bug" datasource="#Application.dataSourceName#">
                                    select b.bugID, b.bugName, b.estimatedEndDate, b.statusID, b.priorityID, p.name as pname, st.name as sname
                                    from bugs as b
                                    inner join bugUsers s
                                    inner join priorities as p
                                    inner join status as st
                                    on b.bugID=s.bugID and s.userID=#Session.userID#
                                    and b.statusID=st.statusID and b.priorityID=p.priorityID
                                    order by b.priorityID,b.estimatedEndDate;
                                </cfquery> 
                                <cfoutput query="bug">
                                    <cfif #LSDateformat(bug.estimatedEndDate ,"yyyy-mm-dd")# LT Dateadd("d",7,now()) and #LSDateformat(bug.estimatedEndDate ,"yyyy-mm-dd")# GT now()>  
                                        <tr>
                                      
                                            <td>#bug.bugName#</td>
                                            <td>#LSDateformat(bug.estimatedEndDate,"yyyy-mm-dd")#</td>
                                            <td>#bug.pname#</td>
                                            <td>#bug.sname#</td>
                                        </tr>   
                                    </cfif>  
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
