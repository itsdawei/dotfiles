"""Provides the Qtile configurations."""

# pylint: disable=invalid-name, import-error, missing-function-docstring

import os
import subprocess
from datetime import datetime, timedelta

from libqtile import bar, hook, layout, qtile, widget
from libqtile.config import (Click, Drag, DropDown, Group, Key, Match,
                             ScratchPad, Screen)
from libqtile.dgroups import simple_key_binder
from libqtile.lazy import lazy

mod = "mod4"
terminal = "kitty"
browser = "firefox"

today = datetime.now().strftime("%d")
tomorrow = (datetime.now() + timedelta(1)).strftime("%d")

keys = [
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch Terminal"),
    Key(
        [mod, "shift"],
        "Return",
        lazy.spawn("dm-run"),
        desc="Run Launcher",
    ),
    Key(
        [mod],
        "b",
        lazy.spawn(browser),
        desc="Firefox",
    ),
    Key(
        [mod],
        "Tab",
        lazy.next_layout(),
        desc="Toggle through layouts",
    ),
    Key(
        [mod, "shift"],
        "c",
        lazy.window.kill(),
        desc="Kill active window",
    ),
    Key(
        [mod, "shift"],
        "r",
        lazy.restart(),
        desc="Restart Qtile",
    ),
    Key(
        [mod, "shift"],
        "q",
        lazy.shutdown(),
        desc="Shutdown Qtile",
    ),
    # Switch focus of monitors
    Key(
        [mod],
        "period",
        lazy.next_screen(),
        desc="Move focus to next monitor",
    ),
    # Window controls
    Key([mod],
        "j",
        lazy.layout.down(),
        desc="Move focus down in current stack pane"),
    Key([mod],
        "k",
        lazy.layout.up(),
        desc="Move focus up in current stack pane"),
    Key([mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        lazy.layout.section_down(),
        desc="Move windows down in current stack"),
    Key([mod, "shift"],
        "k",
        lazy.layout.shuffle_up(),
        lazy.layout.section_up(),
        desc="Move windows up in current stack"),
    Key([mod],
        "h",
        lazy.layout.shrink(),
        lazy.layout.decrease_nmaster(),
        desc="Shrink window (MonadTall), decrease number in master pane (Tile)"
        ),
    Key([mod],
        "l",
        lazy.layout.grow(),
        lazy.layout.increase_nmaster(),
        desc="Expand window (MonadTall), increase number in master pane (Tile)"
        ),
    Key([mod],
        "n",
        lazy.layout.normalize(),
        desc="normalize window size ratios"),
    Key([mod],
        "m",
        lazy.layout.maximize(),
        desc="toggle window between minimum and maximum sizes"),
    Key([mod, "shift"],
        "f",
        lazy.window.toggle_floating(),
        desc="toggle floating"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="toggle fullscreen"),
    # Stack controls
    Key([mod, "shift"],
        "Tab",
        lazy.layout.rotate(),
        lazy.layout.flip(),
        desc="Switch which side main pane occupies (XmonadTall)"),
    Key([mod],
        "space",
        lazy.layout.next(),
        desc="Switch window focus to other pane(s) of stack"),
    Key([mod, "shift"],
        "space",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),

    # Dmenu scripts launched using the key chord SUPER+p followed by "key"
    # KeyChord([mod], "p", [
    #     Key([], "h", lazy.spawn("dm-hub"), desc="List all dmscripts"),
    #     Key([], "a", lazy.spawn("dm-sounds"), desc="Choose ambient sound"),
    #     Key([], "b", lazy.spawn("dm-setbg"), desc="Set background"),
    #     Key([],
    #         "c",
    #         lazy.spawn("dtos-colorscheme"),
    #         desc="Choose color scheme"),
    #     Key([],
    #         "e",
    #         lazy.spawn("dm-confedit"),
    #         desc="Choose a config file to edit"),
    #     Key([], "i", lazy.spawn("dm-maim"), desc="Take a screenshot"),
    #     Key([], "k", lazy.spawn("dm-kill"), desc="Kill processes "),
    #     Key([], "m", lazy.spawn("dm-man"), desc="View manpages"),
    #     Key([], "n", lazy.spawn("dm-note"), desc="Store and copy notes"),
    #     Key([], "o", lazy.spawn("dm-bookman"), desc="Browser bookmarks"),
    #     Key([], "p", lazy.spawn("passmenu -p \"Pass: \""), desc="Logout menu"),
    #     Key([], "q", lazy.spawn("dm-logout"), desc="Logout menu"),
    #     Key([], "r", lazy.spawn("dm-radio"), desc="Listen to online radio"),
    #     Key([], "s", lazy.spawn("dm-websearch"),
    #         desc="Search various engines"),
    #     Key([], "t", lazy.spawn("dm-translate"), desc="Translate text"),
    # ]),
    # Function keys
    Key([],
        "XF86MonBrightnessUp",
        lazy.spawn("light -A 5"),
        desc="Increase brightness"),
    Key([],
        "XF86MonBrightnessDown",
        lazy.spawn("light -U 5"),
        desc="Increase brightness"),
    Key([],
        "XF86AudioMute",
        lazy.spawn("amixer set Master toggle"),
        desc="Toggle mute"),
    Key([],
        "XF86AudioLowerVolume",
        lazy.spawn("amixer set Master 5%- unmute"),
        desc="Lower volume"),
    Key([],
        "XF86AudioRaiseVolume",
        lazy.spawn("amixer set Master 5%+ unmute"),
        desc="Raise volume"),
]

groups = [
    Group("DEV1", layout="monadtall"),
    Group("DEV2", layout="monadtall"),
    Group("WEB", layout="monadtall"),
    Group("NOTE", layout="monadtall", matches=[Match(wm_class="notion-app")]),
    Group("READ", layout="monadtall"),
    Group("COM", layout="monadtall", matches=[Match(wm_class="mailspring")]),
]

# Allow MODKEY+[0 through 9] to bind to groups, see
# https://docs.qtile.org/en/stable/manual/config/groups.html
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group
dgroups_key_binder = simple_key_binder("mod4")

# Define scratchpads
groups.append(
    ScratchPad("scratchpad", [
        DropDown(
            "agenda",
            "firefox -new-instance 'https://track.toggl.com/timer' -P 'scratchpad'",
            width=0.8,
            height=0.8,
            x=0.1,
            y=0.1,
            opacity=1,
            on_focus_lost_hide=False,
        ),
        DropDown("term",
                 "kitty --class=scratch",
                 width=0.7,
                 height=0.7,
                 x=0.15,
                 y=0.15,
                 opacity=1),
        DropDown("ranger",
                 "kitty --class=ranger -e ranger",
                 width=0.7,
                 height=0.7,
                 x=0.15,
                 y=0.15,
                 opacity=0.9),
        DropDown("volume",
                 "pavucontrol",
                 width=0.7,
                 height=0.7,
                 x=0.15,
                 y=0.15,
                 opacity=0.9),
        DropDown(
            "org",
            "kitty --class=org -e nvim /home/dawei/Documents/org/todo.org",
            width=0.5,
            height=0.7,
            x=0.25,
            y=0.15,
            opacity=1,
            on_focus_lost_hide=False,
        ),
    ]))

# Scratchpad keybindings
keys.extend([
    Key([mod], "t", lazy.group["scratchpad"].dropdown_toggle("term")),
    Key([mod], "r", lazy.group["scratchpad"].dropdown_toggle("ranger")),
    Key([mod], "v", lazy.group["scratchpad"].dropdown_toggle("volume")),
    Key([mod], "o", lazy.group["scratchpad"].dropdown_toggle("org")),
    Key([mod], "a", lazy.group["scratchpad"].dropdown_toggle("agenda")),
])

layout_theme = {
    "border_width": 5,
    "margin": 10,
    "border_focus": "e1acff",
    "border_normal": "1D2330",
}

layouts = [
    layout.MonadWide(**layout_theme),
    # layout.Bsp(**layout_theme),
    # layout.Stack(stacks=2, **layout_theme),
    # layout.Columns(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.Tile(shift_windows=True, **layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.Matrix(**layout_theme),
    # layout.Zoomy(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    # layout.Stack(num_stacks=2),
    # layout.RatioTile(**layout_theme),
    layout.TreeTab(font="Ubuntu",
                   fontsize=10,
                   sections=["FIRST", "SECOND", "THIRD", "FOURTH"],
                   section_fontsize=10,
                   border_width=2,
                   bg_color="1c1f24",
                   active_bg="c678dd",
                   active_fg="000000",
                   inactive_bg="a9a1e1",
                   inactive_fg="1c1f24",
                   padding_left=5,
                   padding_x=5,
                   padding_y=5,
                   section_top=10,
                   section_bottom=20,
                   level_shift=8,
                   vspace=3,
                   panel_width=200),
    # layout.Floating(**layout_theme)
]

# gruvbox-material
colors = [
    ["#252423", "#252423"],  # bg_dim
    ["#3c3836", "#3c3836"],  # bg1
    ["#d4be98", "#d4be98"],  # fg0
    ["#ea6962", "#ea6962"],  # red
    ["#e78a4e", "#e78a4e"],  # orange
    ["#d8a657", "#d8a657"],  # yellow
    ["#a9b665", "#a9b665"],  # green
    ["#89b482", "#89b482"],  # aqua
    ["#7daea3", "#7daea3"],  # blue
    ["#d3869b", "#d3869b"],  # purple
]

##### DEFAULT WIDGET SETTINGS #####
widget_defaults = {
    "font": "SourceCodePro",
    "fontsize": 12,
    "padding": 2,
    "background": colors[0],
}
extension_defaults = widget_defaults.copy()


def init_widgets_list():
    return [
        widget.Spacer(length=6),
        widget.Image(
            filename="~/.config/qtile/icons/python-white.png",
            scale="False",
            mouse_callbacks={"Button1": lambda: qtile.cmd_spawn(terminal)}),
        widget.Spacer(length=6),
        widget.GroupBox(
            foreground=colors[1],
            padding_y=5,
            padding_x=3,
            margin_y=3,
            margin_x=0,
            borderwidth=3,
            active=colors[2],
            inactive=colors[7],
            rounded=False,
            highlight_color=colors[1],
            highlight_method="line",
            this_current_screen_border=colors[6],
            this_screen_border=colors[4],
            other_current_screen_border=colors[6],
            other_screen_border=colors[4],
        ),
        widget.Sep(
            linewidth=1,
            padding=10,
            foreground="474747",
        ),
        widget.CurrentLayoutIcon(
            custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
            padding=0,
            scale=0.75),
        widget.CurrentLayout(foreground=colors[2], padding=5),
        widget.Sep(
            linewidth=1,
            padding=10,
            foreground="474747",
        ),
        widget.TaskList(
            icon_size=15,
            foreground=colors[6],
            borderwidth=1,
            border=colors[6],
            margin=2,
            title_width_method="uniform",
            txt_floating="🗗 ",
            txt_maximized="🗖 ",
            txt_minimized="🗕 ",
        ),
        widget.Sep(
            linewidth=1,
            padding=10,
            foreground="474747",
        ),
        widget.Systray(icon_size=12),
        widget.Sep(
            linewidth=1,
            padding=10,
            foreground="474747",
        ),
        widget.Battery(
            foreground=colors[5],
            padding=5,
            format="{char} {percent:2.0%}",
        ),
        widget.Spacer(length=6),
        widget.ThermalSensor(
            foreground=colors[6],
            padding=5,
            threshold=90,
        ),
        widget.Spacer(length=6),
        widget.CPU(foreground=colors[4],
                   update_interval=1.0,
                   format=" {load_percent}%",
                   padding=5),
        widget.Spacer(length=6),
        widget.Memory(
            foreground=colors[7],
            padding=5,
            format="{MemUsed:.0f}{mm}/{MemTotal:.0f}{mm}",
            measure_mem="M",
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn(terminal + " -e htop")
            },
        ),
        widget.Spacer(length=6),
        widget.Volume(
            foreground=colors[8],
            padding=5,
            fmt="Vol {}",
            mouse_callbacks={
                'Button3': lambda: qtile.cmd_spawn("pavucontrol")
            },
        ),
        widget.Spacer(length=6),
        widget.Clock(
            foreground=colors[9],
            format="%A, %B %d - %H:%M ",
        ),
    ]


def init_widgets_screen1():
    """Main monitor (1) displays all widgets."""
    return init_widgets_list()


def init_widgets_screen2():
    """Secondary monitor (2) excludes Systray widget."""
    widgets = init_widgets_list()
    return widgets[:9] + widgets[11:]


if __name__ in ["config", "__main__"]:
    # margin=[N E S W]
    screens = [
        Screen(top=bar.Bar(
            widgets=init_widgets_screen1(), size=22, margin=[8, 8, 0, 8])),
        Screen(top=bar.Bar(
            widgets=init_widgets_screen2(), size=22, margin=[8, 8, 0, 8])),
    ]
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()


def window_to_prev_group(qtile):  # pylint: disable=redefined-outer-name
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


def window_to_next_group(qtile):  # pylint: disable=redefined-outer-name
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


def window_to_previous_screen(qtile):  # pylint: disable=redefined-outer-name
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)


def window_to_next_screen(qtile):  # pylint: disable=redefined-outer-name
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)


def switch_screens(qtile):  # pylint: disable=redefined-outer-name
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)


mouse = [
    Drag([mod],
         "Button1",
         lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod],
         "Button3",
         lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = True

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # default_float_rules include: utility, notification, toolbar, splash, dialog,
    # file_progress, confirm, download and error.
    *layout.Floating.default_float_rules,
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True


@hook.subscribe.startup_once
def start_once():
    """Startup hook."""
    subprocess.call([os.path.expanduser("~") + "/.config/qtile/autostart.sh"])
