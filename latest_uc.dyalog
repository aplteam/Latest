﻿:Class  Latest  ⍝V4.0.0
⍝ 2020 02 12 ⋄ Kai: Major changes to both arguments and options/flags; see detailed help (???) for more information

    ∇ r←List;⎕IO;⎕ML ⍝ this function usually returns 1 or more namespaces (here only 1)
      :Access Shared Public
      ⎕IO←⎕ML←1
      r←⎕NS''
      r.Name←'Latest'
      r.Desc←'Prints some/all objects found in the workspace or files in a particular folder sorted by "Changed" date'
      r.Group←'FN'
     ⍝ Parsing rules for each:
      r.Parse←' -recursive∊0 1 -stats -all'
    ∇

    ∇ r←Run(Cmd Args);⎕IO;⎕ML;stats;noOf;flag;value;ref;recursive;path;all
      :Access Shared Public
      ⎕IO←⎕ML←1
      recursive←1 Args.Switch'recursive'    ⍝ default is 1
      stats←Args.Switch'stats'              ⍝ default is empty
      all←0 Args.Switch'all'                ⍝ default is 0
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
      ref←CopyCode ⎕NS''
      r←ref.Latest.Run(path recursive stats all noOf)
    ∇

    ∇ r←l Help Cmd;⎕IO;⎕ML;sep;ref
      ⎕IO←⎕ML←1
      sep←⎕UCS 13
      :Access Shared Public
      r←''
      :Select l
      :Case 0
          r,←⊂List.Desc
          r,←⊂'Lists the latest changes either in the workspace or a specific folder.'
      :Case 1
          r←''
          r,←⊂'May be called with:'
          r,←⊂'* no argument at all'
          r,←⊂'* an integer'
          r,←⊂'* a character vector'
          r,←⊂'* both an integer and a character vector'
          r,←⊂''
          r,←⊂'Options:'
          r,←⊂'-recursive=0|1  Defaults to 1, meaning that the path is searched recursively'
          r,←⊂'-all            By default only APL source files are considered'
          r,←⊂'-stats          If this flag is specified you get a matrix with change statistics'
      :Else
          ⎕SE.⎕SHADOW'TEMP'
          ref←⍎'TEMP'⎕SE.⎕NS''
          CopyCode ref
          {}⎕SE.UCMD'ADOC ⎕SE.TEMP.Latest -ref=0 -toc=0'
      :EndSelect
    ∇

    ∇ {ref}←CopyCode ref;regKey;paths;success;thisPath;filename;regData
      regKey←GetRegKey,'\SALT\CommandFolder'
      regData←ReadRegKey regKey
      ((regData∊'∘°')/regData)←';'
      paths←1↓¨{⍺←';' ⋄ (⍺=⍵)⊂⍵}regData
      success←0
      :For thisPath :In paths
          filename←thisPath,'/Latest/Latest.DWS'
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