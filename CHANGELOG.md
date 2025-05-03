## 0.0.2

- Fixed bug causing `400 Bad Request` when no query parameters were provided.
- Improved handling of `null` or empty `queryParams` to avoid unnecessary trailing `?` in URLs.
- Minor code cleanup and refactoring for better stability and readability.

## 0.0.1

- Initial release of the package.
- Includes `ApiConnector` for sending GET, POST, PUT, DELETE, PATCH requests.
- Support for:
    - Query parameters and custom headers
    - Authentication via configurable `AuthProvider`
    - Request timeouts
    - JSON body encoding based on Content-Type
    - Response parsing with safe JSON fallback
- Simple and extendable structure for integrating with REST APIs.
