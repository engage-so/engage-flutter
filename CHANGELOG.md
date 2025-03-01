## [0.3.0] - 2025-02-14

### Changed

- Updated `package_info_plus` to 8.0.2
- Updated `flutter_lints` to 4.0.2
- Replaced `flutter_native_timezone` with `flutter_timezone`

## [0.2.0] - 2023-09-26

### Added

- `logout`: delete the associated device token from the user's profile

## [0.1.0] - 2023-04-04

### Changed

- `init` now requires `await`. Should be called after `WidgetsFlutterBinding.ensureInitialized();`
- `identify` now automatically tracks the customer's timezone (as `tz`). This is to be used for sending messages at recipient's timezone.
- `setDeviceToken` now tracks app version, build and current timestamp to know last sync.

### Added

- `merge`: Merge an anonymous user with an identified user
- `addToAccount`: Add the Customer to an Account
- `removeFromAccount`: Remove the Customer from an Account
- `changeAccountRole`: Change the Customer's role in the Account
- `convertToAccount`: Convert the Customer profile to an Account
- `convertToCustomer`: convert the Account profile to a Customer

## [0.0.2] - 2022-04-08

### Added

- Added `created_at` to `identify`.

## [0.0.1] - 2022-03-30

### Added

- First version. Implemented `setDeviceToken`, `addAttributes`, `trackEvents` and `identify`.
