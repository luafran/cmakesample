# - Try to find 
# Once done, this will define
#
# GConf_FOUND - system has GConf
# GConf_INCLUDE_DIRS - the GConf include directories
# GConf_LIBRARIES - link these to use GConf

include(LibFindMacros)

# Dependencies
# The current package name (GConf) is included as first paramater in order to foward the REQUIRED or QUIET paramaters
# to the find_package for the dependent library (ie Threads)
libfind_package(GConf GLib)
libfind_package(GConf GObject)

# Use pkg-config to get hints about paths
libfind_pkg_check_modules(GConf_PKGCONF gconf-2.0)

# Include dir
find_path(GConf_INCLUDE_DIR
  NAMES gconf/gconf.h
  HINTS ${GConf_PKGCONF_INCLUDE_DIRS}
)

# Finally the library itself
find_library(GConf_LIBRARY
  NAMES gconf-2
  HINTS ${GConf_PKGCONF_LIBRARY_DIRS}
)

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(GConf_PROCESS_INCLUDES GConf_INCLUDE_DIR GLib_INCLUDE_DIRS GObject_INCLUDE_DIRS)
set(GConf_PROCESS_LIBS GConf_LIBRARY GLib_LIBRARIES GObject_LIBRARIES)
libfind_process(GConf)
