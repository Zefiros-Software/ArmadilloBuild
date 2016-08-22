# Armadillo
To use Armadillo in [ZPM](http://zpm.zefiros.eu), just use:

# Status
OS          | Status
----------- | -------
Linux & OSX | [![Build Status](https://travis-ci.org/Zefiros-Software/ArmadilloBuild.svg?branch=master)](https://travis-ci.org/Zefiros-Software/ArmadilloBuild)
Windows     | [![Build status](https://ci.appveyor.com/api/projects/status/hiqslar9whee6h6m?svg=true)](https://ci.appveyor.com/project/PaulVisscher/armadillobuild)

# [ZPM](http://zpm.zefiros.eu) Installation
We have two flavours:

## Default Armadillo
In `.package.json`
```json
"requires": [
		{
			"name": "Zefiros-Software/Armadillo",
			"version": "@head"
		}
]
```

In `premake5.lua`
```lua
zpm.uses "Zefiros-Software/Armadillo"
```
## Extended Armadillo
In `.package.json`
```json
"requires": [
		{
			"name": "Zefiros-Software/ArmadilloExt",
			"version": "@head"
		}
]
```

In `premake5.lua`
```lua
zpm.uses "Zefiros-Software/Armadilloext"
```