if exists('g:loaded_streamline_plugin')
    finish
endif
let g:loaded_streamline_plugin = 1

set laststatus=2
set statusline=%!CreateStatusline()
augroup status
    autocmd!
    autocmd WinEnter * setlocal statusline=%!CreateStatusline()
    autocmd WinLeave * setlocal statusline=%!CreateInactiveStatusline()
augroup END

hi WarningColor guibg=#E5C07B guifg=#1E1E1E ctermbg=Yellow ctermfg=White
hi ErrorColor guibg=#DF6A63 guifg=#1E1E1E ctermbg=Red ctermfg=White

function! CreateStatusline()
    let statusline=''
    let statusline.='%#Search#'
    let statusline.=' %{GetMode()} '
    let statusline.='%#diffadd#'
    let statusline.='%{GitBranch()}'
    let statusline.='%#CursorlineNr#'
    let statusline.=' %f'                  " Show filename
    let statusline.=' %m'                  " Show modified tag
    let statusline.='%='                   " Switch elements to the right
    let statusline.='%#StatuslineNC#'
    if !get(g:, 'streamline_minimal_ui', 0)
        let statusline.='▏%y'              " Show filetype
        let statusline.=' %{&fileencoding?&fileencoding:&encoding}'
        let statusline.='[%{&fileformat}] '
        let statusline.='%#TermCursor#'
    endif
    let statusline.='▏☰ %l:%c'             " Show line number and column
    let statusline.=' %p%% '               " Show percentage
    if get(g:, 'streamline_show_ale_status', 0) && exists(':ALELint')
        let statusline.='%#WarningColor#'
        let statusline.='%{GetAleStatus()[0]}'
        let statusline.='%#ErrorColor#'
        let statusline.='%{GetAleStatus()[1]}'
    endif
    return statusline
endfunction

function! CreateInactiveStatusline()
    let statusline=''
    let statusline.='%#Whitespace#'
    let statusline.=' %{GetMode()} '
    let statusline.='%{GitBranch()}'
    let statusline.='▏%f'
    let statusline.=' %m'
    let statusline.='%='
    if !get(g:, 'streamline_minimal_ui', 0)
        let statusline.='▏%y'
        let statusline.=' %{&fileencoding?&fileencoding:&encoding}'
        let statusline.='[%{&fileformat}] '
    endif
    let statusline.='▏☰ %l:%c'
    let statusline.=' %p%% '
    if get(g:, 'streamline_show_ale_status', 0) && exists(':ALELint')
        let statusline.='%{GetAleStatus()[0]}'
        let statusline.='%{GetAleStatus()[1]}'
    endif
    return statusline
endfunction

function! GitBranch()
    let l:branch = system('cd '.expand('%:p:h').' && git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d "\n"')
    return !strlen(l:branch) || !isdirectory(expand('%:p:h')) ? '' : '▏'.l:branch.' '
endfunction

function GetAleStatus()
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:formated_errors = l:all_errors == 0 ? '' : '▏✗ '.l:all_errors.' '
    let l:all_warnings = l:counts.total - l:all_errors
    let l:formated_warnings = l:all_warnings == 0 ? '' : '▏⚠ '.l:all_warnings.' '
    return [l:formated_warnings, l:formated_errors]
endfunction

function! GetMode()
    let l:mode=mode(1)
    if l:mode ==# 'i'
        return 'INSERT'
    elseif l:mode ==# 'c'
        return 'COMMAND'
    elseif l:mode ==# 'v'
        return 'VISUAL'
    elseif l:mode ==# 'V'
        return 'V-LINE'
    elseif l:mode ==# "\<C-V>"
        return 'V-BLOCK'
    elseif l:mode ==? 'R' || l:mode ==? 'Rv'
        return 'REPLACE'
    elseif l:mode ==? 't'
        return 'TERMINAL'
    else
        return 'NORMAL'
    endif
endfunction
