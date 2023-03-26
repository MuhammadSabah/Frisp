import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/providers/auth_provider.dart';
import 'package:mocktail/mocktail.dart';

import 'user_provider_unit_test.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late AuthProvider authProvider;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockUserCredential mockUserCredential;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockUserCredential = MockUserCredential();
    authProvider = AuthProvider(mockFirebaseAuth, mockFirebaseFirestore);
  });

  group('AuthProvider', () {
    group('signUpUser', () {
      test('should return null if sign up is successful', () async {
        final mockUser = UserModel(
          id: '123',
          userName: 'testuser',
          email: 'test@test.com',
          photoUrl: '',
          bio: '',
          followers: [],
          following: [],
        );
        String mockUserName = 'testuser';
        String mockUserEmail = 'test@test.com';
        String mockUserPassword = '22334455';

        when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
              email: mockUserEmail,
              password: mockUserPassword,
            )).thenAnswer((_) => Future.value(mockUserCredential));

        when(() => mockFirebaseAuth.currentUser)
            .thenReturn(mockUserCredential.user);

        when(() => mockUserCredential.user!.uid).thenReturn(mockUser.id);

        when(() => mockFirebaseFirestore.collection('users').doc(mockUser.id))
            .thenReturn(MockDocumentReference());

        await authProvider.signUpUser(
            userName: mockUserName,
            userEmail: mockUserEmail,
            userPassword: mockUserPassword);

        expect(authProvider.user, null);
      });

      test(
          'should return "The password provided is too weak." if password is weak',
          () async {
        String mockUserName = 'testuser';
        String mockUserEmail = 'test@test.com';
        String mockUserPassword = '223';

        when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
              email: mockUserEmail,
              password: mockUserPassword,
            )).thenThrow(FirebaseAuthException(code: 'weak-password'));

        final result = await authProvider.signUpUser(
          userName: mockUserName,
          userEmail: mockUserEmail,
          userPassword: mockUserPassword,
        );

        expect(result, equals('The password provided is too weak.'));
      });

      test(
          'should return "An account already exists for that email." if email is already in use',
          () async {
        String mockUserEmail = 'test@test.com';
        String mockUserPassword = '123456';

        when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
              email: mockUserEmail,
              password: mockUserPassword,
            )).thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

        final result = await authProvider.signUpUser(
            userName: 'testuser',
            userEmail: mockUserEmail,
            userPassword: mockUserPassword);

        expect(result, equals('An account already exists for that email.'));
      });
      test('should return error when email is invalid', () async {
        // Arrange
        String invalidEmail = 'invalid email';
        String invalidEmailError = 'Email is invalid.';
        when(
          () => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: invalidEmail,
            password: any(named: 'password'),
          ),
        ).thenThrow(FirebaseAuthException(code: 'invalid-email'));

        final result = await authProvider.signUpUser(
            userName: 'Test User',
            userEmail: invalidEmail,
            userPassword: '123456');

        expect(result, equals(invalidEmailError));
      });
    });
    group('logInUser', () {
      test('should sign in the user and return null if successful', () async {
        String mockUserEmail = 'test@test.com';
        String mockUserPassword = 'password';

        when(() => mockFirebaseAuth.signInWithEmailAndPassword(
              email: mockUserEmail,
              password: mockUserPassword,
            )).thenAnswer((_) => Future.value(mockUserCredential));

        await authProvider.logInUser(
          userEmail: mockUserEmail,
          userPassword: mockUserPassword,
        );

        expect(authProvider.user, null);
      });

      test(
          'should return "Password is incorrect." if wrong password is entered',
          () async {
        String mockUserEmail = 'test@test.com';
        String mockUserPassword = 'password';

        when(() => mockFirebaseAuth.signInWithEmailAndPassword(
              email: mockUserEmail,
              password: mockUserPassword,
            )).thenThrow(FirebaseAuthException(code: 'wrong-password'));

        final result = await authProvider.logInUser(
          userEmail: mockUserEmail,
          userPassword: mockUserPassword,
        );

        expect(result, equals('Password is incorrect.'));
        expect(authProvider.user, isNull);
      });

      test('should return "User is not registered." if user not found',
          () async {
        String mockUserEmail = 'test@test.com';
        String mockUserPassword = 'password';

        when(() => mockFirebaseAuth.signInWithEmailAndPassword(
              email: mockUserEmail,
              password: mockUserPassword,
            )).thenThrow(FirebaseAuthException(code: 'user-not-found'));

        final result = await authProvider.logInUser(
          userEmail: mockUserEmail,
          userPassword: mockUserPassword,
        );

        expect(result, equals('User is not registered.'));
        expect(authProvider.user, isNull);
      });

      test('should return "Invalid email." if the email is invalid', () async {
        String mockUserEmail = 'test';
        String mockUserPassword = 'password';

        when(() => mockFirebaseAuth.signInWithEmailAndPassword(
              email: mockUserEmail,
              password: mockUserPassword,
            )).thenThrow(FirebaseAuthException(code: 'invalid-email'));

        final result = await authProvider.logInUser(
          userEmail: mockUserEmail,
          userPassword: mockUserPassword,
        );

        expect(result, equals('Invalid email.'));
        expect(authProvider.user, isNull);
      });
      test('should return "Error occurred" if unknown error', () async {
        String mockUserEmail = 'test@test.com';
        String mockUserPassword = '793845';

        when(() => mockFirebaseAuth.signInWithEmailAndPassword(
              email: mockUserEmail,
              password: mockUserPassword,
            )).thenThrow(Exception('Unknown error'));

        final result = await authProvider.logInUser(
          userEmail: mockUserEmail,
          userPassword: mockUserPassword,
        );

        expect(result, equals('Exception: Unknown error'));
      });
    });
    group('forgetPassword', () {
      final mockAuth = MockFirebaseAuth();
      final mockFirestore = MockFirebaseFirestore();
      final authProvider = AuthProvider(mockAuth, mockFirestore);

      test('should return null if password reset email is sent successfully',
          () async {
        String mockEmail = 'test@test.com';

        when(() => mockAuth.sendPasswordResetEmail(email: mockEmail))
            .thenAnswer((_) => Future.value());
        final result = await authProvider.forgetPassword(email: mockEmail);
        expect(result, null);
      });

      test('should return "User is not registered." if user not found',
          () async {
        String mockEmail = 'test@test.com';

        when(() => mockAuth.sendPasswordResetEmail(email: mockEmail))
            .thenThrow(FirebaseAuthException(code: 'user-not-found'));
        final result = await authProvider.forgetPassword(email: mockEmail);
        expect(result, equals('User is not registered.'));
      });
    });
    group('logOutUser', () {
      test('should log out the user and reset the selected tab', () async {
        when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async => null);
        await authProvider.logOutUser();
        verify(() => mockFirebaseAuth.signOut()).called(1);
        expect(mockFirebaseAuth.currentUser, null);
      });
    });
  });
}
