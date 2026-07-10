<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,bean.products,DB.Productdao,bean.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HKShop - Products</title>
<link rel="stylesheet" href="/hamza/Hkshop/css/customer.css">
<style>
    body {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }
    .main-content { flex: 1; }

    /* ── Navbar ── */
    .navbar {
        background: linear-gradient(135deg, #00695c, #00897b);
        padding: 0 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        height: 65px;
        box-shadow: 0 2px 15px rgba(0,105,92,0.3);
        position: sticky;
        top: 0;
        z-index: 100;
    }
    .navbar-left {
        display: flex;
        align-items: center;
        gap: 12px;
    }
    .navbar-logo {
        height: 40px;
        width: 40px;
        object-fit: cover;
        border-radius: 8px;
        border: 2px solid rgba(255,255,255,0.3);
    }
    .navbar-brand {
        font-family: 'Poppins', sans-serif;
        font-size: 1.3rem;
        font-weight: 700;
        color: white;
        letter-spacing: 1px;
    }
    .navbar-right {
        display: flex;
        align-items: center;
        gap: 8px;
    }
    .navbar-right a {
        color: rgba(255,255,255,0.9);
        font-size: 0.88rem;
        font-weight: 600;
        padding: 8px 18px;
        border-radius: 25px;
        border: 1px solid rgba(255,255,255,0.25);
        transition: all 0.2s;
        text-decoration: none;
    }
    .navbar-right a:hover {
        background: white;
        color: #00695c;
        border-color: white;
    }
    .navbar-right a.cart-btn {
        background: #ff6f61;
        border-color: #ff6f61;
        color: white;
    }
    .navbar-right a.cart-btn:hover {
        background: #e64a3b;
        border-color: #e64a3b;
        color: white;
    }

    /* ── Banner ── */
    .banner {
        width: 100%;
        max-height: 280px;
        object-fit: cover;
        display: block;
    }

    /* ── Welcome strip ── */
    .welcome-strip {
        background: #e0f7f4;
        padding: 12px 30px;
        border-bottom: 2px solid #b2dfdb;
        font-size: 0.9rem;
        color: #00695c;
        font-weight: 700;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    /* ── Table fixes ── */
    .product-table {
        width: 100%;
        border-collapse: collapse;
        background: white;
        border-radius: 14px;
        overflow: hidden;
        box-shadow: 0 4px 20px rgba(0,105,92,0.12);
        border: 2px solid #b2dfdb;
    }
    .product-table th {
        background: linear-gradient(135deg, #00695c, #00897b);
        color: white;
        padding: 15px 18px;
        text-align: left;
        font-size: 0.85rem;
        font-weight: 700;
        letter-spacing: 0.5px;
        border-right: 1px solid rgba(255,255,255,0.15);
    }
    .product-table th:last-child { border-right: none; }
    .product-table td {
        padding: 14px 18px;
        border-bottom: 1px solid #e0f2f0;
        border-right: 1px solid #e0f2f0;
        font-size: 0.9rem;
        vertical-align: middle;
    }
    .product-table td:last-child { border-right: none; }
    .product-table tr:last-child td { border-bottom: none; }
    .product-table tr:hover td { background: #f0fffe; }
    .product-table tr:nth-child(even) td { background: #f9ffff; }
    .product-table tr:nth-child(even):hover td { background: #f0fffe; }

    /* ── Footer always at bottom ── */
    .footer {
        background: linear-gradient(135deg, #00695c, #004d40);
        color: rgba(255,255,255,0.8);
        text-align: center;
        padding: 20px;
        font-size: 0.85rem;
        margin-top: auto;
    }
    .footer span { color: #ff6f61; font-weight: 700; }
</style>
</head>
<body>

<%-- Session check --%>
<%
    User u = (User) session.getAttribute("user");
    if (u == null || u.getRole().equals("admin")) {
        response.sendRedirect(request.getContextPath() + "/Hkshop/login1.jsp");
        return;
    }
    Productdao dao = new Productdao();
    List<products> list = dao.getAll();
%>

<%-- Navbar --%>
<div class="navbar">
    <div class="navbar-left">
        <img src="/hamza/Hkshop/hkshop.png" class="navbar-logo" alt="HKShop">
        <span class="navbar-brand">HKShop</span>
    </div>
    <div class="navbar-right">
        <a href="/hamza/Hkshop/myorders.jsp">📋 My Orders</a>
        <a href="/hamza/Cartitemservlet?action=view" class="cart-btn">🛒 Cart</a>
        <a href="/hamza/LogoutServlet">Logout</a>
    </div>
</div>

<%-- Banner image --%>
<img src="/hamza/Hkshop/hkshop.png" class="banner" alt="HKShop Banner">

<%-- Welcome strip --%>
<div class="welcome-strip">
    <span>👋 Welcome back, <%= u.getUsername() %>!</span>
    <span style="color:#607d7b; font-weight:400; font-size:0.85rem;">
        <%= list.size() %> products available
    </span>
</div>

<%-- Success message --%>
<% String success = request.getParameter("success");
   if ("1".equals(success)) { %>
    <div style="background:#e0f7f4; border-left:4px solid #00897b;
                color:#00695c; padding:12px 30px; font-weight:700;">
        ✅ Product added to cart!
        <a href="/hamza/Cartitemservlet?action=view"
           style="margin-left:10px; color:#ff6f61;">View Cart →</a>
    </div>
<% } %>

<%-- Main Content --%>
<div class="main-content">
<div class="page-wrapper">

    <h2 style="margin-bottom:20px;">📦 Our Products</h2>

    <table class="product-table">
        <tr>
        	<th>Image</th>
            <th>#</th>
            <th>Product Name</th>
            <th>Price</th>
            <th>Description</th>
            <th>Stock</th>
            <th>Action</th>
            
        </tr>
        <% for (int i = 0; i < list.size(); i++) {
               products p = list.get(i); %>
        <tr>
        	<td>
			    <% if (p.getImage() != null && !p.getImage().isEmpty()) { %>
			        <img src="<%= p.getImage() %>"
			             style="width:70px; height:70px;
			                    object-fit:cover;
			                    border-radius:10px;
			                    border:2px solid #b2dfdb;
			                    box-shadow:0 2px 8px rgba(0,105,92,0.15);">
			    <% } else { %>
			        <span style="font-size:1.8rem;">📦</span>
			    <% } %>
			</td>
            <td style="color:#607d7b; font-size:0.85rem;">
                <%= p.getId() %>
            </td>
            <td style="font-weight:700; color:#00695c;">
                <%= p.getName() %>
            </td>
            <td style="color:#ff6f61; font-weight:800; font-size:1rem;">
                $<%= String.format("%.2f", p.getPrice()) %>
            </td>
            <td style="color:#607d7b;">
                <%= p.getDescription() %>
            </td>
            <td>
                <% if (p.getQuantity() > 0) { %>
                    <span style="background:#e0f7f4; color:#00695c;
                                 padding:4px 10px; border-radius:20px;
                                 font-size:0.82rem; font-weight:700;">
                        <%= p.getQuantity() %> left
                    </span>
                <% } else { %>
                    <span style="background:#fdecea; color:#e64a3b;
                                 padding:4px 10px; border-radius:20px;
                                 font-size:0.82rem; font-weight:700;">
                        Out of stock
                    </span>
                <% } %>
            </td>
            <td>
                <% if (p.getQuantity() > 0) { %>
                <form action="/hamza/Cartitemservlet" method="post">
                    <input type="hidden" name="productId" value="<%= p.getId() %>">
                    <input type="submit" value="Add to Cart"
                           style="width:auto; padding:8px 18px;
                                  font-size:0.82rem; border-radius:20px;
                                  margin-top:0;">
                </form>
                <% } else { %>
                    <span style="color:#ccc; font-size:0.85rem;">—</span>
                <% } %>
            </td>
           
        </tr>
        <% } %>
    </table>

</div>
</div>

<%-- Footer always at bottom --%>
<div class="footer">
    © 2026 <span>HKShop</span> — Developed by <span>Hamza Khaldi</span>
    &nbsp;|&nbsp; All rights reserved
</div>

</body>
</html>