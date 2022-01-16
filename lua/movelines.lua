function GetDirection(direction)
    local result = ""
    if string.len(direction) == 0 then
        return result
    end

    local first_letter = string.sub(direction,1,1)
    first_letter = string.lower(first_letter)

    if first_letter == 'u' or
        first_letter == 'd' or
        first_letter == 'l' or
        first_letter == 'r' then
        result = first_letter
    end

    return result
end

function MoveNormal(direction)
    if vim.api.nvim_get_mode().mode ~= 'n' then
        return 1
    end

    local direction = GetDirection(direction)

    if string.len(direction) == 0 then
        return 1
    end

    if direction == 'r' then
        local cmd = vim.api.nvim_replace_termcodes('normal i <ESC>l', true, false, true)
        vim.cmd(cmd)
        return 0
    elseif direction == 'l' then
        vim.cmd('normal! hx')
        return 0
    end

    local cursor_pos = {
        x = vim.api.nvim_win_get_cursor(0)[2],
        y = vim.api.nvim_win_get_cursor(0)[1]
    }

    if direction == 'u' then
        cursor_pos.y = cursor_pos.y - 1
    elseif direction == 'd' then
        cursor_pos.y = cursor_pos.y + 1
    end

    if cursor_pos.y <= 0 or cursor_pos.y > vim.fn.line('$') then
        return 1
    end

    local CR = vim.api.nvim_replace_termcodes('<CR>',true,false,true)

    if direction == 'u' then
        vim.cmd('move .-2'..CR)
    elseif direction == 'd' then
        vim.cmd('move .+1'..CR)
    else
        return 1
    end

    return 0
end

function MoveVisual(direction)
    local direction = GetDirection(direction)

    if string.len(direction) == 0 then
        return 1
    end

    local _, start_row, start_col = unpack(vim.fn.getpos("'<"))
    local _, end_row, end_col = unpack(vim.fn.getpos("'>"))

    local d = end_row - start_row

    local CR = vim.api.nvim_replace_termcodes('<CR>',true,false,true)

    if (direction == 'u' and start_row == 1) or
        (direction == 'd' and end_row == vim.fn.line('$')) then
        vim.cmd('normal v'..d..CR..'gv$')
        return 0
    end

    if direction == 'u' then
        if d == 0 then
            vim.cmd("normal V:move '<-2"..CR.."gv$")
        else
            vim.cmd("normal V"..d..CR..":move '<-2"..CR.."gv$")
        end
    elseif direction == 'd' then
        if d == 0 then
            vim.cmd("normal V:move '>+1"..CR.."gv$")
        else
            vim.cmd("normal V"..d..CR..":move '>+1"..CR.."gv$")
        end
    elseif direction == 'l' then
        if d == 0 then
            vim.cmd("normal V:normal _X"..CR.."gv$")
        else
            vim.cmd("normal V"..d..CR..":normal _X"..CR.."gv$")
        end
    elseif direction == 'r' then
        if d == 0 then
            vim.cmd("normal V:normal i "..CR.."gv$")
        else
            vim.cmd("normal V"..d..CR.."$:normal i "..CR.."gv$")
        end
    end

    return 0
end
