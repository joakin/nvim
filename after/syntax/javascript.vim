
"" If conceal is available modify some rules

if (has('conceal') && &enc=="utf-8")

  " Change pangloss return conceal sign, it only exists on a few fonts
  " syntax keyword jsReturn         return conceal cchar=Β«


  "" NOT NEEDED ANYMORE SINCE PANGLOSS INCLUDES SOME CONCEALS NOW {{{
  "" ------------------------------------------------------------

  "" Replace the function keyword with a π
  " syntax match jsConcealFunction /function/ contained containedin=javaScriptFunction conceal cchar=Ζ "π

  " "" Replace the return keyword with β΅ , β€, β©, β, β, β, β, Β«, symbol
  " syntax keyword javaScriptBranch return conceal cchar=Β« "π

  " "" Replace this. with @ ala Ruby
  " "" We need to clear the original style to override it with a match instead of keyword
  " syntax clear   javaScriptThis
  syntax match   javaScriptThis  /\<this\>/ containedin=@javaScriptExpression2
  syntax match   jsConcealThis  /\<this\./ containedin=@javaScriptExpression2 conceal cchar=@
  hi def link jsConcealThis javaScriptThis

  "" Replace .prototype. with βor β·
  "" Use containedin=@jsAll to give it more priority
  " prototype symbols: Β», β
  " syntax match jsConcealProto /\.prototype\./ containedin=@javaScriptAll conceal cchar=Β»
  " hi def link jsConcealProto Type

  "" ------------------------------------------------------------ }}}

endif

