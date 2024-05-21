class BmiState {
  double height = 0;
  double weight = 0;


  double calculateBmi() {
    double heightInMeters = height / 100.0;
    return weight / (heightInMeters * heightInMeters);
  }
}