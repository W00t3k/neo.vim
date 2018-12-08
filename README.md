# neo.vim
The Ultimate Nvim Distribution Without Plugins
![screen shot](https://github.com/azbshiri/neo.vim/blob/master/screenshot.png)


# TODO
- [ ] Elixir setup
- [x] Ruby setup
- [x] Go setup
- [x] Delete buffer without losing window
- [x] Switch between buffers
- [x] Rename file
- [x] Search in files
- [x] Search the word under the cursor
- [ ] Fuzzy Finder
  - This snippet doesn't work on Nvim (It works in Vim btw) so I'm working on it, any comments are welcome.
  ```vim
     function! FzyCommand(choice_command, vim_command)
    try
      let output = system(a:choice_command . " | fzy ")
    catch /Vim:Interrupt/
      " Swallow errors from ^C, allow redraw! below
    endtry
    redraw!
    if v:shell_error == 0 && !empty(output)
      exec a:vim_command . ' ' . output
    endif
  endfunction

  nnoremap <leader>p :call FzyCommand("git ls-files --cached --exclude-standard --others", ":e")<cr>
  nnoremap <leader>v :call FzyCommand("git ls-files --cached --exclude-standard --others", ":vne")<cr>
  ```
