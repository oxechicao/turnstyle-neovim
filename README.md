<p align="center">
    <img src="https://raw.githubusercontent.com/oxechicao/turnstyle/refs/heads/main/turnstyle.png" width="89" />
    <h2 align="center">Turnstyle for Neovim</h2>
</p>

This project would never exists without rose-pine theme.
It was started as a fork of [rose-pine/neovim](https://github.com/rose-pine/neovim).
I customized it based on [Vscode Turnstyle theme](https://github.com/oxechicao/turnstyle) that I created.

## How to use it

### [lazy.nvim](https://lazy.folke.io/installation)

**Structured Setup**

```lua
-- lua/plugins/turnstyle.lua
return {
	"oxechicao/turnstyle-neovim",
	name = "turnstyle",
	config = function()
		vim.cmd("colorscheme turnstyle")
	end
}
```

**Single file**

```lua
{ "oxechicao/turnstyle-neovim", name = "turnstyle" }
```
