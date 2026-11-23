import 'package:flutter_test/flutter_test.dart';

import 'package:stream_pro/core/error/safe_call/safe_call.dart';

import 'package:stream_pro/core/error/exceptions/server_exception.dart';
import 'package:stream_pro/core/error/exceptions/gallery_exception.dart';
import 'package:stream_pro/core/error/exceptions/google_auth_exception.dart';

import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/failures/server_failure.dart';
import 'package:stream_pro/core/error/failures/gallery_failure.dart';
import 'package:stream_pro/core/error/failures/google_auth_failure.dart';
import 'package:stream_pro/core/error/failures/unknown_failure.dart';

void main() {
  group('safeCall', () {
    test('should return Right when action succeeds', () async {
      const expectedValue = 'Success';

      final result = await safeCall<String>(() async => expectedValue);

      expect(result.isRight(), isTrue);
      expect(result.getOrElse(() => ''), expectedValue);
    });

    test(
      'should return ServerFailure when ServerException is thrown',
      () async {
        const exception = ServerException('Server error', statusCode: 500);

        final result = await safeCall<String>(() async {
          throw exception;
        });

        expect(result.isLeft(), isTrue);

        final failure = result.fold<Failure?>(
          (failure) => failure,
          (_) => null,
        );

        expect(failure, isA<ServerFailure>());
        expect(failure!.message, exception.message);
        expect((failure as ServerFailure).statusCode, 500);
      },
    );

    test(
      'should return GalleryFailure when GalleryException is thrown',
      () async {
        const exception = GalleryException('Gallery error');

        final result = await safeCall<String>(() async {
          throw exception;
        });

        expect(result.isLeft(), isTrue);

        final failure = result.fold<Failure?>(
          (failure) => failure,
          (_) => null,
        );

        expect(failure, isA<GalleryFailure>());
        expect(failure!.message, exception.message);
      },
    );

    group('GoogleAuthException', () {
      test(
        'should return GoogleAuthFailure when exception is thrown',
        () async {
          const exception = GoogleAuthException('Google auth error');

          final result = await safeCall<String>(() async {
            throw exception;
          });

          expect(result.isLeft(), isTrue);

          final failure = result.fold<Failure?>(
            (failure) => failure,
            (_) => null,
          );

          expect(failure, isA<GoogleAuthFailure>());
          expect(failure!.message, exception.message);
          expect((failure as GoogleAuthFailure).isCancelled, isFalse);
        },
      );

      test('should preserve cancellation state', () async {
        const exception = GoogleAuthException.cancelled();

        final result = await safeCall<String>(() async {
          throw exception;
        });

        expect(result.isLeft(), isTrue);

        final failure = result.fold<Failure?>(
          (failure) => failure,
          (_) => null,
        );

        expect(failure, isA<GoogleAuthFailure>());
        expect(failure!.message, exception.message);
        expect((failure as GoogleAuthFailure).isCancelled, isTrue);
      });
    });

    test('should return UnknownFailure for an unknown exception', () async {
      final exception = Exception('Unexpected error');

      final result = await safeCall<String>(() async {
        throw exception;
      });

      expect(result.isLeft(), isTrue);

      final failure = result.fold<Failure?>((failure) => failure, (_) => null);

      expect(failure, isA<UnknownFailure>());
      expect(failure!.message, exception.toString());
    });
  });
}
