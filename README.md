# DeviceDiagnostics

A lightweight diagnostics module for iOS that collects battery level data and sends it to a remote server every 2 minutes.

---

## 🔧 Features

- Collects battery level using `UIDevice.current.batteryLevel`
- Sends data every 2 minutes using efficient `DispatchSourceTimer`
- Background execution support via `UIBackgroundTask`
- Optional Base64 encoding for basic data obfuscation
- Clean JSON API request using `POST` method
- Modular architecture (Swift, SwiftUI)

---

## 📦 Project Structure

```
DeviceDiagnostics/
├── Models/              # Codable models (e.g., BatteryData)
├── Services/            # Core logic (DeviceDataService, NetworkService)
│   └── Network/         # Endpoint protocol, APIEndpoint, HTTPMethod
├── ViewModels/          # Optional for binding data to UI
├── Views/               # SwiftUI views
├── Config.swift         # Constants like base URL, interval, etc.
```

---

## ⚙️ Configuration

```swift
enum Config {
    static let baseUrl = "https://jsonplaceholder.typicode.com"
    static let dataSyncInterval: TimeInterval = 2 * 60
    static let backgroundTaskName = "SendBatteryData"
}
```

---

## 🔐 Basic Data Protection

- Supports Base64 encoding of JSON payload before sending.
- When enabled, Content-Type is set to `text/plain`.
- Can be toggled via `useBase64: Bool` in `NetworkService.send(...)`.

---

## 🧪 How It Works

1. `DeviceDataService` starts monitoring battery level.
2. Every 2 minutes, it reads battery level and triggers a background-safe task.
3. Sends JSON (or Base64) data to `https://jsonplaceholder.typicode.com/posts` via `NetworkService`.
4. Logs responses and errors to the console.

---

## ✅ Requirements

- Xcode 15+
- iOS 15+
- Swift 5.8+

---

## 🧼 Code Style & Best Practices

- Singleton for background service (`DeviceDataService`)
- GCD-based timer (battery-friendly)
- Network abstraction using `Endpoint` protocol
- No force-unwrapping, all data is safely handled
- Test-friendly modular structure

---

## 📄 Example JSON

```json
{
  "level": 0.77
}
```

If `useBase64 = true`:

```
eyJsZXZlbCI6MC43N30=
```
---

## 📤 Author

Igor Karyi  
iOS Developer — August 2025
