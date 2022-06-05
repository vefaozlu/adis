part of 'items_cubit.dart';

enum ItemsStatus { loading, success, failure }

@immutable
class ItemsState extends Equatable {
  const ItemsState._({
    this.status = ItemsStatus.loading,
    this.items = const [],
    this.categoryIndex = 0,
  });

  const ItemsState.loading() : this._();

  const ItemsState.success({
    required List<Item> items,
    required int categoryIndex,
  }) : this._(
          status: ItemsStatus.success,
          items: items,
          categoryIndex: categoryIndex,
        );

  const ItemsState.failure() : this._(status: ItemsStatus.failure);

  final ItemsStatus status;
  final List<Item> items;
  final int categoryIndex;

  @override
  List<Object> get props => [status, items, categoryIndex];
}
