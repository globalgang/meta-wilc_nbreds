# meta-wilc
<a href="http://www:.atmel.com"><img src="http://www.atmel.com/Images/atmel.png" align="left" hspace="10" vspace="6"></a>

This repository provides ATWILC1000 driver on Poky.

see [ATWILC1000 driver](https://github.com/linux4sc/staging.git).

##Sources
#### meta-wilc
* URI: git://github.com/linux4sc/meta-wilc.git
* URI: https://github.com/linux4sc/meta-wilc.git

##Dependencies
#### meta-atmel
* URI: git://github.com/linux4sam/meta-atmel.git
* URI: https://github.com/linux4sam/meta-atmel.git

#### meta-openembedded
* URI: git://git.openembedded.org/meta-openembedded
* URI: http://cgit.openembedded.org/meta-openembedded/

#### meta-qt5
* URI: git://github.com/meta-qt5/meta-qt5.git
* URI: https://github.com/meta-qt5/meta-qt5

##Build procedure
#####1. Clone yocto/poky git repository
~~~
git clone git://git.yoctoproject.org/poky
~~~
#####2. Clone meta-openembedded git repository
~~~
git clone git://git.openembedded.org/meta-openembedded
~~~
#####3. Clone meta-qt5 git repository
~~~
git clone git://github.com/meta-qt5/meta-qt5.git
cd meta-qt5
git reset --hard 754aaadc7f0a1c98a4895899617afbaef0f1cdfa
cd ../
~~~
#####4. Clone meta-atmel layer
~~~
git clone https://github.com/linux4sc/meta-atmel.git
~~~
#####5. Clone meta-wilc layer
~~~
git clone https://github.com/linux4sc/meta-wilc.git
~~~
#####6. Initialize build directory
~~~
cd poky
source oe-init-build-env build-atmel
~~~
#####7. Add meta-wilc layer patch to bblayer configuration file
~~~
vim conf/bblayers.conf
~~~
~~~
# LAYER_CONF_VERSION is increased each time build/conf/bblayers.conf
# changes incompatibly
POKY_BBLAYERS_CONF_VERSION = "2"

BBPATH = "${TOPDIR}"
BBFILES ?= ""

BSPDIR := "${@os.path.abspath(os.path.dirname(d.getVar('FILE', True)) + '/../../..')}"

BBLAYERS ?= " \
  ${BSPDIR}/poky/meta \
  ${BSPDIR}/poky/meta-poky \
  ${BSPDIR}/poky/meta-yocto-bsp \
  ${BSPDIR}/meta-atmel \
  ${BSPDIR}/meta-openembedded/meta-oe \
  ${BSPDIR}/meta-openembedded/meta-networking \
  ${BSPDIR}/meta-openembedded/meta-python \
  ${BSPDIR}/meta-openembedded/meta-ruby \
  ${BSPDIR}/meta-openembedded/meta-multimedia \
  ${BSPDIR}/meta-qt5 \
  ${BSPDIR}/meta-wilc \
  "

BLAYERS_NON_REMOVABLE ?= " \
  ${BSPDIR}/poky/meta \
  ${BSPDIR}/poky/meta-poky \
  "
~~~
#####8. Edit local.conf to specify the machine, location of source archived, package type (rpm, deb or ipk)
~~~
vim conf/local.conf
~~~
~~~
[...]
MACHINE ??= "sama5d4-xplained"
[...]
DL_DIR ?= "your_download_directory_path"
[...]
PACKAGE_CLASSES ?= "package_ipk"
~~~
Here are the machines that are supported:
* MACHINE ??= "at91sam9rlek"
* MACHINE ??= "at91sam9m10g45ek"
* MACHINE ??= "at91sam9x5ek"
* MACHINE ??= "sama5d3xek"
* MACHINE ??= "sama5d3-xplained"
* MACHINE ??= "sama5d4ek"
* MACHINE ??= "sama5d4-xplained"

To get better performance, use the poky-atmel distribution by also adding that
line:
~~~
DISTRO = "poky-atmel"
~~~
Input correct package name
~~~  
#Atmel
IMAGE_INSTALL_append += " \
  hostapd \
  wilc1000 "
~~~
#####9. We found that additional local.conf changes are needed for our QT demo image. 
You can add these two lines at the end of the file:
~~~
vim conf/local.conf
~~~
~~~
[...]
LICENSE_FLAGS_WHITELIST += "commercial"
SYSVINIT_ENABLED_GETTYS = ""
~~~
#####14. Build Atmel demo images
~~~
bitbake atmel-qt5-demo-image
~~~
