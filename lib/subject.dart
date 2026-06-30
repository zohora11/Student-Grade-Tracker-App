/// Subject model class for storing subject name and marks
class Subject {
  final String name;
  final double _mark;

  Subject({required this.name, required double mark}) : _mark = mark;

  /// Returns mark value
  double get mark => _mark;

  /// Returns grade based on mark value
  /// A: >=80, B: >=65, C: >=50, F: <50
  String get grade {
    if (_mark >= 80) {
      return 'A';
    } else if (_mark >= 65) {
      return 'B';
    } else if (_mark >= 50) {
      return 'C';
    } else {
      return 'F';
    }
  }

  /// Creates a copy of Subject with modified fields
  Subject copyWith({String? name, double? mark}) {
    return Subject(
      name: name ?? this.name,
      mark: mark ?? this._mark,
    );
  }

  @override
  String toString() => 'Subject(name: $name, mark: $_mark, grade: $grade)';
}