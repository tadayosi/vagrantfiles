#!/bin/bash

sudo apt-get update
sudo apt-get install -y silversearcher-ag build-essential httpie dnsmasq redir

cp /vagrant/_bashrc .bashrc
cp /vagrant/_vimrc .vimrc
sudo chown vagrant:vagrant .vimrc

# golang
GO_VERSION=1.17.13
if [ ! -e go$GO_VERSION.linux-amd64.tar.gz ]; then
  curl -LO https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz
fi
tar -xf go$GO_VERSION.linux-amd64.tar.gz
rm -rf /usr/local/go
mv go /usr/local/

curl -LO https://raw.githubusercontent.com/kura/go-bash-completion/main/etc/bash_completion.d/go
mv go /etc/bash_completion.d/

# oc / kubectl
OKD_VERSION=4.8.0-0.okd-2021-11-14-052418
if [ ! -e openshift-client-linux-$OKD_VERSION.tar.gz ]; then
  curl -LO https://github.com/openshift/okd/releases/download/$OKD_VERSION/openshift-client-linux-$OKD_VERSION.tar.gz
fi
tar -xf openshift-client-linux-$OKD_VERSION.tar.gz oc kubectl
mv oc /usr/local/bin/
mv kubectl /usr/local/bin/
chmod 755 /usr/local/bin/oc
chmod 755 /usr/local/bin/kubectl

# microshift
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
sudo redir -I redir-http -l debug :80 localhost:30080
sudo redir -I redir-https -l debug :443 localhost:30443
