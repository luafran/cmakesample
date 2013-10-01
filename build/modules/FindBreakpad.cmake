# - Try to find 
# Once done, this will define
#
# Breakpad_FOUND - system has Breakpad
# Breakpad_INCLUDE_DIRS - the Breakpad include directories
# Breakpad_LIBRARIES - link these to use Breakpad
# 
# COMPONENTS available: sender handler

include(LibFindMacros)
include(SelectLibraryConfigurations)

foreach(component ${Breakpad_FIND_COMPONENTS})
   if(component STREQUAL "sender")
      if(WIN32)
         find_path(Breakpad_${component}_INCLUDE_DIR
            NAMES crash_report_sender.h
            HINTS ${TCCE_WIN_EXTERNALS_INCLUDEDIR}/google-breakpad/src/client/windows/sender)
         find_library(Breakpad_${component}_LIBRARY_DEBUG
           NAMES crash_report_sender_D
           HINTS ${TCCE_WIN_EXTERNALS_LIBDIR}/google-breakpad)
         find_library(Breakpad_${component}_LIBRARY_RELEASE
           NAMES crash_report_sender
           HINTS ${TCCE_WIN_EXTERNALS_LIBDIR}/google-breakpad)      
         set(NATIVE_LIBRARIES wininet.lib)
      else()
         # TODO: No sender header required for linux?
         find_path(Breakpad_${component}_INCLUDE_DIR
            NAMES breakpad_googletest_includes.h
            HINTS ${THIRDPARTY_ROOTDIR}/breakpad/trunk_596/include)
         find_library(Breakpad_${component}_LIBRARY
              NAMES http_upload.a
              HINTS ${THIRDPARTY_ROOTDIR}/breakpad/trunk_596/lib)
      endif()
   elseif(component STREQUAL "handler")
      if(WIN32)
         find_path(Breakpad_${component}_INCLUDE_DIR
            NAMES breakpad_googletest_includes.h
            HINTS ${TCCE_WIN_EXTERNALS_INCLUDEDIR}/google-breakpad/src)
         find_library(Breakpad_${component}_LIBRARY_DEBUG
           NAMES exception_handler_D
           HINTS ${TCCE_WIN_EXTERNALS_LIBDIR}/google-breakpad)
         find_library(Breakpad_${component}_LIBRARY_RELEASE
           NAMES exception_handler
           HINTS ${TCCE_WIN_EXTERNALS_LIBDIR}/google-breakpad)
      else()
         find_path(Breakpad_${component}_INCLUDE_DIR
            NAMES breakpad_googletest_includes.h
            HINTS ${THIRDPARTY_ROOTDIR}/breakpad/trunk_596/include)
         find_library(Breakpad_${component}_LIBRARY
              NAMES libbreakpad_client.a
              HINTS ${THIRDPARTY_ROOTDIR}/breakpad/trunk_596/lib)
      endif()
   endif()
   
   # Select_library_configurations sets breakpad_FOUND to true, but we wait for libfind_process to do this so revert this value
   select_library_configurations( Breakpad_${component} )
   set(Breakpad_${component}_FOUND FALSE)

   # Set the include dir variables and the libraries and let libfind_process do the rest.
   # NOTE: Singular variables for this library, plural for libraries this this lib depends on.
   set(Breakpad_PROCESS_INCLUDES Breakpad_${component}_INCLUDE_DIR)
   set(Breakpad_PROCESS_LIBS Breakpad_${component}_LIBRARY)
   set(Breakpad_LIBRARIES ${Breakpad_LIBRARIES} ${NATIVE_LIBRARIES})
endforeach()

libfind_process(Breakpad)
