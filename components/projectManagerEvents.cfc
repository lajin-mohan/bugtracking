component {
    url.returnformat="json";
    remote function getEvents()
    {
        var q=new query();
        q.setDatasource("bugTracking"); 
        q.setSQL("select projectName, estimatedEndDate, projectID from projects");
        var dbresults=q.execute().getResult();
        var results=[];
        for(var i=1;i<= dbresults.recordCount;i++)
        {
            arrayAppend(results,{
                "title"=dbresults.projectName[i],
                "start"=dbresults.estimatedEndDate[i],
                "url"="projectProfile.cfm?projectID="&dbresults.projectID[i]
            });
        }
        return results;
    }
}