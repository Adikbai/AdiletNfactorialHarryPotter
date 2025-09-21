import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/spell.dart';
import '../../domain/repositories/spell_repository.dart';
import '../../core/error/failures.dart';
import '../datasources/spell_remote_data_source.dart';

class SpellRepositoryImpl implements SpellRepository {
  final SpellRemoteDataSource remoteDataSource;

  SpellRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Spell>>> getAllSpells() async {
    try {
      final spells = await remoteDataSource.getAllSpells();
      return Right(spells);
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