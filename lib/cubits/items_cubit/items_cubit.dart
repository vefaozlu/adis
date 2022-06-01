import 'package:adis/service.dart';
import 'package:adis/model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  final Service service;
  ItemsCubit(this.service) : super(const ItemsState.loading());

  Future<void> fetchItems() async {
    late final List<Item> items;
    try {
      items = await service.fetchData();
    } catch (err) {
      emit(const ItemsState.failure());
      throw ("Couldn't catch data");
    }

    List<Item> categoryItems = [];

    for (int i = 0; i < 5; i++) {
      categoryItems.add(items[i + 110]);
    }

    emit(ItemsState.success(
      categoryIndex: state.categoryIndex,
      items: items,
      categoryItems: categoryItems,
    ));
  }

  void getCategory(int categoryIndex) {
    List<Item> items = [];
    switch (categoryIndex) {
      case 0:
        items = _getCategoryItems(1, 17);
        break;
      case 1:
        items = _getCategoryItems(18, 23);
        break;
      case 2:
        items = _getCategoryItems(41, 13);
        break;
      case 3:
        items = _getCategoryItems(54, 20);
        break;
      case 4:
        items = _getCategoryItems(74, 36);
        break;
      default:
        items.add(state.items[0]);
        items.addAll(_getCategoryItems(74, 36));
        break;
    }

    emit(ItemsState.success(
        items: state.items,
        categoryItems: items,
        categoryIndex: categoryIndex));
  }

  List<Item> _getCategoryItems(int startIndex, int length) {
    List<Item> items = [];
    for (int i = 0; i < length; i++) {
      items.add(state.items[i + startIndex]);
    }

    return items;
  }
}
