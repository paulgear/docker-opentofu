source /etc/profile
source /root/.aws-ps1.sh
source /root/.aws-reauth.sh
source /root/.terraform-ps1.sh

#Shell Command Completion
complete -C '/usr/bin/aws_completer' aws

#AWS Reauth Function
function reauth () {
    eval $(_aws_reauth)
}

#Prompt
PS1='$(_aws_token_prompt)$(_terraform_prompt)\n\001\033[01;34m\002\w\001\033[00m\002\$ '

#Aliases
