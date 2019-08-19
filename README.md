# iOSLayeredSample

## 概要

iOSのレイヤードアーキテクチャを採用したサンプルアプリです。

* Githubのリポジトリ検索
* Githubのリポジトリ詳細閲覧(実装中)

の機能を予定しています。

## 構成方針

* storyboard上で画面を構成しない、xibを利用して画面構成を行う
* xibのFile Ownerは基本的にPresenterが担う
* 必要がなければPresenterやViewModelはなくて良い

## 名称と役割

### View

表示とユーザーイベントの通知

* 値オブジェクトを受け取って対応するViewにデータを代入する
* Viewに対するユーザー操作のイベントを受け取り、Presenterへ通知
* 1画面に複数、UIを構成するモジュール単位で作成

### Presenter

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

リクエストの待ち合わせ、イベントによるデータの更新を任意のRepositoryに通知

* 複数のRepositoryを保持
* Repositoryの状態とイベントの組み合わせで任意のRepositoryに対して更新通知を出す
* 任意のRepository同士の更新を待ち合わせる
* 1イベントにつき一つ?

### Repository

データ取得先、更新の保存先の選定

* DBキャッシュ利用、API通信の必要可否を判断してデータをUseCaseに通知
* DB、APIなどのデータ更新の保存先を選定

### Client

データの取得
