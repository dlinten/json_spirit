# This file generated automatically by:
#   generate_sugar_files.py
# see wiki for more info:
#   https://github.com/ruslo/sugar/wiki/Collecting-sources

if(DEFINED JSON_SPIRIT_SRC_SUGAR_CMAKE_)
  return()
else()
  set(JSON_SPIRIT_SRC_SUGAR_CMAKE_ 1)
endif()

include(sugar_files)
include(sugar_include)

sugar_files(
    JSON_SPIRIT_SOURCES
    json_spirit_reader.cpp 
    json_spirit_reader.h
    json_spirit_value.cpp 
    json_spirit_value.h
    json_spirit_writer.cpp 
    json_spirit_writer.h
    json_spirit.h
    json_spirit_error_position.h
    json_spirit_reader_template.h
    json_spirit_stream_reader.h
    json_spirit_utils.h
    json_spirit_writer_options.h
    json_spirit_writer_template.h
)
