class CmsSort {
  /// The `id` of the `CmsHeader` that is sorted on
  final Object headerId;
  final bool ascending;

  const CmsSort({
    required this.headerId,
    required this.ascending,
  });

  @override
  bool operator ==(Object other) =>
      other is CmsSort &&
      other.headerId == headerId &&
      other.ascending == ascending;

  @override
  int get hashCode => Object.hash(headerId, ascending);
}
