local function codeCompanionSetup()
  local default_model = "deepseek/deepseek-chat-v3-0324:free"
  local available_models = {
    "deepseek/deepseek-chat-v3-0324:free",
  }
  local current_model = default_model

  local function select_model()
    vim.ui.select(available_models, {
      prompt = "Select  Model:",
    }, function(choice)
      if choice then
        current_model = choice
        vim.notify("Selected model: " .. current_model)
      end
    end)
  end

  require("codecompanion").setup({
    strategies = {
      chat = {
        adapter = "openrouter",
      },
      inline = {
        adapter = "openrouter",
      },
    },
    adapters = {
      openrouter = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          env = {
            url = "https://openrouter.ai/api",
            api_key = 'cmd: gpg --batch --quiet --decrypt /Users/solarbeam/Workspace/secrets/llm-keys/openrouter.gpg',
            chat_url = "/v1/chat/completions",
          },
          schema = {
            model = {
              default = current_model,
            },
          },
        })
      end,
    },
  })

  vim.keymap.set("n", "<leader>cs", select_model, { desc = "Select Gemini Model" })
  -- Expand 'cc' into 'CodeCompanion' in the command line
  vim.cmd([[cab cc CodeCompanion]])
end

codeCompanionSetup()
