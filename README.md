###### md5 hash beb0ec9b9d5b7c5dbf7201a25fb1e189<br>
<img src="wintar.png" width=100>

#### Syntax:-
<SUP>ENVIRONMENT_VARIABLE</SUP> : `set archive-choice=`[{default=}`.tar|.tar.gz`|`.tar.bz2`|`.tar.xz`|`.tar.lzma`]<br>
<SUP>ENVIRONMENT_VARIABLE</SUP> : `set format-choice=`[{default=}`ustar`|`pax`|`cpio`|`shar`]

<B>WARNING:
1. The script is *UNABLE to translate RELATIVE PATHS effectively/accurately* </b>*if it is called from another directory*<br>
2. It must always be called using its name only from the same directory it resides in.   <br>
3. File names must be relative to the directory of the script. <br> (Eg. `C:\users\Username\Desktop>"c:\scripts\tarrer.bat" ..\Desktop\folder`) --> <b>wrong</b><br>`C:\users\Username\Desktop\Scripts>"tarrer.bat" "..\folder"` --> <b>correct</b>

<b>Tips:</b>
1. The batch script <b>can be copied to a concerned directory before executing</b> if convenient. (Eg. usage `tarrer.bat` NOT `%tmp%\tarrer.bat` or `c:\scripts\tarrer.bat`)<sup>SEE WARNING 1.</SUP>
2. Using absolute paths for the file name/folder name to add (eg. `c:\users\name\desktop\122`) , will result in the resulting archive containing the whole directory tree (of the path) and therefore the tree of folders which are above the destination folder will be present in the archive.
3. It is better to use relative paths, relative to the script from the script's location.

<b>`tarrer.bat`</b> `"[Directory or FILENAME or *pattern* to include]"` `[{Optional=}exclude_pattern]`<br>
`addtotar.bat "EXISTINGarchive" "[file or folder toADD]"`<br>
`xtar.bat "ARCHIVEtoExtract"`

###### Supported Wildcards (for Patterns):
1. `*`

#### Edge (and other problematic) cases Reviewed:-
1. Patterns to \*include\* OR \*exclude\* must be checked for validity using `dir` command otherwise the script may hang indefinitely.
2. The script should always be called in an new shell eg. like `start cmd /c "tarrer.bat .."options""` to avoid using the set variables that have been set in the shell environment by the script during the earlier run.
3. File/Folder names containing special variable names (enclosed in `%` like `%special_name%` *may* be misinterpreted (untested) but *will usually* return a file not found error. (`9009`)
4. File names cannot contain Double quotes as part of the name, and should be *enclosed* in double - quotes `"file name"`
5. Many cases are associated with Shell vulnerability or weakness rather than a script issue. These issues must ideally be checked before passing the arguments to the batch script.
6. If you are using this in a script, it is better to test script behaviour and output with the edge case file names.

>[!WARNING]
> <b>Not recommended for GUI use!</b>
>1. do not use Drag 'n' Drop generally, especially with multiple items<br>
>2. multiple items are not supported/processed.<br>
>+ (the script will not be able to parse (multiple or even single in some cases) file/directory names properly if passed thru the GUI because Windows does not pass arguments to the script in a proper format. Handling such unpredicatble format requires immense and an impossible Batch script code. <p>There is also a built in limit to number of arguments that can be parsed in a shell script meaning multiple files (usually beyond 9) cannot use the built in parser.)
>+ <p>It is not recommended to calculate the file hash using the `/v` command, it should be done independently.
