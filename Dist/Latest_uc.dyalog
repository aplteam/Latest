:Class  Latest
⍝ User Command script for "Latest", a much more powerful and flexible replacement
⍝ for Dyalog user command ]latest
⍝ Version 3.0.0 from 2020-01-06

    ∇ r←List;⎕IO;⎕ML ⍝ this function usually returns 1 or more namespaces (here only 1)
      :Access Shared Public
      ⎕IO←⎕ML←1
      r←⎕NS''
      r.Name←'Latest'
      r.Desc←'Prints some/all objects found in APLSource\ sorted by "Changed" date'
      r.Group←'FN'
     ⍝ Parsing rules for each:
      r.Parse←' -path= -stats'
    ∇

    ∇ r←Run(Cmd Args);⎕IO;⎕ML;path;stats;noOf;flag;value;acreFlag;ref;name
      :Access Shared Public
      ⎕IO←⎕ML←1
      path←''Args.Switch'path'      ⍝ default is empty
      stats←Args.Switch'stats'      ⍝ default is empty
      name←{0=≢⍵:'' ⋄ 1⊃⍵}Args.Arguments
      :If 0=≢Args.Arguments
          noOf←⍬
      :Else
          (flag value)←⎕VFI 1⊃Args.Arguments
          :If flag
              noOf←value
          :Else
              noOf←0
              'Name must be simple'⎕SIGNAL 11/⍨'.'∊name
          :EndIf
      :EndIf
      acreFlag←0
      ref←CopyCode
      r←ref.Latest.Latest.Run(name path stats acreFlag noOf)
    ∇

    ∇ r←l Help Cmd;⎕IO;⎕ML;sep
      ⎕IO←⎕ML←1
      sep←⎕UCS 13
      :Access Shared Public
	  r←''
      :Select l
      :Case 0
          r,←⊂List.Desc
      :Else
		r←''
		r,←⊂'Returns by default a list with timestamps for all APL objects in the'
		r,←⊂'current directory''s APLSource\ folder.'
      r,←⊂''
      r,←⊂'By default (read: the user specifies no argument) the user command'
      r,←⊂'reports all files changed lately (read: last day with changes).'
      r,←⊂'When an argument is specified and it is an integer then it is treated'
      r,←⊂'as the number of items to be listed.'
      r,←⊂''
      r,←⊂'When the integer is negative then it is treated as number of days.'
      r,←⊂''
      r,←⊂'When the argument is text then the names are matched against the argument.'
      r,←⊂'For example, if you want to get a list with all functions starting their'
      r,←⊂'names with <Test_:>'
      r,←⊂']latest Test_'
      r,←⊂'Note that you cannot specify an additional level (dot). That means that'
      r,←⊂'only the last level is used for the comparison. In other words the above'
      r,←⊂'example matches C:/Foo/Test_ but not C:/Test_/Foo'
      r,←⊂''
      r,←⊂'This user command requires acre in ⎕SE'
      r,←⊂''
      r,←⊂'-path= By default the user command expects to find a folder APLSource\ in'
      r,←⊂'       the current directory. If it cannot it throws an error.'
      r,←⊂'       You can overwrite this default behaviour by specifying a path to a'
      r,←⊂'       folder that hosts a folder APLSource. This does not have to be a'
      r,←⊂'       Currently opened acre project.'
      r,←⊂'       Instead you can also specify the top namespace of any open acre project.'
      r,←⊂'-stats If this flag is specified you get a matrix with two columns, the first'
      r,←⊂'        one with all unique dates and the second one with the number of changes'
      r,←⊂'        on that date. The number of rows is defined by the number of unique dates.'
	  :EndSelect
    ∇

    ∇ ref←CopyCode;regKey;paths;success;thisPath;filename;regData
      regKey←GetRegKey,'\SALT\CommandFolder'
      regData←ReadRegKey regKey
      ((regData∊'∘°')/regData)←';'
      paths←1↓¨{⍺←';' ⋄ (⍺=⍵)⊂⍵}regData
      success←0
      :For thisPath :In paths
          filename←thisPath,'\Latest.DWS'
          ref←⎕NS''
          :Trap 0
              ref.⎕CY filename
              :If 0<1↑⍴ref.⎕NL⍳16
                  success←1
                  :Leave
              :EndIf
          :EndTrap
      :EndFor
      'Could not find workspace "latest.dws"'⎕SIGNAL 6/⍨~success
    ∇

    ∇ r←{default}ReadRegKey key;wsh;⎕WX
     ⍝ Read a registry key.
      ⎕WX←1
      default←{0<⎕NC ⍵:⍎⍵ ⋄ ''}'default'
      'wsh'⎕WC'OLEClient' 'WScript.Shell'
      :Trap 11
          r←wsh.RegRead key
      :Else
          r←default
      :EndTrap
    ∇

    ∇ regKey←GetRegKey;⎕IO;⎕ML
      ⎕IO←⎕ML←1
      regKey←''
      regKey,←'HKEY_CURRENT_USER\Software\Dyalog\Dyalog APL/W'
      regKey,←('-64'≡¯3↑1⊃'.'⎕WG'APLVersion')/'-64'
      regKey,←' ',{⍵/⍨1≥+\'.'=⍵}2⊃'.'⎕WG'APLVersion'
      regKey,←' ',((80=⎕DR'')/'Unicode')
    ∇

:EndClass
