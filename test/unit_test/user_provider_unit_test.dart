import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/providers/user_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

class MockUserModel extends Mock implements UserModel {}

// ignore: subtype_of_sealed_class
class MockDocumentSnapshot<T> extends Mock implements DocumentSnapshot<T> {}

// ignore: subtype_of_sealed_class
class MockFutureDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

// ignore: subtype_of_sealed_class
class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

// ignore: subtype_of_sealed_class
class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

void main() {
  late UserProvider userProvider;
  late FirebaseFirestore firestore;
  late FirebaseAuth auth;

  setUp(() {
    firestore = MockFirebaseFirestore();
    auth = MockFirebaseAuth();
    userProvider = UserProvider(firestore, auth);
  });

  group('UserProvider', () {
    final mockUser = MockUser();
    final mockUserModel = MockUserModel();
    final mockUserCredential = MockUserCredential();
    final mockFutureDocumentSnapshot = MockFutureDocumentSnapshot();
    final mockDocumentReference = MockDocumentReference();
    final mockDocumentSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();
    final mockCollectionReference = MockCollectionReference();

    test('setUserAuthId sets user auth ID and notifies listeners', () async {
      when(() => auth.currentUser).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('test_uid');

      bool notifiedListeners = false;
      userProvider.addListener(() {
        notifiedListeners = true;
      });

      await userProvider.setUserAuthId();
      expect(userProvider.getUserAuthId, equals('test_uid'));
      expect(notifiedListeners, isTrue);
    });

    test('getUserFromDocument returns null when user not logged in', () async {
      when(() => auth.currentUser).thenReturn(null);
      final userModel = await userProvider.getUserFromDocument();
      expect(userModel, isNull);
    });

    // test('getUserFromDocument returns user model when user logged in',
    //     () async {
    //   when(() => mockDocumentSnapshot.exists).thenReturn(true);
    //   when(() => mockDocumentSnapshot.data())
    //       .thenReturn({'userName': 'Test User'});

    //   when(() => firestore.collection('users').doc(mockUser.uid).get())
    //       .thenAnswer((_) async => mockFutureDocumentSnapshot);

    //   when(() => auth.currentUser).thenReturn(mockUser);

    //   final userProvider = UserProvider(firestore, auth);
    //   final userModel = await userProvider.getUserFromDocument();
    //   expect(userModel, isA<UserModel>());
    //   expect(userModel?.userName, equals('Test User'));
    // });
  });
}
