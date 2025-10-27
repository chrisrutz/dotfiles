SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_DEFAULT_PREFIX="| "

SPACESHIP_PROMPT_ASYNC=true
SPACESHIP_PROMPT_ORDER=(
  time user host dir git
  ruby rails
  python golang
  node package
  line_sep jobs sudo char
)
SPACESHIP_RPROMPT_ORDER=()

SPACESHIP_GIT_COMMIT_SHOW=true
SPACESHIP_GIT_BRANCH_ASYNC=true

# ----------------------------
# Custom 'rails' section
# ----------------------------
# Config knobs (follow Spaceship's option naming)
SPACESHIP_RAILS_SHOW="${SPACESHIP_RAILS_SHOW=true}"
SPACESHIP_RAILS_ASYNC="${SPACESHIP_RAILS_ASYNC=true}"
SPACESHIP_RAILS_PREFIX="${SPACESHIP_RAILS_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_RAILS_SUFFIX="${SPACESHIP_RAILS_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_RAILS_SYMBOL="${SPACESHIP_RAILS_SYMBOL="⚙ "}"
SPACESHIP_RAILS_COLOR="${SPACESHIP_RAILS_COLOR="blue"}"

# The section function name must start with `spaceship_`
spaceship_rails() {
  [[ $SPACESHIP_RAILS_SHOW == false ]] && return
  # Only inside a Rails app (Gemfile.lock present)
  [[ -f Gemfile.lock ]] || return

  # Extract Rails version quickly (no subprocess like `rails -v`)
  local v
  v=$(awk '/^    rails \(/ { gsub(/[()]/,"",$2); print $2; exit }' Gemfile.lock 2>/dev/null)
  [[ -n "$v" ]] || return

  local env=""
  [[ -n "$RAILS_ENV" ]] && env=" @$RAILS_ENV"

  spaceship::section \
    --color "$SPACESHIP_RAILS_COLOR" \
    --prefix "$SPACESHIP_RAILS_PREFIX" \
    --suffix "$SPACESHIP_RAILS_SUFFIX" \
    --symbol "$SPACESHIP_RAILS_SYMBOL" \
    "rails ${v}${env}"
}
