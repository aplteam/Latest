# Latest

## What is it good for

The general idea of the `Latest` user command is to list the latest changes the user made to the APL code.

By default all changes made on the last day the code was changed are listed.

Imagine you left a project half-baked because of a change of priorities. When you come back after a day or a week or a month you might or might not be able to continue where you left depending on your memory. `]Latest` to the recsue.

## Installation

The contents of the ZIP files needs to go in any of the folders that Dyalog APL scans for user commands.

For example, under Windows a folder `MyUCMDs` will be created in `%USERPROFILE%\Documents` when Dyalog is installed, and that is a good place for putting the `Latest\` folder.

However, note that under Linux and Mac-OS no such folder will be created, although it will be scanned for user commands in case it exists.

## Overview

`]Latest` was mainly invented to work on opened projects, no matter whether they are managed by [Cider](https://github.com/aplteam/Cider) or by [acre](https://github.com/the-carlisle-group/Acre-Desktop).

If there is just one project open then `]Latest` will act on that one. If there are multiple projects opened the user will be asked which one shre want to focus on.

But you can also provide an argument: this can be a path, either on the file system in the workspace (like `#.MyCode` or `⎕SE'`).

By default `]Latest` lists all changes from the day ther were any changes made at all, but instead you can ask for a specfic numbr of days, a specfic numbr of changes or all changaes made after a particular date.

By default `]Latest` looks for APL source files (defined by proper extensions), but you can also ask for all files with the `-all` flag.

## Eamples

```
      ]Latest
 #.Latest.Latest.ADOC_Doc         2022-05-22 13:57:12 
 #.Latest.Latest.AddSlash         2022-05-22 13:57:12 
 #.Latest.Latest.EndIf            2022-05-22 13:57:12 
 #.Latest.Latest.History          2022-05-22 13:57:12 
 #.Latest.Latest.Run              2022-05-22 13:57:12 
 #.Latest.Latest.SelectProject    2022-05-22 13:57:12 
 #.Latest.Latest.Version          2022-05-22 13:57:12 
 #.Latest.Latest_uc               2022-05-22 13:57:12 
 #.Latest.TestCases.Assert        2022-05-22 13:57:12 
 #.Latest.TestCases.Test_140      2022-05-22 13:57:12 
 #.Latest.TestCases.Test_150      2022-05-22 13:57:12 
 #.Latest.TestCases.Test_170      2022-05-22 13:57:12 
 #.Latest.TestCases.Test_ZZZ_998  2022-05-22 13:57:12 
      ]latest -v
4.5.0+127 from 2022-05-22
```
