<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,bean.*,DB.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HKShop - Manage Products</title>
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

    /* Add form card */
    .add-card {
        background:white; border-radius:12px; padding:22px 25px;
        margin-bottom:25px; border:1px solid #c8e6c9;
        box-shadow:0 2px 10px rgba(0,0,0,0.05);
    }
    .add-card h3 {
        font-family:'Space Mono',monospace; font-size:0.88rem;
        color:#1b5e20; text-transform:uppercase; letter-spacing:1px;
        margin-bottom:15px; padding-bottom:10px;
        border-bottom:2px solid #e8f5e9;
    }
    .add-form-grid {
        display:grid; grid-template-columns:repeat(4,1fr) auto;
        gap:10px; align-items:end;
    }
    .field-group { display:flex; flex-direction:column; gap:5px; }
    .field-group label {
        font-size:0.75rem; font-weight:700; color:#2e7d32;
        text-transform:uppercase; letter-spacing:0.5px;
    }
    .add-form-grid input[type="text"] {
        background:#f1f8e9; border:2px solid #c8e6c9;
        border-radius:8px; color:#1a2e1a; padding:9px 12px;
        font-size:0.88rem; font-family:'DM Sans',sans-serif;
        width:100%; transition:all 0.2s;
    }
    .add-form-grid input[type="text"]:focus {
        outline:none; border-color:#4caf50; background:white;
    }
    .add-form-grid input[type="submit"] {
        background:linear-gradient(135deg,#1b5e20,#2e7d32);
        color:white; border:none; border-radius:8px;
        padding:10px 20px; font-size:0.85rem;
        font-family:'DM Sans',sans-serif; font-weight:700;
        cursor:pointer; white-space:nowrap;
        transition:all 0.2s; width:auto; margin-top:0;
    }
    .add-form-grid input[type="submit"]:hover {
        background:linear-gradient(135deg,#2e7d32,#4caf50);
    }

    /* Data table */
    .data-table {
        width:100%; border-collapse:collapse;
        background:white; border-radius:12px;
        overflow:hidden; box-shadow:0 2px 15px rgba(0,0,0,0.08);
        border:1px solid #c8e6c9;
    }
    .data-table th {
        background:linear-gradient(135deg,#1b5e20,#2e7d32);
        color:white; padding:13px 16px; text-align:left;
        font-size:0.8rem; font-weight:700; letter-spacing:0.5px;
        border-right:1px solid rgba(255,255,255,0.1);
    }
    .data-table th:last-child { border-right:none; }
    .data-table td {
        padding:11px 16px; border-bottom:1px solid #e8f5e9;
        border-right:1px solid #e8f5e9;
        font-size:0.86rem; vertical-align:middle;
    }
    .data-table td:last-child { border-right:none; }
    .data-table tr:last-child td { border-bottom:none; }
    .data-table tr:hover td { background:#f1f8e9; }

    /* Qty update inline form */
    .qty-form { display:flex; gap:6px; align-items:center; }
    .qty-form input[type="text"] {
        width:55px; padding:5px 8px; border-radius:6px;
        border:2px solid #c8e6c9; background:#f1f8e9;
        font-size:0.85rem; text-align:center;
        font-family:'DM Sans',sans-serif;
    }
    .qty-form input[type="submit"] {
        background:linear-gradient(135deg,#1565c0,#1976d2);
        color:white; border:none; border-radius:6px;
        padding:5px 12px; font-size:0.78rem; font-weight:700;
        cursor:pointer; width:auto; margin-top:0;
    }
    .btn-delete {
        background:linear-gradient(135deg,#b71c1c,#e53935);
        color:white; border:none; border-radius:20px;
        padding:5px 14px; font-size:0.78rem; font-weight:700;
        cursor:pointer; transition:all 0.2s;
        width:auto; margin-top:0;
    }
    .btn-delete:hover { background:linear-gradient(135deg,#e53935,#ef9a9a); }

    /* Success messages */
    .success-msg {
        background:#e8f5e9; border-left:4px solid #4caf50;
        color:#1b5e20; padding:10px 16px; border-radius:0 8px 8px 0;
        margin-bottom:15px; font-weight:700; font-size:0.88rem;
    }

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
    Productdao pdao = new Productdao();
    List<products> list = pdao.getAll();
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
        <a href="users.jsp">👥 Users</a>
        <a href="products.jsp" class="active">📦 Products</a>
        <a href="orders.jsp">📋 Orders</a>
        <hr class="sidebar-divider">
        <a href="/hamza/LogoutServlet">🚪 Logout</a>
    </div>

    <div class="main">
        <div class="page-header">
            <h1>📦 Manage Products</h1>
        </div>

        <%-- Success messages --%>
        <% String success = request.getParameter("success");
           if ("1".equals(success)) { %>
            <div class="success-msg">✅ Product added successfully!</div>
        <% } else if ("2".equals(success)) { %>
            <div class="success-msg">✅ Product deleted successfully!</div>
        <% } else if ("3".equals(success)) { %>
            <div class="success-msg">✅ Quantity updated successfully!</div>
        <% } %>

		 <div class="add-card">
		    <h3>➕ Add New Product</h3>
		    <form action="/hamza/ProductServlet" method="post">
		        <input type="hidden" name="action" value="add">
		
		        <%-- Row 1 — 4 fields --%>
		        <div style="display:grid; grid-template-columns:repeat(4,1fr);
		                    gap:10px; margin-bottom:10px;">
		            <div class="field-group">
		                <label>Product Name</label>
		                <input type="text" name="name"
		                       placeholder="e.g. Laptop Pro">
		            </div>
		            <div class="field-group">
		                <label>Price ($)</label>
		                <input type="text" name="price"
		                       placeholder="e.g. 999.99">
		            </div>
		            <div class="field-group">
		                <label>Description</label>
		                <input type="text" name="description"
		                       placeholder="Short description">
		            </div>
		            <div class="field-group">
		                <label>Quantity</label>
		                <input type="text" name="quantity"
		                       placeholder="e.g. 50">
		            </div>
		        </div>
		
		        <%-- Row 2 — image + button --%>
		        <div style="display:grid; grid-template-columns:1fr auto;
		                    gap:10px; align-items:end;">
		            <div class="field-group">
		                <label>Image URL</label>
		                <input type="text" name="image"
		                       placeholder="https://images.unsplash.com/...">
		            </div>
		            <input type="submit" value="Add ➕"
		                   style="background:linear-gradient(135deg,#1b5e20,#2e7d32);
		                          color:white; border:none; border-radius:8px;
		                          padding:10px 24px; font-size:0.85rem;
		                          font-family:'DM Sans',sans-serif; font-weight:700;
		                          cursor:pointer; white-space:nowrap;
		                          height:40px; width:auto; margin-top:0;">
		        </div>
		
		    </form>
		</div>
        <%-- Products Table --%>
        <table class="data-table">
            <tr>
                <th>ID</th>
                <th>Product Name</th>
                <th>Price</th>
                <th>Description</th>
                <th>Stock</th>
                <th>Update Qty</th>
                <th>Delete</th>
            </tr>
            <% for (int i = 0; i < list.size(); i++) {
                   products p = list.get(i); %>
            <tr>
                <td style="color:#9e9e9e; font-size:0.82rem;">
                    #<%= p.getId() %>
                </td>
                <td style="font-weight:700; color:#1b5e20;">
                    <%= p.getName() %>
                </td>
                <td style="color:#e65100; font-weight:800;">
                    $<%= String.format("%.2f", p.getPrice()) %>
                </td>
                <td style="color:#607d60; font-size:0.85rem;">
                    <%= p.getDescription() %>
                </td>
                <td>
                    <% if (p.getQuantity() > 5) { %>
                        <span style="background:#e8f5e9; color:#2e7d32;
                                     padding:3px 10px; border-radius:12px;
                                     font-size:0.78rem; font-weight:700;">
                            <%= p.getQuantity() %>
                        </span>
                    <% } else if (p.getQuantity() > 0) { %>
                        <span style="background:#fff8e1; color:#f57f17;
                                     padding:3px 10px; border-radius:12px;
                                     font-size:0.78rem; font-weight:700;">
                            ⚠️ <%= p.getQuantity() %>
                        </span>
                    <% } else { %>
                        <span style="background:#fdecea; color:#c62828;
                                     padding:3px 10px; border-radius:12px;
                                     font-size:0.78rem; font-weight:700;">
                            Out of stock
                        </span>
                    <% } %>
                </td>
                <td>
                    <form action="/hamza/ProductServlet" method="post"
                          class="qty-form">
                        <input type="hidden" name="action" value="updateQty">
                        <input type="hidden" name="pid" value="<%= p.getId() %>">
                        <input type="text" name="quantity" placeholder="qty">
                        <input type="submit" value="Update">
                    </form>
                </td>
                <td>
                    <form action="/hamza/ProductServlet" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="pid" value="<%= p.getId() %>">
                        <input type="submit" value="Delete" class="btn-delete">
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