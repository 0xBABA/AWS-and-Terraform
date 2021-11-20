# Home work #4 notes

Since I am not happy with this submission, but submitting it due to time constraints. I am adding this readme which should help any one reviewing this, including me, to understand what went well and what went wrong.

-----------------------

This directory (`Homework4/`) includes a configuration that manages the terrafom cloud resources. 

The AWS resources are managed from the `Homework3/` directory. 

### Here's a checklist of what I managed to achieve:

✅ Create an organization in terraform cloud
</br> -> Organization was created manualy in TFC UI since i had issues reapplying the plan when it was included in the configuration. I am not sure why, but i think it was token related.

✅ Create a workspace in terraform cloud 
</br> -> created 3 workspaces (network, servers, dbs). 

✅ Define the variables in your workspace
</br> -> I tried (very hard) to refrain from coding AWS secrets in this sulution - but didn't succeed (see secrets.auto.tfvars.example). I tried creating IAM users per workspace and the plan was to grab their access keys programmatically - but once that worked (and it did), consecutive applies failed. This might have been better done with a module. Gai found a resource online claiming to use assumeRole for the workspaces - but I couldn't understand how that's done. slack channel also didn't prove very helpful with this. 

✅ Migrate your state to terraform cloud
</br> -> done. no issues there.

✅ Connect your terraform Github repository to terraform cloud and enable auto apply
</br> -> done.

✅ Use modules from private terraform registry instead of local folders/git
</br> -> Due to time limitations i only exported the vpc module to a seperate repo and the private registry. I can (and should) do the same for the instances module, the reason I skipped this is because i am having second thought from the last HW about this module. so i decided to skip that for now. 

✅ Use noticiations to send alerts and updates to slack (use channel #_notifications)
</br> -> done (`tfe/workspace-notifications.tf`). 

Optional: Make your IaC more robust
✅ Seperate your terraform into 2 workspaces - Network and Servers
</br> -> done. I actually have 3: network, servers (nginx servers) and dbs.

✅ Configure run triggers to execute the Servers workspace automaticaly after a succesfull apply in the Network workspace
</br> -> done (tfe/workspace-triggers.tf)

✅ Configure state sharing with specific workspaces
</br> -> done. 

---------------

## Summary of improvements to be done:
* restructure the way workspaces are provisioned, perhaps using a module, so things will be more concise.
* find a better way to grant permissions to workspaces to provision AWS infrastructure. 
* use remote_state_sharing data source and not the way i have it now.
* fix the app configuration (nginx servers) to use a module from private registry or restrcuture the instance provisioining block.
 