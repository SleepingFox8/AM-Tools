# AM-tools
This repository contains LUA libraries to support the creation of Advanced Macros bot scripts. These libraries are currently optimized for [advanced macros mod](https://www.curseforge.com/minecraft/mc-mods/advanced-macros) v9.2.0 or Minecraft v1.14.4. 

## Libraries

- ``botTools.lua`` contains functions for controlling bots
- ``compTools.lua`` contains functions for computing things

## How to use

You can add these libraries to your repository as a git submodule by using the command ``git submodule add https://github.com/SleepingFox8/AM-Tools``. This will import the latest version of this repository into your github rebository as a subdirectory. 

From there you can import these libraries to your own ``.lua`` scripts by importing them via:

```lua
botTools = require ("AM-Tools/botTools")
compTools = require ("AM-Tools/compTools")
```

Library functrions can be called like so:

```lua
botTools.sprintToPoint(0,0,0)
```

If this repo updates, your repo's submodule will not update automatically. To update your repository's submodule, ``cd`` into your submodule's directory and run ``git pull origin master``.
