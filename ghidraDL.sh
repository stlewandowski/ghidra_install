#!/bin/bash
sudo apt -y update
cd ~/Downloads
wget -r -l1 -H -t1 -nd -N -np -A.zip -erobots=off https://www.ghidra-sre.org
in=`ls | grep ghidra_`
echo "Computing checksum for $in..."
a=`sha256sum $in`
ver="$(echo $in | cut -d'_' -f2)"
hsh=`echo $a | cut -d' ' -f 1`
hsh_url=https://www.ghidra-sre.org/releaseNotes_$ver.html
echo "Getting checksum from $hsh_url"
hsh_web=$(wget $hsh_url -q -O -)
echo $hsh_web
cksm=`echo $hsh_web | awk -F'</*code>' '$2{print $2}'`
echo "Ghidra $ver hash:"
echo $cksm
echo "Checking file integrity."
echo "Comparing checksums."
echo "Downloaded checksum:"
echo $hsh
echo 
if [ "$hsh" = "$cksm" ]; then
	echo "File Verified, continuing installation."
else
	echo "File Corrupted.  Deleting file and exiting."
	rm ghidra_*
	exit 1
fi
mkdir ~/ghidra
unzip $in -d ~/ghidra
cd ~/ghidra
ghi_dir=`ls | grep ghidra_`
cd ~/ghidra/$ghi_dir
sudo apt install -y openjdk-11-jdk openjdk-11-jre-headless
echo 
echo "JDK installed."
echo "Creating Ghidra alias."
b=`whoami`
echo "alias run_ghidra='/home/$b/ghidra/ghidra_$ver\_PUBLIC/ghidraRun'" >> ~/.bashrc
echo "Alias created:"
echo "run_ghidra"
echo "To run Ghidra as user $b, use the 'run_ghidra' alias."
exec bash
