enum TaskSourceType {
  fromTaskTypes(description: 'From task types'),
  fromTaskTag(description: 'From task topic'),
  fromMistakes(description: 'From my mistakes');

  final String description;

  const TaskSourceType({required this.description});
}
