#!/bin/bash
programa=$(zenity --list --width=400 --height=350 \
  --title="Menu desenvolvedor" \
  --column="Escolha a ferramenta quer executar"   \
           "Firefox"                              \
           "Chrome"                               \
           "Sublime Text 3"                       \
           "Otter Browser"                        \
           "Visual Studio Code"                   \
           "Atom"                                 \
	         "Meld"				                          \
           "Terminal"                             2> /dev/null )

if [ -z "$programa" ]; then
    exit 0;
fi

case "$programa" in
    "Firefox") ./firefox/firefox -private-window &
       ;;
    "Chrome") ./chrome-linux/chrome -incognito &
       ;;
    "Otter Browser") ./otter-browser.AppImage &
       ;;
    "Sublime Text 3") ./sublime_text_3/sublime_text &
       ;;
    "Visual Studio Code") ./VSCode-linux-x64/code &
       ;;   
    "Atom") ./atom/atom &
       ;;
    "Meld") meld &
       ;;
    "Terminal") gnome-terminal --maximize &
       ;;   
    *) echo "Opcao nao disponível!"
       ;;
esac
