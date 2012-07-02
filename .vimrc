" Load plugins from .vim/bundles using .vim/autoload/pathogen.vim
call pathogen#runtime_append_all_bundles()

" This is standard pathogen and vim setup
set nocompatible
call pathogen#infect() 

" Color Scheme
colo desert
" Further customization of colors is done with the AfterColors Plugin
" https://github.com/spf13/spf13-vim/blob/3.0/.vimrc 
" hi Pmenu guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
" hi PmenuSbar guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
" hi PmenuThumb guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE
" hi LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

set incsearch
set noeb vb t_vb=

set hidden
set number

" http://vim.wikia.com/wiki/Word_wrap_without_line_breaks 
set wrap
set linebreak
set nolist  " list disables linebreak
set textwidth=0
set wrapmargin=0
set formatoptions+=l

" Enable autoindent, cindent
" http://blogs.gnome.org/johannes/2006/11/10/getting-cool-auto-indent-in-vim/
set cindent
set smartindent
set autoindent

" Popup suggestions for the command buffer.
set wildmenu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Customizing ins-completion / omni completion
" http://vim.wikia.com/wiki/Omni_completion 
" http://vim.wikia.com/wiki/Omni_completion_popup_menu 
" http://vim.wikia.com/wiki/Improve_completion_popup_menu
imap <C-space> <C-p>
filetype plugin indent on
syntax on
set ofu=syntaxcomplete#Complete

inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rempap keys for window navigation
" http://vimcasts.org/episodes/working-with-windows/
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Saved macros - http://stackoverflow.com/questions/2024443/saving-vim-macros
let @c='bgUelguew' " Capitalize first leter and jump to next word.
let @v='"+gp'      " or maybe one day map Ctrl-Shift-P if possible?
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODOs
" http://sartak.org/2011/03/end-of-line-whitespace-in-vim.html
" http://www.faqs.org/docs/Linux-HOWTO/C-editing-with-VIM-HOWTO.html
" http://spf13.com/post/ultimate-vim-config 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://vim.wikia.com/wiki/Restore_screen_size_and_position 

if has("gui_running")
  function! ScreenFilename()
    if has('amiga')
      return "s:.vimsize"
    elseif has('win32')
      return $HOME.'\_vimsize'
    else
      return $HOME.'/.vimsize'
    endif
  endfunction

  function! ScreenRestore()
    " Restore window size (columns and lines) and position
    " from values stored in vimsize file.
    " Must set font first so columns and lines are based on font size.
    let f = ScreenFilename()
    if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      for line in readfile(f)
        let sizepos = split(line)
        if len(sizepos) == 5 && sizepos[0] == vim_instance
          silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
          silent! execute "winpos ".sizepos[3]." ".sizepos[4]
          return
        endif
      endfor
    endif
  endfunction

  function! ScreenSave()
    " Save window size and position.
    if has("gui_running") && g:screen_size_restore_pos
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
            \ (getwinposx()<0?0:getwinposx()) . ' ' .
            \ (getwinposy()<0?0:getwinposy())
      let f = ScreenFilename()
      if filereadable(f)
        let lines = readfile(f)
        call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
        call add(lines, data)
      else
        let lines = [data]
      endif
      call writefile(lines, f)
    endif
  endfunction

  if !exists('g:screen_size_restore_pos')
    let g:screen_size_restore_pos = 1
  endif
  if !exists('g:screen_size_by_vim_instance')
    let g:screen_size_by_vim_instance = 1
  endif
  autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
  autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
endif

" To enable the saving and restoring of screen positions.
let g:screen_size_restore_pos = 1

" To save and restore screen for each Vim instance.
" This is useful if you routinely run more than one Vim instance.
" For all Vim to use the same settings, change this to 0.
let g:screen_size_by_vim_instance = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Generated settings which I will sift through later

if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
nmap gx <Plug>NetrwBrowseX
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
let &cpo=s:cpo_save
unlet s:cpo_save
set background=dark
set backspace=indent,eol,start
set cscopeprg=/usr/bin/cscope
set cscopetag
set cscopeverbose
set fileencodings=utf-8,latin1
set guifont=Inconsolata\ 13
set helplang=en
set history=50
set hlsearch
set mouse=a
set ruler
set shiftwidth=4
set tabstop=4
set termencoding=utf-8
set viminfo='20,\"50
set window=27
" vim: set ft=vim :

