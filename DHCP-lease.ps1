
#increase buffer limit to unlimited
$FormatEnumerationLimit=-1
$file = "C:\scripts\output\DHCP Scopes.csv"

#Poll AD to get list of DHCP Servers
$Servers = Get-DhcpServerInDC

#create empty array
$report = @()

#Loop
foreach($Server in $Servers){

#Poll DHCP servers to get scopes
$scope = Get-DhcpServerv4Scope -ComputerName $Server.IPAddress


$lease = Get-DhcpServerv4Lease -ScopeId $scope.scopeId
#Select what objects are added to the array
$report += [pscustomobject]@{


    'Scope ID' = $scope.ScopeId
    'IPAddress' = $lease.ipaddress
    'HostName' = $Server.DnsName
    'ClientID' = $lease.clientid
    'State' = $scope.state 
}

}
$report | Export-Csv $file