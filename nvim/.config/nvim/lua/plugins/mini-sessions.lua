return {
	"echasnovski/mini.sessions",
	config = true,
	keys = {
		{
			"<space>sd",
			function()
				MiniSessions.select("delete", { force = true })
			end,
		},
		{
			"<space>sl",
			function()
				MiniSessions.select()
			end,
		},
		{
			"<space>sc",
			function()
				vim.ui.input({ prompt = "Session name: " }, function(input)
					if input then
						MiniSessions.write(input)
					end
				end)
			end,
		},
	},
}
