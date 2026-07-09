param(
    [string]$DbHost = "127.0.0.1",
    [string]$DbPort = "3306",
    [string]$DbName = "appdb",
    [string]$DbUser = "root",
    [string]$DbPassword = "Admin@123456"
)

$ErrorActionPreference = "Stop"

$env:DB_HOST = $DbHost
$env:DB_PORT = $DbPort
$env:DB_NAME = $DbName
$env:DB_USER = $DbUser
$env:DB_PASSWORD = $DbPassword

& "$PSScriptRoot\.tools\apache-maven\bin\mvn.cmd" tomcat7:run
