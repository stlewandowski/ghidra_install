#!/bin/bash
sudo apt -y update
cd ~/Downloads
wget https://www.ghidra-sre.org/ghidra_9.0.4_PUBLIC_20190516.zip
a=`sha256sum ghidra_9.0.4_PUBLIC_20190516.zip`
hsh=`echo $a | cut -d' ' -f 1`
# check website for new versions, this version should be 9.0.4
echo "Ghidra 9.0.4 hash:"
echo "a50d0cd475d9377332811eeae66e94bdc9e7d88e58477c527e9c6b78caec18bf"
echo "Checking file integrity."
echo "Comparing checksums."
echo "Downloaded checksum:"
echo $hsh
echo "a50d0cd475d9377332811eeae66e94bdc9e7d88e58477c527e9c6b78caec18bf"
# a50d0cd475d9377332811eeae66e94bdc9e7d88e58477c527e9c6b78caec18bf
# https://www.ghidra-sre.org/releaseNotes_9.1.html
if [ "$hsh" = "a50d0cd475d9377332811eeae66e94bdc9e7d88e58477c527e9c6b78caec18bf" ]; then
	echo "File Verified, continuing installation."
else
	echo "File Corrupted.  Deleting file and exiting."
	rm ghidra_9.0.4_PUBLIC_20190516.zip
	exit 1
fi
mkdir ~/ghidra
unzip ghidra_9.0.4_PUBLIC_20190516.zip -d ~/ghidra
cd ~/ghidra/ghidra_9.0.4
sudo apt install -y openjdk-11-jdk openjdk-11-jre-headless
echo 
echo "JDK installed."
echo "Creating Ghidra alias."
b=`whoami`
echo "alias run_ghidra='/home/$b/ghidra/ghidra_9.0.4/ghidraRun'" >> ~/.bashrc
echo "Alias created:"
echo "run_ghidra"
echo "To run Ghidra as user $b, use the 'run_ghidra' alias."
exec bash