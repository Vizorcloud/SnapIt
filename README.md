SnapIt

Keeping cities clean, one snap at a time.

SnapIt is a native iOS app for reporting vandalism and neighborhood issues. A user takes a photo, the app tags it with their current location, and the report is submitted to a shared backend for review, no forms, no friction, just a photo and a send.

Features
Email/password authentication with session persistence, real-time form validation (email format, password length, confirm-password matching) via a shared AuthenticationFormProtocol, and a session-based root redirect (signed-in users skip straight to the main app, others land on onboarding)
Custom in-app camera built directly on AVFoundation (not the system picker), with live preview, capture, retake, and orientation-aware image correction for both portrait and landscape use
Automatic geotagging of every report using CoreLocation, attaching the reporter's current latitude/longitude at time of capture
Cloud-backed reports stored in Firebase Firestore and Firebase Storage, each report tracked with an image URL, timestamp, coordinates, and review status ("Unreviewed" by default)
Three-tab main app: Home (recent activity feed + quick report entry point), Create Report (camera capture flow), and Profile (user info, report history, account controls)
Home feed showing a scrollable strip of the user's recent report thumbnails, loaded asynchronously from Firebase Storage URLs
Profile view with an initials-based avatar, account details, sign-out/delete controls, and a full history of the user's submitted reports with live status tracking
Community resource link connecting users directly to their city's real-world graffiti removal program
Adaptive camera controls that reflow between horizontal and vertical control bars depending on device orientation
Animated "Report Sent" confirmation screen after a successful submission
Architecture

Built with SwiftUI and the MVVM pattern:

Views: WelcomeView, LoginView, SignupView, RootView (tab container), HomeView, ProfileView, UserProfileView, CameraDataView, CameraView (+ modular subviews for buttons and control bars), LoadingView
View Models: AuthViewModel (shared singleton handling auth state, current user, and report fetching), CameraViewModel (capture session state machine: notStarted → processing → finished), reportModel (per-view report loading)
Models: Report / UserReport (Codable, map directly to Firestore documents via @DocumentID)
Managers: LocationManager (CoreLocation wrapper, publishes live location updates via Combine)

ContentView acts as the app's root router, checking AuthViewModel's session state to decide between the authenticated RootView (tab bar) and the unauthenticated WelcomeView onboarding flow.

The camera pipeline is built natively on AVCaptureSession / AVCapturePhotoOutput rather than relying on UIImagePickerController, giving full control over the capture UI, live preview layer, and device-orientation handling (UIDeviceOrientation extensions map orientation to both video rotation angle and image orientation).

Tech Stack
Language: Swift, SwiftUI
Camera: AVFoundation (AVCaptureSession, AVCapturePhotoOutput)
Location: CoreLocation, MapKit
Backend: Firebase (Auth, Firestore, Storage, Analytics)
Concurrency: Swift Concurrency (async/await, Task)
Status

60+ user-submitted reports collected during testing, with backend response time improvements of ~37% through report structuring and status tracking.
