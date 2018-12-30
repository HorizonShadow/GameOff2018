import "map.bas"

bar_mode_map = load_resource("bar_mode.map")
class MixModeMap(MapWrapper)
	var m = bar_mode_map
endclass