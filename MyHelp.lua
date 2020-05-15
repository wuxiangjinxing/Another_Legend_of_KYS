-- 本文件为自己开发的一些DIY功能

help			= {}
help.dsl	= {}
--xml				= require("script.help.xmlSimple").newParser()
json			= require("script.help.json")
require("script.help.string")
require("script.help.util")
require("script.help.file")
--require("script.help.dsl.wugong")
--require("script.help.dsl.person")
require("script.help.data")
require("script.help.playersetting")
--require("script.help.display")
--require("script.help.display.statusbar")

--logic						= {}
--logic.war					= {}
--logic.war.effect			= {}
--logic.war.effect.general	= {}
--require("script.logic.war.procedure")
--require("script.logic.war.effect.general.func")

--[[
for k,v in pairs(help) do
	help.util.debug("[MyHelp] help["..tostring(k).."]=["..tostring(v).."] [type="..type(v).."]")
	if v ~= nil and type(v) == "table" then
		for kk,vv in pairs(v) do
			help.util.debug("[MyHelp] help["..k.."]["..tostring(kk).."]=["..tostring(vv).."] [type="..type(vv).."]")
		end
	end
end
]]--