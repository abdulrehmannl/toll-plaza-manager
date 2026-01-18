# Toll Plaza Manager App 🚗💨

A comprehensive Flutter application designed to streamline operations at toll plazas. This app helps managers and staff efficiently track vehicle entries, manage toll collections, and monitor plaza activities in real-time.

🚀 Features

* Vehicle Entry Tracking: Record vehicle details, license plates, and entry times efficiently.
* Toll Collection: Calculate and process toll fees based on vehicle type (Car, Truck, Bus, etc.).
* Real-time Dashboard: View daily statistics, total revenue, and traffic flow.
* Staff Management: Manage shift timings and user roles (Admin vs. Staff).
* Report Generation: Export daily or monthly logs for auditing.
* Cross-Platform: Runs smoothly on both Android and iOS.

📸 Screenshots

<img width="200" height="200" alt="image" src="https://github.com/user-attachments/assets/f0605732-e04b-442e-8c7e-884c4fed3bf8" />
![IMG_20260118_234234](https://github.com/user-attachments/assets/e8f113e6-f4a0-437b-8f26-0cbd9cf81a99)
![IMG_20260118_234258](https://github.com/user-attachments/assets/d338df19-059f-404a-b47a-22a1b9e9eab3)
![IMG_20260118_234311](https://github.com/user-attachments/assets/838c9bb7-8381-479b-a9ca-0f8fcee2aef8)
![IMG_20260118_234332](https://github.com/user-attachments/assets/60417e26-4797-4503-b055-e41b334c1494)
![IMG_20260118_234346](https://github.com/user-attachments/assets/b4de8a99-e7a5-493f-8355-4fb74c366a8c)
![IMG_20260118_234400](https://github.com/user-attachments/assets/48ba55ac-81c8-4c13-b628-99940acd5439)
![IMG_20260118_234413](https://github.com/user-attachments/assets/38bd934d-96da-4082-b359-f317e01ac395)
![IMG_20260118_234424](https://github.com/user-attachments/assets/dbe974e2-4ca5-41a4-82cb-259da8cef24f)
![IMG_20260118_234437](https://github.com/user-attachments/assets/50049729-85d0-4f23-ac8e-1c0f44f439aa)
![IMG_20260118_234447](https://github.com/user-attachments/assets/272bca56-c04a-4b3b-bd0b-b8680111bdee)
| ![Dashboard](https://via.placeholder.com/200x400?text=Dashboard) | ![Entry Screen](https://via.placeholder.com/200x400?text=Entry+Screen) | ![Reports](https://via.placeholder.com/200x400?text=Reports) |

🛠️ Installation & Setup

Follow these steps to get the project running on your local machine.

Prerequisites
* [Flutter SDK](https://flutter.dev/docs/get-started/install) installed.
* [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/).
* An Android Emulator or a physical device.

Steps
1.  Clone the repository:
    ```bash
    git clone [https://github.com/abdulrehmannl/toll-plaza-manager.git](https://github.com/abdulrehmannl/toll-plaza-manager.git)
    ```

2.  Navigate to the project directory:
    ```bash
    cd toll-plaza-manager
    ```

3.  Install dependencies:
    ```bash
    flutter pub get
    ```

4.  **Run the app:**
    ```bash
    flutter run
    ```

📂 Project Structure

```text
lib/
├── models/         # Data models (e.g., Vehicle, TollRecord)
├── screens/        # UI Screens (Dashboard, Entry, Settings)
├── widgets/        # Reusable UI components
├── services/       # Backend logic & API calls
├── utils/          # Constants and helper functions
└── main.dart       # Entry point of the application
