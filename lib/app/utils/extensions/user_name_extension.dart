extension UserNameExtension on String? {
  static String reduceName(String? name) {
    List<String>? list = name!.trim().split(" ");
    int size = list.length;
    String result = "";

    if (size < 3) {
      return name;
    }

    result = list[0] + " " + list[size - 1];

    return result;
  }
}
