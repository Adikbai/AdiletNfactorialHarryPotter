import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/character.dart';

part 'character_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CharacterModel extends Character {
  @JsonKey(name: 'alternate_names')
  @override
  final List<String> alternateNames;
  
  @JsonKey(name: 'dateOfBirth')
  @override
  final String? dateOfBirth;
  
  @JsonKey(name: 'yearOfBirth')
  @override
  final int? yearOfBirth;
  
  @JsonKey(name: 'eyeColour')
  @override
  final String eyeColour;
  
  @JsonKey(name: 'hairColour')
  @override
  final String hairColour;
  
  @JsonKey(name: 'hogwartsStudent')
  @override
  final bool hogwartsStudent;
  
  @JsonKey(name: 'hogwartsStaff')
  @override
  final bool hogwartsStaff;
  
  @JsonKey(name: 'alternate_actors')
  @override
  final List<String> alternateActors;

  const CharacterModel({
    required super.id,
    required super.name,
    required this.alternateNames,
    required super.species,
    required super.gender,
    required super.house,
    this.dateOfBirth,
    this.yearOfBirth,
    required super.wizard,
    required super.ancestry,
    required this.eyeColour,
    required this.hairColour,
    super.wand,
    required super.patronus,
    required this.hogwartsStudent,
    required this.hogwartsStaff,
    required super.actor,
    required this.alternateActors,
    required super.alive,
    required super.image,
  }) : super(
          alternateNames: alternateNames,
          dateOfBirth: dateOfBirth,
          yearOfBirth: yearOfBirth,
          eyeColour: eyeColour,
          hairColour: hairColour,
          hogwartsStudent: hogwartsStudent,
          hogwartsStaff: hogwartsStaff,
          alternateActors: alternateActors,
        );

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);
}