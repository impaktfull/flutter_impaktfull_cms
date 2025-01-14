class PagingInfo<T> {
  final List<T> items;
  final int page;
  final int pageSize;
  final int totalPage;

  const PagingInfo({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalPage,
  });
}
