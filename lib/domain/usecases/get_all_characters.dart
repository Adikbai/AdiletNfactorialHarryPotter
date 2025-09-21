import 'package:dartz/dartz.dart';
import '../entities/character.dart';
import '../repositories/character_repository.dart';
import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';

class GetAllCharacters implements UseCase<List<Character>, NoParams> {
  final CharacterRepository repository;

  GetAllCharacters(this.repository);

  @override
  Future<Either<Failure, List<Character>>> call(NoParams params) async {
    return await repository.getAllCharacters();
  }
}