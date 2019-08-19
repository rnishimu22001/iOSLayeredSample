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

* 値オブジェクトを受け取って対応するViewにデータを代入する
* Viewに対するユーザー操作のイベントを受け取り、Presenterへ通知

### Presenter

* 対応するViewに値オブジェクトを振り分ける
* Viewの追加や整形、非表示などを行う
* Viewのイベントを受け取り、ViewControllerへ通知

### ViewController

* 画面のエントリーポイント
* OS、画面のライフサイクルを受け取る
* 画面遷移を行う
* イベントをViewModelへ通知
* 更新データをPresenterに通知する

### ViewModel

* 保持している値オブジェクトを元に表示する画面の種類(エラー、ロードなど)を決定する
* データを表示用のデータに整形、追加、並び替えを行う
* 表示用データの更新完了通知をViewControllerに通知する
* イベントをUseCaseに通知

### UseCase

