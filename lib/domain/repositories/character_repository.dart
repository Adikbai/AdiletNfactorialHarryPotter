import 'package:dartz/dartz.dart';
import '../entities/character.dart';
import '../../core/error/failures.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<Character>>> getAllCharacters();
  Future<Either<Failure, List<Character>>> getStudents();
  Future<Either<Failure, List<Character>>> getStaff();
  Future<Either<Failure, List<Character>>> getCharactersByHouse(String house);
}