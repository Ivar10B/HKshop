<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,bean.*,DB.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HKShop - Order Confirmed</title>
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

    /* Success banner */
    .success-banner {
        background: linear-gradient(135deg, #43a047, #66bb6a);
        color: white; text-align:center;
        padding: 30px 20px;
        border-radius: 16px;
        margin: 25px 0;
        box-shadow: 0 4px 20px rgba(67,160,71,0.3);
    }
    .success-banner .check { font-size: 3rem; margin-bottom: 10px; }
    .success-banner h2 {
        color: white; font-size: 1.6rem;
        font-family:'Poppins',sans-serif; margin-bottom:5px;
    }
    .success-banner p { color: rgba(255,255,255,0.9); margin:0; }

    /* Info grid */
    .info-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
        margin-bottom: 25px;
    }

    /* Info card */
    .info-card {
        background: white;
        border-radius: 14px;
        padding: 22px;
        border: 2px solid #b2dfdb;
        box-shadow: 0 4px 15px rgba(0,105,92,0.08);
    }
    .info-card h3 {
        color: #00695c;
        font-family: 'Poppins', sans-serif;
        font-size: 0.88rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-bottom: 15px;
        padding-bottom: 10px;
        border-bottom: 2px solid #e0f7f4;
    }
    .info-row {
        display: flex;
        justify-content: space-between;
        padding: 7px 0;
        border-bottom: 1px solid #f0f9f8;
        font-size: 0.88rem;
    }
    .info-row:last-child { border-bottom: none; }
    .info-row .label { color: #607d7b; font-weight: 600; }
    .info-row .value { color: #1a2e2b; font-weight: 700; }

    /* Order items table */
    .items-table {
        width: 100%; border-collapse: collapse;
        background: white; border-radius: 14px;
        overflow: hidden;
        box-shadow: 0 4px 15px rgba(0,105,92,0.08);
        border: 2px solid #b2dfdb;
        margin-bottom: 20px;
    }
    .items-table th {
        background: linear-gradient(135deg, #00695c, #00897b);
        color: white; padding: 13px 18px;
        text-align: left; font-size: 0.82rem;
        font-weight: 700; letter-spacing: 0.5px;
    }
    .items-table td {
        padding: 12px 18px;
        border-bottom: 1px solid #e0f2f0;
        font-size: 0.88rem; color: #1a2e2b;
    }
    .items-table tr:last-child td { border-bottom: none; }
    .items-table tr:hover td { background: #f0fffe; }

    /* Footer */
    .footer {
        background: linear-gradient(135deg, #00695c, #004d40);
        color: rgba(255,255,255,0.8);
        text-align:center; padding:20px;
        font-size:0.85rem; margin-top:auto;
    }
    .footer span { color: #ff6f61; font-weight:700; }
</style>
</head>
<body>

<%
    User u = (User) session.getAttribute("user");
    if (u == null) {
        response.sendRedirect(request.getContextPath() + "/Hkshop/login1.jsp");
        return;
    }
    Object orderIdObj = session.getAttribute("lastOrderId");
    if (orderIdObj == null) {
        response.sendRedirect(request.getContextPath() + "/Hkshop/index.jsp");
        return;
    }
    int orderId = (Integer) orderIdObj;
    OrderDao orderDAO = new OrderDao();
    Order order           = orderDAO.getOrder(orderId);
    CustomerInfo ci       = orderDAO.getCustomerInfo(u.getId());
    ArrayList<OrderItem> items = orderDAO.getOrderItems(orderId);
%>

<%-- Navbar --%>
<div class="navbar">
    <div class="navbar-left">
        <img src="/hamza/Hkshop/hkshop.png" class="navbar-logo" alt="HKShop">
        <span class="navbar-brand">HKShop</span>
    </div>
    <div class="navbar-right">
        <a href="/hamza/Hkshop/index.jsp">🏠 Shop</a>
        <a href="/hamza/Hkshop/myorders.jsp">📋 My Orders</a>
        <a href="/hamza/LogoutServlet">Logout</a>
    </div>
</div>

<div class="main-content">
<div class="page-wrapper">

    <%-- Success Banner --%>
    <div class="success-banner">
        <div class="check">✅</div>
        <h2>Payment Successful!</h2>
        <p>Your order #<%= orderId %> has been placed successfully</p>
    </div>

    <%-- Info Grid --%>
    <div class="info-grid">

        <%-- Order Info --%>
        <div class="info-card">
            <h3>📋 Order Details</h3>
            <div class="info-row">
                <span class="label">Order ID</span>
                <span class="value">#<%= orderId %></span>
            </div>
            <div class="info-row">
                <span class="label">Payment</span>
                <span class="value"><%= order.getPaymentMethod() %></span>
            </div>
            <div class="info-row">
                <span class="label">Total Paid</span>
                <span class="value" style="color:#ff6f61; font-size:1.1rem;">
                    $<%= String.format("%.2f", order.getTotalAmount()) %>
                </span>
            </div>
            <div class="info-row">
                <span class="label">Date</span>
                <span class="value" style="font-size:0.82rem;">
                    <%= order.getOrderdate() %>
                </span>
            </div>
        </div>

        <%-- Delivery Info --%>
        <% if (ci != null) { %>
        <div class="info-card">
            <h3>🚚 Delivery Details</h3>
            <div class="info-row">
                <span class="label">Name</span>
                <span class="value">
                    <%= ci.getFirstName() %> <%= ci.getLastName() %>
                </span>
            </div>
            <div class="info-row">
                <span class="label">City</span>
                <span class="value"><%= ci.getCity() %></span>
            </div>
            <div class="info-row">
                <span class="label">Address</span>
                <span class="value"><%= ci.getAddress() %></span>
            </div>
        </div>
        <% } %>

    </div>

    <%-- Order Items --%>
    <h2>🛍 Items Ordered</h2>
    <table class="items-table">
        <tr>
            <th>Product</th>
            <th>Quantity</th>
            <th>Price</th>
        </tr>
        <% for (int i = 0; i < items.size(); i++) {
               OrderItem item = items.get(i); %>
        <tr>
            <td style="font-weight:700; color:#00695c;">
                <%= item.getProductName() %>
            </td>
            <td>
                <span style="background:#e0f7f4; color:#00695c;
                             padding:4px 12px; border-radius:20px;
                             font-weight:700;">
                    × <%= item.getQuantity() %>
                </span>
            </td>
            <td style="color:#ff6f61; font-weight:800;">
                $<%= String.format("%.2f", item.getPrice()) %>
            </td>
        </tr>
        <% } %>
    </table>

    <%-- Action Buttons --%>
    <div style="display:flex; gap:15px; margin-top:10px;">
        <a href="/hamza/Hkshop/index.jsp" style="flex:1; text-decoration:none;">
            <input type="button" value="🛍 Continue Shopping"
                   style="width:100%; background:white; color:#00695c;
                          border:2px solid #00695c;">
        </a>
        <a href="/hamza/Hkshop/myorders.jsp" style="flex:1; text-decoration:none;">
            <input type="button" value="📋 View My Orders" style="width:100%;">
        </a>
    </div>

</div>
</div>

<div class="footer">
    © 2026 <span>HKShop</span> — Developed by <span>Hamza Khaldi</span>
    &nbsp;|&nbsp; All rights reserved
</div>

</body>
</html>