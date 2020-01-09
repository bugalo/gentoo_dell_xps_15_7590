#!/bin/bash

# Change directory.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Initial download the git repo.
getdolphin() {
	echo 'Downloading Dolphin...'
	git clone https://github.com/dolphin-emu/dolphin.git
}

# Update the git repo.
updatedolphin() {
	cd $DIR/dolphin
	echo 'Updating the local repository...'
	git pull origin
}

# Build Dolphin with the desired optimizations.
build() {
	my_flags="-march=core-avx2 -fomit-frame-pointer -O2 -pipe"
	my_cpu_flags="avx avx2 fma3 mmx mmxext popcnt sse sse2 sse3 sse4_1 sse4_2 ssse3"
	my_qt_flag=true

	# cmake $DIR/dolphin
	# cmake -DCMAKE_C_FLAGS_RELEASE=$my_flags -DCMAKE_CXX_FLAGS_RELEASE=$my_flags $DIR/dolphin
	cmake -DCMAKE_C_FLAGS_RELEASE=$my_flags -DCMAKE_CXX_FLAGS_RELEASE=$my_flags -DGMX_CPU_ACCELERATION=$my_cpu_flags -DENABLE_QT2=$my_qt_flag $DIR/dolphin
	make -j7
	# make
}

# Update or download the git repo.
updatedolphin || getdolphin

# Make the required directory and move to it.
mkdir $DIR/build
cd $DIR/build

# Build the downloaded Dolphin version.
build && echo 'Compiled successfully.' || exit

# Install the downloaded Dolphin version.
echo 'Proceeding to the installation; press Enter to continue or Ctrl+C to cancel.'
read

if [$(whoami) == "root"]
then
	make install
else
	sudo make install
fi
