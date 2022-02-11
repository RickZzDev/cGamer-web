extension DoubleExtension on double? {
  String formattedPoints() {
    if (this == null) {
      return "";
    }
    var pointsString = this.toString();
    var pointsSplit = pointsString.split(".");

    if (pointsSplit[1].length > 1) {
      String decimalSplited = pointsSplit[1][0];
      pointsString = pointsSplit[0] + '.' + decimalSplited;
    }

    var pointsSplitString = pointsString.split(".");

    if (pointsSplitString[1] == "0") {
      return pointsString.replaceFirst(RegExp(r"\.[^]*"), "");
    } else {
      return pointsString;
    }
  }
}

// extension IntExtension on int? {
//   //TODO formatacao dos troféus

//   String formattedTrophy() {
//     if (this == null) {
//       return "";
//     }
//     var pointsString = this.toString();
//     var pointsSplit = pointsString.split(".");

//     if (pointsSplit[1].length > 1) {
//       String decimalSplited = pointsSplit[1][0];
//       pointsString = pointsSplit[0] + '.' + decimalSplited;
//     }

//     var pointsSplitString = pointsString.split(".");

//     if (pointsSplitString[1] == "0") {
//       return pointsString.replaceFirst(RegExp(r"\.[^]*"), "");
//     } else {
//       return pointsString;
//     }
//   }
// }

