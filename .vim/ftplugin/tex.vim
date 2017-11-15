set sw=4
set iskeyword+=:
map <F6> <ESC>:w<CR><leader>ll<C-o>
call IMAP('SUM','\sum_{<++>}^{<++>} <++>','tex')
call IMAP('FRAC','\frac{<++>}{<++>} <++>','tex')
call IMAP('INT','\int_{<++>}^{<++>} <++>','tex')
call IMAP('PROD','\prod_{<++>}^{<++>} <++>','tex')
call IMAP('ST','\qquad \text{s.t. }','tex')
call IMAP('IG','\includegraphics[width=<++>\linewidth]{<++>}','tex')
