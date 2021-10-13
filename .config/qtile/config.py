# Qtile imports
from typing import List  # noqa: F401

from libqtile import bar, layout, widget, qtile, hook
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

terminal = "alacritty"

# My modules
from keys import get_keys
from widgets import MyBattery

mod = "mod1"
groups = [Group(i) for i in "1234567890"]
# groups += [
#         ScratchPad("scratchpad", [
# 
#         ])
# 
#     ]

keys = get_keys(groups)

layouts = [
    layout.Tile(
        ratio=0.5, 
        border_width=2, 
        add_after_last=True,
        border_focus=['#d75f5f', '#8f3d3d']
        ),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Columns(border_focus_stack=['#d75f5f', '#8f3d3d'], border_width=4),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='Acme',
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

seperator = widget.Sep()
backlight = widget.Backlight(
        backlight_name="intel_backlight",
        change_command="brightnessctl s {0}",
        fmt="\uf185 {}"
        )
# TODO write my own simple volume widget
volume = widget.Volume(
        volume_app="pavucontrol",
        fmt="\uf028 {}"
        )
battery = MyBattery(
        charge_char='\uf376',
        empty_char='\uf244',
        low_char='\ue0b1',
        quarter_char='\uf243',
        half_char='\uf242',
        three_quarters_char='\uf241',
        full_char='\uf240'
        )

wifi = widget.Wlan(
        # format="{essid} {percent:2.0%}",
        update_interval = 60,
        fmt = "\uf1eb {}",
        mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn("{} -t nmtui -e nmtui".format(terminal))}
        )

clock = widget.Clock(format='%m/%d/%Y- %a %I:%M %p')

widgets = [
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                ),
                widget.CurrentLayout(),
                seperator,
                wifi,
                seperator,
                volume,
                seperator,
                backlight,
                seperator,
                battery,
                seperator,
                widget.Systray(),
                clock
        ]

screens = [
    Screen(
        top=bar.Bar(
            widgets,
            24,
        ),
        wallpaper="~/.wallpapers/wallpaper",
        wallpaper_mode="fill"
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
widget_floating_windows = [
    Match(title='nmtui'),  
    Match(wm_class='osmo'),  
]
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
] + widget_floating_windows)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True
