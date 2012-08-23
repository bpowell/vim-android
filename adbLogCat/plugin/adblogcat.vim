if exists('g:AdbLogCat_Loaded')
	finish
endif
let g:AdbLogCat_Loaded = 1

if !exists('s:AdbLogCat_IsRunning')
	let s:AdbLogCat_IsRunning = 0
endif

if !exists('s:AdbLogCat_PrevWinHeight')
	let s:AdbLogCat_PrevWinHeight = 15
endif

if !exists('s:AdbLogCat_LogFileLoc')
	let s:AdbLogCat_LogFileLoc = '/tmp/adb-logcat-output.adb'
endif

python << endpython
import vim
import threading
from threading import Thread
from time import sleep

class UpdatePrevWin(Thread):
	def __init__(self):
		self.cont = True
		Thread.__init__(self)

	def run(self):
		while self.cont:
			vim.command("silent! wincmd P")
			vim.command("silent execute 'pedit!'")
			vim.command("normal G")
			sleep(1)
	
	def stop(self):
		self.cont = False

	def restart(self):
		self.cont = True

update = UpdatePrevWin()
endpython

nmap <F2> :call ToggleAdbLogCat()<CR>

function! ToggleAdbLogCat()
	if s:AdbLogCat_IsRunning == 0 "Not running
		call AdbLogCat()
		call TailFile()
	else "Is running
		call TailFile_Stop()
	endif
endfunction

function! AdbLogCat()
	silent execute ':!adb logcat > ' . s:AdbLogCat_LogFileLoc . '&'
endfunction

function! TailFile()
	if !filereadable(s:AdbLogCat_LogFileLoc)
		echohl ErrorMsg | echo "Cannot open file for readins: " . s:AdbLogCat_LogFileLoc | echohl None
		return
	endif

	pclose "close prevwin if one is already opened.
	if bufexists(bufnr(s:AdbLogCat_LogFileLoc))
		execute ':' . bufnr(s:AdbLogCat_LogFileLoc) . 'bwipeout'
	endif

	augroup TailFile
		execute "autocmd BufWinEnter " . s:AdbLogCat_LogFileLoc . " call TailFile_Setup()"
	augroup END

	silent execute s:AdbLogCat_PrevWinHeight . "new " . s:AdbLogCat_LogFileLoc
	call TailFile_Start()
endfunction

function! TailFile_Setup()
	setlocal noswapfile
	setlocal noshowcmd
	setlocal bufhidden=delete
	setlocal nobuflisted
	setlocal nomodifiable
	setlocal nowrap
	setlocal nonumber
	setlocal previewwindow

	wincmd P
	normal G
endfunction

function! TailFile_Start()
	let s:AdbLogCat_IsRunning = 1
python << endpython
update.start()
endpython
endfunction

function! TailFile_Stop()
python << endpython
update.stop()
endpython
	let s:AdbLogCat_IsRunning = 0
	silent execute "!ps aux | grep 'adb logcat' | grep -v 'grep' | awk '{print $2}' | xargs kill"
	redraw!
endfunction

function! TailFile_Restart()
	call AdbLogCat()
	call TailFile()
python << endpython
update.restart()
update.run()
endpython
	let s:AdbLogCat_IsRunning = 1
endfunction
