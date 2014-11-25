<!---
            Bug Tracker - User CFC
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfcomponent>
    <cffunction name="fileupload" returnType="any">
        <cfargument name="userid" required="false" /> 
        <cfif isDefined('form.status')>
            <cfquery name="updateStatusID" datasource="#Application.dataSourceName#">
                update bugs set 
                statusID=<cfqueryparam value="#form.status#" CFSQLType="CF_SQL_TINYINT">
                where bugID=<cfqueryparam value="#url.bugID#" CFSQLType="CF_SQL_TINYINT">;
            </cfquery>
            <cfif Session.roleID eq 4>
                <cfquery name="relateTestertoBug" datasource="#Application.dataSourceName#" result="checkTester">
                    select userID from bugUsers where
                    userID = <cfqueryparam value="#Session.userID#" CFSQLType="CF_SQL_TINYINT"> and
                    bugID = <cfqueryparam value="#url.bugID#" CFSQLType="CF_SQL_TINYINT">;
                </cfquery>
                <cfif !checkTester.recordcount>
                    <cfquery name="insertRelation" datasource="#Application.dataSourceName#">
                        insert into bugUsers(userID,bugID) values (
                            <cfqueryparam value="#Session.userID#" CFSQLType="CF_SQL_TINYINT">,
                            <cfqueryparam value="#url.bugID#" CFSQLType="CF_SQL_TINYINT">
                        );
                    </cfquery>
                </cfif>
            </cfif>
        </cfif>
               
        <cfset dat=now()/>
        <cfif Session.roleID neq 1> 
        <cfquery name="remarkTableInsert" datasource="#Application.dataSourceName#" result="remark">
            insert into remarks (
            name,
            description,
            createdOn,
            bugID,
            userID
            ) values (
            <cfqueryparam value="#form.subject#" CFSQLType="CF_SQL_VARCHAR">,
            <cfqueryparam value="#form.remark#" CFSQLType="CF_SQL_VARCHAR">,
            <cfqueryparam value="#dat#" CFSQLType="CF_SQL_TIMESTAMP">,
            <cfqueryparam value="#url.bugID#" CFSQLType="CF_SQL_TINYINT">,
            <cfqueryparam value="#session.userID#" CFSQLType="CF_SQL_TINYINT">
            );
        </cfquery>  
            <cfelse>
          <cfquery name="remarkTableInsert" datasource="#Application.dataSourceName#" result="remark">
            insert into remarks (
            name,
            description,
            createdOn,
            userID,
            ProjectID
            ) values (
            <cfqueryparam value="#form.subject#" CFSQLType="CF_SQL_VARCHAR">,
            <cfqueryparam value="#form.remark#" CFSQLType="CF_SQL_VARCHAR">,
            <cfqueryparam value="#dat#" CFSQLType="CF_SQL_TIMESTAMP">,
            <cfqueryparam value="#userid#" CFSQLType="CF_SQL_TINYINT">,
            <cfqueryparam value="#url.pid#" CFSQLType="CF_SQL_TINYINT">
            );
        </cfquery>  
                </cfif>
        <cfif len(trim(form.attachment))>
            <cffile action = "upload" 
                    fileField = "form.attachment" 
                    destination = "#expandPath('images/')#"
                    nameConflict = "MakeUnique"
                    result="uploadresult">
                <cfset filen=#uploadresult.serverfile#/>
                <cfset filepa=#uploadresult.serverdirectory#/>
                <cfset filety=#uploadresult.serverfileext#/>
               
               <cfelse> 
                
               <cfset filen=""/>
                <cfset filepa=""/>
                <cfset filety=""/>
        </cfif>
        <cfquery name="getRemarkID" datasource="#Application.dataSourceName#" result="remarkID">
            select remarkID from remarks where createdOn=#dat#;
        </cfquery>
                <cfif Session.roleID neq 1> 
        <cfquery name="attachmentInsert" datasource="#Application.dataSourceName#" result="attachmentRsult">
            insert into attachments (
            fileName,
            remarkID,    
            filePath,
            fileType,
            uploadedOn
            ) values (
            <cfqueryparam value="#filen#" CFSQLType="CF_SQL_VARCHAR">,
            <cfqueryparam value="#getRemarkID.remarkID#" CFSQLType="CF_SQL_VARCHAR">,
            <cfqueryparam value="#filepa#" CFSQLType="CF_SQL_VARCHAR">,
            <cfqueryparam value="#filety#" CFSQLType="CF_SQL_VARCHAR">,
            <cfqueryparam value="#dat#" CFSQLType="CF_SQL_TIMESTAMP">
            );
        </cfquery>
                <cfelse>
                    <cfquery name="attachmentInsert" datasource="#Application.dataSourceName#" result="attachmentRsult">
            insert into attachments (
            fileName,
            remarkID,    
            filePath,
            fileType,
            uploadedOn
            ) values (
            <cfqueryparam value="#filen#" CFSQLType="CF_SQL_VARCHAR">,
            <cfqueryparam value="#getRemarkID.remarkID#" CFSQLType="CF_SQL_VARCHAR">,
            <cfqueryparam value="#filepa#" CFSQLType="CF_SQL_VARCHAR">,
            <cfqueryparam value="#filety#" CFSQLType="CF_SQL_VARCHAR">,
            <cfqueryparam value="#dat#" CFSQLType="CF_SQL_TIMESTAMP">
            );
        </cfquery>
                </cfif>
        <cfif remarkID.recordcount eq 1 and remark.recordcount eq 1>
            <cfoutput>attachment inserted successfully</cfoutput>
            <cfreturn true />
        <cfelse>
            <cfoutput> failed</cfoutput> 
            <cfreturn false />
        </cfif>
    </cffunction>       

    <cffunction name="bug" returnType="any">
        <cfargument name="tempbugID" required="true">
        <cfoutput>
            <cfquery name="bugcheck" datasource="#Application.dataSourceName#" result="checkbug">
                select * from bugs where 
                bugID = <cfqueryparam value="#tempbugID#" CFSQLType="CF_SQL_TINYINT">;
            </cfquery>
            <cfquery name="bugusercheck" datasource="#Application.dataSourceName#" result="checkbuguser">
                select userID from bugUsers where 
                bugID = <cfqueryparam value="#tempbugID#" CFSQLType="CF_SQL_TINYINT">;
            </cfquery>
            <cfif form.statusID eq #bugcheck.statusID#>
                <cfset statusID = "#bugcheck.statusID#" />
            <cfelse>
                <cfset statusID = "#form.statusID#" />
            </cfif>
            <cfif form.priorityID eq #bugcheck.priorityID#>
                <cfset priorityID = "#bugcheck.priorityID#" />
            <cfelse>
                <cfset priorityID = "#form.priorityID#" />
            </cfif>
            <cfif form.severityID eq #bugcheck.severityID#>
                <cfset severityID = "#bugcheck.severityID#" />
            <cfelse>
                <cfset severityID = "#form.severityID#" />
            </cfif>
            <cfif form.teamMemberID eq 0 >
                <cfset teamMemberID = "#bugusercheck.userID#" />
            <cfelse>
                <cfset teamMemberID = "#form.teamMemberID#" />
            </cfif>   
            <cfquery name="updatebug" datasource="#Application.dataSourceName#" result="updatedbug">
                update bugs set
                bugName = <cfqueryparam value="#form.bname#" CFSQLType="CF_SQL_VARCHAR">,
                bugDescription = <cfqueryparam value="#form.bugdes#" CFSQLType="CF_SQL_VARCHAR">,
                actualStartDate = <cfqueryparam value="#form.asd#" CFSQLType="CF_SQL_DATE">,
                statusID = <cfqueryparam value="#statusID#" CFSQLType="CF_SQL_TINYINT">,
                priorityID = <cfqueryparam value="#priorityID#" CFSQLType="CF_SQL_TINYINT">,
                severityID = <cfqueryparam value="#severityID#" CFSQLType="CF_SQL_TINYINT"> 
                where bugID=<cfqueryparam value="#tempbugID#" CFSQLType="CF_SQL_TINYINT">;
            </cfquery>
            <cfquery name="updatebugUser" datasource="#Application.dataSourceName#" result="updatedbuguser">
                update bugUsers set
                userID= <cfqueryparam value="#teamMemberID#" CFSQLType="CF_SQL_TINYINT" >  
                where bugID=<cfqueryparam value="#tempbugID#" CFSQLType="CF_SQL_TINYINT">;
            </cfquery>
            <cfif updatedbug.recordcount eq 1 and updatedbuguser.recordcount eq 1>
                <cfreturn true />
                
            <cfelse>
                <cfoutput>update failed</cfoutput> 
                <cfreturn false />
            </cfif>
        </cfoutput>
    </cffunction>

    <cffunction name="getDesignation">
        <cfargument name="tableName" required="true" />
        <cfquery name="designationValues" datasource="#Application.dataSourceName#" result="designationRecord">
            select * from #arguments.tableName#;
        </cfquery>
        <cfreturn designationValues />
    </cffunction>

    <cffunction name="loginCheck">
        <cfquery name="loginValues" datasource="#Application.dataSourceName#" result="loginRecord">
            select * from users where
            email = <cfqueryparam value="#form.email#" CFSQLType="CF_SQL_VARCHAR">
        </cfquery>
        <cfif loginRecord.recordcount>
            <cfset password = Hash(trim(form.pass) & loginValues.salt,'SHA-512') />
            <cfif password eq loginValues.password>
                <cfset Session.userID="#loginValues.userID#">
                <cfset Session.roleID="#loginValues.roleID#">
                <cfset Session.firstName="#loginValues.firstName#">
                <cfset Session.email="#loginValues.email#">
                <cfset SessionRotate()>
                <cfif Session.roleID eq '1'>
                    <cfset Session.menu1="projectManager.cfm">
                    <cfset Session.menu2="projectDetails.cfm">
                    <cfset Session.menu3="pmTimeSheet.cfm">
                    <cfset Session.menu4="calendar.cfm">
                    <cfset Session.menu5="employeeDetails.cfm">
                    <cfset Session.menu6="projectManagerHistory.cfm">
                    <cfset Session.highlight1="active">
                    <cfset Session.highlight2="inactive">
                    <cfset Session.highlight3="inactive">
                    <cfset Session.highlight4="inactive">
                    <cfset Session.highlight5="inactive">
                    <cfset Session.highlight6="inactive">
                    <cflocation url="projectManager.cfm" addtoken="false">
              <cfelseif Session.roleID eq '2'>
                    <cfset Session.menu1="projectLead.cfm">
                    <cfset Session.menu2="bugProjectDetails.cfm">
                    <cfset Session.menu3="plTimeSheet.cfm">
                    <cfset Session.menu4="calendar.cfm">
                    <cfset Session.menu5="projectMembers.cfm">
                    <cfset Session.menu6="teamLeadHistory.cfm">
                    <cfset Session.highlight1="active">
                    <cfset Session.highlight2="inactive">
                    <cfset Session.highlight3="inactive">
                    <cfset Session.highlight4="inactive">
                    <cfset Session.highlight5="inactive">
                    <cfset Session.highlight6="inactive">
                    <cflocation url="projectLead.cfm" addtoken="false">
                <cfelseif Session.roleID eq '3'>
                    <cfset Session.menu1="softwareDeveloper.cfm">
                    <cfset Session.menu2="ownBugs.cfm">
                    <cfset Session.menu3="userTimeSheet.cfm">
                    <cfset Session.menu4="calendar.cfm">
                    <cfset Session.menu5="teamMembers.cfm">
                    <cfset Session.menu6="softwareDeveloperHistory.cfm">
                    <cfset Session.highlight1="active">
                    <cfset Session.highlight2="inactive">
                    <cfset Session.highlight3="inactive">
                    <cfset Session.highlight4="inactive">
                    <cfset Session.highlight5="inactive">
                    <cfset Session.highlight6="inactive">
                    <cflocation url="softwareDeveloper.cfm" addtoken="false">
                <cfelseif Session.roleID eq '4'>
                    <cfset Session.menu1="softwareTester.cfm">
                    <cfset Session.menu2="ownBugs.cfm">
                    <cfset Session.menu3="userTimeSheet.cfm">
                    <cfset Session.menu4="calendar.cfm">
                    <cfset Session.menu5="teamMembers.cfm">
                    <cfset Session.menu6="testerHistory.cfm">
                    <cfset Session.highlight1="active">
                    <cfset Session.highlight2="inactive">
                    <cfset Session.highlight3="inactive">
                    <cfset Session.highlight4="inactive">
                    <cfset Session.highlight5="inactive">
                    <cfset Session.highlight6="inactive">
                    <cflocation url="softwareTester.cfm" addtoken="false">
                <cfelse>
                    <cflocation url="index.cfm" addtoken="false">
                </cfif>
            <cfelse>
                <p>Incorrect Login or Password</p>
            </cfif>
        <cfelse>
            <p>Incorrect Login or Password</p>
        </cfif>
    </cffunction>

    <cffunction name="selectProject" access="public" output="false" returnType="query">
        <cfquery name="projects" datasource="#Application.dataSourceName#">
            select projects.*, status.name 
            from projects inner join status on 
            status.statusID=projects.statusID
        </cfquery>
        <cfreturn projects>
    </cffunction>

    <cffunction name="projectStatus" access="public" output="false" returnType="query">
        <cfargument name="value" required="true" type="string">
            <cfquery name="projectStatus" datasource="#Application.dataSourceName#">
                select projects.*, status.name from projects inner join status
                on status.statusID=projects.statusID and status.statusID="#value#"
            </cfquery>
            <cfreturn projectStatus>
    </cffunction>

    <cffunction name="selectStatus" access="public" output="false" returnType="query">
        <cfquery name="status" datasource="#Application.dataSourceName#">
            select * from status
        </cfquery>
        <cfreturn status>
    </cffunction>

    <cffunction name="addUser">
        <cfquery result="checkEmail" datasource="#Application.dataSourceName#">
            select email from users where email=<cfqueryparam value="#form.email#" CFSQLType="CF_SQL_VARCHAR">
        </cfquery>
        <cfif checkEmail.recordcount>
            <p>User already exists on database</p>
        <cfelse>
            <cfquery result="upperLimit" datasource="#Application.dataSourceName#">
                select userID from users;
            </cfquery>
            <cfset limit = #upperLimit.recordCount# />
            <cfset empAutoID  = "TV#NumberFormat(limit+1,'0____')#" />
            <cfset salt = Hash(GenerateSecretKey("AES"),"SHA-512") />
            <cfset password = Hash(trim(form.password) & salt,"SHA-512") />
            <cfquery name="inser" datasource="#Application.dataSourceName#">
                insert into users (
                    firstName,
                    lastName,
                    email,
                    password,
                    salt,
                    employeeID,
                    roleID,
                    designationID 
                )
                values (
                    <cfqueryparam value="#form.firstName#" CFSQLType="CF_SQL_VARCHAR"/>,
                    <cfqueryparam value="#form.lastName#" CFSQLType="CF_SQL_VARCHAR"/>,
                    <cfqueryparam value="#form.email#" CFSQLType="CF_SQL_VARCHAR"/>,
                    <cfqueryparam value="#password#" CFSQLType="CF_SQL_VARCHAR"/>,
                    <cfqueryparam value="#salt#" CFSQLType="CF_SQL_VARCHAR"/>,
                    <cfqueryparam value="#empAutoID#" CFSQLType="CF_SQL_VARCHAR"/>,
                    <cfqueryparam value="#form.role#" CFSQLType="CF_SQL_TINYINT"/>,
                    <cfqueryparam value="#form.designation#" CFSQLType="CF_SQL_TINYINT"/>
                );
            </cfquery>
            <cflocation url="employeeDetails.cfm" addtoken="false"/>
        </cfif>
    </cffunction>

    <cffunction name="updateProfile" returnType="any">
        <cfargument name="tempUserID" default="#Session.userID#" >
        <cfquery name="check" datasource="#Application.dataSourceName#" result="checkRecord">
            select * from users where userID = <cfqueryparam value="#tempUserID#" CFSQLType="CF_SQL_TINYINT">;
        </cfquery>
        <cfif isNull(form.fname)>
            <cfset fname = "#check.firstName#" />
        <cfelse>
            <cfset fname = "#form.fname#" />
        </cfif>
        <cfif isNull(form.lname)>
            <cfset lname = "#check.lastName#" />
        <cfelse>
            <cfset lname = "#form.lname#" />
        </cfif>
        <cfif isNull(form.email)>
            <cfset email = "#check.email#" />
        <cfelse>
            <cfset email = "#form.email#" />
        </cfif>
        <cfif isNull(form.empid)>
            <cfset employeeCode = "#check.employeeID#" />
        <cfelse>
            <cfset employeeCode = "#form.empid#" />
        </cfif>
        <cfif isNull(form.role)>
            <cfset roleID = "#check.roleID#" />
        <cfelse>
            <cfset roleID = "#form.role#" />
        </cfif>
        <cfif isNull(form.designation)>
            <cfset designationID = "#check.designationID#" />
        <cfelse>
            <cfset designationID = "#form.designation#" />
        </cfif>
        <cfif Session.roleID eq 1>
            <cfif len(#form.newPassword#)>
                <cfset salt = "#check.salt#" />
                <cfset password = Hash(form.newPassword & salt,"SHA-512") />
            <cfelse>
                <cfset password="#check.password#" />
            </cfif>
        <cfelse>
            <cfif !len(#form.oldPassword#)>
                <cfset password="#check.password#" />
            <cfelse>
                <cfset actualPassword = "#check.password#" />
                <cfset salt = "#check.salt#" />
                <cfset oldPassword = Hash(form.oldPassword & salt,"SHA-512") />
                <cfif len(#form.newPassword#)>
                    <cfset newPassword = Hash(form.newPassword & salt,"SHA-512") />
                    <cfif oldPassword eq actualPassword>
                        <cfset password="#newPassword#" /> 
                    <cfelse>
                        <cfset password="#check.password#" />
                        <p>New password has not been updated since the old password you 
                        entered was incorrect</p>
                    </cfif>
                <cfelse>
                    <p>You need to enter a new password</p>
                </cfif>
            </cfif>
        </cfif>
        <cfif len(trim(#form.co1#)) and isNumeric(#form.co1#)>
            <cfset newNumber1 = "#form.co1#" />
        <cfelse>
            <cfset newNumber1 = "#check.contactNumber1#" />
        </cfif>
        <cfif (len(trim(#form.co2#)) and isNumeric(#form.co2#)) or (len(#form.co2#) EQ 0)>
            <cfset newNumber2 = "#form.co2#" />
        <cfelse>
            <cfset newNumber2 = "#check.contactNumber2#" />
        </cfif>
        <cfquery name="updateRecord" datasource="#Application.dataSourceName#">
            update users set
            firstName = <cfqueryparam value="#fname#" CFSQLType="CF_SQL_VARCHAR">,
            lastName = <cfqueryparam value="#lname#" CFSQLType="CF_SQL_VARCHAR">,
            email = <cfqueryparam value="#email#" CFSQLType="CF_SQL_VARCHAR">,
            employeeID = <cfqueryparam value="#employeeCode#" CFSQLType="CF_SQL_VARCHAR">,
            password = <cfqueryparam value="#password#" CFSQLType="CF_SQL_VARCHAR">,
            contactNumber1 = <cfqueryparam value="#newNumber1#" CFSQLType="CF_SQL_VARCHAR">,
            contactNumber2 = <cfqueryparam value="#newNumber2#" CFSQLType="CF_SQL_VARCHAR">,
            roleID = <cfqueryparam value="#roleID#" CFSQLType="CF_SQL_TINYINT">,
            designationID = <cfqueryparam value="#designationID#" CFSQLType="CF_SQL_TINYINT"> 
            where userID=<cfqueryparam value="#tempUserID#" CFSQLType="CF_SQL_TINYINT">;
        </cfquery>
        <cfif Session.userID eq 1>
            <cflocation url="employeeDetails.cfm" addtoken="false"/>
        <cfelse>
            <cflocation url="userView.cfm?userID=#tempUserID#" addToken="false" />
        </cfif>
    </cffunction>
</cfcomponent>
