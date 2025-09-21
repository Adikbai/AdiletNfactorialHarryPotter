import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/spell.dart';

part 'spell_model.g.dart';

@JsonSerializable()
class SpellModel extends Spell {
  const SpellModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory SpellModel.fromJson(Map<String, dynamic> json) =>
      _$SpellModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpellModelToJson(this);
}