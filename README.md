# 📦 no\_code\_api\_connector

![Pub Version](https://img.shields.io/pub/v/no_code_api_connector)
![Issues](https://img.shields.io/github/issues/dhrruvchotai/NoCodeApiConnector)

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
  no_code_api_connector: 
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

### Step 2: Create instance of ApiConfig and set parameters tha you want to include in all api requests

```dart
final apiConfig = ApiConfig(baseUrl: 'https://api.escuelajs.co/api/v1');
```

### Step 3: Create Instance of ApiConnector by passing instance of ApiConfig

```dart
final connector = ApiConnector(apiConfig);
```

### Step 4: Create instance of RequestConfig and set necessary parameters like method and endpoint(path)

```dart
//Get Method
final requestConfig = RequestConfig(
  method: HttpMethod.get,
  path: '/products/16',
);

```

### Step 4: Call an endpoint

```dart
Map<String, dynamic> fetchedData = await connector.sendRequest(requestConfig);
```

You can find more advanced examples in the [`lib/example`](../example) directory.

---

## 📁 Folder Structure

```text
lib/
├── no_code_api_connector.dart
src/
├── api_connector.dart
├── api_config.dart
├── auth_provider.dart
├── request_config.dart
├── response_handler.dart
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

For issues, reach out via the [GitHub Issues](https://github.com/your-username/NoCodeApiConnector/issues) page.

---

Made with ❤️ by \[Dhruv Chotai]

