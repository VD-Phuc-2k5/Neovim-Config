" ====== KEY MAPPINGS ======

" Navigation
nnoremap <silent> <C-p> :Telescope find_files<CR>
nnoremap <leader>ff :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fh :Telescope help_tags<CR>

" Buffer management
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-c> :bdelete<CR>

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Save
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a

" Terminal
nnoremap <silent> <C-t> :FloatermToggle<CR>
tnoremap <silent> <C-t> <C-\><C-n>:FloatermToggle<CR>

" COC keymaps
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>ai <Plug>(coc-codeaction)
nnoremap <silent> <leader>d :call CocActionAsync('diagnosticInfo')<CR>

" COC completion
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-y>"
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confir" C# specific global keymaps

nnoremap <leader>cs :!dotnet new console -n 
nnoremap <leader>cw :!dotnet new web -n 
nnoremap <leader>cm :!dotnet new mvc -n m() : "\<C-g>u\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" NERDTree Configuration
augroup NERDTreeMappings
    autocmd!
    autocmd FileType nerdtree call s:SetupNERDTreeMappings()
augroup END

function! s:SetupNERDTreeMappings()
    " Tạo file mới (a = add file)
    nnoremap <buffer> <silent> a :call <SID>CreateFile()<CR>
    " Tạo thư mục mới (A = add directory)
    nnoremap <buffer> <silent> A :call <SID>CreateDirectory()<CR>
    " Xóa file/thư mục (d = delete)
    nnoremap <buffer> <silent> d :call <SID>DeleteNode()<CR>
    " Đổi tên file/thư mục (r = rename)
    nnoremap <buffer> <silent> r :call <SID>RenameNode()<CR>
    " Sao chép file/thư mục (c = copy)
    nnoremap <buffer> <silent> c :call <SID>CopyNode()<CR>
    " Di chuyển file/thư mục (m = move)
    nnoremap <buffer> <silent> m :call <SID>MoveNode()<CR>
endfunction

" Hàm lấy đường dẫn hiện tại trong NERDTree
function! s:GetCurrentPath()
    let line = getline('.')
    let node = g:NERDTreeFileNode.GetSelected()
    if node == {}
        " Nếu không có node được chọn, sử dụng root
        let current_path = b:NERDTree.root.path.str()
    else
        " Nếu là file, lấy thư mục cha
        if node.path.isDirectory
            let current_path = node.path.str()
        else
            let current_path = node.path.getParent().str()
        endif
    endif
    return current_path
endfunction

" Hàm lấy node hiện tại
function! s:GetSelectedNode()
    let node = g:NERDTreeFileNode.GetSelected()
    if node == {}
        echo "Không có file/thư mục nào được chọn"
        return {}
    endif
    return node
endfunction

" Hàm làm sạch tên file/thư mục (xử lý ký tự đặc biệt)
function! s:SanitizeName(name)
    " Loại bỏ khoảng trắng đầu cuối
    let name = substitute(a:name, '^\s\+\|\s\+$', '', 'g')
    " Không cho phép tên rỗng
    if name == ""
        return ""
    endif
    " Không cho phép các ký tự không hợp lệ trên hệ thống file
    let invalid_chars = '[<>:"|?*]'
    if name =~ invalid_chars
        echo "Tên chứa ký tự không hợp lệ: < > : \" | ? *"
        return ""
    endif
    " Không cho phép tên kết thúc bằng dấu chấm hoặc khoảng trắng (Windows)
    if name =~ '\.$\|\s$'
        echo "Tên không được kết thúc bằng dấu chấm hoặc khoảng trắng"
        return ""
    endif
    return name
endfunction

" Hàm tạo file mới
function! s:CreateFile()
    let current_path = s:GetCurrentPath()
    let filename = input("Tên file mới: ", "")
    let filename = s:SanitizeName(filename)
    if filename == ""
        echo "Hủy tạo file"
        return
    endif

    let full_path = current_path . "/" . filename

    " Kiểm tra file đã tồn tại
    if filereadable(full_path) || isdirectory(full_path)
        echo "File/thư mục đã tồn tại: " . filename
        return
    endif

    try
        " Tạo thư mục cha nếu cần
        let parent_dir = fnamemodify(full_path, ':h')
        if !isdirectory(parent_dir)
            call mkdir(parent_dir, 'p')
        endif

        " Tạo file
        call writefile([], full_path)
        echo "Đã tạo file: " . filename

        " Refresh NERDTree
        call s:RefreshNERDTree()
    catch
        echo "Lỗi khi tạo file: " . v:exception
    endtry
endfunction

" Hàm tạo thư mục mới
function! s:CreateDirectory()
    let current_path = s:GetCurrentPath()
    let dirname = input("Tên thư mục mới: ", "")
    let dirname = s:SanitizeName(dirname)
    if dirname == ""
        echo "Hủy tạo thư mục"
        return
    endif

    let full_path = current_path . "/" . dirname

    " Kiểm tra thư mục đã tồn tại
    if isdirectory(full_path) || filereadable(full_path)
        echo "File/thư mục đã tồn tại: " . dirname
        return
    endif

    try
        call mkdir(full_path, "p")
        echo "Đã tạo thư mục: " . dirname

        " Refresh NERDTree
        call s:RefreshNERDTree()
    catch
        echo "Lỗi khi tạo thư mục: " . v:exception
    endtry
endfunction

" Hàm xóa file/thư mục
function! s:DeleteNode()
    let node = s:GetSelectedNode()
    if node == {}
        return
    endif

    let path = node.path.str()
    let name = node.path.getLastPathComponent(1)

    " Xác nhận xóa
    let choice = input("Bạn có chắc muốn xóa '" . name . "'? (y/N): ")
    if choice !~? '^y'
        echo "Hủy xóa"
        return
    endif

    try
        if node.path.isDirectory
            " Xóa thư mục và nội dung
            call delete(path, 'rf')
            echo "Đã xóa thư mục: " . name
        else
            " Xóa file
            call delete(path)
            echo "Đã xóa file: " . name
        endif

        " Refresh NERDTree
        call s:RefreshNERDTree()
    catch
        echo "Lỗi khi xóa: " . v:exception
    endtry
endfunction

" Hàm đổi tên file/thư mục
function! s:RenameNode()
    let node = s:GetSelectedNode()
    if node == {}
        return
    endif

    let old_path = node.path.str()
    let old_name = node.path.getLastPathComponent(1)
    let parent_path = node.path.getParent().str()

    let new_name = input("Tên mới: ", old_name)
    let new_name = s:SanitizeName(new_name)
    if new_name == "" || new_name == old_name
        echo "Hủy đổi tên"
        return
    endif

    let new_path = parent_path . "/" . new_name

    " Kiểm tra tên mới đã tồn tại
    if filereadable(new_path) || isdirectory(new_path)
        echo "Tên đã tồn tại: " . new_name
        return
    endif

    try
        call rename(old_path, new_path)
        echo "Đã đổi tên: " . old_name . " -> " . new_name

        " Refresh NERDTree
        call s:RefreshNERDTree()
    catch
        echo "Lỗi khi đổi tên: " . v:exception
    endtry
endfunction

" Hàm sao chép file/thư mục
function! s:CopyNode()
    let node = s:GetSelectedNode()
    if node == {}
        return
    endif

    let src_path = node.path.str()
    let src_name = node.path.getLastPathComponent(1)
    let parent_path = node.path.getParent().str()

    let new_name = input("Sao chép thành: ", src_name . "_copy")
    let new_name = s:SanitizeName(new_name)
    if new_name == ""
        echo "Hủy sao chép"
        return
    endif

    let dest_path = parent_path . "/" . new_name

    " Kiểm tra tên đích đã tồn tại
    if filereadable(dest_path) || isdirectory(dest_path)
        echo "Tên đã tồn tại: " . new_name
        return
    endif

    try
        if node.path.isDirectory
            " Sao chép thư mục
            call system('cp -r ' . shellescape(src_path) . ' ' . shellescape(dest_path))
        else
            " Sao chép file
            call system('cp ' . shellescape(src_path) . ' ' . shellescape(dest_path))
        endif

        echo "Đã sao chép: " . src_name . " -> " . new_name

        " Refresh NERDTree
        call s:RefreshNERDTree()
    catch
        echo "Lỗi khi sao chép: " . v:exception
    endtry
endfunction

" Hàm di chuyển file/thư mục
function! s:MoveNode()
    let node = s:GetSelectedNode()
    if node == {}
        return
    endif

    let src_path = node.path.str()
    let src_name = node.path.getLastPathComponent(1)

    let dest_path = input("Di chuyển đến: ", src_path)
    if dest_path == "" || dest_path == src_path
        echo "Hủy di chuyển"
        return
    endif

    " Xử lý đường dẫn đích
    let dest_path = expand(dest_path)

    " Kiểm tra đích đã tồn tại
    if filereadable(dest_path) || isdirectory(dest_path)
        echo "Đích đã tồn tại: " . dest_path
        return
    endif

    try
        " Tạo thư mục cha nếu cần
        let parent_dir = fnamemodify(dest_path, ':h')
        if !isdirectory(parent_dir)
            call mkdir(parent_dir, 'p')
        endif

        call rename(src_path, dest_path)
        echo "Đã di chuyển: " . src_name . " -> " . dest_path

        " Refresh NERDTree
        call s:RefreshNERDTree()
    catch
        echo "Lỗi khi di chuyển: " . v:exception
    endtry
endfunction

" Hàm refresh NERDTree (ĐÃ SỬA)
function! s:RefreshNERDTree()
    if exists('b:NERDTree') && exists('b:NERDTree.root')
        let current_line = line('.')
        let current_col = col('.')
        
        " Refresh toàn bộ cây
        let b:NERDTree.root.refresh()
        call b:NERDTree.render()
        
        " Khôi phục vị trí con trỏ
        call cursor(current_line, current_col)
    endif
endfunction

" NERDTree shortcuts
nnoremap <silent> <F2> :NERDTreeToggle<CR>
nnoremap <silent> <F3> :NERDTreeFind<CR>

" Hiển thị help trong NERDTree
let g:NERDTreeMapHelp = '<F1>'
