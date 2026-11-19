@secure()
param vulnerabilityAssessments_Default_storageContainerPath string
param servers_sqlserver_3tier_prod_ban_name string = 'sqlserver-3tier-prod-ban'
param networkSecurityGroups_nsg_data_name string = 'nsg-data'
param networkSecurityGroups_nsg_appgw_name string = 'nsg-appgw'
param virtualNetworks_Vnet_3tier_prod_name string = 'Vnet-3tier-prod'
param sites_rg_3tier_capstone_prod_ban123_name string = 'rg-3tier-capstone-prod-ban123'
param networkSecurityGroups_nsp_webapp_name string = 'nsp-webapp'
param metricAlerts_lert_agw_5xx_errors_name string = 'lert-agw-5xx-errors'
param applicationGateways_agw_3tier_prod_name string = 'agw-3tier-prod'
param privateEndpoints_pe_sqlserver_prod_name string = 'pe-sqlserver-prod'
param publicIPAddresses_pip_agw_3tier_prod_name string = 'pip-agw-3tier-prod'
param serverfarms_ASP_rg3tiercapstoneprod_b188_name string = 'ASP-rg3tiercapstoneprod-b188'
param workspaces_law_3tier_prod_name string = 'law-3tier-prod'
param virtualNetworks_vnet_webapp_centraleast_name string = 'vnet-webapp-centraleast'
param privateDnsZones_privatelink_database_windows_net_name string = 'privatelink.database.windows.net'
param ApplicationGatewayWebApplicationFirewallPolicies_waf_policy_3tier_prod_name string = 'waf-policy-3tier-prod'

resource ApplicationGatewayWebApplicationFirewallPolicies_waf_policy_3tier_prod_name_resource 'Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies@2025-09-01' = {
  name: ApplicationGatewayWebApplicationFirewallPolicies_waf_policy_3tier_prod_name
  location: 'canadacentral'
  properties: {
    customRules: []
    policySettings: {
      requestBodyCheck: true
      maxRequestBodySizeInKb: 128
      fileUploadLimitInMb: 100
      state: 'Enabled'
      mode: 'Detection'
      requestBodyInspectLimitInKB: 128
      fileUploadEnforcement: true
      requestBodyEnforcement: true
    }
    managedRules: {
      managedRuleSets: [
        {
          ruleSetType: 'Microsoft_DefaultRuleSet'
          ruleSetVersion: '2.2'
          ruleGroupOverrides: []
        }
      ]
      exclusions: []
    }
  }
}

resource networkSecurityGroups_nsg_appgw_name_resource 'Microsoft.Network/networkSecurityGroups@2025-09-01' = {
  name: networkSecurityGroups_nsg_appgw_name
  location: 'canadacentral'
  tags: {
    Costcenter: 'IT-portfolio'
    Environment: 'Production'
    Owner: 'Betty'
    project: 'ThreeTierCapstone'
  }
  properties: {
    securityRules: [
      {
        name: 'Allow-Http-internet'
        id: networkSecurityGroups_nsg_appgw_name_Allow_Http_internet.id
        properties: {
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          priority: 100
          protocol: 'TCP'
          access: 'Allow'
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Allow-GatewayManager'
        id: networkSecurityGroups_nsg_appgw_name_Allow_GatewayManager.id
        properties: {
          sourcePortRange: '*'
          destinationPortRange: '65200-65535'
          sourceAddressPrefix: 'GatewayManager'
          destinationAddressPrefix: '*'
          priority: 110
          protocol: '*'
          access: 'Allow'
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource networkSecurityGroups_nsg_data_name_resource 'Microsoft.Network/networkSecurityGroups@2025-09-01' = {
  name: networkSecurityGroups_nsg_data_name
  location: 'canadacentral'
  tags: {
    Costcenter: 'IT-portfolio'
    Environment: 'Production'
    Owner: 'Betty'
    project: 'ThreeTierCapstone'
  }
  properties: {
    securityRules: [
      {
        name: 'Allow-WebApp-To-SQL'
        id: networkSecurityGroups_nsg_data_name_Allow_WebApp_To_SQL.id
        properties: {
          sourcePortRange: '*'
          destinationPortRange: '1433'
          sourceAddressPrefix: '10.1.1.0/24'
          destinationAddressPrefix: '10.0.3.0/24'
          priority: 100
          protocol: 'TCP'
          access: 'Allow'
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource networkSecurityGroups_nsp_webapp_name_resource 'Microsoft.Network/networkSecurityGroups@2025-09-01' = {
  name: networkSecurityGroups_nsp_webapp_name
  location: 'canadacentral'
  tags: {
    Costcenter: 'IT-portfolio'
    Environment: 'Production'
    Owner: 'Betty'
    project: 'ThreeTierCapstone'
  }
  properties: {
    securityRules: [
      {
        name: 'Allow-AppGw-To-WebApp'
        id: networkSecurityGroups_nsp_webapp_name_Allow_AppGw_To_WebApp.id
        properties: {
          sourcePortRange: '*'
          sourceAddressPrefix: '10.0.1.0/24'
          destinationAddressPrefix: '10.0.2.0/24'
          priority: 100
          protocol: 'TCP'
          access: 'Allow'
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: [
            '80'
            '443'
          ]
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource privateDnsZones_privatelink_database_windows_net_name_resource 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateDnsZones_privatelink_database_windows_net_name
  location: 'global'
  tags: {
    Costcenter: 'IT-portfolio'
    Environment: 'Production'
    Owner: 'Betty'
    project: 'ThreeTierCapstone'
  }
  properties: {}
}

resource publicIPAddresses_pip_agw_3tier_prod_name_resource 'Microsoft.Network/publicIPAddresses@2025-09-01' = {
  name: publicIPAddresses_pip_agw_3tier_prod_name
  location: 'canadacentral'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '1'
    '2'
    '3'
  ]
  properties: {
    ipAddress: '4.173.230.215'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource workspaces_law_3tier_prod_name_resource 'Microsoft.OperationalInsights/workspaces@2026-03-01' = {
  name: workspaces_law_3tier_prod_name
  location: 'canadacentral'
  tags: {
    Costcenter: 'IT-portfolio'
    Environment: 'Production'
    Owner: 'Betty'
    project: 'ThreeTierCapstone'
  }
  properties: {
    sku: {
      name: 'pergb2018'
    }
    retentionInDays: 30
    features: {
      legacy: 0
      searchVersion: 1
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    workspaceCapping: {
      dailyQuotaGb: json('-1')
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource servers_sqlserver_3tier_prod_ban_name_resource 'Microsoft.Sql/servers@2026-08-01-preview' = {
  name: servers_sqlserver_3tier_prod_ban_name
  location: 'canadacentral'
  tags: {
    Costcenter: 'IT-portfolio'
    Environment: 'Production'
    Owner: 'Betty'
    project: 'ThreeTierCapstone'
  }
  kind: 'v12.0'
  properties: {
    administratorLogin: 'pat'
    version: '12.0'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Disabled'
    administrators: {
      administratorType: 'ActiveDirectory'
      principalType: 'User'
      login: 'anfumbom12@outlook.com'
      sid: 'cce919f3-7c71-40fe-b3b2-7423cb557088'
      tenantId: '73ede107-6fff-4721-87b5-06b3979de425'
      azureADOnlyAuthentication: false
    }
    restrictOutboundNetworkAccess: 'Disabled'
    retentionDays: -1
  }
}

resource serverfarms_ASP_rg3tiercapstoneprod_b188_name_resource 'Microsoft.Web/serverfarms@2024-11-01' = {
  name: serverfarms_ASP_rg3tiercapstoneprod_b188_name
  location: 'Canada East'
  tags: {
    Costcenter: 'IT-portfolio'
    Environment: 'Production'
    Owner: 'Betty'
    project: 'ThreeTierCapstone'
  }
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
    family: 'B'
    capacity: 1
  }
  kind: 'linux'
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: true
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
    asyncScalingEnabled: false
  }
}

resource metricAlerts_lert_agw_5xx_errors_name_resource 'microsoft.insights/metricAlerts@2026-01-01' = {
  name: metricAlerts_lert_agw_5xx_errors_name
  location: 'global'
  tags: {
    Costcenter: 'IT-portfolio'
    Environment: 'Production'
    Owner: 'Betty'
    project: 'ThreeTierCapstone'
  }
  properties: {
    severity: 3
    enabled: true
    scopes: [
      applicationGateways_agw_3tier_prod_name_resource.id
    ]
    evaluationFrequency: 'PT1M'
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/applicationGateways'
    targetResourceRegion: 'canadacentral'
    actions: []
    windowSize: 'PT5M'
    criteria: {
      allOf: [
        {
          operator: 'GreaterThan'
          threshold: json('5')
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/applicationGateways'
          metricName: 'FailedRequests'
          dimensions: []
          timeAggregation: 'Total'
          skipMetricValidation: false
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
  }
}

resource networkSecurityGroups_nsp_webapp_name_Allow_AppGw_To_WebApp 'Microsoft.Network/networkSecurityGroups/securityRules@2025-09-01' = {
  name: '${networkSecurityGroups_nsp_webapp_name}/Allow-AppGw-To-WebApp'
  properties: {
    sourcePortRange: '*'
    sourceAddressPrefix: '10.0.1.0/24'
    destinationAddressPrefix: '10.0.2.0/24'
    priority: 100
    protocol: 'TCP'
    access: 'Allow'
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: [
      '80'
      '443'
    ]
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsp_webapp_name_resource
  ]
}

resource networkSecurityGroups_nsg_appgw_name_Allow_GatewayManager 'Microsoft.Network/networkSecurityGroups/securityRules@2025-09-01' = {
  name: '${networkSecurityGroups_nsg_appgw_name}/Allow-GatewayManager'
  properties: {
    sourcePortRange: '*'
    destinationPortRange: '65200-65535'
    sourceAddressPrefix: 'GatewayManager'
    destinationAddressPrefix: '*'
    priority: 110
    protocol: '*'
    access: 'Allow'
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_appgw_name_resource
  ]
}

resource networkSecurityGroups_nsg_appgw_name_Allow_Http_internet 'Microsoft.Network/networkSecurityGroups/securityRules@2025-09-01' = {
  name: '${networkSecurityGroups_nsg_appgw_name}/Allow-Http-internet'
  properties: {
    sourcePortRange: '*'
    destinationPortRange: '80'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    priority: 100
    protocol: 'TCP'
    access: 'Allow'
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_appgw_name_resource
  ]
}

resource networkSecurityGroups_nsg_data_name_Allow_WebApp_To_SQL 'Microsoft.Network/networkSecurityGroups/securityRules@2025-09-01' = {
  name: '${networkSecurityGroups_nsg_data_name}/Allow-WebApp-To-SQL'
  properties: {
    sourcePortRange: '*'
    destinationPortRange: '1433'
    sourceAddressPrefix: '10.1.1.0/24'
    destinationAddressPrefix: '10.0.3.0/24'
    priority: 100
    protocol: 'TCP'
    access: 'Allow'
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_data_name_resource
  ]
}

resource privateDnsZones_privatelink_database_windows_net_name_sqlserver_3tier_prod_ban 'Microsoft.Network/privateDnsZones/A@2024-06-01' = {
  parent: privateDnsZones_privatelink_database_windows_net_name_resource
  name: 'sqlserver-3tier-prod-ban'
  properties: {
    metadata: {
      creator: 'created by private endpoint pe-sqlserver-prod with resource guid 328e14a3-6ed0-460e-a7cf-fa7853d13b31'
    }
    ttl: 10
    aRecords: [
      {
        ipv4Address: '10.0.3.4'
      }
    ]
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_database_windows_net_name 'Microsoft.Network/privateDnsZones/SOA@2024-06-01' = {
  parent: privateDnsZones_privatelink_database_windows_net_name_resource
  name: '@'
  properties: {
    ttl: 3600
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
  }
}

resource virtualNetworks_vnet_webapp_centraleast_name_resource 'Microsoft.Network/virtualNetworks@2025-09-01' = {
  name: virtualNetworks_vnet_webapp_centraleast_name
  location: 'canadaeast'
  tags: {
    Costcenter: 'IT-portfolio'
    Environment: 'Production'
    Owner: 'Betty'
    project: 'ThreeTierCapstone'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'snet-webapp-ce'
        id: virtualNetworks_vnet_webapp_centraleast_name_snet_webapp_ce.id
        properties: {
          addressPrefixes: [
            '10.1.1.0/24'
          ]
          delegations: [
            {
              name: 'Microsoft.Web/serverFarms'
              id: '${virtualNetworks_vnet_webapp_centraleast_name_snet_webapp_ce.id}/delegations/Microsoft.Web/serverFarms'
              properties: {
                serviceName: 'Microsoft.Web/serverFarms'
              }
              type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
            }
          ]
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
      }
    ]
    virtualNetworkPeerings: [
      {
        name: 'pee-ce-cc'
        id: virtualNetworks_vnet_webapp_centraleast_name_pee_ce_cc.id
        properties: {
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteVirtualNetwork: {
            id: virtualNetworks_Vnet_3tier_prod_name_resource.id
          }
          allowVirtualNetworkAccess: true
          allowForwardedTraffic: false
          allowGatewayTransit: false
          useRemoteGateways: false
          doNotVerifyRemoteGateways: false
          peerCompleteVnets: true
          enableOnlyIPv6Peering: false
          remoteAddressSpace: {
            addressPrefixes: [
              '10.0.0.0/16'
            ]
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '10.0.0.0/16'
            ]
          }
        }
      }
    ]
    enableDdosProtection: false
  }
}

resource virtualNetworks_vnet_webapp_centraleast_name_snet_webapp_ce 'Microsoft.Network/virtualNetworks/subnets@2025-09-01' = {
  name: '${virtualNetworks_vnet_webapp_centraleast_name}/snet-webapp-ce'
  properties: {
    addressPrefixes: [
      '10.1.1.0/24'
    ]
    delegations: [
      {
        name: 'Microsoft.Web/serverFarms'
        id: '${virtualNetworks_vnet_webapp_centraleast_name_snet_webapp_ce.id}/delegations/Microsoft.Web/serverFarms'
        properties: {
          serviceName: 'Microsoft.Web/serverFarms'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
      }
    ]
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_vnet_webapp_centraleast_name_resource
  ]
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_General_AlphabeticallySortedComputers 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_General|AlphabeticallySortedComputers'
  properties: {
    category: 'General Exploration'
    displayName: 'All Computers with their most recent data'
    version: 2
    query: 'search not(ObjectName == "Advisor Metrics" or ObjectName == "ManagedSpace") | summarize AggregatedValue = max(TimeGenerated) by Computer | limit 500000 | sort by Computer asc\r\n// Oql: NOT(ObjectName="Advisor Metrics" OR ObjectName=ManagedSpace) | measure max(TimeGenerated) by Computer | top 500000 | Sort Computer // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_General_dataPointsPerManagementGroup 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_General|dataPointsPerManagementGroup'
  properties: {
    category: 'General Exploration'
    displayName: 'Which Management Group is generating the most data points?'
    version: 2
    query: 'search * | summarize AggregatedValue = count() by ManagementGroupName\r\n// Oql: * | Measure count() by ManagementGroupName // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_General_dataTypeDistribution 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_General|dataTypeDistribution'
  properties: {
    category: 'General Exploration'
    displayName: 'Distribution of data Types'
    version: 2
    query: 'search * | extend Type = $table | summarize AggregatedValue = count() by Type\r\n// Oql: * | Measure count() by Type // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_General_StaleComputers 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_General|StaleComputers'
  properties: {
    category: 'General Exploration'
    displayName: 'Stale Computers (data older than 24 hours)'
    version: 2
    query: 'search not(ObjectName == "Advisor Metrics" or ObjectName == "ManagedSpace") | summarize lastdata = max(TimeGenerated) by Computer | limit 500000 | where lastdata < ago(24h)\r\n// Oql: NOT(ObjectName="Advisor Metrics" OR ObjectName=ManagedSpace) | measure max(TimeGenerated) as lastdata by Computer | top 500000 | where lastdata < NOW-24HOURS // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_AllEvents 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|AllEvents'
  properties: {
    category: 'Log Management'
    displayName: 'All Events'
    version: 2
    query: 'Event | sort by TimeGenerated desc\r\n// Oql: Type=Event // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_AllSyslog 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|AllSyslog'
  properties: {
    category: 'Log Management'
    displayName: 'All Syslogs'
    version: 2
    query: 'Syslog | sort by TimeGenerated desc\r\n// Oql: Type=Syslog // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_AllSyslogByFacility 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|AllSyslogByFacility'
  properties: {
    category: 'Log Management'
    displayName: 'All Syslog Records grouped by Facility'
    version: 2
    query: 'Syslog | summarize AggregatedValue = count() by Facility\r\n// Oql: Type=Syslog | Measure count() by Facility // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_AllSyslogByProcess 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|AllSyslogByProcessName'
  properties: {
    category: 'Log Management'
    displayName: 'All Syslog Records grouped by ProcessName'
    version: 2
    query: 'Syslog | summarize AggregatedValue = count() by ProcessName\r\n// Oql: Type=Syslog | Measure count() by ProcessName // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_AllSyslogsWithErrors 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|AllSyslogsWithErrors'
  properties: {
    category: 'Log Management'
    displayName: 'All Syslog Records with Errors'
    version: 2
    query: 'Syslog | where SeverityLevel == "error" | sort by TimeGenerated desc\r\n// Oql: Type=Syslog SeverityLevel=error // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_AverageHTTPRequestTimeByClientIPAddress 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|AverageHTTPRequestTimeByClientIPAddress'
  properties: {
    category: 'Log Management'
    displayName: 'Average HTTP Request time by Client IP Address'
    version: 2
    query: 'search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = avg(TimeTaken) by cIP\r\n// Oql: Type=W3CIISLog | Measure Avg(TimeTaken) by cIP // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_AverageHTTPRequestTimeHTTPMethod 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|AverageHTTPRequestTimeHTTPMethod'
  properties: {
    category: 'Log Management'
    displayName: 'Average HTTP Request time by HTTP Method'
    version: 2
    query: 'search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = avg(TimeTaken) by csMethod\r\n// Oql: Type=W3CIISLog | Measure Avg(TimeTaken) by csMethod // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_CountIISLogEntriesClientIPAddress 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|CountIISLogEntriesClientIPAddress'
  properties: {
    category: 'Log Management'
    displayName: 'Count of IIS Log Entries by Client IP Address'
    version: 2
    query: 'search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by cIP\r\n// Oql: Type=W3CIISLog | Measure count() by cIP // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_CountIISLogEntriesHTTPRequestMethod 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|CountIISLogEntriesHTTPRequestMethod'
  properties: {
    category: 'Log Management'
    displayName: 'Count of IIS Log Entries by HTTP Request Method'
    version: 2
    query: 'search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by csMethod\r\n// Oql: Type=W3CIISLog | Measure count() by csMethod // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_CountIISLogEntriesHTTPUserAgent 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|CountIISLogEntriesHTTPUserAgent'
  properties: {
    category: 'Log Management'
    displayName: 'Count of IIS Log Entries by HTTP User Agent'
    version: 2
    query: 'search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by csUserAgent\r\n// Oql: Type=W3CIISLog | Measure count() by csUserAgent // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_CountOfIISLogEntriesByHostRequestedByClient 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|CountOfIISLogEntriesByHostRequestedByClient'
  properties: {
    category: 'Log Management'
    displayName: 'Count of IIS Log Entries by Host requested by client'
    version: 2
    query: 'search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by csHost\r\n// Oql: Type=W3CIISLog | Measure count() by csHost // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_CountOfIISLogEntriesByURLForHost 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|CountOfIISLogEntriesByURLForHost'
  properties: {
    category: 'Log Management'
    displayName: 'Count of IIS Log Entries by URL for the host "www.contoso.com" (replace with your own)'
    version: 2
    query: 'search csHost == "www.contoso.com" | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by csUriStem\r\n// Oql: Type=W3CIISLog csHost="www.contoso.com" | Measure count() by csUriStem // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_CountOfIISLogEntriesByURLRequestedByClient 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|CountOfIISLogEntriesByURLRequestedByClient'
  properties: {
    category: 'Log Management'
    displayName: 'Count of IIS Log Entries by URL requested by client (without query strings)'
    version: 2
    query: 'search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by csUriStem\r\n// Oql: Type=W3CIISLog | Measure count() by csUriStem // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_CountOfWarningEvents 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|CountOfWarningEvents'
  properties: {
    category: 'Log Management'
    displayName: 'Count of Events with level "Warning" grouped by Event ID'
    version: 2
    query: 'Event | where EventLevelName == "warning" | summarize AggregatedValue = count() by EventID\r\n// Oql: Type=Event EventLevelName=warning | Measure count() by EventID // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_DisplayBreakdownRespondCodes 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|DisplayBreakdownRespondCodes'
  properties: {
    category: 'Log Management'
    displayName: 'Shows breakdown of response codes'
    version: 2
    query: 'search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by scStatus\r\n// Oql: Type=W3CIISLog | Measure count() by scStatus // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_EventsByEventLog 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|EventsByEventLog'
  properties: {
    category: 'Log Management'
    displayName: 'Count of Events grouped by Event Log'
    version: 2
    query: 'Event | summarize AggregatedValue = count() by EventLog\r\n// Oql: Type=Event | Measure count() by EventLog // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_EventsByEventsID 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|EventsByEventsID'
  properties: {
    category: 'Log Management'
    displayName: 'Count of Events grouped by Event ID'
    version: 2
    query: 'Event | summarize AggregatedValue = count() by EventID\r\n// Oql: Type=Event | Measure count() by EventID // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_EventsByEventSource 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|EventsByEventSource'
  properties: {
    category: 'Log Management'
    displayName: 'Count of Events grouped by Event Source'
    version: 2
    query: 'Event | summarize AggregatedValue = count() by Source\r\n// Oql: Type=Event | Measure count() by Source // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_EventsInOMBetween2000to3000 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|EventsInOMBetween2000to3000'
  properties: {
    category: 'Log Management'
    displayName: 'Events in the Operations Manager Event Log whose Event ID is in the range between 2000 and 3000'
    version: 2
    query: 'Event | where EventLog == "Operations Manager" and EventID >= 2000 and EventID <= 3000 | sort by TimeGenerated desc\r\n// Oql: Type=Event EventLog="Operations Manager" EventID:[2000..3000] // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_EventsWithStartedinEventID 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|EventsWithStartedinEventID'
  properties: {
    category: 'Log Management'
    displayName: 'Count of Events containing the word "started" grouped by EventID'
    version: 2
    query: 'search in (Event) "started" | summarize AggregatedValue = count() by EventID\r\n// Oql: Type=Event "started" | Measure count() by EventID // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_FindMaximumTimeTakenForEachPage 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|FindMaximumTimeTakenForEachPage'
  properties: {
    category: 'Log Management'
    displayName: 'Find the maximum time taken for each page'
    version: 2
    query: 'search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = max(TimeTaken) by csUriStem\r\n// Oql: Type=W3CIISLog | Measure Max(TimeTaken) by csUriStem // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_IISLogEntriesForClientIP 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|IISLogEntriesForClientIP'
  properties: {
    category: 'Log Management'
    displayName: 'IIS Log Entries for a specific client IP Address (replace with your own)'
    version: 2
    query: 'search cIP == "192.168.0.1" | extend Type = $table | where Type == W3CIISLog | sort by TimeGenerated desc | project csUriStem, scBytes, csBytes, TimeTaken, scStatus\r\n// Oql: Type=W3CIISLog cIP="192.168.0.1" | Select csUriStem,scBytes,csBytes,TimeTaken,scStatus // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_ListAllIISLogEntries 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|ListAllIISLogEntries'
  properties: {
    category: 'Log Management'
    displayName: 'All IIS Log Entries'
    version: 2
    query: 'search * | extend Type = $table | where Type == W3CIISLog | sort by TimeGenerated desc\r\n// Oql: Type=W3CIISLog // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_NoOfConnectionsToOMSDKService 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|NoOfConnectionsToOMSDKService'
  properties: {
    category: 'Log Management'
    displayName: 'How many connections to Operations Manager\'s SDK service by day'
    version: 2
    query: 'Event | where EventID == 26328 and EventLog == "Operations Manager" | summarize AggregatedValue = count() by bin(TimeGenerated, 1d) | sort by TimeGenerated desc\r\n// Oql: Type=Event EventID=26328 EventLog="Operations Manager" | Measure count() interval 1DAY // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_ServerRestartTime 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|ServerRestartTime'
  properties: {
    category: 'Log Management'
    displayName: 'When did my servers initiate restart?'
    version: 2
    query: 'search in (Event) "shutdown" and EventLog == "System" and Source == "User32" and EventID == 1074 | sort by TimeGenerated desc | project TimeGenerated, Computer\r\n// Oql: shutdown Type=Event EventLog=System Source=User32 EventID=1074 | Select TimeGenerated,Computer // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_Show404PagesList 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|Show404PagesList'
  properties: {
    category: 'Log Management'
    displayName: 'Shows which pages people are getting a 404 for'
    version: 2
    query: 'search scStatus == 404 | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by csUriStem\r\n// Oql: Type=W3CIISLog scStatus=404 | Measure count() by csUriStem // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_ShowServersThrowingInternalServerError 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|ShowServersThrowingInternalServerError'
  properties: {
    category: 'Log Management'
    displayName: 'Shows servers that are throwing internal server error'
    version: 2
    query: 'search scStatus == 500 | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by sComputerName\r\n// Oql: Type=W3CIISLog scStatus=500 | Measure count() by sComputerName // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_TotalBytesReceivedByEachAzureRoleInstance 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|TotalBytesReceivedByEachAzureRoleInstance'
  properties: {
    category: 'Log Management'
    displayName: 'Total Bytes received by each Azure Role Instance'
    version: 2
    query: 'search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = sum(csBytes) by RoleInstance\r\n// Oql: Type=W3CIISLog | Measure Sum(csBytes) by RoleInstance // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_TotalBytesReceivedByEachIISComputer 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|TotalBytesReceivedByEachIISComputer'
  properties: {
    category: 'Log Management'
    displayName: 'Total Bytes received by each IIS Computer'
    version: 2
    query: 'search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = sum(csBytes) by Computer | limit 500000\r\n// Oql: Type=W3CIISLog | Measure Sum(csBytes) by Computer | top 500000 // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_TotalBytesRespondedToClientsByClientIPAddress 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|TotalBytesRespondedToClientsByClientIPAddress'
  properties: {
    category: 'Log Management'
    displayName: 'Total Bytes responded back to clients by Client IP Address'
    version: 2
    query: 'search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = sum(scBytes) by cIP\r\n// Oql: Type=W3CIISLog | Measure Sum(scBytes) by cIP // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_TotalBytesRespondedToClientsByEachIISServerIPAddress 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|TotalBytesRespondedToClientsByEachIISServerIPAddress'
  properties: {
    category: 'Log Management'
    displayName: 'Total Bytes responded back to clients by each IIS ServerIP Address'
    version: 2
    query: 'search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = sum(scBytes) by sIP\r\n// Oql: Type=W3CIISLog | Measure Sum(scBytes) by sIP // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_TotalBytesSentByClientIPAddress 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|TotalBytesSentByClientIPAddress'
  properties: {
    category: 'Log Management'
    displayName: 'Total Bytes sent by Client IP Address'
    version: 2
    query: 'search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = sum(csBytes) by cIP\r\n// Oql: Type=W3CIISLog | Measure Sum(csBytes) by cIP // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_WarningEvents 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|WarningEvents'
  properties: {
    category: 'Log Management'
    displayName: 'All Events with level "Warning"'
    version: 2
    query: 'Event | where EventLevelName == "warning" | sort by TimeGenerated desc\r\n// Oql: Type=Event EventLevelName=warning // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_WindowsFireawallPolicySettingsChanged 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|WindowsFireawallPolicySettingsChanged'
  properties: {
    category: 'Log Management'
    displayName: 'Windows Firewall Policy settings have changed'
    version: 2
    query: 'Event | where EventLog == "Microsoft-Windows-Windows Firewall With Advanced Security/Firewall" and EventID == 2008 | sort by TimeGenerated desc\r\n// Oql: Type=Event EventLog="Microsoft-Windows-Windows Firewall With Advanced Security/Firewall" EventID=2008 // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_LogManagement_workspaces_law_3tier_prod_name_LogManagement_WindowsFireawallPolicySettingsChangedByMachines 'Microsoft.OperationalInsights/workspaces/savedSearches@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogManagement(${workspaces_law_3tier_prod_name})_LogManagement|WindowsFireawallPolicySettingsChangedByMachines'
  properties: {
    category: 'Log Management'
    displayName: 'On which machines and how many times have Windows Firewall Policy settings changed'
    version: 2
    query: 'Event | where EventLog == "Microsoft-Windows-Windows Firewall With Advanced Security/Firewall" and EventID == 2008 | summarize AggregatedValue = count() by Computer | limit 500000\r\n// Oql: Type=Event EventLog="Microsoft-Windows-Windows Firewall With Advanced Security/Firewall" EventID=2008 | measure count() by Computer | top 500000 // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
  }
}

resource workspaces_law_3tier_prod_name_AACAudit 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AACAudit'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AACAudit'
      displayName: 'AACAudit'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AACHttpRequest 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AACHttpRequest'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AACHttpRequest'
      displayName: 'AACHttpRequest'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADAgentRiskEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADAgentRiskEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADAgentRiskEvents'
      displayName: 'AADAgentRiskEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADB2CRequestLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADB2CRequestLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADB2CRequestLogs'
      displayName: 'AADB2CRequestLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADCustomSecurityAttributeAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADCustomSecurityAttributeAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADCustomSecurityAttributeAuditLogs'
      displayName: 'AADCustomSecurityAttributeAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADDomainServicesAccountLogon 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADDomainServicesAccountLogon'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADDomainServicesAccountLogon'
      displayName: 'AADDomainServicesAccountLogon'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADDomainServicesAccountManagement 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADDomainServicesAccountManagement'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADDomainServicesAccountManagement'
      displayName: 'AADDomainServicesAccountManagement'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADDomainServicesDirectoryServiceAccess 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADDomainServicesDirectoryServiceAccess'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADDomainServicesDirectoryServiceAccess'
      displayName: 'AADDomainServicesDirectoryServiceAccess'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADDomainServicesDNSAuditsDynamicUpdates 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADDomainServicesDNSAuditsDynamicUpdates'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADDomainServicesDNSAuditsDynamicUpdates'
      displayName: 'AADDomainServicesDNSAuditsDynamicUpdates'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADDomainServicesDNSAuditsGeneral 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADDomainServicesDNSAuditsGeneral'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADDomainServicesDNSAuditsGeneral'
      displayName: 'AADDomainServicesDNSAuditsGeneral'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADDomainServicesLogonLogoff 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADDomainServicesLogonLogoff'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADDomainServicesLogonLogoff'
      displayName: 'AADDomainServicesLogonLogoff'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADDomainServicesPolicyChange 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADDomainServicesPolicyChange'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADDomainServicesPolicyChange'
      displayName: 'AADDomainServicesPolicyChange'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADDomainServicesPrivilegeUse 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADDomainServicesPrivilegeUse'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADDomainServicesPrivilegeUse'
      displayName: 'AADDomainServicesPrivilegeUse'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADDomainServicesSystemSecurity 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADDomainServicesSystemSecurity'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADDomainServicesSystemSecurity'
      displayName: 'AADDomainServicesSystemSecurity'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADFirstPartyToFirstPartySignInLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADFirstPartyToFirstPartySignInLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADFirstPartyToFirstPartySignInLogs'
      displayName: 'AADFirstPartyToFirstPartySignInLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADGraphActivityLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADGraphActivityLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADGraphActivityLogs'
      displayName: 'AADGraphActivityLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADManagedIdentitySignInLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADManagedIdentitySignInLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADManagedIdentitySignInLogs'
      displayName: 'AADManagedIdentitySignInLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADNonInteractiveUserSignInLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADNonInteractiveUserSignInLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADNonInteractiveUserSignInLogs'
      displayName: 'AADNonInteractiveUserSignInLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADProvisioningLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADProvisioningLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADProvisioningLogs'
      displayName: 'AADProvisioningLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADRiskyAgents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADRiskyAgents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADRiskyAgents'
      displayName: 'AADRiskyAgents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADRiskyServicePrincipals 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADRiskyServicePrincipals'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADRiskyServicePrincipals'
      displayName: 'AADRiskyServicePrincipals'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADRiskyUsers 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADRiskyUsers'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADRiskyUsers'
      displayName: 'AADRiskyUsers'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADServicePrincipalRiskEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADServicePrincipalRiskEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADServicePrincipalRiskEvents'
      displayName: 'AADServicePrincipalRiskEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADServicePrincipalSignInLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADServicePrincipalSignInLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADServicePrincipalSignInLogs'
      displayName: 'AADServicePrincipalSignInLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AADUserRiskEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AADUserRiskEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AADUserRiskEvents'
      displayName: 'AADUserRiskEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ABSBotRequests 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ABSBotRequests'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ABSBotRequests'
      displayName: 'ABSBotRequests'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACICollaborationAudit 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACICollaborationAudit'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACICollaborationAudit'
      displayName: 'ACICollaborationAudit'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACLTransactionLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACLTransactionLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACLTransactionLogs'
      displayName: 'ACLTransactionLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACLUserDefinedLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACLUserDefinedLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACLUserDefinedLogs'
      displayName: 'ACLUserDefinedLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACRConnectedClientList 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACRConnectedClientList'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACRConnectedClientList'
      displayName: 'ACRConnectedClientList'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACREntraAuthenticationAuditLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACREntraAuthenticationAuditLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACREntraAuthenticationAuditLog'
      displayName: 'ACREntraAuthenticationAuditLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSAdvancedMessagingOperations 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSAdvancedMessagingOperations'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSAdvancedMessagingOperations'
      displayName: 'ACSAdvancedMessagingOperations'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSAuthIncomingOperations 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSAuthIncomingOperations'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSAuthIncomingOperations'
      displayName: 'ACSAuthIncomingOperations'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSBillingUsage 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSBillingUsage'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSBillingUsage'
      displayName: 'ACSBillingUsage'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSCallAutomationIncomingOperations 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSCallAutomationIncomingOperations'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSCallAutomationIncomingOperations'
      displayName: 'ACSCallAutomationIncomingOperations'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSCallAutomationMediaSummary 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSCallAutomationMediaSummary'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSCallAutomationMediaSummary'
      displayName: 'ACSCallAutomationMediaSummary'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSCallAutomationStreamingUsage 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSCallAutomationStreamingUsage'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSCallAutomationStreamingUsage'
      displayName: 'ACSCallAutomationStreamingUsage'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSCallClientMediaStatsTimeSeries 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSCallClientMediaStatsTimeSeries'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSCallClientMediaStatsTimeSeries'
      displayName: 'ACSCallClientMediaStatsTimeSeries'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSCallClientOperations 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSCallClientOperations'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSCallClientOperations'
      displayName: 'ACSCallClientOperations'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSCallClientServiceRequestAndOutcome 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSCallClientServiceRequestAndOutcome'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSCallClientServiceRequestAndOutcome'
      displayName: 'ACSCallClientServiceRequestAndOutcome'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSCallClosedCaptionsSummary 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSCallClosedCaptionsSummary'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSCallClosedCaptionsSummary'
      displayName: 'ACSCallClosedCaptionsSummary'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSCallDiagnostics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSCallDiagnostics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSCallDiagnostics'
      displayName: 'ACSCallDiagnostics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSCallDiagnosticsUpdates 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSCallDiagnosticsUpdates'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSCallDiagnosticsUpdates'
      displayName: 'ACSCallDiagnosticsUpdates'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSCallingMetrics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSCallingMetrics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSCallingMetrics'
      displayName: 'ACSCallingMetrics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSCallRecordingIncomingOperations 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSCallRecordingIncomingOperations'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSCallRecordingIncomingOperations'
      displayName: 'ACSCallRecordingIncomingOperations'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSCallRecordingSummary 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSCallRecordingSummary'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSCallRecordingSummary'
      displayName: 'ACSCallRecordingSummary'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSCallSummary 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSCallSummary'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSCallSummary'
      displayName: 'ACSCallSummary'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSCallSummaryUpdates 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSCallSummaryUpdates'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSCallSummaryUpdates'
      displayName: 'ACSCallSummaryUpdates'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSCallSurvey 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSCallSurvey'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSCallSurvey'
      displayName: 'ACSCallSurvey'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSChatIncomingOperations 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSChatIncomingOperations'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSChatIncomingOperations'
      displayName: 'ACSChatIncomingOperations'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSEmailSendMailOperational 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSEmailSendMailOperational'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSEmailSendMailOperational'
      displayName: 'ACSEmailSendMailOperational'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSEmailStatusUpdateOperational 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSEmailStatusUpdateOperational'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSEmailStatusUpdateOperational'
      displayName: 'ACSEmailStatusUpdateOperational'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSEmailUserEngagementOperational 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSEmailUserEngagementOperational'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSEmailUserEngagementOperational'
      displayName: 'ACSEmailUserEngagementOperational'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSJobRouterIncomingOperations 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSJobRouterIncomingOperations'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSJobRouterIncomingOperations'
      displayName: 'ACSJobRouterIncomingOperations'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSOptOutManagementOperations 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSOptOutManagementOperations'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSOptOutManagementOperations'
      displayName: 'ACSOptOutManagementOperations'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSRoomsIncomingOperations 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSRoomsIncomingOperations'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSRoomsIncomingOperations'
      displayName: 'ACSRoomsIncomingOperations'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ACSSMSIncomingOperations 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ACSSMSIncomingOperations'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ACSSMSIncomingOperations'
      displayName: 'ACSSMSIncomingOperations'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADAssessmentRecommendation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADAssessmentRecommendation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADAssessmentRecommendation'
      displayName: 'ADAssessmentRecommendation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AddonAzureBackupAlerts 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AddonAzureBackupAlerts'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AddonAzureBackupAlerts'
      displayName: 'AddonAzureBackupAlerts'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AddonAzureBackupJobs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AddonAzureBackupJobs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AddonAzureBackupJobs'
      displayName: 'AddonAzureBackupJobs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AddonAzureBackupPolicy 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AddonAzureBackupPolicy'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AddonAzureBackupPolicy'
      displayName: 'AddonAzureBackupPolicy'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AddonAzureBackupProtectedInstance 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AddonAzureBackupProtectedInstance'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AddonAzureBackupProtectedInstance'
      displayName: 'AddonAzureBackupProtectedInstance'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AddonAzureBackupStorage 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AddonAzureBackupStorage'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AddonAzureBackupStorage'
      displayName: 'AddonAzureBackupStorage'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADFActivityRun 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADFActivityRun'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADFActivityRun'
      displayName: 'ADFActivityRun'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADFAirflowSchedulerLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADFAirflowSchedulerLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADFAirflowSchedulerLogs'
      displayName: 'ADFAirflowSchedulerLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADFAirflowTaskLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADFAirflowTaskLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADFAirflowTaskLogs'
      displayName: 'ADFAirflowTaskLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADFAirflowWebLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADFAirflowWebLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADFAirflowWebLogs'
      displayName: 'ADFAirflowWebLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADFAirflowWorkerLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADFAirflowWorkerLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADFAirflowWorkerLogs'
      displayName: 'ADFAirflowWorkerLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADFPipelineRun 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADFPipelineRun'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADFPipelineRun'
      displayName: 'ADFPipelineRun'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADFSandboxActivityRun 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADFSandboxActivityRun'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADFSandboxActivityRun'
      displayName: 'ADFSandboxActivityRun'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADFSandboxPipelineRun 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADFSandboxPipelineRun'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADFSandboxPipelineRun'
      displayName: 'ADFSandboxPipelineRun'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADFSSignInLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADFSSignInLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADFSSignInLogs'
      displayName: 'ADFSSignInLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADFSSISIntegrationRuntimeLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADFSSISIntegrationRuntimeLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADFSSISIntegrationRuntimeLogs'
      displayName: 'ADFSSISIntegrationRuntimeLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADFSSISPackageEventMessageContext 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADFSSISPackageEventMessageContext'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADFSSISPackageEventMessageContext'
      displayName: 'ADFSSISPackageEventMessageContext'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADFSSISPackageEventMessages 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADFSSISPackageEventMessages'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADFSSISPackageEventMessages'
      displayName: 'ADFSSISPackageEventMessages'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADFSSISPackageExecutableStatistics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADFSSISPackageExecutableStatistics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADFSSISPackageExecutableStatistics'
      displayName: 'ADFSSISPackageExecutableStatistics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADFSSISPackageExecutionComponentPhases 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADFSSISPackageExecutionComponentPhases'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADFSSISPackageExecutionComponentPhases'
      displayName: 'ADFSSISPackageExecutionComponentPhases'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADFSSISPackageExecutionDataStatistics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADFSSISPackageExecutionDataStatistics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADFSSISPackageExecutionDataStatistics'
      displayName: 'ADFSSISPackageExecutionDataStatistics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADFTriggerRun 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADFTriggerRun'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADFTriggerRun'
      displayName: 'ADFTriggerRun'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADGSyslogEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADGSyslogEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADGSyslogEvent'
      displayName: 'ADGSyslogEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADReplicationResult 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADReplicationResult'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADReplicationResult'
      displayName: 'ADReplicationResult'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADSecurityAssessmentRecommendation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADSecurityAssessmentRecommendation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADSecurityAssessmentRecommendation'
      displayName: 'ADSecurityAssessmentRecommendation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADTDataHistoryOperation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADTDataHistoryOperation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADTDataHistoryOperation'
      displayName: 'ADTDataHistoryOperation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADTDigitalTwinsOperation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADTDigitalTwinsOperation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADTDigitalTwinsOperation'
      displayName: 'ADTDigitalTwinsOperation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADTEventRoutesOperation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADTEventRoutesOperation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADTEventRoutesOperation'
      displayName: 'ADTEventRoutesOperation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADTModelsOperation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADTModelsOperation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADTModelsOperation'
      displayName: 'ADTModelsOperation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADTQueryOperation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADTQueryOperation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADTQueryOperation'
      displayName: 'ADTQueryOperation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADXCommand 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADXCommand'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADXCommand'
      displayName: 'ADXCommand'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADXDataOperation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADXDataOperation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADXDataOperation'
      displayName: 'ADXDataOperation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADXIngestionBatching 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADXIngestionBatching'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADXIngestionBatching'
      displayName: 'ADXIngestionBatching'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADXJournal 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADXJournal'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADXJournal'
      displayName: 'ADXJournal'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADXQuery 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADXQuery'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADXQuery'
      displayName: 'ADXQuery'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADXTableDetails 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADXTableDetails'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADXTableDetails'
      displayName: 'ADXTableDetails'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ADXTableUsageStatistics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ADXTableUsageStatistics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ADXTableUsageStatistics'
      displayName: 'ADXTableUsageStatistics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AegDataPlaneRequests 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AegDataPlaneRequests'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AegDataPlaneRequests'
      displayName: 'AegDataPlaneRequests'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AegDeliveryFailureLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AegDeliveryFailureLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AegDeliveryFailureLogs'
      displayName: 'AegDeliveryFailureLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AegPublishFailureLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AegPublishFailureLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AegPublishFailureLogs'
      displayName: 'AegPublishFailureLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AEWAssignmentBlobLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AEWAssignmentBlobLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AEWAssignmentBlobLogs'
      displayName: 'AEWAssignmentBlobLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AEWAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AEWAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AEWAuditLogs'
      displayName: 'AEWAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AEWComputePipelinesLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AEWComputePipelinesLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AEWComputePipelinesLogs'
      displayName: 'AEWComputePipelinesLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AEWExperimentAssignmentSummary 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AEWExperimentAssignmentSummary'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AEWExperimentAssignmentSummary'
      displayName: 'AEWExperimentAssignmentSummary'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AEWExperimentScorecardMetricPairs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AEWExperimentScorecardMetricPairs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AEWExperimentScorecardMetricPairs'
      displayName: 'AEWExperimentScorecardMetricPairs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AEWExperimentScorecards 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AEWExperimentScorecards'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AEWExperimentScorecards'
      displayName: 'AEWExperimentScorecards'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AFSAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AFSAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AFSAuditLogs'
      displayName: 'AFSAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AGCAccessLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AGCAccessLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AGCAccessLogs'
      displayName: 'AGCAccessLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AGCFirewallLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AGCFirewallLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AGCFirewallLogs'
      displayName: 'AGCFirewallLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AgentFabricFlowLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AgentFabricFlowLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AgentFabricFlowLogs'
      displayName: 'AgentFabricFlowLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AgriFoodApplicationAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AgriFoodApplicationAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AgriFoodApplicationAuditLogs'
      displayName: 'AgriFoodApplicationAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AgriFoodFarmManagementLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AgriFoodFarmManagementLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AgriFoodFarmManagementLogs'
      displayName: 'AgriFoodFarmManagementLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AgriFoodFarmOperationLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AgriFoodFarmOperationLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AgriFoodFarmOperationLogs'
      displayName: 'AgriFoodFarmOperationLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AgriFoodInsightLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AgriFoodInsightLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AgriFoodInsightLogs'
      displayName: 'AgriFoodInsightLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AgriFoodJobProcessedLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AgriFoodJobProcessedLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AgriFoodJobProcessedLogs'
      displayName: 'AgriFoodJobProcessedLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AgriFoodModelInferenceLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AgriFoodModelInferenceLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AgriFoodModelInferenceLogs'
      displayName: 'AgriFoodModelInferenceLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AgriFoodProviderAuthLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AgriFoodProviderAuthLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AgriFoodProviderAuthLogs'
      displayName: 'AgriFoodProviderAuthLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AgriFoodSatelliteLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AgriFoodSatelliteLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AgriFoodSatelliteLogs'
      displayName: 'AgriFoodSatelliteLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AgriFoodSensorManagementLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AgriFoodSensorManagementLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AgriFoodSensorManagementLogs'
      displayName: 'AgriFoodSensorManagementLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AgriFoodWeatherLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AgriFoodWeatherLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AgriFoodWeatherLogs'
      displayName: 'AgriFoodWeatherLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AGSGrafanaAlertAuthFailure 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AGSGrafanaAlertAuthFailure'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AGSGrafanaAlertAuthFailure'
      displayName: 'AGSGrafanaAlertAuthFailure'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AGSGrafanaLoginEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AGSGrafanaLoginEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AGSGrafanaLoginEvents'
      displayName: 'AGSGrafanaLoginEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AGSGrafanaUsageInsightsEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AGSGrafanaUsageInsightsEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AGSGrafanaUsageInsightsEvents'
      displayName: 'AGSGrafanaUsageInsightsEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AGSUpdateEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AGSUpdateEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AGSUpdateEvents'
      displayName: 'AGSUpdateEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AGWAccessLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AGWAccessLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AGWAccessLogs'
      displayName: 'AGWAccessLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AGWFirewallLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AGWFirewallLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AGWFirewallLogs'
      displayName: 'AGWFirewallLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AGWPerformanceLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AGWPerformanceLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AGWPerformanceLogs'
      displayName: 'AGWPerformanceLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AHCIDiagnosticLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AHCIDiagnosticLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AHCIDiagnosticLogs'
      displayName: 'AHCIDiagnosticLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AHDSDeidAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AHDSDeidAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AHDSDeidAuditLogs'
      displayName: 'AHDSDeidAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AHDSDicomAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AHDSDicomAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AHDSDicomAuditLogs'
      displayName: 'AHDSDicomAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AHDSDicomDiagnosticLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AHDSDicomDiagnosticLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AHDSDicomDiagnosticLogs'
      displayName: 'AHDSDicomDiagnosticLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AHDSMedTechDiagnosticLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AHDSMedTechDiagnosticLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AHDSMedTechDiagnosticLogs'
      displayName: 'AHDSMedTechDiagnosticLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AirflowDagProcessingLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AirflowDagProcessingLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AirflowDagProcessingLogs'
      displayName: 'AirflowDagProcessingLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AKSAudit 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AKSAudit'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AKSAudit'
      displayName: 'AKSAudit'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AKSAuditAdmin 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AKSAuditAdmin'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AKSAuditAdmin'
      displayName: 'AKSAuditAdmin'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AKSControlPlane 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AKSControlPlane'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AKSControlPlane'
      displayName: 'AKSControlPlane'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ALBHealthEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ALBHealthEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ALBHealthEvent'
      displayName: 'ALBHealthEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_Alert 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'Alert'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'Alert'
      displayName: 'Alert'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AMAHealth 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AMAHealth'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AMAHealth'
      displayName: 'AMAHealth'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AmlComputeClusterEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AmlComputeClusterEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AmlComputeClusterEvent'
      displayName: 'AmlComputeClusterEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AmlComputeClusterNodeEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AmlComputeClusterNodeEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AmlComputeClusterNodeEvent'
      displayName: 'AmlComputeClusterNodeEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AmlComputeCpuGpuUtilization 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AmlComputeCpuGpuUtilization'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AmlComputeCpuGpuUtilization'
      displayName: 'AmlComputeCpuGpuUtilization'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AmlComputeInstanceEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AmlComputeInstanceEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AmlComputeInstanceEvent'
      displayName: 'AmlComputeInstanceEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AmlComputeJobEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AmlComputeJobEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AmlComputeJobEvent'
      displayName: 'AmlComputeJobEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AmlDataLabelEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AmlDataLabelEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AmlDataLabelEvent'
      displayName: 'AmlDataLabelEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AmlDataSetEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AmlDataSetEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AmlDataSetEvent'
      displayName: 'AmlDataSetEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AmlDataStoreEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AmlDataStoreEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AmlDataStoreEvent'
      displayName: 'AmlDataStoreEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AmlDeploymentEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AmlDeploymentEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AmlDeploymentEvent'
      displayName: 'AmlDeploymentEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AmlEnvironmentEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AmlEnvironmentEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AmlEnvironmentEvent'
      displayName: 'AmlEnvironmentEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AmlInferencingEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AmlInferencingEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AmlInferencingEvent'
      displayName: 'AmlInferencingEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AMLManagedNetworkEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AMLManagedNetworkEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AMLManagedNetworkEvent'
      displayName: 'AMLManagedNetworkEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AmlModelsEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AmlModelsEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AmlModelsEvent'
      displayName: 'AmlModelsEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AmlOnlineEndpointConsoleLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AmlOnlineEndpointConsoleLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AmlOnlineEndpointConsoleLog'
      displayName: 'AmlOnlineEndpointConsoleLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AmlOnlineEndpointEventLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AmlOnlineEndpointEventLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AmlOnlineEndpointEventLog'
      displayName: 'AmlOnlineEndpointEventLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AmlOnlineEndpointTrafficLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AmlOnlineEndpointTrafficLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AmlOnlineEndpointTrafficLog'
      displayName: 'AmlOnlineEndpointTrafficLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AmlPipelineEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AmlPipelineEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AmlPipelineEvent'
      displayName: 'AmlPipelineEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AmlRegistryReadEventsLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AmlRegistryReadEventsLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AmlRegistryReadEventsLog'
      displayName: 'AmlRegistryReadEventsLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AmlRegistryWriteEventsLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AmlRegistryWriteEventsLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AmlRegistryWriteEventsLog'
      displayName: 'AmlRegistryWriteEventsLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AmlRunEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AmlRunEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AmlRunEvent'
      displayName: 'AmlRunEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AmlRunStatusChangedEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AmlRunStatusChangedEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AmlRunStatusChangedEvent'
      displayName: 'AmlRunStatusChangedEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AMSKeyDeliveryRequests 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AMSKeyDeliveryRequests'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AMSKeyDeliveryRequests'
      displayName: 'AMSKeyDeliveryRequests'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AMSLiveEventOperations 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AMSLiveEventOperations'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AMSLiveEventOperations'
      displayName: 'AMSLiveEventOperations'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AMSMediaAccountHealth 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AMSMediaAccountHealth'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AMSMediaAccountHealth'
      displayName: 'AMSMediaAccountHealth'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AMSStreamingEndpointRequests 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AMSStreamingEndpointRequests'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AMSStreamingEndpointRequests'
      displayName: 'AMSStreamingEndpointRequests'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AMWMetricsUsageDetails 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AMWMetricsUsageDetails'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AMWMetricsUsageDetails'
      displayName: 'AMWMetricsUsageDetails'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ANFFileAccess 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ANFFileAccess'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ANFFileAccess'
      displayName: 'ANFFileAccess'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ANFTopClientReadIOPS 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ANFTopClientReadIOPS'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ANFTopClientReadIOPS'
      displayName: 'ANFTopClientReadIOPS'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ANFTopClientWriteIOPS 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ANFTopClientWriteIOPS'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ANFTopClientWriteIOPS'
      displayName: 'ANFTopClientWriteIOPS'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ANFTopFileReadIOPS 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ANFTopFileReadIOPS'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ANFTopFileReadIOPS'
      displayName: 'ANFTopFileReadIOPS'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ANFTopFileWriteIOPS 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ANFTopFileWriteIOPS'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ANFTopFileWriteIOPS'
      displayName: 'ANFTopFileWriteIOPS'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AOIDatabaseQuery 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AOIDatabaseQuery'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AOIDatabaseQuery'
      displayName: 'AOIDatabaseQuery'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AOIDigestion 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AOIDigestion'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AOIDigestion'
      displayName: 'AOIDigestion'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AOIStorage 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AOIStorage'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AOIStorage'
      displayName: 'AOIStorage'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ApiManagementGatewayLlmLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ApiManagementGatewayLlmLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ApiManagementGatewayLlmLog'
      displayName: 'ApiManagementGatewayLlmLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ApiManagementGatewayLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ApiManagementGatewayLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ApiManagementGatewayLogs'
      displayName: 'ApiManagementGatewayLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ApiManagementGatewayMCPLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ApiManagementGatewayMCPLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ApiManagementGatewayMCPLog'
      displayName: 'ApiManagementGatewayMCPLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ApiManagementWebSocketConnectionLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ApiManagementWebSocketConnectionLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ApiManagementWebSocketConnectionLogs'
      displayName: 'ApiManagementWebSocketConnectionLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_APIMDevPortalAuditDiagnosticLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'APIMDevPortalAuditDiagnosticLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'APIMDevPortalAuditDiagnosticLog'
      displayName: 'APIMDevPortalAuditDiagnosticLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppAvailabilityResults 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppAvailabilityResults'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 90
    plan: 'Analytics'
    schema: {
      name: 'AppAvailabilityResults'
      displayName: 'AppAvailabilityResults'
    }
    retentionInDays: 90
  }
}

resource workspaces_law_3tier_prod_name_AppBrowserTimings 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppBrowserTimings'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 90
    plan: 'Analytics'
    schema: {
      name: 'AppBrowserTimings'
      displayName: 'AppBrowserTimings'
    }
    retentionInDays: 90
  }
}

resource workspaces_law_3tier_prod_name_AppCenterError 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppCenterError'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppCenterError'
      displayName: 'AppCenterError'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppDependencies 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppDependencies'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 90
    plan: 'Analytics'
    schema: {
      name: 'AppDependencies'
      displayName: 'AppDependencies'
    }
    retentionInDays: 90
  }
}

resource workspaces_law_3tier_prod_name_AppEnvSessionConsoleLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppEnvSessionConsoleLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppEnvSessionConsoleLogs'
      displayName: 'AppEnvSessionConsoleLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppEnvSessionLifecycleLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppEnvSessionLifecycleLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppEnvSessionLifecycleLogs'
      displayName: 'AppEnvSessionLifecycleLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppEnvSessionPoolEventLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppEnvSessionPoolEventLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppEnvSessionPoolEventLogs'
      displayName: 'AppEnvSessionPoolEventLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppEnvSpringAppConsoleLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppEnvSpringAppConsoleLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppEnvSpringAppConsoleLogs'
      displayName: 'AppEnvSpringAppConsoleLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 90
    plan: 'Analytics'
    schema: {
      name: 'AppEvents'
      displayName: 'AppEvents'
    }
    retentionInDays: 90
  }
}

resource workspaces_law_3tier_prod_name_AppExceptions 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppExceptions'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 90
    plan: 'Analytics'
    schema: {
      name: 'AppExceptions'
      displayName: 'AppExceptions'
    }
    retentionInDays: 90
  }
}

resource workspaces_law_3tier_prod_name_AppGenAIContent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppGenAIContent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 90
    plan: 'Analytics'
    schema: {
      name: 'AppGenAIContent'
      displayName: 'AppGenAIContent'
    }
    retentionInDays: 90
  }
}

resource workspaces_law_3tier_prod_name_AppMetrics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppMetrics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 90
    plan: 'Analytics'
    schema: {
      name: 'AppMetrics'
      displayName: 'AppMetrics'
    }
    retentionInDays: 90
  }
}

resource workspaces_law_3tier_prod_name_AppPageViews 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppPageViews'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 90
    plan: 'Analytics'
    schema: {
      name: 'AppPageViews'
      displayName: 'AppPageViews'
    }
    retentionInDays: 90
  }
}

resource workspaces_law_3tier_prod_name_AppPerformanceCounters 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppPerformanceCounters'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 90
    plan: 'Analytics'
    schema: {
      name: 'AppPerformanceCounters'
      displayName: 'AppPerformanceCounters'
    }
    retentionInDays: 90
  }
}

resource workspaces_law_3tier_prod_name_AppPlatformBuildLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppPlatformBuildLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppPlatformBuildLogs'
      displayName: 'AppPlatformBuildLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppPlatformContainerEventLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppPlatformContainerEventLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppPlatformContainerEventLogs'
      displayName: 'AppPlatformContainerEventLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppPlatformIngressLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppPlatformIngressLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppPlatformIngressLogs'
      displayName: 'AppPlatformIngressLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppPlatformLogsforSpring 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppPlatformLogsforSpring'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppPlatformLogsforSpring'
      displayName: 'AppPlatformLogsforSpring'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppPlatformSystemLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppPlatformSystemLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppPlatformSystemLogs'
      displayName: 'AppPlatformSystemLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppRequests 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppRequests'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 90
    plan: 'Analytics'
    schema: {
      name: 'AppRequests'
      displayName: 'AppRequests'
    }
    retentionInDays: 90
  }
}

resource workspaces_law_3tier_prod_name_AppServiceAntivirusScanAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppServiceAntivirusScanAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppServiceAntivirusScanAuditLogs'
      displayName: 'AppServiceAntivirusScanAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppServiceAppLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppServiceAppLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppServiceAppLogs'
      displayName: 'AppServiceAppLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppServiceAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppServiceAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppServiceAuditLogs'
      displayName: 'AppServiceAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppServiceAuthenticationLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppServiceAuthenticationLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppServiceAuthenticationLogs'
      displayName: 'AppServiceAuthenticationLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppServiceConsoleLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppServiceConsoleLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppServiceConsoleLogs'
      displayName: 'AppServiceConsoleLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppServiceEnvironmentPlatformLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppServiceEnvironmentPlatformLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppServiceEnvironmentPlatformLogs'
      displayName: 'AppServiceEnvironmentPlatformLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppServiceFileAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppServiceFileAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppServiceFileAuditLogs'
      displayName: 'AppServiceFileAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppServiceHTTPLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppServiceHTTPLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppServiceHTTPLogs'
      displayName: 'AppServiceHTTPLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppServiceIPSecAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppServiceIPSecAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppServiceIPSecAuditLogs'
      displayName: 'AppServiceIPSecAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppServicePlatformLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppServicePlatformLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppServicePlatformLogs'
      displayName: 'AppServicePlatformLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppServiceServerlessSecurityPluginData 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppServiceServerlessSecurityPluginData'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AppServiceServerlessSecurityPluginData'
      displayName: 'AppServiceServerlessSecurityPluginData'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AppSystemEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppSystemEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 90
    plan: 'Analytics'
    schema: {
      name: 'AppSystemEvents'
      displayName: 'AppSystemEvents'
    }
    retentionInDays: 90
  }
}

resource workspaces_law_3tier_prod_name_AppTraces 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AppTraces'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 90
    plan: 'Analytics'
    schema: {
      name: 'AppTraces'
      displayName: 'AppTraces'
    }
    retentionInDays: 90
  }
}

resource workspaces_law_3tier_prod_name_ArcK8sAudit 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ArcK8sAudit'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ArcK8sAudit'
      displayName: 'ArcK8sAudit'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ArcK8sAuditAdmin 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ArcK8sAuditAdmin'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ArcK8sAuditAdmin'
      displayName: 'ArcK8sAuditAdmin'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ArcK8sControlPlane 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ArcK8sControlPlane'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ArcK8sControlPlane'
      displayName: 'ArcK8sControlPlane'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ASCAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ASCAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ASCAuditLogs'
      displayName: 'ASCAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ASCDeviceEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ASCDeviceEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ASCDeviceEvents'
      displayName: 'ASCDeviceEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ASRJobs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ASRJobs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ASRJobs'
      displayName: 'ASRJobs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ASRReplicatedItems 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ASRReplicatedItems'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ASRReplicatedItems'
      displayName: 'ASRReplicatedItems'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ASRv2HealthEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ASRv2HealthEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ASRv2HealthEvents'
      displayName: 'ASRv2HealthEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ASRv2JobEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ASRv2JobEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ASRv2JobEvents'
      displayName: 'ASRv2JobEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ASRv2ProtectedItems 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ASRv2ProtectedItems'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ASRv2ProtectedItems'
      displayName: 'ASRv2ProtectedItems'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ASRv2ReplicationExtensions 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ASRv2ReplicationExtensions'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ASRv2ReplicationExtensions'
      displayName: 'ASRv2ReplicationExtensions'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ASRv2ReplicationPolicies 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ASRv2ReplicationPolicies'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ASRv2ReplicationPolicies'
      displayName: 'ASRv2ReplicationPolicies'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ASRv2ReplicationVaults 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ASRv2ReplicationVaults'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ASRv2ReplicationVaults'
      displayName: 'ASRv2ReplicationVaults'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ATCExpressRouteCircuitIpfix 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ATCExpressRouteCircuitIpfix'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ATCExpressRouteCircuitIpfix'
      displayName: 'ATCExpressRouteCircuitIpfix'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ATCMicrosoftPeeringMetadata 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ATCMicrosoftPeeringMetadata'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ATCMicrosoftPeeringMetadata'
      displayName: 'ATCMicrosoftPeeringMetadata'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ATCPrivatePeeringMetadata 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ATCPrivatePeeringMetadata'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ATCPrivatePeeringMetadata'
      displayName: 'ATCPrivatePeeringMetadata'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AuditLogs'
      displayName: 'AuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AutoscaleEvaluationsLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AutoscaleEvaluationsLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AutoscaleEvaluationsLog'
      displayName: 'AutoscaleEvaluationsLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AutoscaleScaleActionsLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AutoscaleScaleActionsLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AutoscaleScaleActionsLog'
      displayName: 'AutoscaleScaleActionsLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AVNMConnectivityConfigurationChange 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AVNMConnectivityConfigurationChange'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AVNMConnectivityConfigurationChange'
      displayName: 'AVNMConnectivityConfigurationChange'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AVNMIPAMPoolAllocationChange 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AVNMIPAMPoolAllocationChange'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AVNMIPAMPoolAllocationChange'
      displayName: 'AVNMIPAMPoolAllocationChange'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AVNMNetworkGroupMembershipChange 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AVNMNetworkGroupMembershipChange'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AVNMNetworkGroupMembershipChange'
      displayName: 'AVNMNetworkGroupMembershipChange'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AVNMRuleCollectionChange 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AVNMRuleCollectionChange'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AVNMRuleCollectionChange'
      displayName: 'AVNMRuleCollectionChange'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AVSEsxiFirewallSyslog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AVSEsxiFirewallSyslog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AVSEsxiFirewallSyslog'
      displayName: 'AVSEsxiFirewallSyslog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AVSEsxiSyslog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AVSEsxiSyslog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AVSEsxiSyslog'
      displayName: 'AVSEsxiSyslog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AVSNsxEdgeSyslog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AVSNsxEdgeSyslog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AVSNsxEdgeSyslog'
      displayName: 'AVSNsxEdgeSyslog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AVSNsxManagerSyslog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AVSNsxManagerSyslog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AVSNsxManagerSyslog'
      displayName: 'AVSNsxManagerSyslog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AVSSyslog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AVSSyslog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AVSSyslog'
      displayName: 'AVSSyslog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AVSVcSyslog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AVSVcSyslog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AVSVcSyslog'
      displayName: 'AVSVcSyslog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZFWApplicationRule 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZFWApplicationRule'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZFWApplicationRule'
      displayName: 'AZFWApplicationRule'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZFWApplicationRuleAggregation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZFWApplicationRuleAggregation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZFWApplicationRuleAggregation'
      displayName: 'AZFWApplicationRuleAggregation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZFWDnsFlowTrace 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZFWDnsFlowTrace'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZFWDnsFlowTrace'
      displayName: 'AZFWDnsFlowTrace'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZFWDnsQuery 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZFWDnsQuery'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZFWDnsQuery'
      displayName: 'AZFWDnsQuery'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZFWFatFlow 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZFWFatFlow'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZFWFatFlow'
      displayName: 'AZFWFatFlow'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZFWFlowTrace 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZFWFlowTrace'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZFWFlowTrace'
      displayName: 'AZFWFlowTrace'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZFWIdpsSignature 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZFWIdpsSignature'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZFWIdpsSignature'
      displayName: 'AZFWIdpsSignature'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZFWInternalFqdnResolutionFailure 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZFWInternalFqdnResolutionFailure'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZFWInternalFqdnResolutionFailure'
      displayName: 'AZFWInternalFqdnResolutionFailure'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZFWNatRule 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZFWNatRule'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZFWNatRule'
      displayName: 'AZFWNatRule'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZFWNatRuleAggregation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZFWNatRuleAggregation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZFWNatRuleAggregation'
      displayName: 'AZFWNatRuleAggregation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZFWNetworkRule 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZFWNetworkRule'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZFWNetworkRule'
      displayName: 'AZFWNetworkRule'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZFWNetworkRuleAggregation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZFWNetworkRuleAggregation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZFWNetworkRuleAggregation'
      displayName: 'AZFWNetworkRuleAggregation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZFWThreatIntel 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZFWThreatIntel'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZFWThreatIntel'
      displayName: 'AZFWThreatIntel'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZKVAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZKVAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZKVAuditLogs'
      displayName: 'AZKVAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZKVPolicyEvaluationDetailsLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZKVPolicyEvaluationDetailsLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZKVPolicyEvaluationDetailsLogs'
      displayName: 'AZKVPolicyEvaluationDetailsLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZMSApplicationMetricLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZMSApplicationMetricLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZMSApplicationMetricLogs'
      displayName: 'AZMSApplicationMetricLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZMSArchiveLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZMSArchiveLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZMSArchiveLogs'
      displayName: 'AZMSArchiveLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZMSAutoscaleLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZMSAutoscaleLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZMSAutoscaleLogs'
      displayName: 'AZMSAutoscaleLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZMSCustomerManagedKeyUserLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZMSCustomerManagedKeyUserLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZMSCustomerManagedKeyUserLogs'
      displayName: 'AZMSCustomerManagedKeyUserLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZMSDiagnosticErrorLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZMSDiagnosticErrorLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZMSDiagnosticErrorLogs'
      displayName: 'AZMSDiagnosticErrorLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZMSHybridConnectionsEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZMSHybridConnectionsEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZMSHybridConnectionsEvents'
      displayName: 'AZMSHybridConnectionsEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZMSKafkaCoordinatorLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZMSKafkaCoordinatorLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZMSKafkaCoordinatorLogs'
      displayName: 'AZMSKafkaCoordinatorLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZMSKafkaUserErrorLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZMSKafkaUserErrorLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZMSKafkaUserErrorLogs'
      displayName: 'AZMSKafkaUserErrorLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZMSOperationalLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZMSOperationalLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZMSOperationalLogs'
      displayName: 'AZMSOperationalLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZMSRunTimeAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZMSRunTimeAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZMSRunTimeAuditLogs'
      displayName: 'AZMSRunTimeAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AZMSVnetConnectionEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AZMSVnetConnectionEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AZMSVnetConnectionEvents'
      displayName: 'AZMSVnetConnectionEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AzureActivity 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AzureActivity'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 90
    plan: 'Analytics'
    schema: {
      name: 'AzureActivity'
      displayName: 'AzureActivity'
    }
    retentionInDays: 90
  }
}

resource workspaces_law_3tier_prod_name_AzureActivityV2 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AzureActivityV2'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AzureActivityV2'
      displayName: 'AzureActivityV2'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AzureAssessmentRecommendation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AzureAssessmentRecommendation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AzureAssessmentRecommendation'
      displayName: 'AzureAssessmentRecommendation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AzureAttestationDiagnostics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AzureAttestationDiagnostics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AzureAttestationDiagnostics'
      displayName: 'AzureAttestationDiagnostics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AzureBackupOperations 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AzureBackupOperations'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AzureBackupOperations'
      displayName: 'AzureBackupOperations'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AzureDevOpsAuditing 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AzureDevOpsAuditing'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AzureDevOpsAuditing'
      displayName: 'AzureDevOpsAuditing'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AzureLoadTestingOperation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AzureLoadTestingOperation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AzureLoadTestingOperation'
      displayName: 'AzureLoadTestingOperation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AzureMetrics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AzureMetrics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AzureMetrics'
      displayName: 'AzureMetrics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AzureMetricsV2 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AzureMetricsV2'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AzureMetricsV2'
      displayName: 'AzureMetricsV2'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AzureMonitorPipelineLogErrors 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AzureMonitorPipelineLogErrors'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AzureMonitorPipelineLogErrors'
      displayName: 'AzureMonitorPipelineLogErrors'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AzureSQLAutomaticTuning 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AzureSQLAutomaticTuning'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AzureSQLAutomaticTuning'
      displayName: 'AzureSQLAutomaticTuning'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AzureSQLBlocks 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AzureSQLBlocks'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AzureSQLBlocks'
      displayName: 'AzureSQLBlocks'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AzureSQLDatabaseWaitStatistics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AzureSQLDatabaseWaitStatistics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AzureSQLDatabaseWaitStatistics'
      displayName: 'AzureSQLDatabaseWaitStatistics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AzureSQLDeadlocks 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AzureSQLDeadlocks'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AzureSQLDeadlocks'
      displayName: 'AzureSQLDeadlocks'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AzureSQLErrors 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AzureSQLErrors'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AzureSQLErrors'
      displayName: 'AzureSQLErrors'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AzureSQLQueryStoreRuntimeStatistics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AzureSQLQueryStoreRuntimeStatistics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AzureSQLQueryStoreRuntimeStatistics'
      displayName: 'AzureSQLQueryStoreRuntimeStatistics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AzureSQLQueryStoreWaitStatistics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AzureSQLQueryStoreWaitStatistics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AzureSQLQueryStoreWaitStatistics'
      displayName: 'AzureSQLQueryStoreWaitStatistics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AzureSQLResourceUsageStats 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AzureSQLResourceUsageStats'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AzureSQLResourceUsageStats'
      displayName: 'AzureSQLResourceUsageStats'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_AzureSQLTimeouts 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'AzureSQLTimeouts'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'AzureSQLTimeouts'
      displayName: 'AzureSQLTimeouts'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_BehaviorEntities 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'BehaviorEntities'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'BehaviorEntities'
      displayName: 'BehaviorEntities'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_BehaviorInfo 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'BehaviorInfo'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'BehaviorInfo'
      displayName: 'BehaviorInfo'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_BlockchainApplicationLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'BlockchainApplicationLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'BlockchainApplicationLog'
      displayName: 'BlockchainApplicationLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_BlockchainProxyLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'BlockchainProxyLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'BlockchainProxyLog'
      displayName: 'BlockchainProxyLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_CassandraAudit 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'CassandraAudit'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'CassandraAudit'
      displayName: 'CassandraAudit'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_CassandraLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'CassandraLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'CassandraLogs'
      displayName: 'CassandraLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_CCFApplicationLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'CCFApplicationLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'CCFApplicationLogs'
      displayName: 'CCFApplicationLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_CDBCassandraRequests 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'CDBCassandraRequests'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'CDBCassandraRequests'
      displayName: 'CDBCassandraRequests'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_CDBControlPlaneRequests 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'CDBControlPlaneRequests'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'CDBControlPlaneRequests'
      displayName: 'CDBControlPlaneRequests'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_CDBDataPlaneRequests 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'CDBDataPlaneRequests'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'CDBDataPlaneRequests'
      displayName: 'CDBDataPlaneRequests'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_CDBDataPlaneRequests15M 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'CDBDataPlaneRequests15M'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'CDBDataPlaneRequests15M'
      displayName: 'CDBDataPlaneRequests15M'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_CDBDataPlaneRequests5M 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'CDBDataPlaneRequests5M'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'CDBDataPlaneRequests5M'
      displayName: 'CDBDataPlaneRequests5M'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_CDBGremlinRequests 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'CDBGremlinRequests'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'CDBGremlinRequests'
      displayName: 'CDBGremlinRequests'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_CDBMongoRequests 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'CDBMongoRequests'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'CDBMongoRequests'
      displayName: 'CDBMongoRequests'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_CDBPartitionKeyRUConsumption 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'CDBPartitionKeyRUConsumption'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'CDBPartitionKeyRUConsumption'
      displayName: 'CDBPartitionKeyRUConsumption'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_CDBPartitionKeyStatistics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'CDBPartitionKeyStatistics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'CDBPartitionKeyStatistics'
      displayName: 'CDBPartitionKeyStatistics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_CDBQueryRuntimeStatistics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'CDBQueryRuntimeStatistics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'CDBQueryRuntimeStatistics'
      displayName: 'CDBQueryRuntimeStatistics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_CDBTableApiRequests 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'CDBTableApiRequests'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'CDBTableApiRequests'
      displayName: 'CDBTableApiRequests'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ChaosStudioExperimentEventLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ChaosStudioExperimentEventLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ChaosStudioExperimentEventLogs'
      displayName: 'ChaosStudioExperimentEventLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_CHSMServiceOperationAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'CHSMServiceOperationAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'CHSMServiceOperationAuditLogs'
      displayName: 'CHSMServiceOperationAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_CIEventsAudit 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'CIEventsAudit'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'CIEventsAudit'
      displayName: 'CIEventsAudit'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_CIEventsOperational 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'CIEventsOperational'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'CIEventsOperational'
      displayName: 'CIEventsOperational'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_CloudHsmHardwareOperationAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'CloudHsmHardwareOperationAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'CloudHsmHardwareOperationAuditLogs'
      displayName: 'CloudHsmHardwareOperationAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_CloudHsmServiceOperationAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'CloudHsmServiceOperationAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'CloudHsmServiceOperationAuditLogs'
      displayName: 'CloudHsmServiceOperationAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ComputerGroup 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ComputerGroup'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ComputerGroup'
      displayName: 'ComputerGroup'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ContainerAppConsoleLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ContainerAppConsoleLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ContainerAppConsoleLogs'
      displayName: 'ContainerAppConsoleLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ContainerAppHTTPLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ContainerAppHTTPLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ContainerAppHTTPLogs'
      displayName: 'ContainerAppHTTPLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ContainerAppSystemLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ContainerAppSystemLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ContainerAppSystemLogs'
      displayName: 'ContainerAppSystemLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ContainerEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ContainerEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ContainerEvent'
      displayName: 'ContainerEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ContainerImageInventory 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ContainerImageInventory'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ContainerImageInventory'
      displayName: 'ContainerImageInventory'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ContainerInstanceLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ContainerInstanceLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ContainerInstanceLog'
      displayName: 'ContainerInstanceLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ContainerInventory 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ContainerInventory'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ContainerInventory'
      displayName: 'ContainerInventory'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ContainerLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ContainerLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ContainerLog'
      displayName: 'ContainerLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ContainerLogV2 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ContainerLogV2'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ContainerLogV2'
      displayName: 'ContainerLogV2'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ContainerNetworkLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ContainerNetworkLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ContainerNetworkLogs'
      displayName: 'ContainerNetworkLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ContainerNodeInventory 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ContainerNodeInventory'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ContainerNodeInventory'
      displayName: 'ContainerNodeInventory'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ContainerRegistryLoginEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ContainerRegistryLoginEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ContainerRegistryLoginEvents'
      displayName: 'ContainerRegistryLoginEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ContainerRegistryRepositoryEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ContainerRegistryRepositoryEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ContainerRegistryRepositoryEvents'
      displayName: 'ContainerRegistryRepositoryEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ContainerServiceLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ContainerServiceLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ContainerServiceLog'
      displayName: 'ContainerServiceLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_CoreAzureBackup 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'CoreAzureBackup'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'CoreAzureBackup'
      displayName: 'CoreAzureBackup'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksAccounts 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksAccounts'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksAccounts'
      displayName: 'DatabricksAccounts'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksApps 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksApps'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksApps'
      displayName: 'DatabricksApps'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksBrickStoreHttpGateway 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksBrickStoreHttpGateway'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksBrickStoreHttpGateway'
      displayName: 'DatabricksBrickStoreHttpGateway'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksBudgetPolicyCentral 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksBudgetPolicyCentral'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksBudgetPolicyCentral'
      displayName: 'DatabricksBudgetPolicyCentral'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksCapsule8Dataplane 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksCapsule8Dataplane'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksCapsule8Dataplane'
      displayName: 'DatabricksCapsule8Dataplane'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksClamAVScan 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksClamAVScan'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksClamAVScan'
      displayName: 'DatabricksClamAVScan'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksCloudStorageMetadata 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksCloudStorageMetadata'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksCloudStorageMetadata'
      displayName: 'DatabricksCloudStorageMetadata'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksClusterLibraries 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksClusterLibraries'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksClusterLibraries'
      displayName: 'DatabricksClusterLibraries'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksClusterPolicies 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksClusterPolicies'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksClusterPolicies'
      displayName: 'DatabricksClusterPolicies'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksClusters 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksClusters'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksClusters'
      displayName: 'DatabricksClusters'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksDashboards 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksDashboards'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksDashboards'
      displayName: 'DatabricksDashboards'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksDatabricksSQL 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksDatabricksSQL'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksDatabricksSQL'
      displayName: 'DatabricksDatabricksSQL'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksDataMonitoring 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksDataMonitoring'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksDataMonitoring'
      displayName: 'DatabricksDataMonitoring'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksDataRooms 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksDataRooms'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksDataRooms'
      displayName: 'DatabricksDataRooms'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksDBFS 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksDBFS'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksDBFS'
      displayName: 'DatabricksDBFS'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksDeltaPipelines 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksDeltaPipelines'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksDeltaPipelines'
      displayName: 'DatabricksDeltaPipelines'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksFeatureStore 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksFeatureStore'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksFeatureStore'
      displayName: 'DatabricksFeatureStore'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksFiles 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksFiles'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksFiles'
      displayName: 'DatabricksFiles'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksFilesystem 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksFilesystem'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksFilesystem'
      displayName: 'DatabricksFilesystem'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksGenie 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksGenie'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksGenie'
      displayName: 'DatabricksGenie'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksGitCredentials 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksGitCredentials'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksGitCredentials'
      displayName: 'DatabricksGitCredentials'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksGlobalInitScripts 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksGlobalInitScripts'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksGlobalInitScripts'
      displayName: 'DatabricksGlobalInitScripts'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksGroups 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksGroups'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksGroups'
      displayName: 'DatabricksGroups'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksIAMRole 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksIAMRole'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksIAMRole'
      displayName: 'DatabricksIAMRole'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksIngestion 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksIngestion'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksIngestion'
      displayName: 'DatabricksIngestion'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksInstancePools 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksInstancePools'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksInstancePools'
      displayName: 'DatabricksInstancePools'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksJobs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksJobs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksJobs'
      displayName: 'DatabricksJobs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksLakeviewConfig 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksLakeviewConfig'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksLakeviewConfig'
      displayName: 'DatabricksLakeviewConfig'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksLineageTracking 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksLineageTracking'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksLineageTracking'
      displayName: 'DatabricksLineageTracking'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksMarketplaceConsumer 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksMarketplaceConsumer'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksMarketplaceConsumer'
      displayName: 'DatabricksMarketplaceConsumer'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksMarketplaceProvider 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksMarketplaceProvider'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksMarketplaceProvider'
      displayName: 'DatabricksMarketplaceProvider'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksMLflowAcledArtifact 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksMLflowAcledArtifact'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksMLflowAcledArtifact'
      displayName: 'DatabricksMLflowAcledArtifact'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksMLflowExperiment 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksMLflowExperiment'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksMLflowExperiment'
      displayName: 'DatabricksMLflowExperiment'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksModelRegistry 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksModelRegistry'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksModelRegistry'
      displayName: 'DatabricksModelRegistry'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksNotebook 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksNotebook'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksNotebook'
      displayName: 'DatabricksNotebook'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksOnlineTables 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksOnlineTables'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksOnlineTables'
      displayName: 'DatabricksOnlineTables'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksPartnerHub 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksPartnerHub'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksPartnerHub'
      displayName: 'DatabricksPartnerHub'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksPredictiveOptimization 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksPredictiveOptimization'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksPredictiveOptimization'
      displayName: 'DatabricksPredictiveOptimization'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksRBAC 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksRBAC'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksRBAC'
      displayName: 'DatabricksRBAC'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksRemoteHistoryService 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksRemoteHistoryService'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksRemoteHistoryService'
      displayName: 'DatabricksRemoteHistoryService'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksRepos 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksRepos'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksRepos'
      displayName: 'DatabricksRepos'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksRFA 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksRFA'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksRFA'
      displayName: 'DatabricksRFA'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksSecrets 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksSecrets'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksSecrets'
      displayName: 'DatabricksSecrets'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksServerlessRealTimeInference 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksServerlessRealTimeInference'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksServerlessRealTimeInference'
      displayName: 'DatabricksServerlessRealTimeInference'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksSQL 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksSQL'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksSQL'
      displayName: 'DatabricksSQL'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksSQLPermissions 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksSQLPermissions'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksSQLPermissions'
      displayName: 'DatabricksSQLPermissions'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksSSH 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksSSH'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksSSH'
      displayName: 'DatabricksSSH'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksTables 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksTables'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksTables'
      displayName: 'DatabricksTables'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksUnityCatalog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksUnityCatalog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksUnityCatalog'
      displayName: 'DatabricksUnityCatalog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksVectorSearch 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksVectorSearch'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksVectorSearch'
      displayName: 'DatabricksVectorSearch'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksWebhookNotifications 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksWebhookNotifications'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksWebhookNotifications'
      displayName: 'DatabricksWebhookNotifications'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksWebTerminal 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksWebTerminal'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksWebTerminal'
      displayName: 'DatabricksWebTerminal'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksWorkspace 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksWorkspace'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksWorkspace'
      displayName: 'DatabricksWorkspace'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DatabricksWorkspaceFiles 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DatabricksWorkspaceFiles'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DatabricksWorkspaceFiles'
      displayName: 'DatabricksWorkspaceFiles'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DataSetOutput 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DataSetOutput'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DataSetOutput'
      displayName: 'DataSetOutput'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DataSetRuns 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DataSetRuns'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DataSetRuns'
      displayName: 'DataSetRuns'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DataTransferOperations 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DataTransferOperations'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DataTransferOperations'
      displayName: 'DataTransferOperations'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DCRLogErrors 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DCRLogErrors'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DCRLogErrors'
      displayName: 'DCRLogErrors'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DCRLogTroubleshooting 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DCRLogTroubleshooting'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DCRLogTroubleshooting'
      displayName: 'DCRLogTroubleshooting'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DevCenterAgentHealthLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DevCenterAgentHealthLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DevCenterAgentHealthLogs'
      displayName: 'DevCenterAgentHealthLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DevCenterBillingEventLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DevCenterBillingEventLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DevCenterBillingEventLogs'
      displayName: 'DevCenterBillingEventLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DevCenterConnectionLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DevCenterConnectionLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DevCenterConnectionLogs'
      displayName: 'DevCenterConnectionLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DevCenterDiagnosticLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DevCenterDiagnosticLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DevCenterDiagnosticLogs'
      displayName: 'DevCenterDiagnosticLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DevCenterResourceOperationLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DevCenterResourceOperationLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DevCenterResourceOperationLogs'
      displayName: 'DevCenterResourceOperationLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DeviceBehaviorEntities 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DeviceBehaviorEntities'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DeviceBehaviorEntities'
      displayName: 'DeviceBehaviorEntities'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DeviceBehaviorInfo 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DeviceBehaviorInfo'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DeviceBehaviorInfo'
      displayName: 'DeviceBehaviorInfo'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DeviceCustomFileEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DeviceCustomFileEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DeviceCustomFileEvents'
      displayName: 'DeviceCustomFileEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DeviceCustomImageLoadEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DeviceCustomImageLoadEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DeviceCustomImageLoadEvents'
      displayName: 'DeviceCustomImageLoadEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DeviceCustomNetworkEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DeviceCustomNetworkEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DeviceCustomNetworkEvents'
      displayName: 'DeviceCustomNetworkEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DeviceCustomProcessEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DeviceCustomProcessEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DeviceCustomProcessEvents'
      displayName: 'DeviceCustomProcessEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DeviceCustomRegistryEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DeviceCustomRegistryEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DeviceCustomRegistryEvents'
      displayName: 'DeviceCustomRegistryEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DeviceCustomScriptEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DeviceCustomScriptEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DeviceCustomScriptEvents'
      displayName: 'DeviceCustomScriptEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DevOpsOperationsAudit 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DevOpsOperationsAudit'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DevOpsOperationsAudit'
      displayName: 'DevOpsOperationsAudit'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DiscoveryBookshelfAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DiscoveryBookshelfAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DiscoveryBookshelfAuditLogs'
      displayName: 'DiscoveryBookshelfAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DiscoverySupercomputerAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DiscoverySupercomputerAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DiscoverySupercomputerAuditLogs'
      displayName: 'DiscoverySupercomputerAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DiscoveryWorkspaceAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DiscoveryWorkspaceAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DiscoveryWorkspaceAuditLogs'
      displayName: 'DiscoveryWorkspaceAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DNSQueryLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DNSQueryLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DNSQueryLogs'
      displayName: 'DNSQueryLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DragonCopilot 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DragonCopilot'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DragonCopilot'
      displayName: 'DragonCopilot'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DSMAzureBlobStorageLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DSMAzureBlobStorageLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DSMAzureBlobStorageLogs'
      displayName: 'DSMAzureBlobStorageLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DSMDataClassificationLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DSMDataClassificationLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DSMDataClassificationLogs'
      displayName: 'DSMDataClassificationLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DSMDataLabelingLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DSMDataLabelingLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DSMDataLabelingLogs'
      displayName: 'DSMDataLabelingLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_DurableTaskSchedulerLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'DurableTaskSchedulerLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'DurableTaskSchedulerLogs'
      displayName: 'DurableTaskSchedulerLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_EdgeActionConsoleLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'EdgeActionConsoleLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'EdgeActionConsoleLog'
      displayName: 'EdgeActionConsoleLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_EdgeActionServiceLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'EdgeActionServiceLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'EdgeActionServiceLog'
      displayName: 'EdgeActionServiceLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_EdgeSecurityEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'EdgeSecurityEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'EdgeSecurityEvents'
      displayName: 'EdgeSecurityEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_EGNFailedHttpDataPlaneOperations 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'EGNFailedHttpDataPlaneOperations'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'EGNFailedHttpDataPlaneOperations'
      displayName: 'EGNFailedHttpDataPlaneOperations'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_EGNFailedMqttConnections 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'EGNFailedMqttConnections'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'EGNFailedMqttConnections'
      displayName: 'EGNFailedMqttConnections'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_EGNFailedMqttPublishedMessages 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'EGNFailedMqttPublishedMessages'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'EGNFailedMqttPublishedMessages'
      displayName: 'EGNFailedMqttPublishedMessages'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_EGNFailedMqttSubscriptions 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'EGNFailedMqttSubscriptions'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'EGNFailedMqttSubscriptions'
      displayName: 'EGNFailedMqttSubscriptions'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_EGNMqttDisconnections 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'EGNMqttDisconnections'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'EGNMqttDisconnections'
      displayName: 'EGNMqttDisconnections'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_EGNSuccessfulHttpDataPlaneOperations 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'EGNSuccessfulHttpDataPlaneOperations'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'EGNSuccessfulHttpDataPlaneOperations'
      displayName: 'EGNSuccessfulHttpDataPlaneOperations'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_EGNSuccessfulMqttConnections 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'EGNSuccessfulMqttConnections'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'EGNSuccessfulMqttConnections'
      displayName: 'EGNSuccessfulMqttConnections'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_EnrichedMicrosoft365AuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'EnrichedMicrosoft365AuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'EnrichedMicrosoft365AuditLogs'
      displayName: 'EnrichedMicrosoft365AuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ETWEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ETWEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ETWEvent'
      displayName: 'ETWEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_Event 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'Event'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'Event'
      displayName: 'Event'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ExchangeAssessmentRecommendation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ExchangeAssessmentRecommendation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ExchangeAssessmentRecommendation'
      displayName: 'ExchangeAssessmentRecommendation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ExchangeOnlineAssessmentRecommendation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ExchangeOnlineAssessmentRecommendation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ExchangeOnlineAssessmentRecommendation'
      displayName: 'ExchangeOnlineAssessmentRecommendation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_FailedIngestion 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'FailedIngestion'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'FailedIngestion'
      displayName: 'FailedIngestion'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_FunctionAppLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'FunctionAppLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'FunctionAppLogs'
      displayName: 'FunctionAppLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_GraphNotificationsActivityLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'GraphNotificationsActivityLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'GraphNotificationsActivityLogs'
      displayName: 'GraphNotificationsActivityLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightAmbariClusterAlerts 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightAmbariClusterAlerts'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightAmbariClusterAlerts'
      displayName: 'HDInsightAmbariClusterAlerts'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightAmbariSystemMetrics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightAmbariSystemMetrics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightAmbariSystemMetrics'
      displayName: 'HDInsightAmbariSystemMetrics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightGatewayAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightGatewayAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightGatewayAuditLogs'
      displayName: 'HDInsightGatewayAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightHadoopAndYarnLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightHadoopAndYarnLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightHadoopAndYarnLogs'
      displayName: 'HDInsightHadoopAndYarnLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightHadoopAndYarnMetrics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightHadoopAndYarnMetrics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightHadoopAndYarnMetrics'
      displayName: 'HDInsightHadoopAndYarnMetrics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightHBaseLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightHBaseLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightHBaseLogs'
      displayName: 'HDInsightHBaseLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightHBaseMetrics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightHBaseMetrics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightHBaseMetrics'
      displayName: 'HDInsightHBaseMetrics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightHiveAndLLAPLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightHiveAndLLAPLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightHiveAndLLAPLogs'
      displayName: 'HDInsightHiveAndLLAPLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightHiveAndLLAPMetrics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightHiveAndLLAPMetrics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightHiveAndLLAPMetrics'
      displayName: 'HDInsightHiveAndLLAPMetrics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightHiveQueryAppStats 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightHiveQueryAppStats'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightHiveQueryAppStats'
      displayName: 'HDInsightHiveQueryAppStats'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightHiveTezAppStats 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightHiveTezAppStats'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightHiveTezAppStats'
      displayName: 'HDInsightHiveTezAppStats'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightJupyterNotebookEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightJupyterNotebookEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightJupyterNotebookEvents'
      displayName: 'HDInsightJupyterNotebookEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightKafkaLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightKafkaLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightKafkaLogs'
      displayName: 'HDInsightKafkaLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightKafkaMetrics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightKafkaMetrics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightKafkaMetrics'
      displayName: 'HDInsightKafkaMetrics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightKafkaServerLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightKafkaServerLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightKafkaServerLog'
      displayName: 'HDInsightKafkaServerLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightOozieLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightOozieLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightOozieLogs'
      displayName: 'HDInsightOozieLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightRangerAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightRangerAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightRangerAuditLogs'
      displayName: 'HDInsightRangerAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightSecurityLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightSecurityLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightSecurityLogs'
      displayName: 'HDInsightSecurityLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightSparkApplicationEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightSparkApplicationEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightSparkApplicationEvents'
      displayName: 'HDInsightSparkApplicationEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightSparkBlockManagerEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightSparkBlockManagerEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightSparkBlockManagerEvents'
      displayName: 'HDInsightSparkBlockManagerEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightSparkEnvironmentEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightSparkEnvironmentEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightSparkEnvironmentEvents'
      displayName: 'HDInsightSparkEnvironmentEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightSparkExecutorEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightSparkExecutorEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightSparkExecutorEvents'
      displayName: 'HDInsightSparkExecutorEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightSparkExtraEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightSparkExtraEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightSparkExtraEvents'
      displayName: 'HDInsightSparkExtraEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightSparkJobEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightSparkJobEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightSparkJobEvents'
      displayName: 'HDInsightSparkJobEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightSparkLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightSparkLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightSparkLogs'
      displayName: 'HDInsightSparkLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightSparkSQLExecutionEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightSparkSQLExecutionEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightSparkSQLExecutionEvents'
      displayName: 'HDInsightSparkSQLExecutionEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightSparkStageEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightSparkStageEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightSparkStageEvents'
      displayName: 'HDInsightSparkStageEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightSparkStageTaskAccumulables 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightSparkStageTaskAccumulables'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightSparkStageTaskAccumulables'
      displayName: 'HDInsightSparkStageTaskAccumulables'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightSparkTaskEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightSparkTaskEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightSparkTaskEvents'
      displayName: 'HDInsightSparkTaskEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightStormLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightStormLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightStormLogs'
      displayName: 'HDInsightStormLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightStormMetrics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightStormMetrics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightStormMetrics'
      displayName: 'HDInsightStormMetrics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HDInsightStormTopologyMetrics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HDInsightStormTopologyMetrics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HDInsightStormTopologyMetrics'
      displayName: 'HDInsightStormTopologyMetrics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HealthStateChangeEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HealthStateChangeEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HealthStateChangeEvent'
      displayName: 'HealthStateChangeEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_Heartbeat 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'Heartbeat'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'Heartbeat'
      displayName: 'Heartbeat'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HorizonDBAutovacuumStats 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HorizonDBAutovacuumStats'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HorizonDBAutovacuumStats'
      displayName: 'HorizonDBAutovacuumStats'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HorizonDBPgStatActivitySessions 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HorizonDBPgStatActivitySessions'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HorizonDBPgStatActivitySessions'
      displayName: 'HorizonDBPgStatActivitySessions'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HorizonDBQueryStoreQueryText 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HorizonDBQueryStoreQueryText'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HorizonDBQueryStoreQueryText'
      displayName: 'HorizonDBQueryStoreQueryText'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HorizonDBQueryStoreRuntimeStats 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HorizonDBQueryStoreRuntimeStats'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HorizonDBQueryStoreRuntimeStats'
      displayName: 'HorizonDBQueryStoreRuntimeStats'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HorizonDBQueryStoreWaitsStats 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HorizonDBQueryStoreWaitsStats'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HorizonDBQueryStoreWaitsStats'
      displayName: 'HorizonDBQueryStoreWaitsStats'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HorizonDBServerLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HorizonDBServerLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HorizonDBServerLogs'
      displayName: 'HorizonDBServerLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_HorizonDBTransactionsStats 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'HorizonDBTransactionsStats'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'HorizonDBTransactionsStats'
      displayName: 'HorizonDBTransactionsStats'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_InsightsMetrics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'InsightsMetrics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'InsightsMetrics'
      displayName: 'InsightsMetrics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_IntuneAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'IntuneAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'IntuneAuditLogs'
      displayName: 'IntuneAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_IntuneDeviceComplianceOrg 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'IntuneDeviceComplianceOrg'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'IntuneDeviceComplianceOrg'
      displayName: 'IntuneDeviceComplianceOrg'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_IntuneDevices 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'IntuneDevices'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'IntuneDevices'
      displayName: 'IntuneDevices'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_IntuneOperationalLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'IntuneOperationalLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'IntuneOperationalLogs'
      displayName: 'IntuneOperationalLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_KubeEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'KubeEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'KubeEvents'
      displayName: 'KubeEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_KubeHealth 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'KubeHealth'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'KubeHealth'
      displayName: 'KubeHealth'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_KubeMonAgentEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'KubeMonAgentEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'KubeMonAgentEvents'
      displayName: 'KubeMonAgentEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_KubeNodeInventory 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'KubeNodeInventory'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'KubeNodeInventory'
      displayName: 'KubeNodeInventory'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_KubePodInventory 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'KubePodInventory'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'KubePodInventory'
      displayName: 'KubePodInventory'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_KubePVInventory 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'KubePVInventory'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'KubePVInventory'
      displayName: 'KubePVInventory'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_KubeServices 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'KubeServices'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'KubeServices'
      displayName: 'KubeServices'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_LAJobLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LAJobLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'LAJobLogs'
      displayName: 'LAJobLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_LAQueryLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LAQueryLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'LAQueryLogs'
      displayName: 'LAQueryLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_LASummaryLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LASummaryLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'LASummaryLogs'
      displayName: 'LASummaryLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_LedgerTransactionLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LedgerTransactionLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'LedgerTransactionLogs'
      displayName: 'LedgerTransactionLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_LedgerUserDefinedLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LedgerUserDefinedLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'LedgerUserDefinedLogs'
      displayName: 'LedgerUserDefinedLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_LIATrackingEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LIATrackingEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'LIATrackingEvents'
      displayName: 'LIATrackingEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_LogicAppWorkflowRuntime 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'LogicAppWorkflowRuntime'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'LogicAppWorkflowRuntime'
      displayName: 'LogicAppWorkflowRuntime'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MCCEventLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MCCEventLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MCCEventLogs'
      displayName: 'MCCEventLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MCVPAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MCVPAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MCVPAuditLogs'
      displayName: 'MCVPAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MCVPOperationLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MCVPOperationLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MCVPOperationLogs'
      displayName: 'MCVPOperationLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MDCDetectionDNSEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MDCDetectionDNSEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MDCDetectionDNSEvents'
      displayName: 'MDCDetectionDNSEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MDCDetectionFimEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MDCDetectionFimEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MDCDetectionFimEvents'
      displayName: 'MDCDetectionFimEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MDCDetectionGatingValidationEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MDCDetectionGatingValidationEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MDCDetectionGatingValidationEvents'
      displayName: 'MDCDetectionGatingValidationEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MDCDetectionK8SApiEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MDCDetectionK8SApiEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MDCDetectionK8SApiEvents'
      displayName: 'MDCDetectionK8SApiEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MDCDetectionProcessV2Events 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MDCDetectionProcessV2Events'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MDCDetectionProcessV2Events'
      displayName: 'MDCDetectionProcessV2Events'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MDCFileIntegrityMonitoringEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MDCFileIntegrityMonitoringEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MDCFileIntegrityMonitoringEvents'
      displayName: 'MDCFileIntegrityMonitoringEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MDECustomCollectionDeviceFileEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MDECustomCollectionDeviceFileEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MDECustomCollectionDeviceFileEvents'
      displayName: 'MDECustomCollectionDeviceFileEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MDPResourceLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MDPResourceLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MDPResourceLog'
      displayName: 'MDPResourceLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MeshControlPlane 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MeshControlPlane'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MeshControlPlane'
      displayName: 'MeshControlPlane'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MicrosoftAzureBastionAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MicrosoftAzureBastionAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MicrosoftAzureBastionAuditLogs'
      displayName: 'MicrosoftAzureBastionAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MicrosoftDataShareReceivedSnapshotLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MicrosoftDataShareReceivedSnapshotLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MicrosoftDataShareReceivedSnapshotLog'
      displayName: 'MicrosoftDataShareReceivedSnapshotLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MicrosoftDataShareSentSnapshotLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MicrosoftDataShareSentSnapshotLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MicrosoftDataShareSentSnapshotLog'
      displayName: 'MicrosoftDataShareSentSnapshotLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MicrosoftDataShareShareLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MicrosoftDataShareShareLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MicrosoftDataShareShareLog'
      displayName: 'MicrosoftDataShareShareLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MicrosoftGraphActivityLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MicrosoftGraphActivityLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MicrosoftGraphActivityLogs'
      displayName: 'MicrosoftGraphActivityLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MicrosoftGraphPolicyLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MicrosoftGraphPolicyLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MicrosoftGraphPolicyLogs'
      displayName: 'MicrosoftGraphPolicyLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MicrosoftHealthcareApisAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MicrosoftHealthcareApisAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MicrosoftHealthcareApisAuditLogs'
      displayName: 'MicrosoftHealthcareApisAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MicrosoftServicePrincipalSignInLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MicrosoftServicePrincipalSignInLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MicrosoftServicePrincipalSignInLogs'
      displayName: 'MicrosoftServicePrincipalSignInLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MNFDeviceUpdates 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MNFDeviceUpdates'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MNFDeviceUpdates'
      displayName: 'MNFDeviceUpdates'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MNFSystemSessionHistoryUpdates 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MNFSystemSessionHistoryUpdates'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MNFSystemSessionHistoryUpdates'
      displayName: 'MNFSystemSessionHistoryUpdates'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MNFSystemStateMessageUpdates 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MNFSystemStateMessageUpdates'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MNFSystemStateMessageUpdates'
      displayName: 'MNFSystemStateMessageUpdates'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MPCAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MPCAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MPCAuditLogs'
      displayName: 'MPCAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MPCIngestionLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MPCIngestionLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MPCIngestionLogs'
      displayName: 'MPCIngestionLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MySqlAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MySqlAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MySqlAuditLogs'
      displayName: 'MySqlAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_MySqlSlowLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'MySqlSlowLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'MySqlSlowLogs'
      displayName: 'MySqlSlowLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NatGatewayFlowlogsV1 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NatGatewayFlowlogsV1'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NatGatewayFlowlogsV1'
      displayName: 'NatGatewayFlowlogsV1'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NCBMBreakGlassAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NCBMBreakGlassAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NCBMBreakGlassAuditLogs'
      displayName: 'NCBMBreakGlassAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NCBMSecurityDefenderLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NCBMSecurityDefenderLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NCBMSecurityDefenderLogs'
      displayName: 'NCBMSecurityDefenderLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NCBMSecurityLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NCBMSecurityLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NCBMSecurityLogs'
      displayName: 'NCBMSecurityLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NCBMSystemLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NCBMSystemLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NCBMSystemLogs'
      displayName: 'NCBMSystemLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NCCIDRACLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NCCIDRACLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NCCIDRACLogs'
      displayName: 'NCCIDRACLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NCCKubernetesAPIAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NCCKubernetesAPIAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NCCKubernetesAPIAuditLogs'
      displayName: 'NCCKubernetesAPIAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NCCKubernetesLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NCCKubernetesLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NCCKubernetesLogs'
      displayName: 'NCCKubernetesLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NCCPlatformOperationsLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NCCPlatformOperationsLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NCCPlatformOperationsLogs'
      displayName: 'NCCPlatformOperationsLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NCCVMOrchestrationLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NCCVMOrchestrationLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NCCVMOrchestrationLogs'
      displayName: 'NCCVMOrchestrationLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NCMClusterOperationsLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NCMClusterOperationsLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NCMClusterOperationsLogs'
      displayName: 'NCMClusterOperationsLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NCSStorageAlerts 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NCSStorageAlerts'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NCSStorageAlerts'
      displayName: 'NCSStorageAlerts'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NCSStorageAudits 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NCSStorageAudits'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NCSStorageAudits'
      displayName: 'NCSStorageAudits'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NCSStorageLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NCSStorageLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NCSStorageLogs'
      displayName: 'NCSStorageLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NetworkAccessAlerts 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NetworkAccessAlerts'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NetworkAccessAlerts'
      displayName: 'NetworkAccessAlerts'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NetworkAccessConnectionEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NetworkAccessConnectionEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NetworkAccessConnectionEvents'
      displayName: 'NetworkAccessConnectionEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NetworkAccessGenerativeAIInsights 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NetworkAccessGenerativeAIInsights'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NetworkAccessGenerativeAIInsights'
      displayName: 'NetworkAccessGenerativeAIInsights'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NetworkAccessTraffic 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NetworkAccessTraffic'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NetworkAccessTraffic'
      displayName: 'NetworkAccessTraffic'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NginxUpstreamUpdateLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NginxUpstreamUpdateLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NginxUpstreamUpdateLogs'
      displayName: 'NginxUpstreamUpdateLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NGXOperationLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NGXOperationLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NGXOperationLogs'
      displayName: 'NGXOperationLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NGXSecurityLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NGXSecurityLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NGXSecurityLogs'
      displayName: 'NGXSecurityLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NSPAccessLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NSPAccessLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NSPAccessLogs'
      displayName: 'NSPAccessLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NTAInsights 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NTAInsights'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NTAInsights'
      displayName: 'NTAInsights'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NTAIpDetails 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NTAIpDetails'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NTAIpDetails'
      displayName: 'NTAIpDetails'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NTANetAnalytics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NTANetAnalytics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NTANetAnalytics'
      displayName: 'NTANetAnalytics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NTANspRuleRecommendation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NTANspRuleRecommendation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NTANspRuleRecommendation'
      displayName: 'NTANspRuleRecommendation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NTARuleRecommendation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NTARuleRecommendation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NTARuleRecommendation'
      displayName: 'NTARuleRecommendation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NTATopologyDetails 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NTATopologyDetails'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NTATopologyDetails'
      displayName: 'NTATopologyDetails'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NWConnectionMonitorDestinationListenerResult 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NWConnectionMonitorDestinationListenerResult'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NWConnectionMonitorDestinationListenerResult'
      displayName: 'NWConnectionMonitorDestinationListenerResult'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NWConnectionMonitorDNSResult 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NWConnectionMonitorDNSResult'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NWConnectionMonitorDNSResult'
      displayName: 'NWConnectionMonitorDNSResult'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NWConnectionMonitorPathResult 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NWConnectionMonitorPathResult'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NWConnectionMonitorPathResult'
      displayName: 'NWConnectionMonitorPathResult'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NWConnectionMonitorTestResult 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NWConnectionMonitorTestResult'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NWConnectionMonitorTestResult'
      displayName: 'NWConnectionMonitorTestResult'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NWPacketCaptureDnsQuery 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NWPacketCaptureDnsQuery'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NWPacketCaptureDnsQuery'
      displayName: 'NWPacketCaptureDnsQuery'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NWPacketCaptureHttpTransaction 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NWPacketCaptureHttpTransaction'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NWPacketCaptureHttpTransaction'
      displayName: 'NWPacketCaptureHttpTransaction'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NWPacketCaptureNetworkSession 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NWPacketCaptureNetworkSession'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NWPacketCaptureNetworkSession'
      displayName: 'NWPacketCaptureNetworkSession'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_NWPacketCaptureTlsSession 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'NWPacketCaptureTlsSession'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'NWPacketCaptureTlsSession'
      displayName: 'NWPacketCaptureTlsSession'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ODSPFiles 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ODSPFiles'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ODSPFiles'
      displayName: 'ODSPFiles'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_OEPAirFlowTask 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'OEPAirFlowTask'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'OEPAirFlowTask'
      displayName: 'OEPAirFlowTask'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_OEPAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'OEPAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'OEPAuditLogs'
      displayName: 'OEPAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_OEPDataplaneLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'OEPDataplaneLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'OEPDataplaneLogs'
      displayName: 'OEPDataplaneLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_OEPElasticOperator 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'OEPElasticOperator'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'OEPElasticOperator'
      displayName: 'OEPElasticOperator'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_OEPElasticsearch 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'OEPElasticsearch'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'OEPElasticsearch'
      displayName: 'OEPElasticsearch'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_OEWAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'OEWAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'OEWAuditLogs'
      displayName: 'OEWAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_OEWExperimentAssignmentSummary 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'OEWExperimentAssignmentSummary'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'OEWExperimentAssignmentSummary'
      displayName: 'OEWExperimentAssignmentSummary'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_OEWExperimentScorecardMetricPairs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'OEWExperimentScorecardMetricPairs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'OEWExperimentScorecardMetricPairs'
      displayName: 'OEWExperimentScorecardMetricPairs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_OEWExperimentScorecards 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'OEWExperimentScorecards'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'OEWExperimentScorecards'
      displayName: 'OEWExperimentScorecards'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_OGOAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'OGOAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'OGOAuditLogs'
      displayName: 'OGOAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_OLPSupplyChainEntityOperations 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'OLPSupplyChainEntityOperations'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'OLPSupplyChainEntityOperations'
      displayName: 'OLPSupplyChainEntityOperations'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_OLPSupplyChainEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'OLPSupplyChainEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'OLPSupplyChainEvents'
      displayName: 'OLPSupplyChainEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_Operation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'Operation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'Operation'
      displayName: 'Operation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_OracleCloudDatabase 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'OracleCloudDatabase'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'OracleCloudDatabase'
      displayName: 'OracleCloudDatabase'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_OTelEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'OTelEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'OTelEvents'
      displayName: 'OTelEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_OTelLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'OTelLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'OTelLogs'
      displayName: 'OTelLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_OTelResources 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'OTelResources'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'OTelResources'
      displayName: 'OTelResources'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_OTelSpans 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'OTelSpans'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'OTelSpans'
      displayName: 'OTelSpans'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_OTelTraces 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'OTelTraces'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'OTelTraces'
      displayName: 'OTelTraces'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_OTelTracesAgent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'OTelTracesAgent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'OTelTracesAgent'
      displayName: 'OTelTracesAgent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_PartnerRiskEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'PartnerRiskEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'PartnerRiskEvents'
      displayName: 'PartnerRiskEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_PaymentHsmHardwareOperationAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'PaymentHsmHardwareOperationAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'PaymentHsmHardwareOperationAuditLogs'
      displayName: 'PaymentHsmHardwareOperationAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_Perf 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'Perf'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'Perf'
      displayName: 'Perf'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_PerfInsightsFindings 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'PerfInsightsFindings'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'PerfInsightsFindings'
      displayName: 'PerfInsightsFindings'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_PerfInsightsImpactedResources 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'PerfInsightsImpactedResources'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'PerfInsightsImpactedResources'
      displayName: 'PerfInsightsImpactedResources'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_PerfInsightsRun 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'PerfInsightsRun'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'PerfInsightsRun'
      displayName: 'PerfInsightsRun'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_PFTitleAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'PFTitleAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'PFTitleAuditLogs'
      displayName: 'PFTitleAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_PGSQLAutovacuumStats 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'PGSQLAutovacuumStats'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'PGSQLAutovacuumStats'
      displayName: 'PGSQLAutovacuumStats'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_PGSQLDbTransactionsStats 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'PGSQLDbTransactionsStats'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'PGSQLDbTransactionsStats'
      displayName: 'PGSQLDbTransactionsStats'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_PGSQLPgBouncer 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'PGSQLPgBouncer'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'PGSQLPgBouncer'
      displayName: 'PGSQLPgBouncer'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_PGSQLPgStatActivitySessions 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'PGSQLPgStatActivitySessions'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'PGSQLPgStatActivitySessions'
      displayName: 'PGSQLPgStatActivitySessions'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_PGSQLQueryStoreQueryText 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'PGSQLQueryStoreQueryText'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'PGSQLQueryStoreQueryText'
      displayName: 'PGSQLQueryStoreQueryText'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_PGSQLQueryStoreRuntime 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'PGSQLQueryStoreRuntime'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'PGSQLQueryStoreRuntime'
      displayName: 'PGSQLQueryStoreRuntime'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_PGSQLQueryStoreWaits 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'PGSQLQueryStoreWaits'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'PGSQLQueryStoreWaits'
      displayName: 'PGSQLQueryStoreWaits'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_PGSQLServerLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'PGSQLServerLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'PGSQLServerLogs'
      displayName: 'PGSQLServerLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_PowerBIDatasetsTenant 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'PowerBIDatasetsTenant'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'PowerBIDatasetsTenant'
      displayName: 'PowerBIDatasetsTenant'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_PowerBIDatasetsWorkspace 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'PowerBIDatasetsWorkspace'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'PowerBIDatasetsWorkspace'
      displayName: 'PowerBIDatasetsWorkspace'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_PreAuthenticationDiscoveryLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'PreAuthenticationDiscoveryLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'PreAuthenticationDiscoveryLogs'
      displayName: 'PreAuthenticationDiscoveryLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_PurviewDataSensitivityLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'PurviewDataSensitivityLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'PurviewDataSensitivityLogs'
      displayName: 'PurviewDataSensitivityLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_PurviewScanStatusLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'PurviewScanStatusLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'PurviewScanStatusLogs'
      displayName: 'PurviewScanStatusLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_PurviewSecurityLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'PurviewSecurityLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'PurviewSecurityLogs'
      displayName: 'PurviewSecurityLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_QuantumProviderAccountDeviceOperationLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'QuantumProviderAccountDeviceOperationLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'QuantumProviderAccountDeviceOperationLogs'
      displayName: 'QuantumProviderAccountDeviceOperationLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_QuantumProviderAccountJobAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'QuantumProviderAccountJobAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'QuantumProviderAccountJobAuditLogs'
      displayName: 'QuantumProviderAccountJobAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_QuantumProviderAccountMessageAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'QuantumProviderAccountMessageAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'QuantumProviderAccountMessageAuditLogs'
      displayName: 'QuantumProviderAccountMessageAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_QuantumProviderAccountQueueAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'QuantumProviderAccountQueueAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'QuantumProviderAccountQueueAuditLogs'
      displayName: 'QuantumProviderAccountQueueAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_QuantumProviderAccountTargetAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'QuantumProviderAccountTargetAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'QuantumProviderAccountTargetAuditLogs'
      displayName: 'QuantumProviderAccountTargetAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_QuantumWorkspaceJobAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'QuantumWorkspaceJobAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'QuantumWorkspaceJobAuditLogs'
      displayName: 'QuantumWorkspaceJobAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_REDConnectionEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'REDConnectionEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'REDConnectionEvents'
      displayName: 'REDConnectionEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_RemoteNetworkHealthLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'RemoteNetworkHealthLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'RemoteNetworkHealthLogs'
      displayName: 'RemoteNetworkHealthLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ResourceManagementPublicAccessLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ResourceManagementPublicAccessLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ResourceManagementPublicAccessLogs'
      displayName: 'ResourceManagementPublicAccessLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_RetinaNetworkFlowLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'RetinaNetworkFlowLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'RetinaNetworkFlowLogs'
      displayName: 'RetinaNetworkFlowLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SCCMAssessmentRecommendation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SCCMAssessmentRecommendation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SCCMAssessmentRecommendation'
      displayName: 'SCCMAssessmentRecommendation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SCGPoolExecutionLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SCGPoolExecutionLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SCGPoolExecutionLog'
      displayName: 'SCGPoolExecutionLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SCGPoolRequestLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SCGPoolRequestLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SCGPoolRequestLog'
      displayName: 'SCGPoolRequestLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SCOMAssessmentRecommendation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SCOMAssessmentRecommendation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SCOMAssessmentRecommendation'
      displayName: 'SCOMAssessmentRecommendation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ServiceFabricOperationalEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ServiceFabricOperationalEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ServiceFabricOperationalEvent'
      displayName: 'ServiceFabricOperationalEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ServiceFabricReliableActorEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ServiceFabricReliableActorEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ServiceFabricReliableActorEvent'
      displayName: 'ServiceFabricReliableActorEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ServiceFabricReliableServiceEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ServiceFabricReliableServiceEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ServiceFabricReliableServiceEvent'
      displayName: 'ServiceFabricReliableServiceEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SfBAssessmentRecommendation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SfBAssessmentRecommendation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SfBAssessmentRecommendation'
      displayName: 'SfBAssessmentRecommendation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SfBOnlineAssessmentRecommendation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SfBOnlineAssessmentRecommendation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SfBOnlineAssessmentRecommendation'
      displayName: 'SfBOnlineAssessmentRecommendation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SharePointOnlineAssessmentRecommendation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SharePointOnlineAssessmentRecommendation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SharePointOnlineAssessmentRecommendation'
      displayName: 'SharePointOnlineAssessmentRecommendation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SignalRServiceDiagnosticLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SignalRServiceDiagnosticLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SignalRServiceDiagnosticLogs'
      displayName: 'SignalRServiceDiagnosticLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SigninLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SigninLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SigninLogs'
      displayName: 'SigninLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SPAssessmentRecommendation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SPAssessmentRecommendation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SPAssessmentRecommendation'
      displayName: 'SPAssessmentRecommendation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SQLAssessmentRecommendation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SQLAssessmentRecommendation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SQLAssessmentRecommendation'
      displayName: 'SQLAssessmentRecommendation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SQLSecurityAuditEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SQLSecurityAuditEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SQLSecurityAuditEvents'
      displayName: 'SQLSecurityAuditEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_StorageAntimalwareScanResults 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'StorageAntimalwareScanResults'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'StorageAntimalwareScanResults'
      displayName: 'StorageAntimalwareScanResults'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_StorageBlobLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'StorageBlobLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'StorageBlobLogs'
      displayName: 'StorageBlobLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_StorageCacheOperationEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'StorageCacheOperationEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'StorageCacheOperationEvents'
      displayName: 'StorageCacheOperationEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_StorageCacheUpgradeEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'StorageCacheUpgradeEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'StorageCacheUpgradeEvents'
      displayName: 'StorageCacheUpgradeEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_StorageCacheWarningEvents 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'StorageCacheWarningEvents'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'StorageCacheWarningEvents'
      displayName: 'StorageCacheWarningEvents'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_StorageFileLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'StorageFileLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'StorageFileLogs'
      displayName: 'StorageFileLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_StorageMalwareScanningResults 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'StorageMalwareScanningResults'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'StorageMalwareScanningResults'
      displayName: 'StorageMalwareScanningResults'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_StorageMoverAuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'StorageMoverAuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'StorageMoverAuditLogs'
      displayName: 'StorageMoverAuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_StorageMoverCopyLogsFailed 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'StorageMoverCopyLogsFailed'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'StorageMoverCopyLogsFailed'
      displayName: 'StorageMoverCopyLogsFailed'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_StorageMoverCopyLogsTransferred 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'StorageMoverCopyLogsTransferred'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'StorageMoverCopyLogsTransferred'
      displayName: 'StorageMoverCopyLogsTransferred'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_StorageMoverJobRunLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'StorageMoverJobRunLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'StorageMoverJobRunLogs'
      displayName: 'StorageMoverJobRunLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_StorageQueueLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'StorageQueueLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'StorageQueueLogs'
      displayName: 'StorageQueueLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_StorageTableLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'StorageTableLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'StorageTableLogs'
      displayName: 'StorageTableLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SucceededIngestion 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SucceededIngestion'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SucceededIngestion'
      displayName: 'SucceededIngestion'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SVMPoolExecutionLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SVMPoolExecutionLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SVMPoolExecutionLog'
      displayName: 'SVMPoolExecutionLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SVMPoolRequestLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SVMPoolRequestLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SVMPoolRequestLog'
      displayName: 'SVMPoolRequestLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseBigDataPoolApplicationsEnded 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseBigDataPoolApplicationsEnded'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseBigDataPoolApplicationsEnded'
      displayName: 'SynapseBigDataPoolApplicationsEnded'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseBuiltinSqlPoolRequestsEnded 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseBuiltinSqlPoolRequestsEnded'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseBuiltinSqlPoolRequestsEnded'
      displayName: 'SynapseBuiltinSqlPoolRequestsEnded'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseDXCommand 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseDXCommand'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseDXCommand'
      displayName: 'SynapseDXCommand'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseDXFailedIngestion 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseDXFailedIngestion'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseDXFailedIngestion'
      displayName: 'SynapseDXFailedIngestion'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseDXIngestionBatching 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseDXIngestionBatching'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseDXIngestionBatching'
      displayName: 'SynapseDXIngestionBatching'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseDXQuery 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseDXQuery'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseDXQuery'
      displayName: 'SynapseDXQuery'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseDXSucceededIngestion 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseDXSucceededIngestion'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseDXSucceededIngestion'
      displayName: 'SynapseDXSucceededIngestion'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseDXTableDetails 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseDXTableDetails'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseDXTableDetails'
      displayName: 'SynapseDXTableDetails'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseDXTableUsageStatistics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseDXTableUsageStatistics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseDXTableUsageStatistics'
      displayName: 'SynapseDXTableUsageStatistics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseGatewayApiRequests 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseGatewayApiRequests'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseGatewayApiRequests'
      displayName: 'SynapseGatewayApiRequests'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseIntegrationActivityRuns 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseIntegrationActivityRuns'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseIntegrationActivityRuns'
      displayName: 'SynapseIntegrationActivityRuns'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseIntegrationPipelineRuns 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseIntegrationPipelineRuns'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseIntegrationPipelineRuns'
      displayName: 'SynapseIntegrationPipelineRuns'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseIntegrationTriggerRuns 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseIntegrationTriggerRuns'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseIntegrationTriggerRuns'
      displayName: 'SynapseIntegrationTriggerRuns'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseLinkEvent 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseLinkEvent'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseLinkEvent'
      displayName: 'SynapseLinkEvent'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseRbacOperations 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseRbacOperations'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseRbacOperations'
      displayName: 'SynapseRbacOperations'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseScopePoolScopeJobsEnded 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseScopePoolScopeJobsEnded'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseScopePoolScopeJobsEnded'
      displayName: 'SynapseScopePoolScopeJobsEnded'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseScopePoolScopeJobsStateChange 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseScopePoolScopeJobsStateChange'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseScopePoolScopeJobsStateChange'
      displayName: 'SynapseScopePoolScopeJobsStateChange'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseSqlPoolDmsWorkers 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseSqlPoolDmsWorkers'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseSqlPoolDmsWorkers'
      displayName: 'SynapseSqlPoolDmsWorkers'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseSqlPoolExecRequests 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseSqlPoolExecRequests'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseSqlPoolExecRequests'
      displayName: 'SynapseSqlPoolExecRequests'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseSqlPoolRequestSteps 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseSqlPoolRequestSteps'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseSqlPoolRequestSteps'
      displayName: 'SynapseSqlPoolRequestSteps'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseSqlPoolSqlRequests 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseSqlPoolSqlRequests'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseSqlPoolSqlRequests'
      displayName: 'SynapseSqlPoolSqlRequests'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_SynapseSqlPoolWaits 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'SynapseSqlPoolWaits'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'SynapseSqlPoolWaits'
      displayName: 'SynapseSqlPoolWaits'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_Syslog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'Syslog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'Syslog'
      displayName: 'Syslog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_TOUserAudits 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'TOUserAudits'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'TOUserAudits'
      displayName: 'TOUserAudits'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_TOUserDiagnostics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'TOUserDiagnostics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'TOUserDiagnostics'
      displayName: 'TOUserDiagnostics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_TSIIngress 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'TSIIngress'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'TSIIngress'
      displayName: 'TSIIngress'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_UCClient 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'UCClient'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'UCClient'
      displayName: 'UCClient'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_UCClientReadinessStatus 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'UCClientReadinessStatus'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'UCClientReadinessStatus'
      displayName: 'UCClientReadinessStatus'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_UCClientUpdateStatus 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'UCClientUpdateStatus'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'UCClientUpdateStatus'
      displayName: 'UCClientUpdateStatus'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_UCDeviceAlert 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'UCDeviceAlert'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'UCDeviceAlert'
      displayName: 'UCDeviceAlert'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_UCDOAggregatedStatus 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'UCDOAggregatedStatus'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'UCDOAggregatedStatus'
      displayName: 'UCDOAggregatedStatus'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_UCDOStatus 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'UCDOStatus'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'UCDOStatus'
      displayName: 'UCDOStatus'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_UCServiceUpdateStatus 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'UCServiceUpdateStatus'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'UCServiceUpdateStatus'
      displayName: 'UCServiceUpdateStatus'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_UCUpdateAlert 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'UCUpdateAlert'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'UCUpdateAlert'
      displayName: 'UCUpdateAlert'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_Usage 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'Usage'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 90
    plan: 'Analytics'
    schema: {
      name: 'Usage'
      displayName: 'Usage'
    }
    retentionInDays: 90
  }
}

resource workspaces_law_3tier_prod_name_VCoreMongoRequests 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'VCoreMongoRequests'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'VCoreMongoRequests'
      displayName: 'VCoreMongoRequests'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_VIAudit 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'VIAudit'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'VIAudit'
      displayName: 'VIAudit'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_VIIndexing 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'VIIndexing'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'VIIndexing'
      displayName: 'VIIndexing'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_VMBoundPort 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'VMBoundPort'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'VMBoundPort'
      displayName: 'VMBoundPort'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_VMComputer 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'VMComputer'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'VMComputer'
      displayName: 'VMComputer'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_VMConnection 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'VMConnection'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'VMConnection'
      displayName: 'VMConnection'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_VMProcess 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'VMProcess'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'VMProcess'
      displayName: 'VMProcess'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_W3CIISLog 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'W3CIISLog'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'W3CIISLog'
      displayName: 'W3CIISLog'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_WebPubSubConnectivity 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'WebPubSubConnectivity'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'WebPubSubConnectivity'
      displayName: 'WebPubSubConnectivity'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_WebPubSubHttpRequest 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'WebPubSubHttpRequest'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'WebPubSubHttpRequest'
      displayName: 'WebPubSubHttpRequest'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_WebPubSubMessaging 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'WebPubSubMessaging'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'WebPubSubMessaging'
      displayName: 'WebPubSubMessaging'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_Windows365AuditLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'Windows365AuditLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'Windows365AuditLogs'
      displayName: 'Windows365AuditLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_Windows365CheckpointLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'Windows365CheckpointLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'Windows365CheckpointLogs'
      displayName: 'Windows365CheckpointLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_Windows365ConnectionErrorLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'Windows365ConnectionErrorLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'Windows365ConnectionErrorLogs'
      displayName: 'Windows365ConnectionErrorLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_Windows365ConnectionLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'Windows365ConnectionLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'Windows365ConnectionLogs'
      displayName: 'Windows365ConnectionLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_Windows365NetworkLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'Windows365NetworkLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'Windows365NetworkLogs'
      displayName: 'Windows365NetworkLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_WindowsClientAssessmentRecommendation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'WindowsClientAssessmentRecommendation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'WindowsClientAssessmentRecommendation'
      displayName: 'WindowsClientAssessmentRecommendation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_WindowsServerAssessmentRecommendation 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'WindowsServerAssessmentRecommendation'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'WindowsServerAssessmentRecommendation'
      displayName: 'WindowsServerAssessmentRecommendation'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_WorkloadDiagnosticLogs 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'WorkloadDiagnosticLogs'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'WorkloadDiagnosticLogs'
      displayName: 'WorkloadDiagnosticLogs'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_WOUserAudits 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'WOUserAudits'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'WOUserAudits'
      displayName: 'WOUserAudits'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_WOUserDiagnostics 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'WOUserDiagnostics'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'WOUserDiagnostics'
      displayName: 'WOUserDiagnostics'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_WVDAgentHealthStatus 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'WVDAgentHealthStatus'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'WVDAgentHealthStatus'
      displayName: 'WVDAgentHealthStatus'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_WVDAutoscaleEvaluationPooled 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'WVDAutoscaleEvaluationPooled'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'WVDAutoscaleEvaluationPooled'
      displayName: 'WVDAutoscaleEvaluationPooled'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_WVDCheckpoints 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'WVDCheckpoints'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'WVDCheckpoints'
      displayName: 'WVDCheckpoints'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_WVDConnectionGraphicsDataPreview 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'WVDConnectionGraphicsDataPreview'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'WVDConnectionGraphicsDataPreview'
      displayName: 'WVDConnectionGraphicsDataPreview'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_WVDConnectionNetworkData 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'WVDConnectionNetworkData'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'WVDConnectionNetworkData'
      displayName: 'WVDConnectionNetworkData'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_WVDConnections 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'WVDConnections'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'WVDConnections'
      displayName: 'WVDConnections'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_WVDErrors 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'WVDErrors'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'WVDErrors'
      displayName: 'WVDErrors'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_WVDFeeds 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'WVDFeeds'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'WVDFeeds'
      displayName: 'WVDFeeds'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_WVDHostRegistrations 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'WVDHostRegistrations'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'WVDHostRegistrations'
      displayName: 'WVDHostRegistrations'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_WVDManagement 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'WVDManagement'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'WVDManagement'
      displayName: 'WVDManagement'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_WVDMultiLinkAdd 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'WVDMultiLinkAdd'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'WVDMultiLinkAdd'
      displayName: 'WVDMultiLinkAdd'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_WVDSessionHostManagement 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'WVDSessionHostManagement'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'WVDSessionHostManagement'
      displayName: 'WVDSessionHostManagement'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ZTSGraph 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ZTSGraph'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ZTSGraph'
      displayName: 'ZTSGraph'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ZTSJobStatus 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ZTSJobStatus'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ZTSJobStatus'
      displayName: 'ZTSJobStatus'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ZTSMetadata 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ZTSMetadata'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ZTSMetadata'
      displayName: 'ZTSMetadata'
    }
    retentionInDays: 30
  }
}

resource workspaces_law_3tier_prod_name_ZTSRequest 'Microsoft.OperationalInsights/workspaces/tables@2026-03-01' = {
  parent: workspaces_law_3tier_prod_name_resource
  name: 'ZTSRequest'
  properties: {
    protectionLevel: 'General'
    totalRetentionInDays: 30
    plan: 'Analytics'
    schema: {
      name: 'ZTSRequest'
      displayName: 'ZTSRequest'
    }
    retentionInDays: 30
  }
}

resource servers_sqlserver_3tier_prod_ban_name_ActiveDirectory 'Microsoft.Sql/servers/administrators@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_resource
  name: 'ActiveDirectory'
  properties: {
    administratorType: 'ActiveDirectory'
    login: 'anfumbom12@outlook.com'
    sid: 'cce919f3-7c71-40fe-b3b2-7423cb557088'
    tenantId: '73ede107-6fff-4721-87b5-06b3979de425'
  }
}

resource servers_sqlserver_3tier_prod_ban_name_Default 'Microsoft.Sql/servers/advancedThreatProtectionSettings@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_resource
  name: 'Default'
  properties: {
    state: 'Disabled'
  }
}

resource servers_sqlserver_3tier_prod_ban_name_CreateIndex 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: servers_sqlserver_3tier_prod_ban_name_resource
  name: 'CreateIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
}

resource servers_sqlserver_3tier_prod_ban_name_DbParameterization 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: servers_sqlserver_3tier_prod_ban_name_resource
  name: 'DbParameterization'
  properties: {
    autoExecuteValue: 'Disabled'
  }
}

resource servers_sqlserver_3tier_prod_ban_name_DefragmentIndex 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: servers_sqlserver_3tier_prod_ban_name_resource
  name: 'DefragmentIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
}

resource servers_sqlserver_3tier_prod_ban_name_DropIndex 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: servers_sqlserver_3tier_prod_ban_name_resource
  name: 'DropIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
}

resource servers_sqlserver_3tier_prod_ban_name_ForceLastGoodPlan 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: servers_sqlserver_3tier_prod_ban_name_resource
  name: 'ForceLastGoodPlan'
  properties: {
    autoExecuteValue: 'Enabled'
  }
}

resource Microsoft_Sql_servers_auditingPolicies_servers_sqlserver_3tier_prod_ban_name_Default 'Microsoft.Sql/servers/auditingPolicies@2014-04-01' = {
  parent: servers_sqlserver_3tier_prod_ban_name_resource
  name: 'Default'
  location: 'Canada Central'
  properties: {
    auditingState: 'Disabled'
  }
}

resource Microsoft_Sql_servers_auditingSettings_servers_sqlserver_3tier_prod_ban_name_Default 'Microsoft.Sql/servers/auditingSettings@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_resource
  name: 'Default'
  properties: {
    retentionDays: 0
    auditActionsAndGroups: []
    isStorageSecondaryKeyInUse: false
    isAzureMonitorTargetEnabled: false
    isManagedIdentityInUse: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource Microsoft_Sql_servers_azureADOnlyAuthentications_servers_sqlserver_3tier_prod_ban_name_Default 'Microsoft.Sql/servers/azureADOnlyAuthentications@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_resource
  name: 'Default'
  properties: {
    azureADOnlyAuthentication: false
  }
}

resource Microsoft_Sql_servers_connectionPolicies_servers_sqlserver_3tier_prod_ban_name_default 'Microsoft.Sql/servers/connectionPolicies@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_resource
  name: 'default'
  location: 'canadacentral'
  properties: {
    connectionType: 'Default'
  }
}

resource servers_sqlserver_3tier_prod_ban_name_AppDatabase 'Microsoft.Sql/servers/databases@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_resource
  name: 'AppDatabase'
  location: 'canadacentral'
  tags: {
    Costcenter: 'IT-portfolio'
    Environment: 'Production'
    Owner: 'Betty'
    project: 'ThreeTierCapstone'
  }
  sku: {
    name: 'Basic'
    tier: 'Basic'
    capacity: 5
  }
  kind: 'v12.0,user'
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 2147483648
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
    zoneRedundant: false
    readScale: 'Disabled'
    requestedBackupStorageRedundancy: 'Local'
    maintenanceConfigurationId: '/subscriptions/a885c71b-3924-4e7b-b1fe-d2fb3ef755d5/providers/Microsoft.Maintenance/publicMaintenanceConfigurations/SQL_Default'
    isLedgerOn: false
    availabilityZone: 'NoPreference'
  }
}

resource servers_sqlserver_3tier_prod_ban_name_master_Default 'Microsoft.Sql/servers/databases/advancedThreatProtectionSettings@2026-08-01-preview' = {
  name: '${servers_sqlserver_3tier_prod_ban_name}/master/Default'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_auditingPolicies_servers_sqlserver_3tier_prod_ban_name_master_Default 'Microsoft.Sql/servers/databases/auditingPolicies@2014-04-01' = {
  name: '${servers_sqlserver_3tier_prod_ban_name}/master/Default'
  location: 'Canada Central'
  properties: {
    auditingState: 'Disabled'
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_auditingSettings_servers_sqlserver_3tier_prod_ban_name_master_Default 'Microsoft.Sql/servers/databases/auditingSettings@2026-08-01-preview' = {
  name: '${servers_sqlserver_3tier_prod_ban_name}/master/Default'
  properties: {
    retentionDays: 0
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_extendedAuditingSettings_servers_sqlserver_3tier_prod_ban_name_master_Default 'Microsoft.Sql/servers/databases/extendedAuditingSettings@2026-08-01-preview' = {
  name: '${servers_sqlserver_3tier_prod_ban_name}/master/Default'
  properties: {
    retentionDays: 0
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_geoBackupPolicies_servers_sqlserver_3tier_prod_ban_name_master_Default 'Microsoft.Sql/servers/databases/geoBackupPolicies@2026-08-01-preview' = {
  name: '${servers_sqlserver_3tier_prod_ban_name}/master/Default'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource servers_sqlserver_3tier_prod_ban_name_master_Current 'Microsoft.Sql/servers/databases/ledgerDigestUploads@2026-08-01-preview' = {
  name: '${servers_sqlserver_3tier_prod_ban_name}/master/Current'
  properties: {}
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_securityAlertPolicies_servers_sqlserver_3tier_prod_ban_name_master_Default 'Microsoft.Sql/servers/databases/securityAlertPolicies@2026-08-01-preview' = {
  name: '${servers_sqlserver_3tier_prod_ban_name}/master/Default'
  properties: {
    state: 'Disabled'
    disabledAlerts: [
      ''
    ]
    emailAddresses: [
      ''
    ]
    emailAccountAdmins: false
    retentionDays: 0
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_transparentDataEncryption_servers_sqlserver_3tier_prod_ban_name_master_Current 'Microsoft.Sql/servers/databases/transparentDataEncryption@2026-08-01-preview' = {
  name: '${servers_sqlserver_3tier_prod_ban_name}/master/Current'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_vulnerabilityAssessments_servers_sqlserver_3tier_prod_ban_name_master_Default 'Microsoft.Sql/servers/databases/vulnerabilityAssessments@2026-08-01-preview' = {
  name: '${servers_sqlserver_3tier_prod_ban_name}/master/Default'
  properties: {
    recurringScans: {
      isEnabled: false
      emailSubscriptionAdmins: true
    }
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource Microsoft_Sql_servers_devOpsAuditingSettings_servers_sqlserver_3tier_prod_ban_name_Default 'Microsoft.Sql/servers/devOpsAuditingSettings@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_resource
  name: 'Default'
  properties: {
    isAzureMonitorTargetEnabled: false
    isManagedIdentityInUse: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource servers_sqlserver_3tier_prod_ban_name_current 'Microsoft.Sql/servers/encryptionProtector@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_resource
  name: 'current'
  kind: 'servicemanaged'
  properties: {
    serverKeyName: 'ServiceManaged'
    serverKeyType: 'ServiceManaged'
    autoRotationEnabled: false
  }
}

resource Microsoft_Sql_servers_extendedAuditingSettings_servers_sqlserver_3tier_prod_ban_name_Default 'Microsoft.Sql/servers/extendedAuditingSettings@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_resource
  name: 'Default'
  properties: {
    retentionDays: 0
    auditActionsAndGroups: []
    isStorageSecondaryKeyInUse: false
    isAzureMonitorTargetEnabled: false
    isManagedIdentityInUse: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource servers_sqlserver_3tier_prod_ban_name_ServiceManaged 'Microsoft.Sql/servers/keys@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_resource
  name: 'ServiceManaged'
  kind: 'servicemanaged'
  properties: {
    serverKeyType: 'ServiceManaged'
  }
}

resource Microsoft_Sql_servers_securityAlertPolicies_servers_sqlserver_3tier_prod_ban_name_Default 'Microsoft.Sql/servers/securityAlertPolicies@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_resource
  name: 'Default'
  properties: {
    state: 'Disabled'
    disabledAlerts: [
      ''
    ]
    emailAddresses: [
      ''
    ]
    emailAccountAdmins: false
    retentionDays: 0
  }
}

resource Microsoft_Sql_servers_sqlVulnerabilityAssessments_servers_sqlserver_3tier_prod_ban_name_Default 'Microsoft.Sql/servers/sqlVulnerabilityAssessments@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_resource
  name: 'Default'
  properties: {
    state: 'Disabled'
  }
}

resource Microsoft_Sql_servers_vulnerabilityAssessments_servers_sqlserver_3tier_prod_ban_name_Default 'Microsoft.Sql/servers/vulnerabilityAssessments@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_resource
  name: 'Default'
  properties: {
    recurringScans: {
      isEnabled: false
      emailSubscriptionAdmins: true
    }
    storageContainerPath: vulnerabilityAssessments_Default_storageContainerPath
  }
}

resource sites_rg_3tier_capstone_prod_ban123_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2024-11-01' = {
  parent: sites_rg_3tier_capstone_prod_ban123_name_resource
  name: 'ftp'
  location: 'Canada East'
  tags: {
    Costcenter: 'IT-portfolio'
    Environment: 'Production'
    Owner: 'Betty'
    project: 'ThreeTierCapstone'
  }
  properties: {
    allow: false
  }
}

resource sites_rg_3tier_capstone_prod_ban123_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2024-11-01' = {
  parent: sites_rg_3tier_capstone_prod_ban123_name_resource
  name: 'scm'
  location: 'Canada East'
  tags: {
    Costcenter: 'IT-portfolio'
    Environment: 'Production'
    Owner: 'Betty'
    project: 'ThreeTierCapstone'
  }
  properties: {
    allow: false
  }
}

resource sites_rg_3tier_capstone_prod_ban123_name_web 'Microsoft.Web/sites/config@2024-11-01' = {
  parent: sites_rg_3tier_capstone_prod_ban123_name_resource
  name: 'web'
  location: 'Canada East'
  tags: {
    Costcenter: 'IT-portfolio'
    Environment: 'Production'
    Owner: 'Betty'
    project: 'ThreeTierCapstone'
  }
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
      'hostingstart.html'
    ]
    netFrameworkVersion: 'v4.0'
    linuxFxVersion: 'NODE|22-lts'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: 'REDACTED'
    scmType: 'None'
    use32BitWorkerProcess: true
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetName: '2de1e9b1-289a-4798-b0f3-8e4dcaf2b1ca_snet-webapp-ce'
    vnetRouteAllEnabled: true
    vnetPrivatePortsCount: 0
    publicNetworkAccess: 'Enabled'
    localMySqlEnabled: false
    managedServiceIdentityId: 10496
    ipSecurityRestrictions: [
      {
        ipAddress: '4.173.230.215/32'
        action: 'Allow'
        tag: 'Default'
        priority: 100
        name: 'Allow-Only-AppGw'
      }
      {
        ipAddress: 'Any'
        action: 'Deny'
        priority: 2147483647
        name: 'Deny all'
        description: 'Deny all access'
      }
    ]
    ipSecurityRestrictionsDefaultAction: 'Deny'
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsDefaultAction: 'Allow'
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'FtpsOnly'
    preWarmedInstanceCount: 0
    elasticWebAppScaleLimit: 0
    functionsRuntimeScaleMonitoringEnabled: false
    minimumElasticInstanceCount: 0
    azureStorageAccounts: {}
    http20ProxyFlag: 0
  }
}

resource sites_rg_3tier_capstone_prod_ban123_name_sites_rg_3tier_capstone_prod_ban123_name_bdffg4c3cmfvabcn_canadaeast_01_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2024-11-01' = {
  parent: sites_rg_3tier_capstone_prod_ban123_name_resource
  name: '${sites_rg_3tier_capstone_prod_ban123_name}-bdffg4c3cmfvabcn.canadaeast-01.azurewebsites.net'
  location: 'Canada East'
  properties: {
    siteName: 'rg-3tier-capstone-prod-ban123'
    hostNameType: 'Verified'
  }
}

resource privateDnsZones_privatelink_database_windows_net_name_7z57deafjwxcs 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_database_windows_net_name_resource
  name: '7z57deafjwxcs'
  location: 'global'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_Vnet_3tier_prod_name_resource.id
    }
  }
}

resource privateDnsZones_privatelink_database_windows_net_name_link_vnet_webapp_ce 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_database_windows_net_name_resource
  name: 'link-vnet-webapp-ce'
  location: 'global'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_vnet_webapp_centraleast_name_resource.id
    }
  }
}

resource privateEndpoints_pe_sqlserver_prod_name_resource 'Microsoft.Network/privateEndpoints@2025-09-01' = {
  name: privateEndpoints_pe_sqlserver_prod_name
  location: 'canadacentral'
  tags: {
    Costcenter: 'IT-portfolio'
    Environment: 'Production'
    Owner: 'Betty'
    project: 'ThreeTierCapstone'
  }
  properties: {
    privateLinkServiceConnections: [
      {
        name: privateEndpoints_pe_sqlserver_prod_name
        id: '${privateEndpoints_pe_sqlserver_prod_name_resource.id}/privateLinkServiceConnections/${privateEndpoints_pe_sqlserver_prod_name}'
        properties: {
          privateLinkServiceId: servers_sqlserver_3tier_prod_ban_name_resource.id
          groupIds: [
            'sqlServer'
          ]
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Auto-approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
    manualPrivateLinkServiceConnections: []
    customNetworkInterfaceName: '${privateEndpoints_pe_sqlserver_prod_name}-nic'
    subnet: {
      id: virtualNetworks_Vnet_3tier_prod_name_snet_data.id
    }
    ipConfigurations: []
    customDnsConfigs: []
    ipVersionType: 'IPv4'
  }
}

resource privateEndpoints_pe_sqlserver_prod_name_default 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2025-09-01' = {
  name: '${privateEndpoints_pe_sqlserver_prod_name}/default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'privatelink-database-windows-net'
        properties: {
          privateDnsZoneId: privateDnsZones_privatelink_database_windows_net_name_resource.id
        }
      }
    ]
  }
  dependsOn: [
    privateEndpoints_pe_sqlserver_prod_name_resource
  ]
}

resource virtualNetworks_Vnet_3tier_prod_name_snet_data 'Microsoft.Network/virtualNetworks/subnets@2025-09-01' = {
  name: '${virtualNetworks_Vnet_3tier_prod_name}/snet-data'
  properties: {
    addressPrefixes: [
      '10.0.3.0/24'
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_nsg_data_name_resource.id
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_Vnet_3tier_prod_name_resource
  ]
}

resource virtualNetworks_Vnet_3tier_prod_name_snet_webapp 'Microsoft.Network/virtualNetworks/subnets@2025-09-01' = {
  name: '${virtualNetworks_Vnet_3tier_prod_name}/snet-webapp'
  properties: {
    addressPrefixes: [
      '10.0.2.0/24'
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_nsp_webapp_name_resource.id
    }
    delegations: [
      {
        name: 'Microsoft.Web/serverFarms'
        id: '${virtualNetworks_Vnet_3tier_prod_name_snet_webapp.id}/delegations/Microsoft.Web/serverFarms'
        properties: {
          serviceName: 'Microsoft.Web/serverFarms'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
      }
    ]
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_Vnet_3tier_prod_name_resource
  ]
}

resource virtualNetworks_vnet_webapp_centraleast_name_pee_ce_cc 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2025-09-01' = {
  name: '${virtualNetworks_vnet_webapp_centraleast_name}/pee-ce-cc'
  properties: {
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: virtualNetworks_Vnet_3tier_prod_name_resource.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: false
    peerCompleteVnets: true
    enableOnlyIPv6Peering: false
    remoteAddressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
  dependsOn: [
    virtualNetworks_vnet_webapp_centraleast_name_resource
  ]
}

resource virtualNetworks_Vnet_3tier_prod_name_peer_cc_ce 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2025-09-01' = {
  name: '${virtualNetworks_Vnet_3tier_prod_name}/peer-cc-ce'
  properties: {
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: virtualNetworks_vnet_webapp_centraleast_name_resource.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: false
    peerCompleteVnets: true
    enableOnlyIPv6Peering: false
    remoteAddressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
  }
  dependsOn: [
    virtualNetworks_Vnet_3tier_prod_name_resource
  ]
}

resource servers_sqlserver_3tier_prod_ban_name_AppDatabase_Default 'Microsoft.Sql/servers/databases/advancedThreatProtectionSettings@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_AppDatabase
  name: 'Default'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource servers_sqlserver_3tier_prod_ban_name_AppDatabase_CreateIndex 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
  parent: servers_sqlserver_3tier_prod_ban_name_AppDatabase
  name: 'CreateIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource servers_sqlserver_3tier_prod_ban_name_AppDatabase_DbParameterization 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
  parent: servers_sqlserver_3tier_prod_ban_name_AppDatabase
  name: 'DbParameterization'
  properties: {
    autoExecuteValue: 'Disabled'
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource servers_sqlserver_3tier_prod_ban_name_AppDatabase_DefragmentIndex 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
  parent: servers_sqlserver_3tier_prod_ban_name_AppDatabase
  name: 'DefragmentIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource servers_sqlserver_3tier_prod_ban_name_AppDatabase_DropIndex 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
  parent: servers_sqlserver_3tier_prod_ban_name_AppDatabase
  name: 'DropIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource servers_sqlserver_3tier_prod_ban_name_AppDatabase_ForceLastGoodPlan 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
  parent: servers_sqlserver_3tier_prod_ban_name_AppDatabase
  name: 'ForceLastGoodPlan'
  properties: {
    autoExecuteValue: 'Enabled'
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_auditingPolicies_servers_sqlserver_3tier_prod_ban_name_AppDatabase_Default 'Microsoft.Sql/servers/databases/auditingPolicies@2014-04-01' = {
  parent: servers_sqlserver_3tier_prod_ban_name_AppDatabase
  name: 'Default'
  location: 'Canada Central'
  properties: {
    auditingState: 'Disabled'
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_auditingSettings_servers_sqlserver_3tier_prod_ban_name_AppDatabase_Default 'Microsoft.Sql/servers/databases/auditingSettings@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_AppDatabase
  name: 'Default'
  properties: {
    retentionDays: 0
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_backupLongTermRetentionPolicies_servers_sqlserver_3tier_prod_ban_name_AppDatabase_default 'Microsoft.Sql/servers/databases/backupLongTermRetentionPolicies@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_AppDatabase
  name: 'default'
  properties: {
    timeBasedImmutability: 'Disabled'
    weeklyRetention: 'P4W'
    monthlyRetention: 'PT0S'
    yearlyRetention: 'PT0S'
    weekOfYear: 0
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_backupShortTermRetentionPolicies_servers_sqlserver_3tier_prod_ban_name_AppDatabase_default 'Microsoft.Sql/servers/databases/backupShortTermRetentionPolicies@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_AppDatabase
  name: 'default'
  properties: {
    retentionDays: 7
    diffBackupIntervalInHours: 24
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_extendedAuditingSettings_servers_sqlserver_3tier_prod_ban_name_AppDatabase_Default 'Microsoft.Sql/servers/databases/extendedAuditingSettings@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_AppDatabase
  name: 'Default'
  properties: {
    retentionDays: 0
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_geoBackupPolicies_servers_sqlserver_3tier_prod_ban_name_AppDatabase_Default 'Microsoft.Sql/servers/databases/geoBackupPolicies@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_AppDatabase
  name: 'Default'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource servers_sqlserver_3tier_prod_ban_name_AppDatabase_Current 'Microsoft.Sql/servers/databases/ledgerDigestUploads@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_AppDatabase
  name: 'Current'
  properties: {}
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_securityAlertPolicies_servers_sqlserver_3tier_prod_ban_name_AppDatabase_Default 'Microsoft.Sql/servers/databases/securityAlertPolicies@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_AppDatabase
  name: 'Default'
  properties: {
    state: 'Disabled'
    disabledAlerts: [
      ''
    ]
    emailAddresses: [
      ''
    ]
    emailAccountAdmins: false
    retentionDays: 0
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_transparentDataEncryption_servers_sqlserver_3tier_prod_ban_name_AppDatabase_Current 'Microsoft.Sql/servers/databases/transparentDataEncryption@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_AppDatabase
  name: 'Current'
  properties: {
    state: 'Enabled'
    scanState: 'Complete'
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_vulnerabilityAssessments_servers_sqlserver_3tier_prod_ban_name_AppDatabase_Default 'Microsoft.Sql/servers/databases/vulnerabilityAssessments@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_AppDatabase
  name: 'Default'
  properties: {
    recurringScans: {
      isEnabled: false
      emailSubscriptionAdmins: true
    }
  }
  dependsOn: [
    servers_sqlserver_3tier_prod_ban_name_resource
  ]
}

resource servers_sqlserver_3tier_prod_ban_name_pe_sqlserver_prod_29585705_316c_4493_88b6_5d48123d8cf1 'Microsoft.Sql/servers/privateEndpointConnections@2026-08-01-preview' = {
  parent: servers_sqlserver_3tier_prod_ban_name_resource
  name: 'pe-sqlserver-prod-29585705-316c-4493-88b6-5d48123d8cf1'
  properties: {
    privateEndpoint: {
      id: privateEndpoints_pe_sqlserver_prod_name_resource.id
    }
    privateLinkServiceConnectionState: {
      status: 'Approved'
      description: 'Auto-approved'
    }
  }
}

resource sites_rg_3tier_capstone_prod_ban123_name_resource 'Microsoft.Web/sites@2024-11-01' = {
  name: sites_rg_3tier_capstone_prod_ban123_name
  location: 'Canada East'
  tags: {
    Costcenter: 'IT-portfolio'
    Environment: 'Production'
    Owner: 'Betty'
    project: 'ThreeTierCapstone'
  }
  kind: 'app,linux'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${sites_rg_3tier_capstone_prod_ban123_name}-bdffg4c3cmfvabcn.canadaeast-01.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${sites_rg_3tier_capstone_prod_ban123_name}-bdffg4c3cmfvabcn.scm.canadaeast-01.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: serverfarms_ASP_rg3tiercapstoneprod_b188_name_resource.id
    reserved: true
    isXenon: false
    hyperV: false
    dnsConfiguration: {}
    outboundVnetRouting: {
      allTraffic: false
      applicationTraffic: true
      contentShareTraffic: false
      imagePullTraffic: false
      backupRestoreTraffic: false
    }
    siteConfig: {
      numberOfWorkers: 1
      linuxFxVersion: 'NODE|22-lts'
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: false
      functionAppScaleLimit: 0
      minimumElasticInstanceCount: 0
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientAffinityProxyEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    ipMode: 'IPv4'
    customDomainVerificationId: 'DC0FFFAB90660C27352FC92E1ADD735A096B0881A452ED14B87F1F24E2232F19'
    containerSize: 0
    dailyMemoryTimeQuota: 0
    httpsOnly: true
    endToEndEncryptionEnabled: false
    redundancyMode: 'None'
    publicNetworkAccess: 'Enabled'
    storageAccountRequired: false
    virtualNetworkSubnetId: virtualNetworks_vnet_webapp_centraleast_name_snet_webapp_ce.id
    keyVaultReferenceIdentity: 'SystemAssigned'
    autoGeneratedDomainNameLabelScope: 'TenantReuse'
  }
}

resource sites_rg_3tier_capstone_prod_ban123_name_2de1e9b1_289a_4798_b0f3_8e4dcaf2b1ca_snet_webapp_ce 'Microsoft.Web/sites/virtualNetworkConnections@2024-11-01' = {
  parent: sites_rg_3tier_capstone_prod_ban123_name_resource
  name: '2de1e9b1-289a-4798-b0f3-8e4dcaf2b1ca_snet-webapp-ce'
  location: 'Canada East'
  properties: {
    vnetResourceId: virtualNetworks_vnet_webapp_centraleast_name_snet_webapp_ce.id
    isSwift: true
  }
}

resource applicationGateways_agw_3tier_prod_name_resource 'Microsoft.Network/applicationGateways@2025-09-01' = {
  name: applicationGateways_agw_3tier_prod_name
  location: 'canadacentral'
  tags: {
    Costcenter: 'IT-portfolio'
    Environment: 'Production'
    Owner: 'Betty'
    project: 'ThreeTierCapstone'
  }
  zones: [
    '1'
    '2'
    '3'
  ]
  properties: {
    sku: {
      name: 'WAF_v2'
      tier: 'WAF_v2'
      family: 'Generation_2'
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        id: '${applicationGateways_agw_3tier_prod_name_resource.id}/gatewayIPConfigurations/appGatewayIpConfig'
        properties: {
          subnet: {
            id: virtualNetworks_Vnet_3tier_prod_name_subnet_appgw.id
          }
        }
      }
    ]
    sslCertificates: []
    trustedRootCertificates: []
    trustedClientCertificates: []
    sslProfiles: []
    frontendIPConfigurations: [
      {
        name: 'appGwPublicFrontendIpIPv4'
        id: '${applicationGateways_agw_3tier_prod_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIpIPv4'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_pip_agw_3tier_prod_name_resource.id
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'port_80'
        id: '${applicationGateways_agw_3tier_prod_name_resource.id}/frontendPorts/port_80'
        properties: {
          port: 80
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'backend-pool-webapp'
        id: '${applicationGateways_agw_3tier_prod_name_resource.id}/backendAddressPools/backend-pool-webapp'
        properties: {
          backendAddresses: [
            {
              fqdn: 'rg-3tier-capstone-prod-ban123-bdffg4c3cmfvabcn.canadaeast-01.azurewebsites.net'
            }
          ]
        }
      }
    ]
    loadDistributionPolicies: []
    backendHttpSettingsCollection: [
      {
        name: 'setting-webapp-http'
        id: '${applicationGateways_agw_3tier_prod_name_resource.id}/backendHttpSettingsCollection/setting-webapp-http'
        properties: {
          port: 443
          protocol: 'Https'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: true
          dedicatedBackendConnection: false
          validateCertChainAndExpiry: true
          validateSNI: true
          requestTimeout: 20
        }
      }
    ]
    backendSettingsCollection: []
    httpListeners: [
      {
        name: 'listener-http'
        id: '${applicationGateways_agw_3tier_prod_name_resource.id}/httpListeners/listener-http'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGateways_agw_3tier_prod_name_resource.id}/frontendIPConfigurations/appGwPublicFrontendIpIPv4'
          }
          frontendPort: {
            id: '${applicationGateways_agw_3tier_prod_name_resource.id}/frontendPorts/port_80'
          }
          protocol: 'Http'
          hostNames: []
          requireServerNameIndication: false
          customErrorConfigurations: []
        }
      }
    ]
    listeners: []
    urlPathMaps: []
    requestRoutingRules: [
      {
        name: 'rule-web-http'
        id: '${applicationGateways_agw_3tier_prod_name_resource.id}/requestRoutingRules/rule-web-http'
        properties: {
          ruleType: 'Basic'
          priority: 100
          httpListener: {
            id: '${applicationGateways_agw_3tier_prod_name_resource.id}/httpListeners/listener-http'
          }
          backendAddressPool: {
            id: '${applicationGateways_agw_3tier_prod_name_resource.id}/backendAddressPools/backend-pool-webapp'
          }
          backendHttpSettings: {
            id: '${applicationGateways_agw_3tier_prod_name_resource.id}/backendHttpSettingsCollection/setting-webapp-http'
          }
        }
      }
    ]
    routingRules: []
    probes: []
    rewriteRuleSets: []
    redirectConfigurations: []
    privateLinkConfigurations: []
    entraJWTValidationConfigs: []
    enableHttp2: true
    enableFips: false
    autoscaleConfiguration: {
      minCapacity: 0
      maxCapacity: 2
    }
    firewallPolicy: {
      id: ApplicationGatewayWebApplicationFirewallPolicies_waf_policy_3tier_prod_name_resource.id
    }
  }
}

resource virtualNetworks_Vnet_3tier_prod_name_subnet_appgw 'Microsoft.Network/virtualNetworks/subnets@2025-09-01' = {
  name: '${virtualNetworks_Vnet_3tier_prod_name}/subnet-appgw'
  properties: {
    addressPrefixes: [
      '10.0.1.0/24'
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_nsg_appgw_name_resource.id
    }
    applicationGatewayIPConfigurations: [
      {
        id: '${applicationGateways_agw_3tier_prod_name_resource.id}/gatewayIPConfigurations/appGatewayIpConfig'
      }
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_Vnet_3tier_prod_name_resource
  ]
}

resource virtualNetworks_Vnet_3tier_prod_name_resource 'Microsoft.Network/virtualNetworks@2025-09-01' = {
  name: virtualNetworks_Vnet_3tier_prod_name
  location: 'canadacentral'
  tags: {
    Costcenter: 'IT-portfolio'
    Environment: 'Production'
    Owner: 'Betty'
    project: 'ThreeTierCapstone'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'subnet-appgw'
        id: virtualNetworks_Vnet_3tier_prod_name_subnet_appgw.id
        properties: {
          addressPrefixes: [
            '10.0.1.0/24'
          ]
          networkSecurityGroup: {
            id: networkSecurityGroups_nsg_appgw_name_resource.id
          }
          applicationGatewayIPConfigurations: [
            {
              id: '${applicationGateways_agw_3tier_prod_name_resource.id}/gatewayIPConfigurations/appGatewayIpConfig'
            }
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
      }
      {
        name: 'snet-webapp'
        id: virtualNetworks_Vnet_3tier_prod_name_snet_webapp.id
        properties: {
          addressPrefixes: [
            '10.0.2.0/24'
          ]
          networkSecurityGroup: {
            id: networkSecurityGroups_nsp_webapp_name_resource.id
          }
          delegations: [
            {
              name: 'Microsoft.Web/serverFarms'
              id: '${virtualNetworks_Vnet_3tier_prod_name_snet_webapp.id}/delegations/Microsoft.Web/serverFarms'
              properties: {
                serviceName: 'Microsoft.Web/serverFarms'
              }
              type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
            }
          ]
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
      }
      {
        name: 'snet-data'
        id: virtualNetworks_Vnet_3tier_prod_name_snet_data.id
        properties: {
          addressPrefixes: [
            '10.0.3.0/24'
          ]
          networkSecurityGroup: {
            id: networkSecurityGroups_nsg_data_name_resource.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
      }
    ]
    virtualNetworkPeerings: [
      {
        name: 'peer-cc-ce'
        id: virtualNetworks_Vnet_3tier_prod_name_peer_cc_ce.id
        properties: {
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteVirtualNetwork: {
            id: virtualNetworks_vnet_webapp_centraleast_name_resource.id
          }
          allowVirtualNetworkAccess: true
          allowForwardedTraffic: false
          allowGatewayTransit: false
          useRemoteGateways: false
          doNotVerifyRemoteGateways: false
          peerCompleteVnets: true
          enableOnlyIPv6Peering: false
          remoteAddressSpace: {
            addressPrefixes: [
              '10.1.0.0/16'
            ]
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '10.1.0.0/16'
            ]
          }
        }
      }
    ]
    enableDdosProtection: false
  }
}
