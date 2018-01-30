$VerbosePreference = "Continue" 
 
#Clear and prepare SelectedUsers array 
$Selectedpolicies = @() 
#Clear and prepare SelectedUsers array 
$Selectedsubscriptions = @() 
 
# Login-AzureRmAccount
        $SelectedSubscriptions = Get-AzureRmSubscription | Select Name, Id | Out-GridView -Title "Select Subscriptions (Ctrl/Shift click for multiples)" -PassThru  
		$polname = 
		$poldef =
		$displayname =
		$SubscriptionId=
		$Policies = @() 
        $Policies = Get-AzureRmPolicydefinition  | select name -ExpandProperty Properties | Sort-Object -Property @{Expression = {$_.IsCustom}; Ascending = $false}, Name | Out-GridView -title "Select Policies  (Ctrl/Shift click for multiples)" -PassThru 
        Select-AzureRmSubscription -SubscriptionId $SelectedSubscriptions[0].Id
 
        foreach ($Sub in $SelectedSubscriptions) { 
            foreach ($Policy in $Policies) { 
				$subscriptionPath = "/subscriptions/" + $Sub.Id
				$polname = $Policy.Name	
				$poldef =  "/providers/Microsoft.Authorization/policyDefinitions/$Polname"
				$displayname = $policy.displayName
				$definition = Get-AzureRmPolicyDefinition -Id /providers/Microsoft.Authorization/policyDefinitions/$polname
				New-AzureRMPolicyAssignment -Name $displayname.subString(0, [System.Math]::Min(64, $displayname.Length)) -Scope $subscriptionPath -PolicyDefinition $definition -DisplayName $displayname.subString(0, [System.Math]::Min(64, $displayname.Length))}
			}
 