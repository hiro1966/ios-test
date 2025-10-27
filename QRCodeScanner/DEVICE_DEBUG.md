# iOS実機デバッグガイド

iPhoneやiPadの実機でアプリをデバッグする方法を詳しく説明します。

## 📱 必要なもの

### ハードウェア
- ✅ Mac（macOS 12.0以降推奨）
- ✅ iPhone/iPad（iOS 15.0以降）
- ✅ Lightning/USB-Cケーブル

### ソフトウェア
- ✅ Xcode 14.0以降
- ✅ Apple ID（無料でOK）

## 🔧 セットアップ手順

### ステップ1: Xcodeでプロジェクトを開く

1. **プロジェクトを開く**
   ```bash
   open QRCodeScanner.xcodeproj
   ```

2. **またはFinderから**
   - `QRCodeScanner.xcodeproj`ファイルをダブルクリック

### ステップ2: Apple IDを追加（初回のみ）

Apple IDをまだXcodeに追加していない場合：

1. **Xcodeメニューから設定を開く**
   - `Xcode` → `Settings...`（または `Preferences...`）
   - ショートカット: `⌘,`（Command + カンマ）

2. **Accountsタブを選択**
   - 左側のタブから「Accounts」をクリック

3. **Apple IDを追加**
   - 左下の「+」ボタンをクリック
   - 「Apple ID」を選択
   - Apple IDとパスワードを入力
   - 「Continue」をクリック

4. **確認**
   - アカウント一覧に自分のApple IDが表示されればOK

### ステップ3: デバイスを接続

1. **iPhoneをMacに接続**
   - LightningケーブルまたはUSB-Cケーブルで接続

2. **iPhone側で信頼を許可**
   - iPhoneに「このコンピュータを信頼しますか？」と表示される
   - 「信頼」をタップ
   - パスコードを入力（求められた場合）

3. **Xcodeでデバイスを確認**
   - Xcodeの上部ツールバーを確認
   - デバイス名（例：「hiro1966's iPhone」）が表示されればOK
   - 表示されない場合は、`Window` → `Devices and Simulators`で確認

### ステップ4: 署名設定（重要！）

1. **プロジェクトナビゲーターを開く**
   - 左側のフォルダアイコンをクリック
   - または `⌘1`

2. **プロジェクトファイルを選択**
   - 一番上の「QRCodeScanner」（青いアイコン）をクリック

3. **ターゲットを選択**
   - 「TARGETS」の下の「QRCodeScanner」を選択

4. **Signing & Capabilitiesタブを開く**
   - 上部のタブから「Signing & Capabilities」をクリック

5. **署名を設定**
   ```
   ✅ Automatically manage signing（チェックを入れる）
   ```

6. **チームを選択**
   - 「Team」のドロップダウンをクリック
   - 自分のApple IDを選択
   - 個人アカウントの場合：「Your Name (Personal Team)」

7. **Bundle Identifierを変更（必要な場合）**
   - エラーが出た場合、Bundle Identifierを変更
   - 例：`com.example.QRCodeScanner` → `com.yourname.QRCodeScanner`
   - ユニークな識別子にする必要があります

### ステップ5: ビルドターゲットを選択

1. **デバイスを選択**
   - Xcodeの上部ツールバー（中央付近）
   - スキーマ選択ボタン（「QRCodeScanner」の右側）をクリック
   - 接続したiPhoneを選択
   - 例：「hiro1966's iPhone」

2. **確認ポイント**
   ```
   QRCodeScanner > [あなたのiPhone名]
   ```
   この表示になっていればOK

### ステップ6: ビルド＆実行

1. **ビルドを開始**
   - 再生ボタン（▶️）をクリック
   - またはショートカット: `⌘R`（Command + R）

2. **初回のみ：開発者を信頼する設定**
   
   アプリがiPhoneにインストールされた後、初回起動時にエラーが出る場合：

   **iPhoneで以下の操作を実行：**
   
   a. iPhoneの「設定」アプリを開く
   
   b. 下にスクロールして「一般」をタップ
   
   c. 「VPNとデバイス管理」をタップ
      - iOS 15以前：「デバイス管理」
      - iOS 16以降：「VPNとデバイス管理」
   
   d. 「デベロッパApp」セクションを探す
   
   e. 自分のApple IDをタップ
   
   f. 「"[Your Apple ID]"を信頼」をタップ
   
   g. 確認ダイアログで「信頼」をタップ

3. **アプリが起動**
   - iPhoneにアプリがインストールされ、自動的に起動します
   - カメラ権限のダイアログが表示されます
   - 「許可」をタップしてください

## 🐛 デバッグ機能の使い方

### コンソールログの確認

1. **デバッグエリアを表示**
   - `View` → `Debug Area` → `Show Debug Area`
   - ショートカット: `⌘⇧Y`

2. **ログを確認**
   - 下部にコンソールが表示されます
   - `print()`文の出力やエラーメッセージが表示されます

### ブレークポイントの設定

1. **ブレークポイントを追加**
   - 止めたい行番号の左側をクリック
   - 青い矢印が表示されます

2. **デバッグ実行**
   - アプリを実行すると、ブレークポイントで停止
   - 変数の値を確認できます

3. **ステップ実行**
   - `Step Over`: 次の行へ（`F6`）
   - `Step Into`: 関数の中へ（`F7`）
   - `Step Out`: 関数から出る（`F8`）
   - `Continue`: 次のブレークポイントまで実行（`⌘⌃Y`）

### デバイスログの確認

1. **Devices and Simulatorsを開く**
   - `Window` → `Devices and Simulators`
   - ショートカット: `⌘⇧2`

2. **デバイスを選択**
   - 左側のリストから接続したiPhoneを選択

3. **ログを確認**
   - 「Open Console」ボタンをクリック
   - システムログ全体を確認できます

## ⚠️ よくある問題と解決方法

### 問題1: 「Failed to register bundle identifier」

**原因**: Bundle Identifierが他の開発者と重複している

**解決方法**:
1. プロジェクト設定を開く
2. `Signing & Capabilities`タブ
3. Bundle Identifierを変更
   ```
   変更前: com.example.QRCodeScanner
   変更後: com.yourname.QRCodeScanner
   ```

### 問題2: 「The operation couldn't be completed」

**原因**: 署名設定が正しくない

**解決方法**:
1. `Signing & Capabilities`タブを開く
2. "Automatically manage signing"のチェックを外す
3. もう一度チェックを入れる
4. Teamを再選択

### 問題3: デバイスが表示されない

**原因**: デバイスが正しく認識されていない

**解決方法**:
1. ケーブルを抜き差しする
2. iPhoneを再起動
3. Xcodeを再起動
4. `Window` → `Devices and Simulators`でデバイスを確認
5. デバイスが「Preparing」状態の場合は完了まで待つ

### 問題4: 「Could not launch "QRCodeScanner"」

**原因**: 開発者の信頼設定が未完了

**解決方法**:
iPhoneで以下の操作：
1. 設定 → 一般 → VPNとデバイス管理
2. Apple IDを信頼する設定を実行

### 問題5: 「Revoke certificate」エラー

**原因**: 無料アカウントの証明書の上限に達した

**解決方法**:
1. Xcode → Settings → Accounts
2. Apple IDを選択
3. "Download Manual Profiles"をクリック
4. 古い証明書を削除してから再試行

### 問題6: アプリが7日後に起動しなくなる

**原因**: 無料の開発者アカウントは7日間の制限がある

**解決方法**:
1. Xcodeでもう一度ビルド＆実行
2. 再度7日間使用可能になります
3. または、年間$99のApple Developer Programに登録

## 📊 パフォーマンス測定

### メモリ使用量の確認

1. デバッグエリアを表示（`⌘⇧Y`）
2. 上部の「Debug Memory Graph」ボタンをクリック
3. メモリリークや使用量を確認

### CPU使用率の確認

1. `Debug` → `Attach to Process`
2. アプリ実行中のCPU使用率が表示される

### Instrumentsを使用

1. `Product` → `Profile`（または`⌘I`）
2. テンプレートを選択：
   - Time Profiler: CPU使用率
   - Allocations: メモリ使用量
   - Leaks: メモリリーク検出
3. 録画ボタンで測定開始

## 🔒 プライバシー設定のテスト

### カメラ権限のリセット

テストのためにカメラ権限をリセットする方法：

1. **iPhoneで操作**
   - 設定 → プライバシーとセキュリティ → カメラ
   - 「QRCodeScanner」を探す
   - トグルをオフにする
   - アプリを再起動

2. **完全リセット**
   - 設定 → 一般 → 転送またはiPhoneをリセット
   - 「リセット」→ 「位置情報とプライバシーをリセット」

## 💡 開発のヒント

### 1. ワイヤレスデバッグ（iOS 16+）

1. iPhoneとMacを同じWi-Fiネットワークに接続
2. `Window` → `Devices and Simulators`
3. デバイスを選択
4. 「Connect via network」にチェック
5. ケーブルを外してもデバッグ可能

### 2. SwiftUIプレビューの活用

- コードの横の「Resume」ボタンでプレビュー表示
- リアルタイムでUIの変更を確認
- ショートカット: `⌥⌘P`

### 3. ホットリロード的な開発

デバッグ実行中に一部のコードを変更する場合：
1. 実行を止めずにコードを編集
2. `Debug` → `Resume`で反映

### 4. 複数デバイスでのテスト

- 異なるiOSバージョン
- iPhone/iPad両方
- 画面サイズの違い

これらを実機でテストすることで、より堅牢なアプリになります。

## 📚 参考リンク

- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [Xcode Help](https://help.apple.com/xcode/)
- [App Distribution Guide](https://developer.apple.com/documentation/xcode/distributing-your-app-for-beta-testing-and-releases)

---

問題が解決しない場合は、エラーメッセージの全文をメモして、Appleの開発者フォーラムで質問することをお勧めします。
