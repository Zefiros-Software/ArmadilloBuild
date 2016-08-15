# GoogleTest
To use the GoogleTest in [ZPM](zpm.zefiros.eu), just use:

# Status
OS          | Status
----------- | -------
Linux & OSX | [![Build Status](https://travis-ci.org/Zefiros-Software/Anaconda.svg?branch=master)](https://travis-ci.org/Zefiros-Software/Anaconda)
Windows     | [![Build status](https://ci.appveyor.com/api/projects/status/0a8c11bdsdxehg58?svg=true)](https://ci.appveyor.com/project/PaulVisscher/anaconda)

# [ZPM](http://zpm.zefiros.eu) Installation
In `.package.json`
```json
"requires": [
		{
			"name": "Zefiros-Software/GoogleTest",
			"version": "@head"
		}
]
```

In `premake5.lua`
```lua
zpm.uses "Zefiros-Software/GoogleTest"
```