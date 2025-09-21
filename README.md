# harry_potter_adilet

# Harry Potter Flutter App

A Flutter application built with Clean Architecture principles that displays Harry Potter characters and spells using the HP API.

## Architecture

This project follows Clean Architecture with the following layers:

### 🏗️ Project Structure

```
lib/
├── core/
│   ├── di/
│   │   └── service_locator.dart      # Dependency injection setup
│   ├── error/
│   │   └── failures.dart             # Error handling
│   └── usecases/
│       └── usecase.dart               # Base use case class
├── data/
│   ├── datasources/
│   │   ├── character_remote_data_source.dart
│   │   └── spell_remote_data_source.dart
│   ├── models/
│   │   ├── character_model.dart       # Data model with JSON serialization
│   │   └── spell_model.dart
│   └── repositories/
│       ├── character_repository_impl.dart
│       └── spell_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── character.dart             # Business entities
│   │   └── spell.dart
│   ├── repositories/
│   │   ├── character_repository.dart  # Repository interfaces
│   │   └── spell_repository.dart
│   └── usecases/
│       ├── get_all_characters.dart    # Business logic
│       ├── get_students.dart
│       ├── get_staff.dart
│       ├── get_characters_by_house.dart
│       └── get_all_spells.dart
├── presentation/
│   └── cubits/
│       ├── character/
│       │   ├── character_cubit.dart   # State management
│       │   └── character_state.dart
│       └── spell/
│           ├── spell_cubit.dart
│           └── spell_state.dart
├── features/
│   └── home_page/
│       └── home_page.dart             # UI screens
├── network/
│   ├── hp_urls.dart                   # API endpoints
│   └── rest_client.dart               # HTTP client wrapper
└── main.dart
```

## 🛠️ Technologies Used

- **Flutter & Dart** - Framework and language
- **Clean Architecture** - Project structure and separation of concerns
- **Cubit (flutter_bloc)** - State management
- **Dio** - HTTP client for API requests
- **GetIt** - Dependency injection
- **json_annotation** - JSON serialization/deserialization
- **Dartz** - Functional programming (Either type)
- **Equatable** - Value object comparison

## 🔧 Setup Instructions

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd harry_potter_adilet
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🔄 Data Flow

1. **UI Layer** (Presentation) → Triggers actions via Cubit
2. **Cubit** → Calls use cases from Domain layer
3. **Use Cases** → Use repository interfaces from Domain layer
4. **Repository Implementation** (Data) → Implements domain interfaces
5. **Data Sources** → Make API calls using Dio
6. **Models** → Convert JSON to entities and back

## 🚀 Available API Endpoints

- `GET /characters` - All characters
- `GET /characters/students` - Hogwarts students
- `GET /characters/staff` - Hogwarts staff
- `GET /characters/house/{house}` - Characters by house
- `GET /spells` - All spells
