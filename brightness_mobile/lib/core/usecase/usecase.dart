import '../errors/failure.dart';
import '../utils/either.dart';

abstract class UseCase<Out, In> {
  Future<Out> call(In params);
}

class NoParams {
  const NoParams();
}


abstract class UseCaseRegister<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}
