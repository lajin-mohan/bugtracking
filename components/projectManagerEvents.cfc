component {
    url.returnformat="json";
    remote function getEvents()
    {
        var qp=new query();
        qp.setDatasource("bugTracking");
        qp.setSQL("select projectName, estimatedEndDate, projectID from projects where statusID!=6 and userID="&Session.userID);
        var dbresultsProjects=qp.execute().getResult();
        var results=[];
        for(var i=1;i LTE dbresultsProjects.recordCount;i++)
        {
            arrayAppend(results,{
                "title"=dbresultsProjects.projectName[i],
                "start"=dbresultsProjects.estimatedEndDate[i],
                "url"="projectProfile.cfm?projectID="&dbresultsProjects.projectID[i]
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
        var qm=new query();
        qm.setDatasource("bugTracking");
        qm.setSQL("select m.milestoneID, m.projectID, m.milestoneName, m.milestoneDate from milestones m inner join projects p where m.projectID=p.projectID and p.userID="&Session.userID&" and milestoneHide=0");
        var dbresultsMilestones=qm.execute().getResult();
        for(var k=1;k LTE dbresultsMilestones.recordCount;k++)
        {
            arrayAppend(results,{
                "title"=dbresultsMilestones.milestoneName[k],
                "start"=dbresultsMilestones.milestoneDate[k],
                "url"="milestones.cfm?milestoneID="&dbresultsMilestones.milestoneID[k],
                "color"="green"
            });
        }
        return results;
    }
}