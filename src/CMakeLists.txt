include(sugar_include)
sugar_include("./") # JSON_SPIRIT_SOURCES

if(JSON_SPIRIT_BUILD_SHARED_LIBS OR BUILD_SHARED_LIBS)
  set(JSON_SPIRIT_TYPE SHARED)
  set(Boost_USE_STATIC_LIBS OFF)
else()
  set(JSON_SPIRIT_TYPE STATIC)
  set(Boost_USE_STATIC_LIBS ON)
endif()
set(Boost_USE_MULTITHREADED ON)

# Install config
set(LIB_DEST lib)
set(INCL_DEST include)
set(CONF_DEST lib/cmake/JSONSpirit)

set(json_spirit_config "${CMAKE_CURRENT_BINARY_DIR}/JSONSpiritConfig.cmake")

include(CMakePackageConfigHelpers)

configure_package_config_file(
    "JSONSpiritConfig.cmake.in"
    "${json_spirit_config}"
    INSTALL_DESTINATION ${CONF_DEST}
    PATH_VARS CONF_DEST
)

find_package(Boost 1.59 REQUIRED system filesystem)

add_library(json_spirit ${JSON_SPIRIT_TYPE} ${JSON_SPIRIT_SOURCES})
target_include_directories(
    json_spirit
    PUBLIC
    "$<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}>"
    "$<INSTALL_INTERFACE:${INCL_DEST}>"
)
target_include_directories(json_spirit SYSTEM PUBLIC ${Boost_INCLUDE_DIR})
target_link_libraries(json_spirit PUBLIC ${Boost_LIBRARIES})

if(MSVC)
  target_compile_definitions(json_spirit PUBLIC BOOST_ALL_NO_LIB=1)
endif()

if(MSVC)
  target_compile_definitions(
      json_spirit
      PUBLIC
      -D_SCL_SECURE_NO_WARNINGS -D_VARIADIC_MAX=10
  )
endif()

if(WIN32)
  target_compile_definitions(
      json_spirit
      PUBLIC
      -D_WIN32_WINNT=0x0501
  )
endif()

set(IFACE_FILES
    json_spirit_reader.h
    json_spirit_value.h
    json_spirit_writer.h
    json_spirit.h
    json_spirit_error_position.h
    json_spirit_reader_template.h
    json_spirit_stream_reader.h
    json_spirit_utils.h
    json_spirit_writer_options.h
    json_spirit_writer_template.h
)

install(TARGETS json_spirit DESTINATION ${LIB_DEST} EXPORT JSONSpiritTargets)
install(FILES ${IFACE_FILES} DESTINATION ${INCL_DEST})
install(EXPORT JSONSpiritTargets DESTINATION ${CONF_DEST})
install(FILES "${json_spirit_config}" DESTINATION ${CONF_DEST})

