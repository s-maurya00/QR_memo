class Item {
  int? id;
  String? name;
  String? descp;
  int? isCompleted;
  String? date;
  String? notifyTime;
  int? color;
  int? remind;
  String? repeat;

  Item({
    this.id,
    this.name,
    this.descp,
    this.isCompleted,
    this.date,
    this.notifyTime,
    this.color,
    this.remind,
    this.repeat,
  });

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'].toString();
    descp = json['descp'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    notifyTime = json['startTime'];
    color = json['color'];
    remind = json['remind'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'descp': descp,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': notifyTime,
      'color': color,
      'remind': remind,
      'repeat': repeat,
    };

    return data;
  }
}
