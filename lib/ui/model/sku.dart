import 'package:freezed_annotation/freezed_annotation.dart';

part 'sku.freezed.dart';

part 'sku.g.dart';

@freezed
abstract class Sku with _$Sku {
  const factory Sku({
    required String name,
    required String description,
    String? imageUrl,
  }) = _Sku;

  factory Sku.fromJson(Map<String, dynamic> json) => _$SkuFromJson(json);
}
