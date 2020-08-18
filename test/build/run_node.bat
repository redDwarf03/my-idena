@echo off
FOR /F "tokens=4 delims= " %%i in ('route print ^| find " 0.0.0.0"') do set localIp=%%i
echo ------------------------------------------------------------
echo ------------- Settings for my Idena mobile app -------------
echo ------------------------------------------------------------
echo Node address: http://%localIp%:9009
echo Node api key: 123
echo ------------------------------------------------------------
echo ------------------------------------------------------------
echo After you have finished entering information in mobile app settings,
pause
%userprofile%\AppData\Roaming\Idena\node\idena-go.exe --rpcaddr=%localIp% --rpcport=9009 --apikey=123 --datadir="%userprofile%\AppData\Roaming\Idena\node\datadir"