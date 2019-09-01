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

## レイヤーと役割

* 左が各レイヤーで右が実際のクラスの依存関係
* 角丸枠線に黒字がクラスInterface(Protocolで実装)
* 角丸塗りつぶしが実装クラス

![layerd 001](https://user-images.githubusercontent.com/25366111/64076458-2a9ae880-cd00-11e9-95e0-08e992a032f9.jpeg)


### PresentationLayer

#### この層で解決したいこと

UIKitなどのOSが提供する表示に関する処理をこの層にとどめる

#### 責務

* OSからのイベントとユーザーイベントをApplicationLayerに通知する
* ApplicationLayerに通知された更新データを元にUIの表示更新

#### 役割
UIの表示とユーザーイベントの通知

### ApplicationLayer

#### この層で解決したいこと

DomainLayerからシステムの表示の関心を切り離す

#### 責務

* DomainLayerのメソッドの実行結果に応じて画面の状態を判断する
* PresentationLayerで利用するデータ型にデータを加工する
* 更新をPresentationLayerに通知する

#### 役割
* アプリケーション動作の抽象化を提供し、対応するDomainLayerの処理を実行する
* DomainLayerの戻り値から画面全体の状態を判断する
* DomainLayerの戻り値から表示用のデータ加工する
* データの更新をPrensetationLayerに通知する

### DomainLayer

#### この層で解決したいこと

アプリケーションのもつビジネスロジックの複雑さのみを分離して、システムの複雑さと切り離す

#### 責務

ApplicationLayer、DataLayerから渡されるデータを元に、ビジネスルールに基づいて適切な処理の実行、DataLayerへのルーティングを行う

#### 役割

* 抽象化したビジネスロジックのインターフェースを提供する
* ビジネスルールに基づいてDataLayerのインターフェースにルーティングする
* DataLayerからの戻り値を元にビジネスルールに基づいて適切な処理を実行する

### DataLayer

#### この層で解決したいこと

データの取得、永続化などOSが提供するデータに関する処理をこの層にとどめる

####  責務

実行された処理を元にAPI、DBなどデータの取得、保存先を適切にルーティングする

#### 役割

API、データベースなどデータの取得先をDomainLayerが意識せずデータを取得できるInterfaceを提供する
