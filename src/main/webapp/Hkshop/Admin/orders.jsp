<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,bean.*,DB.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HKShop - All Orders</title>
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
        padding:7px 16px; border-radius:20px; font-size:0.82rem;
        font-weight:600; border:1px solid rgba(255,255,255,0.25);
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
        padding:11px 20px; color:#a5d6a7; font-size:0.88rem;
        font-weight:600; text-decoration:none; transition:all 0.2s;
        border-left:3px solid transparent;
    }
    .sidebar a:hover, .sidebar a.active {
        background:rgba(76,175,80,0.15); color:#69f0ae;
        border-left-color:#4caf50;
    }
    .sidebar-divider { border:none; border-top:1px solid #2a3e2a; margin:15px 0; }
    .main { flex:1; padding:30px; overflow-x:auto; }
    .page-header { margin-bottom:20px; }
    .page-header h1 {
        font-family:'Space Mono',monospace; font-size:1.4rem;
        color:#1b5e20; margin-bottom:5px;
    }

    /* Orders table */
    .data-table {
        width:100%; border-collapse:collapse;
        background:white; border-radius:12px;
        overflow:hidden; box-shadow:0 2px 15px rgba(0,0,0,0.08);
        border:1px solid #c8e6c9; white-space:nowrap;
    }
    .data-table th {
        background:linear-gradient(135deg,#1b5e20,#2e7d32);
        color:white; padding:13px 14px; text-align:left;
        font-size:0.78rem; font-weight:700; letter-spacing:0.5px;
        border-right:1px solid rgba(255,255,255,0.1);
    }
    .data-table th:last-child { border-right:none; }
    .data-table td {
        padding:11px 14px; border-bottom:1px solid #e8f5e9;
        border-right:1px solid #e8f5e9; font-size:0.84rem;
        vertical-align:middle;
    }
    .data-table td:last-child { border-right:none; }
    .data-table tr:last-child td { border-bottom:none; }
    .data-table tr:hover td { background:#f1f8e9; }
    .data-table tr:nth-child(even) td { background:#fafffe; }

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
    OrderDao dao = new OrderDao();
    ArrayList<OrderReport> list = dao.getAllOrders();
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
        <a href="dashboared.jsp">🏠 Dashboard</a>
        <a href="users.jsp">👥 Users</a>
        <a href="products.jsp">📦 Products</a>
        <a href="orders.jsp" class="active">📋 Orders</a>
        <hr class="sidebar-divider">
        <a href="/hamza/LogoutServlet">🚪 Logout</a>
    </div>

    <div class="main">
        <div class="page-header">
            <h1>📋 All Orders</h1>
        </div>

        <% if (list == null || list.size() == 0) { %>
            <div style="text-align:center; padding:50px; background:white;
                        border-radius:12px; border:1px solid #c8e6c9;">
                <div style="font-size:3rem;">📦</div>
                <h2 style="color:#607d60; margin:15px 0 8px;
                           font-family:'Space Mono',monospace;">
                    No orders yet
                </h2>
                <p style="color:#9e9e9e;">Orders will appear here once customers start buying.</p>
            </div>
        <% } else { %>

        <table class="data-table">
            <tr>
                <th>Order ID</th>
                <th>Username</th>
                <th>Full Name</th>
                <th>City</th>
                <th>Payment</th>
                <th>Product</th>
                <th>Qty</th>
                <th>Price</th>
                <th>Total</th>
                <th>Date</th>
            </tr>
            <% for (int i = 0; i < list.size(); i++) {
                   OrderReport r = list.get(i); %>
            <tr>
                <td>
                    <span style="background:#e8f5e9; color:#1b5e20;
                                 padding:3px 10px; border-radius:12px;
                                 font-weight:700; font-size:0.78rem;">
                        #<%= r.getOrderId() %>
                    </span>
                </td>
                <td style="font-weight:700; color:#1b5e20;">
                    <%= r.getUsername() %>
                </td>
                <td><%= r.getFirstname() + " " + r.getLastname() %></td>
                <td style="color:#607d60;"><%= r.getCity() %></td>
                <td>
                    <span style="background:#fff8e1; color:#f57f17;
                                 padding:3px 10px; border-radius:12px;
                                 font-size:0.78rem; font-weight:600;
                                 border:1px solid #ffe082;">
                        <%= r.getPaymentMethod() %>
                    </span>
                </td>
                <td style="font-weight:600;">
                    <%= r.getProductName() %>
                </td>
                <td style="color:#607d60; text-align:center;">
                    <%= r.getQuantity() %>
                </td>
                <td>$<%= String.format("%.2f", r.getPrice()) %></td>
                <td style="color:#e65100; font-weight:800;">
                    $<%= String.format("%.2f", r.getTotalAmount()) %>
                </td>
                <td style="color:#9e9e9e; font-size:0.8rem;">
                    <%= r.getOrderDate() %>
                </td>
            </tr>
            <% } %>
        </table>

        <% } %>
    </div>
</div>

<div class="footer">
    © 2026 <span>HKShop Admin</span> —
    Developed by <span>Hamza Khaldi</span>
</div>

</body>
</html>