import 'package:adis/service.dart';
import 'package:adis/models/model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  final Service service;
  ItemsCubit(this.service) : super(const ItemsState.loading());

  Future<void> fetchItems(
      {CategoryName categoryName = CategoryName.main, int index = 0}) async {
    emit(const ItemsState.loading());
    List<Item> items = [];
    try {
      items = await service.fetchData(categoryName.name);
    } catch (err) {
      emit(const ItemsState.failure());
      throw ("Couldn't catch data");
    }

    emit(ItemsState.success(items: items, categoryIndex: index));
  }
}
