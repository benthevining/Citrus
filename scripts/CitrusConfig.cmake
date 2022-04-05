include_guard (GLOBAL)

cmake_minimum_required (VERSION 3.21 FATAL_ERROR)

@PACKAGE_INIT@

include (CMakeFindDependencyMacro)

if(NOT Citrus_FIND_COMPONENTS)
	set (Citrus_FIND_COMPONENTS Limes Oranges)
elseif(All IN_LIST Citrus_FIND_COMPONENTS)
	set (Citrus_FIND_COMPONENTS Limes Oranges)
endif()

if(Oranges IN_LIST Citrus_FIND_COMPONENTS)
	find_dependency (Oranges)
endif()

if(Limes IN_LIST Citrus_FIND_COMPONENTS)
	find_dependency (Limes)
endif()

set (Citrus_INCLUDED TRUE)

check_required_components ("@PROJECT_NAME@")
