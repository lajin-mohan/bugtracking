<!---
            Bug Tracker - Login CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfobject name="loginObject" component="components.user">
<!DOCTYPE html>
<html>
    <head>
        <title>Error Page</title>
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
        <link href="assets/styles.css" rel="stylesheet" media="screen">
        <script src="js/vendor/modernizr-2.6.2-respond-1.1.0.min.js"></script>
    </head>
    <body id="login">
        <br/><br/><br/><br/>
        <div class="container">
            <div class="row-fluid">
                <div class="page-header">
                    <center>
                        <h1>OOPS!</h1>
                        <small>There has been some problem. Please try again later</small>
                    </center>
                </div>
            </div>
        </div>
<cfinclude template="layouts/footer.cfm">
