<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,bean.CartItem,bean.products,bean.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HKShop - My Cart</title>
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

    /* Cart table */
    .cart-table {
        width:100%; border-collapse:collapse;
        background:white; border-radius:14px;
        overflow:hidden;
        box-shadow:0 4px 20px rgba(0,105,92,0.12);
        border:2px solid #b2dfdb;
    }
    .cart-table th {
        background:linear-gradient(135deg,#00695c,#00897b);
        color:white; padding:14px 18px;
        text-align:left; font-size:0.85rem;
        font-weight:700; letter-spacing:0.5px;
        border-right:1px solid rgba(255,255,255,0.15);
    }
    .cart-table th:last-child { border-right:none; }
    .cart-table td {
        padding:14px 18px;
        border-bottom:1px solid #e0f2f0;
        border-right:1px solid #e0f2f0;
        font-size:0.9rem; vertical-align:middle;
    }
    .cart-table td:last-child { border-right:none; }
    .cart-table tr:last-child td { border-bottom:none; }
    .cart-table tr:hover td { background:#f0fffe; }
    .cart-table tr:nth-child(even) td { background:#f9ffff; }
    .cart-table tr:nth-child(even):hover td { background:#f0fffe; }

    /* Footer */
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
    ArrayList<CartItem> cart =
        (ArrayList<CartItem>) session.getAttribute("cart");
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

    <div class="page-hero">
        <h1>🛒 My Cart</h1>
        <p>Review your items before checkout</p>
    </div>

    <%-- Empty cart --%>
    <% if (cart == null || cart.size() == 0) { %>
        <div style="text-align:center; padding:60px 20px;
                    background:white; border-radius:14px;
                    border:2px solid #b2dfdb;">
            <div style="font-size:4rem;">🛒</div>
            <h2 style="color:#607d7b; margin:15px 0 10px;">
                Your cart is empty
            </h2>
            <p>Go back and add some products!</p>
            <br>
            <a href="/hamza/Hkshop/index.jsp">
                <input type="button" value="Continue Shopping"
                       style="width:auto; padding:12px 30px;">
            </a>
        </div>

    <% } else {
        double grandTotal = 0;
        for (int i = 0; i < cart.size(); i++) {
            grandTotal += cart.get(i).getTotalPrice();
        }
    %>

    <%-- Cart Table --%>
    <table class="cart-table">
        <tr>
            <th>Product</th>
            <th>Unit Price</th>
            <th>Quantity</th>
            <th>Subtotal</th>
            <th>Action</th>
        </tr>
        <% for (int i = 0; i < cart.size(); i++) {
               CartItem item = cart.get(i); %>
        <tr>
            <td style="font-weight:700; color:#00695c;">
                <%= item.getProduct().getName() %>
            </td>
            <td style="color:#607d7b;">
                $<%= String.format("%.2f", item.getProduct().getPrice()) %>
            </td>
            <td>
                <span style="background:#e0f7f4; color:#00695c;
                             padding:5px 14px; border-radius:20px;
                             font-weight:700;">
                    × <%= item.getQuantity() %>
                </span>
            </td>
            <td style="color:#ff6f61; font-weight:800; font-size:1rem;">
                $<%= String.format("%.2f", item.getTotalPrice()) %>
            </td>
            <td>
                <form action="/hamza/Cartitemservlet" method="post">
                    <input type="hidden" name="action" value="remove">
                    <input type="hidden" name="productId"
                           value="<%= item.getProduct().getId() %>">
                    <input type="submit" value="Remove"
                           style="background:linear-gradient(135deg,#e64a3b,#ff6f61);
                                  width:auto; padding:7px 18px;
                                  font-size:0.82rem; border-radius:20px;
                                  margin-top:0;">
                </form>
            </td>
        </tr>
        <% } %>
    </table>

    <%-- Grand Total Box --%>
    <div style="background:linear-gradient(135deg,#00695c,#00897b);
                color:white; padding:20px 25px; border-radius:12px;
                display:flex; justify-content:space-between;
                align-items:center; margin:15px 0;
                box-shadow:0 4px 15px rgba(0,105,92,0.25);">
        <span style="font-size:1rem; font-weight:600;">
            Grand Total
        </span>
        <span style="font-size:1.5rem; font-weight:800;">
            $<%= String.format("%.2f", grandTotal) %>
        </span>
    </div>

    <%-- Action Buttons --%>
    <div style="display:flex; gap:15px; margin-top:15px;">
        <a href="/hamza/Hkshop/index.jsp"
           style="flex:1; text-decoration:none;">
            <input type="button" value="← Continue Shopping"
                   style="width:100%; background:white;
                          color:#00695c; border:2px solid #00695c;">
        </a>
        <a href="/hamza/Hkshop/checkout.jsp"
           style="flex:1; text-decoration:none;">
            <input type="button" value="Proceed to Checkout →"
                   style="width:100%;">
        </a>
    </div>

    <% } %>

</div>
</div>

<%-- Footer --%>
<div class="footer">
    © 2026 <span>HKShop</span> — Developed by <span>Hamza Khaldi</span>
    &nbsp;|&nbsp; All rights reserved
</div>

</body>
</html>