class User {
    User({
        required this.uuid,
        this.googleId,
        required this.displayName,
        required this.email,
        required this.createdAt,
        required this.updatedAt,
    });

    String uuid;
    String? googleId;
    String displayName;
    String email;
    DateTime createdAt;
    DateTime updatedAt;

    factory User.fromJson(Map<String, dynamic> json) => User(
        uuid: json["uuid"],
        googleId: json["google_id"],
        displayName: json["displayName"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "google_id": googleId,
        "displayName": displayName,
        "email": email,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
