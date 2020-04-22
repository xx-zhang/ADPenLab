try{
    $name = (Get-NetAdapter | select Name).Name
    Disable-NetAdapterBinding –InterfaceAlias $name –ComponentID ms_tcpip6
}catch{
    add-content "c:\\log.txt" -value "$(get-date -format 'u'): $_.exception.message"
}
try{
    $index = (Get-NetAdapter | select IfIndex).IfIndex
    Set-DnsClientServerAddress -InterfaceIndex $index -ServerAddresses ("10.0.0.4")
}catch{
    add-content "c:\\log.txt" -value "$(get-date -format 'u'): $_.exception.message"
}

$domain = "hackcollege.tw"
$username = "student0"
$password =( "Hackcollege@20200" | ConvertTo-SecureString -asPlainText -Force)
$credential = New-Object System.Management.Automation.PSCredential $username,$password

function add-todomain{
    try{
        Add-Computer -DomainName $domain -Credential $credential -Restart
        add-content "c:\\log.txt" -value "$(get-date -format 'u'): add to domain successfully"
    }catch{
        add-content "c:\\log.txt" -value "$(get-date -format 'u'): $_.exception.message"
        add-todomain
    }
}
add-todomain
Restart-Computer -Force