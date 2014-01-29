"release autogroup in MyAutoCmd
augroup MyAutoCmd
	autocmd!
augroup END

"####表示設定#####
set title 							"編集中のファイル名を表示
set showmatch 					"括弧入力時の対応する括弧を表示
syntax on 							"コードの色分け
set tabstop=4 					"インデントをスペース4つ分に設定
set shiftwidth=4				"オートインデントの幅
set smartindent 				"オートインデント
set list                " 不可視文字の可視化
set number              " 行番号の表示
set wrap                " 長いテキストの折り返し
set textwidth=0         " 自動的に改行が入るのを無効化
set colorcolumn=80      " その代わり80文字目にラインを入れる
set encoding=utf8
set nocompatible

" 前時代的スクリーンベルを無効化
set t_vb=4
set novisualbell

" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

"#####検索設定#####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
set incsearch           " インクリメンタルサーチ
set hlsearch            " 検索マッチテキストをハイライト (2013-07-03 14:30 修正）

"バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

"####　編集関係 #####
set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする


" TODO用のコマンド
command! Todo call s:Todo()
au BufNewFile,BufRead .todo set filetype=markdown
function! s:Todo()
	let l:path  =  '~/.todo'   
	if filereadable("~/Dropbox/.todo")
	   let l:path = "~/Dropbox/.todo"
	endif
	if bufwinnr(l:path) < 0
		execute 'silent bo 40vs +set\ nonumber ' . l:path 
	endif	
	unlet! l:path
 endfunction




 " .vimrc設定編集反映用
 nnoremap <silent> <Space>ev  :<C-u>edit $MYVIMRC<CR>
 nnoremap <silent> <Space>eg  :<C-u>edit $MYGVIMRC<CR> 
 " Load .gvimrc after .vimrc edited at GVim.
 nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC \| if has('gui_running')
	 " \| source $MYGVIMRC \| endif <CR>
	 nnoremap <silent> <Space>rg :<C-u>source $MYGVIMRC<CR>

	 " Set augroup.  
	 if !has('gui_running') && !(has('win32') || has('win64'))
		 " .vimrcの再読込時にも色が変化するようにする
		 autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
	 else
		 " .vimrcの再読込時にも色が変化するようにする
		 autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC | 
					 \if has('gui_running') | source $MYGVIMRC  
		 autocmd MyAutoCmd BufWritePost $MYGVIMRC if has('gui_running') | source $MYGVIMRC
	 endif

	 " ftplugin設定編集反映用
	 let g:ftpPath = $HOME . "/.vim/after/ftplugin/" 
	 nnoremap <silent>  <Space>ef :<C-u>call <SID>openFTPluginFile()<CR>
	 function! s:openFTPluginFile()
		 let l:ftpFileName = g:ftpPath . &filetype . ".vim"
		 edit `=l:ftpFileName`
	 endfunction 

	 " 対応括弧に'<'と'>'のペアを追加
	 set matchpairs& matchpairs+=<:>

	 " バックスペースでなんでも消せるようにする
	 set backspace=indent,eol,start
	 

	 " クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
	 " 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
	 if has('unnamedplus')
		 " set clipboard& clipboard+=unnamedplus " 2013-07-03 14:30 unnamed 追加
		 set clipboard& clipboard+=unnamedplus,unnamed 
	 else
		 " set clipboard& clipboard+=unnamed,autoselect 2013-06-24 10:00 autoselect 削除
		 set clipboard& clipboard+=unnamed
	 endif

	 " Swapファイル？Backupファイル？前時代的すぎ
	 " なので全て無効化する
	 set nowritebackup
	 set nobackup
	 set noswapfile


	 "素早くjj と押すことでESCとみなす
	 inoremap jj <Esc>
	 nnoremap ; :
	 nnoremap : ;

	 " ESCを二回押すことでハイライトを消す
     nnoremap <silent> <Esc><Esc>	:noh<CR>
      
	 " カーソル下の単語を * で検索
	 vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

	 " 検索後にジャンプした際に検索単語を画面中央に持ってくる
	 nnoremap n nzz
	 nnoremap N Nzz
	 nnoremap * *zz
	 nnoremap # #zz
	 nnoremap g* g*zz
	 nnoremap g# g#zz    

	 " j, k による移動を折り返されたテキストでも自然に振る舞うように変更
	 nnoremap j gj
	 nnoremap k gk

	 " vを二回で行末まで選択
	 vnoremap v $h

	 " TABにて対応ペアにジャンプ
	 nnoremap <Tab> %
	 vnoremap <Tab> %

	 " Ctrl + hjkl でウィンドウ間を移動
	 nnoremap <C-h> <C-w>h
	 nnoremap <C-j> <C-w>j
	 nnoremap <C-k> <C-w>k
	 nnoremap <C-l> <C-w>l

	 " Shift + 矢印でウィンドウサイズを変更
	 nnoremap <S-Left>  <C-w><<CR>
	 nnoremap <S-Right> <C-w>><CR>
	 nnoremap <S-Up>    <C-w>-<CR>
	 nnoremap <S-Down>  <C-w>+<CR>

	 " T + ? で各種設定をトグル
	 nnoremap [toggle] <Nop>
	 nmap T [toggle]
	 nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
	 nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
	 nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
	 nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>


	 " make, grep などのコマンド後に自動的にQuickFixを開く
	 autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

	 " QuickFixおよびHelpでは q でバッファを閉じる
	 autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

	 " w!! でスーパーユーザーとして保存（sudoが使える環境限定）
	 cmap w!! w !sudo tee > /dev/null %

	 " :e などでファイルを開く際にフォルダが存在しない場合は自動作成
	 function! s:mkdir(dir, force)
		 if !isdirectory(a:dir) && (a:force ||
					 \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
			 call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
		 endif
	 endfunction

	 autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)
	 " vim 起動時のみカレントディレクトリを開いたファイルの親ディレクトリに指定
	 autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')
	 function! s:ChangeCurrentDir(directory, bang)
		 if a:directory == ''
			 lcd %:p:h
		 else
			 execute 'lcd' . a:directory
		 endif
		 if a:bang == ''
			 pwd
		 endif
	 endfunction
	 " ~/.vimrc.localが存在する場合のみ設定を読み込む
	 let s:local_vimrc = expand('~/.vimrc.local')
	 if filereadable(s:local_vimrc)
		 execute 'source ' . s:local_vimrc
	 endif

	 "##### Plug-in #######
	 let s:noplugin = 0
	 let s:bundle_root = expand('~/.vim/bundle')
	 let s:neobundle_root = s:bundle_root . '/neobundle.vim'


	 if (!isdirectory(s:neobundle_root) || v:version < 702 )
		 " NeoBundleが存在しない、もしくはVimのバージョンが古い場合はプラグインを一切
		 " 読み込まない
		 let s:noplugin = 1
	 else
		 "###################### NeoBundle Configuration###########################"
		 " NeoBundleを'runtimepath'に追加し初期化を行う
		 if has('vim_starting')
			 execute "set runtimepath+=" . s:neobundle_root
		 endif
		 call neobundle#rc(s:bundle_root)

		 " NeoBundle自身をNeoBundleで管理させる
		 NeoBundleFetch 'Shougo/neobundle.vim'

		 " 非同期通信を可能にする
		 " 'build'が指定されているのでインストール時に自動的に
		 " 指定されたコマンドが実行され vimproc がコンパイルされる
		 NeoBundle "Shougo/vimproc.vim", {
					 \ "build": {
					 \   "windows"   : "make -f make_mingw32.mak",
					 \   "cygwin"    : "make -f make_cygwin.mak",
					 \   "mac"       : "make -f make_mac.mak",
					 \   "unix"      : "make -f make_unix.mak",
					 \ }}

		 " カラースキーム一覧表示に Unite.vim を使う
		 NeoBundle 'Shougo/unite.vim'
		 
		 " カラースキーム
		 NeoBundle 'ujihisa/unite-colorscheme'

		 NeoBundle 'nanotech/jellybeans.vim'
		 NeoBundle 'vim-scripts/Lucius'
		 NeoBundle 'vim-scripts/Zenburn'
		 NeoBundle 'mrkn/mrkn256.vim'
		 NeoBundle 'jpo/vim-railscasts-theme' 
		 NeoBundle 'tomasr/molokai'
		 NeoBundle 'vim-scripts/Wombat'
         
         
         " ステータスバー
		 NeoBundle 'itchyny/lightline.vim'

 		 let g:lightline = {
					 \ 'colorscheme': 'wombat',
					 \ 'mode_map': {'c': 'NORMAL'},
					 \ 'active': {
					 \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
					 \ },
					 \ 'component_function': {
					 \   'modified': 'MyModified',
					 \   'readonly': 'MyReadonly',
					 \   'fugitive': 'MyFugitive',
					 \   'filename': 'MyFilename',
					 \   'fileformat': 'MyFileformat',
					 \   'filetype': 'MyFiletype',
					 \   'fileencoding': 'MyFileencoding',
					 \   'mode': 'MyMode'
					 \ }
					 \ }

		 function! MyModified()
			 return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
		 endfunction

		 function! MyReadonly()
			 return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
		 endfunction

		 function! MyFilename()
			 return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
						 \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
						 \  &ft == 'unite' ? unite#get_status_string() :
						 \  &ft == 'vimshell' ? vimshell#get_status_string() :
						 \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
						 \ ('' != MyModified() ? ' ' . MyModified() : '')
		 endfunction

		 function! MyFugitive()
			 try
				 if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
					 return fugitive#head()
				 endif
			 catch
			 endtry
			 return ''
		 endfunction

		 function! MyFileformat()
			 return winwidth(0) > 70 ? &fileformat : ''
		 endfunction

		 function! MyFiletype()
			 return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
		 endfunction

		 function! MyFileencoding()
			 return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
		 endfunction

		 function! MyMode()
			 return winwidth(0) > 60 ? lightline#mode() : ''
		 endfunction


		 NeoBundleLazy "Shougo/vimfiler.vim", {
					 \ "depends": ["Shougo/unite.vim"],          
					 \ "autoload": {
					 \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
					 \   "mappings": ['<Plug>(vimfiler_switch)'],
					 \   "explorer": 1,
					 \ }} 
		 nnoremap <Leader>e :VimFilerExplorer<CR>
		 " close vimfiler automatically when there are only vimfiler open
		 autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
		 let s:hooks = neobundle#get_hooks("vimfiler.vim")
		 function! s:hooks.on_source(bundle)
			 let g:vimfiler_as_default_explorer = 1
			 let g:vimfiler_enable_auto_cd = 1
			 " 2013-08-14 追記
			 let g:vimfiler_ignore_pattern = "\%(^\..*\|\.pyc$\)"
			 " vimfiler specific key mappings
			 autocmd MyAutoCmd FileType vimfiler call <SID>vimfiler_settings()
			 function! s:vimfiler_settings()
				 " ^^ to go up 
				 nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
				 " use R to refresh
				 nmap <buffer> R <Plug>(vimfiler_redraw_screen)
				 " overwrite C-l
				 nmap <buffer> <C-l> <C-w>l
			 endfunction
		 endfunction
 		 

		 "エディタ関係の便利ツール
		 NeoBundle 'tpope/vim-surround'
		 NeoBundle 'vim-scripts/Align'
		 NeoBundle 'vim-scripts/YankRing.vim'
		 NeoBundle 'tpope/vim-fugitive' 

		 NeoBundleLazy "rcmdnk/vim-markdown", {
					 \ "autoload": {
					 \   "filetypes" : ["markdown"] 
					 \}}
		 let s:hooks = neobundle#get_hooks("vim-markdown")
		 function! s:hooks.on_source(bundle)
		 endfunction

		 NeoBundleLazy "vim-scripts/TaskList.vim", {
					 \ "autoload": {
					 \   "mappings": ['<Plug>TaskList'],
					 \}}
		 let s:hooks = neobundle#get_hooks("Tasklist.vim")
		 function! s:hooks.on_source(bundle)
			 nmap <Leader>T <plug>TaskList
		 endfunction

		 "プログラミング関係の便利ツール
		 NeoBundleLazy "davidhalter/jedi-vim", {
					 \'rev':'3934359',
					 \ "autoload": {
					 \   "filetypes": ["python", "python3", "djangohtml"],
					 \ },
					 \ "build": {
					 \   "mac": "pip install jedi",
					 \   "unix": "pip install jedi",
					 \ }}
		 let s:hooks = neobundle#get_hooks("jedi-vim")
		 function! s:hooks.on_source(bundle)
			 " jediにvimの設定を任せると'completeopt+=preview'するので
			 " 自動設定機能をOFFにし手動で設定を行う
			 let g:jedi#auto_vim_configuration = 0

			 "補完の最初の項目が選択された状態だと使いにくいためオフにする
			 let g:jedi#popup_on_dot = 1
			 let g:jedi#popup_select_first = 0
			 "quickrunと被るため大文字に変更
			 let g:jedi#rename_command = '<Leader>R'
			 " gundoと被るため大文字に変更 (2013-06-2410:00 追記）
			 let g:jedi#goto_assignments_command = '<Leader>G'
		 endfunction

		 "#############日本語 文書作成向けプラグイン############### 
		 "WORD移動用文書区切り用
		 NeoBundle "deton/jasegment.vim" 
		 "`
		 NeoBundleLazy "kana/vim-smartchr", { 
					 \ "autoload": {
					 \   "filetypes": ["tex"],
					 \ } 
					 \ }
		 NeoBundle 'Shougo/neocomplcache.vim'

		 let s:hooks = neobundle#get_hooks('neosnippet')
		 function! s:hooks.on_source(bundle)
			 " Disable AutoComplPop.
			 let g:acp_enableAtStartup = 0
			 " Use neocomplcache.
			 let g:neocomplcache_enable_at_startup = 1
			 " Use smartcase.
			 let g:neocomplcache_enable_smart_case = 1
			 " Set minimum syntax keyword length.
			 let g:neocomplcache_min_syntax_length = 3
			 let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

			 " Define dictionary.
			 let g:neocomplcache_dictionary_filetype_lists = {
						 \ 'default' : ''
						 \ }

			 " Plugin key-mappings.
			 inoremap <expr><C-g>     neocomplcache#undo_completion()
			 inoremap <expr><C-l>     neocomplcache#complete_common_string()

			 " Recommended key-mappings.
			 " <CR>: close popup and save indent.
			 inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
			 function! s:my_cr_function()
				 return neocomplcache#smart_close_popup() . "\<CR>"
			 endfunction
			 " <TAB>: completion.
			 inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
			 " <C-h>, <BS>: close popup and delete backword char.
			 inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
			 inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
			 inoremap <expr><C-y>  neocomplcache#close_popup()
			 inoremap <expr><C-e>  neocomplcache#cancel_popup()
		 endfunction

		 NeoBundle 'Shougo/neosnippet'
		 NeoBundle 'Shougo/neosnippet-snippets'
		 let s:hooks = neobundle#get_hooks('neosnippet')
		 function! s:hooks.on_source(bundle)
			 " Plugin key-mappings.
			 imap <C-k>     <Plug>(neosnippet_expand_or_jump)
			 smap <C-k>     <Plug>(neosnippet_expand_or_jump)
			 xmap <C-k>     <Plug>(neosnippet_expand_target)

			 " SuperTab like snippets behavior.
			 imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
						 \ "\<Plug>(neosnippet_expand_or_jump)"
						 \: pumvisible() ? "\<C-n>" : "\<TAB>"
			 smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
						 \ "\<Plug>(neosnippet_expand_or_jump)"
						 \: "\<TAB>"

			 " For snippet_complete marker.
			 if has('conceal')
				 set conceallevel=2 concealcursor=i
			 endif
		 endfunction

		 NeoBundleLazy "jcf/vim-latex", {
					 \ "autoload": {
					 \   "filetypes": ["tex"],
					 \ }}
		 let s:hooks = neobundle#get_hooks("vim-latex")
		 function! s:hooks.on_source(bundle)
			 set shellslash
			 set grepprg=grep\ -nH\ $*
			 let g:tex_flavor='platex'
			 let g:Imap_UsePlaceHolders = 1
			 let g:Imap_DeleteEmptyPlaceHolders = 1
			 let g:Imap_StickyPlaceHolders = 0
			 let g:Tex_DefaultTargetFormat = 'pdf'
			 let g:Tex_FormatDependency_ps = 'dvi,ps'
			 let g:Tex_CompileRule_pdf = 'ptex2pdf -l -ot -kanji=utf8 -no-guess-input-enc -synctex=0 -interaction=nonstopmode -file-line-error-style $*' 
			 let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
			 let g:Tex_BibtexFlavor = 'pbibtex -kanji=utf-8 $*'
			 let g:Tex_MakeIndexFlavor = 'mendex -U $*.idx'
			 let g:Tex_ViewRule_pdf = 'texworks'

			 "キー配置の変更
			 ""<Ctrl + J>はパネルの移動と被るので番うのに変える
			 imap <C-n> <Plug>IMAP_JumpForward
			 nmap <C-n> <Plug>IMAP_JumpForward
			 vmap <C-n> <Plug>IMAP_DeleteAndJumpForward 
		 endfunction

		 " インストールされていないプラグインのチェックおよびダウンロード
		 NeoBundleCheck
		 colorscheme molokai 
	 endif

	 " ファイルタイププラグインおよびインデントを有効化
	 " これはNeoBundleによる処理が終了したあとに呼ばなければならない
	 filetype plugin indent on


