# Latest

## What is it good for

The general idea of the `Latest` user command is to list the latest changes the user made to the APL code.

By default all changes made on the last day the code was changed are listed.

Imagine you left a project half-baked because of a change of priorities or whatever. When you come back after a day or a week or a month you might or might not be able to continue where you left depending on your memory.

There is a Dyalog user command that does something similar. However, it takes timestamps into account, meaning that it is helpless when it comes to scripts as they do not have a timestamp.

## Installation

The contents of the ZIP files needs to go into any of the folders that Dyalog APL scans for user commands.

For example, under Windows a folder `MyUCMDs` will be created in `%USERPROFILE%\Documents` when Dyalog is installed, and that is a good place for putting the `Latest\` folder and the related file `latest_uc.dyalog`.

However, note that under Linux and Mac-OS no such folder will be created, although it will be scanned for user commands in case it exists. It needs to go into your home folder.

## Overview

* `]latest` can act on the workspace, meaning that you need to specify something like `#` or `⎕SE` or `#.Foo` as argument
* `]latest` can act on a specific folder like C:\MyProjects\ThisProject\APLSource
* `]latest` can act on open Cider projects (no argument required)

If no argument is specified **and** Cider does **not** live in `⎕SE` (read: you are not using Cider), then it falls back to the current directory but will ask the user for confirmation.

By default the user command reports all objects or files changed lately (read: last day with any changes).

This limits `]Latest` powers within the workspace, because scripts (classes, interfaces, scripted namespaces) do not own a timestamp that could be used. When acting on the file system however, this information is available.

Note that by providing a path as an argument you can extend the meaning of `]Latest` beyond APL source files, in particular together with the `-all` flag.

## The argument(s)

When an argument is specified it must be one of:

* An integer
  * A positive one defines...
    * the number of objects/files to be listed if the integer is smaller than `1E7` 
    * the date from which changes should be listed if the integer is greater than `1E7` 
  * A negative one defines the number of days with any changes

* A character vector. 
  * If it starts with `#` or `⎕` the argument is treated as a namespace path
  * If it does not start with `#` or `⎕` the argument is treated as a path to a project managed either by Cider or by acre
* A vector of length two with an integer and a character vector in no particular order, see above

In case no argument or only an integer is specified, `]Latest` will establish which Cider projects are currently opened.

If it is just one it will act on it. If there are multiple projects open, then the user will be prompted.

Note that if you provide a path pointing to an open Cider  project you should include the folder that holds APL source files. 

If on the other hand you want to see more than just APL source files then you might want to specify the `-all` flag,
see there for details.

## FLags (options)

`-recursive=0|1`

: The default is 1, meaning that the path is searched recursively;
  if you don't want this then specify a 0.
       
`-all`

: By default only files with extensions that are recognized as APL source files (`.aplf`, `.aplc`, `.dyalog` etc.) are
  listed. You can force `]Latest` to consider all files by specifying this flag.

`-stats`

: If this flag is specified you get a matrix with two columns, the first
  one with all unique dates and the second one with the number of changes
  on that date. The number of rows is defined by the number of unique dates.

: If `-stats` is specified any integer provided as argument will be ignored.