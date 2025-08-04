# strider

`strider` is a Dart package for creating Swift-like Strides.

## License

This project is licensed under the [MIT License](LICENSE).

## Features

- No external dependencies

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
	strider: ^<latest_version>
```

Then run:

```sh
dart pub get
```

## Usage

Import the package:

```dart
import 'package:strider/strider.dart';
```

### Creating Dates

```dart
final date = CalendarDate(2025, 8, 4);
final today = CalendarDate.local();
final todayUtc = CalendarDate.zulu();
final today2 = CalendarDate.fromDateTime(DateTime.now());
final today2Utc = CalendarDate.fromDateTime(DateTime.timestamp());
```

### Date Arithmetic

```dart
final tomorrow = date + const Duration(days: 1); 
final yesterday = date - const Duration(days: 1);
```

### Date Ranges and Stride

```dart
for (final d in date.to(tomorrow, by: const Duration(days: 1))) {
	print(d);
}
```
```
OUT:
2025-08-04
2025-08-05
```
### Comparison

```dart
if (date > CalendarDate(2025, 1, 1)) {
	print('Date is after Jan 1, 2025');
}
```

## Contributing

Contributions are welcome! Please open issues or submit pull requests on [GitHub](https://github.com/davidpryor/strider).

1. Fork the repository
2. Create a feature branch
3. Write tests for your changes
4. Open a pull request

