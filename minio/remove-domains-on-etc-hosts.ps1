# Define o IP e o caminho para o arquivo hosts
$ip = "127.0.0.1"
$hostsPath = "C:\Windows\System32\drivers\etc\hosts"

# Função para remover um domínio do arquivo hosts
function Remove-DomainFromHosts {
    param (
        [string]$domain
    )
    
    # Verifica se o domínio está presente no arquivo hosts
    if (Get-Content $hostsPath | Select-String "$ip\s+$domain") {
        # Filtra as linhas que não contêm o domínio e reescreve o arquivo hosts
        (Get-Content $hostsPath) | Where-Object { $_ -notmatch "$ip\s+$domain" } | Set-Content $hostsPath
        Write-Host "Domínio $domain removido do arquivo hosts."
    } else {
        Write-Host "O domínio $domain não está presente no arquivo hosts."
    }
}

# Remove os domínios
Remove-DomainFromHosts -domain "docker.local"
Remove-DomainFromHosts -domain "s3.minio.docker.local"
Remove-DomainFromHosts -domain "minio.docker.local"