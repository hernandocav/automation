#!/bin/bash
APPS_DIR=~/bin

clear
echo "# Preparando"
ORIG=$PWD
cd
mkdir -p $APPS_DIR
cd $APPS_DIR
cp -f $ORIG/tools.png .
cp -f $ORIG/menu.sh .

############################
# FIREFOX
echo "# Iniciando Firefox"
FF_URL="https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=pt-BR"
wget -qO  firefox.tar.bz2 $FF_URL 
FF_OK=$(file firefox.tar.bz2| grep "bzip2 compressed data" | wc -l)

if [[ $FF_OK -eq 1 ]]; then
	rm -rf firefox
	tar jxf firefox.tar.bz2
	rm -rf firefox.tar.bz2
	echo "# Firefox Atualizado"
fi

############################
# CHROME
echo "# Iniciando chrome"
CHROME_URL="https://download-chromium.appspot.com/dl/Linux_x64?type=snapshots"
wget -qO  chrome.zip $CHROME_URL 
CHROME_OK=$(file chrome.zip| grep "Zip archive data" | wc -l)

if [[ $CHROME_OK -eq 1 ]]; then
	rm -rf chrome-linux
	unzip -q chrome.zip
	rm -rf chrome.zip
	echo "# Chrome Atualizado"
fi

############################
# OTTER BROWSER
echo "# Iniciando Otter Browser"
OTTER_URL="https://otter-browser.org/"
rm -rf otter-browser*
wget -qO - $OTTER_URL | grep -m 1 AppImage | awk -F "\"" {'print $2'} | xargs wget -qO otter-browser.AppImage 
chmod 755 otter-browser.AppImage
echo "# Otter Browser Atualizado"

############################
# SUBLIME TEXT 3
echo "# Iniciando Sublime Text"
SUBLIME_BUILD=$(wget -qO - http://www.sublimetext.com/3 | grep -Po -m1 "\\b([0-9]+)(?=\.dmg)")
SUBLIME_URL="https://download.sublimetext.com/sublime_text_3_build_"$SUBLIME_BUILD"_x64.tar.bz2"
wget -qO sublime.tar.bz2 $SUBLIME_URL
SUBLIME_OK=$(file sublime.tar.bz2| grep "bzip2 compressed data" | wc -l)
if [[ $SUBLIME_OK -eq 1 ]]; then
	rm -rf sublime_text_3
	tar jxf sublime.tar.bz2
	rm -rf sublime.tar.bz2
	echo "# Sublime Text 3 Atualizado"
fi

############################
# Visual Studio Code
echo "# Iniciando Visual Studio Code"
VSC_URL="http://go.microsoft.com/fwlink/?LinkID=620884"
rm -rf code-*
wget -qO code-stable-code.tar.gz $VSC_URL
VSC_OK=$(file code-stable-code.tar.gz| grep "gzip compressed data" | wc -l)

if [[ $VSC_OK -eq 1 ]]; then
	rm -rf VSCode-linux-x64
	tar zxf code-stable-code.tar.gz
	rm -rf code-stable-code.tar.gz
	echo "# Visual Studio Code Atualizado"
fi

#############################
# ATOM
echo "# Iniciando Atom"
ATOM_URL="https://github.com/atom/atom/releases/latest"
rm -rf atom*
wget -qO - $ATOM_URL | grep -m 1 amd64.tar.gz | awk -F "\"" {'print $2'} | xargs -I% wget -qO atom.tar.gz https://github.com/%
ATOM_OK=$(file atom.tar.gz| grep "gzip compressed data" | wc -l)
if [[ $ATOM_OK -eq 1 ]]; then	
	tar zxf atom.tar.gz
	rm -rf atom.tar.gz
	mv $(ls -d atom*) atom
	echo "# Visual Atom Atualizado"
fi

#############################
# MELD
echo "# Instalando Meld"
echo "Forneça a senha de SUDO para instalação via apt"
sudo apt-get -qq install meld
echo "# Meld Instalado"

#############################
# MENU
function menu() {
	echo -e "[Desktop Entry]\nTerminal=false\nName=Ferramentas Desenvolvedor\nExec=$HOME/bin/menu.sh\nPath=$HOME/bin\nType=Application\nIcon=$HOME/bin/tools.png" \
	> ${HOME}/.local/share/applications/tools.desktop

	favoritos_atuais=$(gsettings get "com.canonical.Unity.Launcher" favorites)
	substring="application://"
	novo_atalho="application://tools.desktop"
	ultimo_atalho_application=""

	if [ ! -z "${favoritos_atuais##*$novo_atalho*}" ]; then

	    for favorito in $(echo ${favoritos_atuais:1:-1} | tr "," "\n"); do
	        if [ -z "${favorito##*$substring*}" ]; then
	            ultimo_atalho_application="$favorito"
	        fi
	    done

	    favoritos_novos=$(echo "$favoritos_atuais" | sed s#${ultimo_atalho_application}#"${ultimo_atalho_application}, '${novo_atalho}'"#)

	    gsettings set com.canonical.Unity.Launcher favorites "$favoritos_novos"
	fi
}
menu
echo "Ferramentas Instaladas com sucesso"

