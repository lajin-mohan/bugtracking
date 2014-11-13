<!---
            Bug Tracker - Login CFM
            October 30, 2014
            Author: CF Freshers 2014
--->

<cfobject name="loginObject" component="components.user">
<!DOCTYPE html>
<html>
    <head>
        <title>Bug Tracker Login</title>
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
        <link href="assets/styles.css" rel="stylesheet" media="screen">
        <script src="js/vendor/modernizr-2.6.2-respond-1.1.0.min.js"></script>
    </head>
    <body id="login">
        <div class="container">
            <form class="form-signin" action="index.cfm" method="post" name="signIn">
                <h2 class="form-signin-heading">BUG TRACKER</h2>
                <input name="email" type="text" class="input-block-level" placeholder="Email address" required />
                <input name="pass" type="password" class="input-block-level" placeholder="Password" required />
                <input class="btn btn-large btn-primary" type="submit" name="submit" value="Sign in" />
            </form>
            <cfif isDefined('form.submit')>
                <cfoutput>#loginObject.loginCheck()#</cfoutput>
            </cfif>
        </div>
<cfinclude template="layouts/footer.cfm">
