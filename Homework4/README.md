# Home work #4 notes

This directory (`Homework4/`) includes a configuration that manages the terrafom cloud resources. 

The AWS resources are managed from the `Homework3/` directory. 

-----------

✅ Create an organization in terraform cloud
</br> -> Organization was created manualy in TFC UI since I had issues reapplying the plan when it was included in the configuration. I am not sure why, but i think it was token related (I also tried to move this configuration to TFC so maybe that was the culprit).

✅ Create a workspace in terraform cloud 
</br> -> created 3 workspaces (network, servers, dbs). network includes all vpc related resources and is utilizing the vpc module hosted in a proivate registry on TFC, servers include the ngingx instances, their related resources and ALB. 

✅ Define the variables in your workspace
</br> -> To be honest I am still not sure what this instruction means. I assumed this is referring to the ENV vars required for AWS resource management. 
I tried (very hard) to refrain from coding AWS secrets in this sulution - but didn't succeed (see secrets.auto.tfvars.example). I tried creating IAM users per workspace and the plan was to grab their access keys programmatically - but once that worked (and it did), consecutive applies failed. Gai found a resource online claiming to use assumeRole for the workspaces - but I couldn't understand how that's done. slack channel also didn't prove very helpful with this.
</br> eventually what I did was create two users in AWS, one to control network resources, and the other controls EC2 resources. I used the keys of these users in my secret.auto.tfvars file to allow TFC to provision resources on AWS.  

✅ Migrate your state to terraform cloud
</br> -> done. no issues there.

✅ Connect your terraform Github repository to terraform cloud and enable auto apply
</br> -> done.

✅ Use modules from private terraform registry instead of local folders/git
</br> -> I only exported the vpc module to a seperate repo and for the private registry. I can (and should) do the same for the instances module, the reason I skipped this is because I am having second thought from the last HW about this module. so I decided to skip that for now. 

✅ Use noticiations to send alerts and updates to slack (use channel #_notifications)
</br> -> done (`tfe/workspace-notifications.tf`). 

Optional: Make your IaC more robust
✅ Seperate your terraform into 2 workspaces - Network and Servers
</br> -> done. I actually have 3: network, servers and dbs.

✅ Configure run triggers to execute the Servers workspace automaticaly after a succesfull apply in the Network workspace
</br> -> done (tfe/workspace-triggers.tf)

✅ Configure state sharing with specific workspaces
</br> -> done. (tfe/ws_network.tf)

---------------

## Required improvements:
* restructure the way workspaces are provisioned, perhaps using a module, so things will be more concise.
* find a better way to grant permissions to workspaces to provision AWS infrastructure. (further research the assumeRole method mentioned above)
* fix the app configuration (nginx servers) to use a module from private registry or restructure the instance provisioining block.
 