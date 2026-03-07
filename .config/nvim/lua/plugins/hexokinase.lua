return {
  "RRethy/vim-hexokinase",
  ft = { "css", "html", "scss", "less" }, -- Lazy load on specific file types
  build = "make hexokinase", -- Build command required by the plugin
  "vim-hexokinase",
  init = function()
	  vim.g.Hexokinase_optInPatterns = "full_hex,rgb,rgba,hsl,hsla,colour_names"
	  vim.g.Hexokinase_highlighters = 'backgroundfull'
  end,
}
