# Sample i3 Window Manager Config with Multiple Monitor Setup

Here's a basic configuration file for i3 window manager that includes setup for multiple monitors. This assumes you have two monitors, but can be #easily adapted for more.

```config
# ~/.config/i3/config
# i3 configuration file for multiple monitor setup

# Font for window titles
font pango:monospace 8

# Use Mouse+Mod1 (Alt) to drag floating windows
floating_modifier Mod1

# Default workspace layout (can be changed per-workspace)
workspace_layout tabbed

# Set modifier key (Windows key)
set $mod Mod4

# Basic keybindings
bindsym $mod+Return exec alacritty
bindsym $mod+d exec rofi -show drun
bindsym $mod+Shift+q kill
bindsym $mod+h split h
bindsym $mod+v split v
bindsym $mod+f fullscreen toggle
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split
bindsym $mod+Shift+c reload
bindsym $mod+Shift+r restart
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'Exit i3?' -b 'Yes' 'i3-msg exit'"

# Media keys
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle
bindsym XF86MonBrightnessUp exec xbacklight -inc 10
bindsym XF86MonBrightnessDown exec xbacklight -dec 10

# Multiple monitor setup
# Assuming one monitor is primary (e.g., laptop screen) and one is external
# Replace outputs with your actual output names (use xrandr to find them)

# Example for two monitors (HDMI-1 and eDP-1)
exec --no-startup-id xrandr --output HDMI-1 --auto --right-of eDP-1 --primary

# Alternatively, for more complex setups:
# exec --no-startup-id arandr # GUI tool to configure monitors, then save script

# Workspace assignment to monitors
workspace "1" output eDP-1
workspace "2" output eDP-1
workspace "3" output HDMI-1
workspace "4" output HDMI-1
workspace "5" output eDP-1
workspace "6" output HDMI-1

# Move workspaces between monitors
bindsym $mod+Control+Left move workspace to output left
bindsym $mod+Control+Right move workspace to output right
bindsym $mod+Control+Up move workspace to output up
bindsym $mod+Control+Down move workspace to output down

# Focus follows mouse
focus_follows_mouse no

# Gaps (if using i3-gaps)
# gaps inner 10
# gaps outer 5

# Auto-start applications
exec --no-startup-id nm-applet
exec --no-startup-id blueman-applet
exec --no-startup-id pasystray
exec --no-startup-id feh --bg-scale ~/Pictures/wallpaper.jpg

# Colorscheme
# class                 border  backgr. text    indicator child_border
client.focused          #4c7899 #285577 #ffffff #2e9ef4   #285577
client.focused_inactive #333333 #5f676a #ffffff #484e50   #5f676a
client.unfocused        #333333 #222222 #888888 #292d2e   #222222
```

## Important Notes:

1. **Monitor Identification**: First run `xrandr` in terminal to identify your monitor names (eDP-1, HDMI-1, DP-1, etc.)

2. **Workspace Assignment**: Adjust workspace numbers and monitor assignments according to your preference

3. **Display Configuration**: The `xrandr` command in the config is just an example. You might want to:
   - Run `arandr` to visually configure your displays
   - Save the configuration
   - Replace the xrandr command in the config with your saved script

4. **For Laptop Users**: You might want to add hotkeys for quickly changing monitor configurations (e.g., laptop only, external only, both)

5. **Refresh Rate**: If you have high refresh rate monitors, you may need to add rate parameters to xrandr commands

Would you like me to provide any specific additions or modifications to this configuration?