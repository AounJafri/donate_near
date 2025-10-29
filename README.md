# 💚 DonateNear

**DonateNear** is a Flutter-based mobile application designed to connect **donors** with **NGOs** and **people in need** nearby.  
It promotes community-driven giving by making the donation process simple, quick, and accessible — without requiring user logins or complicated forms.

---

## 🚀 Features

✅ **Anonymous Donations** — No login required. Donors can optionally provide their name.  
✅ **Easy Item Submission** — Add donation details like item type, description, location, and image.  
✅ **Donation Feed** — View all active donations shared by others in a clean, scrollable feed.  
✅ **Responsive UI** — Works smoothly across devices and screen sizes.  
✅ **Storage** — Donations are stored in Firebase database.  
✅ **Splash & Navigation Flow** — Clean splash screen leading to tabbed home screen (Feed & Add Donation).  
✅ **Image Upload Support** — Add item photos from camera or gallery.

---

## 🏗️ App Structure

📁 donate_near_app/
│
├── 📁 lib/
│   ├── 📁 models/
│   │   └── donation_model.dart         # Data model class
│   ├── 📁 services/
│   │   └── donation_service.dart       # Handles data storage (local/Firebase)
│   ├── 📁 screens/
│   │   ├── splash_screen.dart          # Intro splash screen
│   │   ├── home_screen.dart            # Main tabbed home screen
│   │   └── donation_details_screen.dart# Shows full details of a donation
│   ├── 📁 widgets/
│   │   └── donation_card.dart          # Reusable card widget for listing donations
│   └── main.dart                       # App entry point
│
├── pubspec.yaml                        # App dependencies

---

## 🧠 Tech Stack

- **Framework:** Flutter  
- **Language:** Dart  
- **Design:** Material UI  
- **Database :** Firebase  
- **IDE Used:** Visual Studio Code  

---

## 🖼️ Screens Overview

| Screen | Description |
|--------|--------------|
| 🌀 **Splash Screen** | Simple intro screen with app logo. |
| 🏠 **Home Screen** | Tabbed layout with Feed & Add Donation tabs. |
| 📝 **Add Donation Tab** | Add donation with name, type, description, location, and image. |
| 📋 **Feed Tab** | Displays donation list in clean card format. |
| 🔍 **Donation Details** | Detailed view of a selected donation card. |

---

## ⚙️ Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/<your-username>/<repo-name>.git



2. **Navigate into project folder**
  cd donate_near_app



3. **Get dependencies**
  flutter pub get



4. **Run the app**
  flutter run




## 📦 Future Improvements
**🚧 Integration with Firebase for real-time storage**
**🚧 Add location-based donation discovery**
**🚧 Add NGO verification and chat feature**
**🚧 Push notifications for nearby donation alerts**

## 👨‍💻 Developed By
**Aoun Jafri**
**MAD Course Project**



---
