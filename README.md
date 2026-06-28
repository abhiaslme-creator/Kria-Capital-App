# KRIA CAPITAL App - Setup Guide (Free)

Yeh app aapki website (kriacapitalofficial.blogspot.com) ko Android + iOS app
me dikhata hai, login/signup ke saath. Jab bhi blog par naya post karenge,
app me automatically dikh jayega - kuch alag se karne ki zaroorat nahi.

Pura process FREE hai. Sirf jab Play Store/App Store par publish karoge,
tab Google/Apple ki apni fees lagengi (yeh unavoidable hai):
- Google Play: $25 (ek baar, lifetime)
- Apple App Store: $99/year (sirf agar iPhone users ke liye chahiye)

---

## 🚀 SABSE EASY METHOD: GitHub se Automatic APK (Flutter install nahi karna)

Agar aap chahte hain ki APK khud-ba-khud ban jaye, bina apne computer me
Flutter/Android Studio install kiye, toh yeh karo:

1. https://github.com par free account banao (agar nahi hai)
2. "New Repository" banao (naam: kria-capital-app), private ya public - dono chalega
3. Pehle Firebase setup zaroor kar lo (STEP 4 neeche dekho) aur
   `google-services.json` file ko `android/app/` folder me daal do
4. Iss poore project folder (jo maine diya hai, .github folder ke saath)
   ko GitHub website par upload kar do:
   - Repository page par "uploading an existing file" link milega
   - Sab files/folders drag-drop kar do
   - "Commit changes" par click karo
5. GitHub repository ke **"Actions"** tab me jao
   - Aapko "Build APK" workflow chalta dikhega (automatic shuru ho jata hai)
   - 2-5 minute wait karo
6. Jab green tick (✅) aa jaye, us workflow run par click karo
   - Niche "Artifacts" section me **"kria-capital-app-apk"** milega
   - Usse download kar lo - yehi aapki final APK file hai!

Yeh poora process free hai aur GitHub ke servers khud APK build karte hain -
aapko Flutter ya Android Studio apne computer me install karne ki zaroorat
nahi padti.

---

## STEP 1: Flutter install karo (Free) - sirf agar upar wala method nahi use karna

1. https://flutter.dev/docs/get-started/install par jao
2. Apne OS (Windows/Mac/Linux) ke according Flutter SDK download karo
3. Terminal/Command Prompt me check karo: `flutter --version`
4. Android Studio bhi install kar lo (https://developer.android.com/studio)
   - Yeh Android app build/test karne ke liye chahiye

## STEP 2: Naya Flutter project banao

Terminal me yeh command chalao:

```
flutter create kria_capital_app
cd kria_capital_app
```

Isse ek poora project structure ban jayega (android/, ios/, lib/ folders).

## STEP 3: Diye gaye files copy karo

Maine jo files diye hain (pubspec.yaml aur lib/ folder), unhe apne naye
banaye gaye `kria_capital_app` project ke andar copy/paste/replace kar do:

- `pubspec.yaml` -> project ke root me replace karo
- `lib/main.dart` -> apne project ke `lib/main.dart` ko replace karo
- `lib/screens/login_screen.dart` -> naya folder `lib/screens/` banao aur yeh file usme daalo
- `lib/screens/signup_screen.dart` -> same folder me
- `lib/screens/home_webview_screen.dart` -> same folder me

## STEP 4: Firebase setup (Free - Login ke liye zaroori)

1. https://console.firebase.google.com par jao, Google account se login karo
2. "Add Project" par click karo, naam do "KRIA CAPITAL"
3. Project banne ke baad, left menu me **Authentication** par jao
4. "Get Started" -> "Sign-in method" tab -> **Email/Password** ko Enable karo
5. Ab Android app add karo:
   - Project Overview me Android icon par click karo
   - Package name daalo: `com.kriacapital.app` (ya jo bhi aapne `flutter create` me diya)
   - `google-services.json` file download hogi
   - Isko `android/app/` folder me copy karo
6. iOS app bhi add karna ho to same tarah "Add app" -> iOS icon:
   - Bundle ID daalo (jo `ios/Runner.xcodeproj` me set hai)
   - `GoogleService-Info.plist` download karo
   - Isko `ios/Runner/` folder me copy karo (Xcode me drag-drop karna better hai)

## STEP 5: Android me Firebase plugin add karo

`android/build.gradle` (project level) me, dependencies block me yeh line add karo:

```
classpath 'com.google.gms:google-services:4.4.2'
```

`android/app/build.gradle` (app level) ke sabse last me yeh line add karo:

```
apply plugin: 'com.google.gms.google-services'
```

## STEP 6: Dependencies install karo

Terminal me project folder ke andar:

```
flutter pub get
```

## STEP 7: App run karo (test ke liye)

Phone ko USB se connect karo (ya emulator chalao), phir:

```
flutter run
```

Login screen aana chahiye. Sign up karke ek account banao, login karo -
aapki website WebView me khul jayegi.

## STEP 8: Final APK banao (Android)

```
flutter build apk --release
```

APK file yahan milegi: `build/app/outputs/flutter-apk/app-release.apk`

Yeh file directly apne Android phone me install ho sakti hai (bina Play
Store ke bhi) - bas file ko phone me bhej kar install kar lo.

## STEP 9 (Optional): Play Store / App Store par publish

- Google Play Console (one-time $25): https://play.google.com/console
- Apple Developer Program ($99/year): https://developer.apple.com/programs

---

## Important Notes

- `lib/screens/home_webview_screen.dart` me top par `kWebsiteUrl` variable hai
  - Agar aapko blog ka URL change karna ho, sirf yahan edit karo
- Auto-update automatic hai - WebView seedha live website load karta hai
- Agar koi error aaye to error message Claude ko bhej dena, main madad karunga

## Kya yeh app store me accept hoga?

Apple/Google ko sirf "website wrap kiya hua app" pasand nahi - isliye humne
login/signup (native feature) add kiya hai jo browser me nahi milta. Isse
approval me problem nahi aani chahiye.
