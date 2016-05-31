COMPATIBLE_MACHINE_sama5d4_xplained = "sama5d4_xplained"

FILESEXTRAPATHS_prepend := "${THISDIR}/linux-at91_4.1:"
SRCREV = "19291d7be4fbfac1789e48c4d3be46515bc79284"

SRC_URI += "file://0001-patch-dts-file-for-mmc-cd.patch"
