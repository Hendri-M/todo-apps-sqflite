class Notes {
  final int? id;
  final String priority;
  final String title;
  final String description;
  final DateTime createdAt;

  Notes({
    this.id,
    required this.priority,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        id: json['id'],
        priority: json['priority'],
        title: json['title'],
        description: json['description'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "priority": priority,
        "title": title,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
      };

  Notes copy({
    int? id,
    String? priority,
    String? title,
    String? description,
    DateTime? createdAt,
  }) =>
      Notes(
          id: id ?? this.id,
          priority: priority ?? this.priority,
          title: title ?? this.title,
          description: description ?? this.description,
          createdAt: createdAt ?? this.createdAt);
}
