# 📱 KharchaPlus – Kathmandu Expense & Transit Tracker (Setup Expectations)

**KharchaPlus** is a Flutter-based mobile application tailored for Kathmandu, Nepal. It is designed to help users track daily expenses and navigate local transit routes. **This README outlines the planned structure and feature set. No code has been implemented yet.**

---

## ⚠️ IMPORTANT

> 🧪 This document defines **setup expectations** for the project. Actual app development (code, UI components, logic) has not been started.

---

## 📋 Planned Features

### 🎯 Expense Tracking

* Quick Add Buttons (e.g., + Rs. 30 Bus Fare)
* Categorized Expenses with Icons
* Static expense list grouped by date
* Expense input form with categories, tags, notes, and payment methods

### 📊 Dashboard

* Pie chart breakdown of expenses (by category)
* Monthly budget bar (static data)

### 🚌 Transit Module

* List of Kathmandu city bus routes
* Estimated fare for each route
* Log fare directly as an expense (pre-filled form)

### ⚙️ Settings

* Light/Dark Theme Toggle
* Currency Selector (NPR, USD, etc.)
* Language Toggle (English, Nepali)

---

## 🧱 Tech Stack (Planned)

* **Flutter** (UI framework)
* **Dart** (programming language)
* **Static Dummy Data** (no API/backend in this version)
* **Layered Architecture** (Presentation, Application, Domain, Data)
* **Custom Widgets** for reusability and design consistency

---

## 📁 Expected Project Structure

```
lib/
├── core/               # Theme, constants, utilities
├── presentation/       # UI screens, widgets, navigation
│   ├── pages/
│   ├── widgets/
│   └── routes.dart
├── application/        # State management (basic controllers, dummy logic)
├── domain/             # Models, entities, business rules
├── data/               # Static data and fake repositories
└── main.dart
```

---

## 📌 Notes

* No backend/API integration in this version
* All data interactions will be simulated using dummy models
* Focus is on clean UI, routing, and screen transitions

---

## 🛠 Setup Goals

* Establish folder structure
* Define UI components (in Figma or sketches)
* Write static models and sample data classes
* Build 5-6 key screens with reusable layout

---

## 🔄 Future Phases (Post UI Setup)

* Backend in Golang (REST APIs, Auth, Sync)
* Real-time transit data integration
* Firebase, eSewa, Khalti integration
* Offline-first architecture and cloud sync

---

## 📄 License (Future)

MIT License © 2025 Renish Ojha
