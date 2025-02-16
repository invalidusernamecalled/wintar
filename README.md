<B>Project is Now Closed</b>
###### md5 hash 4edef622134f4b732449c57a27504a24<br>
<img src="wintar.png" width=100><p>
- `set archive-choice=`(default=)`.tar|.tar.gz`|`.tar.bz2`|`.tar.xz`|`.tar.lzma`<br>
- `set format-choice=`(default=)`ustar`|`pax`|`cpio`|`shar`
- `set enable_logging=1`|`0`
- `set logfile=Example_Name`    Log is stored as `Example_Name_vhZZPuG.txt`<br>
   &nbsp; <b>If it does not Exist Already.</b>

#### Syntax:-
+ <b>`tarrer.bat`</b> "[FILE/FOLDER]" [{optional}EXCLUDE 1] .. [EXCLUDE 8]<br>
+ <b>add&nbsp; &nbsp;  --\>`addtotar.bat`</b> "ARCHIVE" "FILE/FOLDER"<br>
+ <b>extract--\>`xtar.bat`</b> "ARCHIVE"
+ <b>list&nbsp; &nbsp; &nbsp; --\>`tarlist.bat`</b> "ARCHIVE/PATTERN"

#### Salient features:-
1. Archive name is created automatically
2. Archive extracted creates a folder automatically
3. Outputs tar error code in output
4. Verbose output
5. returns `2` error level for possibly corrupt archives

###### Supported Wildcards (for Patterns):
1. `*`

>[!WARNING]
> <b>Not for GUI use!</b>
>1. do not use Drag 'n' Drop<br>
>2. do not Drag 'n' Drop multiple items<br>
>3. multiple items are not processed.<br>
>4. Windows does not pass arguments to the script in proper or predictable format.

#### Edge case:-
1. Do not pass file/folder names or arguments containing ampersand `%` especially some letter or word enclosed in ampersands like `some %file%.txt` as it is subject to mis interpretation by the shell.
2.  File/Folder names containing special variable names (enclosed in `%` like `%specialname%` *may* be misinterpreted (untested) but *will usually* return a file not found error. (`9009`)
