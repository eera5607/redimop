#! /bin/bash
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
SIZEINT='^[0-9]+$'
read -p "Enter the path: " -i "$HOME/Pictures/" -e FOLDER
read -p "Do you want to resize the images? (y or n): " -e RESIZE

if [ $RESIZE = "y" ]
then
# maximun width
read -p "Enter the width in pixels: " -i "640" -e WIDTH
# maximun height
read -p "Enter the height in pixels: " -i "480" -e HEIGHT

	if ! [[ $WIDTH =~ $SIZEINT ]] || ! [[ $HEIGHT =~ $SIZEINT ]]
	then
	echo "Dimensions must be in pixels but don't add \"px\" at the end. For example: 640"
	exit 1
	fi
	
elif [ $RESIZE = "n" ]
then
echo "- Images are not going to be resized"
else
echo "Choose a correct option. Only ${BOLD}y${NORMAL} and ${BOLD}n${NORMAL} are admitted"
exit 2
fi

read -p "Do you want to optimize the images? (y or n): " -e OPTIMIZE

if ! [[ $OPTIMIZE = "y" || $OPTIMIZE = "n" ]]
then
echo "Choose a correct option. Only ${BOLD}y${NORMAL} and ${BOLD}n${NORMAL} are admitted"
exit 3
fi

if [ $RESIZE = "n" ] && [ $OPTIMIZE = "n" ]
then
echo "- Images are not going to be optimized"
echo "No changes will be applied to the images. Exiting now"
exit 4
fi

read -p "Enter the images extension (jpg, png or both): " -i "both" -e FORMAT

if [ $OPTIMIZE = "y" ] && [ $FORMAT = "both" ]
then
read -p "Enter the jpg quality factor (0-100). 85-92 is recommended: " -i "85" -e QJPG
read -p "Enter the png optimization level (1-10). 2-5 is recommended: " -i "5" -e QPNG
	if ! [[ $QJPG =~ $SIZEINT ]] || ! [[ $QPNG =~ $SIZEINT ]]
	then
	echo "Wrong JPG quality factor or PNG optimization."
	exit 5
	elif ! [ "$QJPG" -ge 0 -a "$QJPG" -le 100 ] || ! [ "$QPNG" -ge 1 -a "$QPNG" -le 10 ]
	then
	echo "JPG quality factor or PNG optimization level outside of range."
	exit 6
	fi
elif [ $OPTIMIZE = "y" ] && [ $FORMAT = "png" ]
then
read -p "Enter the png optimization level (1-10). 2-5 is recommended: " -i "5" -e QPNG
	if ! [[ $QPNG =~ $SIZEINT ]]
	then
	echo "Wrong PNG optimization level."
	exit 7
	elif ! [ "$QPNG" -ge 1 -a "$QPNG" -le 10 ]
	then
	echo "PNG optimization level out of range."
	exit 8
	fi
elif [ $OPTIMIZE = "y" ] && [ $FORMAT = "jpg" ]
then
read -p "Enter the jpg quality factor (0-100). 85-92 is recommended: " -i "85" -e QJPG
	if ! [[ $QJPG =~ $SIZEINT ]]
	then
	echo "Wrong JPG quality factor."
	exit 9
	elif ! [ "$QJPG" -ge 0 -a "$QJPG" -le 100 ]
	then
	echo "JPG quality factor out of range."
	exit 10
	fi
elif [ $OPTIMIZE = "n" ]
then
echo "- Images are not going to be optimized."
else
echo "Choose appropriate options. Only ${BOLD}jpg${NORMAL}, ${BOLD}png${NORMAL} or ${BOLD}both${NORMAL} are admitted."
exit 11
fi

if [ $RESIZE = "y" ] && [ $OPTIMIZE = "y" ] && [ $FORMAT = "both" ]
then
find $FOLDER -iname '*.jpg' -exec convert \{} -verbose -resize $HEIGHTx$WIDTH\> \{} \;
find $FOLDER -iname '*.png' -exec convert \{} -verbose -resize $HEIGHTx$WIDTH\> \{} \;
find $FOLDER -type f -iname '*.png' -exec optipng -o${QPNG} {} \;
find $FOLDER -type f -iname '*.jpg' -exec jpegoptim -m${QJPG} --strip-all {} +
echo "The process has been completed successfully."
elif [ $RESIZE = "n" ] && [ $OPTIMIZE = "y" ] && [ $FORMAT = "both" ]
then
find $FOLDER -type f -iname '*.png' -exec optipng -o${QPNG} {} \;
find $FOLDER -type f -iname '*.jpg' -exec jpegoptim -m${QJPG} --strip-all {} +
echo "The process has been completed successfully."
elif [ $RESIZE = "y" ] && [ $OPTIMIZE = "n" ] && [ $FORMAT = "both" ]
then
find $FOLDER -iname '*.jpg' -exec convert \{} -verbose -resize $HEIGHTx$WIDTH\> \{} \;
find $FOLDER -iname '*.png' -exec convert \{} -verbose -resize $HEIGHTx$WIDTH\> \{} \;
echo "The process has been completed successfully."
elif [ $RESIZE = "y" ] && [ $OPTIMIZE = "y" ] && [ $FORMAT = "jpg" ]
then
find $FOLDER -iname '*.jpg' -exec convert \{} -verbose -resize $HEIGHTx$WIDTH\> \{} \;
find $FOLDER -type f -iname '*.jpg' -exec jpegoptim -m${QJPG} --strip-all {} +
echo "The process has been completed successfully."
elif [ $RESIZE = "y" ] && [ $OPTIMIZE = "y" ] && [ $FORMAT = "png" ]
then
find $FOLDER -iname '*.png' -exec convert \{} -verbose -resize $HEIGHTx$WIDTH\> \{} \;
find $FOLDER -type f -iname '*.png' -exec optipng -o${QPNG} {} \;
echo "The process has been completed successfully."
elif [ $RESIZE = "n" ] && [ $OPTIMIZE = "y" ] && [ $FORMAT = "png" ]
then
find $FOLDER -type f -iname '*.png' -exec optipng -o${QPNG} {} \;
echo "The process has been completed successfully."
elif [ $RESIZE = "n" ] && [ $OPTIMIZE = "y" ] && [ $FORMAT = "jpg" ]
then
find $FOLDER -type f -iname '*.jpg' -exec jpegoptim -m${QJPG} --strip-all {} +
echo "The process has been completed successfully."
elif [ $RESIZE = "y" ] && [ $OPTIMIZE = "n" ] && [ $FORMAT = "jpg" ]
then
find $FOLDER -iname '*.jpg' -exec convert \{} -verbose -resize $HEIGHTx$WIDTH\> \{} \;
echo "The process has been completed successfully."
elif [ $RESIZE = "y" ] && [ $OPTIMIZE = "n" ] && [ $FORMAT = "png" ]
then
find $FOLDER -iname '*.png' -exec convert \{} -verbose -resize $HEIGHTx$WIDTH\> \{} \;
echo "The process has been completed successfully."
fi
/bin/bash
