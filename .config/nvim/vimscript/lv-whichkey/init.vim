" Leader Key Maps

" Timeout
let g:which_key_timeout = 100

let g:which_key_display_names = {'<CR>': '↵', '<TAB>': '⇆', " ": 'SPC'}

" Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

let g:which_key_map =  {}
let g:which_key_sep = '→'

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0
let g:which_key_max_size = 0

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

let g:which_key_map['/'] = 'comment toggle'
let g:which_key_map[';'] = [ ':Dashboard'                       , 'home screen' ]
let g:which_key_map['?'] = [ ':NvimTreeFindFile'                , 'find current file' ]
let g:which_key_map['e'] = [ ':NvimTreeToggle'                  , 'explorer' ]
let g:which_key_map['f'] = [ ':Telescope find_files'            , 'find files' ]
let g:which_key_map['r'] = [ ':RnvimrToggle'                    , 'ranger' ]
let g:which_key_map['u'] = [ ':UndotreeToggle'                  , 'undotree' ]
let g:which_key_map['z'] = [ ':Goyo'                            , 'zen' ]
" TODO create entire treesitter section
" TODO play nice with status line

" Group mappings

" s is for search powered by telescope
let g:which_key_map.s = {
      \ 'name' : '+search' ,
      \ '.' : [':Telescope filetypes'                   , 'filetypes'],
      \ 'B' : [':Telescope git_branches'                , 'git branches'],
      \ 'd' : [':Telescope lsp_document_diagnostics'    , 'document_diagnostics'],
      \ 'D' : [':Telescope lsp_workspace_diagnostics'   , 'workspace_diagnostics'],
      \ 'h' : [':Telescope command_history'             , 'history'],
      \ 'i' : [':Telescope media_files'                 , 'media files'],
      \ 'm' : [':Telescope marks'                       , 'marks'],
      \ 'M' : [':Telescope man_pages'                   , 'man_pages'],
      \ 'o' : [':Telescope vim_options'                 , 'vim_options'],
      \ 't' : [':Telescope live_grep'                   , 'text'],
      \ 'r' : [':Telescope registers'                   , 'registers'],
      \ 'w' : [':Telescope file_browser'                , 'buf_fuz_find'],
      \ 'u' : [':Telescope colorscheme'                 , 'colorschemes'],
      \ }

" S is for Session
let g:which_key_map.S = {
      \ 'name' : '+Session' ,
      \ 's' : [':SessionSave'           , 'save session'],
      \ 'l' : [':SessionLoad'           , 'load Session'],
      \ }

" g is for git
let g:which_key_map.g = {
      \ 'name' : '+git' ,
      \ 'c' : [':Git commit'                          , 'commit'],
      \ 'd' : [':Git diff'                            , 'diff'],
      \ 'j' : [':NextHunk'                            , 'next hunk'],
      \ 'k' : [':PrevHunk'                            , 'prev hunk'],
      \ 'l' : [':Git log'                             , 'log'],
      \ 'p' : [':PreviewHunk'                         , 'preview hunk'],
      \ 'r' : [':ResetHunk'                           , 'reset hunk'],
      \ 'R' : [':ResetBuffer'                         , 'reset buffer'],
      \ 's' : [':StageHunk'                           , 'stage hunk'],
      \ 'S' : [':Gstatus'                             , 'status'],
      \ 'u' : [':UndoStageHunk'                       , 'undo stage hunk'],
      \ }

" v is for language server protocol
let g:which_key_map.v = {
      \ 'name' : '+lsp' ,
      \ 'd' : [':Telescope lsp_document_diagnostics' , 'document diagnostics'],
      \ 'D' : [':Telescope lsp_workspace_diagnostics', 'workspace diagnostics'],
      \ 'f' : [':LspFormatting'                      , 'format'],
      \ 'i' : [':LspImplementation'                  , 'lsp implementation'],
      \ 'l' : [':Lspsaga lsp_finder'                 , 'lsp finder'],
      \ 'r' : [':Lspsaga rename'                     , 'rename'],
      \ 'p' : [':Lspsaga preview_definition'         , 'preview definition'],
      \ 'n' : [':Lspsaga diagnostic_jump_next'       , 'next diagnostics'],
      \ 's' : [':Telescope lsp_document_symbols'     , 'document symbols'],
      \ 'S' : [':Telescope lsp_workspace_symbols'    , 'workspace symbols'],
      \ 'h' : [':Telescope help_tags'                , 'help tags'],
      \ 'K' : [':Lspsaga hover_doc'                  , 'hover doc'],
      \ }

call which_key#register('<Space>', "g:which_key_map")
