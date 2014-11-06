<!---
            Bug Tracker - Sidebar CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<div class="span3" id="sidebar"><!--- sidebar for software engineer --->
    <cfoutput>
        <ul class="nav nav-list bs-docs-sidenav nav-collapse collapse">        
        <cfif Session.roleID eq 1>
            <li class="#Session.highlight1#">
                <a href="#Session.menu1#"><i class="icon-chevron-right"></i>Home</a>
            </li>
            <li class="#Session.highlight2#">
                <a href="#Session.menu2#"><i class="icon-chevron-right"></i>Projects</a>
            </li>
            <li class="#Session.highlight3#">
                <a href="#Session.menu3#"><i class="icon-chevron-right"></i>Employees</a>
            </li>
            <li class="#Session.highlight4#">
                <a href="#Session.menu4#"><i class="icon-chevron-right"></i>History</a>
            </li>
        
        <cfelseif Session.roleID eq 2>
            <li class="#Session.highlight1#">
                <a href="#Session.menu1#"><i class="icon-chevron-right"></i>Home</a>
            </li>
            <li class="#Session.highlight2#">
                <a href="#Session.menu2#"><i class="icon-chevron-right"></i>Projects</a>
            </li>
            <li class="#Session.highlight3#">
                <a href="#Session.menu3#"><i class="icon-chevron-right"></i>Project Members</a>
            </li>
            <li class="#Session.highlight4#">
                <a href="#Session.menu4#"><i class="icon-chevron-right"></i>History</a>
            </li>

        <cfelseif Session.roleID eq 3>
            <li class="#Session.highlight1#">
                <a href="#Session.menu1#"><i class="icon-chevron-right"></i>Home</a>
            </li>
            <li class="#Session.highlight2#">
                <a href="#Session.menu2#"><i class="icon-chevron-right"></i>Bugs</a>
            </li>
            <li class="#Session.highlight3#">
                <a href="#Session.menu3#"><i class="icon-chevron-right"></i>Employees</a>
            </li>
            <li class="#Session.highlight4#">
                <a href="#Session.menu4#"><i class="icon-chevron-right"></i>History</a>
            </li>
        <cfelseif Session.roleID eq 4>
            <li class="#Session.highlight1#">
                <a href="#Session.menu1#"><i class="icon-chevron-right"></i>Home</a>
            </li>
            <li class="#Session.highlight2#">
                <a href="#Session.menu2#"><i class="icon-chevron-right"></i>Projects</a>
            </li>
            <li class="#Session.highlight3#">
                <a href="#Session.menu3#"><i class="icon-chevron-right"></i>Employees</a>
            </li>
            <li class="#Session.highlight4#">
                <a href="#Session.menu4#"><i class="icon-chevron-right"></i>History</a>
            </li>
        </cfif>
        </ul>
    </cfoutput>
</div><!--- close of sidebar --->
