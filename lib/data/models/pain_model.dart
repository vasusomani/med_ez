class Pain {
  final String date;
  final String painScale;
  final String comments;

  Pain({
    required this.date,
    required this.painScale,
    required this.comments,
  });

  factory Pain.fromJson(Map<String, dynamic> json) {
    return Pain(
      date: json["Date"],
      painScale: json["PainScale"],
      comments: json["Comments"],
    );
  }
}
