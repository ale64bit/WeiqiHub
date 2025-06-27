enum Rank {
  k30,
  k29,
  k28,
  k27,
  k26,
  k25,
  k24,
  k23,
  k22,
  k21,
  k20,
  k19,
  k18,
  k17,
  k16,
  k15,
  k14,
  k13,
  k12,
  k11,
  k10,
  k9,
  k8,
  k7,
  k6,
  k5,
  k4,
  k3,
  k2,
  k1,
  d1,
  d2,
  d3,
  d4,
  d5,
  d6,
  d7,
  d8,
  d9,
  d10,
  p1,
  p2,
  p3,
  p4,
  p5,
  p6,
  p7,
  p8,
  p9,
  p10;

  @override
  String toString() {
    if (index <= k1.index) return '${30 - index}K';
    if (index <= d10.index) return '${index - k1.index}D';
    return '${index - d10.index}P';
  }

  static String decimalString(double rank) {
    final index = rank.truncate();
    final frac = rank - index;
    if (index < d1.index) {
      if (frac > 0) {
        return '${(29 - index + (1 - frac)).toStringAsFixed(1)}K';
      } else {
        return '${(30 - index).toStringAsFixed(1)}K';
      }
    } else if (index <= d10.index) {
      return '${(index - k1.index + frac).toStringAsFixed(1)}D';
    }
    return '${(index - d10.index + frac).toStringAsFixed(1)}P';
  }
}
