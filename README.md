# Latest

## What is it good for

The general idea of the `Latest` user command is to list the latest changes the user made to the APL code.

By default all changes are listed made on the last day the code was changed.

Imagine you left a project half-baked because of a change of priorities. When you come back after a day or a week or a month you might or might not be able to continue where you left.

If you execute `]Latest` you get a list with all changes you made on the last day you worked on the code. With `]Latest ¯3` you get a list with all changes made over the course of the last three days any changes to the code were made.

## The argument(s)

The user may specify one or two arguments. A single argument might be either a character vector or an integer.

If it is a character vector then it must be one of:

* A namespace name or `#` or `⎕SE`. Use this to investigate all objects in the given space.

  Note that the power of `]Latest` is limited in this case because scripts do not own a timestamp, therefore `]Latest` cannot report on them in this case.

* A folder. By default all files with extension reserved for APL Source code are investigated.

  Because files carry a date all kinds of APL objects can be processed.

If it is an integer it must be one of:

* Positive integer; treated as the number of objects to be listed
* Negative integer; treated as the number of days to be considered

Note that you can also specify both, a character vector **and** an integer in no particular order.

If no argument is specified at all then what happens depends on whether there are any acre projects or not:

* In case there are open acre projects, the command acts towards this/those.

  If just one project is open then `]Latest` will act on that project.

  If there is more than one project open then the user will be prompted.

* In case there are no open acre projects --- or acre is not even available in `⎕se` --- the current directory is investigated.