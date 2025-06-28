class PercentMapper {
  static String roundDouble(double value) {
    int znak = 0;

    for (var ch in value.toString().split('')){
      if (ch == '0'){
        znak++;
      }
      else if (ch != '.' && ch != ','){
        if (znak > 3){
          return value.toStringAsFixed(znak);
        }
        else {
          return value.toStringAsFixed(3);
        }
      }
    }
    return '?';
  }
}
