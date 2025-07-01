" ====== C# SPECIFIC SETTINGS ======
" Indentation settings for C#
setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent
setlocal smartindent

" Enable OmniSharp for this buffer
let b:OmniSharp_server_stdio = 1

" C# specific keymaps
nnoremap <buffer> <leader>gd :OmniSharpGotoDefinition<CR>
nnoremap <buffer> <leader>gi :OmniSharpFindImplementations<CR>
nnoremap <buffer> <leader>gf :OmniSharpFindUsages<CR>
nnoremap <buffer> <leader>gr :OmniSharpRename<CR>
nnoremap <buffer> <leader>ca :OmniSharpGetCodeActions<CR>
nnoremap <buffer> <leader>cf :OmniSharpCodeFormat<CR>
nnoremap <buffer> <leader>th :OmniSharpTypeLookup<CR>
nnoremap <buffer> <leader>dc :OmniSharpDocumentation<CR>

" Run and build commands
nnoremap <buffer> <leader>rb :!dotnet build<CR>
nnoremap <buffer> <leader>rr :!dotnet run<CR>
nnoremap <buffer> <leader>rt :!dotnet test<CR>
nnoremap <buffer> <leader>rc :!dotnet clean<CR>

" Navigate errors
nnoremap <buffer> <leader>ne :OmniSharpNavigateUp<CR>
nnoremap <buffer> <leader>pe :OmniSharpNavigateDown<CR>

" Preview definition
nnoremap <buffer> <leader>pd :OmniSharpPreviewDefinition<CR>

" Start OmniSharp server
nnoremap <buffer> <leader>ss :OmniSharpStartServer<CR>
nnoremap <buffer> <leader>sp :OmniSharpStopServer<CR>

" Highlighting
augroup omnisharp_commands
  autocmd!
  " Show type information automatically when cursor stops moving
  autocmd CursorHold *.cs OmniSharpTypeLookup
  
  " Update the highlighting whenever leaving insert mode
  autocmd InsertLeave *.cs OmniSharpHighlightEchoKind
  
  " Automatically start the OmniSharp server when opening a .cs file
  autocmd BufEnter *.cs OmniSharpStartServer
augroup END

" Use Roslyn for better IntelliSense
let g:OmniSharp_server_use_mono = 0

" Set completeopt for better completion experience
setlocal completeopt=longest,menuone,preview,noselect,noinsert

" File templates for new C# files
if line('$') == 1 && getline(1) == ''
  " Basic class template
  let l:filename = expand('%:t:r')
  call append(0, [
    \ 'using System;',
    \ '',
    \ 'namespace ' . substitute(getcwd(), '.*[/\\]', '', '') . '',
    \ '{',
    \ '    public class ' . l:filename,
    \ '    {',
    \ '        public ' . l:filename . '()',
    \ '        {',
    \ '            ',
    \ '        }',
    \ '    }',
    \ '}'
  \ ])
  normal! 9G$
endif
