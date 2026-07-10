<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bean.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HKShop - Admin Dashboard</title>
<link rel="stylesheet" href="/hamza/Hkshop/css/admin.css">
<style>
    /* ── Layout ── */
    body { display:flex; flex-direction:column; min-height:100vh;
           background:#f0f4f0; font-family:'DM Sans',sans-serif; }
    .layout { display:flex; flex:1; }

    /* ── Topbar ── */
    .topbar {
        background:linear-gradient(135deg,#1b5e20,#2e7d32);
        color:white; padding:0 25px;
        display:flex; justify-content:space-between;
        align-items:center; height:60px;
        box-shadow:0 2px 10px rgba(0,0,0,0.2);
        position:sticky; top:0; z-index:200;
    }
    .topbar-brand {
        font-family:'Space Mono',monospace;
        font-size:1.1rem; font-weight:700;
        color:white; letter-spacing:1px;
        display:flex; align-items:center; gap:10px;
    }
    .topbar-brand img {
        height:35px; width:35px; border-radius:6px;
        object-fit:cover; border:2px solid rgba(255,255,255,0.3);
    }
    .topbar-right { display:flex; align-items:center; gap:10px; }
    .topbar-right span {
        color:rgba(255,255,255,0.8); font-size:0.85rem;
    }
    .topbar-right a {
        color:white; background:rgba(255,255,255,0.15);
        padding:7px 16px; border-radius:20px;
        font-size:0.82rem; font-weight:600;
        border:1px solid rgba(255,255,255,0.25);
        text-decoration:none; transition:all 0.2s;
    }
    .topbar-right a:hover {
        background:rgba(255,255,255,0.25);
    }

    /* ── Sidebar ── */
    .sidebar {
        width:210px; background:#1a2e1a;
        min-height:100%; padding:25px 0;
        flex-shrink:0;
    }
    .sidebar-section {
        font-size:0.7rem; font-weight:700;
        color:#4caf50; text-transform:uppercase;
        letter-spacing:2px; padding:0 20px;
        margin:20px 0 8px;
    }
    .sidebar a {
        display:flex; align-items:center; gap:10px;
        padding:11px 20px; color:#a5d6a7;
        font-size:0.88rem; font-weight:600;
        text-decoration:none; transition:all 0.2s;
        border-left:3px solid transparent;
    }
    .sidebar a:hover, .sidebar a.active {
        background:rgba(76,175,80,0.15);
        color:#69f0ae;
        border-left-color:#4caf50;
    }
    .sidebar-divider {
        border:none; border-top:1px solid #2a3e2a;
        margin:15px 0;
    }

    /* ── Main Content ── */
    .main { flex:1; padding:30px; overflow-x:auto; }

    /* ── Page Header ── */
    .page-header {
        margin-bottom:25px;
    }
    .page-header h1 {
        font-family:'Space Mono',monospace;
        font-size:1.4rem; color:#1b5e20;
        margin-bottom:5px;
    }
    .page-header p { color:#607d60; font-size:0.88rem; margin:0; }

    /* ── Dashboard Cards ── */
    .dash-grid {
        display:grid;
        grid-template-columns:repeat(2,1fr);
        gap:16px; max-width:550px;
        margin-bottom:30px;
    }
    .dash-card {
        background:white;
        border-radius:12px;
        padding:25px 20px;
        border:2px solid #c8e6c9;
        box-shadow:0 2px 10px rgba(0,0,0,0.06);
        text-align:center;
        text-decoration:none;
        display:block;
        transition:all 0.2s;
    }
    .dash-card:hover {
        border-color:#4caf50;
        background:#f1f8e9;
        transform:translateY(-3px);
        box-shadow:0 6px 20px rgba(76,175,80,0.2);
        text-decoration:none;
    }
    .dash-card .icon { font-size:2.2rem; margin-bottom:10px; }
    .dash-card .title {
        font-family:'Space Mono',monospace;
        font-size:0.82rem; font-weight:700;
        color:#1b5e20; text-transform:uppercase;
        letter-spacing:1px;
    }
    .dash-card .desc {
        font-size:0.78rem; color:#607d60;
        margin-top:4px;
    }

    /* ── Welcome banner ── */
    .welcome-banner {
        background:linear-gradient(135deg,#1b5e20,#2e7d32);
        color:white; border-radius:14px;
        padding:25px 30px; margin-bottom:25px;
        box-shadow:0 4px 15px rgba(27,94,32,0.3);
    }
    .welcome-banner h2 {
        color:white; font-family:'Space Mono',monospace;
        font-size:1.1rem; margin-bottom:5px;
        border:none; padding:0;
    }
    .welcome-banner p {
        color:rgba(255,255,255,0.8); margin:0;
        font-size:0.88rem;
    }

    /* ── Footer ── */
    .footer {
        background:#1a2e1a; color:rgba(255,255,255,0.5);
        text-align:center; padding:15px;
        font-size:0.8rem;
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

    <%-- Sidebar --%>
    <div class="sidebar">
        <div class="sidebar-section">Menu</div>
        <a href="dashboard.jsp" class="active">🏠 Dashboard</a>
        <a href="users.jsp">👥 Users</a>
        <a href="products.jsp">📦 Products</a>
        <a href="orders.jsp">📋 Orders</a>
        <hr class="sidebar-divider">
        <a href="/hamza/LogoutServlet">🚪 Logout</a>
    </div>

    <%-- Main Content --%>
    <div class="main">

        <%-- Welcome Banner --%>
        <div class="welcome-banner">
            <h2>Welcome back, <%= u.getUsername() %>! 👋</h2>
            <p>Here's what's happening in your store today.</p>
        </div>

        <%-- Page Header --%>
        <div class="page-header">
            <h1>📊 Dashboard</h1>
            <p>Manage your HKShop from here</p>
        </div>

        <%-- Quick Access Cards --%>
        <div class="dash-grid">
            <a href="users.jsp" class="dash-card">
                <div class="icon">👥</div>
                <div class="title">Manage Users</div>
                <div class="desc">View, edit, delete customers</div>
            </a>
            <a href="products.jsp" class="dash-card">
                <div class="icon">📦</div>
                <div class="title">Manage Products</div>
                <div class="desc">Add, remove, update stock</div>
            </a>
            <a href="orders.jsp" class="dash-card">
                <div class="icon">📋</div>
                <div class="title">View Orders</div>
                <div class="desc">All customer orders</div>
            </a>
            <a href="/hamza/Hkshop/login1.jsp" class="dash-card">
                <div class="icon">🛒</div>
                <div class="title">Visit Shop</div>
                <div class="desc">See the customer side</div>
            </a>
        </div>

    </div>
</div>

<div class="footer">
    © 2026 <span>HKShop Admin</span> —
    Developed by <span>Hamza Khaldi</span>
</div>

</body>
</html>