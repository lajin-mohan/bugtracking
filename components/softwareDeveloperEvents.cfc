component {
    url.returnformat="json";
    remote function getEvents()
    {
        var qb=new query();
        qb.setDatasource("bugTracking"); 
        qb.setSQL("select b.bugName, b.bugID, b.estimatedEndDate from bugs b inner join bugUsers bu where b.bugID=bu.bugID and bu.userID="&Session.userID);
        var dbresultsBugs=qb.execute().getResult();
        var results=[];
        for(var i=1;i LTE dbresultsBugs.recordCount;i++)
        {
            arrayAppend(results,{
                "title"=dbresultsBugs.bugName[i],
                "start"=dbresultsBugs.estimatedEndDate[i],
                "url"="bugview.cfm?bid="&dbresultsBugs.bugID[i]
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