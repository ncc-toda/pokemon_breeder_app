/// アプリケーション全体で使用するスペース（余白、パディングなど）の値を定義するクラス。
///
/// UI 要素間のスペースや、コンポーネント内部のパディングなどに使用する。
class DsSpacing {
  // このクラスはインスタンス化されることを意図していない。
  // 定数へのアクセスは AppSpacing.xxs のように静的に行う。
  const DsSpacing._();

  /// 極小のスペース (2.0)
  /// 細かい調整や、非常に小さい要素間の区切りに使用する。
  static const double xxs = 2;

  /// とても小さいスペース (4.0)
  /// アイコンとテキストの間や、小さな要素間のマージンなどに使用する。
  static const double xs = 4;

  /// 小さいスペース (8.0)
  /// UI コンポーネント内の標準的なパディングや、関連性の高い要素間のマージンに使用する。
  static const double s = 8;

  /// 標準的なスペース (12.0)
  /// やや大きめのパディングや、要素グループ間の区切りに使用する。
  static const double m = 12;

  /// 少し大きめのスペース (16.0)
  /// カードやセクションなどの主要なコンポーネントの外側のマージンや、
  /// 画面全体の標準的なパディングに使用する。
  static const double l = 16;

  /// 大きいスペース (24.0)
  /// セクション間の区切りや、より強調したいマージンに使用する。
  static const double xl = 24;

  /// とても大きいスペース (40.0)
  /// ページ内の大きな区切りや、重要な要素の周囲の余白に使用する。
  static const double xxl = 40;

  // * --- 具体的な用途に基づいたスペース定義 --- * //

  /// アイコンとその隣のテキストとの間の標準的なギャップ。
  static const double iconTextGap = xs;

  /// リスト内のアイテム間の標準的なギャップ。
  static const double listItemGap = s;

  /// フォーム内のフィールド間の標準的なギャップ。
  static const double formFieldGap = m;

  /// 主要なUIセクション間の標準的なギャップ。
  static const double sectionGap = xl;

  /// 画面の左右端に対する標準的なパディング。
  static const double screenPaddingHorizontal = l;

  /// 画面の上端または下端に対する標準的なパディング。
  static const double screenPaddingVertical = l;
}
