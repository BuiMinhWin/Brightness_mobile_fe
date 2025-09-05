apps/mobile/
├─ android/ ios/ web/ macos/ linux/ windows/     # Platform-specific
├─ assets/                                      # Images, fonts, lottie...
├─ build/                                       # Generated, không commit
├─ lib/
│  ├─ app/
│  │  ├─ app.dart                               # MaterialApp, theme
│  │  ├─ router.dart                            # GoRouter config
│  │  └─ di.dart                                # Dependency injection
│  ├─ core/
│  │  ├─ config/                                # Env, constants
│  │  ├─ errors/                                # AppException, Failure
│  │  ├─ network/                               # Dio, interceptors
│  │  ├─ theme/                                 # Color, text styles
│  │  ├─ utils/                                 # Helpers, formatters
│  │  └─ widgets/                               # Reusable base widgets
│  ├─ shared/
│  │  ├─ models/                                # Session, Pagination...
│  │  ├─ providers/                             # Riverpod global providers
│  │  └─ services/                              # Storage, Analytics, Push
│  ├─ features/
│  │  ├─ auth/                                  # Authentication feature
│  │  │  ├─ data/                               # API client, repo impl
│  │  │  ├─ domain/                             # Entities, repo contracts
│  │  │  └─ presentation/                       # Screens, controllers, widgets
│  │  ├─ home/                                  # Dashboard, calendar
│  │  │  ├─ data/
│  │  │  ├─ domain/
│  │  │  └─ presentation/
│  │  ├─ settings/                              # Settings screens
│  │  ├─ map/                                   # Map & route tracking                            
│  │  ├─ workout/                               # Workout calendar
│  │  └─ nutrition/                             # Nutrition/kcal summary
│  ├─ l10n/                                     # ARB files (localization)
│  └─ main.dart                                 # Entry point
├─ test/                                        # Unit/widget tests
├─ integration_test/                            # E2E tests
├─ pubspec.yaml                                 # Dependencies
└─ tool/                                        # Codegen, scripts
