#!/bin/bash
APPS_DIR=~/dev/apps;
APPS=$(ls -dla1 $APPS_DIR/* | awk '{print $9}' | awk -F '-+|_' {'print $1'}| awk -F '/' '{print NR, $6}')
LAPPS=$(ls -dla1 $APPS_DIR/* | awk '{print $9}' | awk -F '-+|_' {'print $1'}| awk -F '/' '{print $6}')

DIALOG_CANCEL=1
DIALOG_ESC=255
HEIGHT=0
WIDTH=0

ARRAY_APPS=($LAPPS)

display_result() {
  dialog --title "$1" \
    --no-collapse \
    --msgbox "$result" 0 0
}

while true; do
  exec 3>&1
  selection=$(dialog \
    --backtitle "Apps" \
    --title "Menu" \
    --clear \
    --cancel-label "Exit" \
    --menu "Please select:" 0 0 0 \
    $APPS 2>&1 1>&3)
  exit_status=$?
  #exec 3>&-     
  case $exit_status in
    $DIALOG_CANCEL)
      clear
      echo "Program terminated."
      exit
      ;;
    $DIALOG_ESC)
      clear 
      echo "Program aborted." #>&2
      exit 1
      ;;
  esac
  case $selection in
    *)
	  #display_result "teste"
      clear
      id=$(expr $selection - 1)
      
      if [ -f $APPS_DIR/${ARRAY_APPS[$id]}*/bin/${ARRAY_APPS[$id]} ] ; then
		echo "Found: " $APPS_DIR/${ARRAY_APPS[$id]}*/bin/${ARRAY_APPS[$id]}
		echo "TESTE"
		$APPS_DIR/${ARRAY_APPS[$id]}*/bin/${ARRAY_APPS[$id]} >/dev/null 2>&1&
      fi;
      if [ -f $APPS_DIR/${ARRAY_APPS[$id]}*/bin/${ARRAY_APPS[$id]}.sh ] ; then
		echo "Found: " $APPS_DIR/${ARRAY_APPS[$id]}*/bin/${ARRAY_APPS[$id]}.sh
		$APPS_DIR/${ARRAY_APPS[$id]}*/bin/${ARRAY_APPS[$id]}*.sh >/dev/null 2>&1&
      fi;
      if [ -f $APPS_DIR/${ARRAY_APPS[$id]}*/${ARRAY_APPS[$id]} ] ; then
		echo "Found: " $APPS_DIR/${ARRAY_APPS[$id]}*/${ARRAY_APPS[$id]}
        $APPS_DIR/${ARRAY_APPS[$id]}*/${ARRAY_APPS[$id]} >/dev/null 2>&1&
      fi;
      if [ -f $APPS_DIR/${ARRAY_APPS[$id]}*/${ARRAY_APPS[$id]}.sh ] ; then
		echo "Found: " $APPS_DIR/${ARRAY_APPS[$id]}*/${ARRAY_APPS[$id]}.sh
		$APPS_DIR/${ARRAY_APPS[$id]}*/${ARRAY_APPS[$id]}*.sh >/dev/null 2>&1&
      fi;

      echo "Please Wait, its running!"
      sleep 5;
	  ;;
  esac
done
