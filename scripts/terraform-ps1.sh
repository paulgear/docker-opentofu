function _terraform_prompt () {
    CYAN=$'\033[0;36m'
    RESET=$'\033[0m'
    OPEN_ESC=$'\001'
    CLOSE_ESC=$'\002'

    if [ -d .terraform ]; then
        WORKSPACE="$(command terraform workspace show 2>/dev/null)"
        echo "[${OPEN_ESC}${CYAN}${CLOSE_ESC} ${WORKSPACE} ${OPEN_ESC}${RESET}${CLOSE_ESC}]"
    fi
}
