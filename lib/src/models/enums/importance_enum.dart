enum ImportanceEnum {
  low('low'),
  medium('medium'),
  high('high');

  const ImportanceEnum(this.type);
  final String type;
}

extension ConvertImportance on String {
  ImportanceEnum toEnum() {
    switch (this) {
      case 'low':
        return ImportanceEnum.low;
      case 'medium':
        return ImportanceEnum.medium;
      case 'high':
        return ImportanceEnum.high;
      default:
        return ImportanceEnum.low;
    }
  }
}
