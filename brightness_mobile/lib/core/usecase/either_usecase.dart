import 'package:dartz/dartz.dart';
import '../errors/failure.dart';

abstract class EitherUseCase<Out, In> {
  Future<Either<Failure, Out>> call(In params);
}

class NoParams {
  const NoParams();
}
