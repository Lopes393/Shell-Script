#!/usr/bin/env bash

## Date 10/01/2020
## Murilo
## github/Lopes393

## Começando shell script

## Removendo travas eventuais no apt ##
sudo rm /var/lib/dpkg/lock-frontend; sudo rm /var/cache/apt/archives/lock;

##URL_VSCODE="https://az764295.vo.msecnd.net/stable/8795a9889db74563ddd43eb0a897a2384129a619/code_1.40.1-1573664190_amd64.deb"
URL_VSCODE="https://go.microsoft.com/fwlink/?LinkID=760868"
URL_SLACK="https://downloads.slack-edge.com/linux_releases/slack-desktop-4.2.0-amd64.deb"
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_DBEAVER="https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb"


DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"
mkdir $DIRETORIO_DOWNLOADS

PROGRAMAS_PARA_INSTALAR=(
  plank
  git
  spotify-client
  nodejs
  apache2
  mysql-server
  php 
  postgresql
  postgresql-contrib
  libapache2-mod-php 
  php-mysql 
  php-mcrypt
  php-zip
  php-gettext
  php-common 
  php-xml 
  php-dom 
  php-pgsql 
  php-mbstring 
  php-curl 
  php-gd 
  memcached 
  php-memcached 
  php-sybase 
  php-json 
  php-xml
)


## spotify ## 
echo "downloading Spotify "
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

## Node ## 
echo "downloading Node "
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
#Caso de erro na versão tina do linux mint https://unix.stackexchange.com/questions/538536/newest-version-of-nodejs-is-not-intalling-in-linux-mint-tina


sudo apt update -y

## Download e instalaçao de programas externos ##
mkdir $DIRETORIO_DOWNLOADS

wget -c "$URL_GOOGLE_CHROME"    -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_VSCODE"           -P "$DIRETORIO_DOWNLOADS" -O vscode.deb
wget -c "$URL_SLACK"            -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_DBEAVER"          -P "$DIRETORIO_DOWNLOADS"

## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb


# Install programs in apt - shell
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Only install if not already installed
    apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

## Angular ## 
echo "installing Angular "
npm install -g @angular/cli

## Download and install Composer Latest: v1.9.1 ## 
echo "Install Composer "
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'baf1608c33254d00611ac1705c1d9958c817a1a33bce370c0595974b342601bd80b92a3f46067da89e3b06bff421f182') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer

composer 

echo "installing Laravel "
composer global require laravel/installer

## install wine
echo "installing Wine "
sudo apt install --install-recommends winehq-stable wine-stable wine-stable-i386 wine-stable-amd64 -y



# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
sudo apt update && sudo apt dist-upgrade -y
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #
