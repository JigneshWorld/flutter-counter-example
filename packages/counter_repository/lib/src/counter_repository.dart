import 'package:firebase_database/firebase_database.dart';

/// Counter App Key
const keyCountersApp = 'counters_app';

/// {@template counter_repository}
/// CounterRepository to manage counter values using firebase database
/// {@endtemplate}
class CounterRepository {
  /// {@macro counter_repository}
  CounterRepository({FirebaseDatabase? database})
      : _database = database ?? FirebaseDatabase.instance;

  final FirebaseDatabase _database;

  /// listen value changes for specific counter using key
  Stream<int> onValue(String key, {int defaultValue = 0}) {
    return _database
        .ref('$keyCountersApp/$key')
        .onValue
        .map((event) => (event.snapshot.value as int?) ?? defaultValue);
  }

  /// set value for specific counter using key
  Future<void> set(String key, int value) {
    return _database.ref('$keyCountersApp/$key').set(value);
  }
}
