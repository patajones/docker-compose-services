
# Obtém o IP da interface "vEthernet (WSL (Hyper-V firewall))"
$adapterName = "vEthernet (WSL (Hyper-V firewall))"
$ip = (Get-NetIPAddress -InterfaceAlias $adapterName -AddressFamily IPv4).IPAddress

$hostsPath = "C:\Windows\System32\drivers\etc\hosts"

# Função para adicionar domínio ao arquivo hosts
function Add-DomainToHosts {
    param (
        [string]$domain
    )
    
    # Verifica se o domínio já está presente no arquivo hosts
    if (-not (Get-Content $hostsPath | Select-String "$ip\s+$domain")) {
        Add-Content -Path $hostsPath -Value "$ip     $domain"
        Write-Host "Domínio $domain adicionado ao arquivo hosts."
    } else {
        Write-Host "O domínio $domain já está presente no arquivo hosts."
    }
}

# Adiciona os domínios
Add-DomainToHosts -domain "docker.local"
Add-DomainToHosts -domain "s3.minio.docker.local"
Add-DomainToHosts -domain "minio.docker.local"
Add-DomainToHosts -domain "spark.docker.local"
Add-DomainToHosts -domain "worker1.spark.docker.local"
Add-DomainToHosts -domain "worker2.spark.docker.local"