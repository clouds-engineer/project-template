#!/usr/bin/env bash
####################################################################################################
usage () {
    echo "Usage: $0 <subcommand>"
    echo "Available subcommands:"
    echo "  aws_ecr_login"
}
aws_ecr_login () {
    echo "Logging into ECR..."
    aws ecr get-login-password | ${CONTAINER_RUNTIME} login \
                                                                --username AWS \
                                                                --password-stdin "${CONTAINER_REGISTERY}"
}
###############################################################################
main () {
    SUBCOMMAND="$1"
    case "$SUBCOMMAND" in
        "aws_ecr_login")
            aws_ecr_login
            ;;
        .+)
            usage
            ;;
    esac
}
####################################################################################################
main "$@"
