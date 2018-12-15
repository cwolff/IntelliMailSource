clipper setup 
masm nbrdrv;
rem IF NOT ERRORLEVEL 1 Plink86 FI %1 LIB \CLIPPER\CLIPPER, \CLIPPER\EXTEND
link setup+nbrdrv,,,c:\clipper\clipper.lib+c:\clipper\extend.lib
