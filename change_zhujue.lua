--nino: 小二的不负责任主角更换事件
OEVENTLUA[30016] = function() --换人物
	zjini()
	SetS(103, 0, 0, 1, 0)
	All_team(1, 191) --可以在这里添加人物，最好是10的倍数不然可能翻页时会跳出
	All_team(581, 581)
	All_team(589, 596)
	say("我其实真的只是一个小二。客官您到底要我做啥啊？",220,0,"神秘小二") 	
	instruct_0()
	say("嗯？你想换人玩？这么穿越的事情你竟然来找一个小二来商量？",220,0,"神秘小二") 
	instruct_0()
	say("好吧好吧，看在你这么有诚心一直按空格键的份上，我就帮帮你吧。",220,0,"神秘小二") 
	instruct_0()
	say("本来是要收点小费的，测试期间就算你免费吧。",220,0,"神秘小二") 
	instruct_0()	
	say("先说好哦，我可不保证这游戏可以正常进行下去......",220,0,"神秘小二")	
	if DrawStrBoxYesNo(-1, -1, "要换人玩吗？", C_WHITE, 30) == true then	
		instruct_0()
		DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "要换成谁？", C_WHITE, CC.DefaultFont)
		local nexty = CC.MainSubMenuY + CC.SingleLineHeight
		local r = My_Select(CC.menu, CC.i - 1, 10)
		local pid
		if r <= 0 then
			instruct_0()
			say("放弃了吗？好吧，我也省心点。请继续走下去吧。",220,0,"神秘小二")				
			do return; end
		end
		pid = CC.menu[r][4]
		
		if pid == GetS(103, 0, 0, 1) then
			instruct_0()
			say("你不是已经在用这个人物了吗？重新选过吧。",220,0,"神秘小二")				
			do return; end		
		end				
		if duiyou(pid) then --如果是队友
			if inteam(pid) then --如果在队伍里则移位
				local position = -1
				for i = 1, CC.TeamNum do
					if JY.Base["队伍"..i] == pid then
						position = i
						break
					end
				end
				local current = 1
				for i = 1, CC.TeamNum do
					if JY.Base["队伍"..i] > 0 then
						current = current + 1
					end
				end
				for i = position + 1, CC.TeamNum do
					if JY.Base["队伍"..i] > 0 then
						JY.Base["队伍"..i - 1] = JY.Base["队伍"..i]
					end
				end
				JY.Base["队伍"..current] = -1
				JY.Base["队伍1"] = pid			
			else --不在队伍里面直接修改
				JY.Base["队伍1"] = pid	
			end
		else --如果不是队友		
			for i = 1, #PSX do
				SetS(103, i, 0, 0, JY.Person[pid][PSX[i]]) --纪录原始数据
			end	
			instruct_0()
			say("因为你选择的是初始等级高的非队友人物，所以给你个选择的机会吧。",220,0,"神秘小二")	
			local initialize = 0
			if DrawStrBoxYesNo(-1, -1, "要初始化人物数据吗？", C_WHITE, 30) then
				initialize = 1
			end
			JY.Person[pid]["等级"] = 30 --设置等级生命内力
			JY.Person[pid]["生命"] = 1500
			JY.Person[pid]["生命最大值"] = 1500
			JY.Person[pid]["内力最大值"] = 5000
			JY.Person[pid]["内力"] = 5000
			if initialize == 1 then --数据初始化
				SetS(103, 0, 0, 3, 1)
				JY.Person[pid]["等级"] = 10
				JY.Person[pid]["攻击力"] = 120
				JY.Person[pid]["轻功"] = 120
				JY.Person[pid]["防御力"] = 120
				JY.Person[pid]["生命"] = 1000
				JY.Person[pid]["生命最大值"] = 1000
				JY.Person[pid]["内力最大值"] = 3000
				JY.Person[pid]["内力"] = 3000				
				if JY.Person[pid]["拳掌功夫"] < 40 then
					JY.Person[pid]["拳掌功夫"] = 40
				end
				if JY.Person[pid]["御剑能力"] < 40 then
					JY.Person[pid]["御剑能力"] = 40
				end		
				if JY.Person[pid]["耍刀技巧"] < 40 then
					JY.Person[pid]["耍刀技巧"] = 40
				end			
				if JY.Person[pid]["特殊兵器"] < 40 then
					JY.Person[pid]["特殊兵器"] = 40
				end			
				for i = 1, 10 do
					if JY.Person[pid]["武功"..i] > 0 then
						JY.Person[pid]["武功等级"..i] = 0
					end
				end
			end
			JY.Base["队伍1"] = pid	
			local T = {}
			for a = 1, 1000 do
			  local b = "" .. a
			  T[b] = a
			end
			DrawStrBoxWaitKey("请输入想要的人物资质", C_WHITE, 30)
			JY.Person[pid]["资质"] = -1
			while JY.Person[pid]["资质"] == -1 do
				local r = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
				if T[r] ~= nil and T[r] > -1 and T[r] < 101 then
				  JY.Person[pid]["资质"] = T[r]
				else
					DrawStrBoxWaitKey(CC.EVB125, C_WHITE, 30)
				end
			end			
		end
		SetS(103, 0, 0, 0, 1)
		SetS(103, 0, 0, 1, pid)			
		instruct_0()
		say("主角换成"..JY.Person[pid]["姓名"].."了，想要换回来的就再来找我吧。",220,0,"神秘小二")	
		instruct_3(61,3,-2,-2,30017,-2,-2,-2,-2,-2,-2,-2,-2)	
	else
		instruct_0()
		say("放弃了吗？好吧，我也省心点。请继续走下去吧。",220,0,"神秘小二")	
	end
end

OEVENTLUA[30017] = function() --换回来
	say("啊，客官您这么快就腻了啊？想换回来？",220,0,"神秘小二") 	
	instruct_0()
	say("好吧好吧，虽然我最近很穷，但是就再免费帮你一次吧。",220,0,"神秘小二") 
	instruct_0()
	say("但是我还是不保证会不会有后遗症哦。",220,0,"神秘小二")	
	if DrawStrBoxYesNo(-1, -1, "要换回来吗？", C_WHITE, 30) == true then	
		local pid = GetS(103, 0, 0, 1)
		if duiyou(pid) then
			instruct_0()
			say("因为我很懒所以就直接调用离队事件了哦。要的话就到小村去找回那位曾经的伪主角队友吧。",220,0,"神秘小二")					
			JY.Base["队伍1"] = 0
			instruct_0()
			for i,v in pairs(CC.PersonExit) do
				if GetS(103, 0, 0, 1) == v[1] then
					if OEVENTLUA[v[2]] ~= nil then
						OEVENTLUA[v[2]]()
					else
						oldCallEvent(v[2])
					end
				end
			end	
		else
			for i = 1, #PSX do --重置npc数据
				JY.Person[pid][PSX[i]] = GetS(103, i, 0, 0)
			end
			JY.Base["队伍1"] = 0	
			instruct_0()
			say("伪主角的数据已经重置了。",220,0,"神秘小二")							
		end

		SetS(103, 0, 0, 0, 0)
		SetS(103, 0, 0, 1, 0)
		SetS(103, 0, 0, 3, 0)
		instruct_0()
		say("好了，请继续以主角光环走下去吧。",220,0,"神秘小二")	
		instruct_3(61,3,-2,-2,30016,-2,-2,-2,-2,-2,-2,-2,-2)	
	else
		instruct_0()
		say("放弃了吗？好吧，我也省心点。请继续走下去吧。",220,0,"神秘小二")	
	end
end

OEVENTLUA[30016] = function() --换人物
	say("我其实真的只是一个小二。客官您到底要我做啥啊？",220,0,"神秘小二") 	
end
