enum OrderOption {
  dateModified,
  dateCredated;

  String get name {
    return switch (this) {
      OrderOption.dateModified => 'Date Modified',
      OrderOption.dateCredated => 'Date Created'
    };
  }
}
