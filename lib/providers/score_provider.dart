import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/score_history.dart';
import '../services/score_storage_service.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Initialize SharedPreferences first');
});

final scoreStorageServiceProvider = Provider<ScoreStorageService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ScoreStorageService(prefs);
});

class ScoreHistoryNotifier
    extends StateNotifier<AsyncValue<List<ScoreHistory>>> {
  final ScoreStorageService _storageService;

  ScoreHistoryNotifier(this._storageService)
      : super(const AsyncValue.loading()) {
    loadScores();
  }

  Future<void> loadScores() async {
    try {
      state = const AsyncValue.loading();
      final scores = await _storageService.getScores();
      scores.sort((a, b) => b.date.compareTo(a.date));
      state = AsyncValue.data(scores);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> addScore(ScoreHistory score) async {
    try {
      await _storageService.saveScore(score);
      await loadScores();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> clearScores() async {
    try {
      await _storageService.clearScores();
      state = const AsyncValue.data([]);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final scoreHistoryNotifierProvider =
    StateNotifierProvider<ScoreHistoryNotifier, AsyncValue<List<ScoreHistory>>>(
        (ref) {
  final storageService = ref.watch(scoreStorageServiceProvider);
  return ScoreHistoryNotifier(storageService);
});
