class Question {
  int id;
  String qTitle;
  String qOptions;
  String answer;
  String imageFilePath;

  Question(
      {this.id, this.qTitle, this.qOptions, this.answer, this.imageFilePath});

  factory Question.fromMap(Map<String, dynamic> json) => new Question(
      id: json["id"],
      qTitle: json["q_title"],
      qOptions: json["q_options"],
      answer: json["answer"],
      imageFilePath: json["image_file_path"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "q_title": qTitle,
        "q_options": qOptions,
        "answer": answer,
        "image_file_path": imageFilePath
      };
}
