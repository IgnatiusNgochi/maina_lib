<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>
    <head>
        <title> Login Page</title>
        <link href="${contextPath}/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="${contextPath}/assets/vegas/css/vegas.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container-fluid">
            <div class="row" style="height:100%" id="slide">
                <!--open row-->
                <div class="panel panel-default col-sm-6 col-md-4 col-md-offset-4" style="margin-top:10%">
                    <div class="panel-body">
                        <h1 class="text-center login-title">Login</h1>
                        <div class="clearfix"></div>
                        <div class="account-wall">
                            <img class="profile-img" src="" alt="">
                            <form class="form-signin" action="j_security_check" method="post">
                                <input type="text" class="form-control" placeholder="Email" name="j_username" required autofocus>
                                <br>
                                <input type="password" class="form-control" placeholder="Password" name="j_password" required>
                                <br>
                                <button class="btn btn-lg btn-primary btn-block" type="submit">
                                Sign in</button>
                                <label class="checkbox pull-left">
                                <input type="checkbox" value="remember-me">
                                Remember me
                                </label>
                                <a href="#" class="pull-right need-help">Need help? </a><span class="clearfix"></span>
                            </form>
                        </div>
                        <!--a href="#" class="text-center new-account">Create an account </a>-->
                    </div>
                    <!--closes panel body-->
                    <div class="panel-footer"> Maina Library Sys &#169 2015 </div>
                </div>
            </div>
            <!--close row-->
        </div>
        <!--close div-->
        <script src="${contextPath}/assets/js/jquery.js"> </script>
        <script src="${contextPath}/assets/vegas/js/vegas.min.js"> </script>
        <!-- <script src="${contextPath}/assets/bootstrap/js/bootstrap.min.js"> </script>-->
        <script>
            $('#slide').vegas({
              timer: false,
              shuffle: true,
            transition: [ 'fade', 'zoomOut', 'swirlLeft2','swirlRight2','blur2' ],
              transitionDuration: 2000,
                 delay:4000,
              cover:true,
            slides: [
            { src: '${contextPath}/assets/images/login/image4.jpg' },
            { src: '${contextPath}/assets/images/login/image5.jpg' },
            { src: '${contextPath}/assets/images/login/image6.jpg' }
            ]
            });
        </script>
    </body>
</html>

