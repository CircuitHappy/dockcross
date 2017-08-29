
file(
  DOWNLOAD https://raw.githubusercontent.com/Kitware/CMake/master/README.rst /tmp/README.rst
  STATUS status
  )
list(GET status 0 error_code)
list(GET status 1 error_msg)
if(error_code)
  message(FATAL_ERROR "error: Failed to download  - ")
else()
  message(STATUS "CMake: HTTPS download works")
endif()

file(REMOVE /tmp/README.rst)

