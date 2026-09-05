hl.bind(
	"CTRL + SUPER + Slash",
	hl.dsp.exec_cmd("xdg-open ~/.config/illogical-impulse/config.json"),
	{ description = "Edit shell config" }
)
hl.bind(
	"CTRL + SUPER + ALT + Slash",
	hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.conf"),
	{ description = "Edit extra keybinds" }
)

hl.unbind("SUPER + B")
hl.unbind("SUPER + W")
hl.unbind("CTRL + SUPER + T")
hl.unbind("SUPER + C")
hl.unbind("CTRL + SHIFT + Escape")
hl.unbind("SUPER + Q")
hl.bind("SUPER + B", hl.dsp.exec_cmd(browser), { description = "Browser" })
hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd(taskManager), { description = "Task manager" })
hl.bind("SUPER + C", hl.dsp.exec_cmd(codeEditor))

hl.bind(
	"CTRL + SUPER + W",
	hl.dsp.global("quickshell:wallpaperSelectorToggle"),
	{ description = "Toggle wallpaper selector" }
)
hl.bind("SUPER + F4", hl.dsp.global("quickshell:sessionToggle"), { description = "Shell: Toggle session menu" })
hl.bind(
	"CTRL + SUPER + ALT + W",
	hl.dsp.global("quickshell:wallpaperSelectorRandom"),
	{ description = "Select random wallpaper" }
)
hl.bind(
	"CTRL + SUPER + W",
	hl.dsp.exec_cmd(
		"qs -c $qsConfig ipc call TEST_ALIVE || ~/.config/quickshell/$qsConfig/scripts/colors/switchwall.sh"
	),
	{ description = "Change wallpaper" }
)

hl.bind("ALT + F4", hl.dsp.window.close(), { description = "Close active window" })
hl.bind("ALT + SHIFT + F4", hl.dsp.exec_cmd("hyprctl kill"), { description = "Force kill" })
hl.bind("SUPER + SHIFT + F", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle float" })

hl.bind("CTRL + SUPER + SHIFT + Left", hl.dsp.layout("splitratio -0.1"), { repeating = true })
hl.bind("CTRL + SUPER + SHIFT + Right", hl.dsp.layout("splitratio +0.1"), { repeating = true })

hl.bind("ALT + Tab", hl.dsp.window.cycle_next(), { description = "Cycle next" })
hl.bind("ALT + Tab", hl.dsp.window.bring_to_top(), { description = "Bring to top" })

--#/# bind = SUPER+ALT, Hash,, -- Send to workspace -- (1, 2, 3,...)
for i = 1, 10 do
	hl.bind("SUPER + SHIFT + " .. (i % 10), function()
		hl.dispatch(hl.dsp.window.move({ workspace = workspace_in_group(i) }))
	end, { description = "Window: Send to workspace " .. i })
end

hl.bind("SUPER + Space", hl.dsp.no_op())
