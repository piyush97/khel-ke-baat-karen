class RewardModel {
  int id;
  String imagePath;
  String rewardPoints;

  RewardModel({
    this.id,
    this.imagePath,
    this.rewardPoints,
  });

  factory RewardModel.fromMap(Map<String, dynamic> json) => new RewardModel(
      id: json["id"],
      imagePath: json["image_path"],
      rewardPoints: json["reward_points"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "image_path": imagePath,
        "reward_points": rewardPoints,
      };
}
