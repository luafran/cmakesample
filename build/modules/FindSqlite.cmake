# - Try to find sqlite
# Once done, this will define
#
# Sqlite_FOUND - system has sqlite
# Sqlite_INCLUDE_DIRS - the sqlite include directories
# Sqlite_LIBRARIES - link these to use sqlite

include(LibFindMacros)
include(SelectLibraryConfigurations)

# Dependencies
# The current package name (Sqlite) is included as first paramater in order to foward the REQUIRED or QUIET paramaters
# to the find_package for the dependent library (ie Threads)
#libfind_package(Sqlite Threads)

# For MeeGo we should use the system versions of sqlite, on windows we use TCCE provided versions
option (ISM_USE_SYSTEM_SQLITE "On will dynamically link against the version of Sqlite assumed to exist on the system at runtime. Off will statically link with the tcce controlled version of Sqlite." OFF)
if(WIN32)
    set (ISM_SQLITE_INCLUDE_DIR ${TCCE_WIN_EXTERNALS_INCLUDEDIR})
    set (ISM_SQLITE_LIBRARY_DIR "${TCCE_WIN_EXTERNALS_LIBDIR}/sqlite3")
else()
    if (ISM_USE_SYSTEM_SQLITE)
        libfind_pkg_check_modules(Sqlite_PKGCONF sqlite3) # Use pkg-config to get hints about paths
        set (ISM_SQLITE_INCLUDE_DIR ${Sqlite_PKGCONF_INCLUDE_DIRS})
        set (ISM_SQLITE_LIBRARY_DIR ${Sqlite_PKGCONF_LIBRARY_DIRS})
    else()
        set (ISM_SQLITE_INCLUDE_DIR "${THIRDPARTY_ROOTDIR}/sqlite/3.6.14/include")
        set (ISM_SQLITE_LIBRARY_DIR "${THIRDPARTY_ROOTDIR}/sqlite/3.6.14/lib")
        set (FIND_FLAGS "NO_DEFAULT_PATH")
   endif()
endif()

# Include dir
# For Windows there is a generic include path so the .h is located inside an
# sqlite folder.
# For Meego the include path is particular to sqlite
find_path(Sqlite_INCLUDE_DIR
   NAMES sqlite3/sqlite3.h sqlite3.h
   HINTS ${ISM_SQLITE_INCLUDE_DIR}
   ${FIND_FLAGS}
)

# Finally the library itself
find_library(Sqlite_LIBRARY_DEBUG
   NAMES sqlite3d
   HINTS ${ISM_SQLITE_LIBRARY_DIR}
   ${FIND_FLAGS}
)

find_library(Sqlite_LIBRARY_RELEASE
   NAMES sqlite3
   HINTS ${ISM_SQLITE_LIBRARY_DIR}
   ${FIND_FLAGS}
)

# Select_library_configurations sets GSoap_FOUND to true, but we wait for libfind_process to do this so revert this value
select_library_configurations( Sqlite )
set(Sqlite_FOUND FALSE)
   
# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(Sqlite_PROCESS_INCLUDES Sqlite_INCLUDE_DIR)
set(Sqlite_PROCESS_LIBS Sqlite_LIBRARY)
libfind_process(Sqlite)
