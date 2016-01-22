cmake_minimum_required(VERSION 2.6)

project(json_spirit)

find_package(Boost 1.34 REQUIRED)
include_directories(${Boost_INCLUDE_DIR})

####
# Sources macro that handles both normal sources and test sources
# Test sources are detected as a result of a test prefix test_<test_name>.cpp
macro (add_sources)
    file (RELATIVE_PATH _relPath "${CMAKE_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}")
    foreach (_src ${ARGN})
        if (_relPath)
            if("${_src}" MATCHES "(test_*)")
                list (APPEND TST_SRCS "${CMAKE_CURRENT_SOURCE_DIR}/${_src}")
            else()
                list (APPEND SRCS "${CMAKE_CURRENT_SOURCE_DIR}/${_src}")
            endif()
        else()
            if("${_src}" MATCHES "(test_*)")
                list (APPEND TST_SRCS "${_src}")
            else()
                list (APPEND SRCS "${_src}")
            endif()
        endif()
    endforeach()
    if (_relPath)
        # propagate SRCS to parent directory
        set (SRCS ${SRCS} PARENT_SCOPE)
        set (TST_SRCS ${TST_SRCS} PARENT_SCOPE)
    endif()
endmacro()

include_directories(json_spirit)
add_subdirectory(json_spirit)
add_library(json_spirit STATIC ${SRCS})


install(
  FILES
  ${CMAKE_SOURCE_DIR}/json_spirit/json_spirit.h
  ${CMAKE_SOURCE_DIR}/json_spirit/json_spirit_error_position.h
  ${CMAKE_SOURCE_DIR}/json_spirit/json_spirit_reader.h
  ${CMAKE_SOURCE_DIR}/json_spirit/json_spirit_reader_template.h
  ${CMAKE_SOURCE_DIR}/json_spirit/json_spirit_stream_reader.h
  ${CMAKE_SOURCE_DIR}/json_spirit/json_spirit_utils.h
  ${CMAKE_SOURCE_DIR}/json_spirit/json_spirit_value.h
  ${CMAKE_SOURCE_DIR}/json_spirit/json_spirit_writer.h
  ${CMAKE_SOURCE_DIR}/json_spirit/json_spirit_writer_template.h
  ${CMAKE_SOURCE_DIR}/json_spirit/json_spirit_writer_options.h
  DESTINATION include)

install(
  FILES
  ${CMAKE_BINARY_DIR}/json_spirit/libjson_spirit.a
  DESTINATION lib)

include(CPack)
