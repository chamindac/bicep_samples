param vnetName string 
param snetName string 
param networkInterfaceName string
param location string 

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets:[
      {
        name:snetName
        properties:{
          addressPrefix:'10.0.0.0/24'
          privateEndpointNetworkPolicies:'Enabled'
          privateLinkServiceNetworkPolicies:'Enabled'
        }
      }
    ]
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' existing = {
  name: snetName
  parent: vnet
}

resource nic 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: networkInterfaceName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnet.id
          }
          privateIPAllocationMethod: 'Static'
          privateIPAddressVersion:'IPv4'
          privateIPAddress:'10.0.0.4'
        }
      }
    ]
  }
}
