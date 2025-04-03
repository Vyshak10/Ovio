import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class PeriodStorageService {
  static const String _storageKey = 'period_dates';

  Future<void> savePeriodDates(Set<DateTime> dates) async {
    try {
      if (dates.isEmpty) {
        await clearPeriodDates();
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      final List<String> datesList = dates
          .map((date) => date.toIso8601String())
          .toList()
        ..sort();
      await prefs.setString(_storageKey, json.encode(datesList));
    } catch (e) {
      throw Exception('Failed to save period dates: $e');
    }
  }

  Future<Set<DateTime>> loadPeriodDates() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? datesJson = prefs.getString(_storageKey);
      
      if (datesJson == null || datesJson.isEmpty) {
        return {};
      }

      final List<dynamic> datesList = json.decode(datesJson);
      final Set<DateTime> result = {};
      
      for (var dateStr in datesList) {
        try {
          final date = DateTime.parse(dateStr.toString());
          if (date.isBefore(DateTime(2000)) || date.isAfter(DateTime(2050))) {
            continue; // Skip invalid dates
          }
          result.add(date);
        } catch (e) {
          // Skip invalid date strings
          continue;
        }
      }
      
      return result;
    } catch (e) {
      throw Exception('Failed to load period dates: $e');
    }
  }

  Future<void> clearPeriodDates() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_storageKey);
    } catch (e) {
      throw Exception('Failed to clear period dates: $e');
    }
  }

  Future<List<String>> getFormattedDates() async {
    try {
      final dates = await loadPeriodDates();
      if (dates.isEmpty) {
        return [];
      }
      
      final dateFormat = DateFormat('MMMM d, yyyy');
      return dates
          .map((date) => dateFormat.format(date))
          .toList()
        ..sort();
    } catch (e) {
      throw Exception('Failed to format dates: $e');
    }
  }

  Future<String> getDatesAsString() async {
    try {
      final dates = await getFormattedDates();
      if (dates.isEmpty) {
        return 'No period dates recorded';
      }
      return dates.join('\n');
    } catch (e) {
      throw Exception('Failed to get dates as string: $e');
    }
  }
}