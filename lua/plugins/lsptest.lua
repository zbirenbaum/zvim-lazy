local util = require("copilot.util")

vim.lsp.start_client({
  cmd = { '/home/zach/Dev/RADEV/start.sh'},
  root_dir = vim.loop.cwd(),
  name = "radev",
  get_language_id = function(_, filetype)
    return util.language_for_file_type(filetype)
  end,
  on_init = function(client, initialize_result)
    if M.id == client.id then
      M.capabilities = initialize_result.capabilities
    end
  end,
})

