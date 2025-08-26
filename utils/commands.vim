" ====== commands.vim ======
command! -nargs=0 ManualPrettier silent! call CocAction('runCommand', 'prettier.formatFile')
command! -nargs=0 ManualEslintFix silent! call CocAction('runCommand', 'eslint.executeAutofix')
command! -nargs=0 ManualOrganizeImports silent! call CocAction('runCommand', 'editor.action.organizeImport')

" Dotnet commands
command! -nargs=1 DotnetNew execute '!dotnet new ' . <q-args>
command! -nargs=0 DotnetBuild !dotnet build
command! -nargs=0 DotnetRun !dotnet run
command! -nargs=0 DotnetTest !dotnet test

" Git commands
command! GitStatus vertical Git status
command! GitLog vertical Git log --oneline
command! GitDiff vertical Git diff

" Error suppression and optimization
set shortmess+=c
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0
