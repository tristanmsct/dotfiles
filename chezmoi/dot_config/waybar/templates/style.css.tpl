/*
 * __        __          _                  ____  _         _
 * \ \      / /_ _ _   _| |__   __ _ _ __  / ___|| |_ _   _| | ___
 *  \ \ /\ / / _` | | | | '_ \ / _` | '__| \___ \| __| | | | |/ _ \
 *   \ V  V / (_| | |_| | |_) | (_| | |     ___) | |_| |_| | |  __/
 *    \_/\_/ \__,_|\__, |_.__/ \__,_|_|    |____/ \__|\__, |_|\___|
 *                 |___/                              |___/
 *
 * ----------------------------------------------------------------------------------------------------------------------------------------
 */


/*
 *   ____      _
 *  / ___|___ | | ___  _ __ ___
 * | |   / _ \| |/ _ \| '__/ __|
 * | |__| (_) | | (_) | |  \__ \
 *  \____\___/|_|\___/|_|  |___/
 *
 * --------------------------------------------------------------------------------------
 */

@import '../../.cache/wal/colors-waybar.css';

/* waybar area/group colors*/
@define-color segment-dark rgba(0, 0, 0, 0.7);
@define-color segment-light rgba(0, 0, 0, 0.4);

@define-color bg-border @segment-light;
@define-color bg-border-dark @segment-dark;
@define-color border-overlay rgba(0, 0, 0, 0.5);

@define-color bg-apps @segment-dark;
@define-color bg-quicklinks @segment-light;
@define-color bg-workspaces @segment-dark;
@define-color bg-taskbar @segment-light;
@define-color bg-center @segment-dark;
@define-color bg-misc @segment-light;
@define-color bg-devices @segment-dark;
@define-color bg-system @segment-light;

/* workspace text colors */
@define-color workspace_fg @foreground;
@define-color act_wrk_fg rgba(0, 0, 0, 1);
@define-color use_wrk_fg @color5;
@define-color txt-clock @foreground;
@define-color accent-color <MAIN COLOR>;

/* workspace button-background colors */
@define-color workspace_bg rgba(0, 0, 0, 0.6);
@define-color act_wrk_bg @foreground;

/* taskbar button-background colors */
@define-color taskbar_bg rgba(255, 255, 255, 0.2);

/* updates-widget icon+text colors */
@define-color updates_green #a3be8c;
@define-color updates_yellow #ff9a3c;
@define-color updates_red #dc2f2f;

/*
 *   ____                           _
 *  / ___| ___ _ __   ___ _ __ __ _| |
 * | |  _ / _ \ '_ \ / _ \ '__/ _` | |
 * | |_| |  __/ | | |  __/ | | (_| | |
 *  \____|\___|_| |_|\___|_|  \__,_|_|
 *
 * --------------------------------------------------------------------------------------
 */

* {
    font-family: "MesloLGS NF";
    font-weight: bold;
    font-size: 16px;
    min-height: 20px;
}

window#waybar {
    background: rgba(0, 0, 0, 0);
    color: <TEXT COLOR>;
}

tooltip {
    background: @segment-dark;
    color: @foreground;
    font-size: 14px;
    border-radius: 7px;
    border-width: 0px;
}

/* Paddings between sections */
#apps-quicklinks-padding, #quicklinks-workspaces-padding, #workspaces-taskbar-padding, #misc-devices-padding, #devices-system-padding,
/* Padding at the end of segments */
#r-taskbar, #l-misc, #l-clock, #r-clock {
    background: transparent;
    min-height: 0px;
}

/* inactiv widget modules */
#cpu, #memory, #mpris, #custom-spotify, #custom-mode, #custom-gpuinfo, #custom-ddcutil,
/* group "system" widgets */
#custom-updates, #custom-power, #custom-copyq, #custom-mako,
/* group "devices" widgets */
#bluetooth, #pulseaudio, #wireplumber, #network, #custom-ddc_brightness, #custom-screenrecorder,
/* group "misc" widgets */
#custom-screenrecorder, #custom-misc, #idle_inhibitor,
/* group "quicklinks" widgets */
#custom-filemanager, #custom-browser, #custom-terminal, #custom-editor, #custom-obsidian,
/* groups + custom-appmenu */
#custom-appmenu, #quicklinks, #window, #misc, #devices, #devices-secondary, #system, #system-secondary {
    padding: 0px 10px;
}

/*
 *     _                  __  __
 *    / \   _ __  _ __   |  \/  | ___ _ __  _   _
 *   / _ \ | '_ \| '_ \  | |\/| |/ _ \ '_ \| | | |
 *  / ___ \| |_) | |_) | | |  | |  __/ | | | |_| |
 * /_/   \_\ .__/| .__/  |_|  |_|\___|_| |_|\__,_|
 *         |_|   |_|
 *
 * --------------------------------------------------------------------------------------
 */

#custom-appmenu {
    background: @bg-apps;
    margin-right: 0;
    padding-bottom: 2px;
}

#custom-appmenu:hover {
    color: @accent-color;
    padding-bottom: 0;
    border-bottom: 2px solid @accent-color;
    transition: ease-in-out 0.2s;
}

#apps-quicklinks-padding {
    border-left: 18px solid @border-overlay;
    border-bottom: 35px solid transparent;
    background-color: @bg-border;
}

/*
 *   ___        _      _    _ _       _
 *  / _ \ _   _(_) ___| | _| (_)_ __ | | _____
 * | | | | | | | |/ __| |/ / | | '_ \| |/ / __|
 * | |_| | |_| | | (__|   <| | | | | |   <\__ \
 *  \__\_\\__,_|_|\___|_|\_\_|_|_| |_|_|\_\___/
 *
 * --------------------------------------------------------------------------------------
 */

#quicklinks {
    background: @bg-quicklinks;
}

#custom-filemanager, #custom-browser, #custom-terminal, #custom-editor, #custom-typora {
    padding-bottom: 2px;
}

#custom-filemanager:hover, #custom-browser:hover, #custom-terminal:hover, #custom-editor:hover, #custom-typora:hover {
    color: @accent-color;
    padding-bottom: 0;
    border-bottom: 2px solid @accent-color;
    transition: ease-in-out 0.2s;
}

#quicklinks-workspaces-padding {
    border-right: 18px solid @border-overlay;
    border-top: 35px solid transparent;
    background-color: @bg-border;
}

/*
 * __        __         _
 * \ \      / /__  _ __| | _____ _ __   __ _  ___ ___  ___
 *  \ \ /\ / / _ \| '__| |/ / __| '_ \ / _` |/ __/ _ \/ __|
 *   \ V  V / (_) | |  |   <\__ \ |_) | (_| | (_|  __/\__ \
 *    \_/\_/ \___/|_|  |_|\_\___/ .__/ \__,_|\___\___||___/
 *                              |_|
 *
 * --------------------------------------------------------------------------------------
 */

#workspaces {
    background: @bg-workspaces;
    padding: 4px 10px;
}

/* ALL workspace buttons (Focused + Unfocused) */
#workspaces button:hover {
    background-color: rgba(200, 255, 200, 0.2);
}

/* Only focused workspace*/
#workspaces button.active {
    color: @act_wrk_fg;
    background: @accent-color;
    border: none;
    padding: 1px 2px;
    margin: 1px 4px;
    transition: all 0.3s ease-in-out;
}

/* Unfocused workspace WITH opened Apps
   !!! Border style is valid for ALL buttons,
   Set seperate border style for every button. */
#workspaces button {
    color: @workspace_fg;
    background: @workspace_bg;
    padding: 1px 2px;
    margin: 1px 4px;
    transition: all 0.3s ease-in-out;
}

#workspaces button:not(.empty):not(.active) {
    color: @accent-color;
    padding: 1px 2px;
    margin: 1px 4px;
}

#workspaces-taskbar-padding {
    border-left: 18px solid @border-overlay;
    border-bottom: 35px solid transparent;
    background-color: @bg-border;
}

/*
    OTHER POSSIBLE DESIGN-ATTRIBUTES:
    #workspaces button.empty
    #workspaces button.persistent
    #workspaces button:not(.persistent)
    #workspaces button:not(.active) usw.
*/

/*
 *  _____         _    _
 * |_   _|_ _ ___| | _| |__   __ _ _ __
 *   | |/ _` / __| |/ / '_ \ / _` | '__|
 *   | | (_| \__ \   <| |_) | (_| | |
 *   |_|\__,_|___/_|\_\_.__/ \__,_|_|
 *
 * --------------------------------------------------------------------------------------
 */

#taskbar {
    background-color: @bg-taskbar;
    padding: 4px 10px;
}

#taskbar button {
    padding: 1px 4px;
    margin: 0px 4px;
    border-width: 0;
}

#taskbar button.active {
    background: @taskbar_bg;
    border-radius: 5px;
    transition: all 0.3s ease-in-out;
}

#taskbar button:hover {
    background: @color1;
    border-radius: 5px;
    transition: all 0.3s ease-in-out;
}

#r-taskbar {
    border-left: 18px solid @bg-border;
    border-bottom: 35px solid transparent;
}

#taskbar.empty {
    background: transparent;
    padding: 0px;
}

/*
 *   ____ _            _
 *  / ___| | ___   ___| | __
 * | |   | |/ _ \ / __| |/ /
 * | |___| | (_) | (__|   <
 *  \____|_|\___/ \___|_|\_\
 *
 * --------------------------------------------------------------------------------------
 */

#center {
    background: @bg-center;
}

#center-secondary {
    background: @bg-center;
}

#l-clock {
    border-left: 18px solid transparent;
    border-bottom: 35px solid @bg-border-dark;
}

#clock {
    font-size: 14px;
    padding: 2px 10px 2px 10px;
}

#clock:hover {
    padding-bottom: 0px;
    color: @accent-color;
    border-bottom: 2px solid @accent-color;
    transition: ease-in-out 0.2s;
}

#r-clock {
    border-left: 18px solid @bg-border-dark;
    border-bottom: 35px solid transparent;
}

/*
 *  __  __ _
 * |  \/  (_)___  ___
 * | |\/| | / __|/ __|
 * | |  | | \__ \ (__
 * |_|  |_|_|___/\___|
 *
 * --------------------------------------------------------------------------------------
 */

#l-misc {
    border-left: 18px solid transparent;
    border-bottom: 35px solid @bg-border;
}

#misc {
    background: @bg-misc;
}

#idle_inhibitor, #custom-theme_switch, #custom-cliphist, #custom-hyprsunset, #custom-gamemode {
    padding-bottom: 2px;
}

#idle_inhibitor:hover, #idle_inhibitor.activated:hover, #custom-theme_switch:hover, #custom-cliphist:hover, #custom-hyprsunset:hover,
#custom-gamemode:hover, #custom-hyprsunset.auto_timer:hover, #custom-hyprsunset.filter_on:hover {
    padding-bottom: 0px;
    color: @accent-color;
    border-bottom: 2px solid @accent-color;
    transition: ease-in-out 0.2s;
}

#misc:hover #custom-misc {
    color: @accent-color;
    transition: ease-in-out 0.2s;
}

#idle_inhibitor.activated {
    color: #99d989;
}

#custom-hyprsunset.filter_on {
    color: #99d989;
}

#custom-hyprsunset.auto_timer {
    color: #e8a561;
}

#misc-devices-padding {
    border-right: 18px solid @border-overlay;
    border-top: 35px solid transparent;
    background-color: @bg-border;
}


/*
 *   ____
 *  / ___|__ ___   ____ _
 * | |   / _` \ \ / / _` |
 * | |__| (_| |\ V / (_| |
 *  \____\__,_| \_/ \__,_|
 *
 * --------------------------------------------------------------------------------------
 */

#cava {
    padding: 0 3px 0 3px;
    color: @foreground;
    background: @bg-devices;
}

/*
 *  ____             _
 * |  _ \  _____   _(_) ___ ___  ___
 * | | | |/ _ \ \ / / |/ __/ _ \/ __|
 * | |_| |  __/\ V /| | (_|  __/\__ \
 * |____/ \___| \_/ |_|\___\___||___/
 *
 * --------------------------------------------------------------------------------------
 */

#devices {
    background: @bg-devices;
}

#pulseaudio, #bluetooth, #backlight, #network, #battery {
    padding-bottom: 2px;
}

#pulseaudio:hover, #bluetooth:hover, #backlight:hover, #network:hover, #battery:hover,
#battery.warning:hover, #battery.low:hover, #battery.critical:hover {
    color: @accent-color;
    padding-bottom: 0px;
    border-bottom: 2px solid @accent-color;
    transition: ease-in-out 0.2s;
}

#devices-secondary {
    background: @bg-devices;
}

#devices-system-padding {
    border-left: 15px solid @border-overlay;
    border-bottom: 35px solid transparent;
    background-color: @bg-border;
}

/* -----------------------------------------------------
 * Battery
 * ----------------------------------------------------- */

 #battery.warning {
    color: rgb(242, 203, 94);
}

#battery.low {
    color: rgb(245, 139, 93);
}

#battery.critical {
    color: rgb(217, 93, 74);
}

/*
 *  ____            _
 * / ___| _   _ ___| |_ ___ _ __ ___
 * \___ \| | | / __| __/ _ \ '_ ` _ \
 *  ___) | |_| \__ \ ||  __/ | | | | |
 * |____/ \__, |___/\__\___|_| |_| |_|
 *        |___/
 *
 * --------------------------------------------------------------------------------------
 */

#system {
    background: @bg-system;
}

#system-secondary {
    background: @bg-system;
}

#custom-power {
    padding-bottom: 2px;
}

#custom-power:hover {
    padding-bottom: 0px;
    color: @accent-color;
    border-bottom: 2px solid @accent-color;
    transition: ease-in-out 0.2s;
}

/*
 *   ___  _   _
 *  / _ \| |_| |__   ___ _ __
 * | | | | __| '_ \ / _ \ '__|
 * | |_| | |_| | | |  __/ |
 *  \___/ \__|_| |_|\___|_|
 *
 * --------------------------------------------------------------------------------------
 */

/*
#custom-updates.green {
    color: @updates_green;
}
*/

#custom-updates.yellow {
    color: @updates_yellow;
}

#custom-updates.red {
    color: @updates_red;
}

/* -----------------------------------------------------
 * VPN
 * ----------------------------------------------------- */

 #custom-updates.noupdate {
    color: transparent;
    padding: 0px;
 }

#custom-vpnstatus, #custom-updates {
    padding-bottom: 2px;
}

#custom-vpnstatus:hover, #custom-updates:hover {
    padding-bottom: 0px;
    color: @accent-color;
    border-bottom: 2px solid @accent-color;
    transition: ease-in-out 0.2s;
}
