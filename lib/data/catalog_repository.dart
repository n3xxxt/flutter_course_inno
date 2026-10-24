import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/entities/space_item.dart';

/// Ошибка работы с каталогом с текстом для пользователя.
class CatalogException implements Exception {
  const CatalogException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Репозиторий каталога и избранного на Cloud Firestore.
class CatalogRepository {
  CatalogRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  static const _timeout = Duration(seconds: 10);
  static const _writeTimeout = Duration(seconds: 5);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _items =>
      _firestore.collection('items');

  DocumentReference<Map<String, dynamic>> _userDoc(String uid) =>
      _firestore.doc('users/$uid');

  Future<List<SpaceItem>> fetchItems() {
    return _guard(() async {
      final snapshot = await _items
          .get(const GetOptions(source: Source.server))
          .timeout(_timeout);
      return _parse(snapshot);
    });
  }

  Stream<List<SpaceItem>> watchItems() {
    return _items.snapshots().map(_parse).transform(_errorMapper());
  }

  Stream<Set<String>> watchFavorites(String uid) {
    return _userDoc(uid)
        .snapshots()
        .map((doc) {
          final favorites = doc.data()?['favorites'];
          if (favorites is! List) return <String>{};
          return favorites.whereType<String>().toSet();
        })
        .transform(_errorMapper());
  }

  Future<void> setFavorite(String uid, String itemId, {required bool liked}) {
    return _write(
      () => _userDoc(uid).set({
        'favorites': liked
            ? FieldValue.arrayUnion([itemId])
            : FieldValue.arrayRemove([itemId]),
      }, SetOptions(merge: true)),
    );
  }

  Future<void> addItem(SpaceItem draft) {
    return _write(
      () => _items.add({
        ...draft.toJson(),
        'createdAt': FieldValue.serverTimestamp(),
      }),
    );
  }

  Future<void> updateItem(SpaceItem item) {
    return _write(() => _items.doc(item.id).update(item.toJson()));
  }

  Future<void> deleteItem(String id) {
    return _write(() => _items.doc(id).delete());
  }

  List<SpaceItem> _parse(QuerySnapshot<Map<String, dynamic>> snapshot) {
    final items = <SpaceItem>[];
    for (final doc in snapshot.docs) {
      final item = _fromDoc(doc);
      if (item != null) items.add(item);
    }
    items.sort((a, b) {
      final x = a.createdAt;
      final y = b.createdAt;
      if (x == null && y == null) return 0;
      if (x == null) return -1;
      if (y == null) return 1;
      return y.compareTo(x);
    });
    return items;
  }

  SpaceItem? _fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    try {
      return SpaceItem.fromJson({
        ...data,
        'id': doc.id,
        'createdAt': (data['createdAt'] as Timestamp?)?.toDate(),
      });
    } on TypeError {
      return null;
    } on ArgumentError {
      return null;
    } on FormatException {
      return null;
    }
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on FirebaseException catch (e) {
      throw CatalogException(_message(e.code));
    } on TimeoutException {
      throw CatalogException(_message('timeout'));
    }
  }

  Future<void> _write(Future<void> Function() action) {
    return _guard(() async {
      try {
        await action().timeout(_writeTimeout);
      } on TimeoutException {
        return;
      }
    });
  }

  StreamTransformer<T, T> _errorMapper<T>() {
    return StreamTransformer<T, T>.fromHandlers(
      handleError: (error, stackTrace, sink) {
        if (error is FirebaseException) {
          sink.addError(CatalogException(_message(error.code)), stackTrace);
        } else if (error is TimeoutException) {
          sink.addError(CatalogException(_message('timeout')), stackTrace);
        } else {
          sink.addError(error, stackTrace);
        }
      },
    );
  }

  String _message(String code) {
    return switch (code) {
      'unavailable' || 'timeout' => 'Нет соединения с сервером',
      'permission-denied' => 'Нет доступа к каталогу',
      'not-found' => 'Объект уже удалён',
      _ => 'Ошибка сервера: $code',
    };
  }
}
