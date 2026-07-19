import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/utils/result_status.dart';

void main() {
  group('ResultStatus', () {
    group('ResultStatus.success', () {
      const successValue = 'Success value';
      final result = ResultStatus<String, Exception>.success(successValue);

      test('isSuccessful is true', () {
        expect(result.isSuccessful, isTrue);
      });

      test('hasError is false', () {
        expect(result.hasError, isFalse);
      });

      test('asSuccess returns the value', () {
        expect(result.asSuccess, equals(successValue));
      });

      test('asError throws StateError', () {
        expect(() => result.asError, throwsA(isA<StateError>()));
      });

      test('when calls onSuccess with value', () {
        String? capturedValue;
        Exception? capturedError;

        result.when(onSuccess: (v) => capturedValue = v, onError: (e) => capturedError = e);

        expect(capturedValue, equals(successValue));
        expect(capturedError, isNull);
      });
    });

    group('ResultStatus.error', () {
      final errorValue = Exception('Error message');
      final result = ResultStatus<String, Exception>.error(errorValue);

      test('isSuccessful is false', () {
        expect(result.isSuccessful, isFalse);
      });

      test('hasError is true', () {
        expect(result.hasError, isTrue);
      });

      test('asError returns the error', () {
        expect(result.asError, equals(errorValue));
      });

      test('asSuccess throws StateError', () {
        expect(() => result.asSuccess, throwsA(isA<StateError>()));
      });

      test('when calls onError with error', () {
        String? capturedValue;
        Exception? capturedError;

        result.when(onSuccess: (v) => capturedValue = v, onError: (e) => capturedError = e);

        expect(capturedValue, isNull);
        expect(capturedError, equals(errorValue));
      });
    });
  });
}
