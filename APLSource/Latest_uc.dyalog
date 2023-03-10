:Class  Latest_uc

    ∇ r←List;⎕IO;⎕ML ⍝ this function usually returns 1 or more namespaces (here only 1)
      :Access Shared Public
      ⎕IO←⎕ML←1
      r←⎕NS''
      r.Name←'Latest'
      r.Desc←'Prints some/all objects found in either the workspace or files in a folder sorted by their "Changed" date'
      r.Group←'FN'
     ⍝ Parsing rules for each:
      r.Parse←' -recursive∊0 1 -stats -all -version'
    ∇

    ∇ r←Run(Cmd Args);⎕IO;⎕ML;stats;noOf;flag;value;ref;recursive;path;all;version
      :Access Shared Public
      ⎕IO←⎕ML←1
      version←0 Args.Switch'version'
      :If version
          r←⎕SE.Latest.Version ⋄ →0
      :EndIf
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
      ref←LoadCode ⍬
      ref.⎕IO←0 ⋄ ref.⎕ML←3
      r←⎕SE.Latest.Run(path recursive stats all noOf)
    ∇

    ∇ r←level Help Cmd;⎕IO;⎕ML
      ⎕IO←⎕ML←1
      :Access Shared Public
      r←''
      :Select level
      :Case 0
          r,←⊂']Latest [<no arg>|<int>|<txt>|<int&txt] -recursive=1|0 -all -stats -version'
      :Case 1
          r,←⊂'Lists the latests changes. Is mainly designed to act on Cider projects but'
          r,←⊂'can also deal with just the workspace or with any folder.'
          r,←⊂''
          r,←⊂'May be called with:'
          r,←⊂' * no argument at all'
          r,←⊂' * an integer'
          r,←⊂' * a character vector'
          r,←⊂' * both an integer and a character vector'
          r,←⊂''
          r,←⊂'A character vector may specify either a namespace or a folder on disk.'
          r,←⊂''
          r,←⊂' * An integer smaller than 1E7 is treated as number of items to be reported'
          r,←⊂' * An integer greater than 1E7 is treated as a specific date (YYYYMMDD) (after)'
          r,←⊂' * A negative integer is treated as number of days'
          r,←⊂''
          r,←⊂'Options:'
          r,←⊂'-recursive=0|1  Defaults to 1, meaning that the path is searched recursively'
          r,←⊂'-all            By default only APL source files are considered (by extension)'
          r,←⊂'-stats          If this flag is specified you get a matrix with change statistics'
          r,←⊂'-version        Prints the version number of the user command to the session'
          r,←⊂'                If this is specified any argument and all other flags are ignored.'
      :EndSelect
    ∇

    ∇ {r}←LoadCode dummy
      r←⎕SE.Tatin.LoadDependencies⊂'[MyUCMDs]Latest'
    ∇

    ∇ r←GetHomeFolder
      r←1⊃⎕NPARTS ##.SourceFile
    ∇

:EndClass
