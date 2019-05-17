#!/bin/bash

#
# Copyright 2017-2019 Benjamin Worpitz
#
# This file is part of Alpaka.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

source ./script/travis/set.sh

# runtime and compile time options
ALPAKA_DOCKER_ENV_LIST=()
ALPAKA_DOCKER_ENV_LIST+=("--env" "CC=${CC}")
ALPAKA_DOCKER_ENV_LIST+=("--env" "CXX=${CXX}")
ALPAKA_DOCKER_ENV_LIST+=("--env" "TRAVIS_OS_NAME=${TRAVIS_OS_NAME}")
ALPAKA_DOCKER_ENV_LIST+=("--env" "CMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}")
ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_CI_ANALYSIS=${ALPAKA_CI_ANALYSIS}")
ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_CI_BOOST_BRANCH=${ALPAKA_CI_BOOST_BRANCH}")
ALPAKA_DOCKER_ENV_LIST+=("--env" "BOOST_ROOT=${BOOST_ROOT}")
ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_CI_BOOST_LIB_DIR=${ALPAKA_CI_BOOST_LIB_DIR}")
ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_CI_CLANG_DIR=${ALPAKA_CI_CLANG_DIR}")
if [ ! -z ${ALPAKA_CI_CLANG_VER+x} ]
then
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_CI_CLANG_VER=${ALPAKA_CI_CLANG_VER}")
fi
ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_CI_STDLIB=${ALPAKA_CI_STDLIB}")
if [ ! -z ${ALPAKA_CI_CLANG_LIBSTDCPP_VERSION+x} ]
then
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_CI_CLANG_LIBSTDCPP_VERSION=${ALPAKA_CI_CLANG_LIBSTDCPP_VERSION}")
fi
ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_CI_CMAKE_VER=${ALPAKA_CI_CMAKE_VER}")
ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_CI_CMAKE_DIR=${ALPAKA_CI_CMAKE_DIR}")
if [ ! -z ${ALPAKA_CI_GCC_VER+x} ]
then
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_CI_GCC_VER=${ALPAKA_CI_GCC_VER}")
fi
if [ ! -z ${ALPAKA_CI_SANITIZERS+x} ]
then
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_CI_SANITIZERS=${ALPAKA_CI_SANITIZERS}")
fi
if [ ! -z ${ALPAKA_ACC_CPU_B_SEQ_T_SEQ_ENABLE+x} ]
then
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_ACC_CPU_B_SEQ_T_SEQ_ENABLE=${ALPAKA_ACC_CPU_B_SEQ_T_SEQ_ENABLE}")
fi
if [ ! -z ${ALPAKA_ACC_CPU_B_SEQ_T_THREADS_ENABLE+x} ]
then
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_ACC_CPU_B_SEQ_T_THREADS_ENABLE=${ALPAKA_ACC_CPU_B_SEQ_T_THREADS_ENABLE}")
fi
if [ ! -z ${ALPAKA_ACC_CPU_B_SEQ_T_FIBERS_ENABLE+x} ]
then
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_ACC_CPU_B_SEQ_T_FIBERS_ENABLE=${ALPAKA_ACC_CPU_B_SEQ_T_FIBERS_ENABLE}")
fi
if [ ! -z ${ALPAKA_ACC_CPU_B_OMP2_T_SEQ_ENABLE+x} ]
then
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_ACC_CPU_B_OMP2_T_SEQ_ENABLE=${ALPAKA_ACC_CPU_B_OMP2_T_SEQ_ENABLE}")
fi
if [ ! -z ${ALPAKA_ACC_CPU_B_SEQ_T_OMP2_ENABLE+x} ]
then
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_ACC_CPU_B_SEQ_T_OMP2_ENABLE=${ALPAKA_ACC_CPU_B_SEQ_T_OMP2_ENABLE}")
fi
if [ ! -z ${ALPAKA_ACC_CPU_BT_OMP4_ENABLE+x} ]
then
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_ACC_CPU_BT_OMP4_ENABLE=${ALPAKA_ACC_CPU_BT_OMP4_ENABLE}")
fi
if [ ! -z ${ALPAKA_ACC_GPU_CUDA_ENABLE+x} ]
then
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_ACC_GPU_CUDA_ENABLE=${ALPAKA_ACC_GPU_CUDA_ENABLE}")
fi
if [ ! -z ${ALPAKA_ACC_GPU_HIP_ENABLE+x} ]
then
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_ACC_GPU_HIP_ENABLE=${ALPAKA_ACC_GPU_HIP_ENABLE}")
fi
if [ ! -z ${ALPAKA_ACC_CPU_B_TBB_T_SEQ_ENABLE+x} ]
then
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_ACC_CPU_B_TBB_T_SEQ_ENABLE=${ALPAKA_ACC_CPU_B_TBB_T_SEQ_ENABLE}")
fi
ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_CI_INSTALL_CUDA=${ALPAKA_CI_INSTALL_CUDA}")
if [ "${ALPAKA_CI_INSTALL_CUDA}" == "ON" ]
then
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_CI_CUDA_DIR=${ALPAKA_CI_CUDA_DIR}")
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_CUDA_VERSION=${ALPAKA_CUDA_VERSION}")
    if [ ! -z ${ALPAKA_CUDA_COMPILER+x} ]
    then
        ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_CUDA_COMPILER=${ALPAKA_CUDA_COMPILER}")
    fi
    if [ ! -z ${ALPAKA_CUDA_ARCH+x} ]
    then
        ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_CUDA_ARCH=${ALPAKA_CUDA_ARCH}")
    fi
fi
ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_CI_INSTALL_HIP=${ALPAKA_CI_INSTALL_HIP}")
if [ "${ALPAKA_CI_INSTALL_HIP}" == "ON" ]
then
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_CI_HIP_ROOT_DIR=${ALPAKA_CI_HIP_ROOT_DIR}")
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_HIP_PLATFORM=${ALPAKA_HIP_PLATFORM}")
fi

# runtime only options
ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_CI=${ALPAKA_CI}")
if [ ! -z ${ALPAKA_DEBUG+x} ]
then
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_DEBUG=${ALPAKA_DEBUG}")
fi
if [ ! -z ${ALPAKA_CXX_STANDARD+x} ]
then
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_CXX_STANDARD=${ALPAKA_CXX_STANDARD}")
fi
if [ ! -z ${OMP_NUM_THREADS+x} ]
then
    ALPAKA_DOCKER_ENV_LIST+=("--env" "OMP_NUM_THREADS=${OMP_NUM_THREADS}")
fi
if [ ! -z ${ALPAKA_ACC_GPU_CUDA_ONLY_MODE+x} ]
then
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_ACC_GPU_CUDA_ONLY_MODE=${ALPAKA_ACC_GPU_CUDA_ONLY_MODE}")
fi
if [ ! -z ${ALPAKA_ACC_GPU_HIP_ONLY_MODE+x} ]
then
    ALPAKA_DOCKER_ENV_LIST+=("--env" "ALPAKA_ACC_GPU_HIP_ONLY_MODE=${ALPAKA_ACC_GPU_HIP_ONLY_MODE}")
fi

docker images
docker images -q ${ALPAKA_CI_DOCKER_IMAGE_NAME}

# If we have created the image in the current run, we do not have to load it again, because it is already available.
if [[ "$(docker images -q ${ALPAKA_CI_DOCKER_IMAGE_NAME} 2> /dev/null)" == "" ]]; then
    gzip -dc "${ALPAKA_CI_DOCKER_CACHE_IMAGE_FILE_PATH}" | docker load
fi

# --cap-add SYS_PTRACE is required for LSAN to work
docker run --cap-add SYS_PTRACE -v "$(pwd)":"$(pwd)" -w "$(pwd)" "${ALPAKA_DOCKER_ENV_LIST[@]}" --rm "${ALPAKA_CI_DOCKER_IMAGE_NAME}" /bin/bash ./script/travis/run.sh
