vim.g.startify_custom_header = {
	"   ::::    ::: ::::::::::  ::::::::  :::     ::: ::::::::::: ::::    :::: ",
	"   :+:+:   :+: :+:        :+:    :+: :+:     :+:     :+:     +:+:+: :+:+:+",
	"   :+:+:+  +:+ +:+        +:+    +:+ +:+     +:+     +:+     +:+ +:+:+ +:+",
	"   +#+ +:+ +#+ +#++:++#   +#+    +:+ +#+     +:+     +#+     +#+  +:+  +#+",
	"   +#+  +#+#+# +#+        +#+    +#+  +#+   +#+      +#+     +#+       +#+",
	"   #+#   #+#+# #+#        #+#    #+#   #+#+#+#       #+#     #+#       #+#",
	"   ###    #### ##########  ########      ###     ########### ###       ###",
}

local Plug = vim.fn["plug#"]

vim.call("plug#begin")
Plug("ajmwagar/vim-deus")
Plug("airblade/vim-gitgutter")
Plug("wincent/terminus")
Plug("vim-airline/vim-airline")
Plug("vim-airline/vim-airline-themes")
Plug("zefei/vim-wintabs")
Plug("zefei/vim-wintabs-powerline")
Plug("ryanoasis/vim-devicons")
Plug("mhinz/vim-startify")
Plug("scrooloose/nerdtree")
Plug("neomake/neomake")
Plug("tpope/vim-fugitive")
Plug("dart-lang/dart-vim-plugin")
Plug("sbdchd/neoformat")
Plug("dhruvasagar/vim-table-mode")
vim.call("plug#end")

vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeHijackNetrw = 1
vim.api.nvim_create_autocmd("User", {
	pattern = "StartifyBufferOpened",
	callback = function()
		vim.cmd.NERDTree()
		vim.cmd.wincmd("p")
	end,
})
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		if
			vim.call("winnr", "$") == 1
			and vim.call("exists", "b:NERDTree") == 1
			and vim.api.nvim_eval("b:NERDTree.isTabTree()") == 1
		then
			vim.cmd.quit()
		end
	end,
})

if vim.env["TERM"] ~= "linux" then
	vim.o.termguicolors = true
	vim.cmd.colorscheme("deus")
	vim.g.airline_theme = "deus"
	vim.g.airline_powerline_fonts = 1
end

vim.o.relativenumber = true
vim.o.number = true

vim.fn["neomake#configure#automake"]("nrwi", 500)

vim.keymap.set({ "n", "t", "i" }, "<M-Left>", function()
	vim.cmd.wincmd("h")
end)
vim.keymap.set({ "n", "t", "i" }, "<M-Down>", function()
	vim.cmd.wincmd("j")
end)
vim.keymap.set({ "n", "t", "i" }, "<M-Up>", function()
	vim.cmd.wincmd("k")
end)
vim.keymap.set({ "n", "t", "i" }, "<M-Right>", function()
	vim.cmd.wincmd("l")
end)

vim.keymap.set("n", "<M-s>", function()
	vim.wo.spell = not vim.wo.spell
end)
vim.keymap.set("n", "<M-f>", vim.cmd.Neoformat)
vim.keymap.set("n", "<M-t>", vim.cmd.NERDTreeToggle)
vim.keymap.set("n", "<M-n>", function()
	vim.o.relativenumber = not vim.o.relativenumber
	vim.o.number = not vim.o.number
end)

vim.keymap.set("n", "<C-M-Left>", vim.cmd.tabprevious)
vim.keymap.set("n", "<C-M-Right>", vim.cmd.tabnext)
vim.keymap.set("n", "<M-Left>", vim.cmd.bp)
vim.keymap.set("n", "<M-Right>", vim.cmd.bn)

vim.opt.clipboard:append("unnamedplus")
vim.o.colorcolumn = "+0"
vim.o.textwidth = 80
vim.opt.path:append("**")

-- set pylint preferred width
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.o.textwidth = 100
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rst",
	callback = function()
		vim.o.tabstop = 3
		vim.o.shiftwidth = 3
		vim.o.expandtab = true
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "dart",
	callback = function()
		vim.o.tabstop = 2
		vim.o.shiftwidth = 2
		vim.o.expandtab = true
	end,
})
