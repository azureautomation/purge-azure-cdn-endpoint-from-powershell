[CmdletBinding(DefaultParameterSetName='PurgeWithoutCredentials')]
param(
    [Parameter(Position=0, ParameterSetName='PurgeWithEndpoint', ValueFromPipeline=$true, Mandatory=$true)]
    $EndPoint,

    [string]
    [Parameter(Position=0, ParameterSetName='PurgeWithCredentials', Mandatory=$true)]
    $SubscriptionId,
   
    [System.Management.Automation.PSCredential]
    [Parameter(Position=1, ParameterSetName='PurgeWithCredentials', Mandatory=$true)]
    $Credentials,

    [string]
    [Parameter(Position=2, ParameterSetName='PurgeWithCredentials', Mandatory=$true)]
    [Parameter(Position=0, ParameterSetName='PurgeWithoutCredentials', Mandatory=$true)]
    $ResourceGroupName,

    [string]
    [Parameter(Position=3, ParameterSetName='PurgeWithCredentials', Mandatory=$true)]
    [Parameter(Position=1, ParameterSetName='PurgeWithoutCredentials', Mandatory=$true)]
    $EndpointName,

    [string]
    [Parameter(Position=4, ParameterSetName='PurgeWithCredentials', Mandatory=$true)]
    [Parameter(Position=2, ParameterSetName='PurgeWithoutCredentials', Mandatory=$true)]
    $ProfileName,

    [string[]]
    [Parameter(Position=5, ParameterSetName='PurgeWithCredentials')]
    [Parameter(Position=3, ParameterSetName='PurgeWithoutCredentials')]
    [Parameter(Position=1, ParameterSetName='PurgeWithEndpoint')]
    $ContentPaths = @('/*')
)
$ErrorActionPreference = 'Stop'

switch ($PsCmdlet.ParameterSetName) {
  'PurgeWithCredentials' { 
      Write-Host ("Login into Azure Subcription '{0}' using user '{1}'" -f $SubscriptionId, $Credentials.UserName)
      Login-AzureRmAccount -Credential $Credentials -SubscriptionId $SubscriptionId
   }
   'PurgeWithEndpoint' {
    if(! ($Endpoint -is [Microsoft.Azure.Commands.Cdn.Models.Endpoint.PSEndpoint])) {
      throw "Endpoint parameter is expected to be of type 'Microsoft.Azure.Commands.Cdn.Models.Endpoint.PSEndpoint'"
    }
    else {
      $EndPoint = [Microsoft.Azure.Commands.Cdn.Models.Endpoint.PSEndpoint]$EndPoint
      $ResourceGroupName = $EndPoint.ResourceGroupName
      $ProfileName = $EndPoint.ProfileName
      $EndpointName = $EndPoint.Name
    }
   }
}

Write-Host "Purging CDN $ProfileName/$EndpointName"

#Purging CDN
Invoke-AzureRmResourceAction `
    -ResourceGroupName $ResourceGroupName `
    -ResourceType 'Microsoft.Cdn/profiles/endpoints' `
    -ResourceName $ProfileName/$EndpointName `
    -ApiVersion '2015-06-01' `
    -Action 'Purge' `
    -Parameters @{ ContentPaths = $ContentPaths } `
    -Force

Write-Host 'Purging completed'