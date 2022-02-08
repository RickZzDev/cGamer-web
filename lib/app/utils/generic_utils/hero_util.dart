class HeroUtil {
  DateTime? _uniqueId;

  HeroUtil() {
    _uniqueId = DateTime.now();
  }

  String getUniqueId() {
    return _uniqueId.toString();
  }
}
