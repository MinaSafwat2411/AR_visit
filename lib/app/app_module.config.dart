// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ar_visiting_app/app/data/repository/dio_helper_repository.dart'
    as _i82;
import 'package:ar_visiting_app/app/data/repository/dio_helper_repository_interface.dart'
    as _i437;
import 'package:ar_visiting_app/app/domain/usecase/base_use_case.dart'
    as _i1030;
import 'package:ar_visiting_app/app/domain/usecase/base_use_case_interface.dart'
    as _i911;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i437.DioHelperRepositoryInterface>(
        () => _i82.DioHelperRepository());
    gh.lazySingleton<_i911.BaseUseCaseInterface>(() => _i1030.BaseUseCase(
        repository: gh<_i437.DioHelperRepositoryInterface>()));
    return this;
  }
}
