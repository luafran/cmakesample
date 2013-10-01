# - Try to find QtSingleApplication
# Once done, this will define
#
# QtSingleApplication_FOUND - system has QtSingleApplication
# QtSingleApplication_INCLUDE_DIRS - the QtSingleApplication include directories
# QtSingleApplication_CORE_SOURCES - the source files for QtCoreSingleApplicaiton
# QtSingleApplication_CORE_HEADERS - the headers files for QtCoreSingleApplicaiton
# QtSingleApplication_GUI_SOURCES - the source files for QtSingleApplicaiton
# QtSingleApplication_GUI_HEADERS - the headers files for QtSingleApplicaiton
# NOTE: No library is available for QtSingleApplication.. the source/header files 
# must be included/compiled into the project you wish to use them in.
# TODO: Make this an external library to avoid needing to include the srcs/headers

include(LibFindMacros)

# Include dir
find_path(QtSingleApplication_INCLUDE_DIR
   NAMES qtsinglecoreapplication.h
   HINTS 
      ${TCCE_WIN_EXTERNALS_INCLUDEDIR}/qtsingleapplication-2.6-commercial/src/
      ${THIRDPARTY_ROOTDIR}/qtsingleapplication-2.6-commercial/src/
      ${THIRDPARTY_ROOTDIR}/qtsingleapplication/2.6-commercial/src/
)

set(QtSingleApplication_CORE_SOURCES
      ${QtSingleApplication_INCLUDE_DIR}/qtlocalpeer.cpp
      ${QtSingleApplication_INCLUDE_DIR}/qtsinglecoreapplication.cpp)
      
set(QtSingleApplication_CORE_HEADERS
      ${QtSingleApplication_INCLUDE_DIR}/qtlocalpeer.h
      ${QtSingleApplication_INCLUDE_DIR}/qtsinglecoreapplication.h)

set(QtSingleApplication_GUI_SOURCES
      ${QtSingleApplication_INCLUDE_DIR}/qtlocalpeer.cpp
      ${QtSingleApplication_INCLUDE_DIR}/qtsingleapplication.cpp)
      
set(QtSingleApplication_GUI_HEADERS
      ${QtSingleApplication_INCLUDE_DIR}/qtlocalpeer.h
      ${QtSingleApplication_INCLUDE_DIR}/qtsingleapplication.h)      
 
set_property(SOURCE ${QtSingleApplication_CORE_SOURCES} PROPERTY COMPILE_DEFINITIONS UNICODE;_UNICODE)
set_property(SOURCE ${QtSingleApplication_CORE_HEADERS} PROPERTY COMPILE_DEFINITIONS UNICODE;_UNICODE)
set_property(SOURCE ${QtSingleApplication_GUI_SOURCES} PROPERTY COMPILE_DEFINITIONS UNICODE;_UNICODE)
set_property(SOURCE ${QtSingleApplication_GUI_HEADERS} PROPERTY COMPILE_DEFINITIONS UNICODE;_UNICODE)

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(QtSingleApplication_PROCESS_INCLUDES QtSingleApplication_INCLUDE_DIR)
libfind_process(QtSingleApplication)
