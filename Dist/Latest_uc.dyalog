:Class  Latest
⍝ User Command script for "Latest", a much more powerful and flexible replacement
⍝ for Dyalog user command ]latest
⍝ Version 3.0.0 from 2020-01-06

    ∇ r←List;⎕IO;⎕ML ⍝ this function usually returns 1 or more namespaces (here only 1)
      :Access Shared Public
      ⎕IO←⎕ML←1
      r←⎕NS''
      r.Name←'Latest'
      r.Desc←'Prints some/all objects found in APLSource\ or the workspace sorted by "Changed" date'
      r.Group←'FN'
     ⍝ Parsing rules for each:
      r.Parse←' -match= -stats'
    ∇

    ∇ r←Run(Cmd Args);⎕IO;⎕ML;stats;noOf;flag;value;ref;match;path
      :Access Shared Public
      ⎕IO←⎕ML←1
      match←''Args.Switch'match'    ⍝ default is empty
      stats←Args.Switch'stats'      ⍝ default is empty
      :If 2=≢Args.Arguments
          'Invalid arguments'⎕SIGNAL 11/⍨~(⊂⊃∘⊃∘⎕VFI¨Args.Arguments)∊(0 1)(1 0)
          (flag value)←⎕VFI 1⊃Args.Arguments
          :If flag
              noOf←value
          :Else
              path←1⊃Args.Arguments
          :EndIf
          (flag value)←⎕VFI 2⊃Args.Arguments
          :If flag
              noOf←value
          :Else
              path←2⊃Args.Arguments
          :EndIf
      :ElseIf 1=≢Args.Arguments
          (flag value)←⎕VFI 1⊃Args.Arguments
          :If flag
              noOf←value
              path←''
          :Else
              path←1⊃Args.Arguments
              noOf←⍬
          :EndIf
      :ElseIf 0≠≢Args.Arguments
          'Invalid number of arguments'⎕SIGNAL 11
      :EndIf
      :If 0=≢Args.Arguments
          noOf←⍬
          path←''
      :EndIf
      ref←CopyCode
      r←ref.Latest.Run(path match stats noOf)
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
          r,←⊂'Returns by default a list for all APL objects with timestamps in the'
          r,←⊂'current directory''s APLSource\ folder or the current workspace.'
          r,←⊂'This user command requires acre in ⎕SE.'
          r,←⊂''
          r,←⊂'By default (read: the user specifies no argument) the user command'
          r,←⊂'reports all files changed lately (read: last day with changes).'
          r,←⊂'When an argument is specified it must be one of:'
          r,←⊂'* An integer. If positive this is treated as the number of items to be listed.'
          r,←⊂'  If it is negative it defines the number of days with changes.'
          r,←⊂'* A character vector. If it starts with a # it is treated as a namespace name.'
          r,←⊂'  If it does not start with a # it is treated as a path to an acre project.'
          r,←⊂'* A vector of length two with an integer and a character vector in no particular'
          r,←⊂'  order; see above.'
          r,←⊂''
          r,←⊂'-match= The content is matched against the last part of the name.'
          r,←⊂'        For example, if you want to get a list with all APL objects  starting'
          r,←⊂'        their names with "Test_":'
          r,←⊂'        ]latest Test_'
          r,←⊂'        Note that you cannot specify an additional level (dot). That means that'
          r,←⊂'        only the last level is used for the comparison. In other words the above'
          r,←⊂'        example matches C:/Foo/Test_ but not C:/Test_/Foo'
          r,←⊂'-stats  If this flag is specified you get a matrix with two columns, the first'
          r,←⊂'        one with all unique dates and the second one with the number of changes'
          r,←⊂'        on that date. The number of rows is defined by the number of unique dates.'
          r,←⊂'        If -stats is specified -match will be ignored as well as any integer'
          r,←⊂'        provided as argument.'
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
