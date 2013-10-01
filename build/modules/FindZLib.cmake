# - Try to find ZLib
# Once done, this will define
#
# ZLib_FOUND - system has ZLib
# ZLib_INCLUDE_DIRS - the ZLib include directories
# ZLib_LIBRARIES - link these to use ZLib

include(LibFindMacros)
include(SelectLibraryConfigurations)

# Dependencies
# The current package name (ZLib) is included as first paramater in order to foward the REQUIRED or QUIET paramaters
# to the find_package for the dependent library (ie Threads)
#libfind_package(ZLib)

# Use pkg-config to get hints about paths
if(UNIX)
   libfind_pkg_check_modules(ZLib_PKGCONF zlib)
endif()

# Include dir
find_path(ZLib_INCLUDE_DIR
   NAMES zlib.h
   HINTS 
      ${ZLib_PKGCONF_INCLUDE_DIRS}
      ${TCCE_WIN_EXTERNALS_INCLUDEDIR}/zlib
)

find_library(ZLib_LIBRARY_DEBUG
NAMES zlib1d
HINTS 
   ${ZLib_PKGCONF_LIBRARY_DIRS}
   ${TCCE_WIN_EXTERNALS_LIBDIR}/zlib/lib)
   
find_library(ZLib_LIBRARY_RELEASE
NAMES zlib1 z
HINTS 
   ${ZLib_PKGCONF_LIBRARY_DIRS}
   ${TCCE_WIN_EXTERNALS_LIBDIR}/zlib/lib)


# Select_library_configurations sets breakpad_FOUND to true, but we wait for libfind_process to do this so revert this value
select_library_configurations( ZLib )
set(ZLib_FOUND FALSE)
   
# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(ZLib_PROCESS_INCLUDES ZLib_INCLUDE_DIR)
set(ZLib_PROCESS_LIBS ZLib_LIBRARY)
libfind_process(ZLib)
