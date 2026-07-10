<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,bean.CartItem,bean.products,bean.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HKShop - Checkout</title>
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

    /* Two column layout */
    .checkout-grid {
        display: grid;
        grid-template-columns: 1fr 1.2fr;
        gap: 25px;
        margin-top: 25px;
    }

    /* Section card */
    .section-card {
        background: white;
        border-radius: 14px;
        padding: 25px;
        border: 2px solid #b2dfdb;
        box-shadow: 0 4px 20px rgba(0,105,92,0.1);
    }

    .section-card h3 {
        color: #00695c;
        font-family: 'Poppins', sans-serif;
        font-size: 1rem;
        font-weight: 700;
        margin-bottom: 18px;
        padding-bottom: 10px;
        border-bottom: 2px solid #e0f7f4;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    /* Order summary table */
    .summary-table {
        width: 100%; border-collapse: collapse;
        border-radius: 10px; overflow: hidden;
        border: 1px solid #e0f2f0;
    }
    .summary-table th {
        background: linear-gradient(135deg, #00695c, #00897b);
        color: white; padding: 10px 14px;
        font-size: 0.82rem; font-weight: 700;
        text-align: left; letter-spacing: 0.5px;
    }
    .summary-table td {
        padding: 10px 14px;
        border-bottom: 1px solid #e0f2f0;
        font-size: 0.88rem; color: #1a2e2b;
    }
    .summary-table tr:last-child td { border-bottom: none; }
    .summary-table tr:hover td { background: #f0fffe; }

    /* Field label */
    .field-label {
        font-size: 0.78rem; font-weight: 700;
        color: #00695c; text-transform: uppercase;
        letter-spacing: 1px; margin-bottom: 6px;
        margin-top: 14px; display: block;
    }

    /* Payment radio buttons */
    .payment-options {
        display: flex; gap: 12px; margin: 10px 0;
        flex-wrap: wrap;
    }
    .payment-option {
        flex: 1; min-width: 80px;
        border: 2px solid #b2dfdb;
        border-radius: 10px; padding: 12px 10px;
        text-align: center; cursor: pointer;
        transition: all 0.2s; font-size: 0.88rem;
        font-weight: 700; color: #607d7b;
    }
    .payment-option:hover {
        border-color: #00897b;
        background: #e0f7f4;
        color: #00695c;
    }

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
    ArrayList<CartItem> cart =
        (ArrayList<CartItem>) session.getAttribute("cart");
    if (cart == null || cart.size() == 0) {
        response.sendRedirect(request.getContextPath() + "/Hkshop/index.jsp");
        return;
    }
    double grandTotal = 0;
    for (int i = 0; i < cart.size(); i++) {
        grandTotal += cart.get(i).getTotalPrice();
    }
%>

<%-- Navbar --%>
<div class="navbar">
    <div class="navbar-left">
        <img src="/hamza/Hkshop/hkshop.png" class="navbar-logo" alt="HKShop">
        <span class="navbar-brand">HKShop</span>
    </div>
    <div class="navbar-right">
        <a href="/hamza/Hkshop/index.jsp">🏠 Shop</a>
        <a href="/hamza/LogoutServlet">Logout</a>
    </div>
</div>

<div class="main-content">
<div class="page-wrapper">

    <div class="page-hero">
        <h1>💳 Checkout</h1>
        <p>Almost there — fill your details and complete your order</p>
    </div>

    <div class="checkout-grid">

        <%-- LEFT — Order Summary --%>
        <div class="section-card">
            <h3>📦 Order Summary</h3>
            <table class="summary-table">
                <tr>
                    <th>Product</th>
                    <th>Qty</th>
                    <th>Total</th>
                </tr>
                <% for (int i = 0; i < cart.size(); i++) {
                       CartItem item = cart.get(i); %>
                <tr>
                    <td style="font-weight:700; color:#00695c;">
                        <%= item.getProduct().getName() %>
                    </td>
                    <td>× <%= item.getQuantity() %></td>
                    <td style="color:#ff6f61; font-weight:800;">
                        $<%= String.format("%.2f", item.getTotalPrice()) %>
                    </td>
                </tr>
                <% } %>
            </table>

            <div style="background:linear-gradient(135deg,#00695c,#00897b);
                        color:white; padding:15px 18px; border-radius:10px;
                        margin-top:15px; display:flex;
                        justify-content:space-between; align-items:center;">
                <span style="font-weight:600;">Total to Pay</span>
                <span style="font-size:1.3rem; font-weight:800;">
                    $<%= String.format("%.2f", grandTotal) %>
                </span>
            </div>
        </div>

        <%-- RIGHT — Payment Form --%>
        <div class="section-card">
            <h3>📝 Your Details</h3>

            <form action="/hamza/PaymentServlet" method="post">

                <span class="field-label">First Name</span>
                <input type="text" name="firstName" placeholder="Enter first name">

                <span class="field-label">Last Name</span>
                <input type="text" name="lastName" placeholder="Enter last name">

                <span class="field-label">City</span>
                <input type="text" name="city" placeholder="Enter your city">

                <span class="field-label">Address</span>
                <input type="text" name="address" placeholder="Enter your address">

                <span class="field-label">Payment Method</span>
                <div class="payment-options">
                    <label class="payment-option">
                        <input type="radio" name="paymentMethod"
                               value="Visa" style="display:none;">
                        💳 Visa
                    </label>
                    <label class="payment-option">
                        <input type="radio" name="paymentMethod"
                               value="Mastercard" style="display:none;">
                        💳 Mastercard
                    </label>
                    <label class="payment-option">
                        <input type="radio" name="paymentMethod"
                               value="UnionPay" style="display:none;">
                        💳 UnionPay
                    </label>
                </div>

                <span class="field-label">Card Number</span>
                <input type="text" name="cardNumber"
                       placeholder="1234 5678 9012 3456">

                <span class="field-label">Card Holder Name</span>
                <input type="text" name="cardHolder"
                       placeholder="Name on card">

                <span class="field-label">Expiry Date</span>
                <input type="text" name="expiryDate" placeholder="MM/YY">

                <div style="margin-top:25px;">
                    <input type="submit" value="Pay Now →"
                           style="font-size:1rem; padding:15px;">
                </div>

            </form>
        </div>

    </div>
</div>
</div>

<div class="footer">
    © 2026 <span>HKShop</span> — Developed by <span>Hamza Khaldi</span>
    &nbsp;|&nbsp; All rights reserved
</div>

</body>
</html>