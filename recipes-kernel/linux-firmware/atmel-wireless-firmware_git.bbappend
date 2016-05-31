SUMMARY = "Atmel wilc1000 firmware files for use with Linux kernel"
SECTION = "kernel"

LICENSE = "CLOSED"

PV = "git${SRCPV}"
SRCREV = "30da6d3e0bf679f1af6c81d647c8ebb5bdc21e0a"
SRC_URI = "git://github.com/linux4sc/wireless-firmware.git"

S = "${WORKDIR}/git"

do_install() {
  install -d ${D}/lib/firmware/atmel/
  install -m 0755 *.bin ${D}/lib/firmware/atmel/
}

FILES_wilc1000-firmware += " \
  /lib/firmware/atmel/wilc1003_firmware.bin "
