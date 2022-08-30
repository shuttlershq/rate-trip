extension StarName on int {
  String name() {
    switch (this) {
      case 1:
        return 'Very poor';
      case 2:
        return 'Poor';
      case 3:
        return 'Average';
      case 4:
        return 'Good';
      case 5:
        return 'Excellent';
    }
    return 'Unknown';
  }
}
