scriptencoding utf-8

if exists('g:loaded_streamline_plugin')
    finish
endif
let g:loaded_streamline_plugin = 1

set laststatus=2
set statusline=%!CreateStatusline()
augroup status
    autocmd!
    autocmd WinEnter * setlocal statusline=%!CreateStatusline()
    autocmd WinLeave * setlocal statusline=%!streamline#inactive#CreateStatusline()
    autocmd ColorScheme * call CreateHighlightGroups()
    autocmd BufEnter * let s:git_branch = GetGitBranch()
augroup END

if get(g:, 'streamline_powerline_fonts', 1)
    let g:streamline_left_sep = get(g:, 'streamline_left_sep', '')
    let g:streamline_right_sep = get(g:, 'streamline_right_sep', '')
    let g:streamline_left_sep_alt = get(g:, 'streamline_left_sep_alt', '')
    let g:streamline_right_sep_alt = get(g:, 'streamline_right_sep_alt', '')
else
    let g:streamline_left_sep = get(g:, 'streamline_left_sep', '')
    let g:streamline_right_sep = get(g:, 'streamline_right_sep', '')
    let g:streamline_left_sep_alt = get(g:, 'streamline_left_sep_alt', '-')
    let g:streamline_right_sep_alt = get(g:, 'streamline_right_sep_alt', '-')
endif


function! Init()
    call CreateHighlightGroups()
    let s:git_branch = GetGitBranch()
endfunction

function! CreateStatusline()
    let statusline=''                      " Clear statusline
    let statusline.='%#ModeColor#'
    let statusline.=' %{GetMode()} '
    let statusline.='%1*'.g:streamline_left_sep
    let statusline.='%#BranchColor#'
    if get(g:, 'streamline_powerline_fonts', 1) && s:git_branch !=# ''
        let statusline.=' '
    endif
    let statusline.=s:git_branch
    let statusline.='%2*'.g:streamline_left_sep
    let statusline.='%#CursorlineNr#'
    if get(g:, 'streamline_enable_devicons', 1) && exists('*WebDevIconsGetFileTypeSymbol')
        let statusline.=' %{WebDevIconsGetFileTypeSymbol()}'
    else
        let statusline.=' %y'              " Show filetype
    endif
    let statusline.=' %f'                  " Show filename
    let statusline.=' %m'                  " Show modified tag
    let statusline.='%='                   " Switch elements to the right
    let statusline.='%2*'.g:streamline_right_sep
    if !get(g:, 'streamline_minimal_ui', 0)
        let statusline.='%#BranchColor#'
        let statusline.=' %{&fileformat} '
        let statusline.=g:streamline_right_sep_alt
        let statusline.=' %{&fileencoding?&fileencoding:&encoding} '
    endif
    let statusline.='%1*'.g:streamline_right_sep
    let statusline.='%#ModeColor#'
    let statusline.=' ☰ %l:%c'              " Show line number and column
    let statusline.=' %p%% '                " Show percentage
    if get(g:, 'streamline_show_ale_status', 1) && exists(':ALELint')
        let statusline.='%#WarningColor#'
        let statusline.='%{streamline#ale#GetAleStatus()[0]}'
        let statusline.='%#ErrorColor#'
        let statusline.='%{streamline#ale#GetAleStatus()[1]}'
    endif
    return statusline
endfunction

function GetGitBranch()
    let l:branch = system('cd '.expand('%:p:h').' && git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d "\n"')
    return !strlen(l:branch) || !isdirectory(expand('%:p:h')) ? '' : ' ' . l:branch . ' '
endfunction

function! GetMode()
    let l:mode=mode(1)
    if l:mode ==# 'i'
        return 'INSERT'
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

function! CreateHighlightGroups()
    let g:group_num = 0
    hi WarningColor guibg=#E5C07B guifg=#1E1E1E ctermbg=Yellow ctermfg=Black
    hi ErrorColor guibg=#DF6A63 guifg=#1E1E1E ctermbg=Red ctermfg=Black
    call streamline#powerline#CreateHighlightGroup('Search', 'ModeColor')
    call streamline#powerline#CreateHighlightGroup('diffadd', 'BranchColor')
    call streamline#powerline#CreateHighlightGroup('CursorlineNr', 'StatusColor')
    if get(g:, 'streamline_powerline_fonts', 1)
        call streamline#powerline#ReverseHighlightGroup('ModeColor', 'BranchColor')
        call streamline#powerline#ReverseHighlightGroup('BranchColor', 'StatusColor')
        call streamline#powerline#ReverseHighlightGroup('BranchColor', 'ModeColor')
        call streamline#powerline#ReverseHighlightGroup('ModeColor', 'StatusColor')
    endif
endfunction

call Init()
