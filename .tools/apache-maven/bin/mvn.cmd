@echo off
setlocal

set "MAVEN_HOME=%~dp0.."
set "CLASSWORLDS_JAR=%MAVEN_HOME%\boot\plexus-classworlds-2.11.0.jar"

if defined JAVA_HOME (
  set "JAVACMD=%JAVA_HOME%\bin\java.exe"
) else (
  set "JAVACMD=java.exe"
)

"%JAVACMD%" ^
  -classpath "%CLASSWORLDS_JAR%" ^
  "-Dclassworlds.conf=%MAVEN_HOME%\bin\m2.conf" ^
  "-Dmaven.home=%MAVEN_HOME%" ^
  "-Dmaven.multiModuleProjectDirectory=%CD%" ^
  org.codehaus.plexus.classworlds.launcher.Launcher %*

endlocal
