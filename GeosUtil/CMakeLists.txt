add_library(JulDay STATIC EXCLUDE_FROM_ALL
	julday_mod.F90
)
target_link_libraries(JulDay
	PUBLIC Headers
)

add_library(GeosUtil STATIC EXCLUDE_FROM_ALL
	error_mod.F90
	file_mod.F90
	gc_grid_mod.F90
	grid_registry_mod.F90
        henry_mod.F90
	ifort_errmsg.F90
	pressure_mod.F90
	print_mod.F90
	regrid_a2a_mod.F90
	time_mod.F90
	timers_mod.F90
	transfer_mod.F90
	unitconv_mod.F90
)
target_link_libraries(GeosUtil
	PUBLIC NcdfUtil
)

