# iOSLayeredSample

## 概要

iOSのレイヤードアーキテクチャを採用したサンプルアプリです。

* Githubのリポジトリ検索
* Githubのリポジトリ詳細閲覧

の機能があります

## 実装方針

* storyboard上で画面を構成しない。xibを利用して画面構成を行う。
* 1画面の構成を管理するxibのFile Ownerは、基本的にViewが担う。
* データの更新通知はCombineによるオブザーバーパターンを用いる
* サンプルのためライブラリはなるべく利用しない
* テストコードを書くことを前提とするので、DIを用いた参照を利用する
* 独自クラスの継承はせず、protocolとprotocol extensionを利用

## レイヤーと役割

* 左が各レイヤーで右が実際のクラスの依存関係
* 角丸枠線に黒字がProtocol
* 角丸塗りつぶしが実装クラス

![layerd 001](https://user-images.githubusercontent.com/25366111/65311994-902a1880-dbcc-11e9-9498-178cc815de1f.jpeg)


### PresentationLayer

#### この層で解決したいこと

UIKitなどのOSが提供する表示に関する処理をこの層にとどめる

#### 責務

* OSからのイベントとユーザーイベントをApplicationLayerに通知する
* ApplicationLayerに通知された更新データを元にUIの表示更新

### ApplicationLayer

#### この層で解決したいこと

DomainLayerからシステムの表示の関心を切り離す

#### 責務

* DomainLayerのメソッドの実行結果に応じて画面の状態を判断する
* PresentationLayerで利用するデータ型にデータを加工する
* 更新をPresentationLayerに通知する

### DomainLayer

#### この層で解決したいこと

アプリケーションのもつビジネスロジックの複雑さのみを分離して、システムの複雑さと切り離す

#### 責務

ApplicationLayer、DataLayerから渡されるデータを元に、ビジネスルールに基づいて適切な処理の実行、DataLayerへのルーティングを行う

### DataLayer

#### この層で解決したいこと

データの取得、永続化などOSが提供するデータに関する処理をこの層にとどめる

####  責務

実行された処理を元にAPI、DBなどデータの取得、保存先を適切にルーティングする

