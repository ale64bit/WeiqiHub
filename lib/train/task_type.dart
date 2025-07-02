enum TaskType {
  lifeAndDeath,
  tesuji,
  capture,
  captureRace,
  opening,
  joseki,
  middlegame,
  endgame,
  theory,
  appreciation;

  @override
  String toString() => switch (this) {
        TaskType.lifeAndDeath => 'Life & death',
        TaskType.tesuji => 'Tesuji',
        TaskType.capture => 'Capture stones',
        TaskType.captureRace => 'Capture race',
        TaskType.opening => 'Opening',
        TaskType.joseki => 'Joseki',
        TaskType.middlegame => 'Middlegame',
        TaskType.endgame => 'Endgame',
        TaskType.theory => 'Theory',
        TaskType.appreciation => 'Appreciation'
      };
}
