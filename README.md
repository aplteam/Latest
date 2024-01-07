# Latest

## What is it good for

The general idea of the `Latest` user command is to list the latest changes the user made to the APL code.

Imagine you left a project half-baked because of a change of priorities or whatever. When you come back after a day or a week or a month you might or might not be able to continue where you left depending on your memory. `]Latest` to the rescue.

By default all changes made on the last day the code was changed are listed.

There is a Dyalog user command that does something similar. However, it takes timestamps into account, meaning that it is helpless when it comes to scripts and dfns because neither have a timestamp.


## Overview

* `]latest` can act on a LINK, that is anything returned by `]Link.Status`; specify the LINKed namespace for this
* `]latest` can act on the workspace, meaning that you need to specify something like `#` or `⎕SE` or `#.Foo` as argument
* `]latest` can act on a specific (un-linked) folder like `C:\MyProjects\ThisProject\APLSource`

If no argument is specified and there are no LINKed namespaces, then it falls back to the current directory but will ask the user for confirmation.

By default the user command reports all objects or files changed lately (read: last day something was changed).

Note that by providing a path as an argument you can extend the meaning of `]Latest` beyond APL source files, in particular together with the `-allFiles` flag.

## Examples

```
      ]Latest
 #.ADOC                           ≢ ←→ 5
 #.Latest.Latest.ADOC_Doc         2022-05-22 13:57:12 
 #.Latest.Latest.AddSlash         2022-05-22 13:57:12 
 #.Latest.Latest.EndIf            2022-05-22 13:57:12 
 #.Latest.Latest.History          2022-05-22 13:57:12 
 #.Latest.Latest.Run              2022-05-22 13:57:12 
      ]latest -v
7.0.0+127 from 2023-12-28
```

## Installation

`Latest` can be installed as a Tatin package:

```
]Tatin.InstallPackages [tatin]latest [MyUCMDs]
```

This will make the user commands of `Latest` available, but it will not establish the API. However, executing any of its user commands will force `Latest` to load the API into `⎕SE`. For that, executing `]Latest.Version` will do.

If you want the API to be available right from the start then please consult the article [Dyalog User Commands](https://aplwiki.com/wiki/Dyalog_User_Commands "Link to the APL wiki").


## 
