import 'package:flutter/foundation.dart';

class FavoritesNotifier extends ChangeNotifier {
  final Set<String> _likedIds = {};

  int get count => _likedIds.length;

  bool isLiked(String id) => _likedIds.contains(id);

  void toggle(String id) {
    if (!_likedIds.remove(id)) _likedIds.add(id);
    notifyListeners();
  }
}
