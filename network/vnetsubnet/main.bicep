targetScope='subscription'
param rgName string = 'rg-snettest-01'
param location string = 'eastus'

param vnetName string = 'vnet-snettest-01'
param snetName string = 'snet-snettest-01'
param networkInterfaceName string = 'nic-snettest-01'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
}

module vnet 'network.bicep' = {
  scope: rg
  name: 'vnet'
  params:{
    vnetName:vnetName
    snetName:snetName
    networkInterfaceName:networkInterfaceName
    location:location
  }
}
