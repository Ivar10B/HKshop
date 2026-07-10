<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,bean.*,DB.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HKShop - Edit User</title>
<link rel="stylesheet" href="/hamza/Hkshop/css/admin.css">
<style>
    body { display:flex; flex-direction:column; min-height:100vh;
           background:#f0f4f0; font-family:'DM Sans',sans-serif; }
    .layout { display:flex; flex:1; }
    .topbar {
        background:linear-gradient(135deg,#1b5e20,#2e7d32);
        padding:0 25px; display:flex;
        justify-content:space-between; align-items:center;
        height:60px; box-shadow:0 2px 10px rgba(0,0,0,0.2);
        position:sticky; top:0; z-index:200;
    }
    .topbar-brand {
        font-family:'Space Mono',monospace; font-size:1.1rem;
        font-weight:700; color:white; letter-spacing:1px;
        display:flex; align-items:center; gap:10px;
    }
    .topbar-brand img {
        height:35px; width:35px; border-radius:6px;
        object-fit:cover; border:2px solid rgba(255,255,255,0.3);
    }
    .topbar-right { display:flex; align-items:center; gap:10px; }
    .topbar-right span { color:rgba(255,255,255,0.8); font-size:0.85rem; }
    .topbar-right a {
        color:white; background:rgba(255,255,255,0.15);
        padding:7px 16px; border-radius:20px;
        font-size:0.82rem; font-weight:600;
        border:1px solid rgba(255,255,255,0.25);
        text-decoration:none; transition:all 0.2s;
    }
    .topbar-right a:hover { background:rgba(255,255,255,0.25); }
    .sidebar {
        width:210px; background:#1a2e1a;
        min-height:100%; padding:25px 0; flex-shrink:0;
    }
    .sidebar-section {
        font-size:0.7rem; font-weight:700; color:#4caf50;
        text-transform:uppercase; letter-spacing:2px;
        padding:0 20px; margin:20px 0 8px;
    }
    .sidebar a {
        display:flex; align-items:center; gap:10px;
        padding:11px 20px; color:#a5d6a7;
        font-size:0.88rem; font-weight:600;
        text-decoration:none; transition:all 0.2s;
        border-left:3px solid transparent;
    }
    .sidebar a:hover, .sidebar a.active {
        background:rgba(76,175,80,0.15); color:#69f0ae;
        border-left-color:#4caf50;
    }
    .sidebar-divider { border:none; border-top:1px solid #2a3e2a; margin:15px 0; }
    .main { flex:1; padding:30px; }
    .page-header { margin-bottom:25px; }
    .page-header h1 {
        font-family:'Space Mono',monospace; font-size:1.4rem;
        color:#1b5e20; margin-bottom:5px;
    }

    /* Form card */
    .form-card {
        background:white; border-radius:14px;
        padding:30px; max-width:480px;
        border:1px solid #c8e6c9;
        box-shadow:0 2px 15px rgba(0,0,0,0.06);
    }
    .field-label {
        display:block; font-size:0.78rem; font-weight:700;
        color:#1b5e20; text-transform:uppercase;
        letter-spacing:1px; margin-bottom:6px; margin-top:16px;
    }
    input[type="text"], input[type="password"], select {
        background:#f1f8e9; border:2px solid #c8e6c9;
        border-radius:8px; color:#1a2e1a;
        padding:10px 14px; font-size:0.9rem;
        font-family:'DM Sans',sans-serif; width:100%;
        transition:all 0.2s;
    }
    input[type="text"]:focus, input[type="password"]:focus, select:focus {
        outline:none; border-color:#4caf50;
        background:white; box-shadow:0 0 0 3px rgba(76,175,80,0.15);
    }
    input[readonly] {
        background:#e8f5e9; color:#607d60; cursor:not-allowed;
    }
    select option { background:white; }
    input[type="submit"] {
        background:linear-gradient(135deg,#1b5e20,#2e7d32);
        color:white; border:none; border-radius:8px;
        padding:12px 28px; font-size:0.9rem;
        font-family:'DM Sans',sans-serif; font-weight:700;
        cursor:pointer; width:100%; margin-top:20px;
        transition:all 0.2s;
    }
    input[type="submit"]:hover {
        background:linear-gradient(135deg,#2e7d32,#4caf50);
        transform:translateY(-1px);
    }
    .back-link {
        display:inline-block; margin-top:15px;
        color:#607d60; font-size:0.85rem;
        text-decoration:none; font-weight:600;
    }
    .back-link:hover { color:#1b5e20; }

    .footer {
        background:#1a2e1a; color:rgba(255,255,255,0.5);
        text-align:center; padding:15px; font-size:0.8rem;
    }
    .footer span { color:#69f0ae; font-weight:700; }
</style>
</head>
<body>

<%
    User u = (User) session.getAttribute("user");
    if (u == null) {
        response.sendRedirect(request.getContextPath() + "/Hkshop/login1.jsp");
        return;
    }
    if (!u.getRole().equals("admin")) {
        response.sendRedirect(request.getContextPath() + "/Hkshop/login1.jsp");
        return;
    }
    String username = request.getParameter("username");
    Usdao dao = new Usdao();
    User editUser = dao.getUserName(username);
    if (editUser == null) {
        response.sendRedirect("users.jsp");
        return;
    }
%>

<%-- Topbar --%>
<div class="topbar">
    <div class="topbar-brand">
        <img src="/hamza/Hkshop/hkshop.png" alt="HKShop">
        HKShop Admin
    </div>
    <div class="topbar-right">
        <span>👤 <%= u.getUsername() %></span>
        <a href="/hamza/LogoutServlet">Logout</a>
    </div>
</div>

<div class="layout">
    <div class="sidebar">
        <div class="sidebar-section">Menu</div>
        <a href="dashboard.jsp">🏠 Dashboard</a>
        <a href="users.jsp" class="active">👥 Users</a>
        <a href="products.jsp">📦 Products</a>
        <a href="orders.jsp">📋 Orders</a>
        <hr class="sidebar-divider">
        <a href="/hamza/LogoutServlet">🚪 Logout</a>
    </div>

    <div class="main">
        <div class="page-header">
            <h1>✏️ Edit User</h1>
        </div>

        <%-- Error message --%>
        <% String error = request.getParameter("error");
           if ("1".equals(error)) { %>
            <p style="color:red; margin-bottom:15px;">
                ❌ Passwords do not match. Try again.
            </p>
        <% } %>

        <div class="form-card">
            <form action="/hamza/AdminServlet" method="post">
                <input type="hidden" name="action" value="update">

                <span class="field-label">Username (cannot change)</span>
                <input type="text" name="username"
                       value="<%= editUser.getUsername() %>" readonly>

                <span class="field-label">New Password</span>
                <input type="password" name="password"
                       value="<%= editUser.getPassword() %>">

                <span class="field-label">Confirm Password</span>
                <input type="password" name="confirmPassword"
                       value="<%= editUser.getPassword() %>">

                <span class="field-label">Email</span>
                <input type="text" name="email"
                       value="<%= editUser.getEmail() %>">

                <span class="field-label">Role</span>
                <select name="role">
                    <option value="customer"
                        <%= "customer".equals(editUser.getRole()) ? "selected" : "" %>>
                        👤 Customer
                    </option>
                    <option value="admin"
                        <%= "admin".equals(editUser.getRole()) ? "selected" : "" %>>
                        ⭐ Admin
                    </option>
                </select>

                <input type="submit" value="Save Changes ✓">
            </form>

            <a href="users.jsp" class="back-link">← Back to Users</a>
        </div>

    </div>
</div>

<div class="footer">
    © 2026 <span>HKShop Admin</span> —
    Developed by <span>Hamza Khaldi</span>
</div>

</body>
</html>