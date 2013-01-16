#!/bin/bash
##
## Patch for OpenViBE to work with EmotivEPOC headset on Linux
##
## by Thibault BRONCHAIN for IOT "I Only Think"
## http://eip.epitech.eu/2013/iot/
##

##
## user variables
EMOTIV_LOCATION="${HOME}"
EMOTIV_DIR="EmotivEducation_1.0.0.5"
OPENVIBE_LOCATION="${HOME}"
OPENVIBE_DIR="openvibe"
OPENEMO_LOCATION="."
PATCH_DIR="${OPENEMO_LOCATION}/patch"
##

##
## internal variables
EMOTIV_HEADER_PATH="${EMOTIV_LOCATION}/${EMOTIV_DIR}/doc/examples_Qt/example5"
#EMOTIV_STAT_LIB_PATH=""
EMOTIV_DYN_LIB_PATH="${EMOTIV_LOCATION}/${EMOTIV_DIR}/lib"
OPENVIBE_CMAKE_PATH="${OPENVIBE_LOCATION}/${OPENVIBE_DIR}/cmake-modules"
OPENVIBE_EMOTIV_PATH="${OPENVIBE_LOCATION}/${OPENVIBE_DIR}/openvibe-applications/acquisition-server/trunc/src/emotiv-epoc"
TMP_PATH="${OPENEMO_LOCATION}/_openemoscript_tmpfiles"
##

##
## init
mkdir $TMP_PATH
mkdir "${TMP_PATH}/emo/"
mkdir "${TMP_PATH}/openvibe/"

cp ${EMOTIV_HEADER_PATH}/{edkErrorCode.h,EmoStateDLL.h,edk.h} "${TMP_PATH}/emo/"
cp ${OPENVIBE_EMOTIV_PATH}/{ovasCConfigurationEmotivEPOC.cpp,ovasCConfigurationEmotivEPOC.h,ovasCDriverEmotivEPOC.cpp,ovasCDriverEmotivEPOC.h} "${TMP_PATH}/openvibe/"
cp ${OPENVIBE_CMAKE_PATH}/FindThirdPartyEmotivAPI.cmake "${TMP_PATH}/openvibe/"
##

##
## patch
patch "${TMP_PATH}/emo/edk.h" < "${PATCH_DIR}/edk.h.patch"
patch "${TMP_PATH}/openvibe/ovasCConfigurationEmotivEPOC.h" < "${PATCH_DIR}/ovasCConfigurationEmotivEPOC.h.patch"
patch "${TMP_PATH}/openvibe/ovasCDriverEmotivEPOC.cpp" < "${PATCH_DIR}/ovasCDriverEmotivEPOC.cpp.patch"
patch "${TMP_PATH}/openvibe/ovasCDriverEmotivEPOC.h" < "${PATCH_DIR}/ovasCDriverEmotivEPOC.h.patch"
patch "${TMP_PATH}/openvibe/FindThirdPartyEmotivAPI.cmake" < "${PATCH_DIR}/FindThirdPartyEmotivAPI.cmake.patch"
##

##
## copy openvibe files
cp ${TMP_PATH}/openvibe/{ovasCConfigurationEmotivEPOC.cpp,ovasCConfigurationEmotivEPOC.h,ovasCDriverEmotivEPOC.cpp,ovasCDriverEmotivEPOC.h} "${OPENVIBE_EMOTIV_PATH}/"
cp ${TMP_PATH}/openvibe/FindThirdPartyEmotivAPI.cmake "${OPENVIBE_CMAKE_PATH}/"
##

##
## copy root files
(sudo cp ${TMP_PATH}/emo/{edkErrorCode.h,EmoStateDLL.h,edk.h} /usr/include/) || exit
sudo cp ${EMOTIV_DYN_LIB_PATH}/libedk.so.1 /usr/lib/libedk.so
sudo cp ${EMOTIV_DYN_LIB_PATH}/libedk_utils.so /usr/lib/libedk_utils.so
##

##
## sym link libs
sudo ln -s /usr/lib/libedk.so /usr/lib/libedk.so.1
sudo ln -s /usr/lib/libedk_utils.so /usr/lib/libedk_utils.so.1
##

##
## delete tmp dir
rm -rf $TMP_PATH
##
