class Bmi {
  final int id;
  final double value;

  Bmi({required this.id, required this.value});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
    };
  }

  factory Bmi.fromMap(Map<String, dynamic> map) {
    return Bmi(
      id: map['id'],
      value: map['value'],
    );
  }
}
