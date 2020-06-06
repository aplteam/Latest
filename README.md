# Latest

## What is it good for

The general idea of the `Latest` user command is to list the latest changes the user made to the APL code.

By default all changes made on the last day the code was changed are listed.

Imagine you left a project half-baked because of a change of priorities. When you come back after a day or a week or a month you might or might not be able to continue where you left depending on your memory.

## Overview

* `]latest` can act on the workspace, meaning that you need to specify something like `#` or `⎕SE` or `#.Foo` as argument
* `]latest` can act on a specific folder like C:\MyProjects\ThisProject\APLSource
* `]latest` can act on opened acre projects (no argument required at all)

If no argument is specified **and** acre does not live in `⎕SE` (read: you are not an acre user), then it falls 
back to the current directory but will check if there is a direcotry `APLSource/` and if so, process the contents of that folder.

By default the user command reports all objects or files changed lately (read: last day with any changes).

This limits `]Latest` powers within the workspace, because scripts (classes, interfaces, scripted namespaces) do
not own a timestamp that could be used. When acting on the file system however, this information is available.

Note that by providing a path as an argument you can extend the meaning of ]`Latest` beyond APL source files, in
particular together with the `-all` flag.

## The argument(s)

When an argument is specified it must be one of:

* An integer
  * A positive one defines the number of objects/files to be listed.
  * A negative one defines the number of days with any changes.
* A character vector. If it starts with `#` or `⎕` the argument is treated as a namespace path.

  Otherwise it is treated as a path to an acre project.
* A vector of length two with an integer and a character vector in no particular order, see above.

In case no argument or only an integer is specified, `]Latest` will establish which acre projects are currently open.
If it is just one it will act on it. If there are multiple acre projects open, then the user will be prompted.

Note that if you provide a path pointing to an acre project you should include `APLSource\` if you are interested just in APL source files. 

If on the other hand you want to see more than just APL source file then you might want to specify the `-all` flag,
see there for details.

## FLags (options)

`-recursive=0|1`

: The default is 1, meaning that the path is searched recursively;
  if you don't want this then specify a 0
       
`-all`

: By default only files with extensions that are recognized as APL source files (`.aplf`, `.aplc` etc.) are
  listed. You can force `]Latest` to consider all files by specifying this flag.

`-stats`

: If this flag is specified you get a matrix with two columns, the first
  one with all unique dates and the second one with the number of changes
  on that date. The number of rows is defined by the number of unique dates.

: If `-stats` is specified any integer provided as argument will be ignored.