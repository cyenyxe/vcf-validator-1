@echo off

if not exist windows_dependencies mkdir windows_dependencies
if exist windows_dependencies/odb exit /b
cd windows_dependencies

:: Download zip files
powershell -command "(new-object System.Net.WebClient).DownloadFile('https://www.codesynthesis.com/download/odb/2.4/libodb-2.4.0.zip','.\libodb-2.4.0.zip')"
powershell -command "(new-object System.Net.WebClient).DownloadFile('https://www.codesynthesis.com/download/odb/2.4/libodb-sqlite-2.4.0.zip','.\libodb-sqlite-2.4.0.zip')"
powershell -command "(new-object System.Net.WebClient).DownloadFile('https://www.sqlite.org/2018/sqlite-dll-win32-x86-3240000.zip','.\sqlite-dll.zip')"
powershell -command "(new-object System.Net.WebClient).DownloadFile('https://www.sqlite.org/2018/sqlite-amalgamation-3240000.zip','sqlite-amalgamation.zip')"
powershell -command "(new-object System.Net.WebClient).DownloadFile('https://curl.haxx.se/windows/dl-7.62.0/curl-7.62.0-win64-mingw.zip','curl-7.62.0.zip')"

:: Unzip zip files
powershell -command "Expand-Archive libodb-2.4.0.zip ."
powershell -command "Expand-Archive libodb-sqlite-2.4.0.zip ."
powershell -command "Expand-Archive sqlite-dll.zip ."
powershell -command "Expand-Archive sqlite-amalgamation.zip ."
powershell -command "Expand-Archive curl-7.62.0.zip ."

:: Restructure directory
move libodb-sqlite-2.4.0\etc\sqlite .\
move sqlite3.def .\sqlite\
move sqlite-amalgamation-3240000\sqlite3.c .\sqlite\
move sqlite-amalgamation-3240000\sqlite3.h .\sqlite\

:: Copy headers
xcopy /e/i libodb-2.4.0\odb .\odb\
xcopy /e/i libodb-sqlite-2.4.0\odb\sqlite odb\sqlite\

:: Rename libcurl static library
ren curl-7.62.0-win64-mingw\lib\libcurl.a libcurl.lib

:: Delete useless files
del libodb-2.4.0.zip
del libodb-sqlite-2.4.0.zip
del sqlite-dll.zip
del sqlite-amalgamation.zip
del sqlite3.dll
del curl-7.62.0.zip
rmdir /s /q sqlite-amalgamation-3240000

dir
cd ..
