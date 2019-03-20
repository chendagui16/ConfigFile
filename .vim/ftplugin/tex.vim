set sw=4
set iskeyword+=:
map <F6> <ESC>:w<CR><leader>ll<C-o>
call IMAP('SUM','\sum_{<++>}^{<++>} <++>','tex')
call IMAP('IG','\includegraphics[width=<++>\linewidth]{<++>}','tex')
call IMAP('FRAM', "\\begin{frame}\<CR>\\frametitle{<++>}\<CR><++>\<CR>\\end{frame}", 'tex')
let g:Tex_PromptedCommands = 'footnote,cite,pageref,label,ref'
let g:Tex_Env_figure = "\\begin{figure}[<+htpb+>]\<CR>\\centering\<CR>\\includegraphics[width=<++>\\linewidth]{<+file+>}\<CR>\\caption{\<CR><+Caption text+>\<CR>}\\label{<fig:<+label+>}\<CR>\\end{figure}\<CR><++>"
let g:Tex_EnvLabelprefix_equation = 'eq:'
let g:Tex_EnvLabelprefix_table = 'tab:'
