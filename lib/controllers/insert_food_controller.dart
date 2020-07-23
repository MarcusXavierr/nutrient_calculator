class InsertFoodController {
  String value;

  dynamic validator(String value) {
    if (value.isEmpty) {
      return "Por favor preencha o campo";
    }
    value = value.replaceAll(',', '.');
    try {
      double.parse(value);
    } catch (e) {
      print(e);
      return "Por favor insira um numero válido";
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
