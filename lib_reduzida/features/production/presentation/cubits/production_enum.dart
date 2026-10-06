enum ProductionStatus {
  initial,
  loading,
}

enum ProductionFeedbackStatus {
  none,
  error,
  startUnloading,
  finishUnloading,
  emptyHopper,
  cleaningHopper,
}
