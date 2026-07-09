param(
    [string]$DbUser = "root",
    [string]$DbPassword = "",
    [string]$MysqlExe = "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $MysqlExe)) {
    throw "mysql.exe not found at: $MysqlExe"
}

if ($DbPassword -eq "") {
    & $MysqlExe "-u$DbUser" "--default-character-set=utf8mb4" -e "source schema.sql"
} else {
    & $MysqlExe "-u$DbUser" "-p$DbPassword" "--default-character-set=utf8mb4" -e "source schema.sql"
}
