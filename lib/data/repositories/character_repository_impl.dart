import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/character.dart';
import '../../domain/repositories/character_repository.dart';
import '../../core/error/failures.dart';
import '../datasources/character_remote_data_source.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Character>>> getAllCharacters() async {
    try {
      final characters = await remoteDataSource.getAllCharacters();
      return Right(characters);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      return const Left(ServerFailure(message: 'Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<Character>>> getStudents() async {
    try {
      final characters = await remoteDataSource.getStudents();
      return Right(characters);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      return const Left(ServerFailure(message: 'Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<Character>>> getStaff() async {
    try {
      final characters = await remoteDataSource.getStaff();
      return Right(characters);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      return const Left(ServerFailure(message: 'Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<Character>>> getCharactersByHouse(String house) async {
    try {
      final characters = await remoteDataSource.getCharactersByHouse(house);
      return Right(characters);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      return const Left(ServerFailure(message: 'Unexpected error occurred'));
    }
  }

  Failure _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(message: 'Connection timeout');
      case DioExceptionType.badResponse:
        return ServerFailure(
          message: 'Server error: ${e.response?.statusCode}',
        );
      case DioExceptionType.cancel:
        return const NetworkFailure(message: 'Request was cancelled');
      case DioExceptionType.connectionError:
        return const NetworkFailure(message: 'No internet connection');
      default:
        return const ServerFailure(message: 'Unexpected error occurred');
    }
  }
}