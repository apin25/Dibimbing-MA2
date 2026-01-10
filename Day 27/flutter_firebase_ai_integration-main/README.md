# Flutter AI Integration - Recipe Generator

A Flutter application that integrates with Firebase AI (Gemini) to generate cooking recipes based on ingredients or food images. The app provides intelligent recipe suggestions with step-by-step cooking instructions in Indonesian language.

## Features

- 🤖 **AI-Powered Recipe Generation**: Uses Google's Gemini 2.5 Flash model via Firebase AI
- 📸 **Image Recognition**: Generate recipes from food images using image analysis
- 🥘 **Ingredient-Based Recipes**: Create recipes based on available ingredients
- 🇮🇩 **Indonesian Language Support**: All responses are in Indonesian
- 📱 **Cross-Platform**: Supports Android, iOS, Web, Windows, macOS, and Linux

## Prerequisites

Before running this project, ensure you have:

- Flutter SDK (3.9.2 or higher)
- Dart SDK
- Firebase account
- Google Cloud Console access (for Firebase AI)
- Android Studio / VS Code with Flutter extensions
- Device/Emulator for testing

## Setup Instructions

### 1. Clone the Repository

```bash
git clone <your-repository-url>
cd flutter_ai_integration
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Firebase Setup

#### Step 3.1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Enter your project name (e.g., "flutter-ai-integration")
4. Enable Google Analytics (optional)
5. Click "Create project"

#### Step 3.2: Enable Firebase AI

1. In your Firebase project console, go to **Build** → **AI**
2. Click "Get started" on Firebase AI
3. Enable the Firebase AI service
4. This will automatically enable the required APIs in Google Cloud Console

#### Step 3.3: Configure Firebase for Flutter

1. Install Firebase CLI:
   ```bash
   npm install -g firebase-tools
   ```

2. Login to Firebase:
   ```bash
   firebase login
   ```

3. Install FlutterFire CLI:
   ```bash
   dart pub global activate flutterfire_cli
   ```

4. Configure Firebase for your Flutter project:
   ```bash
   flutterfire configure
   ```
   - Select your Firebase project
   - Choose platforms you want to support (Android, iOS, Web, etc.)
   - This will generate `firebase_options.dart` file automatically

#### Step 3.4: Platform-Specific Configuration

**For Android:**
- The `google-services.json` file should be automatically placed in `android/app/`
- Verify the file exists and contains your project configuration

**For iOS:**
- The `GoogleService-Info.plist` file should be automatically placed in `ios/Runner/`
- Verify the file exists in the iOS project

**For Web:**
- Firebase configuration will be added to `web/index.html`

### 4. Activate Firebase AI Logic

#### Step 4.1: Verify AI Service Configuration

The AI service is already configured in <mcfile name="ai_service.dart" path="/Users/ndprtm/project/dibimbing/flutter_ai_integration/lib/services/ai_service.dart"></mcfile>:

- **Model**: Gemini 2.5 Flash
- **System Instructions**: Configured for Indonesian recipe generation
- **Response Format**: JSON format for structured recipe data
- **Features**: Text-based and image-based recipe generation

#### Step 4.2: API Key Configuration (if needed)

If you encounter authentication issues:

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Select your Firebase project
3. Navigate to **APIs & Services** → **Credentials**
4. Ensure Firebase AI API is enabled
5. The Firebase SDK should handle authentication automatically

#### Step 4.3: Test AI Integration

The AI service provides two main methods:

1. **Text-based generation**: `generateText(String prompt)`
2. **Image-based generation**: `generateTextByImage({required String prompt, required List<InlineDataPart> imageParts})`

### 5. Run the Application

#### Development Mode

```bash
flutter run
```

#### Build for Production

**Android:**
```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

**Desktop:**
```bash
# Windows
flutter build windows --release

# macOS
flutter build macos --release

# Linux
flutter build linux --release
```

## Project Structure

```
lib/
├── core/                     # Core utilities and constants
├── data/
│   ├── models/              # Data models (recipe_model.dart)
│   └── repositories/        # Data repositories (recipe_repository.dart)
├── presentation/
│   ├── provider/            # State management providers
│   │   ├── ingredients_provider.dart
│   │   └── recipe_provider.dart
│   └── view/               # UI screens
│       ├── home_page.dart
│       ├── ingredients_page.dart
│       └── recipe_page.dart
├── services/
│   ├── ai_service.dart     # Firebase AI integration
│   └── firebase_service.dart
└── main.dart               # App entry point
```

## Dependencies

### Core Dependencies
- `firebase_core: ^4.1.1` - Firebase core functionality
- `firebase_ai: ^3.3.0` - Firebase AI (Gemini) integration
- `provider: ^6.1.5+1` - State management
- `loader_overlay: ^5.0.0` - Loading indicators
- `image_picker: ^1.2.0` - Image selection functionality

### Development Dependencies
- `flutter_test` - Testing framework
- `flutter_lints: ^5.0.0` - Linting rules

## Usage

1. **Launch the app** on your preferred platform
2. **Navigate to ingredients page** to input available ingredients
3. **Generate recipe** by either:
   - Entering text description of ingredients
   - Taking/selecting a photo of ingredients
4. **View generated recipe** with cooking instructions
5. **Follow the step-by-step instructions** provided by the AI

## Troubleshooting

### Common Issues

1. **Firebase not initialized error**:
   - Ensure `firebase_options.dart` exists
   - Verify Firebase configuration is correct
   - Check platform-specific configuration files

2. **AI API errors**:
   - Verify Firebase AI is enabled in console
   - Check internet connection
   - Ensure proper authentication

3. **Image picker not working**:
   - Add camera/gallery permissions for mobile platforms
   - Check platform-specific configurations

4. **Build errors**:
   - Run `flutter clean && flutter pub get`
   - Verify all dependencies are compatible
   - Check platform-specific build configurations

### Debug Mode

Enable debug mode to see detailed logs:
- AI service logs are enabled in debug mode
- Check console output for detailed error messages

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues and questions:
- Check the troubleshooting section above
- Review Firebase AI documentation
- Create an issue in the repository
