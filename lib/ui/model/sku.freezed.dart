// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sku.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Sku _$SkuFromJson(Map<String, dynamic> json) {
  return _Sku.fromJson(json);
}

/// @nodoc
class _$SkuTearOff {
  const _$SkuTearOff();

  _Sku call(
      {required String name, required String description, String? imageUrl}) {
    return _Sku(
      name: name,
      description: description,
      imageUrl: imageUrl,
    );
  }

  Sku fromJson(Map<String, Object?> json) {
    return Sku.fromJson(json);
  }
}

/// @nodoc
const $Sku = _$SkuTearOff();

/// @nodoc
mixin _$Sku {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SkuCopyWith<Sku> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkuCopyWith<$Res> {
  factory $SkuCopyWith(Sku value, $Res Function(Sku) then) =
      _$SkuCopyWithImpl<$Res>;
  $Res call({String name, String description, String? imageUrl});
}

/// @nodoc
class _$SkuCopyWithImpl<$Res> implements $SkuCopyWith<$Res> {
  _$SkuCopyWithImpl(this._value, this._then);

  final Sku _value;
  // ignore: unused_field
  final $Res Function(Sku) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$SkuCopyWith<$Res> implements $SkuCopyWith<$Res> {
  factory _$SkuCopyWith(_Sku value, $Res Function(_Sku) then) =
      __$SkuCopyWithImpl<$Res>;
  @override
  $Res call({String name, String description, String? imageUrl});
}

/// @nodoc
class __$SkuCopyWithImpl<$Res> extends _$SkuCopyWithImpl<$Res>
    implements _$SkuCopyWith<$Res> {
  __$SkuCopyWithImpl(_Sku _value, $Res Function(_Sku) _then)
      : super(_value, (v) => _then(v as _Sku));

  @override
  _Sku get _value => super._value as _Sku;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_Sku(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Sku implements _Sku {
  const _$_Sku({required this.name, required this.description, this.imageUrl});

  factory _$_Sku.fromJson(Map<String, dynamic> json) => _$$_SkuFromJson(json);

  @override
  final String name;
  @override
  final String description;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'Sku(name: $name, description: $description, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Sku &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.imageUrl, imageUrl));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(imageUrl));

  @JsonKey(ignore: true)
  @override
  _$SkuCopyWith<_Sku> get copyWith =>
      __$SkuCopyWithImpl<_Sku>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SkuToJson(this);
  }
}

abstract class _Sku implements Sku {
  const factory _Sku(
      {required String name,
      required String description,
      String? imageUrl}) = _$_Sku;

  factory _Sku.fromJson(Map<String, dynamic> json) = _$_Sku.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$SkuCopyWith<_Sku> get copyWith => throw _privateConstructorUsedError;
}
