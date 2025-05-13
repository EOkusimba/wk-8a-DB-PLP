---

# Library Management System

## Overview
The **Library Management System** is a relational database designed to efficiently manage library operations, including **books, authors, publishers, categories, members, librarians, and loans**.

---

## Features
✅ **Structured relational design with clear entity relationships**  
✅ **Many-to-Many relationships** (Books ↔ Authors, Books ↔ Categories)  
✅ **One-to-Many relationships** (Publishers ↔ Books, Members ↔ Loans)  
✅ **Librarian-linked book loan processing**  
✅ **Preloaded sample data for testing and validation**  

---

## Database Schema Structure

### **Main Tables**
| Table        | Description |
|-------------|------------|
| **Publishers** | Stores publisher details |
| **Authors** | Stores author information |
| **Categories** | Defines book genres |
| **Books** | Stores books with publisher references |
| **Members** | Tracks registered library users |
| **Librarians** | Tracks library staff |
| **Loans** | Tracks book borrowing and returns |

### **Relationship Tables**
| Table        | Description |
|-------------|------------|
| **BookAuthors** | Links books and authors (Many-to-Many) |
| **BookCategories** | Links books and categories (Many-to-Many) |

---

## 🔧 Installation & Usage

### **1️⃣ Setup MySQL Database**
Run the following command in MySQL to create the database:
```sql
CREATE DATABASE IF NOT EXISTS LibraryDB;
USE LibraryDB;
```

### **2️⃣ Import the SQL Schema**
Execute the SQL file using:
```sql
source path/to/library_management.sql;
```
Or copy-paste the SQL script into MySQL Workbench.

### **3️⃣ Verify Database Creation**
Run:
```sql
SHOW TABLES;
```

### **4️⃣ Query & Explore**
Test basic queries:
```sql
SELECT * FROM Books;
SELECT * FROM Loans WHERE return_date IS NULL; -- View pending returns
```

---

##  Contribution Guidelines
We welcome contributions to improve the **Library Management System**.  

### **How to Contribute**
📌 **Fork the repository**  
📌 **Create a feature branch** (`git checkout -b feature-update`)  
📌 **Commit changes** (`git commit -m "Added feature"`)  
📌 **Push changes** (`git push origin feature-update`)  
📌 **Submit a pull request (PR)**  

---

## License
This project is open-source under the **MIT License**.

---
