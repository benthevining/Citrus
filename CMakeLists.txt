include_guard (GLOBAL)

cmake_minimum_required (VERSION 3.21 FATAL_ERROR)

project (
	Citrus
	VERSION 1.0.0
	DESCRIPTION "Workspace combining my various repos"
	HOMEPAGE_URL "www.github.com/benthevining/Citrus"
	LANGUAGES CXX)

enable_testing ()

add_subdirectory (Oranges)
add_subdirectory (Limes)
