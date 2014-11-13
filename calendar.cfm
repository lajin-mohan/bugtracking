<!---
            Bug Tracker - Calendar CFM
            October 30, 2014
            Author: CF Freshers 2014
--->
<!DOCTYPE html>
<html>
    
    <head>
        <title>Calendar</title>
        <!-- Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="vendors/fullcalendar/fullcalendar.css" rel="stylesheet" media="screen">
        <link href="assets/styles.css" rel="stylesheet" media="screen">
        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
            <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <script src="vendors/modernizr-2.6.2-respond-1.1.0.min.js"></script>
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
                                    <i class="icon-user"></i><cfoutput>#Session.userName#</cfoutput><i class="caret"></i>
                                </a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <cfoutput><a tabindex="-1" href="userView.cfm?userID=#Session.userID#">Profile</a></cfoutput>
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
                    </div><!--- close of nav-collapse --->
                </div><!--- close of container-fluid --->
            </div><!--- close of navbar-inner --->
        </div><!--- close of navbar navbar-fixed-top --->
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span3" id="sidebar"><!--- sidebar for software engineer --->
                <cfoutput>
                    <ul class="nav nav-list bs-docs-sidenav nav-collapse collapse">        
                    <cfif Session.roleID eq 1>
                        <li class="inactive">
                            <a href="#Session.menu1#"><i class="icon-chevron-right"></i>Home</a>
                        </li>
                        <li class="inactive">
                            <a href="#Session.menu2#"><i class="icon-chevron-right"></i>Projects</a>
                        </li>
                        <li class="inactive">
                            <a href="#Session.menu3#"><i class="icon-chevron-right"></i>Time Sheet</a>
                        </li>
                        <li class="active">
                            <a href="#Session.menu4#"><i class="icon-chevron-right"></i>Calendar</a>
                        </li>
                        <li class="inactive">
                            <a href="#Session.menu5#"><i class="icon-chevron-right"></i>Employees</a>
                        </li>
                        <li class="inactive">
                            <a href="#Session.menu6#"><i class="icon-chevron-right"></i>History</a>
                        </li>
                        <cfelseif Session.roleID eq 2>
                            <li class="inactive">
                                <a href="#Session.menu1#"><i class="icon-chevron-right"></i>Home</a>
                            </li>
                            <li class="inactive">
                                <a href="#Session.menu2#"><i class="icon-chevron-right"></i>My Projects</a>
                            </li>
                            <li class="inactive">
                                <a href="#Session.menu3#"><i class="icon-chevron-right"></i>Time Sheet</a>
                            </li>
                            <li class="active">
                                <a href="#Session.menu4#"><i class="icon-chevron-right"></i>Calendar</a>
                            </li>
                            <li class="inactive">
                                <a href="#Session.menu5#"><i class="icon-chevron-right"></i>Team Members</a>
                            </li>
                            <li class="inactive">
                                <a href="#Session.menu6#"><i class="icon-chevron-right"></i>History</a>
                            </li>
                        <cfelseif Session.roleID eq 3>
                            <li class="inactive">
                                <a href="#Session.menu1#"><i class="icon-chevron-right"></i>Home</a>
                            </li>
                            <li class="inactive">
                                <a href="#Session.menu2#"><i class="icon-chevron-right"></i>My Bugs</a>
                            </li>
                            <li class="inactive">
                                <a href="#Session.menu3#"><i class="icon-chevron-right"></i>Time Sheet</a>
                            </li>
                            <li class="active">
                                <a href="#Session.menu4#"><i class="icon-chevron-right"></i>Calendar</a>
                            </li>
                            <li class="inactive">
                                <a href="#Session.menu5#"><i class="icon-chevron-right"></i>Team Members</a>
                            </li>
                            <li class="inactive">
                                <a href="#Session.menu6#"><i class="icon-chevron-right"></i>History</a>
                            </li>
                        <cfelseif Session.roleID eq 4>
                            <li class="inactive">
                                <a href="#Session.menu1#"><i class="icon-chevron-right"></i>Home</a>
                            </li>
                            <li class="inactive">
                                <a href="#Session.menu2#"><i class="icon-chevron-right"></i>My Projects</a>
                            </li>
                            <li class="inactive">
                                <a href="#Session.menu3#"><i class="icon-chevron-right"></i>Time Sheet</a>
                            </li>
                            <li class="active">
                                <a href="#Session.menu4#"><i class="icon-chevron-right"></i>Calendar</a>
                            </li>
                            <li class="inactive">
                                <a href="#Session.menu5#"><i class="icon-chevron-right"></i>Team Members</a>
                            </li>
                            <li class="inactive">
                                <a href="#Session.menu6#"><i class="icon-chevron-right"></i>History</a>
                            </li>
                    </cfif>
                    </ul>
                </cfoutput>
            </div><!--- close of sidebar --->
            <cfif Session.roleID eq 1>
                    <div class="row-fluid">
                        <div class="span9" id="content">
                            <div class="row-fluid">
                                <div class="navbar navbar-inner block-header"></div>
                                <br/><br/>
                                <div id='calendar'></div>
                            </div>
                        </div>
                    </div>
                    <div class="fc-day-number" style="visibility:hidden" onload="return retrieveDate()"></div>
                    <hr/>
                    <footer>
                        <p>&copy;Techversant Infotech 2014</p>
                    </footer>
                </div>
                <script src="vendors/jquery-1.9.1.min.js"></script>
                <script src="vendors/jquery-ui-1.10.3.js"></script>
                <script src="bootstrap/js/bootstrap.min.js"></script>
                <script src="vendors/fullcalendar/fullcalendar.js"></script>
                <script src="vendors/fullcalendar/gcal.js"></script>
                <script src="assets/scripts.js"></script>
                <script>
                    $(document).ready(function() {
                        $("#calendar").fullCalendar({
                            //Formating
                            header: {
                                left: 'prev,next',
                                right: '',
                                center: 'title'
                            },
                            titleFormat: {
                                month: 'MMMM yyyy',
                                week: 'MMMM d[ yyyy] - {[ MMM] d, yyyy}',
                                day: 'dddd, MMMM dd, yyyy'
                            },
                            columnFormat: {
                                month: 'dddd',
                                week: 'dddd <br> MM/dd',
                                day: 'dddd, MMMM dd, yyyy'
                            },
                            timeFormat: {
                                '': 'H(:mm) TT \n '
                            },
                            selectable: true,
                            selectHelper: true,
                            select: function(start, end, allDay) {
                                var title = prompt('Event Title:');
                                if (title) {
                                    $('#calendar').fullCalendar('renderEvent',
                                        {
                                            title: title,
                                            start: start,
                                            end: end,
                                            allDay: allDay
                                        },
                                        true // make the event "stick"
                                    );
                                    
                                }
                                $('#calendar').fullCalendar('unselect');
                            },
                            //Data Feed
                            events:'components/projectManagerEvents.cfc?method=getEvents&returnformat=json',
                            editable: false,
                            weekMode:'variable',
                            ignoreTimezone:false        
                        });
                    });
                </script>
                <cfelseif Session.roleID eq 2>
                        <div class="row-fluid">
                            <div class="span9" id="content">
                                <div class="row-fluid">
                                    <!-- block -->
                                    <div class="block">
                                        <div class="navbar navbar-inner block-header"></div>
                                        <div class="span10">
                                            <div id='calendar'></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="fc-day-number" style="visibility:hidden" onload="return retrieveDate()"></div>
                        <hr/>
                        <footer>
                            <p>&copy;Techversant Infotech 2014</p>
                        </footer>
                    </div>
                    <script src="vendors/jquery-1.9.1.min.js"></script>
                    <script src="vendors/jquery-ui-1.10.3.js"></script>
                    <script src="bootstrap/js/bootstrap.min.js"></script>
                    <script src="vendors/fullcalendar/fullcalendar.js"></script>
                    <script src="vendors/fullcalendar/gcal.js"></script>
                    <script src="assets/scripts.js"></script>
                    <script>
                        $(document).ready(function() {
                            $("#calendar").fullCalendar({
                                //Formating
                                header: {
                                    right: 'prev,next today',
                                    left: 'title',
                                    center: 'month,agendaWeek,agendaDay'
                                },
                                titleFormat: {
                                    month: 'MMMM yyyy',
                                    week: 'MMMM d[ yyyy] - {[ MMM] d, yyyy}',
                                    day: 'dddd, MMMM dd, yyyy'
                                },
                                columnFormat: {
                                    month: 'dddd',
                                    week: 'dddd <br> MM/dd',
                                    day: 'dddd, MMMM dd, yyyy'
                                },
                                timeFormat: {
                                    '': 'H(:mm) TT \n '
                                },
                                //Click function to switch to daily agenda
                                dayClick: function(date, view) {
                                    $('#calendar')
                                    .fullCalendar('changeView', 'agendaDay')
                                    .fullCalendar('gotoDate', date);
                                },
                                //Data Feed
                                events:'components/calendarEvents.cfc?method=getEvents&returnformat=json&projectLead',
                                editable: false,
                                weekMode:'variable',
                                ignoreTimezone:false        
                            });
                        });
                        
                    </script>
                    <cfelseif Session.roleID eq 3>
                            <div class="row-fluid">
                            <div class="span9" id="content">
                                <div class="row-fluid">
                                    <!-- block -->
                                    <div class="block">
                                        <div class="navbar navbar-inner block-header"></div>
                                        <div class="span10">
                                            <div id='calendar'></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="fc-day-number" style="visibility:hidden" onload="return retrieveDate()"></div>
                        <hr/>
                        <footer>
                            <p>&copy;Techversant Infotech 2014</p>
                        </footer>
                    </div>
                    <script src="vendors/jquery-1.9.1.min.js"></script>
                    <script src="vendors/jquery-ui-1.10.3.js"></script>
                    <script src="bootstrap/js/bootstrap.min.js"></script>
                    <script src="vendors/fullcalendar/fullcalendar.js"></script>
                    <script src="vendors/fullcalendar/gcal.js"></script>
                    <script src="assets/scripts.js"></script>
                    <script>
                        $(document).ready(function() {
                            $("#calendar").fullCalendar({
                                //Formating
                                header: {
                                    right: 'prev,next today',
                                    left: 'title',
                                    center: 'month,agendaWeek,agendaDay'
                                },
                                titleFormat: {
                                    month: 'MMMM yyyy',
                                    week: 'MMMM d[ yyyy] - {[ MMM] d, yyyy}',
                                    day: 'dddd, MMMM dd, yyyy'
                                },
                                columnFormat: {
                                    month: 'dddd',
                                    week: 'dddd <br> MM/dd',
                                    day: 'dddd, MMMM dd, yyyy'
                                },
                                timeFormat: {
                                    '': 'H(:mm) TT \n '
                                },
                                //Click function to switch to daily agenda
                                dayClick: function(date, view) {
                                    $('#calendar')
                                    .fullCalendar('changeView', 'agendaDay')
                                    .fullCalendar('gotoDate', date);
                                },
                                //Data Feed
                                events:'components/calendarEvents.cfc?method=getEvents&returnformat=json&softwareDeveloper',
                                editable: false,
                                weekMode:'variable',
                                ignoreTimezone:false        
                            });
                        });
                    </script>
                    <cfelseif Session.roleID eq 4>
                            <div class="row-fluid">
                                <div class="span9" id="content">
                                    <div class="row-fluid">
                                        <!-- block -->
                                        <div class="block">
                                            <div class="navbar navbar-inner block-header"></div>
                                            <div class="span10">
                                                <div id='calendar'></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="fc-day-number" style="visibility:hidden" onload="return retrieveDate()"></div>
                            <hr/>
                            <footer>
                                <p>&copy;Techversant Infotech 2014</p>
                            </footer>
                        </div>
                        <script src="vendors/jquery-1.9.1.min.js"></script>
                        <script src="vendors/jquery-ui-1.10.3.js"></script>
                        <script src="bootstrap/js/bootstrap.min.js"></script>
                        <script src="vendors/fullcalendar/fullcalendar.js"></script>
                        <script src="vendors/fullcalendar/gcal.js"></script>
                        <script src="assets/scripts.js"></script>
                        <script>
                            $(document).ready(function() {
                                $("#calendar").fullCalendar({
                                    //Formating
                                    header: {
                                        right: 'prev,next today',
                                        left: 'title',
                                        center: 'month,agendaWeek,agendaDay'
                                    },
                                    titleFormat: {
                                        month: 'MMMM yyyy',
                                        week: 'MMMM d[ yyyy] - {[ MMM] d, yyyy}',
                                        day: 'dddd, MMMM dd, yyyy'
                                    },
                                    columnFormat: {
                                        month: 'dddd',
                                        week: 'dddd <br> MM/dd',
                                        day: 'dddd, MMMM dd, yyyy'
                                    },
                                    timeFormat: {
                                        '': 'H(:mm) TT \n '
                                    },
                                    //Click function to switch to daily agenda
                                    dayClick: function(date, view) {
                                        $('#calendar')
                                        .fullCalendar('changeView', 'agendaDay')
                                        .fullCalendar('gotoDate', date);
                                    },
                                    //Data Feed
                                    events:'components/calendarEvents.cfc?method=getEvents&returnformat=json&tester',
                                    editable: false,
                                    weekMode:'variable',
                                    ignoreTimezone:false        
                                });
                            });
                        </script>
            </cfif>
        <style>
        #external-events {
            float: left;
            width: 150px;
            padding: 0 10px;
            border: 1px solid #ccc;
            background: #eee;
            text-align: left;
            }
            
        #external-events h4 {
            font-size: 16px;
            margin-top: 0;
            padding-top: 1em;
            }
            
        .external-event { /* try to mimick the look of a real event */
            margin: 10px 0;
            padding: 2px 4px;
            background: #3366CC;
            color: #fff;
            font-size: .85em;
            cursor: pointer;
            z-index: 99999999;
            }
            
        #external-events p {
            margin: 1.5em 0;
            font-size: 11px;
            color: #666;
            }
            
        #external-events p input {
            margin: 0;
            vertical-align: middle;
            }

        </style>
    </body>
</html>
