create_pblock pblock_conv
add_cells_to_pblock [get_pblocks pblock_conv] [get_cells -quiet [list system_i/imageProcess_0/inst/conv]]
resize_pblock [get_pblocks pblock_conv] -add {SLICE_X28Y50:SLICE_X45Y99}
resize_pblock [get_pblocks pblock_conv] -add {DSP48_X2Y20:DSP48_X2Y39}
resize_pblock [get_pblocks pblock_conv] -add {RAMB18_X2Y20:RAMB18_X2Y39}
resize_pblock [get_pblocks pblock_conv] -add {RAMB36_X2Y10:RAMB36_X2Y19}
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_conv]
set_property SNAPPING_MODE ON [get_pblocks pblock_conv]
set_property HD.RECONFIGURABLE true [get_cells system_i/imageProcess_0/inst/conv]
