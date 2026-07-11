# HKshop - Elecetronics E-Commerce Store
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
users ──(1:1)── customer_info
users ──(1:N)── orders
orders ──(1:N)── order_items
products ──(1:N)── order_items
---

## 📁 Project Structure
this is my code for db connection :

this is my code for db connection ::
package dao;
import java.sql.Connection;
import java.sql.DriverManager;
public class DBconnection {
     private static final String url = "jdbc:mysql://localhost:3306/hkshop?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
        private static final String USER     = "root";
        private static final String PASSWORD = "NewPassword123@";
        public static Connection getConnection() {
            Connection conn = null;
            try {
                // Load the MySQL driver
                Class.forName("com.mysql.jdbc.Driver");
                // Open the connection
                conn = DriverManager.getConnection(url, USER, PASSWORD);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return conn;
        }
}

Show more
Good — password is updated. ✅

Now run the .gitignore update commands I gave you above:

bash
echo "src/main/java/dao/DBconnection.java" >> /d/hamza/hamza/.gitignore
echo "src/main/webapp/WEB-INF/lib/*.jar" >> /d/hamza/hamza/.gitignore
Then:

bash
cd /d/hamza/hamza
git add .gitignore
git commit -m "Update .gitignore — exclude DBconnection and JAR files"
git push
Send me the output. After this is done we have one last thing in Step 1 — the README.md — and then Step 1 is completely finished.

The README is the most important part for your resume because it's the first thing anyone sees when they open your GitHub link. I'll write the full content for you and we'll add it together.

ASUS@DESKTOP-1C43NBQ MINGW64 /d/hamza/hamza (master)
$ echo "src/main/java/dao/DBconnection.java" >> /d/hamza/hamza/.gitignore
ASUS@DESKTOP-1C43NBQ MINGW64 /d/hamza/hamza (master)
$ echo "src/main/webapp/WEB-INF/lib/*.jar" >> /d/hamza/hamza/.gitignore
ASUS@DESKTOP-1C43NBQ MINGW64 /d/hamza/hamza (master)
$ cd /d/hamza/hamza
ASUS@DESKTOP-1C43NBQ MINGW64 /d/hamza/hamza (master)
$ git add .gitignore
warning: in the working copy of '.gitignore', LF will be replaced by CRLF the next time Git touches it
ASUS@DESKTOP-1C43NBQ MINGW64 /d/hamza/hamza (master)
$ git commit -m "Update gitignore - exclude DBconnection and JAR files"
[master 4877a40] Update gitignore - exclude DBconnection and JAR files
 1 file changed, 2 insertions(+)
ASUS@DESKTOP-1C43NBQ MINGW64 /d/hamza/hamza (master)
$ git push
fatal: unable to access 'https://github.com/Ivar10B/HKshop.git/': Could not resolve host: github.com
ASUS@DESKTOP-1C43NBQ MINGW64 /d/hamza/hamza (master)
$

Show more
The commit worked ✅ — the push failed because of no internet connection at that moment. Not a Git problem, just network.

Check your internet is working, then run just this one command:

bash
git push
Send me the output.

$ git push
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 373 bytes | 373.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/Ivar10B/HKshop.git
   b001b00..4877a40  master -> master

✅ Pushed successfully.

Step 1 Status So Far
Task	Status
Git initialized	✅ Done
.gitignore created and working	✅ Done
Code pushed to GitHub	✅ Done
Password removed from GitHub	✅ Done
MySQL password changed	✅ Done
JAR removed from GitHub	✅ Done
database/hkshop.sql created	✅ Done
README.md	🔲 Last thing
Last Part — README.md
This is the most important file. When a recruiter opens your GitHub link, this is the first thing they read. I will write the full content for you.

Open Notepad, copy everything below exactly, save it as README.md inside D:\hamza\hamza\ — same process as .gitignore — File → Save As → All Files → README.md

markdown
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
|
 Feature 
|
 Description 
|
|
---
|
---
|
|
 🔐 Register 
|
 Create a new account saved to MySQL 
|
|
 🔑 Login 
|
 Secure login with role-based redirect 
|
|
 🛍️ Product Browsing 
|
 View all products with images and stock status 
|
|
 🛒 Shopping Cart 
|
 Add/remove items — session-based cart 
|
|
 💳 Checkout 
|
 Enter delivery info and choose payment method 
|
|
 ✅ Order Confirmation 
|
 Full order summary after payment 
|
|
 📋 My Orders 
|
 View all past orders — cancel if needed 
|
|
 🌍 Chinese Support 
|
 UTF-8 encoding — supports Chinese usernames 
|
|
 🚪 Logout 
|
 Destroys session completely 
|

### 👑 Admin Side
|
 Feature 
|
 Description 
|
|
---
|
---
|
|
 📊 Dashboard 
|
 Quick-access cards to all admin features 
|
|
 👥 Manage Users 
|
 View, edit, delete customer accounts 
|
|
 📦 Manage Products 
|
 Add, delete, update stock and images 
|
|
 📋 View All Orders 
|
 Full JOIN report across 5 database tables 
|
|
 🔒 Security Filter 
|
 Blocks customers from accessing admin pages 
|

---

## 🏗️ Architecture — MVC Pattern
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
users ──(1:1)── customer_info
users ──(1:N)── orders
orders ──(1:N)── order_items
products ──(1:N)── order_items


---

## 📁 Project Structure
src/main/
├── java/
│ ├── bean/ → 7 JavaBeans (User, Product, CartItem, Order...)
│ ├── dao/ → DBconnection.java
│ ├── DB/ → Usdao, Productdao, OrderDao
│ ├── hkshop/ → 8 Servlets
│ └── filters/ → SecurityFilter, EncodingFilter
└── webapp/
└── Hkshop/
├── Css/ → customer.css (Teal theme), admin.css (Dark Green theme)
├── Admin/ → 5 Admin JSP pages
└── *.jsp → 7 Customer JSP pages
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

Open `src/main/java/dao/DBconnection.java` and set your MySQL password:
```java
private static final String PASSWORD = "your_password_here";
```

**3. Import into Eclipse:**
- File → Import → Existing Projects into Workspace
- Select the project folder

**4. Add Tomcat server and run:**
- Right click project → Run As → Run on Server

**5. Open in browser:**
http://localhost:8080/hamza/Hkshop/login1.jsp
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