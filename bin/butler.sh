#!/usr/bin/env bash
###############################################################################
set -e
###############################################################################
# Environment values should have been injected by .envrc
###############################################################################
ID=$(uuidgen)
SHELLRC_FILE=${SHELLRC_FILE:-$HOME/.zshrc}
LOG_FILE="${LOG_FILE:-$HOME/.butler.log}"
LOG=${LOG:-true}
####################################################################################################
usage () {
    printf "\nUsage: butler <command>\n"
    printf "I am your loyal butler sir, currently I know what to do when you call the following commands.\n"
    printf "\n\taws_ecr_login:\tLogin to AWS ECR container registry using credentials from environment variables\n"
    printf "\n\ttf_check:\tExecute commands:\n\n\t\t\t\t - terraform plan\n\t\t\t\t - terraform validate\n"
    printf "\n"
}
logger () {
    if [ "$LOG" = true ]; then
    input=$1
        echo "$(date +%Y-%m-%dT%H:%M:%S%z) ${input}" >> "$LOG_FILE"
    fi
}
aws_ecr_login () {
    echo "Logging into ECR..."
    aws ecr get-login-password | "${CONTAINER_RUNTIME}" login --username AWS --password-stdin "${CONTAINER_REGISTERY}"
} 2>&1
tf_check () {
    terraform validate
    terraform plan
} 2>&1
tf_ro () {
    terraform refresh && terraform output
}
tf_o () {
    terraform output
}
tf_a () {
    terraform apply
}
tf_d () {
    terraform destroy
}
tf_apply () {
    terraform apply # -auto-approve
}

test.test1 () {
    echo "echo: test.test1"
}
install_butler_aliases () {
    cp "$SHELLRC_FILE" "$SHELLRC_FILE.bak"
    { 
        echo 'alias b="butler"'
        echo 'alias aws_ecr_login="b aws_ecr_login"'
        echo 'alias tf_check="b tf_check"'
        echo 'alias tf_apply="b tf_apply"'
    } >> "$SHELLRC_FILE"
    # shellcheck disable=SC1090
    source "$SHELLRC_FILE"
} 2>&1
####################################################################################################
main () {
    SUBCOMMAND="$1"
    case "$SUBCOMMAND" in
        "aws_ecr_login")
            aws_ecr_login
            ;;
        "tf_check")
            tf_check # terraform_check
            ;;
        "tf_ro")
            tf_ro # terraform_refresh_output
            ;;
        "tf_o")
            tf_o # terraform_output
            ;;
        "tf_apply"|"tf_apply_auto"|"tf_a"|"tf_a_auto")
            tf_a # terraform_output
            ;;
        "install_butler_aliases")
            install_butler_aliases
            ;;
        ""|"help"|"-h"|"--help"|.*)
            usage
            echo "Here is a bonus directory listing..."
            ls -alh
            printf "\n"
            test.test1
            ;;
    esac
}
####################################################################################################
main "$@"
