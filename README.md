<div align="center" id="top"> 

  &#xa0;

  <!-- <a href="https://simplei3wm.netlify.app">Demo</a> -->
</div>

<h1 align="center">Simple I3wm</h1>

<p align="center">
  <img alt="Github top language" src="https://img.shields.io/github/languages/top/me-js-bro/simple-i3wm?color=56BEB8">

  <img alt="Github language count" src="https://img.shields.io/github/languages/count/me-js-bro/simple-i3wm?color=56BEB8">

  <img alt="Repository size" src="https://img.shields.io/github/repo-size/me-js-bro/simple-i3wm?color=56BEB8">

  <img alt="License" src="https://img.shields.io/github/license/me-js-bro/simple-i3wm?color=56BEB8">

  <!-- <img alt="Github issues" src="https://img.shields.io/github/issues/me-js-bro/simple-i3wm?color=56BEB8" /> -->

  <!-- <img alt="Github forks" src="https://img.shields.io/github/forks/me-js-bro/simple-i3wm?color=56BEB8" /> -->

  <!-- <img alt="Github stars" src="https://img.shields.io/github/stars/me-js-bro/simple-i3wm?color=56BEB8" /> -->
</p>

<!-- Status -->

<hr>

<p align="center">
  <a href="#about">About</a> &#xa0; | &#xa0; 
  <a href="#features">Features</a> &#xa0; | &#xa0;
  <a href="#technologies">Technologies</a> &#xa0; | &#xa0;
  <a href="#requirements">Requirements</a> &#xa0; | &#xa0;
  <a href="#keybinds">Keybinds</a> &#xa0; | &#xa0;
  <a href="#license">License</a> &#xa0; | &#xa0;
  <a href="https://github.com/me-js-bro" target="_blank">Author</a>
</p>

<br>

## About ##

A simple i3 window manager configuration with installation script

## Features ##

1. Minimal config
2. Organized files and directories
3. Dynamic color changing feature
4. 3 Themes
5. Dynamic wallpaper changing based on current theme
6. App launcher
7. Access clipboard history
8. Notifications
9. System Updates
10. Keyboard Switching ( if openbangla keyboard is installed )

<br>

<details align="center">
  <summary>Click to see the screenshots</summary>
  <div style="display: flex; flex-direction: row; flex-wrap: wrap; justify-content: space-around;">
    <img src="https://github.com/me-js-bro/Screen-Shots/blob/main/i3/1.png?raw=true" alt="Screenshot 1" width="30%">
    <img src="https://github.com/me-js-bro/Screen-Shots/blob/main/i3/2.png?raw=true" alt="Screenshot 2" width="30%">
    <img src="https://github.com/me-js-bro/Screen-Shots/blob/main/i3/3.png?raw=true" alt="Screenshot 3" width="30%">
  </div>

  <div style="display: flex; flex-direction: row; flex-wrap: wrap; justify-content: space-around;">
    <img src="https://github.com/me-js-bro/Screen-Shots/blob/main/i3/4.png?raw=true" alt="Screenshot 1" width="30%">
    <img src="https://github.com/me-js-bro/Screen-Shots/blob/main/i3/5.png?raw=true" alt="Screenshot 2" width="30%">
    <img src="https://github.com/me-js-bro/Screen-Shots/blob/main/i3/6.png?raw=true" alt="Screenshot 3" width="30%">
  </div>
</details>


## Technologies ##

The following tools were used in this project:

- [i3wm](https://i3wm.org/)
- [Polybar](https://polybar.github.io/)
- [Rofi](https://github.com/davatorium/rofi)
- [Pywal](https://github.com/dylanaraps/pywal)
- [Greenclip](https://github.com/erebe/greenclip)

## Requirements ##

This configuration is now only available for [Arch](archlinux.org) Linux. I have a simple script wihch installs the required packages and fonts. <br> But if you install the necessary packages in your <b>Linux Distro</b>, you can use the configuration. <br>
Well very soon I'll update for <b>dnf</b>, <b>apt</b> and <b>zypper</b> also.


## Starting ##

```bash
# Clone this project
$ git clone --depth=1 https://github.com/me-js-bro/simple-i3wm

# Access
$ cd simple-i3wm

# Make the script executable
$ chmod +x setup.sh

# Now run the script
$ ./setup.sh

# If it finds any error and exits the script, please check the Log files in the simple-i3wm/Logs directory.
```

## Keybinds ##

| Keybind                  | Action                                      |
|--------------------------|---------------------------------------------|
| `$mod+q`                 | Kill the focused window                     |
| `$mod+Return`            | Open terminal (kitty) in workspace 1        |
| `$mod+d`                 | Launch rofi menu                            |
| `$mod+e`                 | Open file manager (thunar) in workspace 1   |
| `$mod+b`                 | Open Firefox in workspace 2                 |
| `$mod+Shift+b`           | Open any other browser in workspace 2       |
| `$mod+c`                 | Open VS Code in workspace 3                 |
| `$mod+Shift+l`           | Lock screen                                 |
| `$mod+w`                 | Change wallpaper                            |
| `$mod+Shift+w`           | Select wallpaper (style 1)                  |
| `$mod+Control+w`         | Select wallpaper (style 2)                  |
| `$mod+Shift+c`           | Show clipboard history                      |
| `$mod+$alt+c`            | Clear clipboard history                     |
| `$mod+t`                 | Change theme                                |
| `$mod+x`                 | Show rofi power menu                        |
| `$mod+Tab`               | Show active windows                         |
| `$mod+Shift+d`           | Show rofi emoji                             |
| `$mod+$alt+b`            | Change shell theme                          |
| `$mod+o`                 | Open OBS in workspace 4                     |
| `$mod+Shift+h`           | Show help                                   |
| `Control+Escape`         | Hide/unhide Polybar                         |
| `Control+$alt+Escape`    | Reload Polybar                              |
| `Control+Up`             | Launch Polybar at top                       |
| `Control+Down`           | Launch Polybar at bottom                    |
| `F9`                     | Toggle volume (mute/unmute)                 |
| `F10`                    | Decrease volume                             |
| `F11`                    | Increase volume                             |
| `Print`                  | Full screen screenshot (3s delay)           |
| `$mod+Print`             | Screenshot of selected area                 |
| `$mod+Shift+Print`       | Crop screenshot                             |
| `$mod+h`                 | Focus left                                  |
| `$mod+j`                 | Focus right                                 |
| `$mod+u`                 | Focus up                                    |
| `$mod+m`                 | Focus down                                  |
| `$mod+Left`              | Focus left (cursor key)                     |
| `$mod+Down`              | Focus down (cursor key)                     |
| `$mod+Up`                | Focus up (cursor key)                       |
| `$mod+Right`             | Focus right (cursor key)                    |
| `$mod+Shift+j`           | Move window left                            |
| `$mod+Shift+semicolon`   | Move window right                           |
| `$mod+Shift+u`           | Move window up                              |
| `$mod+Shift+m`           | Move window down                            |
| `$mod+Shift+Left`        | Move window left (cursor key)               |
| `$mod+Shift+Down`        | Move window down (cursor key)               |
| `$mod+Shift+Up`          | Move window up (cursor key)                 |
| `$mod+Shift+Right`       | Move window right (cursor key)              |
| `$mod+Shift+v`           | Split window vertically                     |
| `$mod+f`                 | Toggle fullscreen mode                      |
| `$mod+s`                 | Change to stacking layout                   |
| `$mod+v`                 | Toggle floating mode                        |
| `$mod+space`             | Focus between tiling/floating windows       |
| `$mod+a`                 | Focus parent container                      |
| `$mod+Control+c`         | Reload configuration                        |
| `$mod+Shift+r`           | Restart i3 inplace                          |
| `$mod+Shift+x`           | Exit i3                                     |


## Discord ##

Let's discuss about the improvement of the config [Here](https://discordapp.com/channels/1260810946108981258/1260810946108981261)

## License ##

This project is under license from MIT. For more details, see the [LICENSE](LICENSE) file.



<a href="#top">Back to top</a>
