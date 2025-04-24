🛠 Tools and Packages Used

Tool/Package	Purpose
Riverpod	State management (preferred over Provider due to improved flexibility)
Dio	Networking and API handling (robust and feature-rich)
Freezed	Immutable data classes and unions, with code generation
Flutter Hooks	Simplifies widget state logic
GoRouter	Simplified and declarative routing with deep link support
Logger	Easy and colorful logging
Equatable	Helps value comparison for data classes
intl	Localization and internationalization
flutter_gen	Auto-generates assets and fonts for type-safe usage
build_runner	Code generation for Freezed, json_serializable, etc.
📁 Recommended Folder Structure
bash
Copy
Edit
lib/
├── core/                   # Global utilities, configs, constants, error handling
│   ├── constants/
│   ├── exceptions/
│   ├── utils/
│   └── network/            # Dio setup, interceptors, API client
│
├── features/               # Split by feature for scalability
│   ├── auth/
│   │   ├── data/           # Repositories, data sources, models
│   │   ├── domain/         # Entities and use cases
│   │   └── presentation/   # UI widgets and screens
│   └── dashboard/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── common/                 # Shared widgets, themes, extensions, and dialogs
│   ├── widgets/
│   ├── theme/
│   └── extensions/
│
├── app.dart                # App widget and GoRouter setup
└── main.dart               # Entry point
✅ Best Coding Practices
📦 Project Structure
Modularize features into separate folders for better scalability.

Use core for generic logic reused across features (e.g., error handler, app-wide API client).

🗂 State Management (Riverpod)
Use StateNotifierProvider or AsyncNotifierProvider for state.

Separate logic from UI. UI listens to providers, but doesn’t contain business logic.

Example:

dart
Copy
Edit
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read);
});
🌐 API Integration (Dio)
Create a DioClient with interceptors for logging, token handling.

Use a Base API Response model for consistent API structure handling.

Separate data fetching logic into data_source layer, and use Repository to abstract it.

📃 Model & DTOs (Freezed)
Use Freezed + json_serializable for data classes.

Keep models immutable.

Use .copyWith() and pattern matching with when/map for clean logic.

🌍 Routing (GoRouter)
Use named routes and typed navigation.

Structure routes in a centralized file.

Support deep links and redirection based on authentication state.

💡 UI Design
Keep widgets small and reusable.

Use ConsumerWidget or HookConsumerWidget to read providers.

Use a shared theme in common/theme.

📜 Localization
Use intl and flutter_localizations.

Extract text into .arb files and use AppLocalizations.of(context).

🧪 Testing
Write unit tests for state logic.

Write widget tests for key flows.

Mock external services using mocktail or mockito.

🔐 Security & Performance
Never hardcode secrets or API keys. Use .env or build-time variables.

Cache frequently accessed data (e.g., tokens, user profile) using shared_preferences or flutter_secure_storage.

Avoid rebuilding unnecessary widgets — use const, selectors, and memoization.

