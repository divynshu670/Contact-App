# Flutter Contacts App

## Overview

This Flutter application recreates the core features of the Google Contacts app. It demonstrates contact management functionalities using Flutter and BLoC for state management while following clean architecture principles.

---

## Features Implemented

### Core Features
- **Contact List**
  - Scrollable and alphabetically sorted list of contacts
  - Display of contact name and phone number
  - Local search functionality to filter contacts by name
- **Add Contact**
  - Form with validation for required fields (Name, Phone)
  - Optional email field
- **Edit Contact**
  - Tap on a contact to open a pre-filled form for editing
- **Delete Contact**
  - Delete contact via long press or a dedicated delete icon

### Bonus Features
- Email and phone number format validation
- Light and dark theme support with smooth switching

---

## Technical Details

- **State Management:** flutter_bloc package
- **Data Storage:** In-memory list with a repository pattern (no backend or local database)
- **Architecture:** Clean architecture with separation of data, domain, and presentation layers
- **Folder Structure:** Modular and clean for maintainability and scalability

---

## Getting Started

### Prerequisites
- Flutter SDK installed (version 3.0 or above recommended)
- Dart SDK
- A device or emulator to run the app

### Installation

1. Clone the repository:
   ```bash
   git clone <https://github.com/divynshu670/Contact-App.git>
