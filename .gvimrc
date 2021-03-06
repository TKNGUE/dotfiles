
set visualbell
set t_vb=

" ツールバーを削除
set guioptions-=T

"メニューを削除
set guioptions-=m


if has('win64')
    " Windows用
    set guifont=Ricty:h12.5:cDEFAULT
    " set guifont=Times\ New\ Roman:h12.5
    " set guifont=MS_Mincho:h12:cSHIFTJIS
    " 行間隔の設定
    set linespace=1
    " 一部のUCS文字の幅を自動計測して決める
    if has('kaoriya')
        set ambiwidth=auto
    endif
elseif has('mac')
    set guifont=Osaka－等幅:h12
elseif has('xfontset')
    " UNIX用 (xfontsetを使用)
    set guifontset=a14,r14,k14
elseif has('unix')
     set guifont=Ricty\ 12
endif

"IME関係
if has('multi_byte_ime') || has('xim')
    " 挿入モード・検索モードでのデフォルトのIME状態設定
    set iminsert=2 imsearch=0
    if has('xim') && has('GUI_GTK')
        "    set imactivatekey=C-space
        set imactivatekey=Zenkaku_Hankaku
    endif
    " 挿入モードでのIME状態を記憶させない
    inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif
augroup InsModeAu
    autocmd!
    autocmd InsertEnter,CmdwinEnter * set noimdisable
    autocmd InsertLeave,CmdwinLeave * set imdisable
augroup END
set antialias

