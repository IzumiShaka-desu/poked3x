extension StringExtension on String {
  bool get isCodeValid {
    // example of code : 2212T00252K-AMB2311-10329
    // example of code : 2212T00269K-AMB2311-07693
    // using regex to validate squence of code with minium length is 15
    // and 2 chars at first is digit of year and next 2 chars is digit of month
    // and contains one K- and next of K- is 3 chars is capital letter

    RegExp regExp = RegExp(r"^\d{2}\d{2}T\d{5}K-[A-Z]{3}\d{4}");

    return regExp.hasMatch(trim());
  }

  String get capitalized {
    if (isEmpty) return "";
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
