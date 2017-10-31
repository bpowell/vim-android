# vim-android
Develop for Android using vim.

## Overview
There are three vim scripts that are included in this setup. Those scripts are:
1. SuperTab
	- [GitHub](https://github.com/ervandew/supertab.git)
	- [Vim.org](http://www.vim.org/scripts/script.php?script_id=1643)

	SuperTab allows us to autocomplete with the tab key.
2. snipMate
	- [GitHub](https://github.com/garbas/vim-snipmate.git)
	- [Vim.org](http://www.vim.org/scripts/script.php?script_id=2540)

	snipMate gives us the ability to add some abilities of the text editor TextMate.

3. javacomplete2
	- [GitHub](https://github.com/artur-shaik/vim-javacomplete2.git)
	- [Vim.org](http://www.vim.org/scripts/script.php?script_id=5181)

	Javacomplete does the omnicompletion for the java and android classes/functions.

## How it works
<strong>findAndroidManifest</strong> is a custom vim script that uses python to do the heavy lifting.
This script will try and find an AndroidManifest.xml file in the current directory. If
the file is not found in the current directory. It will serach up the directory tree
until it finds one or it hits the root directory. Everytime vim is started up and a
java file is detected, the script is ran to find the AndroidManifest.xml. If the 
manifest file is found, it will detect the version of android that you are targeting.
It then adds the jar file for the target version of android to the classpath. This 
way javacomplete can omnicomplete android classes/functions. The way omnicompletion
works is by pressing either the tab key or `[Ctrl + X]` and `[Ctrl + U]`.

<strong>adblogcat</strong> is another custom vim script that uses some python. The current binding
to use this script is <F2>. Pressing <F2> loads up a preview window with the output
of `adb logcat`. The output of `adb logcat` is piped out to a file in the /tmp directory.
The exact file is /tmp/adb-logcat-output.adb. The preview window is loaded up with this
file. The preview window will be updated every second. As of right now, while the preview
window is opened, you cannot edit the file you are working on. Before the preview window
is updated, it jumps back to preview buffer and then updates. To turn this off and stop
`adb logcat` hit <F2> again.

## Requirements
- ctags
- Vim with Python bindings
- Python
- Android SDK
- make
- git

## Installation
First-time installation:
```bash
chmod +x android-install.sh
./android-install.sh
```

The installer for this setup generates a ctags file that is placed in your ~/.vim folder.
This is only ran once. Anytime that the Android SDK is updated you should run the following command:

```bash
ctags --recurse --langmap=Java:.java --languages=Java --verbose -f ~/.vim/tags $ANDROID_SDK/sources
```

This is what javacomplete uses for the android omnicompletion.


