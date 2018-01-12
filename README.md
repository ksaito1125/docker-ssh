# docker-ssh

sshdで接続できるコンテナです。

コンテナへの接続は、``docker exec``を利用するので、あくまで検証用です。

## ビルド

下記のコマンドで``sshd``という名前のコンテナをビルドします。

```
$ make build
$ docker images | grep sshd
sshd                   latest              1c0f766a6c70        5 minutes ago       165MB
$
```

## コンテナの起動

下記のコマンドでテスト用のコンテナを起動します。

```
$ make run
$ docker ps | grep sshd
c8d75f2e41ca        sshd                             "/usr/sbin/sshd -D"      5 seconds ago       Up 4 seconds        0.0.0.0:32778->22/tcp   test_sshd
$
```

## コンテナの停止

下記のコマンドでテスト用のコンテナを停止します。

```
$ make rm
```

## テスト

```
$ make test       
make rm                                            
make[1]: ディレクトリ '/home/ksaito/.ghq/github.com/ksaito1125/docker-ssh' に入ります                 
docker rm -f test_sshd                             
test_sshd                                          
make[1]: ディレクトリ '/home/ksaito/.ghq/github.com/ksaito1125/docker-ssh' から出ます                 
docker run -d -P --name test_sshd sshd             
b353c18b71a086857785355d86d3db7273829db86bce2e25e9f54ed979ea0b0b                                      
ssh root@172.17.0.1 -p 32780                       
The authenticity of host '[172.17.0.1]:32780 ([172.17.0.1]:32780)' can't be established.              
ECDSA key fingerprint is SHA256:FeDuVEnj4yXZTwYgUuEZG6npqo96rzcsE+/4hFKb8tQ.                          
Are you sure you want to continue connecting (yes/no)? yes                                            
Warning: Permanently added '[172.17.0.1]:32780' (ECDSA) to the list of known hosts.                   
root@172.17.0.1's password:                        
Welcome to Ubuntu 16.04.3 LTS (GNU/Linux 4.9.60-linuxkit-aufs x86_64)                                 

 * Documentation:  https://help.ubuntu.com         
 * Management:     https://landscape.canonical.com 
 * Support:        https://ubuntu.com/advantage    

The programs included with the Ubuntu system are free software;                                       
the exact distribution terms for each program are described in the                                    
individual files in /usr/share/doc/*/copyright.    

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by                                  
applicable law.                                    

root@b353c18b71a0:~#                  
```

## 後片付け

下記のコマンドで作成したものをすべて破棄します。

```
$ make clean
```

以上
