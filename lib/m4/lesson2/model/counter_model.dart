class CounterModel {
  final int count;
  final String status;

  CounterModel({required this.count, required this.status});

  CounterModel copyWith(
    int? newCount, 
    String? getStatus, 
    ) {
    return CounterModel(
      count: newCount ?? count,
      status: getStatus ?? status,
    );
  }
}
