part of 'app_typography.dart';

typedef PrimaryTextStyle = ({
  Title title,
  PrimaryParagraph paragraph,
});

typedef SecondaryTextStyle = ({
  SecondaryParagraph paragraph,
  Caption caption,
  TextStyle footnote,
});

typedef SecondaryParagraph = ({
  /// medium | size 16.sp | height 1.25 | letter spacing -0.5
  TextStyle large,

  /// medium | size 14.sp | height 1.4285 | letter spacing -0.5
  TextStyle medium,

  /// regular | size 12.sp | height 1.666667 | letter spacing -0.5
  TextStyle small,
});

typedef PrimaryParagraph = ({
  /// medium | size 16.sp | height 1.25 | letter spacing -0.5
  TextStyle medium,

  /// regular | size 12.sp | height 1.666667 | letter spacing -0.5
  TextStyle small,
});

typedef Title = ({
  /// bold | size 31.sp | height 0.968 | letter spacing -0.5
  TextStyle large,

  /// bold | size 20.sp | height 1 | letter spacing -0.5
  TextStyle small,
});

typedef Caption = ({
  /// medium | size 10.sp | height 1.2 | letter spacing -0.5
  TextStyle medium,

  /// regular | size 10.sp | height 1.2 | letter spacing -0.5
  TextStyle regular,
});

extension PrimaryExtension on PrimaryTextStyle {
  PrimaryTextStyle lerp(
    PrimaryTextStyle other,
    double t,
  ) {
    return (
      title: this.title.lerp(other.title, t),
      paragraph: this.paragraph.lerp(other.paragraph, t),
    );
  }
}

extension SecondaryExtension on SecondaryTextStyle {
  SecondaryTextStyle lerp(
    SecondaryTextStyle other,
    double t,
  ) {
    return (
      paragraph: this.paragraph.lerp(other.paragraph, t),
      caption: this.caption.lerp(other.caption, t),
      footnote: TextStyle.lerp(this.footnote, other.footnote, t)!,
    );
  }
}

extension SecondaryParagraphExtension on SecondaryParagraph {
  SecondaryParagraph lerp(
    SecondaryParagraph other,
    double t,
  ) {
    return (
      large: TextStyle.lerp(this.large, other.large, t)!,
      medium: TextStyle.lerp(this.medium, other.medium, t)!,
      small: TextStyle.lerp(this.small, other.small, t)!,
    );
  }
}

extension PrimaryParagraphExtension on PrimaryParagraph {
  PrimaryParagraph lerp(
    PrimaryParagraph other,
    double t,
  ) {
    return (
      medium: TextStyle.lerp(this.medium, other.medium, t)!,
      small: TextStyle.lerp(this.small, other.small, t)!,
    );
  }
}

extension TitleExtension on Title {
  Title lerp(
    Title other,
    double t,
  ) {
    return (
      large: TextStyle.lerp(this.large, other.large, t)!,
      small: TextStyle.lerp(this.small, other.small, t)!,
    );
  }
}

extension CaptionExtension on Caption {
  Caption lerp(
    Caption other,
    double t,
  ) {
    return (
      medium: TextStyle.lerp(this.medium, other.medium, t)!,
      regular: TextStyle.lerp(this.regular, other.regular, t)!,
    );
  }
}
