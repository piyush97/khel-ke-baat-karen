class Question {
  String qTitle;
  String qOptions;
  String answer;
  String imageFilePath;

  Question({this.qTitle, this.qOptions, this.answer, this.imageFilePath});

  factory Question.fromMap(Map<String, dynamic> json) => new Question(
      qTitle: json["q_title"],
      qOptions: json["q_options"],
      answer: json["answer"],
      imageFilePath: json["image_file_path"]);

  Map<String, dynamic> toMap() => {
        "q_title": qTitle,
        "q_options": qOptions,
        "answer": answer,
        "image_file_path": imageFilePath
      };
}
