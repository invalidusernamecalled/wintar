###### md5 hash beb0ec9b9d5b7c5dbf7201a25fb1e189<br>
<img src="wintar.png" width=100>

<SUP>ENVIRONMENT_VARIABLE</SUP> : `set archive-choice=`[{default=}`.tar|.tar.gz`|`.tar.bz2`|`.tar.xz`|`.tar.lzma`]<br>
<SUP>ENVIRONMENT_VARIABLE</SUP> : `set format-choice=`[{default=}`ustar`|`pax`|`cpio`|`shar`]

<B>WARNING:
1. The script is *UNABLE to translate RELATIVE PATHS effectively/accurately* </b>*if it is called from another directory*<br>
2. It must always be called using the script name from the script's location.   <br>
3. Target name must be relative to the directory of the script. <br> (Eg. `C:\users\Username\Desktop>"C:\users\Username\Desktop\Scripts\tarrer.bat" .\folder`) --> <b>wrong</b><br>`C:\users\Username\Desktop\Scripts>"tarrer.bat" "..\folder"` --> <b>correct</b><br>

#### Syntax:-
+ <b>`tarrer.bat`</b> "[Directory or FILENAME or *pattern* to include]" `[Optional=*exclude_pattern*]`<br>
+ <b>`addtotar.bat`</b> "EXISTING_Uncompressed_archive.tar" `"[file or folder toADD]"`<br>
+ <b>`xtar.bat`</b> "ARCHIVEtoExtract"
+ <b>`tarlist.bat`</b> "Archive name or Pattern to list"

#### Salient features:-
1. Archive created is automatically assigned a name.
2. Archive extracted is automatically assigned a folder.

###### Supported Wildcards (for Patterns):
1. `*`

<b>Tips:</b>
1. The batch script <b>can be copied to a the directory containing the folder/file before executing</b> if convenient. (Eg. usage correct-->`tarrer.bat` NOT-->`%tmp%\tarrer.bat` NOT--> `c:\scripts\tarrer.bat`)<sup>SEE WARNING 1.</SUP>
2. Use paths relative to the script's location OR use absolute paths.

>[!WARNING]
> <b>Not recommended for GUI use!</b>
>1. do not use Drag 'n' Drop<br>
>2. do not use Drag 'n' Drop with multiple items<br>
>3. multiple items are not processed.<br>
>+ (the script will not be able to parse file/directory names if passed thru the GUI because Windows does not pass arguments to the script in proper or predictable format.
>+ Handling such unpredicatble format requires immense and an impossible Batch script code. 
>+ Bugs have been identified for file/folders using drag and drop that have special characters and are not passed by Windows. It is a windows problem

#### Edge and problematic cases:-
1. Patterns to \*include\* OR \*exclude\* must be checked for validity using `dir` command otherwise the script may hang indefinitely.
2. The script should always be called in an new shell eg. like `start cmd /c "tarrer.bat .."options""` OR `for /f "delims=" %%i in ('tarrer.bat "options"') do echo %%i`. This avoids unexpected behaviour that can be caused by variables that have been set in the shell environment by the script.
3. File/Folder names containing special variable names (enclosed in `%` like `%special_name%` *may* be misinterpreted (untested) but *will usually* return a file not found error. (`9009`)
4. File names cannot contain Double quotes as part of the name, and should be *enclosed* in double - quotes `"file name"`
5. Many cases are associated with Shell vulnerability or weakness rather than a script issue. These issues must ideally be checked before passing the arguments to the batch script.
6. If you wish to use this script in an automated way, it is better to study this script's behaviour independently and check its output with the edge case file names.
