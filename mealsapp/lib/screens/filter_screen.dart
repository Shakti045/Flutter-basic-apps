import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/providers/filterprovider.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});

  @override
  ConsumerState<FilterScreen> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    final filters = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter meals by your choice'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text(
              'Vegeterian only',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            subtitle: const Text('Only vegeterian meals will display'),
            onChanged: (value) {
              ref.read(filterProvider.notifier).setfilters(
                  AvailaibleFilters.vegeterianmeals, value);
            },
            value: filters.containsKey(AvailaibleFilters.vegeterianmeals)
                ? filters[AvailaibleFilters.vegeterianmeals]!
                : false,
          ),
          SwitchListTile(
            value: filters.containsKey(AvailaibleFilters.gluttenfree)
                ? filters[AvailaibleFilters.gluttenfree]!
                : false,
            onChanged: (value) {
              ref
                  .read(filterProvider.notifier)
                  .setfilters(AvailaibleFilters.gluttenfree, value);
            },
            title: const Text(
              'Glutter-Free',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            subtitle: const Text('Only includes glutten-free meals'),
          ),
          SwitchListTile(
            value: filters.containsKey(AvailaibleFilters.lactosefree)
                ? filters[AvailaibleFilters.lactosefree]!
                : false,
            onChanged: (value) {
              ref
                  .read(filterProvider.notifier)
                  .setfilters(AvailaibleFilters.lactosefree, value);
            },
            title: const Text(
              'Lactose-Free',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            subtitle: const Text('Only includees lactose-free meals'),
          ),
          SwitchListTile(
            value: filters.containsKey(AvailaibleFilters.veganmeals)
                ? filters[AvailaibleFilters.veganmeals]!
                : false,
            onChanged: (value) {
              ref
                  .read(filterProvider.notifier)
                  .setfilters(AvailaibleFilters.veganmeals, value);
            },
            title: const Text(
              'Vegan meals',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            subtitle: const Text('Only includees lvegan meals'),
          )
        ],
      ),
    );
  }
}
