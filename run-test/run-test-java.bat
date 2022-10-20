chcp 65001
:: Set Param
@ECHO OFF
@SETLOCAL

:MainExec
echo "请输入测试选项并回车: 1)x64, 2)x86"
set LIB_PATH="win-JNI-CPU-x64"
set /p flag=
if %flag% == 1 (set LIB_PATH="win-JNI-CPU-x64")^
else if %flag% == 2 (set LIB_PATH="win-JNI-CPU-Win32")^
else (echo Input Error!)

SET TARGET_IMG=images/1.jpg
if not exist %TARGET_IMG% (
echo "找不到待识别的目标图片：%TARGET_IMG%，请打开本文件并编辑TARGET_IMG"
PAUSE
exit
)

java -Djava.library.path=%LIB_PATH%\bin -Dfile.encoding=UTF-8 -jar RapidOcrOnnxJvm.jar models ^
ch_PP-OCRv3_det_infer.onnx ^
ch_ppocr_mobile_v2.0_cls_infer.onnx ^
ch_PP-OCRv3_rec_infer.onnx ^
ppocr_keys_v1.txt ^
%TARGET_IMG% ^
%NUMBER_OF_PROCESSORS% ^
50 ^
1024 ^
0.5 ^
0.3 ^
1.6 ^
1 ^
1

::models
::det
::cls
::rec
::keys
::image
::numThread
::padding
::maxSideLen
::boxScoreThresh
::boxThresh
::unClipRatio
::doAngle
::mostAngle

echo.
GOTO:MainExec

@ENDLOCAL
