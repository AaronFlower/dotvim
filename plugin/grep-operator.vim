nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
	let save_unnamed_register = @@ 
	
	if a:type ==# 'v'
		execute "normal! `<v`>y"
	elseif a:type ==# 'char'
		execute "normal! `[v`]y"
	else
		return
	endif

	" search 
	silent execute "grep! -R " . shellescape(@@) . " . "
	
	" redraw!
	execute "normal! \<c-l>"
	" open quickfix
	copen

	" restore register
	let @@ = save_unnamed_register
endfunction
