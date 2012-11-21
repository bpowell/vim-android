function! FindManifestFile()
python << endpython

import vim
import os

def find_manifest(path):
	found = False

	dirs = os.listdir(path)
	for d in dirs:
		if d=='AndroidManifest.xml':
			found = True

	return found

found = False
old_dir = pwd = os.getcwd()

found = find_manifest(pwd)

while not found:
	if pwd=='/':
		break
	os.chdir(pwd+'/..')
	pwd = os.getcwd()
	found = find_manifest(pwd)

if found:
	ANDROID_SDK = os.environ['ANDROID_SDK']
	if ANDROID_SDK=='':
		exit(1)

	cmd = "let s:androidSdkPath = '" + ANDROID_SDK + "'"
	vim.command(cmd)
	cmd = "vimgrep /target=/j " + pwd + "/project.properties"
	vim.command(cmd)
	vim.command("let s:androidTargetPlatform = split(getqflist()[0].text, '=')[1]")
	vim.command("let s:targetAndroidJar = s:androidSdkPath . '/platforms/' . s:androidTargetPlatform . '/android.jar'")
	target = vim.eval("s:targetAndroidJar")
	cmd = "let $CLASSPATH = '" + target + "'"
	vim.command(cmd)

os.chdir(old_dir)
endpython
endfunction

call FindManifestFile()
