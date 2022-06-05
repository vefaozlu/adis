class Item {
  const Item({
    required this.voicePath,
    required this.iconPath,
    required this.text,
  });

  final String voicePath;
  final String iconPath;
  final String text;

  Item.fromJson(Map<String, dynamic> json)
      : voicePath = json['voice'],
        iconPath = json['icon'],
        text = json['text'];
}
