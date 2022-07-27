class MyEvents {
  String eventTitle;
  String eventDescp;

  MyEvents({required this.eventTitle, required this.eventDescp});

  @override
  String toString() => eventTitle;

  String toString1() => eventDescp;
}
