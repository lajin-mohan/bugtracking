component {
    url.returnformat="json";
    remote function getEvents()
    {
        var qp=new query();
        qp.setDatasource("bugTracking"); 
        qp.setSQL("select p.projectID, p.projectName, p.estimatedEndDate from projects p inner join projectUsers pu where p.projectID=pu.projectID and pu.userID="&Session.userID&" and isLead=1");
        var dbresultsProjects=qp.execute().getResult();
        var results=[];
        for(var i=1;i LTE dbresultsProjects.recordCount;i++)
        {
            arrayAppend(results,{
                "title"=dbresultsProjects.projectName[i],
                "start"=dbresultsProjects.estimatedEndDate[i],
                "url"="projectDetailsView.cfm?pid="&dbresultsProjects.projectID[i]
            });
        }
        var qb=new query();
        qb.setDatasource("bugTracking"); 
        qb.setSQL("select bugName, bugID, estimatedEndDate from bugs where ownerID="&Session.userID);
        var dbresultsBugs=qb.execute().getResult();
        for(var k=1;k LTE dbresultsBugs.recordCount;k++)
        {
            arrayAppend(results,{
                "title"=dbresultsBugs.bugName[k],
                "start"=dbresultsBugs.estimatedEndDate[k],
                "url"="bugview.cfm?bid="&dbresultsBugs.bugID[k],
                "color"="green"
            });
        }
        var qr=new query();
        qr.setDatasource("bugTracking");
        qr.setSQL("select * from remainders where userID="&Session.userID&" and hide=0");
        var dbresultsRemainders=qr.execute().getResult();
        for(var j=1;j LTE dbresultsRemainders.recordCount;j++)
        {
            arrayAppend(results,{
                "title"=dbresultsRemainders.name[j],
                "start"=dbresultsRemainders.date[j],
                "url"="remainders.cfm?remainderID="&dbresultsRemainders.remainderID[j],
                "color"="orange"
            });
        }
        return results;
    }
}