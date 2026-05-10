
class OccasionEntity {
  final String? id;
  final String? name;
  final String? slug;
  final String? image;
  final bool? isSuperAdmin;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? productsCount;

  const OccasionEntity({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.productsCount,
  });
}