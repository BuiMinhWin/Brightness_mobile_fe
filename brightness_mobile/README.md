# Brightness Mobile

Feature-first, clean-architecture scaffold for microservices (auth, user, catalog, order, payment).

## Structure

- `lib/core`: config (env/flavors), DI, network, errors, usecases
- `lib/features/<feature>`: `data/`, `domain/`, `presentation/`
- `lib/app/app.dart`: root `MaterialApp` and global providers
- `lib/main.dart`: bootstraps flavor + DI

## Environments (dev/stg/prod)

Run with `--dart-define` to select flavor and customize base URLs per service.

Examples:

```
flutter run \
  --dart-define=FLAVOR=dev \
  --dart-define=API_AUTH_BASE_URL=http://localhost:8081 \
  --dart-define=API_USER_BASE_URL=http://localhost:8082 \
  --dart-define=API_CATALOG_BASE_URL=http://localhost:8083 \
  --dart-define=API_ORDER_BASE_URL=http://localhost:8084 \
  --dart-define=API_PAYMENT_BASE_URL=http://localhost:8085

flutter run --dart-define=FLAVOR=stg
flutter run --dart-define=FLAVOR=prod
```

Defaults are defined in `lib/core/config/app_config.dart`.

## Dependency Injection

`get_it` is set up in `lib/app/di.dart`. Register core services and feature services here.

## Feature Example

Auth feature contains:

- `domain`: `AuthToken` entity, `AuthRepository`, `LoginUseCase`
- `data`: `AuthRemoteDataSource`, `AuthRepositoryImpl`
- `presentation`: `LoginController` (Provider) + `LoginPage`

## Testing

- Add unit tests per usecase/repository. Example targets:
  - `features/<feature>/domain/usecases/*_test.dart`
  - Mock data sources to isolate repository logic

## Next Steps

- Add routing (e.g., `go_router`) and app-level navigation
- Register additional feature services in `injector.dart`
- Implement real models with `json_serializable`
