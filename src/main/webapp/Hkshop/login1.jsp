<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HKShop - Login</title>
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
	<% String error = request.getParameter("error");
   if ("1".equals(error)) { %>
    <p style="color:red;">❌ Wrong username or password.</p>
<% } else if ("2".equals(error)) { %>
    <p style="color:red;">🔒 Access denied. Please login as admin.</p>
<% } %>
<div class="login-box">

    <h1>🛒 HKShop</h1>
    <p class="subtitle" style="color:#607d7b; margin-bottom:20px;">
        Your premium electronics store
    </p>
    <hr>

    <%-- Messages --%>
    
    <% String success = request.getParameter("success");
       if ("1".equals(success)) { %>
        <p style="color:green;">✅ Account created! Please login.</p>
    <% } %>

    <%-- Form --%>
    <form action="/hamza/servletlogin" method="post">
        <div style="text-align:left; margin-bottom:8px;">
            <span style="font-size:0.8rem; font-weight:700; color:#00695c;
                         text-transform:uppercase; letter-spacing:1px;">
                Username
            </span>
        </div>
        <input type="text" name="username" placeholder="Enter your username">

        <div style="text-align:left; margin: 15px 0 8px;">
            <span style="font-size:0.8rem; font-weight:700; color:#00695c;
                         text-transform:uppercase; letter-spacing:1px;">
                Password
            </span>
        </div>
        <input type="password" name="password" placeholder="Enter your password">

        <div style="margin-top:20px;">
            <input type="submit" value="Login →">
        </div>
    </form>

    <br>
    <p style="color:#607d7b; font-size:0.88rem;">
        Don't have an account?
        <a href="/hamza/Hkshop/register.jsp">Register here</a>
    </p>

</div>

</body>
</html>