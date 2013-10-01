# - Try to find QtMobility
# Once done, this will define
#
# QtMobility_FOUND - system has QtMobility
# QtMobility_INCLUDE_DIRS - the QtMobility include directories
# QtMobility_LIBRARIES - link these to use QtMobility

if(WIN32)
include(LibFindMacros)
include(SelectLibraryConfigurations)

# Dependencies
# The current package name (QtMobility) is included as first paramater in order to foward the REQUIRED or QUIET paramaters
# to the find_package for the dependent library (ie Threads)
#libfind_package(QtMobility Threads)

# Include dir
find_path(QtMobility_INCLUDE_DIR
   NAMES qmobilityglobal.h
   HINTS 
      ${THIRDPARTY_ROOTDIR}/qt-mobility-1.0.1/include/
      ${TCCE_WIN_EXTERNALS_INCLUDEDIR}/qtmobility
)

# Finally the library itself
find_library(QtMobility_LIBRARY_DEBUG
   NAMES QtSystemInfod1 QtSystemInfod
   HINTS 
      ${THIRDPARTY_ROOTDIR}/qt-mobility-1.0.1/lib
      ${TCCE_WIN_EXTERNALS_LIBDIR}/QtMobility/lib
   )

find_library(QtMobility_LIBRARY_RELEASE
   NAMES QtSystemInfo1 QtSystemInfo
   HINTS 
      ${THIRDPARTY_ROOTDIR}/qt-mobility-1.0.1/lib
      ${TCCE_WIN_EXTERNALS_LIBDIR}/QtMobility/lib
   )   

# Select_library_configurations sets <component>_FOUND to true, but we wait for libfind_process to do this so revert this value
select_library_configurations( QtMobility )
set(QtMobility_FOUND FALSE)

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(QtMobility_PROCESS_INCLUDES QtMobility_INCLUDE_DIR)
set(QtMobility_PROCESS_LIBS QtMobility_LIBRARY)
libfind_process(QtMobility)
endif()
