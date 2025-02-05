###### md5 hash 7aa28dab5a035cb62ebbc292a256cf28
#### Syntax:-
<SUP>optional</SUP> `ENVIRONMENT VARIABLE` : `set archive-choice=`[{default=}`.tar|.tar.gz`|`.tar.bz2`|`.tar.xz`|`.tar.lzma`]<br>
<SUP>optional</SUP> `ENVIRONMENT VARIABLE` : `set format-choice=`[{default=}`ustar`|`pax`|`cpio`|`shar`]

<b>`tarrer.bat`</b> `"[Directory or FILENAME or *pattern* to include]"` `[{Optional=}exclude_pattern]`

`addtotar.bat EXISTINGarchiveNAME file/folderNAMEtoADD`

###### Supported Wildcards:
1. `*`

#### Edge (and other problematic) cases Reviewed:-
1. Patterns for \*include\* OR \*exclude\* must be checked for validity using `dir` command otherwise the script may hang indefinitely.
2. The script must always be called using `start cmd /c "tarrer.bat"` to avoid using the set variables that have been set in the shell environment by the script during the earlier run.
3. File names containing special variable names (enclosed in `%` like `%special_name%` could be mis interpreted but *will usually* return a file not found error. (`9009`)
4. File names cannot contain Double quotes as part of the name, and should be *enclosed* in double - quotes `"file name"`
5. Many cases are associated with Shell vulnerability or weakness rather than a script issue. These issues must ideally be checked before passing the arguments to the batch script.

>[!WARNING]
>1. do not use Drag 'n' Drop generally, especially with multiple items<br>
>2. multiple items are not supported/processed.<br>
>+ (the script will not be able to parse (multiple or even single in some cases) file/directory names properly if passed thru the GUI because Windows does not pass arguments to the script in a proper format. Handling such unpredicatble format requires immense and an impossible Batch script code. <p>There is also a built in limit to number of arguments that can be parsed in a shell script meaning multiple files (usually beyond 9) cannot use the built in parser.)
>+ <p>It is not recommended to calculate the file hash using the `/v` command, it should be done independently.
