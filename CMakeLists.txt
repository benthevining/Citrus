include_guard (GLOBAL)

cmake_minimum_required (VERSION 3.21 FATAL_ERROR)

project (
	Citrus
	VERSION 1.0.0
	DESCRIPTION "Workspace combining my various repos"
	HOMEPAGE_URL "www.github.com/benthevining/Citrus"
	LANGUAGES NONE)

enable_testing ()

set (ORANGES_PATH "${CMAKE_CURRENT_LIST_DIR}/Oranges")
set (LIMES_PATH "${CMAKE_CURRENT_LIST_DIR}/Limes")
set (LEMONS_PATH "${CMAKE_CURRENT_LIST_DIR}/Lemons")

add_subdirectory (Oranges)
add_subdirectory (Limes)

if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/PrivateSDKs/CMakeLists.txt")
	add_subdirectory (PrivateSDKs)
endif()

add_subdirectory (Lemons)

#

set (CITRUS_INSTALL_DEST "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
	 CACHE STRING "Directory below INSTALL_PREFIX where ${PROJECT_NAME} will be installed to")

mark_as_advanced (FORCE CITRUS_INSTALL_DEST)

write_basic_package_version_file (Citrus-config-version.cmake VERSION "${PROJECT_VERSION}"
								  COMPATIBILITY SameMajorVersion)

configure_package_config_file ("${CMAKE_CURRENT_LIST_DIR}/scripts/Citrus-config.cmake"
							   Citrus-config.cmake INSTALL_DESTINATION "${CITRUS_INSTALL_DEST}")

install (FILES "${CMAKE_CURRENT_BINARY_DIR}/Citrus-config-version.cmake"
			   "${CMAKE_CURRENT_BINARY_DIR}/Citrus-config.cmake"
		 DESTINATION "${CITRUS_INSTALL_DEST}" COMPONENT citrus_base)

cpack_add_component (citrus_base HIDDEN REQUIRED GROUP Citrus)

cpack_add_component_group (Citrus DESCRIPTION "All components of the Citrus SDK" EXPANDED
																				 BOLD_TITLE)

export (PACKAGE Citrus)
