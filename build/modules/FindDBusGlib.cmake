# - Try to find 
# Once done, this will define
#
# DBusGlib_FOUND - system has DBus
# DBusGlib_INCLUDE_DIRS - the DBus include directories
# DBusGlib_LIBRARIES - link these to use DBus

include(LibFindMacros)

# Use pkg-config to get hints about paths
libfind_pkg_check_modules(DBusGlib_PKGCONF dbus-glib-1)

# Include dir
find_path(DBusGlib_INCLUDE_DIRS
  NAMES dbus/dbus-glib.h
  HINTS ${DBusGlib_PKGCONF_INCLUDE_DIRS}
)

# Finally the library itself
find_library(DBusGlib_LIBRARY
  NAMES dbus-glib-1
  HINTS ${DBusGlib_PKGCONF_LIBRARY_DIRS}
)

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(DBusGlib_PROCESS_INCLUDES DBusGlib_INCLUDE_DIRS)
set(DBusGlib_PROCESS_LIBS DBusGlib_LIBRARY)
libfind_process(DBusGlib)