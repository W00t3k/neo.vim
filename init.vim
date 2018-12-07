" Enable syntax highlighting
syntax on


" Use true colors (24 bit/GUI colors)
set termguicolors


" Set color-scheme
colorscheme base16-tomorrow-night


" Auto-reload when file changes
set autoread


" Escape using jk in all modes (insert, visual, terminal)
inoremap jk <esc>
xnoremap jk <esc>
tnoremap jk <c-\><c-n>


" Define file type specific settings
augroup rubyGroup
	autocmd FileType ruby set ts=2 sts=2 sw=2 et
	autocmd FileType eruby set ts=2 sts=2 sw=2 et

	" NOTE: Add abbreviations for `<%%>` and `<%=%>` when working with
	" `*.erb` files you can just type `<%` for `<% %>` and `<%=` for `<%=
	" %>` which is much faster than typing manually.
	autocmd FileType eruby iabbrev <%    <%%><left><left>
	autocmd FileType eruby iabbrev <=    <%=%><left><left>
augroup end

augroup goGroup
	autocmd FileType go set ts=4 sts=4 sw=4 et
	autocmd BufWritePost *.go silent :!goimports -w %
augroup end


" Do smart auto-indenting when starting a new line
set smartindent


" Display a parenthesized file type after file name in status line
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)


" Display tab line
set showtabline=2


" Make tab line look like status line
" NOTE: It only supports base16-tomorrow and base16-tomorrow-night
" color-schemes.
if g:colors_name == 'base16-tomorrow-night'
  hi TabLine term=reverse cterm=reverse ctermfg=12 ctermbg=11 guifg=#b4b7b4 guibg=#373b41
  hi TabLineFill term=reverse cterm=reverse ctermfg=12 ctermbg=11 guifg=#b4b7b4 guibg=#373b41
  hi TablineSel term=NONE cterm=NONE ctermfg=12 ctermbg=bg guifg=11 guibg=bg
endif

if g:colors_name == 'base16-tomorrow'
  hi TabLine term=reverse cterm=reverse ctermfg=12 ctermbg=11 guifg=#969896 guibg=#d6d6d6
  hi TabLineFill term=reverse cterm=reverse ctermfg=12 ctermbg=11 guifg=#969896 guibg=#d6d6d6
  hi TablineSel term=NONE cterm=NONE ctermfg=12 ctermbg=11 guifg=#969896 guibg=bg
endif


" Use comma as <leader>
" NOTE: Which will be used in mapping combinations. For example; `<leader>p`
" translates to `,p` which could be mapped to a function call, command or etc.
let mapleader=","


" Expand %% to current file directory
" NOTE: This makes creating non-existent directories easier. For example; when
" you :e /project/dir1/file and `dir1` doesn't exist you can simply create the
" directory with `:!mkdir %%` instead of typing the full path.
cnoremap <expr> %% expand('%:h').'/'


" Edit files under current file directory
nnoremap <leader>e :edit %%


" Rename current file
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
nnoremap <leader>n :call RenameFile()<cr>


" Use ripgrep as grep program
" NOTE: Makes greppig 💉 (bloody) fast
" FAQ: You have to install ripgrep (`brew install ripgrep`)
set grepprg=rg\ --vimgrep\ --color=never\ --no-heading


" NOTE: Opens a buffer containing the search results in linked form,
" suppresses grep full screen output and prevents jumping to the first match
" automatically
" SEE: https://neovim.io/doc/user/quickfix.html#grep
command! -nargs=+ Rg execute 'silent grep! <args>' | copen


" Search the word under the cursor
nnoremap K :Rg "\b<c-r><c-w>\b"<cr>


" Delete the buffer without losing/closing the window split
" SEE: https://github.com/neovim/neovim/issues/2434
nnoremap <leader>d :setl bufhidden=delete\|bnext<cr>


" Switch between buffers
" SEE: https://vi.stackexchange.com/a/2187
nnoremap <leader>b :ls<cr>:b<space>
