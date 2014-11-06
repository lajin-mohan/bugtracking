 <cffunction name="bug" returnType="any">
        <cfargument name="tempbugID" >
        <cfquery name="bugcheck" datasource="bugTracking" result="checkbug">
            select * from bugs where bugID = "#tempbugID#";
        </cfquery>
        <cfquery name="bugusercheck" datasource="bugTracking" result="checkbuguser">
            select userID from bugusers where bugID = "#tempbugID#";
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
            <cfset teamMemberID = "#bugusercheck.teamMemberID#" />
        <cfelse>
            <cfset teamMemberID = "#form.teamMemberID#" />
        </cfif>   
            
            
            
        
        <cfquery name="updatebug" datasource="bugTracking" result="updatedbug">
            update bugs set
            bugName = <cfqueryparam value="#form.bname#" CFSQLType="CF_SQL_VARCHAR">,
            bugDescription = <cfqueryparam value="#form.bugdes#" CFSQLType="CF_SQL_VARCHAR">,
            actualStartDate = <cfqueryparam value="#form.asd#" CFSQLType="CF_SQL_DATE">,
            actualEndDate = <cfqueryparam value="#form.aed#" CFSQLType="CF_SQL_DATE">,
            statusID = <cfqueryparam value="#statusID#" CFSQLType="CF_SQL_TINYINT">,
            priorityID = <cfqueryparam value="#priorityID#" CFSQLType="CF_SQL_TINYINT">,
            severityID = <cfqueryparam value="#severityID#" CFSQLType="CF_SQL_TINYINT"> 
           where bugID="#tempbugID#";
        </cfquery>
           
                
         <cfquery name="updatebugUser" datasource="bugTracking" result="updatedbuguser">
            update bugusers set
            userID= <cfqueryparam value="#form.teamMemberID#" CFSQLType="CF_SQL_TINYINT" >  
           where bugID="#tempbugID#";
        </cfquery>
              <cfif updatedbug.recordcount eq 1 and updatedbuguser.recordcount eq 1>
            <cfoutput>update successfully</cfoutput> <cfelse>
                
            <cfoutput>update failed</cfoutput> 
            </cfif>
            
                
                
              </cffunction>
            