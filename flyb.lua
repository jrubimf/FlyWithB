
local FlyB = LibStub("AceAddon-3.0"):NewAddon("FlyB", "AceEvent-3.0", "AceConsole-3.0")

--[[ The defaults a user without a profile will get. ]]--
local defaults = {
	profile={
		settings = {
			enable = true,
		},
		announceIn = {
			say = false,
			party = true,
			guild = false,
			officer = false,
			whisper = false,
			whisperWho = nil
		}
	}
}

--[[ FlyB Initialize ]]--
function FlyB:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("FlyBDB", defaults, true)
	
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileReset")
	self.db.RegisterCallback(self, "OnNewProfile", "OnNewProfile")
	
	self:SetupOptions()
end

function FlyB:OnEnable()
	print("|cffc41f3bFly Buu|r: |cffffff00/flyb|r for GUI menu")
	self:RegisterEvent("QUEST_TURNED_IN")
    self:RegisterEvent("CHAT_MSG_PARTY_LEADER")
	self:RegisterEvent("TAXIMAP_OPENED")
end

function FlyB:OnProfileChanged(event, db)
 	self.db.profile = db.profile
end

function FlyB:OnProfileReset(event, db)
	for k, v in pairs(defaults) do
		db.profile[k] = v
	end
	self.db.profile = db.profile
end

function FlyB:OnNewProfile(event, db)
	for k, v in pairs(defaults) do
		db.profile[k] = v
	end
end

local f=CreateFrame("Frame")
local index = GetChannelName("General")
function FlyB:TAXIMAP_OPENED(event, id, msg)
	local settings = FlyB.db.profile.settings
	if (settings.enable) then
		if flyingstring ~= nil and flyingstring~= "" then 
			SendChatMessage("Voando para: " .. rubimgetCont(flyingstring) , "PARTY", nil, 1); 
			flyingstring = rubimgetCont(flyingstring)
			TakeTaxiNode(rubimgetNode(flyingstring))
			rubimcleanVar()
		end
	end
end

function FlyB:QUEST_TURNED_IN(event,id,exper,money)
		local title, factionID, tagID, tagName, worldQuestType, rarity, elite, tradeskillLineIndexprint = RubimGetQuestInfo(id)
--		print(RubimGetQuestInfo(id))
		if UnitInParty("player") == true and title ~= nil then
			SendChatMessage("Completed: " .. title, "PARTY", nil, 1); 
		end
	end
	
	
function FlyBSendMSG(msg)
	local channel = FlyB.db.profile.announceIn	
	if (channel.say) then
		channel = "SAY"
		SendChatMessage(msg, channel, nil, 1); 
	end
	if (channel.party) then
		channel = "PARTY"
		if IsInGroup() then
			SendChatMessage(msg, channel, nil, 1); 
		end
	end
	if (channel.guild) then
		channel = "GUILD"
		if(IsInGuild()) then
			SendChatMessage(msg, channel, nil, 1); 
		end
	end
	if (channel.officer) then
		channel = "OFFICER"
		if(IsInGuild()) then
			SendChatMessage(msg, channel, nil, 1); 
		end
	end
	if (channel.whisper) then
		channel = "WHISPER"
		SendChatMessage(msg, channel.whisperWho, nil, 1); 
	end
end

function FlyB:CHAT_MSG_PARTY_LEADER(event,m,senderfull,t,_,sender,_,num,num2,_,_num3,num4)
	local settings = FlyB.db.profile.settings
	local triggers={"==>"}
	if (settings.enable) then
		    for _,t in ipairs(triggers) do
--
--			print(m)
--            if m:lower():find(t) then

			if m:find("==>") then
			rubimcleanVar()
			flyinglocation = {}
--			print(string.gsub(m, "==> ", ""))
			--estudar mais
			local firstTime = nil
				for strg in gmatch(m, "%S+") do
					if strg ~= "==>" then
						if flyinglocation ~= nil then
							table.insert(flyinglocation, " " .. strg)
						else
							table.insert(flyinglocation, strg)
						end
					end
				end
				if flyinglocation ~= nil then
					for i=-1, #flyinglocation do
						if flyinglocation[i] ~= nil then
							flyingstring = flyingstring .. flyinglocation[i]
						end
					end
					print(flyingstring)
					flyingstring = (flyingstring:match( "^%s*(.+)" ))
					print("|cffFFF569Flypath registrado para:|r |cffFF7D0A" .. rubimgetCont(flyingstring))
					break
				end
            end
		end
	end
end

function FlyB.SendMSG ()



end
		local Highmountain = {
		"Felbane Camp",
		"Ironhorn Enclave",
		"Nesingwary",
		"Obsidian Overlook",
		"Shipwreck Cove",
		"Skyhorn",
		"Stonehoof Watch",
		"Sylvan Falls",
		"The Witchwood",
		"Thunder Totem"
		}
		local Azsuna = {
		"Azurewing Repose",
		"Challiane's Terrace",
		"Eye of Azashara",
		"Felblaze Ingress",
		"Illidari Perch",
		"Illidari Stand",
		"Shackle's Den",
		"Wardens' Redoubt",
		"Watchers' Aerie"
		}			
		local Valsharah = {
		"Bradensbrook",
		"Garden of the Moon",
		"Gloaming Reef",
		"Lorlathil",
		"Starsong Refuge"
		}		
		local Suramar = {
		"Crimson Thicket",
		"Irongrove Retreat",
		"Meredil"
		}		
		local Stormheim = {
		"Cullen's Post",
		"Dreadwake's Landing",
		"Forsaken Foothold",
		"Hafr Fjall",
		"Shield's Rest",
		"Stormtorn Foothills",
		"Valdisdall"
		}

function rubimcleanVar()
			flyingstring = ""
			if flyinglocation ~= nil then
				wipe(flyinglocation)
			end
end

function ltrim(s)
  return (s:gsub("^%s*", ""))
end

function rubimgetCont(name)
		local newname = name
		for i=1, #Highmountain do
			if name == Highmountain[i] then newname = name .. ", Highmountain" end
		end
		
		for i=1, #Azsuna do
			if name == Azsuna[i] then newname = name .. ", Azsuna" end	
		end
		
		for i=1, #Valsharah do
			if name == Valsharah[i] then newname = name .. ", Val'sharah" end
		end
		
		for i=1, #Suramar do
			if name == Suramar[i] then newname = name .. ", Suramar" end
		end
		
		for i=1, #Stormheim do
			if name == Stormheim[i] then newname = name .. ", Stormheim" end
		end
		if newname ~= name then
			return newname
		elseif name == "Dalaran" then
			return name
		else
			rubimcleanVar()
			return "Nenhum lugar pois ele não existe, ai a gente fica tisti."
		end
end

function rubimgetNode(name)		
	for i=1, NumTaxiNodes() do
		if TaxiNodeName(i) == name then
			return i			
		end
	end
end

function RubimGetQuestInfo(questID)
	local tagID, tagName, worldQuestType, rarity, elite, tradeskillLineIndex = GetQuestTagInfo(questID)
	local title, factionID = C_TaskQuest.GetQuestInfoByQuestID (questID)
	return title, factionID, tagID, tagName, worldQuestType, rarity, elite, tradeskillLineIndex
end

--function f:QUEST_TURNED_IN(event, questID, experience, money)
--	local title, factionID, tagID, tagName, worldQuestType, rarity, elite, tradeskillLineIndex = WorldQuestGroupFinder.GetQuestInfo(questID)
		--SendChatMessage("Completou: " .. title .. " - da facção: " .. factionID , "PARTY", nil, 1); 
--end
