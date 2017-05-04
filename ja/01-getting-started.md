# Getting Started

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [注意](#%E6%B3%A8%E6%84%8F)
  - [環境](#%E7%92%B0%E5%A2%83)
- [インストール](#%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [関連パッケージのインストール](#%E9%96%A2%E9%80%A3%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [haconiwa パッケージのインストール](#haconiwa-%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [haconiwa のバージョンとヘルプの確認](#haconiwa-%E3%81%AE%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E3%81%A8%E3%83%98%E3%83%AB%E3%83%97%E3%81%AE%E7%A2%BA%E8%AA%8D)
- [設定のひな形を作る](#%E8%A8%AD%E5%AE%9A%E3%81%AE%E3%81%B2%E3%81%AA%E5%BD%A2%E3%82%92%E4%BD%9C%E3%82%8B)
- [rootfs の作成](#rootfs-%E3%81%AE%E4%BD%9C%E6%88%90)
- [プロビジョニング](#%E3%83%97%E3%83%AD%E3%83%93%E3%82%B8%E3%83%A7%E3%83%8B%E3%83%B3%E3%82%B0)
- [コンテナに入ってみる](#%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E3%81%AB%E5%85%A5%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B)
- [コンテナでデーモンを動かす](#%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E3%81%A7%E3%83%87%E3%83%BC%E3%83%A2%E3%83%B3%E3%82%92%E5%8B%95%E3%81%8B%E3%81%99)
  - [シンプルな Web サーバーを起動する](#%E3%82%B7%E3%83%B3%E3%83%97%E3%83%AB%E3%81%AA-web-%E3%82%B5%E3%83%BC%E3%83%90%E3%83%BC%E3%82%92%E8%B5%B7%E5%8B%95%E3%81%99%E3%82%8B)
  - [Web サーバーにアクセスする](#web-%E3%82%B5%E3%83%BC%E3%83%90%E3%83%BC%E3%81%AB%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E3%81%99%E3%82%8B)
  - [コンテナに入ってみる](#%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E3%81%AB%E5%85%A5%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B-1)
- [コンテナを停止する](#%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E3%82%92%E5%81%9C%E6%AD%A2%E3%81%99%E3%82%8B)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 注意

### 環境

本ドキュメントにて利用している OS 環境は以下の通りです.

```sh
$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=16.04
DISTRIB_CODENAME=xenial
DISTRIB_DESCRIPTION="Ubuntu 16.04.2 LTS"

$ haconiwa version
haconiwa: v0.8.5
```

上記以外の OS を利用する場合, 各セクションにおいて利用されている OS で利用可能なコマンドに読み替えて下さい.

## インストール

### 関連パッケージのインストール

あらかじめ, 以下のようなパッケージを事前にインストールしておきます.

- LXC

尚、haconiwa は必ずしも LXC は必要ではありませんが, 本資料では `lxc-create` コマンドを利用する設定を利用する為に事前にインストールしておく必要があります.

LXC は以下のコマンドを実行してインストールを行います.

```sh
$ sudo apt-get install lxc
```

### haconiwa パッケージのインストール

haconiwa パッケージは packagecloud にてパッケージ配布されているので, 以下のようにインストールします.

```sh
$ curl -s https://packagecloud.io/install/repositories/udzura/haconiwa/script.deb.sh | sudo bash
$ sudo apt-get install haconiwa=0.8.5-1
```

### haconiwa のバージョンとヘルプの確認

`version` サブコマンドを指定して haconiwa を実行するとバージョンを確認することが出来ます. また, オプションを指定せずに haconiwa を実行するとサブコマンドの一覧を確認することが出来ます.

```sh
$ haconiwa version
haconiwa: v0.8.5

$ haconiwa
haconiwa - The MRuby on Container
commands:
    new       - generate haconiwa's config DSL file template
    create    - create the container rootfs
    provision - provision already booted container rootfs
    archive   - create, provision, then archive rootfs to image
    start     - run the container
    attach    - attach to existing container
    reload    - reload running container parameters, following its current config
    kill      - kill the running container
    version   - show version
    revisions - show mgem/mruby revisions which haconiwa bin uses

Invoke `haconiwa COMMAND -h' for details.
```

## 設定のひな形を作る

`new` サブコマンドを指定して haconiwa を実行すると設定のひな形がカレントディレクトリに作成されます.

```sh
$ haconiwa new \
  --name=my-first-container \
  --root=/var/lib/haconiwa/my-first-container my-first-container.haco
```

`new` サブコマンドを指定する際のオプションは以下の通りです.

| オプション名 | 用途 | 指定例 |
|:---|:---|:---|
| --name | コンテナ名を指定 | --name=my-first-container |
| --root | rootfs のパスを指定 | /var/lib/haconiwa/my-first-container |

コマンドを実行すると, 以下のように出力されます.

```sh
create  my-first-container.haco
```

ひな形が作成されたことを確認します.

```sh
$ ls -l my-first-container.haco
```

ひな型ファイルの中身は以下のような内容となっています. (実際には `#` にて各設定項目に関するコメントが記載されていますが, それらは除いています.)

```ruby
Haconiwa.define do |config|
  config.name = "my-first-container"
  config.init_command = "/bin/bash"
  root = Pathname.new("/var/lib/haconiwa/my-first-container")
  config.chroot_to root
  config.bootstrap do |b|
    b.strategy = "lxc"
    b.os_type  = "alpine"
  end
  config.provision do |p|
    p.run_shell <<-SHELL
apk add --update bash
    SHELL
  end
  config.add_mount_point "tmpfs", to: root.join("tmp"), fs: "tmpfs"
  config.mount_network_etc(root, host_root: "/etc")
  config.mount_independent "procfs"
  config.mount_independent "sysfs"
  config.mount_independent "devtmpfs"
  config.mount_independent "devpts"
  config.mount_independent "shm"
  config.namespace.unshare "mount"
  config.namespace.unshare "ipc"
  config.namespace.unshare "uts"
  config.namespace.unshare "pid"
end
```

尚, ひな型の OS は Alpine Linux となり bash パッケージがインストールされ, 4 つの Namespace においてホストから分離されたコンテナが作成される設定になっています.

## rootfs の作成

`create` サブコマンドとひな型ファイルを指定して haconiwa を実行します.

```sh
$ sudo haconiwa create my-first-container.haco
```

尚, 本資料において LXC は非特権ユーザーで動かす設定がされていない為, 以降の haconiwa の操作には root ユーザーもしくは `sudo` コマンドを利用します.

以下の出力のように rootfs の作成が開始され, `config.provision` も指定されている為, パッケージのインストールも行われます.

```sh
Creating rootfs of my-first-container...
Start bootstrapping rootfs with lxc-create...
[bootstrap.lxc]:        Obtaining an exclusive lock... done

... snip
Command success: lxc-create -n my-first-container -t alpine --dir /var/lib/haconiwa/my-first-container exited 0
Success!
Start provisioning...
Running provisioning with shell script...

... snip
[provison.shell-1]:     OK: 14 MiB in 21 packages
Command success: /bin/sh -xe exited 0
Success!
```

## プロビジョニング

設定ファイルを修正して, コンテナに Web サーバー (Apache) をインストールしてみます.

```diff
--- my-first-container.haco.old 2017-05-03 15:42:57.037536264 +0000
+++ my-first-container.haco     2017-05-03 15:43:14.933536264 +0000
@@ -33,7 +33,7 @@
   # You can declare run_shell step by step:
   config.provision do |p|
     p.run_shell <<-SHELL
-apk add --update bash
+apk add --update bash ruby
     SHELL
   end
```

`provision` サブコマンドとひな型ファイルを指定して haconiwa を実行します.

```sh
$ sudo haconiwa provision my-first-container.haco
```

以下のように出力され, ruby パッケージがインストールされます.

```sh
Provisioning rootfs of my-first-container...
Start provisioning...
Running provisioning with shell script...

... snip
[provison.shell-1]:     OK: 18 MiB in 27 packages
Command success: /bin/sh -xe exited 0
Success!
```

## コンテナに入ってみる

`start` サブコマンドとひな型ファイルを指定して haconiwa を実行します.

```sh
$ sudo haconiwa start my-first-container.haco
```

以下のように出力され, my-first-container コンテナにログインしていることが確認出来ます.

```sh
Container fork success and going to wait: pid=15043
bash-4.3# ps aux
PID   USER     TIME   COMMAND
    1 root       0:00 /bin/bash
    2 root       0:00 ps aux
```

尚、コンテナ内のプロンプトで `exit` を入力してコンテナを抜けることが出来ます.

## コンテナでデーモンを動かす

### シンプルな Web サーバーを起動する

my-first-container でシンプルな Web サーバーを起動してみたいと思います.

my-first-container.haco ファイルを以下のように変更します.

```diff
--- my-first-container.haco.original    2017-05-04 00:01:46.724019010 +0000
+++ my-first-container.haco     2017-05-04 00:00:36.372019010 +0000
@@ -3,7 +3,7 @@
   # The container name and container's hostname:
   config.name = "my-first-container"
   # The first process when invoking haconiwa run:
-  config.init_command = "/bin/bash"
+  config.init_command = [ "/usr/bin/ruby", "-run", "-ehttpd", "/tmp", "-p8000" ]
   # If your first process is a daemon, please explicitly daemonize by:
   # config.daemonize!
```

変更後、`start` サブコマンドとひな型ファイルを指定し、新たに `--daemon` オプションを付けて haconiwa を実行します.

```sh
sudo haconiwa start my-first-container.haco --daemon
```

以下のように出力され, my-first-container コンテナはデーモンモードで動作します. `pids` で出力されている番号はホスト側から見えるコンテナ root PID となります. 今後, この PID を指定してコンテナへのアクセスやコンテナの停止を行います.

```sh
pids: 16483
Container cluster successfully up. PID={supervisors: [16483], root: 16482}
```

尚、設定ファイルに以下のように記述することで `--daemon` オプションを指定することなくデーモンモードで動作させることが出来ます.

```ruby
Haconiwa.define do |config|
  ...
  config.daemonize!
```

### Web サーバーにアクセスする

デーモンモードで起動しているコンテナの Web サーバーに対して, ホストから curl を利用してアクセスすることが出来ます.

```sh
$ curl -s localhost:8000 -o /dev/null -w "%{http_code}\n"
200
```

尚, my-first-container コンテナは Network Namespace を unshare していない為, ホストから `localhost:8000` でアクセスが出来てしまっています. もし, コンテナに IP アドレスを付与し, コンテナの IP アドレスに対して HTTP アクセスしたい場合には, Network Namespace を unshare した上でコンテナに veth (仮想ネットワークインターフェース) を設置するような設定が必要になります.

### コンテナに入ってみる

`attach` サブコマンドを利用することで, デーモンモードで起動しているコンテナに入る (コンソールにアクセスする) ことが出来ます.

```sh
$ sudo haconiwa attach my-first-container.haco --target=16483
```

`attach` サブコマンドを指定する際のオプションは以下の通りです.

| オプション名 | 用途 | 指定例 |
|:---|:---|:---|
| --name | コンテナ名を指定 (必須ではありません) | --name=my-first-container |
| --target | コンテナの root PID を指定 | --target=16483 |

その他にも幾つかのオプションが用意されていますので、`haconiwa attach --help` で確認しましょう.

コマンドを実行すると, my-first-container コンテナにログインして各種コマンドの操作が可能となります.

```sh
bash-4.3#
bash-4.3# ps aux
PID   USER     TIME   COMMAND
    1 root       0:00 /usr/bin/ruby -run -ehttpd /tmp -p8000
    6 root       0:00 /bin/bash
    7 root       0:00 ps aux
```

起動中の Web サーバーのプロセスも確認することが出来ます.

## コンテナを停止する

`kill` サブコマンドを利用することで, コンテナ停止させることが出来ます.

```sh
$ sudo haconiwa kill my-first-container.haco --target=16483
```

`kill` サブコマンドを指定する際のオプションは以下の通りです.

| オプション名 | 用途 | 指定例 |
|:---|:---|:---|
| --target | コンテナの root PID を指定 | --target=16483 |

その他にも幾つかのオプションが用意されていますので、`haconiwa kill --help` で確認しましょう.

コマンドを実行すると, 以下のように出力されコンテナは停止します.

```sh
Kill success
```
