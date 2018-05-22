# Redimop

Short script to resize and/or optimize images on a selected folder.

### Dependencies

The script uses `jpegoptim` and `optipng` to optimize the images and `imagemagick` to resize them. Check the additional info at the end to know how to install them. 

### Running

Download the script and set executions permissions with the command:

`chmod +x redimop.sh`

Just follow the instructions. The script lets the user enter the path of the folder where the images are located. Then it lets the user choose to resize and/or optimize the images. If the user choose to resize the images it will ask the maximum width and maximum height. The script will always preserve the aspect ratio of the images. 

If the user choose to optimize the images the script will ask the jpg quality factor and the png optimization level. In both cases, the script will use the optimization tools to remove all metadata from the image but this is not lossless optimization.

##### JPG Quality Factor

- 92-99: Very good quality, low file size reduction.
- 85-90: Good quality, important file size reduction (recommended option).
- 0 – 60: Noticeable quality reduction, great file size reduction. 

##### PNG Optimization level
- 1-2: fastest, low file size reduction.
- 3-5: recommended for balance. 
- 5-10: slowest, great file size reduction. 

### Additional information

To install the latest version of `jpegoptim`, download and extract the file from the [official website](http://www.kokkonen.net/tjko/projects.html#Jpegoptim) and execute this commands on the extracted folder:
```
./configure
make
make strip
sudo make install
```
To install the latest version of `optipng`, download and extract the file from the [official website](http://optipng.sourceforge.net/) and execute this commands on the extracted folder:
```
./configure
make
make test
sudo make install
```
imagemagick comes by default on Ubuntu but you can check using this command:

`sudo apt install  imagemagick`

IMPORTANT: Always backup the original files on another folder because the script, by default, overwrites the images contained on the selected path after being optimized and/or resized. 
