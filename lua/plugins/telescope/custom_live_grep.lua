local builtin = require("telescope.builtin")

return function()
  vim.ui.input({
    prompt = "Search dirs: ",
    default = nil,
    completion = "dir",
  }, function(search_dirs_str)
    if search_dirs_str == nil then
      return
    end
    local search_dirs = nil
    if search_dirs_str ~= nil and search_dirs_str ~= "" then
      search_dirs = vim.tbl_map(function(dir)
        return vim.trim(dir)
      end, vim.split(search_dirs_str, ","))
    end
    vim.ui.input({
      prompt = "Glob pattern: ",
      default = nil,
      completion = "file",
    }, function(glob_pattern)
      if glob_pattern == nil then
        return
      end
      builtin.live_grep({
        search_dirs = search_dirs,
        glob_pattern = glob_pattern ~= nil and glob_pattern ~= "" and glob_pattern or nil,
      })
    end)
  end)
end
