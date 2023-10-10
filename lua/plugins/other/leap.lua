local leap = require('leap')
leap.add_default_mappings()
leap.setup({
  highlight_unlabeled_phase_one_targets = false,
})

vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })

vim.api.nvim_set_hl(0, 'LeapMatch', {
  fg = 'grey',
  bold = true,
  nocombine = true,
})


local function highlight_unlabeled_phase_one_targets(targets, first_idx, last_idx)
  local hl = require('leap.highlight')
  for i = first_idx or 1, last_idx or #targets do
    local target = targets[i]
    -- if not target.label and target.chars then
      local bufnr = target.wininfo.bufnr
      local id = vim.api.nvim_buf_set_extmark(
          bufnr, hl.ns, target.pos[1] - 1, target.pos[2] - 1,
          {
            virt_text = { { table.concat(target.chars), "LeapMatch" } },
            virt_text_pos = "overlay",
            hl_mode = "combine",
            priority = hl.priority.label,
          }
      )
      -- This way Leap automatically cleans up your stuff together with its own.
      table.insert(hl.extmarks, { bufnr, id })
    end
  -- end
  -- Continue with Leap's native function body.
  return true
end

leap.opts.on_beacons = highlight_unlabeled_phase_one_targets
