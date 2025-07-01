" ====== CUSTOM COMMANDS ======
command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 EslintFix :CocCommand eslint.executeAutofix
command! -nargs=0 OrganizeImports :call CocAction('runCommand', 'editor.action.organizeImport')
