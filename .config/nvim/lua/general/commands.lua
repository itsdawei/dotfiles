Command.cmd({
    -- tab confs
    'autocmd FileType python set sw=4',
    'autocmd FileType python set ts=4',
    'autocmd FileType python set sts=4',
    'filetype plugin on',
})

Augroup.cmds({
    -- its DAWEI!!!
    ITSDAWEI = {
        {"BufWritePre", "* :call TrimWhitespace()"};
    };
})
