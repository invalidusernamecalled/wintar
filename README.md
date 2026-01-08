<B>Project is Now Closed</b>
###### md5 hash 8a008c9f325ba41782874951ec642948<br> 

\\/ for victory 
```
˗ˏˋ ✞ ˎˊ˗
```
<img src="wintar.png" width=100><p>

#### Syntax:-
+ <b>`tarrer.bat`</b> "[FILE PATTERN/SINGLE FILE/FOLDER]" [{optional}EXCLUDE-1] .. [EXCLUDE-8]<br>
+ <b>add&nbsp; &nbsp;  --\>`addtotar.bat`</b> "ARCHIVE" "FILE/FOLDER"<br>
+ <b>extract--\>`xtar.bat`</b>&nbsp; &nbsp; &nbsp; &nbsp; "ARCHIVE" /s  {/s=optional=strip directory}
+ <b>list&nbsp; &nbsp; &nbsp; --\>`tarlist.bat`</b>&nbsp; &nbsp; "ARCHIVE/PATTERN"

suggested usage:
+ use `tarrer.bat` with initial file pattern/folder name
+ use `addtotar.bat` to add subsequent files to already created archive
+ use `tarlist.bat` to list archive contents
+ use `xtar.bat` to extract archive

#### Salient features:-
1. <i>Unique Archive name is generated</i> automatically
2. <i>Extracted archive creates a folder</i> automatically
3. <i>Displays tar error code</i> in `console output`
4. <i>Verbose output</i>

returns `2` error level for possibly corrupt archives

###### Supported Wildcards (for Patterns):
1. `*`
###### Valid Env. Variables:

- `set archive-choice=`(default=)`.tar|.tar.gz`|`.tar.bz2`|`.tar.xz`|`.tar.lzma`<br>
- `set format-choice=`(default=)`ustar`|`pax`|`cpio`|`shar`

#### Disclaimer:
NO WARRANTY IS HERE BY OFFERED BY THE AUTHOR. PLEASE DO NOT BLAME ME FOR LOSS OF DATA ETC. PLEASE READ THE TERMS OF THE LICENSE ASSOCIATED WITH THIS REPOSITORY. THIS SCRIPT IS WRITTEN IN BATCH AND AS SUCH IS (MIGHT BE) VULNERABLE TO SPECIAL OR OFFENSIVE CHARACTERS in FILE NAMES OR FILE/DIRECTORY PATHS, Apart from OTHER UNKNOWN(or UNresolved) BUGS. WHILE I HAVE TRIED TO MAKE THIS SCRIPT USEFUL, it is only here for EDUCATIONAL/TESTING/RESEARCH PURPOSE and under the LIABILITY of the USER who is responsible for ANY UNTOWARD DIRECT or INDIRECT act CAUSED by THIS SOFTWARE BUNDLE.

>[!WARNING]
> <b>Not for GUI use!</b>
>1. do not use Drag 'n' Drop<br>
>2. do not Drag 'n' Drop multiple items<br>
>3. multiple items are not processed.<br>
>4. Windows does not pass arguments to the script in proper or predictable format.

#### Edge case:-
1. Do not pass file/folder names or arguments containing ampersand `%` especially some letter or word enclosed in ampersands like `some %file%.txt` as it is subject to mis interpretation by the shell.
2.  File/Folder names containing `%` like `%specialname%` is subject to being misinterpreted if a variable by that name exists (usual shell behaviour) but *will usually* return a file not found error (and not result in adverse operation) (`9009`)
3.  As such these cases and any adverse operation cannot be pre judged by me.
