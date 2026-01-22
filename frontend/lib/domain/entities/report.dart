class Report {
  final int id;
  final int userId;
  final String title;
  final String description;
  final String category;
  final String imagePath;
  final String urgency;
  final String createdAt;
  final String? metadata;
  final String status;

  Report({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.category,
    required this.imagePath,
    required this.urgency,
    required this.createdAt,
    this.metadata,
    required this.status,
  });
}
