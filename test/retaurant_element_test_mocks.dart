import 'package:mockito/mockito.dart' as _i1;
import 'package:restaurant_app/provider/restaurant_detail_provider.dart' as _i2;
import 'package:restaurant_app/data/api/api_service.dart' as _i3;

class MockRestauralDetailProvider extends _i1.Mock implements _i2.RestaurantDetailProvider {
  MockRestauralDetailProvider() {
    _i1.throwOnMissingStub(this);
  }
}

class MockApiService extends _i1.Mock implements _i3.ApiService {
  MockApiService() {
    _i1.throwOnMissingStub(this);
  }
}