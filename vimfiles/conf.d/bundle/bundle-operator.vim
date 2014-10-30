"--------------------------------------------------
" Vim-Operator
"------------------------------------------------- 
NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-operator-replace'
NeoBundle 'tpope/vim-commentary'                        "コメント切り替えオペレータ
NeoBundle 'tpope/vim-surround'                          "surround記号編集オペレータ
"sort用オtpope/vim-operator-userペレータ
NeoBundle 'emonkak/vim-operator-sort', {                
            \ 'depends' : ['tpope/vim-operator-user']   
            \}
NeoBundle 'pekepeke/vim-operator-tabular', {
            \ 'depends' : ['pekepeke/vim-csvutil'] 
            \}
NeoBundle 'yomi322/vim-operator-suddendeath'            "突然の死ジェネレータ

"NeoBundle 'AndrewRadev/switch.vim'                      "true ⇔ falseなどの切り替え
NeoBundle 'TKNGUE/switch.vim'                      "true ⇔ falseなどの切り替え
let s:hooks = neobundle#get_hooks('switch.vim')
function! s:hooks.on_source(bundle)
    nnoremap - :Switch<CR>
    let g:switch_custom_definitions =
        \ [
        \   ['!=', '=='],
        \   {
        \     '>\(=\)\@!'  : '>=',
        \     '>='  : '<',
        \     '<\(=\)\@!'  : '<=',
        \     '<='  : '>',
        \   },
        \   {
        \     '\<[a-z0-9]\+_\k\+\>': { 
        \       '_\(.\)': '\U\1',
        \       '\<\(.\)': '\U\1'
        \     },
        \     '\<[A-Za-z][a-z0-9]\+[A-Z]\k\+\>': {
        \       '\(\u\)': '_\l\1',
        \       '\<_': ''
        \     },
        \   }
        \ ]
    autocmd FileType python let b:switch_custom_definitions =
        \[
        \   ['and', 'or'],
        \   {
        \     '\(.\+\) if \(.\+\) else \(.\+\)' : { 
        \        '\(\s*\)\(.\+\) = \(.\+\) if \(.\+\) else \(.\+\)' : 
        \             '\1if \4:
        \      }
        \   },
        \]
endfunction
unlet s:hooks


