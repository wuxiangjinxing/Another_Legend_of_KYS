if DrawStrBoxYesNo(-1, -1, "要用懒人补丁么？", C_WHITE, 30) == true then
    for i = 1, CC.TeamNum do                 
        local id = JY.Base["队伍" .. i];
		if id >= 0 then
			JY.Person[id]["修炼点数"] = 30000
			War_PersonTrainBook(id)
			JY.Person[id]["经验"] = 52000
			War_AddPersonLVUP(id);		
		end
    end
end