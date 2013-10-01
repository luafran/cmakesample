#NOTE: A FindOpenSSL.cmake file is available in default Modules dir.  

# - Try to find 
# Once done, this will define
#
# OpenSSL_FOUND - system has OpenSSL
# OpenSSL_INCLUDE_DIRS - the OpenSSL include directories
# OpenSSL_LIBRARIES - link these to use OpenSSL

include(LibFindMacros)
include(SelectLibraryConfigurations)

# Dependencies
# The current package name (OpenSSL) is included as first paramater in order to foward the REQUIRED or QUIET paramaters
# to the find_package for the dependent library (ie Threads)
# libfind_package(OpenSSL)

option (ISM_USE_SYSTEM_OPENSSL "On will dynamically link against the version of OpenSSL assumed to exist on the system at runtime. Off will statically link with the tcce controlled version of OpenSSL." OFF)
if(WIN32)
    set (ISM_OPENSSL_INCLUDE_DIR ${TCCE_WIN_EXTERNALS_INCLUDEDIR})
    set (ISM_OPENSSL_LIBRARY_DIR "${TCCE_WIN_EXTERNALS_LIBDIR}/openssl")
    set (FIND_FLAGS "NO_DEFAULT_PATH")
else()
    if (ISM_USE_SYSTEM_OPENSSL)
        libfind_pkg_check_modules(OpenSSL_PKGCONF libssl) # Use pkg-config to get hints about paths
        set (ISM_OPENSSL_INCLUDE_DIR ${OpenSSL_PKGCONF_INCLUDE_DIRS})
        set (ISM_OPENSSL_LIBRARY_DIR ${OpenSSL_PKGCONF_LIBRARY_DIRS})
    else()
        set (ISM_OPENSSL_INCLUDE_DIR "${THIRDPARTY_ROOTDIR}/openssl/0.9.8l/include")
        set (ISM_OPENSSL_LIBRARY_DIR "${THIRDPARTY_ROOTDIR}/openssl/0.9.8l/lib")
        set (FIND_FLAGS "NO_DEFAULT_PATH")
   endif()
endif()

# Include dir
find_path(OpenSSL_INCLUDE_DIR
  NAMES openssl/ssl.h
  HINTS ${ISM_OPENSSL_INCLUDE_DIR}
  ${FIND_FLAGS}
)

if(WIN32)
   find_library(Libeay32_LIBRARY_DEBUG
      NAMES libeay32d
      HINTS ${ISM_OPENSSL_LIBRARY_DIR}
      ${FIND_FLAGS}
   )
      
   find_library(Libeay32_LIBRARY_RELEASE
      NAMES libeay32
      HINTS ${ISM_OPENSSL_LIBRARY_DIR}
      ${FIND_FLAGS}
   )
      
   # Select_library_configurations sets breakpad_FOUND to true, but we wait for libfind_process to do this so revert this value
   select_library_configurations( Libeay32 )
   set(Libeay32_FOUND FALSE)
   
   find_library(OpenSSL_LIBRARY_DEBUG
      NAMES ssleay32d
      HINTS ${ISM_OPENSSL_LIBRARY_DIR}
      ${FIND_FLAGS}
   )
     
   find_library(OpenSSL_LIBRARY_RELEASE
      NAMES ssleay32
      HINTS ${ISM_OPENSSL_LIBRARY_DIR}
      ${FIND_FLAGS}
   )

   # Select_library_configurations sets breakpad_FOUND to true, but we wait for libfind_process to do this so revert this value
   select_library_configurations( OpenSSL )
   set(OpenSSL_FOUND FALSE)
else()
   find_library(OpenSSL_LIBRARY
     NAMES ssl
     HINTS ${ISM_OPENSSL_LIBRARY_DIR}
     ${FIND_FLAGS}
   )
endif()


# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(OpenSSL_PROCESS_INCLUDES OpenSSL_INCLUDE_DIR)
if(WIN32)
   set(OpenSSL_PROCESS_LIBS OpenSSL_LIBRARY Libeay32_LIBRARY)
else()
   set(OpenSSL_PROCESS_LIBS OpenSSL_LIBRARY)
endif()
libfind_process(OpenSSL)
