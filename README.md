# iOSLayeredSample

## 概要

iOSのレイヤードアーキテクチャを採用したサンプルアプリです。

* Githubのリポジトリ検索
* Githubのリポジトリ詳細閲覧(実装中)

の機能を予定しています。

## 実装方針

* storyboard上で画面を構成しない。xibを利用して画面構成を行う。
* 1画面の構成を管理するxibのFile Ownerは、基本的にPresenterが担う。
* 通知は基本的にDelegateパターンを用いる
* サンプルのためライブラリはなるべく利用しない
* テストコードを書くことを前提とするので、DIを用いた参照を利用する
* 独自クラスの継承はせず、protocolとprotocol extensionを利用

## レイヤーと名称と役割

![layerd 001](https://user-images.githubusercontent.com/25366111/63637480-707bff00-c6b7-11e9-8ab2-630f935093ba.jpeg)

※ 表示状態がない静的な画面など必要がなければPresenterやViewModelはなくて良い

### View

表示とユーザーイベントの通知

* 値オブジェクトを受け取って対応するViewにデータを代入する
* Viewに対するユーザー操作のイベントを受け取り、Presenterへ通知
* 1画面に複数、UIを構成するモジュール単位で作成

### Presenter(Deprecated)

** viewと統合予定 **

データを元にしたViewの管理

* 対応するViewに値オブジェクトを振り分ける
* Viewの追加や整形、非表示などを行う
* Viewのイベントを受け取り、ViewControllerへ通知
* 1画面に一つ、コンポジットパターンによる分割は可能

### ViewController

画面遷移、OSイベントの通知

* 画面のエントリーポイント
* OS、画面のライフサイクルを受け取る
* 画面遷移を行う
* イベントをViewModelへ通知
* 更新データをPresenterに通知する
* 1画面に一つ

### ViewModel

画面の状態管理、表示データの整形

* 保持している値オブジェクトを元に表示する画面の種類(エラー、ロードなど)を決定する
* データを表示用のデータに整形、追加、並び替えを行う
* 表示用データの更新完了通知をViewControllerに通知する
* イベントをUseCaseに通知
* 1画面に一つ

### UseCase

ワークフローとルールの集合体

* 複数のRepositoryを保持
* Repositoryの状態とイベントの組み合わせで任意のRepositoryに対して更新通知を出す
* 任意のRepository同士の更新を待ち合わせる
* 1ワークフローにつき一つ?

### Repository

データの取得、更新の保存する場所の選定

* DBキャッシュ利用、API通信の必要可否を判断してデータをUseCaseに通知
* DB、APIなどのデータ更新の保存先を選定
* 一つの値オブジェクトにつき一つ

### Client

データの取得、更新の実行

* API、DBとの接続
* Queryの生成
* DB、API、UserDefaultsなどにつき一つ
