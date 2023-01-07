build:
	flutter pub run build_runner

build-watch:
	flutter pub run build_runner watch

golden-update:
	flutter test --update-goldens test/golden_test.dart
golden-test:
	flutter test test/golden_test.dart
