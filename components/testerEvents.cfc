component {
    url.returnformat="json";
    remote function getEvents()
    {
        var qp=new query();
        qp.setDatasource("bugTracking"); 
        qp.setSQL("select p.projectID, p.projectName, p.estimatedEndDate from projects p inner join projectUsers pu where p.projectID=pu.projectID and pu.userID="&Session.userID&" and p.statusID=5");
        var dbresultsProjects=qp.execute().getResult();
        var results=[];
        for(var i=1;i LTE dbresultsProjects.recordCount;i++)
        {
            arrayAppend(results,{
                "title"=dbresultsProjects.projectName[i],
                "start"=dbresultsProjects.estimatedEndDate[i],
                "url"="projectProfile.cfm?bid="&dbresultsProjects.projectID[i]
            });
        }
        var qb=new query();
        qb.setDatasource("bugTracking"); 
        qb.setSQL("select b.bugID, b.bugName, b.estimatedEndDate from bugs b inner join projectUsers pu where b.projectID=pu.projectID and pu.userID="&Session.userID&" and b.statusID=5");
        var dbresultsBugs=qb.execute().getResult();
        for(var j=1;j LTE dbresultsBugs.recordCount;j++)
        {
            arrayAppend(results,{
                "title"=dbresultsBugs.bugName[j],
                "start"=dbresultsBugs.estimatedEndDate[j],
                "url"="projectProfile.cfm?bid="&dbresultsBugs.bugID[j],
                "color"="green"
            });
        }
        var qr=new query();
        qr.setDatasource("bugTracking");
        qr.setSQL("select * from remainders where userID="&Session.userID&" and hide=0");
        var dbresultsRemainders=qr.execute().getResult();
        for(var k=1;k LTE dbresultsRemainders.recordCount;k++)
        {
            arrayAppend(results,{
                "title"=dbresultsRemainders.name[k],
                "start"=dbresultsRemainders.date[k],
                "url"="remainders.cfm?remainderID="&dbresultsRemainders.remainderID[k],
                "color"="orange"
            });
        }
        return results;
    }
}