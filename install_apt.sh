########
# init #
########

function pm_update(){
	sudo apt -y update
}

############
# packages #
############

# general
function pm_general(){
	sudo apt -y install vim
	sudo apt -y install neovim
	sudo apt -y install git
	sudo apt -y install firefox
	sudo apt -y install curl
}
# dev packages
function pm_dev(){
	sudo apt -y install build-essential
	sudo apt -y install nasm
	sudo apt -y install qemu
	sudo apt -y install qemu-kvm
	sudo apt -y install bison
	sudo apt -y install flex
	sudo apt -y install libgmp3-dev
	sudo apt -y install libmpc-dev
	sudo apt -y install libmpfr-dev
	sudo apt -y install texinfo
}
# additional packages
function pm_additional(){
	sudo apt -y install thunderbird
	sudo apt -y install virtualbox
}

###########
# upgrade #
###########

function pm_upgrade(){
	sudo apt -y upgrade
}

#################
# configuration #
#################

function c_copyconfig(){
	cp ./res/vimrc ~/.vimrc
}

function c_installconfig(){

}

################
# i386-elf-gcc #
################

function o_i386gcc(){
	export PREFIX="/usr/local/i386elfgcc"
	export TARGET=i386-elf
	export PATH="$PREFIX/bin:$PATH"
	mkdir /tmp/src
	cd /tmp/src
	curl -O http://ftp.gnu.org/gnu/binutils/binutils-2.39.tar.gz
	tar xf binutils-2.39.tar.gz
	mkdir binutils-build
	cd binutils-build
	../binutils-2.39/configure --target=$TARGET --enable-interwork --enable-multilib --disable-nls --disable-werror --prefix=$PREFIX 2>&1 | tee configure.log
	sudo make all install 2>&1 | tee make.log
	cd /tmp/src
	curl -O https://ftp.gnu.org/gnu/gcc/gcc-12.2.0/gcc-12.2.0.tar.gz
	tar xf gcc-12.2.0.tar.gz
	mkdir gcc-build
	cd gcc-build
	echo Configure: . . . . . . .
	../gcc-12.2.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --disable-libssp --enable-language=c,c++ --without-headers
	echo MAKE ALL-GCC:
	sudo make all-gcc
	echo MAKE ALL-TARGET-LIBGCC:
	sudo make all-target-libgcc
	echo MAKE INSTALL-GCC:
	sudo make install-gcc
	echo MAKE INSTALL-TARGET-LIBGCC:
	sudo make install-target-libgcc
	echo HERE U GO MAYBE:
	ls /usr/local/i386elfgcc/bin
	export PATH="$PATH:/usr/local/i386elfgcc/bin"
}

###########
# general #
###########

function readconfig(){
	
}

function installfromconfig(){

}

function installeverything(){
	echo "Initializing..."
	pm_update
	echo "Installing general packages..."
	pm_general
	echo "Installing dev packages..."
	pm_dev
	echo "Installing additional packages..."
	pm_additional
	echo "Upgrading system..."
	pm_upgrade
	
	echo "Copying configuration..."
	c_copyconfig
	echo "Installing configuration..."
	c_installconfig
	echo "Building i386-elf-gcc..."
	o_i386gcc
}

if [ $1 = '--all' ]; then
	installeverything
fi

if [ $1 = '--minimal' ]; then
	echo "Initializing..."
	pm_update
	echo "Installing general packages..."
	pm_general
	echo "Upgrading system..."
	pm_upgrade
	echo "Copying configuration..."
	c_copyconfig

fi

if [ $1 = '--dev' ]; then
	echo "Initializing..."
	pm_update
	echo "Installing dev packages..."
	pm_dev

fi

if [ $1 = '--additional' ]; then
	echo "Initializing..."
	pm_update
	echo "Installing dev packages..."
	pm_additional

fi

if [ $1 = '--config' ]; then
	installfromconfig
fi
