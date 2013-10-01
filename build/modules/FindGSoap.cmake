# - Try to find 
# Once done, this will define
#
# GSoap_FOUND - system has GSoap
# GSoap_INCLUDE_DIRS - the GSoap include directories
# GSoap_LIBRARIES - link these to use GSoap

include(LibFindMacros)
include(SelectLibraryConfigurations)

# Dependencies
# The current package name (GSoap) is included as first paramater in order to foward the REQUIRED or QUIET paramaters
# to the find_package for the dependent library (ie Threads)
libfind_package(GSoap OpenSSL)
libfind_package(GSoap ZLib)

# Use pkg-config to get hints about paths
#libfind_pkg_check_modules(GSoap_PKGCONF gsoap)

# Include dir
find_path(GSoap_INCLUDE_DIR
  NAMES stdsoap2.h
  HINTS ${THIRDPARTY_ROOTDIR}/gsoap/2.7.13-tcce_patch/include
  HINTS ${TCCE_WIN_EXTERNALS_INCLUDEDIR}/gsoap
  NO_DEFAULT_PATH ON
  #PATHS ${GSoap_PKGCONF_INCLUDE_DIRS}
)

# Normally the library prefix 'lib' is only prepended on linux systems, this adds the prefix for windows as gsoap libraries in windows start with 'lib'
set(CMAKE_FIND_LIBRARY_PREFIXES lib)

find_library(GSoap_LIBRARY_RELEASE
  NAMES gsoap
  HINTS ${THIRDPARTY_ROOTDIR}/gsoap/2.7.13-tcce_patch/lib
  HINTS ${TCCE_WIN_EXTERNALS_LIBDIR}/gsoap
  NO_DEFAULT_PATH
)
  
find_library(GSoap_LIBRARY_DEBUG
  NAMES gsoapd gsoap_debug
  HINTS ${THIRDPARTY_ROOTDIR}/gsoap/2.7.13-tcce_patch/lib
  HINTS ${TCCE_WIN_EXTERNALS_LIBDIR}/gsoap
  NO_DEFAULT_PATH
)

# Select_library_configurations sets GSoap_FOUND to true, but we wait for libfind_process to do this so revert this value
   select_library_configurations( GSoap )
   set(GSoap_FOUND FALSE)
   
# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(GSoap_PROCESS_INCLUDES GSoap_INCLUDE_DIR OpenSSL_INCLUDE_DIRS ZLib_INCLUDE_DIRS)
set(GSoap_PROCESS_LIBS GSoap_LIBRARY OpenSSL_LIBRARIES ZLib_LIBRARIES)
libfind_process(GSoap)
