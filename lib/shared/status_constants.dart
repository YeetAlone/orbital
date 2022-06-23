enum Status { available, busy, incognito }

extension ParseToString on Status {
  String toShortString() {
    return toString().split('.').last;
  }
}

Status fromString(String string) {
  return Status.values.firstWhere((e) => e.toString() == string);
}
