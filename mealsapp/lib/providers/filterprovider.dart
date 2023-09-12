import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AvailaibleFilters { gluttenfree, lactosefree, veganmeals, vegeterianmeals }

class FilterNotifier extends StateNotifier<Map<AvailaibleFilters, bool>> {
  FilterNotifier() : super({
    AvailaibleFilters.gluttenfree:false,
    AvailaibleFilters.lactosefree:false,
    AvailaibleFilters.veganmeals:false,
    AvailaibleFilters.vegeterianmeals:false,
  });

  void setfilters(AvailaibleFilters key, bool value) {
    state = {...state, key: value};
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<AvailaibleFilters, bool>>(
    (ref) => FilterNotifier());
