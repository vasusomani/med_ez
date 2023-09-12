class Exercise {
  final int srNo;
  final String nameOfExercise;
  final String reps;
  final String sets;
  final String noOfDays;
  final String nextReview;
  final String link;

  Exercise({
    required this.srNo,
    required this.nameOfExercise,
    required this.reps,
    required this.sets,
    required this.noOfDays,
    required this.nextReview,
    required this.link,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      srNo: json['SrNo'],
      nameOfExercise: json['NameOfExercise'],
      reps: json['Reps'],
      sets: json['Sets'],
      noOfDays: json['NoOfDays'].toString(),
      nextReview: json['NextReview'],
      link: json['Link'],
    );
  }
}
