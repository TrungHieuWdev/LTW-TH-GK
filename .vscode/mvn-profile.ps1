function mvn {
    $mavenCmd = Join-Path $PSScriptRoot "..\.tools\apache-maven\bin\mvn.cmd"
    $mavenArgs = $args

    $shouldOpenBrowser = ($args.Count -eq 1 -and $args[0] -eq "tomcat7:run") -or
        ($args.Count -eq 2 -and $args[0] -eq "clean" -and $args[1] -eq "tomcat7:run")

    if ($shouldOpenBrowser) {
        $mavenArgs = @("clean", "package", "tomcat7:run-war")
        Start-Process -WindowStyle Hidden powershell -ArgumentList @(
            "-NoProfile",
            "-ExecutionPolicy", "Bypass",
            "-Command",
            "`$urls = @('http://localhost:8080/login.jsp', 'http://localhost:8080/dhv_web_group2/login.jsp'); for (`$i = 0; `$i -lt 90; `$i++) { foreach (`$url in `$urls) { try { `$r = Invoke-WebRequest -Uri `$url -UseBasicParsing -TimeoutSec 2; if (`$r.StatusCode -eq 200) { Start-Process `$url; exit } } catch {} }; Start-Sleep -Seconds 1 }"
        )
    }

    & $mavenCmd @mavenArgs
}
