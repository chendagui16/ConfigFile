set sw=4
set iskeyword+=:
map <F6> <ESC>:w<CR><leader>ll<C-o>
call IMAP('SUM','\sum_{<++>}^{<++>} <++>','tex')
call IMAP('IG','\includegraphics[width=<++>\linewidth]{<++>}','tex')
call IMAP('FRAM', "\\begin{frame}\<CR>\\frametitle{<++>}\<CR><++>\<CR>\\end{frame}", 'tex')
