# 📦 no\_code\_api\_connector

`no_code_api_connector` is a Flutter package that allows you to connect to REST APIs using a simple JSON-based configuration — no backend or manual HTTP logic needed. Perfect for developers who want to set up dynamic API integrations quickly and efficiently with minimal boilerplate.

## 🚀 Features

* 🌐 Easily connect to any REST API with a JSON config
* 🧩 Supports `GET`, `POST`, `PUT`, `DELETE`, and more
* 🔐 Built-in support for Bearer and Basic authentication
* 🔄 Handles headers, query params, and body formats
* 🧪 Developer-friendly and easy to debug
* 🧰 Extensible and ready for production

---

## 🛠 Getting Started

### Prerequisites

* ✅ Flutter SDK ≥ 3.0.0
* ✅ Dart ≥ 2.18.0
* ✅ Internet permission (required for Android/iOS)

### Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  no_code_api_connector: ^0.0.1
```

Then run:

```bash
flutter pub get
```

---

## 📈 Usage

### Step 1: Import the package

```dart
import 'package:no_code_api_connector/no_code_api_connector.dart';
```

### Step 2: Create a JSON config

```dart
final config = {
  "baseUrl": "https://jsonplaceholder.typicode.com",
  "headers": {
    "Content-Type": "application/json"
  },
  "endpoints": {
    "getPosts": {
      "path": "/posts",
      "method": "GET"
    },
    "createPost": {
      "path": "/posts",
      "method": "POST",
      "body": {
        "title": "{{title}}",
        "body": "{{body}}",
        "userId": "{{userId}}"
      }
    }
  }
};
```

### Step 3: Initialize the connector

```dart
final connector = NoCodeApiConnector.fromJson(config);
```

### Step 4: Call an endpoint

```dart
// GET example
final response = await connector.call("getPosts");

if (response.statusCode == 200) {
  print(response.body);
} else {
  print('Error: ${response.statusCode}');
}

// POST example
final postResponse = await connector.call("createPost", variables: {
  "title": "New Post",
  "body": "This is the body of the new post.",
  "userId": 1
});
```

You can find more advanced examples in the [`/example`](./example) directory.

---

## 📁 Folder Structure

```text
lib/
├── no_code_api_connector.dart
example/
├── main.dart
```

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

## 🙌 Contributions

Contributions, suggestions, and feedback are always welcome!

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request

---

## 📬 Contact

For issues, reach out via the [GitHub Issues](https://github.com/your-username/no_code_api_connector/issues) page.

---

Made with ❤️ by \[Your Name]

---

Would you like me to generate shields.io badges or sample demo screenshots for the README?
