
local FlyB = LibStub("AceAddon-3.0"):GetAddon("FlyB")

local options, configOptions = nil, {}
--[[ This options table is used in the GUI config. ]]-- 
local function getOptions() 
	if not options then
		options = {
		    type = "group",
			name ="FlyB",			
		    args = {
				general = {
					order = 1,
					type = "group",
					name = "General",
					args = {
						settings = {
							order = 1,
							type = "group",
							inline = true,
							name = "Settings",
							get = function(info)
								local key = info.arg or info[#info]
								return FlyB.db.profile.settings[key]
							end,
							set = function(info, value)
								local key = info.arg or info[#info]
								FlyB.db.profile.settings[key] = value
							end,
							args = {
								enabledesc = {
									order = 1,
									type = "description",
									fontSize = "medium",
									name = "Enable/Disable FlyB"
								},
								enable = {
									order = 2,
									type = "toggle",
									name = "Enable"
						        },
							}
						},
						announceIn = {
							order = 3,
							type = "group",
							inline = true,
							name = "Channels to make the annoucement (Pick one):",
							get = function(info)
								local key = info.arg or info[#info]
								return FlyB.db.profile.announceIn[key]
							end,
							set = function(info, value)
								local key = info.arg or info[#info]
								FlyB.db.profile.announceIn[key] = value
							end,
							args = {
								say = {
									order = 1,
									type = "toggle",
									name = "Say"
								},
								party = {
									order = 2,
									type = "toggle",
									name = "Party"
								},
								instance = {
									order = 3,
									type = "toggle",
									name = "Instance"						
								},								
								guild = {
									order = 4,
									type = "toggle",
									name = "Guild",					
								},
								officer = {
									order = 5,
									type = "toggle",
									name = "Officer",
								},
								whisper = {
									order = 6,
									type = "toggle",
									name = "Whisper",
									width = 'half',
								},
								whisperWho = {
									order = 7,
									type = "input",
									width = 'half',
									name = "Whisper Who",
								}																
							}
						}
					}
				}
		    }
		}
		for k,v in pairs(configOptions) do
			options.args[k] = (type(v) == "function") and v() or v
		end
	end
	
	return options
end

local function openConfig() 
	InterfaceOptionsFrame_OpenToCategory(FlyB.optionsFrames.Profiles)
	InterfaceOptionsFrame_OpenToCategory(FlyB.optionsFrames.FlyB)
	InterfaceOptionsFrame:Raise()
end

function FlyB:SetupOptions()
	self.optionsFrames = {}

	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("FlyB", getOptions)
	self.optionsFrames.FlyB = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("FlyB", nil, nil, "general")

	configOptions["Profiles"] = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)

	self.optionsFrames["Profiles"] = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("FlyB", "Profiles", "FlyB", "Profiles")

	LibStub("AceConsole-3.0"):RegisterChatCommand("flyb", openConfig)
end
