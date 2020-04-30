scriptencoding utf-8

let g:group_num = 0

function! streamline#powerline#CreateHighlightGroup(group, name)
    let id = synIDtrans(hlID(a:group))
    let colors = []
    for type in ['cterm', 'gui']
        for ground in ['fg', 'bg']
            exe printf('let %s%s = synIDattr(id, "%s#", "%s")', type, ground, ground, type)
            exe printf('let color_name = %s%s', type, ground)
            if color_name != ''
                let colors += [type.ground.'='.color_name.' ']
            endif
        endfor
    endfor
    let exe_string = printf('hi %s ', a:name)
    for color in colors
        let exe_string .= color
    endfor
    exe exe_string
endfunction

function! streamline#powerline#ReverseHighlightGroup(group, reverse_group)
    let g:group_num += 1
    " Get ID of the first highlight group
    let id = synIDtrans(hlID(a:group))
    " Get ID of the next group
    let next_id = synIDtrans(hlID(a:reverse_group))
    let colors = []
    for type in ['cterm', 'gui']
        " Get background color of group, and store it in [type]fg
        exe printf('let %sfg = synIDattr(id, "bg#", "%s")', type, type)
        exe printf('let fg_color = %sfg', type)
        if fg_color != ''
            let colors += [type.'fg='.fg_color.' ']
        endif

        " Get the background color of the next group, and store it in [type]bg
        exe printf('let %sbg = synIDattr(next_id, "bg#", "%s")', type, type)
        exe printf('let bg_color = %sbg', type)
        if bg_color != ''
            let colors += [type.'bg='.bg_color.' ']
        endif
    endfor
    let exe_string = printf('hi User%s ', g:group_num)
    for color in colors
        let exe_string .= color
    endfor
    exe exe_string
endfunction
