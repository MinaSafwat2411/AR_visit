# Keep GetX ViewModel-based state management
-keep class * extends androidx.lifecycle.z { *; }

# Keep JSON serialization libraries (Gson, Jackson, Dio)
-keep class com.fasterxml.jackson.databind.** { *; }
-keep class com.google.gson.** { *; }
-keep class retrofit2.** { *; }
-keep class okhttp3.** { *; }

# Keep Flutter Secure Storage
-keep class io.flutter.plugins.sharedpreferences.** { *; }
-keep class io.flutter.plugins.fluttersecurestorage.** { *; }

# Keep all model classes (Replace with your actual package name)
-keep class com.youractualpackagename.models.** { *; }
-keep class com.youractualpackagename.api.** { *; }
