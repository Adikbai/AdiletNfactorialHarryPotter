import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/character.dart';
import '../repositories/character_repository.dart';
import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';

class GetCharactersByHouse implements UseCase<List<Character>, HouseParams> {
  final CharacterRepository repository;

  GetCharactersByHouse(this.repository);

  @override
  Future<Either<Failure, List<Character>>> call(HouseParams params) async {
    return await repository.getCharactersByHouse(params.house);
  }
}

class HouseParams extends Equatable {
  final String house;

  const HouseParams({required this.house});

  @override
  List<Object?> get props => [house];
}