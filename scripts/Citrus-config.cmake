include_guard (GLOBAL)

cmake_minimum_required (VERSION 3.21 FATAL_ERROR)

@PACKAGE_INIT@

include (CMakeFindDependencyMacro)

set (citrus_components Limes Oranges)

if(NOT ${CMAKE_FIND_PACKAGE_NAME}_FIND_COMPONENTS)
	set (finding_components ${citrus_components})
elseif(All IN_LIST ${CMAKE_FIND_PACKAGE_NAME}_FIND_COMPONENTS)
	set (finding_components ${citrus_components})
else()
	set (finding_components ${${CMAKE_FIND_PACKAGE_NAME}_FIND_COMPONENTS})

	foreach(comp_name IN LISTS finding_components)
		if(NOT "${comp_name}" IN_LIST citrus_components)
			if(NOT ${CMAKE_FIND_PACKAGE_NAME}_QUIETLY)
				message (WARNING " -- Citrus: unknown component ${comp_name} requested!")
			endif()

			set (${CMAKE_FIND_PACKAGE_NAME}_${comp_name}_FOUND FALSE)
			list (REMOVE_ITEM finding_components "${comp_name}")
		endif()
	endforeach()
endif()

foreach(comp_name IN LISTS finding_components)
	find_dependency ("${comp_name}")
	set (${CMAKE_FIND_PACKAGE_NAME}_${comp_name}_FOUND "${${comp_name}_FOUND}")
endforeach()

foreach(comp_name IN LISTS citrus_components)
	if(NOT ${CMAKE_FIND_PACKAGE_NAME}_${comp_name}_FOUND)
		set (${CMAKE_FIND_PACKAGE_NAME}_All_FOUND FALSE)
		break ()
	endif()
endforeach()

set (${CMAKE_FIND_PACKAGE_NAME}_FOUND TRUE)

check_required_components ("${CMAKE_FIND_PACKAGE_NAME}")
