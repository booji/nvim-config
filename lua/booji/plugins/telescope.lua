return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')
    
    -- Setup telescope
    telescope.setup({
      defaults = {
        file_ignore_patterns = { "node_modules", ".git/" },
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    })

    -- Load fzf extension if available
    pcall(telescope.load_extension, 'fzf')

    -- Key mappings
    vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Find files' })
    vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Git files' })
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end, { desc = 'Grep search' })
    vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = 'Help tags' })
  end,
}
