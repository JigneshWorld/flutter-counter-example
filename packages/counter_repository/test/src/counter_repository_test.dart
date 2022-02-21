// ignore_for_file: prefer_const_constructors
import 'package:counter_repository/counter_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'mock.dart';

class MockFirebaseDatabase extends Mock implements FirebaseDatabase {}

class MockDatabaseReference extends Mock implements DatabaseReference {}

class MockDatabaseEvent extends Mock implements DatabaseEvent {}

class MockDataSnapshot extends Mock implements DataSnapshot {}

void main() {
  setupFirebaseDatabaseMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  group('CounterRepository', () {
    late FirebaseDatabase firebaseDatabase;

    setUp(() {
      firebaseDatabase = MockFirebaseDatabase();
    });
    test('can be instantiated', () {
      expect(
        CounterRepository(),
        isNotNull,
      );
    });

    test('onValue emits [1]', () {
      const key = 'counter';
      final dataSnapshot = MockDataSnapshot();
      when(() => dataSnapshot.value).thenReturn(1);
      final event = MockDatabaseEvent();
      when(() => event.snapshot).thenReturn(dataSnapshot);
      final ref = MockDatabaseReference();
      when(() => firebaseDatabase.ref(any())).thenReturn(ref);
      when(() => ref.onValue).thenAnswer((_) => Stream.value(event));

      final repository = CounterRepository(
        database: firebaseDatabase,
      );

      expectLater(repository.onValue(key), emits(1));
    });

    test('set value', () {
      const key = 'counter';
      final dataSnapshot = MockDataSnapshot();
      when(() => dataSnapshot.value).thenReturn(1);
      final event = MockDatabaseEvent();
      when(() => event.snapshot).thenReturn(dataSnapshot);
      final ref = MockDatabaseReference();
      when(() => firebaseDatabase.ref(any())).thenReturn(ref);
      when(() => ref.set(any())).thenAnswer((_) => Future.value());

      final repository = CounterRepository(
        database: firebaseDatabase,
      );

      expectLater(repository.set(key, 1), isNotNull);
    });
  });
}
