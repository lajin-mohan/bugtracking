<!---
            Bug Tracker - User CFC
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfcomponent>
    <cffunction name="fileupload" returnType="any">
        <cfif isDefined('form.status')>
            <cfquery name="updateStatusID" datasource="bugTracking">
                update bugs set 
                statusID=<cfqueryparam value="#form.status#" CFSQLType="CF_SQL_TINYINT">
                where bugID=#url.bugID#;
            </cfquery>
        </cfif>

        <cfset dat=now()/>
        <cfquery name="remarkTableInsert" datasource="bugTracking" result="remark">
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
        <cfif len(form.attachment)>
            <cffile action = "upload" 
                    fileField = "form.attachment" 
                    destination = "/var/www/html/Training/Bug Tracking/attachments/"
                    nameConflict = "MakeUnique"
                    result="uploadresult">
            <cfquery name="getRemarkID" datasource="bugTracking" result="remarkID">
                select remarkID from remarks where createdOn=#dat#;
            </cfquery>
            <cfquery name="attachmentInsert" datasource="bugTracking" result="attachment">
                insert into attachments (
                fileName,
                remarkID,    
                filePath,
                fileType,
                uploadedOn
                ) values (
                <cfqueryparam value="#uploadresult.serverfile#" CFSQLType="CF_SQL_VARCHAR">,
                <cfqueryparam value="#getRemarkID.remarkID#" CFSQLType="CF_SQL_VARCHAR">,
                <cfqueryparam value="#uploadresult.serverdirectory#" CFSQLType="CF_SQL_VARCHAR">,
                <cfqueryparam value="#uploadresult.serverfileext#" CFSQLType="CF_SQL_VARCHAR">,
                <cfqueryparam value="#dat#" CFSQLType="CF_SQL_TIMESTAMP">
                );
            </cfquery>
            <cfif remarkID.recordcount eq 1 and remark.recordcount eq 1>
                <cfoutput>attachment inserted successfully</cfoutput>
            <cfelse>
                <cfoutput> failed</cfoutput> 
            </cfif>
        </cfif>  
    </cffunction>       

    <cffunction name="bug" returnType="any">
        <cfargument name="tempbugID" required="true">
        <cfoutput>
            <cfquery name="bugcheck" datasource="bugTracking" result="checkbug">
                select * from bugs where bugID = #tempbugID#;
            </cfquery>
            <cfquery name="bugusercheck" datasource="bugTracking" result="checkbuguser">
                select userID from bugUsers where bugID = #tempbugID#;
            </cfquery>
            <cfif form.statusID eq 0 >
                <cfset statusID = "#bugcheck.statusID#" />
            <cfelse>
                <cfset statusID = "#form.statusID#" />
            </cfif>
            <cfif form.priorityID eq 0 >
                <cfset priorityID = "#bugcheck.priorityID#" />
            <cfelse>
                <cfset priorityID = "#form.priorityID#" />
            </cfif>
            <cfif form.severityID eq 0 >
                <cfset severityID = "#bugcheck.severityID#" />
            <cfelse>
                <cfset severityID = "#form.severityID#" />
            </cfif>
            <cfif form.teamMemberID eq 0 >
                <cfset teamMemberID = "#bugusercheck.userID#" />
            <cfelse>
                <cfset teamMemberID = "#form.teamMemberID#" />
            </cfif>   
            <cfquery name="updatebug" datasource="bugTracking" result="updatedbug">
                update bugs set
                bugName = <cfqueryparam value="#form.bname#" CFSQLType="CF_SQL_VARCHAR">,
                bugDescription = <cfqueryparam value="#form.bugdes#" CFSQLType="CF_SQL_VARCHAR">,
                actualStartDate = <cfqueryparam value="#form.asd#" CFSQLType="CF_SQL_DATE">,
                statusID = <cfqueryparam value="#statusID#" CFSQLType="CF_SQL_TINYINT">,
                priorityID = <cfqueryparam value="#priorityID#" CFSQLType="CF_SQL_TINYINT">,
                severityID = <cfqueryparam value="#severityID#" CFSQLType="CF_SQL_TINYINT"> 
                where bugID=#tempbugID#;
            </cfquery>
            <cfquery name="updatebugUser" datasource="bugTracking" result="updatedbuguser">
                update bugUsers set
                userID= <cfqueryparam value="#teamMemberID#" CFSQLType="CF_SQL_TINYINT" >  
                where bugID=#tempbugID#;
            </cfquery>
            <cfif updatedbug.recordcount eq 1 and updatedbuguser.recordcount eq 1>
                <cflocation url="bugDetails.cfm?pid=#url.p#" addtoken="false">
            <cfelse>
                <cfoutput>update failed</cfoutput> 
            </cfif>
        </cfoutput>
    </cffunction>
    <cffunction name="getDesignation">
        <cfargument name="tableName" required="true" />
        <cfquery name="designationValues" datasource="bugTracking" result="designationRecord">
            select * from #arguments.tableName#;
        </cfquery>
        <cfreturn designationValues />
    </cffunction>
    <cffunction name="loginCheck">
        <cfquery name="loginValues" datasource="bugTracking" result="loginRecord">
            select * from users where
            email = <cfqueryparam value="#form.email#" CFSQLType="CF_SQL_VARCHAR">
        </cfquery>
        <cfif loginRecord.recordcount>
            <cfset password = Hash(trim(form.pass) & loginValues.salt,'SHA-512') />
            <cfif password eq loginValues.password>
                <cfset Session.userID="#loginValues.userID#">
                <cfset Session.roleID="#loginValues.roleID#">
                <cfset Session.userName="#loginValues.userName#">
                <cfset Session.email="#loginValues.email#">
                <cfset SessionRotate()>
                <cfif Session.roleID eq '1'>
                    <cfset Session.menu1="projectManager.cfm">
                    <cfset Session.menu2="projectDetails.cfm">
                    <cfset Session.menu3="employeeDetails.cfm">
                    <cfset Session.menu4="projectManagerHistory.cfm">
                    <cfset Session.highlight1="active">
                    <cfset Session.highlight2="inactive">
                    <cfset Session.highlight3="inactive">
                    <cfset Session.highlight4="inactive">
                    <cflocation url="projectManager.cfm" addtoken="false">
                <cfelseif Session.roleID eq '2'>
                    <cfset Session.menu1="projectLead.cfm">
                    <cfset Session.menu2="bugProjectDetails.cfm">
                    <cfset Session.menu3="projectMembers.cfm">
                    <cfset Session.menu4="teamLeadHistory.cfm">
                    <cfset Session.highlight1="active">
                    <cfset Session.highlight2="inactive">
                    <cfset Session.highlight3="inactive">
                    <cfset Session.highlight4="inactive">
                    <cflocation url="projectLead.cfm" addtoken="false">
                <cfelseif Session.roleID eq '3'>
                    <cfset Session.menu1="softwareDeveloper.cfm">
                    <cfset Session.menu2="ownBugs.cfm">
                    <cfset Session.menu3="teamMembers.cfm">
                    <cfset Session.menu4="pmHistory.cfm">
                    <cfset Session.highlight1="active">
                    <cfset Session.highlight2="inactive">
                    <cfset Session.highlight3="inactive">
                    <cfset Session.highlight4="inactive">
                    <cflocation url="softwareDeveloper.cfm" addtoken="false">
                <cfelseif Session.roleID eq '4'>
                    <cfset Session.menu1="softwareTester.cfm">
                    <cfset Session.menu2="ownBugs.cfm">
                    <cfset Session.menu3="teamMembers.cfm">
                    <cfset Session.menu4="pmHistory.cfm">
                    <cfset Session.highlight1="active">
                    <cfset Session.highlight2="inactive">
                    <cfset Session.highlight3="inactive">
                    <cfset Session.highlight4="inactive">
                    <cflocation url="softwareTester.cfm" addtoken="false">
                <cfelse>
                    <cflocation url="index.cfm" addtoken="false">
                </cfif>
            <cfelse>
                <p>Incorrect Password</p>
            </cfif>
        <cfelse>
            <p>Incorrect Login Information</p>
        </cfif>
    </cffunction>
    <cffunction name="selectProject" access="public" output="false" returnType="query">
        <cfquery name="projects" datasource="bugTracking">
            select projects.*, status.name 
            from projects inner join status on 
            status.statusID=projects.statusID
        </cfquery>
        <cfreturn projects>
    </cffunction>
    <cffunction name="projectStatus" access="public" output="false" returnType="query">
        <cfargument name="value" required="true" type="string">
            <cfquery name="projectStatus" datasource="bugTracking">
                select projects.*, status.name from projects inner join status
                on status.statusID=projects.statusID and status.statusID="#value#"
            </cfquery>
            <cfreturn projectStatus>
    </cffunction>
    <cffunction name="selectStatus" access="public" output="false" returnType="query">
        <cfquery name="status" datasource="bugTracking">
            select * from status
        </cfquery>
        <cfreturn status>
    </cffunction>
    <cffunction name="addUser">
        <cfquery result="checkEmail" datasource="bugTracking">
            select email from users where email="#form.email#"
        </cfquery>

        <cfif checkEmail.recordcount>
            <p>User already exists on database</p>
        <cfelse>
            <cfset salt = Hash(GenerateSecretKey("AES"),"SHA-512") />
            <cfset password = Hash(trim(form.password) & salt,"SHA-512") />
            <cfquery name="inser" datasource="bugTracking">
                insert into users (
                    userName,
                    email,
                    password,
                    salt,
                    employeeID,
                    roleID,
                    designationID 
                )
                values (
                    <cfqueryparam value="#form.name#" CFSQLType="CF_SQL_VARCHAR"/>,
                    <cfqueryparam value="#form.email#" CFSQLType="CF_SQL_VARCHAR"/>,
                    <cfqueryparam value="#password#" CFSQLType="CF_SQL_VARCHAR"/>,
                    <cfqueryparam value="#salt#" CFSQLType="CF_SQL_VARCHAR"/>,
                    <cfqueryparam value="#form.empCode#" CFSQLType="CF_SQL_VARCHAR"/>,
                    <cfqueryparam value="#form.role#" CFSQLType="CF_SQL_TINYINT"/>,
                    <cfqueryparam value="#form.designation#" CFSQLType="CF_SQL_TINYINT"/>
                );
            </cfquery>
            <cflocation url="employeeDetails.cfm" addtoken="false">
        </cfif>
    </cffunction>
    <cffunction name="updateProfile" returnType="any">
        <cfargument name="tempUserID" default="#Session.userID#" >
        <cfquery name="check" datasource="bugTracking" result="checkRecord">
            select * from users where userID = "#tempUserID#";
        </cfquery>
        <cfif isNull(form.uname)>
            <cfset name = "#check.userName#" />
        <cfelse>
            <cfset name = "#form.uname#" />
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
                                    <p>New password has not been updated since the old password you entered was incorrect</p>
                            </cfif>
                            <cfelse>
                                <p>You need to enter a new password</p>
                        </cfif>
                </cfif>
        </cfif>
        <cfif len(trim(#form.co1#))>
            <cfset newNumber1 = "#form.co1#" />
        <cfelse>
            <cfset newNumber1 = "#check.contactNumber1#" />
        </cfif>
        <cfif len(trim(#form.co2#))>
            <cfset newNumber2 = "#form.co2#" />
        <cfelse>
            <cfset newNumber2 = "#check.contactNumber2#" />
        </cfif>
        <cfquery name="updateRecord" datasource="bugTracking">
            update users set
            userName = <cfqueryparam value="#name#" CFSQLType="CF_SQL_VARCHAR">,
            email = <cfqueryparam value="#email#" CFSQLType="CF_SQL_VARCHAR">,
            employeeID = <cfqueryparam value="#employeeCode#" CFSQLType="CF_SQL_VARCHAR">,
            password = <cfqueryparam value="#password#" CFSQLType="CF_SQL_VARCHAR">,
            contactNumber1 = <cfqueryparam value="#newNumber1#" CFSQLType="CF_SQL_VARCHAR">,
            contactNumber2 = <cfqueryparam value="#newNumber2#" CFSQLType="CF_SQL_VARCHAR">,
            roleID = <cfqueryparam value="#roleID#" CFSQLType="CF_SQL_TINYINT">,
            designationID = <cfqueryparam value="#designationID#" CFSQLType="CF_SQL_TINYINT"> 
            where userID="#tempUserID#";
        </cfquery>
            <cflocation url="employeeDetails.cfm" addtoken="false"/>
    </cffunction>
</cfcomponent>
