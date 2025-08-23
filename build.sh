#!/bin/bash
#Script to build buildroot configuration
#Author: Siddhant Jajoo

# Save the original PATH
ORIGINAL_PATH=$PATH

# Clean the PATH for the build
# Remove paths that contain spaces
CLEAN_PATH=$(echo "$ORIGINAL_PATH" | tr ':' '\n' | grep -v ' ' | tr '\n' ':')

# Remove current directory (.) from PATH
CLEAN_PATH=$(echo "$CLEAN_PATH" | tr ':' '\n' | grep -v '^\.$' | tr '\n' ':')

# Remove empty entries (::) and trailing colons (:)
CLEAN_PATH=$(echo "$CLEAN_PATH" | sed -e 's/::/:/g' -e 's/:$//')

# Export the cleaned PATH for the build
export PATH=$CLEAN_PATH

source shared.sh

EXTERNAL_REL_BUILDROOT=../base_external
git submodule init
git submodule sync
git submodule update

set -e 
cd `dirname $0`

rm -rf buildroot/output

if [ ! -e buildroot/.config ]
then
	echo "MISSING BUILDROOT CONFIGURATION FILE"

	if [ -e ${AESD_MODIFIED_DEFCONFIG} ]
	then
		echo "1 USING ${AESD_MODIFIED_DEFCONFIG}"
		make -C buildroot defconfig BR2_EXTERNAL=${EXTERNAL_REL_BUILDROOT} BR2_DEFCONFIG=${AESD_MODIFIED_DEFCONFIG_REL_BUILDROOT} V=1 O=output
	else
		echo "Run ./save_config.sh to save this as the default configuration in ${AESD_MODIFIED_DEFCONFIG}"
		echo "Then add packages as needed to complete the installation, re-running ./save_config.sh as needed"
		make -C buildroot defconfig BR2_EXTERNAL=${EXTERNAL_REL_BUILDROOT} BR2_DEFCONFIG=${AESD_DEFAULT_DEFCONFIG}  O=output V=1
	fi
else
	echo "USING EXISTING BUILDROOT CONFIG"
	echo "To force update, delete .config or make changes using make menuconfig and build again."
	make -C buildroot BR2_EXTERNAL=${EXTERNAL_REL_BUILDROOT} V=1 O=output source
	make -C buildroot BR2_EXTERNAL=${EXTERNAL_REL_BUILDROOT} V=1 O=output

fi
export PATH=$ORIGINAL_PATH