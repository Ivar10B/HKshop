<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HKShop - Register</title>
<link rel="stylesheet" href="/hamza/Hkshop/css/customer.css">
<style>
    body {
        background: linear-gradient(135deg, #e0f7f4 0%, #fce4ec 100%);
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
    }
</style>
</head>
<body>

<div class="register-box">

    <h1>🛒 HKShop</h1>
    <p style="color:#607d7b; margin-bottom:20px;">
        Create your account — it's free!
    </p>
    <hr>

    <%-- Error messages --%>
    <%
    String error = request.getParameter("error");
    if ("1".equals(error)) { %>
        <p style="color:red;">❌ Passwords do not match. Try again.</p>
    <% } else if ("2".equals(error)) { %>
        <p style="color:red;">❌ Registration failed. Try again later.</p>
    <% } %>

    <%-- Form --%>
    <form action="/hamza/registerservlet" method="post">

        <div style="text-align:left; margin-bottom:8px;">
            <span style="font-size:0.8rem; font-weight:700; color:#00695c;
                         text-transform:uppercase; letter-spacing:1px;">
                Username
            </span>
        </div>
        <input type="text" name="username" placeholder="Choose a username">

        <div style="text-align:left; margin: 15px 0 8px;">
            <span style="font-size:0.8rem; font-weight:700; color:#00695c;
                         text-transform:uppercase; letter-spacing:1px;">
                Email
            </span>
        </div>
        <input type="text" name="email" placeholder="Enter your email">

        <div style="text-align:left; margin: 15px 0 8px;">
            <span style="font-size:0.8rem; font-weight:700; color:#00695c;
                         text-transform:uppercase; letter-spacing:1px;">
                Password
            </span>
        </div>
        <input type="password" name="password" placeholder="Create a password">

        <div style="text-align:left; margin: 15px 0 8px;">
            <span style="font-size:0.8rem; font-weight:700; color:#00695c;
                         text-transform:uppercase; letter-spacing:1px;">
                Confirm Password
            </span>
        </div>
        <input type="password" name="confirmPassword" placeholder="Repeat your password">

        <div style="margin-top:20px;">
            <input type="submit" value="Create Account →">
        </div>

    </form>

    <br>
    <p style="color:#607d7b; font-size:0.88rem;">
        Already have an account?
        <a href="/hamza/Hkshop/login1.jsp">Login here</a>
    </p>

</div>

</body>
</html>