// Модель события
/*abstract class TransactionEvent {
  UserEvent({
    required this.type,
    this.id,
    this.accId,
    this.data,
    this.startDate,
    this.endDate
  });
  final String type;
  final int? id;
  final int? accId;
  final Map<String, dynamic>? data;
  final String? startDate;
  final String? endDate;

  // Конструктор, toJson, fromJson...
}

abstract class EventRepository {
  Future<void> saveEvent(TransactionEvent event);
  Future<List<TransactionEvent>> getEvents();
}


// create(data), get(id), update(id), delete(id), period(accId, startDate, endDate)
class TransactionEventRepository implements EventRepository {

}
*/