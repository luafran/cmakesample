# - Try to find log4cplus
# Once done, this will define
#
# Log4cplus_FOUND - system has log4cplus
# Log4cplus_INCLUDE_DIRS - the log4cplus include directories
# Log4cplus_LIBRARIES - link these to use log4cplus

include(LibFindMacros)
include(SelectLibraryConfigurations)
# Dependencies
# The current package name (Log4cplus) is included as first paramater in order to foward the REQUIRED or QUIET paramaters
# to the find_package for the dependent library (ie Threads)
libfind_package(Log4cplus Threads)

# Include dir
find_path(Log4cplus_INCLUDE_DIR
   NAMES log4cplus/logger.h
   HINTS 
      ${THIRDPARTY_ROOTDIR}/log4cplus/1.0.3/include
      ${TCCE_WIN_EXTERNALS_INCLUDEDIR}
)

# Finally the library itself
find_library(Log4cplus_LIBRARY_RELEASE
   NAMES log4cplus
   HINTS 
      ${THIRDPARTY_ROOTDIR}/log4cplus/1.0.3/lib
      ${TCCE_WIN_EXTERNALS_LIBDIR}/log4cplus
)
find_library(Log4cplus_LIBRARY_DEBUG
   NAMES log4cplusD
   HINTS 
      ${THIRDPARTY_ROOTDIR}/log4cplus/1.0.3/lib
      ${TCCE_WIN_EXTERNALS_LIBDIR}/log4cplus
)

# Select_library_configurations sets breakpad_FOUND to true, but we wait for libfind_process to do this so revert this value
select_library_configurations( Log4cplus )
set(Log4cplus_FOUND FALSE)

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(Log4cplus_PROCESS_INCLUDES Log4cplus_INCLUDE_DIR)
set(Log4cplus_PROCESS_LIBS Log4cplus_LIBRARY)
libfind_process(Log4cplus)
