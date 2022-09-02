enum MessageEnum {
  text('text'),
  image('image'),
  audio('audio'),
  video('video'),
  gif('gif');

  const MessageEnum(this.string);
  final String string;
}

extension ConvertMessage on String {
  MessageEnum toEnum() {
    switch (this) {
      case 'audio':
        return MessageEnum.audio;
      case 'text':
        return MessageEnum.text;
      case 'image':
        return MessageEnum.image;
      case 'video':
        return MessageEnum.video;
      case 'gif':
        return MessageEnum.gif;
      default:
        return MessageEnum.text;
    }
  }
}
