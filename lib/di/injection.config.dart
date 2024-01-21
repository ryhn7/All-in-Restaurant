// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:restaurant_app/core/data/remote/api_config.dart' as _i3;
import 'package:restaurant_app/data/remote/restaurant_api.dart' as _i4;
import 'package:restaurant_app/data/repositories/restaurant_repository_impl.dart'
    as _i5;
import 'package:restaurant_app/di/all_in_module.dart' as _i11;
import 'package:restaurant_app/domain/use_case/get_all_restaurant.dart' as _i6;
import 'package:restaurant_app/domain/use_case/get_restaurant_by_id.dart'
    as _i7;
import 'package:restaurant_app/domain/use_case/use_cases_restaurant.dart'
    as _i8;
import 'package:restaurant_app/ui/view_model/restaurant_detail_view_model.dart'
    as _i9;
import 'package:restaurant_app/ui/view_model/restaurant_list_view_model.dart'
    as _i10;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final allInModule = _$AllInModule();
    gh.singleton<_i3.ApiConfig>(allInModule.apiConfig);
    gh.factory<_i4.RestaurantApi>(() => allInModule.restaurantApi);
    gh.singleton<_i5.RestaurantRepository>(allInModule.restaurantRepository);
    gh.singleton<_i6.SGetAllRestaurant>(allInModule.getAllRestaurant);
    gh.singleton<_i7.TGetRestaurantById>(allInModule.getRestaurantById);
    gh.singleton<_i8.UseCasesRestaurant>(allInModule.useCasesRestaurant);
    gh.singleton<_i9.ZRestaurantDetailViewModel>(
        allInModule.restaurantDetailViewModel);
    gh.singleton<_i10.ZRestaurantListViewModel>(
        allInModule.restaurantListViewModel);
    return this;
  }
}

class _$AllInModule extends _i11.AllInModule {}
