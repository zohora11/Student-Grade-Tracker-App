import 'package:flutter/foundation.dart';
import 'subject.dart';

/// Provider class for managing subjects and app state
/// Uses ChangeNotifier for reactive state management without setState
class SubjectProvider extends ChangeNotifier {
  final List<Subject> _subjects = [];

  /// Get all subjects
  List<Subject> get subjects => List.unmodifiable(_subjects);

  /// Add a new subject to the list
  /// Notifies listeners when subject is added
  void addSubject(Subject subject) {
    _subjects.add(subject);
    notifyListeners();
  }

  /// Remove subject by index
  /// Notifies listeners when subject is removed
  void removeSubject(int index) {
    if (index >= 0 && index < _subjects.length) {
      _subjects.removeAt(index);
      notifyListeners();
    }
  }

  /// Get total number of subjects
  int get totalSubjects => _subjects.length;

  /// Calculate average marks using .map()
  /// Required: Use .map() or .where() at least once
  double get averageMark {
    if (_subjects.isEmpty) return 0.0;
    final sum = _subjects.map((s) => s.mark).reduce((a, b) => a + b);
    return sum / _subjects.length;
  }

  /// Get overall grade based on average mark
  String get overallGrade {
    final avg = averageMark;
    if (avg >= 80) {
      return 'A';
    } else if (avg >= 65) {
      return 'B';
    } else if (avg >= 50) {
      return 'C';
    } else {
      return 'F';
    }
  }

  /// Get count of subjects by grade using .where()
  /// Required: Use .map() or .where() at least once
  int getSubjectsCountByGrade(String grade) {
    return _subjects.where((s) => s.grade == grade).length;
  }

  /// Get list of subjects with specific grade
  List<Subject> getSubjectsByGrade(String grade) {
    return _subjects.where((s) => s.grade == grade).toList();
  }

  /// Clear all subjects
  void clearAllSubjects() {
    _subjects.clear();
    notifyListeners();
  }
}