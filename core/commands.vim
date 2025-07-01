" ====== CUSTOM COMMANDS ======
command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 EslintFix :CocCommand eslint.executeAutofix
command! -nargs=0 OrganizeImports :call CocAction('runCommand', 'editor.action.organizeImport')

" C# Commands
command! -nargs=1 DotnetNew :!dotnet new <args>
command! -nargs=0 DotnetBuild :!dotnet build
command! -nargs=0 DotnetRun :!dotnet run
command! -nargs=0 DotnetTest :!dotnet test
command! -nargs=0 DotnetClean :!dotnet clean
command! -nargs=0 DotnetRestore :!dotnet restore

" OmniSharp Commands
command! -nargs=0 OmniSharpRestart :OmniSharpStopServer | :OmniSharpStartServer
command! -nargs=0 OSFormat :OmniSharpCodeFormat
command! -nargs=0 OSRename :OmniSharpRename
