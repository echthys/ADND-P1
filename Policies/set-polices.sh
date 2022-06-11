# Resource Group Policy 

az policy definition create --name 'resource-group-tagging-policy' --display-name 'resource-group-tagging-policy' --description 'Stop resource groups being created without tags' --params ResourceGroupTaggingPolicyParams.json --rules ResourceGroupTaggingPolicy.json
az policy assignment create --name resource-group-tagging-policy --policy resource-group-tagging-policy --params ResourceTaggingPolicyAssigmentParams.json

## All Other Resource Policy

az policy definition create --name 'tagging-policy' --display-name 'tagging-policy' --description 'Stop resources being created without tags' --rules ResourceTaggingPolicy.json
az policy assignment create --name tagging-policy --policy tagging-policy
