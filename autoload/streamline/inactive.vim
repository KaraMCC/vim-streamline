scriptencoding utf-8

function! streamline#inactive#CreateStatusline()
    let statusline=''
    let statusline.='%#StatusColor#'
    let statusline.=' %{GetMode()} '
    let statusline.=g:streamline_left_sep_alt
    let l:git_branch = GetGitBranch()
    if get(g:, 'streamline_powerline_fonts', 1) && l:git_branch !=# ''
        let statusline.=' '
    endif
    if l:git_branch !=# ''
        let statusline.=l:git_branch
        let statusline.=g:streamline_left_sep_alt
    endif
    if get(g:, 'streamline_enable_devicons', 1) && exists('*WebDevIconsGetFileTypeSymbol')
        let statusline.=' %{WebDevIconsGetFileTypeSymbol()}'
    else
        let statusline.=' %y'
    endif
    let statusline.=' %f'
    let statusline.=' %m'
    let statusline.='%='
    if !get(g:, 'streamline_minimal_ui', 0)
        let statusline.=' %{&fileformat} '
        let statusline.=g:streamline_right_sep_alt
        let statusline.=' %{&fileencoding?&fileencoding:&encoding} '
    endif
    let statusline.=g:streamline_right_sep_alt
    let statusline.=' ☰ %l:%c'
    let statusline.=' %p%% '
    if get(g:, 'streamline_show_ale_status', 1) && exists(':ALELint')
        let statusline.='%{streamline#ale#GetAleStatus()[0]}'
        let statusline.='%{streamline#ale#GetAleStatus()[1]}'
    endif
    return statusline
endfunction
