# Latest

## What is it good for

`]Latest` lists the most recent changes to APL source code, sorted by modification date.

Imagine returning to a project after a day, a week, or a month. `]Latest` shows you exactly what changed and when, so you can
pick up where you left off.

By default it reports everything changed on the last day any code was touched.

There is a built-in Dyalog user command that does something similar, but it relies on timestamps — which means it cannot handle
scripts and dfns, since those carry no timestamp. `]Latest` does not have this limitation.

## Overview

`]Latest` can target:

* A LINKed namespace — anything returned by `]Link.Status`
* An [acre](https://github.com/the-carlisle-group/acre-desktop "acre on GitHub") project
* The workspace — pass `#`, `⎕SE`, or a specific namespace like `#.Foo`
* A plain folder on disk — pass a path like `C:\MyProjects\Foo\APLSource`

If no argument is specified and there are no LINKed namespaces and the `-acre` was not specified and there are no acre projects then it falls back to the current directory but will ask the user for confirmation.

When both Linked folders and open acre projects are present, use `-acre` to direct `]Latest` at the acre project(s).

By default only APL source files are considered (by file extension). Pass `-allFiles` to include everything, which makes
`]Latest` useful beyond APL source — for example, to survey a mixed project folder.


## Arguments

`]Latest` accepts an optional namespace/path and an optional integer or date:

| Argument | Meaning |
|---|---|
| *(none)* | Changes on the last modified day |
| `5` | The 5 most recently changed objects |
| `20230807` | All changes from 2023-08-07 to now |
| `2023-08-07` | Same, hyphenated date form |
| `20220101-20221231` | Changes within a date range (inclusive) |
| `2022-01-01-2022-12-31` | Same, hyphenated date form |

An integer smaller than 1E7 is a count; an integer larger than 1E7 is a date (YYYYMMDD). A negative integer means that many
days back (deprecated — use `-days=` instead).


## Flags

| Flag | Description |
|---|---|
| `-acre` | Target open acre project(s) instead of Linked folders |
| `-allFiles` | Include all files, not just APL source files |
| `-api` | Include Tatin package API objects in results (excluded by default) |
| `-days=n` | Report changes from the last *n* days |
| `-recursive=0\|1` | Search sub-folders recursively (default: 1) |
| `-se` | Include Linked namespaces in `⎕SE` (excluded by default) |
| `-stats` | Show a change-statistics matrix instead of the object list |
| `-version` | Print the version number; all other arguments are ignored |


## Examples

```
      ]Latest
 #.ADOC                           ≢ ←→ 5
 #.Latest.Latest.ADOC_Doc         2022-05-22 13:57:12 
 #.Latest.Latest.AddSlash         2022-05-22 13:57:12 
 #.Latest.Latest.EndIf            2022-05-22 13:57:12 
 #.Latest.Latest.History          2022-05-22 13:57:12 
 #.Latest.Latest.Run              2022-05-22 13:57:12 
      ]latest -version
8.0.0+227 from 2026-06-28
```

## Installation

Install `Latest` as a Tatin package:

```
]Tatin.InstallPackages [tatin]latest [MyUCMDs]
```

This makes the `]Latest` user command available. The API (`⎕SE.Latest`) is loaded on first use — running `]Latest -version`
is the lightest way to trigger this.

If you want the API to be available right from the start then please consult the article [Dyalog User Commands](https://aplwiki.com/wiki/Dyalog_User_Commands "Link to the APL wiki").

