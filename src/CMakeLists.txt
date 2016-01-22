set(JSONSpirit_SRCS
    ${CMAKE_CURRENT_SOURCE_DIR}/json_spirit_reader.cpp 
    ${CMAKE_CURRENT_SOURCE_DIR}/json_spirit_reader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/json_spirit_value.cpp 
    ${CMAKE_CURRENT_SOURCE_DIR}/json_spirit_value.h
    ${CMAKE_CURRENT_SOURCE_DIR}/json_spirit_writer.cpp 
    ${CMAKE_CURRENT_SOURCE_DIR}/json_spirit_writer.h
    ${CMAKE_CURRENT_SOURCE_DIR}/json_spirit.h
    ${CMAKE_CURRENT_SOURCE_DIR}/json_spirit_error_position.h
    ${CMAKE_CURRENT_SOURCE_DIR}/json_spirit_reader_template.h
    ${CMAKE_CURRENT_SOURCE_DIR}/json_spirit_stream_reader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/json_spirit_utils.h
    ${CMAKE_CURRENT_SOURCE_DIR}/json_spirit_writer_options.h
    ${CMAKE_CURRENT_SOURCE_DIR}/json_spirit_writer_template.h
  )

  add_library(json-spirit ${Uri_SRCS})
  target_link_libraries(json-spirit ${Boost_LIBRARIES})
  if(${CMAKE_CXX_COMPILER_ID} MATCHES Clang)
    if (NOT JSON_SPIRIT_DISABLE_LIBCXX)
      target_link_libraries(json-spirit "c++")
    endif()
  endif()
  install(
    TARGETS
    json-spirit
    DESTINATION lib
    )

  install(DIRECTORY json-spirit
    DESTINATION include
    )


set(JSONSpirit_SRCS ${JSONSpirit_SRCS} PARENT_SCOPE)
