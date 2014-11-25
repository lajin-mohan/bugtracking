<!---
            Bug Tracker - Header CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<!DOCTYPE html>
<cfif isnull(Session.userID)>
    <cflocation url="index.cfm" addtoken="false">
</cfif>
<html class="no-js">

<head>
    <title>Bug Tracker</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
    <link href="vendors/easypiechart/jquery.easy-pie-chart.css" rel="stylesheet" media="screen">
    <link href="assets/styles.css" rel="stylesheet" media="screen">
    <script src="vendors/modernizr-2.6.2-respond-1.1.0.min.js"></script>
    <script src="vendors/jquery-1.9.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script src="vendors/easypiechart/jquery.easy-pie-chart.js"></script>
    <script src="assets/scripts.js"></script>
    <script src="http://cdn.jsdelivr.net/webshim/1.12.4/extras/modernizr-custom.js"></script>
    <script src="http://cdn.jsdelivr.net/webshim/1.12.4/polyfiller.js"></script>
    <link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css" />
    <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
      <script src="//code.jquery.com/jquery-1.9.1.js"></script>
  <script src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>
<script src="http://jqueryvalidation.org/files/dist/jquery.validate.min.js"></script>
<script src="http://jqueryvalidation.org/files/dist/additional-methods.min.js"></script>
    <script src="assets/customScript.js"></script>
    <script>
        $(document).ready(function () {
            $("#edit_pwd").hide();
            $("#but").click(function () {
                $("#edit_pwd").toggle();
            });
            $('.btn-danger').click(function () {
                if (confirm('Are you sure you want to delete?'))
                    return true;
                else
                    return false;
            });
        });
    </script>
    <script>
        webshims.setOptions('waitReady', false);
        webshims.setOptions('forms-ext', {
            types: 'date'
        });
        webshims.polyfill('forms forms-ext');
    </script>
</head>

<body>
    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container-fluid">
                <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <a class="brand" href="#">Techversant Infotech</a>
                <div class="nav-collapse collapse">
                    <ul class="nav pull-right">
                        <li class="dropdown">
                            <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="icon-user"></i>
                                <cfoutput>#Session.userName#</cfoutput><i class="caret"></i>
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <cfoutput><a tabindex="-1" href="userView.cfm?userID=#Session.userID#">Profile</a>
                                    </cfoutput>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a tabindex="-1" href="logout.cfm">Logout</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <ul class="nav">
                        <li class="active">
                            <a href="projectManager.cfm">Bug Tracker</a>
                        </li>
                    </ul>
                </div>
                <!--- close of nav-collapse --->
            </div>
            <!--- close of container-fluid --->
        </div>
        <!--- close of navbar-inner --->
    </div>
    <!--- close of navbar navbar-fixed-top --->
