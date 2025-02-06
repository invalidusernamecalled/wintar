###### md5 hash beb0ec9b9d5b7c5dbf7201a25fb1e189
#### Syntax:-
<SUP>optional ENVIRONMENT_VARIABLE</SUP> : `set archive-choice=`[{default=}`.tar|.tar.gz`|`.tar.bz2`|`.tar.xz`|`.tar.lzma`]<br>
<SUP>optional ENVIRONMENT_VARIABLE</SUP> : `set format-choice=`[{default=}`ustar`|`pax`|`cpio`|`shar`]

<b>`tarrer.bat`</b> `"[Directory or FILENAME or *pattern* to include]"` `[{Optional=}exclude_pattern]`<br>

<B>WARNING: 1. The script is *unable to translate relative names ACCURATELY*  Eg. `..\Desktop\filename` </b>*if called from another directory*<br>2. It must always be called using its name only from the same directory it resides in. <br>3. File names must be relative to the directory of the script.<br>4. Or <b>copied to a concerned directory before executing.</b> (Eg. usage `tarrer.bat` NOT `%tmp%\tarrer.bat` or `c:\scripts\tarrer.bat`)
<br><b>2.</b> If you plan on using absolute paths for the file name/folder name to add , please understand the resulting archive will contain the whole directory tree (of the path).

`addtotar.bat "EXISTINGarchive" "[file or folder toADD]"`<br>
`xtar.bat "ARCHIVE"`

###### Supported Wildcards:
1. `*`

#### Edge (and other problematic) cases Reviewed:-
1. Patterns to \*include\* OR \*exclude\* must be checked for validity using `dir` command otherwise the script may hang indefinitely.
2. The script should always be called in an new shell eg. like `start cmd /c "tarrer.bat .."options""` to avoid using the set variables that have been set in the shell environment by the script during the earlier run.
3. File names containing special variable names (enclosed in `%` like `%special_name%` could be mis interpreted but *will usually* return a file not found error. (`9009`)
4. File names cannot contain Double quotes as part of the name, and should be *enclosed* in double - quotes `"file name"`
5. Many cases are associated with Shell vulnerability or weakness rather than a script issue. These issues must ideally be checked before passing the arguments to the batch script.
6. If you are using this in a script, it is better to test script behaviour and output with the edge case file names.

>[!WARNING]
>1. do not use Drag 'n' Drop generally, especially with multiple items<br>
>2. multiple items are not supported/processed.<br>
>+ (the script will not be able to parse (multiple or even single in some cases) file/directory names properly if passed thru the GUI because Windows does not pass arguments to the script in a proper format. Handling such unpredicatble format requires immense and an impossible Batch script code. <p>There is also a built in limit to number of arguments that can be parsed in a shell script meaning multiple files (usually beyond 9) cannot use the built in parser.)
>+ <p>It is not recommended to calculate the file hash using the `/v` command, it should be done independently.
