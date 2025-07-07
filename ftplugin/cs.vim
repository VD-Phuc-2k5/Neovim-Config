" ====== C# MVC SPECIFIC SETTINGS ======
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

" MVC specific run and build commands
nnoremap <buffer> <leader>rb :!dotnet build<CR>
nnoremap <buffer> <leader>rr :!dotnet run<CR>
nnoremap <buffer> <leader>rt :!dotnet test<CR>
nnoremap <buffer> <leader>rc :!dotnet clean<CR>
nnoremap <buffer> <leader>rw :!dotnet watch run<CR>
nnoremap <buffer> <leader>rf :!dotnet run --launch-profile https<CR>
nnoremap <buffer> <leader>rd :!dotnet run --environment Development<CR>
nnoremap <buffer> <leader>rp :!dotnet run --environment Production<CR>

" Package management
nnoremap <buffer> <leader>pa :!dotnet add package 
nnoremap <buffer> <leader>pr :!dotnet remove package 
nnoremap <buffer> <leader>pl :!dotnet list package<CR>
nnoremap <buffer> <leader>pu :!dotnet restore<CR>

" Database commands (Entity Framework)
nnoremap <buffer> <leader>db :!dotnet ef database update<CR>
nnoremap <buffer> <leader>dm :!dotnet ef migrations add 
nnoremap <buffer> <leader>dr :!dotnet ef migrations remove<CR>
nnoremap <buffer> <leader>dl :!dotnet ef migrations list<CR>
nnoremap <buffer> <leader>ds :!dotnet ef database drop<CR>

" Navigate errors
nnoremap <buffer> <leader>ne :OmniSharpNavigateUp<CR>
nnoremap <buffer> <leader>pe :OmniSharpNavigateDown<CR>

" Preview definition
nnoremap <buffer> <leader>pd :OmniSharpPreviewDefinition<CR>

" Start/Stop OmniSharp server
nnoremap <buffer> <leader>ss :OmniSharpStartServer<CR>
nnoremap <buffer> <leader>sp :OmniSharpStopServer<CR>

" File navigation helpers for MVC structure
nnoremap <buffer> <leader>fc :e Controllers/<CR>
nnoremap <buffer> <leader>fv :e Views/<CR>
nnoremap <buffer> <leader>fm :e Models/<CR>
nnoremap <buffer> <leader>fw :e wwwroot/<CR>
nnoremap <buffer> <leader>fa :e Areas/<CR>

" Quick file creation for MVC components
nnoremap <buffer> <leader>nc :!echo "Creating new controller..." && touch Controllers/.cs<Left><Left><Left>
nnoremap <buffer> <leader>nm :!echo "Creating new model..." && touch Models/.cs<Left><Left><Left>
nnoremap <buffer> <leader>nv :!echo "Creating new view..." && mkdir -p Views/ && touch Views/.cshtml<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" Highlighting and auto-commands
augroup omnisharp_commands
  autocmd!
  " Show type information automatically when cursor stops moving
  autocmd CursorHold *.cs OmniSharpTypeLookup
  
  " Update the highlighting whenever leaving insert mode
  autocmd InsertLeave *.cs OmniSharpHighlightEchoKind
  
  " Automatically start the OmniSharp server when opening a .cs file
  autocmd BufEnter *.cs OmniSharpStartServer
  
  " Auto-format on save
  autocmd BufWritePre *.cs OmniSharpCodeFormat
augroup END

" Use Roslyn for better IntelliSense
let g:OmniSharp_server_use_mono = 0

" Set completeopt for better completion experience
setlocal completeopt=longest,menuone,preview,noselect,noinsert

" Enable popup menu for completion
set pumheight=10

" File templates for new C# files
if line('$') == 1 && getline(1) == ''
  let l:filename = expand('%:t:r')
  let l:filepath = expand('%:p')
  
  " Controller template
  if l:filepath =~ 'Controllers'
    call append(0, [
      \ 'using Microsoft.AspNetCore.Mvc;',
      \ '',
      \ 'namespace ' . substitute(getcwd(), '.*[/\\]', '', '') . '.Controllers',
      \ '{',
      \ '    public class ' . l:filename . ' : Controller',
      \ '    {',
      \ '        public IActionResult Index()',
      \ '        {',
      \ '            return View();',
      \ '        }',
      \ '    }',
      \ '}'
    \ ])
    normal! 7G$
    
  " Model template
  elseif l:filepath =~ 'Models'
    call append(0, [
      \ 'using System.ComponentModel.DataAnnotations;',
      \ '',
      \ 'namespace ' . substitute(getcwd(), '.*[/\\]', '', '') . '.Models',
      \ '{',
      \ '    public class ' . l:filename,
      \ '    {',
      \ '        public int Id { get; set; }',
      \ '        ',
      \ '    }',
      \ '}'
    \ ])
    normal! 8G$
    
  " Service template
  elseif l:filepath =~ 'Services'
    call append(0, [
      \ 'using System.Threading.Tasks;',
      \ '',
      \ 'namespace ' . substitute(getcwd(), '.*[/\\]', '', '') . '.Services',
      \ '{',
      \ '    public interface I' . l:filename,
      \ '    {',
      \ '        ',
      \ '    }',
      \ '',
      \ '    public class ' . l:filename . ' : I' . l:filename,
      \ '    {',
      \ '        ',
      \ '    }',
      \ '}'
    \ ])
    normal! 7G$
    
  " Default class template
  else
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
endif

" Additional MVC-specific settings
" Set path for 'gf' command to work with MVC structure
set path+=Controllers,Models,Views,Services,Data

" Custom syntax highlighting for Razor files
augroup razor_files
  autocmd!
  autocmd BufNewFile,BufRead *.cshtml set filetype=html
  autocmd BufNewFile,BufRead *.cshtml setlocal commentstring=@*\ %s\ *@
augroup END

" Snippets for common MVC patterns (if using a snippet plugin)
" Add these to your snippet configuration
" Controller Action: 'action' -> public IActionResult ActionName() { return View(); }
" View Model: 'vm' -> public class ViewModel { }
" Entity: 'entity' -> public class Entity { public int Id { get; set; } }

" Status line enhancement for MVC projects
function! GetMvcContext()
  let l:filepath = expand('%:p')
  if l:filepath =~ 'Controllers'
    return '[Controller]'
  elseif l:filepath =~ 'Models'
    return '[Model]'
  elseif l:filepath =~ 'Views'
    return '[View]'
  elseif l:filepath =~ 'Services'
    return '[Service]'
  else
    return '[C#]'
  endif
endfunction

" Add MVC context to statusline
set statusline+=%{GetMvcContext()}