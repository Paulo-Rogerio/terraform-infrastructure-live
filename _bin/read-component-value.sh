#!/usr/bin/env bash
#
# read-component-value.sh
#
##

solve_component_args()
{
    # This is used to get the values from the Terragrunt locals
    component_values="$( awk '/locals[[:space:]]*\{/{flag=1;next}/}/{flag=0}flag' "$1/terragrunt.hcl" )"
}

read_component_value()
{
    value="$( echo "$component_values" | grep -w "$1" | cut -d '=' -f 2 | tr -d ' ' )"

    if [[ -z "$value" ]]; then
        case "$1" in
        "component_create")
            echo "true"
            ;;
        "component_destroy")
            echo "false"
            ;;
        "component_version")
            echo "latest"
            ;;
        *)
            echo ""
            ;;
        esac
        exit 0
    fi

    if [[ -n "$value" ]] ; then
        tr -d '"' <<< "$value"
    fi
}

main()
{
    solve_component_args "$2"
    read_component_value "$1"
}

main "$@"
