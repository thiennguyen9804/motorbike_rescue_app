String getVietnameseInstruction(Map<String, dynamic> step) {
  final type = step['maneuver']['type'];
  final modifier = step['maneuver']['modifier'];
  final name = (step['name'] as String).trim();
  final hasStreet = name.isNotEmpty;

  switch (type) {
    case 'depart':
      return hasStreet ? 'Khởi hành tại $name' : 'Bắt đầu hành trình';
    case 'turn':
      final direction = _translateModifier(modifier);
      return hasStreet ? 'Rẽ $direction vào $name' : 'Rẽ $direction';
    case 'new name':
      return hasStreet ? 'Tiếp tục đi trên $name' : 'Tiếp tục đi thẳng';
    case 'arrive':
      return 'Đến nơi';
    default:
      return 'Đi tiếp';
  }
}

String _translateModifier(String? modifier) {
  switch (modifier) {
    case 'left':
      return 'trái';
    case 'right':
      return 'phải';
    case 'straight':
      return 'thẳng';
    case 'slight right':
      return 'chếch phải';
    case 'slight left':
      return 'chếch trái';
    case 'sharp right':
      return 'gấp phải';
    case 'sharp left':
      return 'gấp trái';
    default:
      return 'theo hướng chỉ dẫn';
  }
}
