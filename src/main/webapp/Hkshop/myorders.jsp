<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,bean.User,bean.OrderReport,DB.OrderDao" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HKShop - My Orders</title>
<link rel="stylesheet" href="/hamza/Hkshop/css/customer.css">
<style>
    body { display:flex; flex-direction:column; min-height:100vh; }
    .main-content { flex:1; }

    .navbar {
        background: linear-gradient(135deg, #00695c, #00897b);
        padding: 0 30px; display:flex;
        justify-content:space-between; align-items:center;
        height:65px; box-shadow:0 2px 15px rgba(0,105,92,0.3);
        position:sticky; top:0; z-index:100;
    }
    .navbar-left { display:flex; align-items:center; gap:12px; }
    .navbar-logo {
        height:40px; width:40px; object-fit:cover;
        border-radius:8px; border:2px solid rgba(255,255,255,0.3);
    }
    .navbar-brand {
        font-family:'Poppins',sans-serif; font-size:1.3rem;
        font-weight:700; color:white; letter-spacing:1px;
    }
    .navbar-right { display:flex; align-items:center; gap:8px; }
    .navbar-right a {
        color:rgba(255,255,255,0.9); font-size:0.88rem;
        font-weight:600; padding:8px 18px; border-radius:25px;
        border:1px solid rgba(255,255,255,0.25);
        transition:all 0.2s; text-decoration:none;
    }
    .navbar-right a:hover {
        background:white; color:#00695c; border-color:white;
    }

    /* Orders table */
    .orders-table {
        width:100%; border-collapse:collapse;
        background:white; border-radius:14px;
        overflow:hidden;
        box-shadow:0 4px 20px rgba(0,105,92,0.12);
        border:2px solid #b2dfdb;
    }
    .orders-table th {
        background:linear-gradient(135deg,#00695c,#00897b);
        color:white; padding:14px 18px;
        text-align:left; font-size:0.82rem;
        font-weight:700; letter-spacing:0.5px;
        border-right:1px solid rgba(255,255,255,0.15);
    }
    .orders-table th:last-child { border-right:none; }
    .orders-table td {
        padding:13px 18px;
        border-bottom:1px solid #e0f2f0;
        border-right:1px solid #e0f2f0;
        font-size:0.88rem; vertical-align:middle;
    }
    .orders-table td:last-child { border-right:none; }
    .orders-table tr:last-child td { border-bottom:none; }
    .orders-table tr:hover td { background:#f0fffe; }
    .orders-table tr:nth-child(even) td { background:#f9ffff; }

    .footer {
        background:linear-gradient(135deg,#00695c,#004d40);
        color:rgba(255,255,255,0.8);
        text-align:center; padding:20px;
        font-size:0.85rem; margin-top:auto;
    }
    .footer span { color:#ff6f61; font-weight:700; }
</style>
</head>
<body>

<%
    User u = (User) session.getAttribute("user");
    if (u == null) {
        response.sendRedirect(request.getContextPath() + "/Hkshop/login1.jsp");
        return;
    }
    if (u.getRole().equals("admin")) {
        response.sendRedirect(request.getContextPath() + "/Hkshop/login1.jsp");
        return;
    }
    OrderDao dao = new OrderDao();
    ArrayList<OrderReport> list = dao.getOrdersByUserId(u.getId());
%>

<%-- Navbar --%>
<div class="navbar">
    <div class="navbar-left">
        <img src="/hamza/Hkshop/hkshop.png" class="navbar-logo" alt="HKShop">
        <span class="navbar-brand">HKShop</span>
    </div>
    <div class="navbar-right">
        <a href="/hamza/Hkshop/index.jsp">🏠 Shop</a>
        <a href="/hamza/Cartitemservlet?action=view">🛒 Cart</a>
        <a href="/hamza/LogoutServlet">Logout</a>
    </div>
</div>

<div class="main-content">
<div class="page-wrapper">

    <div class="page-hero">
        <h1>📋 My Orders</h1>
        <p>All orders placed by <%= u.getUsername() %></p>
    </div>

    <%-- Success message --%>
    <% String success = request.getParameter("success");
       if ("1".equals(success)) { %>
        <p style="color:green;">✅ Order cancelled successfully!</p>
    <% } %>

    <%-- Empty check --%>
    <% if (list == null || list.size() == 0) { %>
        <div style="text-align:center; padding:60px 20px;
                    background:white; border-radius:14px;
                    border:2px solid #b2dfdb;">
            <div style="font-size:3.5rem;">📦</div>
            <h2 style="color:#607d7b; margin:15px 0 10px;">
                No orders yet
            </h2>
            <p>Start shopping and your orders will appear here!</p>
            <br>
            <a href="/hamza/Hkshop/index.jsp">
                <input type="button" value="Start Shopping →"
                       style="width:auto; padding:12px 30px;">
            </a>
        </div>

    <% } else { %>

    <table class="orders-table">
        <tr>
            <th>Order ID</th>
            <th>Product</th>
            <th>Qty</th>
            <th>Price</th>
            <th>Total</th>
            <th>Payment</th>
            <th>Date</th>
            <th>Action</th>
        </tr>
        <% for (int i = 0; i < list.size(); i++) {
               OrderReport r = list.get(i); %>
        <tr>
            <td>
                <span style="background:#e0f7f4; color:#00695c;
                             padding:4px 10px; border-radius:20px;
                             font-weight:700; font-size:0.82rem;">
                    #<%= r.getOrderId() %>
                </span>
            </td>
            <td style="font-weight:700; color:#1a2e2b;">
                <%= r.getProductName() %>
            </td>
            <td style="color:#607d7b;">× <%= r.getQuantity() %></td>
            <td>$<%= String.format("%.2f", r.getPrice()) %></td>
            <td style="color:#ff6f61; font-weight:800;">
                $<%= String.format("%.2f", r.getTotalAmount()) %>
            </td>
            <td>
                <span style="background:#f0fffe; color:#00695c;
                             padding:4px 10px; border-radius:20px;
                             font-size:0.82rem; font-weight:600;
                             border:1px solid #b2dfdb;">
                    <%= r.getPaymentMethod() %>
                </span>
            </td>
            <td style="color:#607d7b; font-size:0.82rem;">
                <%= r.getOrderDate() %>
            </td>
            <td>
                <form action="/hamza/OrderServlet" method="post">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="orderId"
                           value="<%= r.getOrderId() %>">
                    <input type="submit" value="Cancel"
                           style="background:linear-gradient(135deg,#e64a3b,#ff6f61);
                                  width:auto; padding:7px 16px;
                                  font-size:0.8rem; border-radius:20px;
                                  margin-top:0;">
                </form>
            </td>
        </tr>
        <% } %>
    </table>

    <% } %>

</div>
</div>

<div class="footer">
    © 2026 <span>HKShop</span> — Developed by <span>Hamza Khaldi</span>
    &nbsp;|&nbsp; All rights reserved
</div>

</body>
</html>