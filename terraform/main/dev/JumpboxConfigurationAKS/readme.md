## login to the virtual machine

terraform output -raw private_key > web-server-key.pem

# Windows CMD (run as administrator)
icacls "F:\CloudLabs\AWSCloudIntegration\terraform\modules\ec2\web-server-key.pem" /reset
icacls "F:\CloudLabs\AWSCloudIntegration\terraform\modules\ec2\web-server-key.pem" /inheritance:r
icacls "F:\CloudLabs\AWSCloudIntegration\terraform\modules\ec2\web-server-key.pem" /grant:r "%USERNAME%":"(R)"

## SSH to windows vm
ssh -i "F:\CloudLabs\AWSCloudIntegration\terraform\modules\ec2\web-server-key.pem" ec2-user@13.235.254.102