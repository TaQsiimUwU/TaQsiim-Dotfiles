hl.gesture({
	fingers = 4,
	direction = "swipe",
	action = "move",
})
hl.gesture({
	fingers = 3,
	direction = "pinch",
	action = "float",
})
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
hl.gesture({
	fingers = 3,
	direction = "down",
	action = function()
		hl.dispatch(hl.dsp.global("quickshell:overviewWorkspacesToggle"))
	end,
})
hl.gesture({
	fingers = 3,
	direction = "up",
	action = function()
		hl.dispatch(hl.dsp.global("quickshell:overviewWorkspacesClose"))
	end,
})

hl.config({
	gestures = {
		workspace_swipe_distance = 10,
		workspace_swipe_cancel_ratio = 0.2,
		workspace_swipe_min_speed_to_force = 3,
		workspace_swipe_direction_lock = true,
		workspace_swipe_direction_lock_threshold = 10,
		workspace_swipe_create_new = true,
	},
	input = {
		kb_layout = "us,ara",
		kb_options = "grp:win_space_toggle",
		numlock_by_default = true,
		repeat_delay = 250,
		repeat_rate = 35,
		force_no_accel = true,
		follow_mouse = 1,
		sensitivity = -1,
		touchpad = {
			natural_scroll = true,
			disable_while_typing = true,
			clickfinger_behavior = true,
			scroll_factor = 1,
		},
	},
})
