import 'package:flutter/material.dart';

import 'ds_bottom_bar.dart';
import 'ds_top_bar.dart';

/// アプリケーションの基本的な画面レイアウトを提供する Scaffold のラッパー。
///
/// [topBarContent]、[bottomBarContent]、またはその両方を持つ画面を構成できる。
/// [body] は必須のコンテンツエリア。
/// オプションで [backgroundImage] を設定できる。
class DsScaffold extends StatelessWidget {
  /// `AppScaffold` のコンストラクタ。
  ///
  /// [body] は必須。
  /// [topBarContent] と [bottomBarContent] はオプションで、表示したい場合のみ指定する。
  /// [backgroundImage] もオプションで、背景画像を設定したい場合に指定する。
  const DsScaffold({
    required this.body,
    super.key,
    this.topBarContent,
    this.bottomBarContent,
    this.backgroundImage,
  });

  /// 画面上部に表示するコンテンツ。指定しない場合は表示されない。
  /// `Scaffold.body` の一部として画面最上部に配置される。
  final Widget? topBarContent;

  /// 画面下部に表示するコンテンツ。指定しない場合は表示されない。
  /// `Scaffold.bottomNavigationBar` に配置される。
  final List<Widget>? bottomBarContent;

  /// Scaffold の主要なコンテンツを表示する [Widget].
  final Widget body;

  /// Scaffold の body 部分の背景として表示する画像。
  /// 指定しない場合は背景画像なし。
  final ImageProvider? backgroundImage;

  @override
  Widget build(BuildContext context) {
    // 1. topBar を含む可能性のあるコンテンツ部分を構築
    late Widget contentWithTopBar;
    if (topBarContent != null) {
      contentWithTopBar = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            // TODO(me): デザイントークンとして定義する。( AppDemension.xx みたいな想定 )
            height: 120,
            child: DsTopBar(content: topBarContent!),
          ),
          Expanded(child: body),
        ],
      );
    } else {
      contentWithTopBar = body;
    }

    // 2. 背景画像があれば、コンテンツを Stack でラップする
    late Widget bodyWithPotentialBackground;
    if (backgroundImage != null) {
      bodyWithPotentialBackground = Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: backgroundImage!,
            fit: BoxFit.cover,
          ),
          contentWithTopBar,
        ],
      );
    } else {
      bodyWithPotentialBackground = contentWithTopBar;
    }

    return Scaffold(
      body: SafeArea(child: bodyWithPotentialBackground),
      bottomNavigationBar: bottomBarContent != null
          ? DsBottomBar(actions: bottomBarContent!)
          : null,
    );
  }
}
