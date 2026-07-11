# 🛒 HKShop — Electronics E-Commerce Store

A full-stack e-commerce web application built with JSP, Servlet, JavaBean, and MySQL.
Features a complete customer shopping experience and a separate admin management portal,
both secured with role-based access control.

> **Course:** Web Advanced Development Technology  
> **Student:** Hamza Khaldi — ECUT, China  
> **Stack:** JSP + Servlet + JavaBean + MySQL + Apache Tomcat 10  

---

## 🖥️ Screenshots

### Customer Side
> Login Page — Product Catalog — Shopping Cart — Order Confirmation

*(Screenshots coming soon)*

### Admin Side
> Dashboard — Manage Products — View All Orders

*(Screenshots coming soon)*

---

## ✨ Features

### 👤 Customer Side
| Feature | Description |
|---|---|
| 🔐 Register | Create a new account saved to MySQL |
| 🔑 Login | Secure login with role-based redirect |
| 🛍️ Product Browsing | View all products with images and stock status |
| 🛒 Shopping Cart | Add/remove items — session-based cart |
| 💳 Checkout | Enter delivery info and choose payment method |
| ✅ Order Confirmation | Full order summary after payment |
| 📋 My Orders | View all past orders — cancel if needed |
| 🌍 Chinese Support | UTF-8 encoding — supports Chinese usernames |
| 🚪 Logout | Destroys session completely |

### 👑 Admin Side
| Feature | Description |
|---|---|
| 📊 Dashboard | Quick-access cards to all admin features |
| 👥 Manage Users | View, edit, delete customer accounts |
| 📦 Manage Products | Add, delete, update stock and images |
| 📋 View All Orders | Full JOIN report across 5 database tables |
| 🔒 Security Filter | Blocks customers from accessing admin pages |

---

## 🏗️ Architecture — MVC Pattern

```
Browser
    ↓ HTTP Request
Filter (Security + Encoding)
    ↓
web.xml → routes to correct Servlet
    ↓
Servlet (Controller) — reads form, validates, calls DAO
    ↓
DAO (Data Access Object) — runs SQL queries
    ↓
MySQL Database
    ↓
DAO returns JavaBeans → Servlet saves to session
    ↓
JSP (View) renders HTML
    ↓
Browser shows page
```

---

## 🗄️ Database Schema

**Database name:** `hkshop` — 5 tables with foreign key relationships

```sql
users          → id, username, password, email, role
products       → id, name, price, description, quantity, image
customer_info  → id, user_id (FK), first_name, last_name, city, address
orders         → id, user_id (FK), payment_method, total_amount, order_date
order_items    → id, order_id (FK), product_id (FK), quantity, price
```

### Relationships

```
users ──(1:1)── customer_info
users ──(1:N)── orders
orders ──(1:N)── order_items
products ──(1:N)── order_items
```

---

## 📁 Project Structure

```
src/main/
├── java/
│   ├── bean/       → 7 JavaBeans (User, Product, CartItem, Order...)
│   ├── dao/        → DBconnection.java
│   ├── DB/         → Usdao, Productdao, OrderDao
│   ├── hkshop/     → 8 Servlets
│   └── filters/    → SecurityFilter, EncodingFilter
└── webapp/
    └── Hkshop/
        ├── Css/    → customer.css (Teal), admin.css (Dark Green)
        ├── Admin/  → 5 Admin JSP pages
        └── *.jsp   → 7 Customer JSP pages
```

---

## 🔒 Security

| Feature | Implementation |
|---|---|
| Role-based access | Session attribute role check on every protected page |
| Admin protection | SecurityFilter intercepts all /Admin/ URLs |
| SQL injection prevention | PreparedStatement with ? placeholders everywhere |
| UTF-8 encoding | EncodingFilter runs on every request |

---

## 🚀 How to Run

### Prerequisites
- Java JDK 21
- Apache Tomcat 10.0.27
- MySQL 8.x
- Eclipse IDE

### Setup Steps

**1. Create the database:**
```bash
mysql -u root -p < database/hkshop.sql
```

**2. Configure DB connection:**

Open `src/main/java/dao/DBconnection.java` and fill in your MySQL password:
```java
private static final String PASSWORD = "your_password_here";
```

**3. Import into Eclipse:**
- File → Import → Existing Projects into Workspace
- Select the project folder

**4. Add Tomcat and run:**
- Right click project → Run As → Run on Server

**5. Open in browser:**
```
http://localhost:8080/hamza/Hkshop/login1.jsp
```

### Default Accounts

| Role | Username | Password |
|---|---|---|
| Admin | `admin` | `admin123` |
| Customer | Register a new account | — |

---

## 📊 Project Statistics

| Category | Count |
|---|---|
| JavaBeans | 7 |
| Servlets | 8 |
| Filters | 2 |
| DAO Classes | 3 |
| Customer JSP Pages | 7 |
| Admin JSP Pages | 5 |
| Database Tables | 5 |
| Total Files | ~45 |

---

## 👨‍💻 Developer

**Hamza Khaldi**  
Software Engineering Student — ECUT, China  
GitHub: [Ivar10B](https://github.com/Ivar10B)