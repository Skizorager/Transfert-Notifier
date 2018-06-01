#!/bin/bash
clear
rm -rf /tmp/rapport.txt
exec > >(tee -i /tmp/rapport.txt)
exec 2>&1

export SIZE=$(du -sh --block-size=1M $PWD | cut -f 1)
export SIZEGB=$(echo "scale=2; `du -sh --block-size=1M $PWD | cut -f 1` / 1000" | bc)

if [ -z "$SIZETMP" ]; then
export SIZETMP="$SIZE"
fi

export SIZECALC=$(echo "$SIZE"-"$SIZETMP" | bc)


if [ "$SIZECALC" = "0" ]; then
echo "Total : "$SIZE"Mb, "$SIZEGB"Gb, We didn t transfert anything last quarter."
else
echo "Total : "$SIZE"Mb, "$SIZEGB"Gb, "$SIZECALC"Mb Transfered last quarter."
fi
echo " "
echo "---------------------------------"
echo "What is in $PWD"
echo " "
function comptage {
	echo "$type : `find $PWD -iname "*.$type" | wc -l`"
} 


function carre {
	echo "################"
}

function vide {
	echo " "
}

carre
echo "Pictures"
carre

type="jpg"
comptage

type="png"
comptage

type="gif"
comptage

vide
carre
echo "Videos"
carre

type="avi"
comptage

type="mkv"
comptage

type="wmv"
comptage

vide
carre
echo "Audio"
carre

type="mp3"
comptage

type="ogg"
comptage

type="wma"
comptage

type="m4a"
comptage 

type="wav"
comptage

vide
carre
echo "Windows"
carre

type="url"
comptage

type="txt"
comptage

type="rtf"
comptage

type="contact"
comptage

type="zip"
comptage

type="pdf"
comptage

type="exe"
comptage


vide
carre
echo "Office Documents - Outlook"
carre

type="doc*"
comptage

type="xls*"
comptage

type="pst"
comptage

type="ppt*"
comptage

vide

carre
echo "OpenOffice - LibreOffice"
carre
type="odt"
comptage

type="ott"
comptage


vide
vide

echo "Total of files (all format included): `find $PWD -iname "*.*" | wc -l`"

echo "Total : "$SIZE"Mb, "$SIZEGB"Gb."
vide
vide

if [ -z "$minutes" ] ; then
	export minutes="0"
fi
export minutes=$(echo "$minutes"+1 | bc)

if [ -z "$heures" ] ; then
	export heures="0"
fi

if [ "$minutes" -gt "59" ] ; then
	export heures=$(echo "$heures"+1 | bc)
	export minutes="0"
	cp /tmp/rapport.txt /tmp/rapport-final.txt
fi


if [ -z "$jour" ]; then
	export jour="0"

fi
if [ "$heures" -gt "23" ] ; then
	export jour=$(echo "$jour"+1 | bc )
	export heures="0"
fi

echo ""$jour"Day(s), "$heures"Hour(s) : "$minutes"Minute(s) since the beggening of execution."
echo "Computer on since `uptime -p`"

if [ "$quart" = "" ] ; then
export quart="0"
fi

export quart=$(echo "$quart"+1 | bc )

if [ "$quart" = "15" ] ; then
	if [ -z $NBMAIL ]; then
		export NBMAIL="0"
	fi
export SIZETMP="$SIZE"
	export NBMAIL=$(echo "$NBMAIL"+1 | bc)
	echo "Notification about $PWD, echo Total "$SIZE"Mb, "$SIZEGB"Gb, "$SIZECALC"Mb Transfered last quarter." | mailx -s "Transfert $PWD" -a "/tmp/rapport.txt" xxx@gmail.com
export quart="0"
fi

vide

echo "Time eslaped since last quarter (send at 15/15) : $quart/15"
vide
if [ -z $NBMAIL ]; then
	export NBMAIL="0"
fi
echo "You have been notified $NBMAIL times by mail."

vide

sleep 1m
exec $0
