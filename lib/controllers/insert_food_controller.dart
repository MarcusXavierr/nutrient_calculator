class InsertFoodController {
  String value;

  dynamic validator(String value) {
    if (value.isEmpty) {
      return "Please fill in the field";
    }
    value = value.replaceAll(',', '.');
    try {
      double.parse(value);
    } catch (e) {
      print(e);
      return "Please enter a valid number";
    }

    return null;
  }

  double saver(String value) {
    double newValue;
    value = value.replaceAll(',', '.');
    newValue = double.parse(value);
    return newValue;
  }
}
