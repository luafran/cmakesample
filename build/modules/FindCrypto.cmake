# - Try to find 
# Once done, this will define
#
# Crypto_FOUND - system has Crypto
# Crypto_INCLUDE_DIRS - the Crypto include directories
# Crypto_LIBRARIES - link these to use Crypto

include(LibFindMacros)
include(SelectLibraryConfigurations)



if(WIN32)
# We assume the include dir and lib dir for this platform lib is already set in Options->Projects and Solutions->VC++ Directories for Visual Studio 
    set(Crypto_LIBRARY Crypt32.lib)
else()
    if (ISM_USE_SYSTEM_OPENSSL)
        libfind_pkg_check_modules(Crypto_PKGCONF libcrypto) # Use pkg-config to get hints about paths
        set (ISM_CRYPTO_INCLUDE_DIR ${Crypto_PKGCONF_INCLUDE_DIRS})
        set (ISM_CRYPTO_LIBRARY_DIR ${Crypto_PKGCONF_LIBRARY_DIRS})
    else()
        set (ISM_CRYPTO_INCLUDE_DIR "${THIRDPARTY_ROOTDIR}/openssl/0.9.8l/include")
        set (ISM_CRYPTO_LIBRARY_DIR "${THIRDPARTY_ROOTDIR}/openssl/0.9.8l/lib")
        set (FIND_FLAGS "NO_DEFAULT_PATH")
   endif()

    # Include dir
    find_path(Crypto_INCLUDE_DIR
        NAMES openssl/crypto.h
        HINTS ${ISM_CRYPTO_INCLUDE_DIR}
        ${FIND_FLAGS}
    )

    find_library(Crypto_LIBRARY
        NAMES crypto
        HINTS ${ISM_CRYPTO_LIBRARY_DIR}
        ${FIND_FLAGS}
    )

    set(Crypto_PROCESS_INCLUDES Crypto_INCLUDE_DIR)
endif()

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(Crypto_PROCESS_LIBS Crypto_LIBRARY)
libfind_process(Crypto)
