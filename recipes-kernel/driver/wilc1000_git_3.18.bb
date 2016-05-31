LICENSE = "CLOSED"

inherit module

PV = "3.18"
KBRANCH = "kernel-3.18"
SRCREV = "${AUTOREV}"
SRC_URI = "git://github.com/linux4sc/staging.git;protocol=git;branch=${KBRANCH}"

S = "${WORKDIR}/git"

EXTRA_OEMAKE = '-C ${STAGING_KERNEL_DIR} M=${S} \
  CONFIG_ATMEL_SMARTCONNECT=y \
  CONFIG_WILC1000=m \
  CONFIG_WILC1000_SDIO=m \
  '

do_install() {
  install -d ${D}${base_libdir}/modules/${KERNEL_VERSION}/kernel/drivers/net/wireless/atmel/wilc1000
  install -m 0644 ${S}/*${KERNEL_OBJECT_SUFFIX} ${D}${base_libdir}/modules/${KERNEL_VERSION}/kernel/drivers/net/wireless/atmel/wilc1000
}
