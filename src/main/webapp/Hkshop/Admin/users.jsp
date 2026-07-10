<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,bean.*,DB.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HKShop - Manage Users</title>
<link rel="stylesheet" href="/hamza/Hkshop/css/admin.css">
<style>
    body { display:flex; flex-direction:column; min-height:100vh;
           background:#f0f4f0; font-family:'DM Sans',sans-serif; }
    .layout { display:flex; flex:1; }
    .topbar {
        background:linear-gradient(135deg,#1b5e20,#2e7d32);
        color:white; padding:0 25px;
        display:flex; justify-content:space-between;
        align-items:center; height:60px;
        box-shadow:0 2px 10px rgba(0,0,0,0.2);
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
    .main { flex:1; padding:30px; overflow-x:auto; }
    .page-header { margin-bottom:25px; }
    .page-header h1 {
        font-family:'Space Mono',monospace; font-size:1.4rem;
        color:#1b5e20; margin-bottom:5px;
    }
    .page-header p { color:#607d60; font-size:0.88rem; margin:0; }

    /* Table */
    .data-table {
        width:100%; border-collapse:collapse;
        background:white; border-radius:12px;
        overflow:hidden; box-shadow:0 2px 15px rgba(0,0,0,0.08);
        border:1px solid #c8e6c9;
    }
    .data-table th {
        background:linear-gradient(135deg,#1b5e20,#2e7d32);
        color:white; padding:13px 16px;
        text-align:left; font-size:0.8rem;
        font-weight:700; letter-spacing:0.5px;
        border-right:1px solid rgba(255,255,255,0.1);
    }
    .data-table th:last-child { border-right:none; }
    .data-table td {
        padding:12px 16px;
        border-bottom:1px solid #e8f5e9;
        border-right:1px solid #e8f5e9;
        font-size:0.88rem; vertical-align:middle;
    }
    .data-table td:last-child { border-right:none; }
    .data-table tr:last-child td { border-bottom:none; }
    .data-table tr:hover td { background:#f1f8e9; }

    /* Role badge */
    .badge-admin {
        background:#fff8e1; color:#f57f17;
        border:1px solid #ffcc02; padding:3px 10px;
        border-radius:12px; font-size:0.75rem; font-weight:700;
    }
    .badge-customer {
        background:#e8f5e9; color:#2e7d32;
        border:1px solid #a5d6a7; padding:3px 10px;
        border-radius:12px; font-size:0.75rem; font-weight:700;
    }

    /* Buttons in table */
    .btn-edit {
        background:linear-gradient(135deg,#1565c0,#1976d2);
        color:white; border:none; border-radius:20px;
        padding:6px 14px; font-size:0.78rem; font-weight:700;
        cursor:pointer; text-decoration:none;
        display:inline-block; transition:all 0.2s;
    }
    .btn-edit:hover { background:linear-gradient(135deg,#1976d2,#42a5f5);
        color:white; }
    .btn-delete {
        background:linear-gradient(135deg,#b71c1c,#e53935);
        color:white; border:none; border-radius:20px;
        padding:6px 14px; font-size:0.78rem; font-weight:700;
        cursor:pointer; transition:all 0.2s; width:auto;
        margin-top:0;
    }
    .btn-delete:hover { background:linear-gradient(135deg,#e53935,#ef9a9a); }

    /* Add button */
    .btn-add {
        background:linear-gradient(135deg,#1b5e20,#2e7d32);
        color:white; padding:10px 20px; border-radius:8px;
        font-size:0.88rem; font-weight:700;
        text-decoration:none; display:inline-block;
        margin-bottom:20px; transition:all 0.2s;
        border:none; cursor:pointer;
    }
    .btn-add:hover { background:linear-gradient(135deg,#2e7d32,#4caf50);
        color:white; text-decoration:none; }

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
    Usdao dao = new Usdao();
    List<User> users = dao.getallusers();
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
            <h1>👥 Manage Users</h1>
            <p>View, edit and delete customer accounts</p>
        </div>

        <a href="/hamza/Hkshop/register.jsp" class="btn-add">
            ➕ Add New User
        </a>

        <table class="data-table">
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Role</th>
                <th>Edit</th>
                <th>Delete</th>
            </tr>
            <% for (int i = 0; i < users.size(); i++) {
                   User listUser = users.get(i); %>
            <tr>
                <td style="color:#9e9e9e; font-size:0.82rem;">
                    #<%= listUser.getId() %>
                </td>
                <td style="font-weight:700; color:#1b5e20;">
                    <%= listUser.getUsername() %>
                </td>
                <td style="color:#607d60;">
                    <%= listUser.getEmail() %>
                </td>
                <td>
                    <% if ("admin".equals(listUser.getRole())) { %>
                        <span class="badge-admin">⭐ Admin</span>
                    <% } else { %>
                        <span class="badge-customer">👤 Customer</span>
                    <% } %>
                </td>
                <td>
                    <a href="editUser.jsp?username=<%= listUser.getUsername() %>"
                       class="btn-edit">Edit</a>
                </td>
                <td>
                    <form action="/hamza/AdminServlet" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="username"
                               value="<%= listUser.getUsername() %>">
                        <input type="submit" value="Delete"
                               class="btn-delete">
                    </form>
                </td>
            </tr>
            <% } %>
        </table>

    </div>
</div>

<div class="footer">
    © 2026 <span>HKShop Admin</span> —
    Developed by <span>Hamza Khaldi</span>
</div>

</body>
</html>