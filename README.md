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

| Dashboard | Entry Screen | Reports |

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
