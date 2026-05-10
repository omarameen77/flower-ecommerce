import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto {
  @JsonKey(name: "_id")
  String? id;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "slug")
  String? slug;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "imgCover")
  String? imgCover;

  @JsonKey(name: "images")
  List<String>? images;

  @JsonKey(name: "price")
  int? price;

  @JsonKey(name: "priceAfterDiscount")
  int? priceAfterDiscount;

  @JsonKey(name: "discount")
  int? discount;

  @JsonKey(name: "rateAvg")
  num? rateAvg;

  @JsonKey(name: "rateCount")
  int? rateCount;

  @JsonKey(name: "sold")
  int? sold;

  @JsonKey(name: "quantity")
  int? quantity;

  @JsonKey(name: "category")
  String? category;

  @JsonKey(name: "occasion")
  String? occasion;

  @JsonKey(name: "isSuperAdmin")
  bool? isSuperAdmin;

  @JsonKey(name: "createdAt")
  DateTime? createdAt;

  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;

  @JsonKey(name: "__v")
  int? v;

  @JsonKey(name: "favoriteId")
  dynamic favoriteId;

  @JsonKey(name: "isInWishlist")
  bool? isInWishlist;

  ProductDto({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.discount,
    this.rateAvg,
    this.rateCount,
    this.sold,
    this.quantity,
    this.category,
    this.occasion,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.favoriteId,
    this.isInWishlist,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);

  ProductEntity toDomain() {
    return ProductEntity(
      id: id,
      title: title,
      slug: slug,
      description: description,
      imgCover: imgCover,
      images: images,
      price: price,
      priceAfterDiscount: priceAfterDiscount,
      discount: discount,
      rateAvg: rateAvg,
      rateCount: rateCount,
      sold: sold,
      quantity: quantity,
      category: category,
      occasion: occasion,
      isSuperAdmin: isSuperAdmin,
      createdAt: createdAt,
      updatedAt: updatedAt,
      favoriteId: favoriteId,
      isInWishlist: isInWishlist,
    );
  }
}