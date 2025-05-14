import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/score_history.dart';

class ScoreStorageService {
  static const String _storageKey = 'quiz_scores';
  final SharedPreferences _prefs;

  ScoreStorageService(this._prefs);

  Future<void> saveScore(ScoreHistory score) async {
    try {
      final scores = await getScores();
      final updatedScores = [...scores, score];

      final trimmedScores = updatedScores.length > 10
          ? updatedScores.sublist(updatedScores.length - 10)
          : updatedScores;

      final scoreList = ScoreHistoryList(scores: trimmedScores);
      final jsonString = jsonEncode(scoreList.toJson());

      if (kDebugMode) {
        print('Saving score: ${score.toJson()}');
        print('All scores: $jsonString');
      }

      final success = await _prefs.setString(_storageKey, jsonString);
      if (!success) {
        throw Exception('Failed to save score to SharedPreferences');
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error saving score: $e');
        print('Stack trace: $stackTrace');
      }
      rethrow;
    }
  }

  Future<List<ScoreHistory>> getScores() async {
    try {
      final scoresJson = _prefs.getString(_storageKey);
      if (scoresJson == null) {
        if (kDebugMode) {
          print('No scores found in storage');
        }
        return [];
      }

      if (kDebugMode) {
        print('Retrieved scores JSON: $scoresJson');
      }

      final scoreList = ScoreHistoryList.fromJson(jsonDecode(scoresJson));
      return List<ScoreHistory>.from(scoreList.scores);
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error getting scores: $e');
        print('Stack trace: $stackTrace');
      }
      return [];
    }
  }

  Future<void> clearScores() async {
    try {
      await _prefs.remove(_storageKey);
      if (kDebugMode) {
        print('Cleared all scores');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing scores: $e');
      }
      rethrow;
    }
  }
}
