# Make sure we're using correct version of CMake
cmake_minimum_required(VERSION 3.5)
include (CheckCXXCompilerFlag)

set(library_name "json_spirit")
set(interface_name "${library_name}")
set(alias_name "json_spirit::${library_name}")

project("${interface_name}" CXX)


#
# c++ version
#

if (NOT CMAKE_CXX_STANDARD)
    set (CMAKE_REQUIRED_QUIET FALSE)
    
    CHECK_CXX_COMPILER_FLAG(-std=c++17 supports17)
    CHECK_CXX_COMPILER_FLAG(-std=c++14 supports14)
    CHECK_CXX_COMPILER_FLAG(-std=c++11 supports11)
    if (supports17)
        set (CMAKE_CXX_STANDARD "14")
    elseif (supports14)
        set (CMAKE_CXX_STANDARD "14")
    elseif (supports11)
        set (CMAKE_CXX_STANDARD "11")
    else ()
        message (FATAL_ERROR "here's a nickel kid, go buy yourself a better compiler")
    endif ()
    set_property (GLOBAL PROPERTY CXX_STANDARD ${CMAKE_CXX_STANDARD})
    set (CMAKE_CXX_STANDARD ${CMAKE_CXX_STANDARD} CACHE STRING "best complete standard supported by the compiler")
endif ()



#-----------------
# BOOST
SET(ENV_BOOST $ENV{BOOST_ROOT})
IF(NOT BOOST_ROOT AND ENV_BOOST)
  SET(BOOST_ROOT ${ENV_BOOST})
ENDIF(NOT BOOST_ROOT AND ENV_BOOST)

IF(NOT BOOST_ROOT AND WIN32)
  SET(BOOST_ROOT "C:/Program Files/Boost")
ENDIF(NOT BOOST_ROOT AND WIN32)

# Prefer static linking in all cases
SET(Boost_NO_BOOST_CMAKE ON CACHE BOOL "Enable fix for FindBoost.cmake")
SET(JSONSPIRIT_BOOST_COMPONENTS thread date_time)
SET(Boost_USE_STATIC_LIBS TRUE)
#FIND_PACKAGE(Boost COMPONENTS ${JSONSPIRIT_BOOST_COMPONENTS})
FIND_PACKAGE(Boost)
IF(NOT Boost_FOUND)
  # Try dynamic
  SET(Boost_USE_STATIC_LIBS FALSE)
  FIND_PACKAGE(Boost COMPONENTS ${JSONSPIRIT_BOOST_COMPONENTS})
  IF(NOT Boost_FOUND)
    MESSAGE(FATAL_ERROR "Boost or some of its libraries found. If not in standard place please set -DBOOST_ROOT:STRING=")
  ENDIF(NOT Boost_FOUND)
ENDIF(NOT Boost_FOUND)

#
SET(JSONSPIRIT_BOOST_INCLUDE_DIRS ${Boost_INCLUDE_DIRS})
SET(JSONSPIRIT_BOOST_SYSTEM_LIBS ${Boost_SYSTEM_LIBRARY})
SET(JSONSPIRIT_BOOST_THREAD_LIBS ${Boost_THREAD_LIBRARY})
SET(JSONSPIRIT_BOOST_LIBRARY_DIRS ${Boost_LIBRARY_DIRS})

INCLUDE_DIRECTORIES(${JSONSPIRIT_BOOST_INCLUDE_DIRS})

add_subdirectory(src)

