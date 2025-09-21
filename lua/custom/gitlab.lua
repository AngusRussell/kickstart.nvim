-- ~/.config/nvim/lua/custom/gitlab.lua

local function get_gitlab_token()
  -- Replace `vault-name` and `GitLab Token` with your 1Password vault and item name
  local command = "op read 'op://Personal/GitLab Token/token'"
  local handle = io.popen(command)
  if not handle then
    error 'Failed to retrieve GitLab token from 1Password'
  end
  local token = handle:read('*a'):gsub('%s+', '') -- Remove any trailing whitespace
  handle:close()
  return token
end

require('gitlab').setup {
  auth_provider = function()
    local token = get_gitlab_token()
    return token, 'https://git.cs.qm/', nil
  end,
}
