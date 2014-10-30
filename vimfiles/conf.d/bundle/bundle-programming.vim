"--------------------------------------------------
" Syntax
"--------------------------------------------------
NeoBundle 'tejr/vim-tmux'
"--------------------------------------------------
" Programming
"--------------------------------------------------
NeoBundle 'thinca/vim-quickrun'
nnoremap <silent> <Leader>r :QuickRun<CR>
nnoremap <silent> <Leader>se :QuickRun sql<CR>
let s:hooks = neobundle#get_hooks("vim-quickrun")
function! s:hooks.on_source(bundle)
    let g:quickrun_config = {
                \ "_": {
                \   "runner"                    : "vimproc",
                \   "runner/vimproc/updatetime" : "60",
                \   "outputter/buffer/split"    : ":bo vsplit"
                \,}}
    let g:quickrun_config.sql ={
                \ 'command' : 'mysql',
                \ 'cmdopt'  : '%{MakeMySQLCommandOptions()}',
                \ 'exec'    : ['%c %o < %s' ] ,
                \}
    let g:quickrun_config['php.unit'] = {
                \ 'command': 'testrunner',
                \ 'cmdopt': 'phpunit'
                \} 
    let g:quickrun_config['python'] = {
                \ 'command': 'python',
                \}
    " let g:quickrun_config['python.unit'] = {i
    "             \ 'command': 'nosetests',
    "             \ 'cmdopt': '-v -s'
    "             \}
    let g:quickrun_config['python.pytest'] = {
                \ 'command': 'py.test',
                \ 'cmdopt': '-v'
                \}
    let g:quickrun_config.markdown  = {
                \ 'type' : 'markdown/pandoc',
                \ 'outputter' : 'browser'
                \ }
    let g:quickrun_config.html  = {
                \ 'command' : 'cygstart',
                \ 'cmdopt'  : '%c %o' ,
                \ 'outputter' : 'browser'
                \ }
    let g:quickrun_config['ruby.rspec']  = {
                \ 'command': 'rspec'
                \ , 'cmdopt': '-f d'
                \ }
    augroup QuickRunUnitTest
        autocmd!
        autocmd BufWinEnter,BufNewFile *test.php setlocal filetype=php.unit
        "autocmd BufWinEnter,BufNewFile test_*.py setlocal filetype=python.unit
        autocmd BufWinEnter,BufNewFile test_*.py setlocal filetype=python.pytest
        autocmd BufWinEnter,BufNewFile *.t setlocal filetype=perl.unit
        autocmd BufWinEnter,BufNewFile *_spec.rb setlocal filetype=ruby.rspec
    augroup END
    function! MakeMySQLCommandOptions()
        if !exists("g:mysql_config_usr")
            let g:mysql_config_user = input("user> ")
        endif
        if !exists("g:mysql_config_host") 
            let g:mysql_config_host = input("host> ")
        endif
        if !exists("g:mysql_config_port")
            let g:mysql_config_port = input("port> ")
        endif
        if !exists("g:mysql_config_pass")
            let g:mysql_config_pass = inputsecret("password> ")
        endif
        if !exists("g:mysql_config_db") 
            let g:mysql_config_db = input("database> ")
        endif

        let optlist = []
        if g:mysql_config_user != ''
            call add(optlist, '-u ' . g:mysql_config_user)
        endif
        if g:mysql_config_host != ''
            call add(optlist, '-h ' . g:mysql_config_host)
        endif
        if g:mysql_config_db != ''
            call add(optlist, '-D ' . g:mysql_config_db)
        endif
        if g:mysql_config_pass != ''
            call add(optlist, '-p' . g:mysql_config_pass)
        endif
        if g:mysql_config_port != ''
            call add(optlist, '-P ' . g:mysql_config_port)
        endif
        if exists("g:mysql_config_otheropts")
            call add(optlist, g:mysql_config_otheropts)
        endif

        return join(optlist, ' ')
    endfunction 
endfunction 


"--------------------------------------------------
" Programming - Python
"--------------------------------------------------
NeoBundleLazy 'alfredodeza/pytest.vim', {
            \ 'autoload'    : {
            \   'filetypes' : ['python', 'python3', 'pytest'],
            \ },
            \ 'build'       : {
            \   "cygwin"    : "pip install --user pytest",
            \   "mac"       : "pip install --user pytest",
            \   "unix"      : "pip install --user pytest"
            \}}
let s:hooks = neobundle#get_hooks("pytest.vim")
function! s:hooks.on_source(bundle)
    nnoremap  <silent><F5>      <Esc>:Pytest file verbose<CR>
    nnoremap  <silent><C-F5>    <Esc>:Pytest class verbose<CR>
    nnoremap  <silent><S-F5>  <Esc>:Pytest project verbose<CR>
    nnoremap  <silent><F6>      <Esc>:Pytest session<CR>
endfunction

NeoBundleLazy 'voithos/vim-python-matchit', {
            \ "autoload"    : {
            \   "filetypes" : ["python", "python3", "djangohtml"]
            \ }}

" NeoBundleLazy 'davidhalter/jedi-vim', {
"             \ "autoload"    : {
"             \   "filetypes" : ["python", "python3", "djangohtml"],
"             \ },
"             \ "build"       : {
"             \   "cygwin"    : "pip install --user jedi",
"             \   "mac"       : "pip install --user jedi",
"             \   "unix"      : "pip install --user jedi"
"             \ }}

" let g:jedi#auto_vim_configuration = 0
" let s:hooks = neobundle#get_hooks("jedi-vim")
" function! s:hooks.on_source(bundle)
"     " 自動設定機能をoffにし手動で設定を行う
"     let g:jedi#auto_vim_configuration = 0

"     let g:jedi#popup_on_dot = 1
"     let g:jedi#popup_select_first = 1
"     "quickrunと被るため大文字に変更
"     let g:jedi#rename_command = '<Leader>R'
"     let g:jedi#auto_close_doc = 0
"     let g:jedi#use_tabs_not_buffers = 0
"     let g:jedi#completions_enabled = 0
" endfunction


NeoBundleLazy 'klen/python-mode', {
             \ "autoload"    : {
             \   "filetypes" : ["python", "python3", "djangohtml"],
             \ },
             \ "build"       : {
             \   "cygwin"    : "pip install --user pylint rope pyflake pep8",
             \   "mac"       : "pip install --user pylint rope pyflake pep8",
             \   "unix"      : "pip install --user pylint rope pyflake pep8"
             \ }}

let s:hooks = neobundle#get_hooks("python-mode")
function! s:hooks.on_source(bundle)
    let g:pymode_options = 1
    " let g:pymode_python = 'python'
    let g:pymode_quickfix_minheight = 3
    let g:pymode_quickfix_maxheight = 6

    " let g:pymode_indent = []

    let g:pymode_folding = 1

    let g:pymode_run = 1            "融通が利かないのでオフ
    let g:pymode_breakpoint = 1
    let g:pymode_breakpoint_bind = '<leader>b'

    let g:pymode_rope_completion_bind = '<C-N>'
    let g:pymode_rope_autoimport = 1
    " let g:pymode_rope_autoimport_modules = ['os', 'shutil', 'datetime'])
    let g:pymode_rope_autoimport_import_after_complete = 0

    "Find definition
    let g:pymode_rope_goto_definition_rind = 'gd'

    " let g:pymode_rope_rename_bind = 'rr'
    " let g:pymode_rope_rename_module_bind = '<C-c>r1r'
    nnoremap <silent><F8> :<C-u>PymodeLintAuto<CR>
endfunction


NeoBundle 'nvie/vim-flake8', { 
            \ "autoload"    : {
            \   "filetypes" : ["python", "python3", "djangohtml"],
            \ },
            \ "build"       : {
            \   "cygwin"    : "pip install --user flake8",
            \   "mac"       : "pip install --user flake8",
            \   "unix"      : "pip install --user flake8",
            \ }} 
" autocmd BufWritePost *.py call Flake8()
" let g:flake8_quickfix_location="botright"

" NeoBundleLazy 'tell-k/vim-autopep8', { 
"             \ "autoload"    : {
"             \   "filetypes" : ["python", "python3", "djangohtml"],
"             \ },
"             \ "build"       : {
"             \   "cygwin"    : "pip install --user autopep8",
"             \   "mac"       : "pip install --user autopep8",
"             \   "unix"      : "pip install --user autopep8",
"             \ }}

let s:hooks = neobundle#get_hooks("tell-k/vim-autopep8")
function! s:hooks.on_source(bundle) 
endfunction

"--------------------------------------------------
" Programming - Web(HTML, CSS, Javascript, json)
"--------------------------------------------------
NeoBundleLazy 'mattn/emmet-vim', { 
            \ "autoload"    : {
            \   "filetypes" : ['html', 'css'],
            \ },}
let s:hooks = neobundle#get_hooks("emmet-vim")
function! s:hooks.on_source(bundle) 
    let g:user_emmet_leader_key = '<C-Y>'
endfunction

NeoBundleLazy 'vim-scripts/css_color.vim', { 
            \ "autoload"    : {
            \   "filetypes" : ['html','css'],
            \ },}

NeoBundleLazy 'hail2u/vim-css3-syntax', { 
            \ "autoload"    : {
            \   "filetypes" : ['css'],
            \ },}

NeoBundleLazy 'othree/html5.vim', { 
            \ "autoload"    : {
            \   "filetypes" : ['html', 'svg', 'rdf'],
            \ },}

NeoBundleLazy 'elzr/vim-json', { 
            \ "autoload"    : {
            \   "filetypes" : ['json'],
            \ },}
function! s:hooks.on_source(bundle) 
    let g:vim_json_syntax_conceal = 2
endfunction
"--------------------------------------------------
" Programming - Ruby
"--------------------------------------------------
NeoBundleLazy 'vim-ruby/vim-ruby', { 
            \ "autoload"    : {
            \   "filetypes" : ["ruby"],
            \ },}

"--------------------------------------------------
" Programming - LaTex
"--------------------------------------------------
NeoBundleLazy 'jcf/vim-latex', {
            \ "autoload": {
            \   "filetypes": ["tex"],
            \ }}
let g:tex_flavor = 'platex'
let s:hooks = neobundle#get_hooks("vim-latex")
function! s:hooks.on_source(bundle)
    set shellslash
    set grepprg=grep\ -nH\ $*
    let g:Imap_UsePlaceHolders = 1
    let g:Imap_DeleteEmptyPlaceHolders = 1
    let g:Imap_StickyPlaceHolders = 0
    let g:Tex_DefaultTargetFormat = 'pdf'
    let g:Tex_FormatDependency_ps = 'dvi,ps'
    let g:Tex_CompileRule_pdf = 'ptex2pdf -l -ot -kanji=utf8 -no-guess-input-enc -synctex=0 -interaction=nonstopmode -file-line-error-style $*' 
    let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
    let g:Tex_BibtexFlavor = 'pbibtex -kanji=utf-8 $*'
    let g:Tex_MakeIndexFlavor = 'mendex -U $*.idx'
    let g:Tex_ViewRule_pdf = 'evince'

    "キー配置の変更
    ""<Ctrl + J>はパネルの移動と被るので番うのに変える
    imap <C-n> <Plug>IMAP_JumpForward
    nmap <C-n> <Plug>IMAP_JumpForward
    vmap <C-n> <Plug>IMAP_DeleteAndJumpForward 
endfunction


"--------------------------------------------------
" Programming - markdown
"--------------------------------------------------
NeoBundleLazy 'Rykka/riv.vim' ,{
            \ 'autoload'  :{
            \   'filetypes' :
            \      ['python', 'rst']
            \}}

NeoBundle 'plasticboy/vim-markdown'
let g:markdown_fenced_languages = ['vim', 'python', 'ruby', 'javascript']
let g:markdown_folding = 1

NeoBundle 'TKNGUE/hateblo.vim' ,{
            \ 'depends'  : ['mattn/webapi-vim', 'Shoug/unite.vim'],
            \}
let g:hateblo_config_path = '$HOME/.hateblo/.hateblo.vim'
let g:hateblo_dir = '$HOME/.hateblo/blog'

NeoBundleLazy 'TKNGUE/vim-reveal',{  
            \ "autoload"    : {
            \   "filetypes" : ['markdown'],  
            \},
            \}
let s:hooks = neobundle#get_hooks("vim-reveal")
function! s:hooks.on_source(bundle) 
    let g:reveal_root_path = '$HOME/work/reveal.js'
    let g:revel_default_config = {
                \ 'fname'  : 'reveal',
                \ 'key1'  : 'reveal'
                \ }
endfunction

NeoBundleLazy 'kannokanno/previm',{  
            \ "autoload"    : {
            \   "filetypes" : ['markdown'],  
            \ },
            \ "build"       : {
            \   "cygwin"    : "pip install --user docutils",
            \   "mac"       : "pip install --user docutils",
            \   "unix"      : "pip install --user docutils"
            \}}

NeoBundle 'clones/vim-zsh'