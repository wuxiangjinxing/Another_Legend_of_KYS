dofile ".\\script\\nino_MP_event.lua"; --nino门派剧情
dofile ".\\script\\nino_quest_event.lua"; --nino奇遇+任务
dofile ".\\script\\tjm_event.lua"; --nino奇遇+任务
--dofile ".\\script\\nino_gambling_event.lua"; --赌博
--dofile ".\\script\\nino_emblem_event.lua"; --勋章
--dofile ".\\script\\change_zhujue.lua"; 
--[[LDCR - 2000-2005
OEVENT - 2006, 8001-8017, 8201-8208, 8301-8306, 8601-8615, 8650-8652
ninoevent - 9999, 10000, 10001-10019, 10020-10024 郭襄支线，20000-20011 离队 5000-5008 新增事件
tjm_event - 5009 -6000
newevent - 1300 and so on
free to use: 3000-4999   ]]
function My_Enter_SubScene2(sceneid,x,y,direct)
	if JY.Status == GAME_SMAP then
	  JY.Base["无用"] = JY.SubScene
	else
	  JY.Base["无用"] = -1
	end
	SBLDATAS(11)
	
	JY.SubScene = sceneid;
	local flag = 1;   --是否自定义的xy坐标, 0是，1否
	if x == -1 and y == -1 then
		JY.Base["人X1"]=JY.Scene[sceneid]["入口X"];
  	JY.Base["人Y1"]=JY.Scene[sceneid]["入口Y"];
  else
  	JY.Base["人X1"] = x;
  	JY.Base["人Y1"] = y;
  	flag = 0;
	end
	
	if direct > -1 then
		JY.Base["人方向"] = direct;
	end
 			
	
	if JY.Status == GAME_MMAP then
		CleanMemory();
		lib.PicInit()--
		lib.UnloadMMap();
	end
  lib.PicInit();
  lib.ShowSlow(20,1)

	JY.Status = GAME_SMAP;  --改变状态
  JY.MmapMusic=-1;

	JY.Base["乘船"]=0;
  JY.MyPic=GetMyPic(); 
  
  --外景入口是个难点，有些子场景是通过跳转的方式进入的，需要判断
  --由于目前最多只能有一个子场景跳转，所以不需要进行循环判断
  local sid = JY.Scene[sceneid]["跳转场景"];
  
  if sid < 0 or (JY.Scene[sid]["外景入口X1"] <= 0 and JY.Scene[sid]["外景入口Y1"] <= 0) then
  	JY.Base["人X"] = JY.Scene[sceneid]["外景入口X1"];  --改变出子场景后的XY坐标
		JY.Base["人Y"] = JY.Scene[sceneid]["外景入口Y1"];
	else
		JY.Base["人X"] = JY.Scene[sid]["外景入口X1"];  --改变出子场景后的XY坐标
		JY.Base["人Y"] = JY.Scene[sid]["外景入口Y1"];
	end


  Init_SMap(flag);  --重新初始化地图
  
  --[[if flag == 0 then    --如果是自定义位置，先传送到那个位置，再显示场景名称
  	DrawStrBox(-1,10,JY.Scene[JY.SubScene]["名称"],C_WHITE,CC.DefaultFont);
		ShowScreen();
		WaitKey();
  end]]
  
  Cls();
	
end
OEVENTLUA[508] = function() --射中一灯居
    say("阿弥陀佛，苦海无边，回头*是岸。",65)
	if GetS(113,0,0,0) == 0 then 
	    say("居士宅心仁厚，这本一阳指法请居士务必收下。",65) 
	    instruct_0();
	    if instruct_11(0,188) == true then 
	        QZXS("领悟一阳指！")
			say("多谢大师！",0)
	        instruct_0();
	        setLW1(17)
			addthing(96,1)
		else
			say("望居士福寿安康。",65) 
		end	
	end
	if MPPD(0) == 0 then 
	say("请大师指点迷津",0)
    say("善哉，善哉，你与我佛有缘，何不入我门下。",65)
	if DrawStrBoxYesNo(-1, -1, "要加入大理段家么？", C_WHITE, 30) == true then 
	say("多谢师父收留。",0)
	say("阿弥陀佛，老衲这有一本段家绝学天南易阳的秘籍，你也拿去看看吧",65)
	instruct_2(289,1) 
	say("多谢师父",0)
	say("善哉善哉",65)
	JoinMP(0, 15, 1)
	if GetS(111, 0, 0, 0) == 0  then
	    say("老衲还有部分心得，是否愿意学学...",65) 
	    instruct_0();
		if instruct_11(0,188) == true then
	        QZXS("领悟易阳真诀！")
	        instruct_0();
	        say("多谢师父。",0) 
	        SetS(111, 0, 0, 0,152)
		 else
			say("我还是算了吧",0) 
		end
    end
	else		
	say("对不起",0)
	say("阿弥陀佛",65)
	if GetS(111, 0, 0, 0) == 0 and PersonKF(zj(),152) then
	    say("老衲观施主已经学习段家天南易阳，也与段家有缘",65) 
		say("老衲也有部分心得，不知施主是否感兴趣",65) 
	    instruct_0();
		if instruct_11(0,188) == true then
	        QZXS("领悟易阳真诀！")
	        instruct_0();
	        say("多谢大师。",0) 
	        SetS(111, 0, 0, 0,152)
		else
			say("我还是算了吧",0) 
		end
    end
	end
    else
	if GetS(111, 0, 0, 0) == 0 and PersonKF(zj(),152) then
	    say("老衲观施主已经学习段家天南易阳，也与段家有缘",65) 
		say("老衲也有部分心得，不知施主是否感兴趣",65) 
	    instruct_0();
		if instruct_11(0,188) == true then
	        QZXS("领悟易阳真诀！")
	        instruct_0();
	        say("多谢大师。",0) 
	        SetS(111, 0, 0, 0,152)
		else
			say("我还是算了吧",0) 
		end
    end
	end
    if inteam(53) then 
	say("誉儿拜见段家高人。",53)
	say("誉儿，多回家陪陪你父王。",65)
	if not JX(53) then
	say("千里迢迢，行走江湖如此艰险，誉儿不知如何回去。",53)
	say("阿弥陀佛，也罢，该给你我们段家天龙血脉的传承了。",65)
	QZXS("段誉领悟八部战意技【龙王·龙形剑气】！")
	setJX(53,1)
	say("誉儿多谢。",53)
	end
	end
JY.Person[60]["声望"] = 104
JY.Person[60]["武功5"] = 104
JY.Person[60]["武功等级5"] = 999
JY.Person[620]["声望"] = 104
JY.Person[620]["武功5"] = 104
JY.Person[620]["武功等级5"] = 999		
end

OEVENTLUA[828] = function()
    say("哪里来的野小子，敢硬闯我*嵩山派！",22)	
	say("嵩山派身为五岳盟主，我以*为武功必是极高的，没想到*，唉，不过如此。",0)
	say("好小子，你够狂，今日就让*你尝尝嵩山剑法的厉害。",22)	
	if instruct_6(38,40,0,0) == false then 
	   instruct_15(0)  
			do return; end
    end
	instruct_0()
	instruct_13();
	instruct_2(128,1) --得到万岳朝宗
	instruct_0()
	say("小子，你功夫不错，我正在*进行一项功在千秋的大事业*，你加入我嵩山派吧。",22)
	if MPPD(0) == 14 and MPDJ(0) == 2 then 
	say("哦，看你的功夫，原来你在岳师弟那入了门啊，哈哈，要不你到我这里来当个太保吧",22) 
	end
    if DrawStrBoxYesNo(-1, -1, "要加入嵩山派的事业么？", C_WHITE, 30) == true then 
	say("左盟主真当人杰也，小子我愿为嵩山派的事业赴汤蹈火",0)
	say("小子还挺识相，不错不错，我这有一本寒冰真气的秘籍，你也拿去看看吧",22)
	instruct_2(261,1) --得到寒冰真气
	say("多谢左盟主。*＜哈哈，随便忽悠一下就能拿到本秘籍，赚了，赚了＞",0)
	say("好好学吧，小子，以后也能为我排忧解难。*＜嘿嘿，又多了个炮灰，不错，不错＞",22)
	JoinMP(0, 14, 3)
	else		
	say("对不起，我没兴趣。*＜你能有什么大事业，南贤*老头都已经说了，我找寻十*四天书才是最大的事业！＞",0)
	end
	if GetS(113, 0, 0, 0) == 0 then
	say("嵩山派也闯过了，看来这五岳剑派和古代的五行相互关联",0)
	say("虽然其他几个门派也许不太清楚，但这五岳的气象也大约一致",0)
	say("也许我可以根据自己的风格选择一种剑法来参悟五行的奥义",0)
				  if DrawStrBoxYesNo(-1, -1, "是否参悟五行剑意？", C_WHITE, 30) ==true  then
				  say("那么选择哪一种呢",0)
				  	local title = "五行剑意抉择";
	                local str = "请选择需要领悟的五行剑意";
	                local btn = {"北水","东木","南火","中土","西金"};
	                local num = #btn;
	                local r = JYMsgBox(title,str,btn,num);
					if r==1 then
	                 QZXS("领悟北堂坎水剑意！")
	                 instruct_0();
	                 setLW1(30)
					elseif r==2 then
			         QZXS("领悟东方青木剑意！")
	                 instruct_0();
	                 setLW1(31)			
					elseif r==3 then
				     QZXS("领悟南宫离火剑意！")
	                 instruct_0();
	                 setLW1(32)		
					elseif r==4 then
					 QZXS("领悟中央磐土剑意！")
	                 instruct_0();
	                 setLW1(33)
					elseif r==5 then
					 QZXS("领悟西门锐金剑意！")
	                 instruct_0();
	                 setLW1(34)
					end
					 say("呼，终于掌握了，不过，这只是个开始",0)
				  else
				     say("算了，我志不在此，不强求这里有所突破吧",0) 
				  end
    end
	instruct_0()
	instruct_3(-2,-2,-2,0,829,0,0,-2,-2,-2,-2,-2,-2);--修改事件定义:当前场景当前场景事件编号
end

OEVENTLUA[829] = function()
    if MPPD(0) == 14 and MPDJ(0) == 3 then 
	say("好好学吧，小子，以后也能为我排忧解难。*＜嘿嘿，又多了个炮灰，不错，不错＞",22)
	else
    say("小子，你功夫不错，我正在*进行一项功在千秋的大事业*，你加入我嵩山派吧。",22)	
	if MPPD(0) == 14 and MPDJ(0) == 2 then 
	say("哦，看你的功夫，原来你在岳师弟那入了门啊，哈哈，要不你到我这里来当个太保吧",22) 
	end
    if DrawStrBoxYesNo(-1, -1, "要加入嵩山派的事业么？", C_WHITE, 30) == true then 
	say("左盟主真当人杰也，小子我愿为嵩山派的事业赴汤蹈火",0)
	say("小子还挺识相，不错不错，我这有一本寒冰真气的秘籍，你也拿去看看吧",22)
	instruct_2(261,1) --得到寒冰真气
	say("多谢左盟主。*＜哈哈，随便忽悠一下就能拿到本秘籍，赚了，赚了＞",0)
	say("好好学吧，小子，以后也能为我排忧解难。*＜嘿嘿，又多了个炮灰，不错，不错＞",22)
	JoinMP(0, 14, 3)
	else		
	say("对不起，我没兴趣。*＜你能有什么大事业，南贤*老头都已经说了，我找寻十*四天书才是最大的事业！＞",0)
	end
	end
end

OEVENTLUA[747] = function()
    say("晚辈拜见君子剑岳先生。",0)	
	say("少侠不必拘礼。珊儿、平之*他们都在外面，可以去和他们聊*聊吧。",19)--岳不群
	say("不过我听说少侠你是南贤的弟子*不知可否加入我们华山派*在江湖中做番事业。",19)
	say("＜据说岳先生在江湖中风评不错*要不要加入呢？＞",0)
	if DrawStrBoxYesNo(-1, -1, "要加入五岳剑派么？", C_WHITE, 30) == true then 
	say("多谢师父，请受弟子一拜",0)
	say("少侠无须多礼，你是南贤的弟子，我不敢夺人之徒，有误礼法",19)
	say("但你既然已经入我华山派的门*我也会多加照顾的。",19)
	say("多谢岳先生的厚爱。*＜太好了，终于有组织了＞",0)
	say("哈哈，以后，还请少侠多为*华山派出出力啊。*＜嘿，关键时候又多了个替死鬼＞",19)
	say("＜五岳剑派盟主的位置*迟早是我岳不群的，哈哈！*啊，淡定，淡定，不能让这小子看出来＞",19)
	JoinMP(0, 14, 2)
	else		
	say("承蒙先生厚爱*但我仍然想要自己闯荡一番*抱歉了。*＜找寻十四天书要紧！＞",0)
	say("哎，也罢，以后有需要帮助的地方*可以来华山派找我*＜不识好歹的小子！＞",19)
	end
end

OEVENTLUA[465] = function() --桃花
    --say("阿弥陀佛，苦海无边，回头*是岸。",65)
    if not inteam(78) or cxzj() == 78 then
    else	
	instruct_14();   --  13(D):重新显示场景
	instruct_13();   --  13(D):重新显示场景
	say("这里……这里是桃花岛？…*…不……我不能回来……我*不能回来……！",78)
	instruct_0();
	instruct_21(78);
	instruct_3(70,59,1,0,171,0,0,7106,7106,7106,-2,-2,-2);--修改事件定义:当前场景当前场景事件编号
	do return; end
	end
end
OEVENTLUA[614] = function() --星宿
    --say("阿弥陀佛，苦海无边，回头*是岸。",65)
    if not inteam(47) or cxzj() == 47 then
    else	
	instruct_14();   --  13(D):重新显示场景
	instruct_13();   --  13(D):重新显示场景
	say("不，我不要回这里，我不要*回这里……",47)
	instruct_0();
	instruct_21(47);
	instruct_3(70,23,1,0,133,0,0,6374,6374,6374,-2,-2,-2);--修改事件定义:当前场景当前场景事件编号
	do return; end
	end
end

OEVENTLUA[1073] = function()
	null(-2,9)
	instruct_0();
	addthing(91)
	instruct_0();
	if inteam(47) and inteam(2) and hasthing(66) then
		say("喂，你把这秘笈拿来。",47)
		instruct_0();
		say("...你要干什么...别放毒啊，我给你就是了！")
		instruct_0();
		say("哼，这就是玄冥神掌啊，我看丁老怪就用的这功夫，也就那样吧。",47)
		instruct_35(47,0,21,1)
		instruct_0();		
		say("哈哈，我再学了这化功大法，我的毒功就没人能敌了！",47)
		instruct_35(47,1,87,1)
		instruct_0();
		say("无人能敌？小阿紫，你太看得起自己了...我看看...",2)
		instruct_0();
		say("哼，这掌法不过是寒气霸道罢了，我要破解太轻松了。",2)
		instruct_0();
		instruct_35(2,0,21,1)
		say("你，哼。",47)
		instruct_0();
	elseif inteam(47) then
		say("喂，你把这秘笈拿来。",47)
		instruct_0();
		say("...你要干什么...别放毒啊，我给你就是了！")
		instruct_0();
		say("哼，这就是玄冥神掌啊，我看丁老怪就用的这功夫，也就那样吧。",47)
		instruct_35(47,0,21,1)
		instruct_0();
		if hasthing(66) then
			say("哈哈，我再学了这化功大法，我的毒功就没人能敌了！",47)
			instruct_35(47,1,87,1)
			instruct_0();
			say("是是是，星宿小仙，法力无边，星宿老怪，打飞天边。")
			instruct_0();
			say("哈哈哈...",47)
			instruct_0();
		end
	elseif inteam(2) then	
		say("公子，这就是玄冥神掌，听说练成后毒性十足，请让我看一看",2)
		instruct_0();
		say("哦，哦，程姑娘请。")
		instruct_0();
		say("......这套掌法练成以寒毒为主，公子修炼时若与另几种掌法合练效果更佳。",2)
		instruct_0();
		say("哦，明白了。")
		instruct_35(2,0,21,1)
		instruct_0();
	end	
end   

OEVENTLUA[1081] = function() --武duang
    --say("阿弥陀佛，苦海无边，回头*是岸。",65)
    if not inteam(82) or cxzj() == 82 then
    else	
	instruct_14();   --  13(D):重新显示场景
	instruct_13();   --  13(D):重新显示场景
	say("我不能回武当，我不回！",82)
	instruct_0();
	instruct_21(82);
	instruct_3(70,54,1,0,179,0,0,7040,7040,7040,-2,-2,-2);--修改事件定义:当前场景当前场景事件编号
	do return; end
	end
end
OEVENTLUA[468] = function()
    instruct_14();   --  13(D):重新显示场景
	instruct_37(2);   --  37(25):增加道德2
	instruct_26(61,0,1,0,0); --增加场景事件编号的三个触发事件编号
	instruct_26(61,8,1,0,0); --增加场景事件编号的三个触发事件编号
	instruct_26(61,17,1,0,0); --增加场景事件编号的三个触发事件编号
	instruct_26(61,16,1,0,0); --增加场景事件编号的三个触发事件编号
	instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);--修改事件定义:当前场景当前场景事件编号
	instruct_13();   --  13(D):重新显示场景
	instruct_25(34,20,30,21); --场景移动34-20--30-21
    say("妹子，你在这里练功夫么？",61)	
	say("＜靖哥哥受了重伤，还需五*天五夜方能痊癒。偏巧在这*时候碰见这个姓欧阳的，真*是倒楣，怎生撒个大谎，将*他远远骗走＞",56)	
	say("妹子，出来罢，躲在这里气*闷得紧。我知道那姓郭的小*子已经深受重伤，妹子，你*就依了我吧，咱俩做个长久*夫妻。只要你答应我，我保*证不加害这个姓郭的小子。",61)
	say("＜不好，郭大哥和黄姑娘有*难，我得帮帮他们＞，欧阳*兄，好久不见啊？",0)	
	say("啊？又是你！",61)	
	say("小兄弟你来得正好，快来结*果了这个恶人。",56)
	say("听见了吗？欧阳克，你作恶*多端，今日我就要送你归西*！",0)
	     if instruct_6(178,4,0,0) == false then 
		 instruct_15(0);   --  15(F):战斗失败，死亡
			do return; end
         end
	instruct_3(-2,1,1,0,0,0,0,5154,5154,5154,-2,-2,-2);	 --修改事件定义:当前场景当前场景事件编号
	instruct_19(30,21); --场景移动3
	instruct_40(2)--面向
	instruct_0()
	instruct_13();   --  13(D):重新显示场景
	instruct_37(2);   --  37(25):增加道德2
	say("多亏小兄弟及时赶到，否则*今日定难逃脱。",56)	 
	say("郭大哥怎么了？好像伤得很*严重！",0)
    say("靖哥哥和我得知金人要偷武*穆遗书，我们就连夜赶到皇*宫保护，没想到西毒欧阳锋*竟然帮着金人，以蛤蟆功掌*力震伤靖哥哥。",56)	
	say("可恶的西毒欧阳锋，教我碰*见一定好好教训他！",0)
	say("谁这么大口气！",60)
	instruct_14();   --  13(D):重新显示场景
	instruct_3(-2,6,0,0,0,0,0,8218,8218,8218,-2,-2,-2);	 --修改事件定义:当前场景当前场景事件编号
	instruct_40(1)--面向
	instruct_0()
	instruct_13();   --  13(D):重新显示场景
	say("啊，克儿，你怎么了？克儿*！谁，是谁杀了克儿！是不*是你！",60)
	say("＜完了，没办法，事到如今*，豁出去了！＞就是我，怎*么样！",0)
	say("好小子，有骨气！拿命来吧*！",60)
	instruct_0()
	instruct_47(60,30) --[60欧阳锋]增加武功30
	    if instruct_6(172,1,0,1) == true then 
	if GetS(111,0,0,0) == 0 then 
	    say("糟糕！！蛤蟆功！！小子放下！",60) 
	    instruct_0();
			    if DrawStrBoxYesNo(-1, -1, "是否丢弃？", C_WHITE, 30) == false then 
	                 QZXS("获得蛤蟆功精要！")
	                 instruct_0();
	                 SetS(111, 0, 0, 0,95)
					 instruct_2(73)
				else
				     say("谁稀罕。",0) 
					 instruct_0()
				end	
	end
		end

	instruct_3(-2,7,0,0,0,0,0,6154,6154,6154,-2,-2,-2);	 --修改事件定义:当前场景当前场景事件编号
	instruct_0()
	instruct_13();   --  13(D):重新显示场景
	say("嘿嘿，臭蛤蟆，在练什么功*夫啊？",64) 
	say("周老爷子，别在一旁看热闹*，快来帮帮我",0) 
	say("放心，有我在，老毒物伤不*了你。",64) 
	instruct_0()
	instruct_47(60,30) --[60欧阳锋]增加武功30
	     instruct_6(173,1,0,1)

	instruct_3(-2,8,0,0,0,0,0,8238,8238,8238,-2,-2,-2);	 --修改事件定义:当前场景当前场景事件编号
	instruct_0()
	instruct_13();   --  13(D):重新显示场景
	say("蓉儿，是你吗？",57) 
	say("爹爹，快过来，老毒物欺负*你女儿！",56) 
	say("锋兄，为何动手啊？",57) 
	say("欧阳克要欺负我，正好小兄*弟赶到，杀了欧阳克，老毒*物要为他侄子报仇，爹爹，*你快帮帮这位小兄弟吧！",56) 
	say("锋兄，你那侄子也可算是作*恶多端死有余辜，你何必…*…",57) 
	say("废话少说，我今日定要为克*儿报仇！",60)
	instruct_0()
	instruct_47(60,30) --[60欧阳锋]增加武功30 
	    if instruct_6(174,4,0,0) == false then
		 instruct_15(0);   --  15(F):战斗失败，死亡
			do return; end
        end
	instruct_0()
	instruct_13();   --  13(D):重新显示场景
	say("好小子，算你命大，我就让*你再多活几天！克儿，你放*心，等叔叔练好了九阴真经*，一定为你报仇！",60)
	
	instruct_0()
	instruct_3(-2,6,0,0,0,0,0,0,0,0,0,0,0);--修改事件定义:当前场景当前场景事件编号
	instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);--修改事件定义:当前场景当前场景事件编号
	instruct_0()
	say("多谢周老前辈、黄岛主的救命*之恩！",0) 
	say("你救了蓉儿，我救了你，咱*们两不相欠，不必言谢",57) 
	say("黄老邪，你这话就不对了。*就算你不来，我一样可以把*欧阳锋打跑。所以说你来根*本就是多余，小兄弟也不是*你救的。可是他救你女儿女*婿却是实实在在的，所以你*还是欠他的。",64) 
	say("我黄药师一生从不欠别人的*。这样吧，小友，我就把我*的生平绝学传授与你吧。",57) 
	say("岛主救我性命，我已然感激*不尽，若再接受岛主传艺，*实在惶恐。",0) 
	say("小友不必过谦。我一身武艺*，本想有个传人。怎奈我当*初一怒之下，把我所有的徒*弟都逐出门墙。如今得了个*女婿，又是如此……",57) 
	say("爹——",56)
	say("哼，说你的靖哥哥几句你就*不高兴！小友，我看你天资*聪颖，与我桃花岛又颇有缘*分，趁着靖儿养伤这几日，*我这弹指神通的功夫就传给*你吧。",57) 
	say("多谢岛主厚爱，恭敬不如从*命。",0) 
	say("黄老邪，你以为你了不起，*什么生平绝学弹指神通！我*周伯通别的功夫都想学，就*是不看你的古怪功夫。我去*也！",64) 
	if GetS(113,0,0,0) == 0 and JY.Person[0]["暗器技巧"] >= 235 then 
	    say("小友透骨打穴的手法虽然有所纯熟，但当中任有一丝不足",57)
		say("晚辈难以掌握力道以及技巧",0) 
		say("我就来指点小友一番",57)
		say("多谢黄岛主",0)
	    instruct_0();
		if instruct_11(0,188) == true then 
	        QZXS("领悟弹指神通精要！")
	        instruct_0();
	        setLW1(18)
		else
			say("岛主神技，晚辈一时难以学成",0) 
		end	
	end
	if MPPD(0) == 0 and cxzj() ~= 57 then
	say("小友也与我桃花岛素有缘分，也算半个徒弟了，不知是否有意加入桃花岛。",57) 
	if DrawStrBoxYesNo(-1, -1, "要加入桃花岛么？", C_WHITE, 30) == true then 
	say("多谢黄岛主的美意！我向往已久",0) 
    say("哈哈，痛快，痛快",57) 
	JoinMP(0,10,1)	
	QZXS(JY.Person[0]["姓名"].."成为桃花岛弟子！")
	end
	end
	if MPPD(0) == 10 and cxzj() ~= 57 then 
	say("既然小友是我桃花岛的同门，我就传你一些独门绝学吧。",57) 
	JoinMP(0,10,2)
				if GetS(111, 0, 0, 0) == 0 then
						say("让我来考校考校你。",57) 
	                    instruct_0();
				         SetS(106, 63, 1, 0, 0)
	                      SetS(106, 63, 2, 0, 57)
	                    JY.Person[57]["攻击力"] = JY.Person[57]["攻击力"] + 300
	                   JY.Person[57]["轻功"] = JY.Person[57]["轻功"] + 300
	                   JY.Person[57]["防御力"] = JY.Person[57]["防御力"] + 300
				       JY.Person[57]["武功5"] = 107
				         JY.Person[57]["武功等级5"] = 999
                        JY.Person[57]["内力最大值"] = 10000
	                    JY.Person[57]["内力"] = 10000				
	            if WarMain(288) == false then
		           instruct_0();  	
				   say("你还需多用心才是。",57) 
	            else
				   say("不错不错，这碧海潮生功的精义你就拿去吧。",57) 
				   	if DrawStrBoxYesNo(-1, -1, "是否领悟碧海潮生功？", C_WHITE, 30) == true then 
	                 QZXS("领悟碧海潮生功奥妙！")
	                 instruct_0();
	                 SetS(111, 0, 0, 0,6)
				    else
				     say("谢师傅。",0) 
					 instruct_0()
				    end
                end
				end
	end
	instruct_0()
	instruct_14()
	instruct_3(-2,2,0,0,0,0,0,0,0,0,0,0,0);--修改事件定义:当前场景当前场景事件编号
	instruct_3(-2,8,0,0,0,0,0,0,0,0,0,0,0);--修改事件定义:当前场景当前场景事件编号
	instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0);--修改事件定义:当前场景当前场景事件编号
	instruct_3(-2,5,0,0,0,0,0,0,0,0,0,0,0);--修改事件定义:当前场景当前场景事件编号
	instruct_3(-2,10,0,0,0,0,0,8002,8002,8002,-2,-2,-2);	 --修改事件定义:当前场景当前场景事件编号
	instruct_3(-2,11,0,0,0,0,0,8004,8004,8004,-2,-2,-2);	 --修改事件定义:当前场景当前场景事件编号
	instruct_3(-2,9,0,0,0,0,0,8238,8238,8238,-2,-2,-2);	 --修改事件定义:当前场景当前场景事件编号
	instruct_19(23,35)
	instruct_40(1)
	instruct_0()
	instruct_13();   --  13(D):重新显示场景
	say("靖儿的伤已经痊癒了，我这*弹指神通的功夫，小友也学*得差不多啦，咱们就此别过*",57) 
	     if instruct_16(63,0,190) == true then
		    say("还有徒儿，在小友有空时身*边好好练习我教给你的武功*，不得堕了桃花岛的名声。",57) 
			say("是，师傅。",63) 
			instruct_0()
			instruct_35(63,1,12,0)--[63程英]武功[1]为[12落英神剑掌]
			instruct_35(63,2,18,0)--[63程英]武功[2]为[18弹指神通]
			instruct_45(63,10) --[63程英]增加轻功10
			instruct_0()
			instruct_3(-2,9,0,0,0,0,0,0,0,0,0,0,0);--修改事件定义:当前场景当前场景事件编号
			instruct_0()
				if GetS(113, 0, 0, 0) == 0 then
    say("桃花岛的绝学我也有所涉猎，看来之前所学的东西隐隐有些体悟",0) 
	say("总觉得程英姑娘的玉箫另藏玄机，要不拿来看看？",0) 
				  if instruct_11(0,188) == true then
				     say("程姑娘，你的玉箫可否方便给我看看",0) 
					 say("好的，少侠",63) 
					 say("（挥舞了一下）嗯，似乎有点灵感了",0) 
					 say("玉箫在挥动的时候，其实会有一阵缓慢气流穿过箫孔",0)
                     say("然后配合玉箫的低频振动，可以扰乱人脉搏的振动",0) 
                     say("如果挥舞的频率较为适当的话，也许可以有更好的效果",0) 
                     say("比如，次声共振",0) 					 
	                 QZXS("领悟玉箫魔音！")
	                 instruct_0();
	                 say("哈哈，这也能悟出来，我还真是天才",0) 
	                 setLW1(38)
				  else
				     say("算了，不强求这里有所突破吧",0) 
				  end
    end	
			say("爹——*唉，这么快就走，一点也不*疼女儿！",56) 
			say("郭大哥，黄姑娘，你们有何*打算？",0) 
			say("我要继续寻访武穆遗书的下*落。",55) 
			say("小兄弟，咱们就此别过！",56) 
		    instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);	 --修改事件定义:当前场景当前场景事件编号
	        instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);	 --修改事件定义:当前场景当前场景事件编号
			instruct_3(48,3,0,0,0,0,469,0,0,0,-2,-2,-2);
			instruct_3(48,2,0,0,0,0,469,0,0,0,-2,-2,-2);
			instruct_3(48,20,0,0,0,0,0,8002,8002,8002,-2,-2,-2);
			instruct_3(48,21,0,0,0,0,0,8004,8004,8004,-2,-2,-2);
			instruct_3(48,22,0,0,0,0,0,7988,7988,7988,-2,-2,-2);
			instruct_3(48,26,0,0,0,0,0,6094,6094,6094,-2,-2,-2);
			instruct_3(48,25,0,0,0,0,0,6094,6094,6094,-2,-2,-2);
			instruct_0()
			instruct_2(95,1)--得到物品[95弹指神通]1个
			instruct_0()
			do return; end
         end
	if GetS(113, 0, 0, 0) == 0 then
    say("桃花岛的绝学我也有所涉猎，看来之前所学的东西隐隐有些体悟",0) 
	say("回想岛上那漫天飞舞的桃花，似乎蕴含着某种意境",0) 
				  if instruct_11(0,188) == true then
				     say("如果将落英的剑意蕴含于周身气劲中，如同桃花瓣飘舞",0) 
					 say("让飞舞的剑气切割周围的对手，慢慢消耗对手的气血",0)
                     say("那么这将会成为让敌人不敢面对的噩梦吧",0) 					 
	                 QZXS("领悟落英缤纷！")
	                 instruct_0();
	                 say("哈哈，我也算是一个奇才",0) 
	                 setLW1(12)
				  else
				     say("算了，不强求这里有所突破吧",0) 
				  end
    end	
	instruct_0()
	instruct_3(-2,9,0,0,0,0,0,0,0,0,0,0,0);--修改事件定义:当前场景当前场景事件编号
	instruct_0()
	say("爹——*唉，这么快就走，一点也不*疼女儿！",56) 
	say("郭大哥，黄姑娘，你们有何*打算？",0) 
	say("我要继续寻访武穆遗书的下*落。",55) 
	say("小兄弟，咱们就此别过！",56) 
	instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);	 --修改事件定义:当前场景当前场景事件编号
	instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);	 --修改事件定义:当前场景当前场景事件编号
	instruct_3(48,3,0,0,0,0,469,0,0,0,-2,-2,-2);
	instruct_3(48,2,0,0,0,0,469,0,0,0,-2,-2,-2);
	instruct_3(48,20,0,0,0,0,0,8002,8002,8002,-2,-2,-2);
	instruct_3(48,21,0,0,0,0,0,8004,8004,8004,-2,-2,-2);
	instruct_3(48,22,0,0,0,0,0,7988,7988,7988,-2,-2,-2);
	instruct_3(48,26,0,0,0,0,0,6094,6094,6094,-2,-2,-2);
	instruct_3(48,25,0,0,0,0,0,6094,6094,6094,-2,-2,-2);
	instruct_0()
	instruct_2(95,1)--得到物品[95弹指神通]1个
	instruct_0()	 
end

OEVENTLUA[408] = function()
    instruct_1(1552,7,0)--[7何太冲]:你看看这一条的注解：*”吴钩者，吴王阖庐之宝刀*也．”为什麽．． ．
	instruct_0()
	     if instruct_16(38,2,0) ==true or cxzj() == 38 then 

	instruct_1(1553,38,1)--[38石破天]:大哥，*我的”巨骨穴”好热．．．
	instruct_0()
	instruct_3(-2,-2,1,0,409,0,0,-2,-2,-2,-2,-2,-2);
	instruct_26(-2,4,0,0,1)
	instruct_26(-2,5,0,0,1)
	instruct_26(-2,6,0,0,1)
			 	do return; end
         end
end

OEVENTLUA[409] = function()
    instruct_1(1552,7,0)--[7何太冲]:你看看这一条的注解：*”吴钩者，吴王阖庐之宝刀*也．”为什麽．． ．
	instruct_0()
	     if instruct_16(38,2,0) == false then 
		 	do return; end
         end
	instruct_1(1553,38,1)--[38石破天]:大哥，*我的”巨骨穴”好热．．．
	instruct_0()
	instruct_0()
end

OEVENTLUA[410] = function()
    instruct_1(1554,21,0)--[21定闲]:我觉得这句”银鞍照白马”*和”飒沓如流星”连在一起*方为正解．．．
	instruct_0()
	     if instruct_16(38,2,0) == true or cxzj() == 38 then 
	instruct_1(1555,38,1)--[38石破天]:大哥，这马下的云气，好像*一团团云雾在不断的向前推*涌．．．
	instruct_0()
	instruct_3(-2,-2,1,0,411,0,0,-2,-2,-2,-2,-2,-2);
	instruct_26(-2,4,0,0,1)
	instruct_26(-2,5,0,0,1)
	instruct_26(-2,6,0,0,1)
			 	do return; end
         end
end

OEVENTLUA[411] = function()
    instruct_1(1554,21,0)--[21定闲]:我觉得这句”银鞍照白马”*和”飒沓如流星”连在一起*方为正解．．．
	instruct_0()
	     if instruct_16(38,2,0) == false then 
		 	do return; end
         end
	instruct_1(1555,38,1)--[38石破天]:大哥，这马下的云气，好像*一团团云雾在不断的向前推*涌．．．
	instruct_0()
    instruct_0()
end

OEVENTLUA[412] = function()
    instruct_1(1556,23,0)--[23天门]:银光灿烂，鞍自平稳．天马*行空，瞬息万里．．．原来*天马是手．并非真的是马．
	instruct_0()
	instruct_1(1557,23,0)--[23天门]:这壁上的注解说道：白居易*诗云”勿轻直折剑，犹胜曲*全勾”．*可见我这直折之剑，方合石*壁注文原意．
	instruct_0()
	instruct_1(1558,20,0)--[20莫大]:不对，”吴钩霜雪明”是*主，”犹胜曲全钩”是宾．*喧宾夺主，必非正道．
	instruct_0()
	     if instruct_16(38,2,0) == true or cxzj() == 38 then 
	instruct_1(1559,38,1)--[38石破天]:＜咦！这些字的笔划看起来*好像是一把把的长剑，有的*剑尖朝上，有的向下，有的*斜起欲飞，有的横掠欲堕．*”五里穴”好热．．．
	instruct_0()
	instruct_3(-2,11,1,0,413,0,0,-2,-2,-2,-2,-2,-2);
	instruct_3(-2,10,1,0,413,0,0,-2,-2,-2,-2,-2,-2);
	instruct_26(-2,4,0,0,1)
	instruct_26(-2,5,0,0,1)
	instruct_26(-2,6,0,0,1)
			 	do return; end
         end
end

OEVENTLUA[413] = function()
    instruct_1(1556,23,0)--[23天门]:银光灿烂，鞍自平稳．天马*行空，瞬息万里．．．原来*天马是手．并非真的是马．
	instruct_0()
	instruct_1(1557,23,0)--[23天门]:这壁上的注解说道：白居易*诗云”勿轻直折剑，犹胜曲*全勾”．*可见我这直折之剑，方合石*壁注文原意．
	instruct_0()
	instruct_1(1558,20,0)--[20莫大]:不对，”吴钩霜雪明”是*主，”犹胜曲全钩”是宾．*喧宾夺主，必非正道．
	instruct_0()
	     if instruct_16(38,2,0) == false then 
		 	do return; end
         end
	instruct_1(1559,38,1)--[38石破天]:＜咦！这些字的笔划看起来*好像是一把把的长剑，有的*剑尖朝上，有的向下，有的*斜起欲飞，有的横掠欲堕．*”五里穴”好热．．．
	instruct_0()
end

OEVENTLUA[414] = function()
    instruct_1(1560,8,0)--[8唐文亮]:这”侠客行”的古诗图解，*包含着古往今来最博大精深*的武学秘奥．．．*你瞧，这第一句”赵客缦胡*缨”，其中对这个”胡”字*的注解．．．
	instruct_0()
	     if instruct_16(38,2,0) == true or cxzj() == 38 then 
	instruct_0()
	instruct_3(-2,-2,1,0,415,0,0,-2,-2,-2,-2,-2,-2);
	instruct_26(-2,4,0,0,1)
	instruct_26(-2,5,0,0,1)
	instruct_26(-2,6,0,0,1)
			 	do return; end
         end
end

OEVENTLUA[415] = function()
    instruct_1(1560,8,0)--[8唐文亮]:这”侠客行”的古诗图解，*包含着古往今来最博大精深*的武学秘奥．．．*你瞧，这第一句”赵客缦胡*缨”，其中对这个”胡”字*的注解．．．
	instruct_0()
	     if instruct_16(38,2,0) == false then 
		 	do return; end
         end
	instruct_0()
end

OEVENTLUA[416] = function()
    if instruct_16(38,2,0) == true or cxzj() == 38 then

	instruct_26(61,19,1,0,0)
	instruct_26(61,18,1,0,0)
	instruct_1(1561,38,1)--[38石破天]:大哥，这没有什麽好看的，*我们走了好不好．．．
	instruct_0()
	instruct_1(1562,0,1)--[0资]:贤弟，小声一点，别吵到两*位岛主练功．．
	instruct_0()
	instruct_1(1563,38,1)--[38石破天]:＜这些字怎麽如此古怪，看*上一眼，便会头晕？＞**＜至阳穴好热，原来这些蝌*蚪看似乱钻乱游，其实还是*和内息有关＞
	instruct_0()
	instruct_1(1564,39,0)--[39龙岛主]:这位石兄弟双眼注目这”太*玄经”，原来是位精通蝌蚪*文的大方家．
	instruct_0()
	instruct_1(1565,38,1)--[38石破天]:小人一个字也不识，只是瞧*这些小蝌蚪十分好玩，便多*看了一会．
	instruct_0()
	instruct_1(1566,40,0)--[40木岛主]:这就是了，这部”太玄经”*以古蝌蚪文写成，我本来正*自奇怪，石兄弟年纪轻轻，*居然有此奇才，识得这种古*奥文字．
	instruct_0()
	instruct_1(1567,38,1)--[38石破天]:＜我还是别打扰二位岛主好*了．．．可是这蝌蚪还真好*玩．．．＞*＜咦！这些蝌蚪怎麽在我身*体各处跑了起来．．．．．*怎麽这样地舒畅．．．．＞
	instruct_0()
	instruct_1(1568,0,1)--[0资]:贤弟，你干什么？
			    SetS(106, 63, 1, 0, 0)
                SetS(106, 63, 2, 0, 38)
	            JY.Person[38]["攻击力"] = JY.Person[38]["攻击力"]+300
	            JY.Person[38]["轻功"] = JY.Person[38]["轻功"]+300
	            JY.Person[38]["防御力"] = JY.Person[38]["防御力"]+300
				JY.Person[38]["生命最大值"] = JY.Person[38]["生命最大值"]*4
	            JY.Person[38]["生命"] = JY.Person[38]["生命最大值"]
                JY.Person[38]["内力最大值"] = JY.Person[38]["内力最大值"]*3
	            JY.Person[38]["内力"] = JY.Person[38]["内力最大值"]
	            JY.Person[38]["声望"] = 102
				JY.Person[38]["武功等级1"] = 999
				JY.Person[38]["武功2"] = 102
				JY.Person[38]["武功等级2"] = 999
				if WarMain(288) == false then
				else
	instruct_0()
	instruct_2(80,1)--得到物品[80太玄经]1个
		if GetS(111, 0, 0, 0) == 0 then
	    say("原来如此，这太玄神功果然精妙。",0) 
	    instruct_0();
			    if DrawStrBoxYesNo(-1, -1, "是否领悟太玄经？", C_WHITE, 30) == true then 
	                 QZXS("领悟太玄经奥妙！")
	                 instruct_0();
	                 SetS(111, 0, 0, 0,102)
				else
				     say("不过却是不适合我，可惜了。",0) 
					 instruct_0()
				end	
		end	
				end
	            JY.Person[38]["攻击力"] = JY.Person[38]["攻击力"]-300
	            JY.Person[38]["轻功"] = JY.Person[38]["轻功"]-300
	            JY.Person[38]["防御力"] = JY.Person[38]["防御力"]-300
				JY.Person[38]["生命最大值"] = JY.Person[38]["生命最大值"]/4
	            JY.Person[38]["生命"] = JY.Person[38]["生命最大值"]
                JY.Person[38]["内力最大值"] = JY.Person[38]["内力最大值"]/3
	            JY.Person[38]["内力"] = JY.Person[38]["内力最大值"]
	            JY.Person[38]["声望"] = 102
	instruct_0()
	instruct_14()
	instruct_13()
	instruct_1(1569,38,1)--[38石破天]: 啊！好累．*我怎麽觉得好累．
	instruct_0()
	instruct_1(1570,0,1)--[0资]:贤弟，你总算清醒过来了．
	instruct_0()
	instruct_1(1571,38,1)--[38石破天]:怎麽，*难道我昏迷过去了吗？
	instruct_0()
	instruct_1(1572,0,1)--[0资]:是啊！原先我以为你又着魔*了，后来龙岛主说你正悟出*神功，我才没有去吵你，前*后算起来已有三天了．
	instruct_0()
	instruct_1(1573,38,1)--[38石破天]:是吗？已经三天了，*难怪我觉得好饿．
	instruct_0()
	instruct_1(1574,39,0)--[39龙岛主]:石兄弟，我兄弟俩闷在心中*数十年的大疑团，终於得以*解开，真是太感激你了．
	instruct_0()
	instruct_1(1575,38,1)--[38石破天]:我怎麽．．怎麽解破的?
	instruct_0()
	instruct_1(1576,39,0)--[39龙岛主]:石兄弟何必如此谦虚？你参*透了这首”侠客行”的石壁*图谱，不但是现今武林中的*第一人，除了当年在石壁上*雕写图谱的那位前辈之外，*只怕古往今来，也极少有人*及得上你．
	instruct_0()
	instruct_1(1577,38,1)--[38石破天]:小人不敢，小人不敢．
	instruct_0()
	instruct_1(1578,39,0)--[39龙岛主]:这石壁上的蝌蚪古文，在下*与木兄弟所识还不到一成，*不知石兄弟肯赐予指教麽？
	instruct_0()
	instruct_1(1579,38,1)--[38石破天]:我跟两位说了便是，我看这*条蝌蚪，”中注穴”中便有*跳动;*再看这条蝌蚪，”太赫穴”*便大跳一下．．．．
	instruct_0()
	instruct_1(1580,40,0)--[40木岛主]:原来．．原来．．石帮主看*的是一条条．．那个蝌蚪，*不是看一个个字．．．*那麽石帮主如何能通解全篇*”太玄经”？
	instruct_0()
	instruct_1(1581,38,1)--[38石破天]:小人自幼没读过书，当真一*字不识，惭愧的紧．
	instruct_0()
	instruct_1(1582,40,0)--[40木岛主]:你不识字？
	instruct_0()
	instruct_1(1583,38,1)--[38石破天]:不识字．我．．回去之后，*定要去学识字，否则人人都*识字，我却不识得，给人笑*话，多不好意思．
	instruct_0()
	instruct_1(1584,39,0)--[39龙岛主]:你既不识字，那麽这些壁上*许许多多的注释，却是谁解*给你听的？
	instruct_0()
	instruct_1(1585,38,1)--[38石破天]:没人解给我听．*我．．．只是瞧着图形，胡*思乱想，忽然之间，图上的*云头或小剑什麽的，就和身*体内的热气连在一起了．
	instruct_0()
	instruct_1(1586,40,0)--[40木岛主]:你不识字，却能解通图谱，*这．．．如何能够？
	instruct_0()
	instruct_1(1587,39,0)--[39龙岛主]:难道冥冥之中真有天意？*还是这位石兄弟真有天纵英*才．
	instruct_0()
	instruct_1(1588,40,0)--[40木岛主]:．．．．．*我懂了，我懂了．*大哥，原来如此．
	instruct_0()
	instruct_1(1589,39,0)--[39龙岛主]:啊！是了．是了．*石兄弟，幸亏你不识字，才*得解破这个大疑团．*唉！原来这许许多多注释文*字，每一句都在导人误入歧*途．可是参研图谱之人，又*有那个肯不去钻研注解．
	instruct_0()
	instruct_1(1590,39,0)--[39龙岛主]:原来这篇”太玄经”也不是*真的蝌蚪文，只不过．．．*只不过是一些经脉穴道的线*路方位而已．***唉，三十年的光阴，三十年*的光阴！
	instruct_0()
	instruct_1(1591,40,0)--[40木岛主]:白首太玄经！*兄弟，你的头发也真是雪白*了．
	instruct_0()
	instruct_1(1592,39,0)--[39龙岛主]:此岛名为侠客岛，是因为我*们兄弟二人在此间还发现了*另一部奇书，叫《侠客行》*。我二人发下誓愿，谁能解*得了这壁上图谱，便奖此书*曾与谁。如今图谱已解，这*本书就赠与石帮主吧。
	instruct_0()
	instruct_1(1593,38,1)--[38石破天]:我不识字，这本书要来也没*有用。这位大哥好像正在找*这本书吧，那我就把这本书*送给大哥好了。
	instruct_0()
	instruct_1(1594,0,1)--多谢石兄弟，多谢二位岛主*。
	instruct_0()
	instruct_1(1595,39,0)--[39龙岛主]:兄弟，你我心愿已了，我们*也该歇息了．这腊八粥之约*以后也不必了．*我们这就去告诉各位掌门不*用再钻研此图解了．**公子，你们也可赶紧离去。
	instruct_0()
	instruct_1(1596,0,1)--[0资]:前辈，告辞了。
	instruct_0()
	instruct_2(154,1)--得到物品[154侠客行]1个
	instruct_0()
	instruct_3(-2,0,0,0,0,0,0,0,0,0,0,0,0);
	instruct_3(-2,12,0,0,0,0,0,0,0,0,0,0,0);
	instruct_3(-2,13,0,0,0,0,0,0,0,0,0,0,0);
	instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);
	instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);
	instruct_3(-2,9,0,0,0,0,0,0,0,0,0,0,0);
	instruct_3(-2,8,0,0,0,0,0,0,0,0,0,0,0);
	instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0);
	instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);
	instruct_3(-2,16,0,0,0,0,419,0,0,0,-2,-2,-2);
	instruct_3(-2,17,0,0,0,0,419,0,0,0,-2,-2,-2);
	instruct_3(-2,18,0,0,0,0,419,0,0,0,-2,-2,-2);
	instruct_3(-2,3,1,0,418,0,0,5136,5136,5136,-2,-2,-2);
	instruct_3(-2,2,1,0,417,0,0,5132,5132,5132,-2,-2,-2);
	instruct_0()
	instruct_13()
	if cxzj() == 38 then
	instruct_35(zj(),1,102,0)--[38石破天]学会[102太玄神功]
	instruct_46(zj(),100)--[38石破天]增加内力1000
	instruct_47(zj(),50)--[38石破天]增加武功50
	else
	instruct_35(38,1,102,0)--[38石破天]学会[102太玄神功]
	instruct_46(38,100)--[38石破天]增加内力1000
	instruct_47(38,50)--[38石破天]增加武功50
	end
	do return; end
    end
end

OEVENTLUA[392] = function()
    instruct_1(1527,38,0) -- [38石破天]:大哥，雪山派的白师父怎么*样了？
	instruct_0()
	instruct_1(1528,0,1)--[0资]:他很好啊，原本应该发给他*的铜牌现在已经发给我了*……
	instruct_0()
	instruct_1(1529,38,0)--[38石破天]:那我们一起去侠客岛吧
	instruct_0()
	     if instruct_9(0,95) == true then
		    instruct_37(1)
			instruct_1(1530,0,1)
			if cxzj() == 38 then
			    instruct_14()
				instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);
			    instruct_0()
	            instruct_13()
				for i = 1,HHH_GAME_SETTING["WG_COUNT_MAX"] do
			    JY.Person[zj()]["武功"..i] = JY.Person[38]["武功"..i]
				end
				do return; end
            else 
			    instruct_3(104,43,1,0,957,0,0,7074,7074,7074,-2,-2,-2);
			
			 if instruct_20(20,0) == false then
			    instruct_14()
				instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);
			    instruct_0()
	            instruct_13()
				instruct_10(38)
				 do return; end
             end 
			 
			    instruct_1(12,38,0)
				instruct_0()
	            instruct_14()
				instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);
				instruct_3(70,16,1,0,127,0,0,6410,6410,6410,-2,-2,-2);
				instruct_3(70,58,1,0,127,0,0,6412,6412,6412,-2,-2,-2);
	            instruct_0()
	            instruct_13()
			 do return; end
          end 
          end		  
	instruct_1(1531,0,1)--[0资]:我还有事，*你在这里等我吧。
	instruct_0()
	instruct_3(-2,-2,1,0,393,0,0,-2,-2,-2,-2,-2,-2);
end

OEVENTLUA[62] = function()
    instruct_1(272,225,0) -- 一呀摸，二呀摸，摸到姐姐*的头发边……唉，我韦小宝*什么时候能离开这里，一定*要发大财，取一堆漂亮老婆*，开个特大的妓院，哈哈…*…
	instruct_0()
	    if instruct_9(2,0) == false then -- 是否加入
		   instruct_0()
		    do return; end
        end     
		   instruct_26(1,10,1,0,0) 
		   instruct_26(1,7,1,0,0) 
		   instruct_1(273,225,0) --出去玩？＜这个家伙看着好*像挺能打的，跟着他不会吃*亏……我娘现在不在这……*哈哈，就这么定了……＞，*好啊，出去找漂亮老婆，好*爽好爽。
		   instruct_0()
    if instruct_20(21,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label1
		   instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2); 
		   instruct_0()
		   instruct_1(274,225,0)
		   instruct_10(664)
		   instruct_0()
		   instruct_3(71,20,0,0,0,0,63,0,0,0,-2,-2,-2); 
		   instruct_3(76,12,0,0,0,0,89,-2,-2,-2,-2,-2,-2); 
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end
	say("都没地方让我呆着，还是算了。",664)
end

OEVENTLUA[89] = function()
    if instruct_16(664) then
	instruct_0();   --  14(E):场景变黑
        instruct_13();   --  13(D):重新显示场景
	       instruct_3(76,0,1,0,0,0,0,6292,6292,6292,-2,-2,-2); 
		   instruct_3(76,1,1,0,0,0,0,5956,5956,5956,-2,-2,-2); 
		   instruct_3(76,2,1,0,0,0,0,6306,6306,6306,-2,-2,-2); 
		   instruct_3(76,11,1,0,0,0,0,7030,7030,7030,-2,-2,-2);	
        instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);
        instruct_25(29,43,29,32) --主角移动
		instruct_1(150,86,0) -- 阿珂 。。。。。。
		instruct_0()
		instruct_1(334,225,1)
		instruct_0()
		instruct_1(335,0,1)
		instruct_0()
		instruct_1(336,229,0)
		instruct_0()
		instruct_1(337,150,0)
		instruct_0()
		instruct_1(338,139,0)
		instruct_0()
		instruct_1(339,229,0)
		instruct_0()
		instruct_1(340,150,0)
		instruct_0()
		instruct_1(341,229,0)
		instruct_0()
		instruct_1(342,139,0)
		instruct_0()
		instruct_1(343,229,0)
		instruct_0()
		instruct_1(344,139,0)
		instruct_0()
		instruct_1(345,0,1)
		instruct_0()
		instruct_1(346,150,0)
		instruct_0()
		instruct_1(347,229,0)
		instruct_0()
		instruct_1(348,225,1)
		instruct_0()
		
		if instruct_6(136,4,0,0) ==false then    --  6(6):战斗[146]是则跳转到:Label1
            instruct_15(0);   --  15(F):战斗失败，死亡
            do return; end
        end

		instruct_19(27,33)
		instruct_40(1)
		instruct_17(-2,1,27,31,8256)
		instruct_0();   --  14(E):场景变黑
        instruct_13();   --  13(D):重新显示场景
		instruct_1(349,225,1)
		instruct_0()
		instruct_1(350,86,0) 
		instruct_0()
		instruct_1(351,225,1)
		instruct_0()
		instruct_1(352,86,0)  
		instruct_0()
		instruct_1(353,225,1) 
		instruct_0()
		instruct_1(354,86,0) 
		instruct_0()
		instruct_1(355,225,1) 
		instruct_0()
		instruct_1(356,139,0)
		instruct_0()
		instruct_1(357,86,0) 
		instruct_0()
		instruct_1(358,139,0)
		instruct_0()
		instruct_1(359,225,1) 
		instruct_0()
		instruct_1(360,86,0) 
		instruct_0()
		instruct_1(150,139,0)
		instruct_0()
		instruct_1(361,225,1) 
		instruct_0()
		instruct_1(362,86,0) 
		instruct_0()
		instruct_1(363,139,0)
		instruct_0()
		instruct_1(364,225,1) 
		instruct_0()
		instruct_14()
		instruct_3(-2,2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
	    instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
	    instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [15]
		instruct_0();   --  14(E):场景变黑
        instruct_13();   --  13(D):重新显示场景
		instruct_1(365,225,1) 
		instruct_0()
		instruct_1(366,229,0) 
		instruct_0()
		    if instruct_43(228,54,0) == false then
			   instruct_2(228,1)
			   instruct_0()
		       instruct_1(367,0,1)
		       instruct_0()
			   instruct_1(368,229,0) 
		       instruct_0()
			   instruct_1(369,225,1) 
		       instruct_0()
			   instruct_1(370,229,0) 
		       instruct_0()
			   instruct_1(371,0,1)
		       instruct_0()
			   instruct_14()
			   instruct_3(-2,0,0,0,0,0,0,0,0,0,0,0,0)
			   instruct_17(-2,1,27,31,0)
			   instruct_0();   --  14(E):场景变黑
               instruct_13();   --  13(D):重新显示场景
			   instruct_0()
			 	do return; end
            end
		instruct_26(1,10,1,0,0)	
		instruct_26(1,7,1,0,0)
        instruct_1(372,225,1) 
		instruct_0()
		instruct_2(229,1)
		instruct_32(228,-1)
		instruct_1(367,0,1)
		       instruct_0()
			   instruct_1(368,229,0) 
		       instruct_0()
			   instruct_1(369,225,1) 
		       instruct_0()
			   instruct_1(370,229,0) 
		       instruct_0()
			   instruct_1(371,0,1)
		       instruct_0()
			   instruct_14()
			   instruct_3(-2,0,0,0,0,0,0,0,0,0,0,0,0)
			   instruct_17(-2,1,27,31,0)
			   instruct_3(69,11,1,0,90,0,0,8256,8256,8256,-2,-2,-2)
			   instruct_3(69,10,1,0,91,0,0,7036,7036,7036,-2,-2,-2)
			   instruct_3(69,12,1,0,92,0,0,7030,7030,7030,-2,-2,-2)
			   instruct_0();   --  14(E):场景变黑
               instruct_13();   --  13(D):重新显示场景
			   instruct_1(388,225,1)
			   instruct_0()
			   instruct_0()
			   instruct_21(664)
			   setteam(664, 0)
		    do return; end
        end
end

OEVENTLUA[214] = function()
    instruct_1(479,0,1);  --这上面似乎记载着使用这柄*重剑的法门，不知是谁刻的*？
	instruct_0()
	if instruct_16(35,0,263) == true then --判断令狐冲是否在队
	    instruct_1(4100,35,0);   
        instruct_0(); 
	
		if instruct_16(58,0,130) == true then --判断杨过是否在队
		instruct_1(4101,58,0);
        instruct_0();		
		instruct_1(4102,35,0);   
        instruct_0();
		instruct_1(4103,58,0);
		instruct_0();
		instruct_1(4104,0,0);
		instruct_0();
		instruct_14()
	    instruct_3(-2,13,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
	    instruct_3(-2,14,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
	    instruct_3(-2,15,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [15]
	    instruct_3(-2,16,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [16]
	    instruct_3(-2,17,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [17]
    	instruct_0();   --  14(E):场景变黑
        instruct_13();   --  13(D):重新显示场景
	    instruct_0();   --  0(0)::空语句(清屏)
	    instruct_1(4105,35,0);
	    instruct_0();   --  0(0)::空语句(清屏)
	    instruct_1(4106,58,0);
        instruct_0();
	    instruct_47(35,50);
	    instruct_35(35,1,45,0);
	    instruct_45(58,50);
	    instruct_35(58,1,47,0);
	    instruct_0();   --  0(0)::空语句(清屏)
	    instruct_2(116,1); 
	    instruct_0();   --  0(0)::空语句(清屏)
	    instruct_1(4107,0,0); 
	    instruct_0();   --  0(0)::空语句(清屏)
        do return; end
		end
	instruct_1(4108,0,0); 
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(4109,35,0); 
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(4110,0,0); 
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(4111,35,0);
	instruct_3(-2,13,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
	instruct_3(-2,14,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
	instruct_3(-2,15,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [15]
	instruct_3(-2,16,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [16]
	instruct_3(-2,17,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [17]
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(4112,0,0); 
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_2(116,1);   --  
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(4116,35,0);	
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(4113,0,0); 
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(4114,35,0);	
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(4115,35,0);
    instruct_35(35,1,45,0);	
	instruct_0();   --  0(0)::空语句(清屏)
            do return; end
		end
	instruct_1(4117,0,0);
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_2(116,1);   --  
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_3(-2,13,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
	instruct_3(-2,14,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
	instruct_3(-2,15,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [15]
	instruct_3(-2,16,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [16]
	instruct_3(-2,17,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [17]
    instruct_0();   --  0(0)::空语句(清屏)
end

OEVENTLUA[255] = function() 
    instruct_3(-2,12,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
    instruct_3(-2,13,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
    instruct_3(-2,14,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_13();   --  13(D):重新显示场景
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(720,165,0);   --  1(1):[???]说: 他应该已经睡了吧？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(721,81,0);   --  1(1):[???]说: 肯定睡下了，这小鬼每天这*个时候都会睡的很香。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(717,165,0);   --  1(1):[???]说: 真儿，我们这场戏一定要做*的真，不能让他起丝毫的疑*心。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(718,81,0);   --  1(1):[???]说: 爹，你就放心吧。你看我这*些天伺候那小鬼，他已对我*神魂颠倒，一点都不怀疑，*呵呵呵……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(719,165,0);   --  1(1):[???]说: 恩，明天咱们就出发，前往*冰火岛。武林中人梦寐以求*的屠龙宝刀就要成为我朱长*龄的了，哈哈哈……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(722,0,1);   --  1(1):[AAA]说: ＜原来他们父女诱骗张无忌*，是为了屠龙刀啊，我是不*是该通知张无忌呢？＞
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_11(0,22) ==true then    --  11(B):是否住宿否则跳转到:Label0
        instruct_37(1);   --  37(25):增加道德1
        instruct_1(723,0,1);   --  1(1):[AAA]说: 我去找找无忌吧
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_3(-2,3,-2,0,256,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
        do return; end
    end    --:Label0

    instruct_37(-2);   --  37(25):增加道德-2
    instruct_1(724,0,1);   --  1(1):[AAA]说: ＜都说这屠龙宝刀是武林至*尊，说不定和天书有关，我*不妨看看这场戏，说不定能*得到什么好处……＞
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(725,165,0);   --  1(1):[???]说: 什么人！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [11]
    instruct_3(-2,18,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [18]
    instruct_3(-2,19,0,0,0,0,0,5752,5752,5752,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [19]
    instruct_3(-2,20,0,0,0,0,0,7026,7026,7026,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [20]
    instruct_3(-2,22,0,0,0,0,0,5284,5284,5284,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [22]
    instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [10]
    instruct_40(0);   --  40(28):改变主角站立方向0
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(726,165,0);   --  1(1):[???]说: 你是何人？要坏我的好事么*？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(727,0,1);   --  1(1):[AAA]说: 没有没有。误会误会，我是*想和你们一起干。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(728,165,0);   --  1(1):[???]说: 哼！宝刀只有一个，你还想*分一半么？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(729,0,1);   --  1(1):[AAA]说: 我不是要宝刀……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(730,9,0);   --  1(1):[张无忌]说: 啊……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(731,81,0);   --  1(1):[???]说: 不好，是无忌，他好像听到*了我们谈话，往山那边跑了
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(732,165,0);   --  1(1):[???]说: 快追！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,19,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [19]
    instruct_3(-2,20,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [20]
    instruct_3(-2,22,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [22]
    instruct_3(-2,5,0,0,0,0,0,5752,5752,5752,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [5]
    instruct_3(-2,6,0,0,0,0,0,7026,7026,7026,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
    instruct_3(-2,7,0,0,0,0,0,5284,5284,5284,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [7]
    instruct_19(44,19);   --  19(13):主角移动至2C-13
    instruct_40(0);   --  40(28):改变主角站立方向0
    instruct_25(44,17,44,17);   --  25(19):场景移动44-17--44-17
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(733,9,0);   --  1(1):[张无忌]说: 你们，你们居然骗我……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(734,81,0);   --  1(1):[???]说: 好弟弟，快过来，姐姐疼你
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(735,9,0);   --  1(1):[张无忌]说: 不要，你们不要过来，你们*……啊……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(736,0,1);   --  1(1):[AAA]说: 小心悬崖！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(737,165,0);   --  1(1):[???]说: 我的宝刀，你不能死，我…*…啊……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(738,81,0);   --  1(1):[???]说: 爹——！ 
	   say("糟糕，屠龙刀必定和天书有关，我不能就这么放弃！")
	if yesno("要跳下去吗？") then
	   say("啊～！")
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,5,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [5]
    instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [7]
    instruct_3(-2,6,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
    instruct_3(-2,23,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [23]
    instruct_3(68,3,1,0,5011,0,0,5412,5412,5412,-2,-2,-2);   --  3(3):修改事件定义:场景[崑仑派]:场景事件编号 [3]
    instruct_3(68,13,1,0,5011,0,0,5412,5412,5412,-2,-2,-2);   --  3(3):修改事件定义:场景[崑仑派]:场景事件编号 [13]
	instruct_3(68,7,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:场景[崑仑派]:场景事件编号 [7]
    instruct_3(11,106,0,0,0,0,5014,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[光明顶]:场景事件编号 [106]
    instruct_3(11,107,0,0,0,0,5014,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[光明顶]:场景事件编号 [107]
    instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
	instruct_3(4,4,1,0,5012,0,0,2715*2,2715*2,2715*2,-2,26,14);   --  3(3):修改事件定义:场景[崑仑]:场景事件编号 [4]
	instruct_3(4,5,1,0,5012,0,0,2720*2,2720*2,2720*2,-2,24,14);   --  3(3):修改事件定义:场景[崑仑]:场景事件编号 [5]
	instruct_3(4,1,1,0,5013,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[崑仑]:场景事件编号 [1]
	JY.Scene[4]["进入条件"] = 0
    My_Enter_SubScene(4,20,15,2)
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
	instruct_27(-1,3013*2,3018*2)
	   do return; end
    end
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,5,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [5]
    instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [7]
    instruct_3(-2,6,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
    instruct_3(-2,23,0,0,0,0,0,7026,7026,7026,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [23]
    instruct_19(45,18);   --  19(13):主角移动至2D-12
    instruct_40(1);   --  40(28):改变主角站立方向1
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(739,81,0);   --  1(1):[???]说: 爹爹……为了抓那个小鬼，*自己也坠入山崖……爹爹…*…
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(740,244,1);   --  1(1):[???]说: 朱姑娘，不要难过了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(741,81,0);   --  1(1):[???]说: 又不是你没了父亲，你当然*不难过了！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(742,0,1);   --  1(1):[AAA]说: 我们去找找他们吧。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(743,81,0);   --  1(1):[???]说: 我从今后就孤苦伶仃一个人*了……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(744,244,1);   --  1(1):[???]说: 朱姑娘，跟我一起走吧，去*这附近的山谷找一找，说不*定令尊吉人天相……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(745,81,0);   --  1(1):[???]说: 呜呜……*好吧……*这悬崖下面应该是昆仑山谷*，说不定昆仑派会有人见到*。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(746,0,1);   --  1(1):[AAA]说: ＜没找到天书，得到了美女*，也不错啊……＞
    instruct_3(68,3,1,0,257,0,0,5412,5412,5412,-2,-2,-2);   --  3(3):修改事件定义:场景[崑仑派]:场景事件编号 [3]
    instruct_3(68,13,1,0,257,0,0,5412,5412,5412,-2,-2,-2);   --  3(3):修改事件定义:场景[崑仑派]:场景事件编号 [13]
    instruct_3(11,106,0,0,0,0,290,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[光明顶]:场景事件编号 [106]
    instruct_3(11,107,0,0,0,0,290,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[光明顶]:场景事件编号 [107]
    instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
    instruct_3(33,23,0,0,0,0,309,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [23]
    instruct_3(33,24,0,0,0,0,309,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [24]
    instruct_3(33,25,0,0,0,0,309,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [25]
    instruct_3(33,27,0,0,0,0,309,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [27]
    instruct_3(33,26,0,0,0,0,309,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [26]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_3(104,62,1,0,982,0,0,7026,7026,7026,-2,-2,-2);   --  3(3):修改事件定义:场景[钓鱼岛]:场景事件编号 [62]
	if GetS(106, 5, 1, 1) ~= -1 then
		SetS(106, 5, 1, 1, 2)
		SetS(28, 16, 12, 3, 99)
		instruct_3(28,99,1,0,31030,0,0,5374,5374,5374,-2,-2,-2); 		
	else
		SetS(106, 5, 1, 1, 1)
	end
    if instruct_20(21,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label1
        instruct_14();   --  14(E):场景变黑
        instruct_3(-2,23,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [23]
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_10(81);   --  10(A):加入人物[朱九真]
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label1

    instruct_1(12,81,0);   --  1(1):[???]说: 你的队伍已满，我就直接去*小村吧。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,23,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [23]
    instruct_3(70,46,1,0,177,0,0,7026,7026,7026,-2,-2,-2);   --  3(3):修改事件定义:场景[小村]:场景事件编号 [46]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
end

OEVENTLUA[285] = function()
    instruct_26(40,9,4,0,0);   --  
	instruct_26(40,10,4,0,0);   --  
	instruct_26(40,12,4,0,0);   --  
	instruct_1(954,0,1);--:谢前辈，*这是成崑的项上人头。*成崑作恶多端已遭天谴。
	instruct_0();
	instruct_1(955,13,0);--是吗？哈！哈！*成崑啊，成崑！*你作恶多端终遭天谴，*但，可惜啊，可惜！*我不能亲手杀了你。
	instruct_0();
	instruct_1(956,0,1);
	instruct_0();
	instruct_1(957,13,0);
	instruct_0();
	instruct_2(155,1);
	instruct_0();
	if PersonKF(zj(),92) and GetS(111, 0, 0, 0) == 0 then
	   say("谢某无以为报，只有一门狮吼功可传与少侠，少侠可愿意？",13) 
	   instruct_0();
	   	if instruct_11(0,188) == true then
	       QZXS("领悟狮子王吼！")
	       instruct_0();
	       say("多谢谢法王",0) 
	       SetS(111, 0, 0, 0,92)
		else
			say("法王客气了，小子受之有愧",0) 
		end
	instruct_3(-2,-2,1,0,287,0,0,-2,-2,-2,-2,-2,-2); 	
    do return; end
    end
    instruct_3(-2,-2,1,0,287,0,0,-2,-2,-2,-2,-2,-2);
end

OEVENTLUA[268] = function() 
    instruct_14();   --  14(E):场景变黑
    instruct_37(5);   --  37(25):增加道德5
    instruct_26(40,9,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_26(40,10,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_26(40,12,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_39(72);   --  39(27):打开场景冰火岛
    instruct_3(33,2,1,0,1062,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [2]
    instruct_3(34,0,1,0,1066,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[崆峒派]:场景事件编号 [0]
    instruct_13();   --  13(D):重新显示场景
    instruct_25(29,47,29,36);   --  25(19):场景移动29-47--29-36
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(794,8,0);   --  1(1):[唐文亮]说: 魔教已然一败涂地，再不投*降，还待怎的？空闻大师，*咱们这便去毁了魔教三十三*代教主的牌位吧！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(795,7,0);   --  1(1):[何太冲]说: 什麽投不投降？*魔教之众，*今日不能留下任何活口。*除恶务尽，*否则他日死灰复燃，*又将为害江湖。*魔崽子们！*识时务的快快自我了断，*省得大爷们动手。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(796,169,0);   --  1(1):[???]说: 华山派和崆峒派各位，*请将顶上的魔教余孽一概诛*灭了。*武当派从西往东搜索，峨嵋*派从东往西搜索，别让魔教*有一人漏网。*崑仑派预备火种，焚烧魔教*巢穴。**少林弟子各取法器，诵念往*生经文，替六派殉难英雄，*魔教教众超渡，化除冤孽。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_30(29,48,29,38);   --  30(1E):主角走动29-48--29-38
    instruct_1(797,0,1);   --  1(1):[AAA]说: 哇！这里这麽多人，干什麽*这麽热闹，可少不了小侠我*。我说名门正派又怎麽样，*还不是一样赶尽杀绝，跟魔*教又有什麽两样，只不过藉*口好听一点罢了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(798,169,0);   --  1(1):[???]说: 少侠非魔教人士，*还请速速离去，*以免受池鱼之殃。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(799,0,1);   --  1(1):[AAA]说: 那好，大家都别打了，因为*这中间着实有许多误会，*让我好好说给你们听。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(800,6,0);   --  1(1):[灭绝]说: 现在年轻人都这麽狂妄吗？*你自以为是武林盟主吗！*要我们听你说。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(801,8,0);   --  1(1):[唐文亮]说: 你这小贼，跟魔教勾结，*想要拖延时间，好施什麽诡*计麽？先杀了你再说。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(802,0,1);   --  1(1):[AAA]说: 我就知道要你们安安静静听*我说是不太可能，那只有想*办法让你们服气了。*哪一派先来？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(803,7,0);   --  1(1):[何太冲]说: 好狂妄的口气，我昆仑派就*来领教阁下高招！
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_20(1511,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label0
        instruct_1(858,9,0);   --  1(1):[张无忌]说: 我来帮你！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_0();   --  0(0)::空语句(清屏)

        if instruct_6(146,3,0,0) ==false then    --  6(6):战斗[146]是则跳转到:Label1
            instruct_15(0);   --  15(F):战斗失败，死亡
            do return; end
        end    --:Label1

        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_1(804,109,0);   --  1(1):[???]说: 看我华山派的。
        instruct_0();   --  0(0)::空语句(清屏)

        if instruct_6(147,3,0,0) ==false then    --  6(6):战斗[147]是则跳转到:Label2
            instruct_15(0);   --  15(F):战斗失败，死亡
            do return; end
        end    --:Label2

        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_2(142,1);   --  2(2):得到物品[反两仪刀法][1]
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(805,8,0);   --  1(1):[唐文亮]说: 让你尝尝我崆峒七伤拳的厉*害
        instruct_0();   --  0(0)::空语句(清屏)

        if instruct_6(148,3,0,0) ==false then    --  6(6):战斗[148]是则跳转到:Label3
            instruct_15(0);   --  15(F):战斗失败，死亡
            do return; end
        end    --:Label3

        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
		
		if MPPD(0) == 5 then
			Cls()
			say("师侄，你也要和我过招么？",170,0,"空见") 	
			Cls()
			say("弟子不敢，只恳请师叔带众师兄弟离开此处。弟子日后一定会给师叔一个交待的。") 
			Cls()
			say("唉，罢了。",170,0,"空见") 
			say("师侄，这是师叔的毕生绝学，现传授与你",170,0,"空见") 
			say("你好自为之，切莫与奸邪同流合污",170,0,"空见") 
			instruct_2(92,1);   --  2(2):得到物品[龙爪手][1]
			say("弟子谨记师叔教诲。")
			say("阿弥陀佛",170,0,"空见") 
			dark()
			light()				
		else
			instruct_1(806,170,0);   --  1(1):[???]说: 少侠武功盖世，老衲前来领*教一二。
			instruct_0();   --  0(0)::空语句(清屏)

			if instruct_6(149,3,0,0) ==false then    --  6(6):战斗[149]是则跳转到:Label4
				instruct_15(0);   --  15(F):战斗失败，死亡
				do return; end
			end    --:Label4

			instruct_0();   --  0(0)::空语句(清屏)
			instruct_13();   --  13(D):重新显示场景
			instruct_2(92,1);   --  2(2):得到物品[龙爪手][1]
		end
		
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(807,6,0);   --  1(1):[灭绝]说: 小子，你以为你是武林盟主*吗？就算你有屠龙刀在手，*还要问问我手上的倚天剑答*不答应！
        instruct_0();   --  0(0)::空语句(清屏)

        if instruct_6(150,3,0,0) ==false then    --  6(6):战斗[150]是则跳转到:Label5
            instruct_15(0);   --  15(F):战斗失败，死亡
            do return; end
        end    --:Label5

        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_1(808,6,0);   --  1(1):[灭绝]说: 现在就看武当派的了。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(809,171,0);   --  1(1):[???]说: 这个……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(810,9,0);   --  1(1):[张无忌]说: 大师伯，你们别打了。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(811,171,0);   --  1(1):[???]说: 你，你，你是无忌！你是我*五弟的儿子张无忌！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(812,9,0);   --  1(1):[张无忌]说: 大师伯，是我，太师父他老*人家还好吧？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(813,171,0);   --  1(1):[???]说: 好，好，孩子，你身上的寒*毒好了吗？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(814,9,0);   --  1(1):[张无忌]说: 谢谢大师伯挂怀，我想已经*好了吧。大师伯，六大派和*明教，这其中确有不少误会*，你们不要再打了。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(815,171,0);   --  1(1):[???]说: 什么误会？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(816,9,0);   --  1(1):[张无忌]说: 就让这位少侠来说吧。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(817,0,1);   --  1(1):[AAA]说: 事情的经过是这样的。。。*如此如此。。。。。。。。*这般这般。。。。。。。。*总之，一切的阴谋，*都是成崑那奸贼所计划的。**所以我说呢，你们两方还是*握手言和吧，反正明教杀过*六大派的人，六大派也杀过*明教的人，大家半斤八两，*差不了多少，就都罢手吧。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(818,8,0);   --  1(1):[唐文亮]说: 话都是你在说的，*是不是真的，*我们怎麽知道。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(819,6,0);   --  1(1):[灭绝]说: 武当派既认亲，看来这次六*大派围攻光明顶是一败涂地*了，我们走！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(820,169,0);   --  1(1):[???]说: 阿弥陀佛。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(821,7,0);   --  1(1):[何太冲]说: 哼！技不如人，*说这麽多做什麽，*走吧！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(822,171,0);   --  1(1):[???]说: 无忌，还有这位少侠，今日*你们救了明教，今后要多所*规劝引导，总要使明教改邪*归正，少做坏事。*我们走吧。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_14();   --  14(E):场景变黑
        instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [7]
        instruct_3(-2,8,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [8]
        instruct_3(-2,31,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [31]
        instruct_3(-2,30,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [30]
        instruct_3(-2,29,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [29]
        instruct_3(-2,28,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [28]
        instruct_3(-2,27,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
        instruct_3(-2,26,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [26]
        instruct_3(-2,25,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [25]
        instruct_3(-2,24,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [24]
        instruct_3(-2,23,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [23]
        instruct_3(-2,22,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [22]
        instruct_3(-2,21,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [21]
        instruct_3(-2,20,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [20]
        instruct_3(-2,19,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [19]
        instruct_3(-2,18,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [18]
        instruct_3(-2,17,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [17]
        instruct_3(-2,16,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [16]
        instruct_3(-2,15,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [15]
        instruct_3(-2,14,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
        instruct_3(-2,13,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
        instruct_3(-2,12,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
        instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [11]
        instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [10]
        instruct_3(-2,9,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [9]
        instruct_3(-2,79,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [79]
        instruct_3(-2,70,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [70]
        instruct_3(-2,69,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [69]
        instruct_3(-2,68,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [68]
        instruct_3(-2,67,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [67]
        instruct_3(-2,66,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [66]
        instruct_3(-2,65,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [65]
        instruct_3(-2,64,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [64]
        instruct_3(-2,63,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [63]
        instruct_3(-2,62,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [62]
        instruct_3(-2,61,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [61]
        instruct_3(-2,60,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [60]
        instruct_3(-2,59,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [59]
        instruct_3(-2,58,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [58]
        instruct_3(-2,57,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [57]
        instruct_3(-2,56,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [56]
        instruct_3(-2,55,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [55]
        instruct_3(-2,54,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [54]
        instruct_3(-2,53,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [53]
        instruct_3(-2,52,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [52]
        instruct_3(-2,51,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [51]
        instruct_3(-2,50,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [50]
        instruct_3(-2,49,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [49]
        instruct_3(-2,48,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [48]
        instruct_3(-2,47,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [47]
        instruct_3(-2,46,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [46]
        instruct_3(-2,45,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [45]
        instruct_3(-2,44,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [44]
        instruct_3(-2,43,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [43]
        instruct_3(-2,42,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [42]
        instruct_3(-2,41,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [41]
        instruct_3(-2,40,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [40]
        instruct_3(-2,39,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [39]
        instruct_3(-2,38,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [38]
        instruct_3(-2,37,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [37]
        instruct_3(-2,36,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [36]
        instruct_3(-2,35,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [35]
        instruct_3(-2,34,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [34]
        instruct_3(-2,33,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [33]
        instruct_3(-2,32,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [32]
        instruct_3(-2,84,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [84]
        instruct_3(-2,83,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [83]
        instruct_3(-2,82,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [82]
        instruct_3(-2,81,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [81]
        instruct_3(-2,80,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [80]
        instruct_3(-2,96,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [96]
        instruct_3(-2,99,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [99]
        instruct_3(-2,98,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [98]
        instruct_3(-2,97,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [97]
        instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
        instruct_3(-2,5,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [5]
        instruct_3(-2,4,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [4]
        instruct_3(-2,6,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
        instruct_3(-2,108,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [108]
        instruct_3(-2,104,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [104]
        instruct_3(-2,110,1,0,272,0,0,5334,5334,5334,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [110]
        instruct_3(-2,109,1,0,270,280,0,5284,5284,5284,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [109]
        instruct_19(28,17);   --  19(13):主角移动至1C-11
        instruct_25(28,15,28,15);   --  25(19):场景移动28-15--28-15
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_1(823,14,0);   --  1(1):[韦一笑]说: 你们两个小子，还不赖嘛！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(824,10,0);   --  1(1):[范遥]说: 蝠王，不可无礼。明教全教*下上，叩谢少侠和张公子护*教救命的大恩！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(825,0,1);   --  1(1):[AAA]说: 快别这麽说，仗义行侠，本*就是我辈中人应当做的。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(826,14,0);   --  1(1):[韦一笑]说: 你们也别这麽客套了。这样*吧，大家听我一言，我说呢*，这位少侠武功盖世义薄云*天，於本教有存亡续绝的大*恩。咱们拥立他为本教第三*十四任教主。由他来做教主*，总比你来做教主好吧，杨*左使，你说对不对啊。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(827,11,0);   --  1(1):[杨逍]说: 是啊！*这位少侠来做我们教主，*也比你韦一笑来做好的多。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(828,14,0);   --  1(1):[韦一笑]说: 你。。。。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(829,12,0);   --  1(1):[殷天正]说: 你们两个别在那里吵了，丢*人现眼的。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(830,247,1);   --  1(1):[???]说: 不，不，我仍有要事在身，*这个教主是无论如何不能当*的。*＜南贤老头说我有什么天命*在身，听起来比这个教主可*威风多了。＞
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(831,10,0);   --  1(1):[范遥]说: 少侠如果一直推却不肯，我*们明教恐怕又要为此争闹不*休，四分五裂，到时又会被*其他门派围攻，导致灭亡了*。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(832,0,1);   --  1(1):[AAA]说: 我这里有封阳教主的遗书，*上面提到要谢逊谢法王暂代*教主之职。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(833,10,0);   --  1(1):[范遥]说: 可是谢法王至今杳无音信，*明教却不可一日无主啊。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(834,9,0);   --  1(1):[张无忌]说: 我义父应该在冰火岛，咱们*去找他吧。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(835,0,1);   --  1(1):[AAA]说: 我倒有个主意。这位张公子*，今日也可算是明教的恩人*。他是鹰王的外孙，可算是*明教自己人。他还是狮王的*义子，就算狮王做了教主，*子继父业也是理所当然。而*且张公子似乎另有奇遇，武*功卓绝，这个明教教主，再*合适不过了。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(836,14,0);   --  1(1):[韦一笑]说: 少侠此言有理，我韦一笑第*一个赞成！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(837,9,0);   --  1(1):[张无忌]说: 我，我，我不行的……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(838,11,0);   --  1(1):[杨逍]说: 我赞成！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(839,10,0);   --  1(1):[范遥]说: 我也赞成！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(840,12,0);   --  1(1):[殷天正]说: 无忌，你就不要推辞了，难*道你连外公的话都不听吗？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(841,9,0);   --  1(1):[张无忌]说: 我……好吧……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(842,11,0);   --  1(1):[杨逍]说: 明教光明左使杨逍
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(843,10,0);   --  1(1):[范遥]说: 光明右使范遥
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(844,12,0);   --  1(1):[殷天正]说: 白眉鹰王殷天正
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(845,14,0);   --  1(1):[韦一笑]说: 青翼蝠王韦一笑
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(846,0,2);   --  1(1):[AAA]说: 明教众人：*        参见教主！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(847,9,0);   --  1(1):[张无忌]说: 使不得，使不得，你们快起*来……
		JoinMP(9,13,5)
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_14();   --  14(E):场景变黑
        instruct_13();   --  13(D):重新显示场景
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(848,0,1);   --  1(1):[AAA]说: 另外还有一件事拜托你们，*你们明教中是否有一本叫*《倚天屠龙记》的书？*是否能借我一下。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(849,11,0);   --  1(1):[杨逍]说: 有的。这是我明教镇教之宝*，历来由专人掌管。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(850,247,1);   --  1(1):[???]说: 是吗？真的有。皇天不负苦*心人，打了这麽多场仗，终*於让我找到了。不知是哪位*掌管此书？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(851,10,0);   --  1(1):[范遥]说: 金毛狮王谢逊！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(852,0,1);   --  1(1):[AAA]说: 张公子，你知道你义父所在*吧，咱们去找他吧。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(853,9,0);   --  1(1):[张无忌]说: 好啊，我一直想把义父接回*来。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(854,11,0);   --  1(1):[杨逍]说: 可是，现在明教大敌刚去，*有许多事情需要教主安排，*教主你不能轻离光明顶啊。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(855,9,0);   --  1(1):[张无忌]说: 杨左使此言有理。那就拜托*少侠去找寻我义父吧，他就*在极北的冰火岛。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(856,0,1);   --  1(1):[AAA]说: 好，那我这就去寻找谢法王*。各位，告辞了。
        instruct_0();   --  0(0)::空语句(清屏)
			if GetS(111, 0, 0, 0) == 0 and PersonKF(zj(),97) then
		 say("少侠请留步。",9);
		 say("少侠为义父的事如此奔波，我十分感动。",9); 
		 say("看少侠也学过乾坤大挪移，不如和我一起探讨一下。",9); 
				if instruct_11(0,188) == true then
				     say("来吧，张工子！",0) 
					 instruct_0();
	                 QZXS("领悟明尊白莲大法！")
					 QZXS("张无忌成为白莲至尊！")
					 setJX(9,1)
	                 instruct_0();
	                 setLW(97)
				else
				     say("算了，不学也罢！",0) 
					 say("少侠请一路小心！",9) 
					 instruct_0()
				end	
			end
        instruct_1(857,9,0);   --  1(1):[张无忌]说: 少侠慢走。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_3(-2,0,0,0,0,0,274,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
        do return; end
    end    --:Label0


    if instruct_6(9,3,0,0) ==false then    --  6(6):战斗[9]是则跳转到:Label6
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
    end    --:Label6

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(804,109,0);   --  1(1):[???]说: 看我华山派的。
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(11,3,0,0) ==false then    --  6(6):战斗[11]是则跳转到:Label7
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
    end    --:Label7

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_2(142,1);   --  2(2):得到物品[反两仪刀法][1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(805,8,0);   --  1(1):[唐文亮]说: 让你尝尝我崆峒七伤拳的厉*害
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(12,3,0,0) ==false then    --  6(6):战斗[12]是则跳转到:Label8
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
    end    --:Label8

	if MPPD(0) == 5 then
		Cls()
		say("师侄，你也要和我过招么？",170,0,"空见") 	
		Cls()
		say("弟子不敢，只恳请师叔带众师兄弟离开此处。弟子日后一定会给师叔一个交待的。") 
		Cls()
		say("唉，罢了。",170,0,"空见") 
		dark()
		light()
	else
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
		instruct_1(806,170,0);   --  1(1):[???]说: 少侠武功盖世，老衲前来领*教一二。
		instruct_0();   --  0(0)::空语句(清屏)

		if instruct_6(149,3,0,0) ==false then    --  6(6):战斗[149]是则跳转到:Label9
			instruct_15(0);   --  15(F):战斗失败，死亡
			do return; end
		end    --:Label9

		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
		instruct_2(92,1);   --  2(2):得到物品[龙爪手][1]
	end
	
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(807,6,0);   --  1(1):[灭绝]说: 小子，你以为你是武林盟主*吗？就算你有屠龙刀在手，*还要问问我手上的倚天剑答*不答应！
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(150,3,0,0) ==false then    --  6(6):战斗[150]是则跳转到:Label10
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
    end    --:Label10

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(808,6,0);   --  1(1):[灭绝]说: 现在就看武当派的了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(809,171,0);   --  1(1):[???]说: 这个……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(810,9,0);   --  1(1):[张无忌]说: 大师伯，你们别打了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(811,171,0);   --  1(1):[???]说: 你，你，你是无忌！你是我*五弟的儿子张无忌！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(812,9,0);   --  1(1):[张无忌]说: 大师伯，是我，太师父他老*人家还好吧？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(813,171,0);   --  1(1):[???]说: 好，好，孩子，你身上的寒*毒好了吗？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(814,9,0);   --  1(1):[张无忌]说: 谢谢大师伯挂怀，我想已经*好了吧。大师伯，六大派和*明教，这其中确有不少误会*，你们不要再打了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(815,171,0);   --  1(1):[???]说: 什么误会？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(816,9,0);   --  1(1):[张无忌]说: 就让这位少侠来说吧。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(817,0,1);   --  1(1):[AAA]说: 事情的经过是这样的。。。*如此如此。。。。。。。。*这般这般。。。。。。。。*总之，一切的阴谋，*都是成崑那奸贼所计划的。**所以我说呢，你们两方还是*握手言和吧，反正明教杀过*六大派的人，六大派也杀过*明教的人，大家半斤八两，*差不了多少，就都罢手吧。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(818,8,0);   --  1(1):[唐文亮]说: 话都是你在说的，*是不是真的，*我们怎麽知道。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(819,6,0);   --  1(1):[灭绝]说: 武当派既认亲，看来这次六*大派围攻光明顶是一败涂地*了，我们走！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(820,169,0);   --  1(1):[???]说: 阿弥陀佛。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(821,7,0);   --  1(1):[何太冲]说: 哼！技不如人，*说这麽多做什麽，*走吧！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(822,171,0);   --  1(1):[???]说: 无忌，还有这位少侠，今日*你们救了明教，今后要多所*规劝引导，总要使明教改邪*归正，少做坏事。*我们走吧。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [7]
    instruct_3(-2,8,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [8]
    instruct_3(-2,31,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [31]
    instruct_3(-2,30,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [30]
    instruct_3(-2,29,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [29]
    instruct_3(-2,28,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [28]
    instruct_3(-2,27,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
    instruct_3(-2,26,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [26]
    instruct_3(-2,25,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [25]
    instruct_3(-2,24,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [24]
    instruct_3(-2,23,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [23]
    instruct_3(-2,22,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [22]
    instruct_3(-2,21,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [21]
    instruct_3(-2,20,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [20]
    instruct_3(-2,19,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [19]
    instruct_3(-2,18,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [18]
    instruct_3(-2,17,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [17]
    instruct_3(-2,16,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [16]
    instruct_3(-2,15,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [15]
    instruct_3(-2,14,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
    instruct_3(-2,13,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
    instruct_3(-2,12,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
    instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [11]
    instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [10]
    instruct_3(-2,9,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [9]
    instruct_3(-2,79,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [79]
    instruct_3(-2,70,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [70]
    instruct_3(-2,69,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [69]
    instruct_3(-2,68,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [68]
    instruct_3(-2,67,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [67]
    instruct_3(-2,66,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [66]
    instruct_3(-2,65,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [65]
    instruct_3(-2,64,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [64]
    instruct_3(-2,63,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [63]
    instruct_3(-2,62,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [62]
    instruct_3(-2,61,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [61]
    instruct_3(-2,60,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [60]
    instruct_3(-2,59,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [59]
    instruct_3(-2,58,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [58]
    instruct_3(-2,57,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [57]
    instruct_3(-2,56,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [56]
    instruct_3(-2,55,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [55]
    instruct_3(-2,54,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [54]
    instruct_3(-2,53,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [53]
    instruct_3(-2,52,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [52]
    instruct_3(-2,51,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [51]
    instruct_3(-2,50,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [50]
    instruct_3(-2,49,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [49]
    instruct_3(-2,48,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [48]
    instruct_3(-2,47,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [47]
    instruct_3(-2,46,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [46]
    instruct_3(-2,45,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [45]
    instruct_3(-2,44,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [44]
    instruct_3(-2,43,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [43]
    instruct_3(-2,42,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [42]
    instruct_3(-2,41,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [41]
    instruct_3(-2,40,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [40]
    instruct_3(-2,39,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [39]
    instruct_3(-2,38,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [38]
    instruct_3(-2,37,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [37]
    instruct_3(-2,36,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [36]
    instruct_3(-2,35,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [35]
    instruct_3(-2,34,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [34]
    instruct_3(-2,33,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [33]
    instruct_3(-2,32,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [32]
    instruct_3(-2,84,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [84]
    instruct_3(-2,83,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [83]
    instruct_3(-2,82,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [82]
    instruct_3(-2,81,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [81]
    instruct_3(-2,80,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [80]
    instruct_3(-2,96,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [96]
    instruct_3(-2,99,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [99]
    instruct_3(-2,98,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [98]
    instruct_3(-2,97,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [97]
    instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
    instruct_3(-2,5,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [5]
    instruct_3(-2,4,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [4]
    instruct_3(-2,6,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
    instruct_3(-2,108,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [108]
    instruct_3(-2,104,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [104]
    instruct_3(-2,110,1,0,272,0,0,5334,5334,5334,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [110]
    instruct_3(-2,109,1,0,270,280,0,5284,5284,5284,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [109]
    instruct_19(28,17);   --  19(13):主角移动至1C-11
    instruct_25(28,15,28,15);   --  25(19):场景移动28-15--28-15
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(823,14,0);   --  1(1):[韦一笑]说: 你们两个小子，还不赖嘛！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(824,10,0);   --  1(1):[范遥]说: 蝠王，不可无礼。明教全教*下上，叩谢少侠和张公子护*教救命的大恩！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(825,0,1);   --  1(1):[AAA]说: 快别这麽说，仗义行侠，本*就是我辈中人应当做的。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(826,14,0);   --  1(1):[韦一笑]说: 你们也别这麽客套了。这样*吧，大家听我一言，我说呢*，这位少侠武功盖世义薄云*天，於本教有存亡续绝的大*恩。咱们拥立他为本教第三*十四任教主。由他来做教主*，总比你来做教主好吧，杨*左使，你说对不对啊。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(827,11,0);   --  1(1):[杨逍]说: 是啊！*这位少侠来做我们教主，*也比你韦一笑来做好的多。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(828,14,0);   --  1(1):[韦一笑]说: 你。。。。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(829,12,0);   --  1(1):[殷天正]说: 你们两个别在那里吵了，丢*人现眼的。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(830,247,1);   --  1(1):[???]说: 不，不，我仍有要事在身，*这个教主是无论如何不能当*的。*＜南贤老头说我有什么天命*在身，听起来比这个教主可*威风多了。＞
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(831,10,0);   --  1(1):[范遥]说: 少侠如果一直推却不肯，我*们明教恐怕又要为此争闹不*休，四分五裂，到时又会被*其他门派围攻，导致灭亡了*。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(832,0,1);   --  1(1):[AAA]说: 我这里有封阳教主的遗书，*上面提到要谢逊谢法王暂代*教主之职。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(833,10,0);   --  1(1):[范遥]说: 可是谢法王至今杳无音信，*明教却不可一日无主啊。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(834,9,0);   --  1(1):[张无忌]说: 我义父应该在冰火岛，咱们*去找他吧。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(835,0,1);   --  1(1):[AAA]说: 我倒有个主意。这位张公子*，今日也可算是明教的恩人*。他是鹰王的外孙，可算是*明教自己人。他还是狮王的*义子，就算狮王做了教主，*子继父业也是理所当然。而*且张公子似乎另有奇遇，武*功卓绝，这个明教教主，再*合适不过了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(836,14,0);   --  1(1):[韦一笑]说: 少侠此言有理，我韦一笑第*一个赞成！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(837,9,0);   --  1(1):[张无忌]说: 我，我，我不行的……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(838,11,0);   --  1(1):[杨逍]说: 我赞成！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(839,10,0);   --  1(1):[范遥]说: 我也赞成！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(840,12,0);   --  1(1):[殷天正]说: 无忌，你就不要推辞了，难*道你连外公的话都不听吗？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(841,9,0);   --  1(1):[张无忌]说: 我……好吧……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(842,11,0);   --  1(1):[杨逍]说: 明教光明左使杨逍
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(843,10,0);   --  1(1):[范遥]说: 光明右使范遥
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(844,12,0);   --  1(1):[殷天正]说: 白眉鹰王殷天正
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(845,14,0);   --  1(1):[韦一笑]说: 青翼蝠王韦一笑
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(846,0,2);   --  1(1):[AAA]说: 明教众人：*        参见教主！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(847,9,0);   --  1(1):[张无忌]说: 使不得，使不得，你们快起*来……
	JoinMP(9,13,5)
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_13();   --  13(D):重新显示场景
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(848,0,1);   --  1(1):[AAA]说: 另外还有一件事拜托你们，*你们明教中是否有一本叫*《倚天屠龙记》的书？*是否能借我一下。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(849,11,0);   --  1(1):[杨逍]说: 有的。这是我明教镇教之宝*，历来由专人掌管。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(850,247,1);   --  1(1):[???]说: 是吗？真的有。皇天不负苦*心人，打了这麽多场仗，终*於让我找到了。不知是哪位*掌管此书？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(851,10,0);   --  1(1):[范遥]说: 金毛狮王谢逊！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(852,0,1);   --  1(1):[AAA]说: 张公子，你知道你义父所在*吧，咱们去找他吧。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(853,9,0);   --  1(1):[张无忌]说: 好啊，我一直想把义父接回*来。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(854,11,0);   --  1(1):[杨逍]说: 可是，现在明教大敌刚去，*有许多事情需要教主安排，*教主你不能轻离光明顶啊。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(855,9,0);   --  1(1):[张无忌]说: 杨左使此言有理。那就拜托*少侠去找寻我义父吧，他就*在极北的冰火岛。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(856,0,1);   --  1(1):[AAA]说: 好，那我这就去寻找谢法王*。各位，告辞了。
    instruct_0();   --  0(0)::空语句(清屏)
	if GetS(111, 0, 0, 0) == 0 and PersonKF(zj(),97) then
		say("少侠请留步。",9);
		say("少侠为义父的事如此奔波，我十分感动。",9); 
		 say("看少侠也学过乾坤大挪移，不如和我一起探讨一下。",9); 
				if instruct_11(0,188) == true then
				     say("来吧，张工子！",0) 
					 instruct_0();
	                 QZXS("领悟明尊白莲大法！")
					 QZXS("张无忌成为白莲至尊！")
					 setJX(9,1)
	                 instruct_0();
	                 setLW(97)
				else
				     say("算了，不学也罢！",0) 
					 say("少侠请一路小心！",9) 
					 instruct_0()
				end	
			end
    instruct_1(857,9,0);   --  1(1):[张无忌]说: 少侠慢走。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_3(-2,0,0,0,0,0,274,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
end

OEVENTLUA[571] = function() --解决挡门乞丐bug
    instruct_1(2418,207,0);   --  1(1):[???]说: 本帮新任帮主庄聚贤，神功*盖世，即将赶赴少林，与玄*慈方丈争夺武林盟主之位！
    instruct_0();   --  0(0)::空语句(清屏)
	if MPPD(0) == 2 and hasthing(147) then
		Cls()
		say("原来是师弟来了，鲁长老已经等候多时，快请进。",207,0,"丐帮弟子")	
		dark()
		instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0)	
		light()
	end
end

OEVENTLUA[585] = function() --天龙邪线
    instruct_14();   --  14(E):场景变黑
    instruct_37(-5);   --  37(25):增加道德-5
    instruct_3(40,16,1,0,655,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[洛阳城]:场景事件编号 [16]
    instruct_3(40,15,1,0,655,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[洛阳城]:场景事件编号 [15]
    instruct_3(40,14,1,0,655,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[洛阳城]:场景事件编号 [14]
    instruct_3(40,13,1,0,655,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[洛阳城]:场景事件编号 [13]
    instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
    instruct_3(-2,26,1,0,557,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [26]
    instruct_3(-2,31,1,0,557,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [31]
    instruct_3(-2,30,1,0,557,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [30]
    instruct_3(-2,29,1,0,557,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [29]
    instruct_3(-2,28,1,0,557,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [28]
    instruct_3(-2,27,1,0,557,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
    instruct_3(-2,32,1,0,557,0,0,6268,6268,6268,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [32]
    instruct_3(-2,37,1,0,557,0,0,6268,6268,6268,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [37]
    instruct_3(-2,36,1,0,557,0,0,6268,6268,6268,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [36]
    instruct_3(-2,35,1,0,557,0,0,6268,6268,6268,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [35]
    instruct_3(-2,34,1,0,557,0,0,6268,6268,6268,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [34]
    instruct_3(-2,33,1,0,557,0,0,6268,6268,6268,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [33]
    instruct_3(-2,6,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
    instruct_3(-2,19,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [19]
    instruct_3(-2,18,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [18]
    instruct_3(-2,17,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [17]
    instruct_3(-2,16,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [16]
    instruct_3(-2,15,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [15]
    instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [11]
    instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [10]
    instruct_3(-2,9,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [9]
    instruct_3(-2,8,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [8]
    instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [7]
    instruct_3(-2,38,0,0,0,0,0,6152,6152,6152,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [38]
    instruct_3(-2,39,0,0,0,0,0,5132,5132,5132,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [39]
    instruct_3(-2,40,0,0,0,0,0,7130,7130,7130,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [40]
    instruct_3(-2,41,0,0,0,0,0,5136,5136,5136,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [41]
    instruct_3(-2,42,0,0,0,0,0,7990,7990,7990,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [42]
    instruct_3(-2,43,0,0,0,0,0,6298,6298,6298,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [43]
    instruct_3(-2,12,1,0,591,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
    instruct_3(-2,13,1,0,591,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
	SetS(51, 16, 31, 3, 99)
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_30(39,30,16,29);   --  30(1E):主角走动39-30--16-29
    instruct_40(2);   --  40(28):改变主角站立方向2
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_32(216,-1);   --  32(20):物品[带头大哥书信]+[-1]
    instruct_1(2530,51,0);   --  1(1):[AAA]说: 乔峰，你看这是什麽？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2531,50,0);   --  1(1):[乔峰]说: 是什麽？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2532,51,0);   --  1(1):[AAA]说: 你看了便知道。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2533,50,0);   --  1(1):[乔峰]说: 这……这是真的吗？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2534,51,0);   --  1(1):[AAA]说: 少林方丈亲笔写的，会是假*的吗！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2535,51,0);   --  1(1):[慕容复]说: 我今日请来了智光大师、谭*公、谭婆、赵钱孙等人，他*们都可以作证。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2536,50,0);   --  1(1):[乔峰]说: 我……我……*我不是汉人…………*我是契丹人…………
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2537,51,0);   --  1(1):[AAA]说: 乔峰，你是契丹人，非我族*类，其心必异，怎可担任这*丐帮帮主一职，保管《天龙*八部》一书呢！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2538,50,0);   --  1(1):[乔峰]说: 你要我怎麽做！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2539,51,0);   --  1(1):[AAA]说: 辞去丐帮帮主之位，*交出《天龙八部》一书。
	instruct_0();	
	say("好，乔某今天就辞去这丐帮帮主之位。但是《天龙八部》乃是乔某恩师的遗物，不管谁要拿书，就凭武力来抢吧！",50,0,"乔峰") 	
 	instruct_0();	
	say("（乔峰武力过人，不一定打得过啊。罢了，为了天书，拼了！）好！在下来领教乔兄高招！")
 	instruct_0();	
	say("（好机会，收揽人心，以为己助）乔兄，你是契丹英雄，视我中原豪杰有如无物，区区姑苏慕容复今日也想领教阁下高招。在下死在乔兄掌下，也算是为中原豪杰尽了一分微力，虽死犹荣。",51,0,"慕容复") 	
	instruct_0();	
	say("嘿，你们一起上来吧！",50,0,"乔峰") 	
    if DrawStrBoxYesNo(-1, -1, "我应该和慕容复联手吗？", C_WHITE, 30) == true then		
		JY.Person[53]["攻击力"] = JY.Person[53]["攻击力"]+100
		JY.Person[53]["防御力"] = JY.Person[53]["防御力"]+100
		JY.Person[53]["轻功"] = JY.Person[53]["轻功"]+100
		JY.Person[53]["武功等级1"] = 999
		JY.Person[53]["武功等级2"] = 999	
		JY.Person[50]["声望"] = 0
		
		JY.Person[51]["攻击力"] = JY.Person[51]["攻击力"]+300
		JY.Person[51]["防御力"] = JY.Person[51]["防御力"]+400
		JY.Person[51]["轻功"] = JY.Person[51]["轻功"]+300
		JY.Person[51]["生命最大值"] = JY.Person[51]["生命最大值"] + 3000	
		JY.Person[51]["内力最大值"] = JY.Person[51]["内力最大值"] + 5000		
		JY.Person[51]["生命"] = JY.Person[51]["生命最大值"]	
		JY.Person[51]["内力"] = JY.Person[51]["内力最大值"]	
		JY.Person[51]["武功等级1"] = 999		
		JY.Person[51]["声望"] = 98	
		for i = 1, 4 do
			JY.Person[50]["携带物品数量" .. i] = 0
		end
		instruct_0();	
		say("（多一个人多一份胜算）慕容兄，我们一起上！") 		
		instruct_0();	
		instruct_14()
		instruct_3(-2,99,0,0,0,0,0,6312,6312,6312,-2,-2,-2)
		instruct_13()		
		say("等等，慕容公子，你既然与乔兄齐名就应该一对一才是。乘人之危非君子所为。乔兄，我来助你！",53,0,"段誉") 	
		instruct_0();	
		say("好！没想到一位素昧平生的小兄弟愿与我共患难。从此你就是我兄弟了！兄弟，就让你我二人联手抗敌！",50,0,"乔峰") 			
		if instruct_6(260,4,0,0) ==false then 
			instruct_15(0);  
			do return; end
			instruct_0(); 
		end   		
		JY.Person[51]["攻击力"] = JY.Person[51]["攻击力"]-300
		JY.Person[51]["防御力"] = JY.Person[51]["防御力"]-400
		JY.Person[51]["轻功"] = JY.Person[51]["轻功"]-300
		JY.Person[51]["生命最大值"] = JY.Person[51]["生命最大值"] - 3000	
		JY.Person[51]["内力最大值"] = JY.Person[51]["内力最大值"] - 5000		
		JY.Person[51]["生命"] = JY.Person[51]["生命最大值"]	
		JY.Person[51]["内力"] = JY.Person[51]["内力最大值"]			
		JY.Person[51]["武功等级1"] = 500		
		JY.Person[51]["声望"] = 0	
		JY.Person[50]["声望"] = 108
		JY.Person[53]["攻击力"] = JY.Person[53]["攻击力"]-100
		JY.Person[53]["防御力"] = JY.Person[53]["防御力"]-100
		JY.Person[53]["轻功"] = JY.Person[53]["轻功"]-100		
		for i = 1, 4 do
			JY.Person[50]["携带物品数量" .. i] = 1
		end		
		instruct_0();	
		say("好！既然你们赢了乔某也无话可说，这本书你拿去吧！兄弟，我们走！",50,0,"乔峰") 			
	else
		JY.Person[0]["品德"] = JY.Person[0]["品德"] + 2
		if JY.Person[0]["品德"] > 100 then JY.Person[0]["品德"] = 100 end
		instruct_0();
		if T12YMZ(0) then
			say("乔帮主，你豪迈英武，小妹佩服，但形格势禁，也只好得罪了。") 
			instruct_0();
			say("好，那便请杨女侠赐教。",50,0,"乔峰") 
			instruct_0();
			say("（这乔峰当真豪杰，可惜我胜之不武）请了！") 
		else
			say("乔峰，你虽非汉人，但我敬你侠义，此战就由我俩痛快打一场吧！！") 
			instruct_0();	
			say("好汉子！请！",50,0,"乔峰") 
		end
		if instruct_6(259,4,0,0) ==false then 
			instruct_0(); 
			instruct_0();   --  0(0)::空语句(清屏)
		    instruct_13();   --  13(D):重新显示场景	
			TalkEx("看来你还没有资格保管这本《天龙八部》，它还是留在我这里安全，有缘再见吧。",50,0,"乔峰") 
			instruct_0();   --  0(0)::空语句(清屏)
            instruct_14();   --  14(E):场景变黑
	        instruct_3(-2,99,0,0,0,0,0,0,0,0,-2,-2,-2)
            instruct_3(-2,14,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
	        TalkEx("糟了，乔峰这一走，天书就下落不明了！")
	        instruct_0();
	        instruct_0();   --  0(0)::空语句(清屏)
	        instruct_3(-2,41,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [41]
            instruct_3(-2,40,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [40]
            instruct_3(-2,39,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [39]
            instruct_3(-2,38,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [38]
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
            TalkEx("慕容公子，你怎么打算？")
            instruct_0();   --  0(0)::空语句(清屏)
            TalkEx("（这小子是南贤北丑的徒弟，对于我慕容氏复国还有利用价值的）我准备跟你一起去找乔峰，在这之前我要回燕子坞一趟",51,0,"慕容复")
            instruct_0();   --  0(0)::空语句(清屏)
            TalkEx("那好，我随后就来找你")
			instruct_3(51,42,0,0,0,0,0,0,0,0,-2,-2,-2)	--慕容复
	        instruct_3(51,43,0,0,0,0,0,0,0,0,-2,-2,-2)	--王语嫣
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_1(2550,51,0);   --  1(1):[慕容复]说: 我这就回燕子坞，兄弟如果*有需要我帮忙的地方，尽可*去燕子坞找我
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_14();   --  14(E):场景变黑
	        instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
			instruct_3(103,100,0,0,0,0,9003,0,0,0,-2,22,23)		--	3(3):修改事件定义:场景[药王庙]:场景事件编号 [101]
	        do return; end
            instruct_0();   --  0(0)::空语句(清屏)
        end 
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景	
		addHZ(31)
		if JY.Person[0]["品德"] >= 80 then
			instruct_0();	
			say("好！小兄弟，你我虽立场不同，但我知你为人仁厚，这丐帮绝学降龙二十八掌经我删削重复为了降龙十八掌。萧某不忍心让它失传，就交给你吧。",50,0,"乔峰") 			
			instruct_0();	
			say("乔兄慷慨高义，在下敬服。") 
			instruct_0();
			instruct_2(86,1)	
			addHZ(68)
		end
		instruct_0();	
		say("哈哈哈，长江后浪推前浪！各位英雄，乔峰从此退出江湖不问世事，请了！",50,0,"乔峰") 		
	end	
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
	instruct_3(-2,99,0,0,0,0,0,0,0,0,-2,-2,-2)
    instruct_3(-2,14,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_2(147,1);   --  2(2):得到物品[天龙八部][1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2542,207,0);   --  1(1):[???]说: 阁下来此，揭发乔峰的真实*身份，让我丐帮不致误奉一*契丹人为帮主，很是感激。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2544,207,0);   --  1(1):[???]说: 但是，拜你所赐，我丐帮也*将因此事贻笑武林。你拿的*《天龙八部》是丐帮镇帮之*宝，还请阁下留下。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2545,0,1);   --  1(1):[AAA]说: 怎麽可以，我好不容易才拿*到手的。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2546,207,0);   --  1(1):[???]说: 那只好得罪了。
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(84,4,0,0) ==false then    --  6(6):战斗[84]是则跳转到:Label0
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label0
    instruct_3(-2,41,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [41]
    instruct_3(-2,40,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [40]
    instruct_3(-2,39,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [39]
    instruct_3(-2,38,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [38]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(2547,207,0);   --  1(1):[???]说: 阁下对丐帮的"大恩大德"全*武林的叫化子都会记得的。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2548,51,0);   --  1(1):[慕容复]说: 哈哈哈，恭喜少侠如愿以偿*得到天书。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2549,247,1);   --  1(1):[???]说: 哪里哪里，多亏慕容公子鼎*力相助
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2550,51,0);   --  1(1):[慕容复]说: 我这就回燕子坞，兄弟如果*有需要我帮忙的地方，尽可*去燕子坞找我
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
	SetS(106, 2, 2, 0, 1)
    instruct_3(-2,43,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [43]
    instruct_3(-2,42,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [42]
    instruct_3(52,1,1,0,586,0,0,6302,6302,6302,-2,-2,-2);   --  3(3):修改事件定义:场景[燕子坞]:场景事件编号 [1]
    instruct_3(52,2,1,0,587,0,0,6298,6298,6298,-2,-2,-2);   --  3(3):修改事件定义:场景[燕子坞]:场景事件编号 [2]
	instruct_3(42,0,1,0,9999,0,0,-2,-2,-2,-2,-2,-2); --设置9999 邪线拿北冥
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
end

OEVENTLUA[9999] = function() --天龙八部邪线拿北冥
	if instruct_16(51) and instruct_16(76) then
		say("表哥你看！",76,0,"王语嫣")
		instruct_0();   --  0(0)::空语句(清屏)
		say("这座雕像长得跟你好像。。不知道是谁放在这里的。。",51,0,"慕容复")
		instruct_14()
		JY.Person[53]["攻击力"] = JY.Person[53]["攻击力"]+150
		JY.Person[53]["防御力"] = JY.Person[53]["防御力"]+150
		JY.Person[53]["轻功"] = JY.Person[53]["轻功"]+150
		JY.Person[53]["武功等级1"] = 999
		JY.Person[53]["武功等级2"] = 999			
		instruct_3(42,6,1,0,0,0,0,6312,6312,6312,-2,-2,-2)
		instruct_13()
		instruct_0();   --  0(0)::空语句(清屏)
		say("神仙姐姐！是神仙姐姐！",53,0,"段誉")
		instruct_0();   --  0(0)::空语句(清屏)		
		say("原来是你这个家伙！竟然在这里做这种东西对语嫣不敬！",51,0,"慕容复")
		instruct_0();   --  0(0)::空语句(清屏)		
		say("慕容复，休要对我进行污蔑！",53,0,"段誉")
		instruct_0();   --  0(0)::空语句(清屏)		
		say("污蔑你又咋的？枉你是个读书人，竟然满肚子龌蹉思想！",51,0,"慕容复")
		instruct_0();   --  0(0)::空语句(清屏)	
		say("看来你和你那个自命风流的淫棍爹爹也差不多啊！",51,0,"慕容复")
		instruct_0();   --  0(0)::空语句(清屏)			
		say("啊，可恶！既然你如此诽谤我，那么，就让你看看我们段氏龙族的力量吧",53,0,"段誉")
		instruct_0();   --  0(0)::空语句(清屏)			
		say("记忆的封印打开了，力量不断涌现出来",53,0,"段誉")
		instruct_0();   --  0(0)::空语句(清屏)			
		say("我乃是，八，部，龙，王",53,0,"段誉")
		setJX(53,1)
		instruct_0();   --  0(0)::空语句(清屏)
		QZXS("段誉领悟八部战意技【龙王·龙形剑气】！")
		instruct_0();   --  0(0)::空语句(清屏)		
		say("难道只有你才有这种力量吗？也是时候让你看看慕容家的愤怒了",51,0,"慕容复")
		instruct_0();   --  0(0)::空语句(清屏)		
		say("化身为血海地狱的修罗，也要振兴慕容家的霸业",51,0,"慕容复")	
		setJX(51,1)
		instruct_0();   --  0(0)::空语句(清屏)
		QZXS("慕容复领悟八部战意技【修罗·无间斗转】！")
		instruct_0();   --  0(0)::空语句(清屏)		
		say("来吧，你这只长着角的泥鳅",51,0,"慕容复")			
		instruct_0();   --  0(0)::空语句(清屏)
		
		if instruct_6(254) ==false then     --慕容单挑段誉
			instruct_15(0);   --  15(F):战斗失败，死亡
			do return; end
			instruct_0();   --  0(0)::空语句(清屏)
		end    --:Label1	
		JY.Person[53]["攻击力"] = JY.Person[53]["攻击力"]-150
		JY.Person[53]["防御力"] = JY.Person[53]["防御力"]-150
		JY.Person[53]["轻功"] = JY.Person[53]["轻功"]-150		
		instruct_13();   --  13(D):重新显示场景
		instruct_0();   --  0(0)::空语句(清屏)	
		instruct_2(64,1); 	--得到北冥
		TalkEx("慕容公子，这位段兄只是因为倾慕王姑娘而行为失常，罪不至死啊。",0,1)
		instruct_0();   --  0(0)::空语句(清屏)
		say("（杀了这家伙恐怕会导致大理的报复，对我复国不利。）也罢，给我滚的远远的！再也别让我见到你！",51,0,"慕容复")
		instruct_0();   --  0(0)::空语句(清屏)		
		say("神仙姐姐。。。",53,0,"段誉")
		instruct_0();   --  0(0)::空语句(清屏)	
		instruct_14()
		instruct_3(42,6,1,0,0,0,0,0,0,0,-2,-2,-2)
		instruct_13()		
		instruct_3(42,0,1,0,0,0,0,-2,-2,-2,-2,-2,-2)
	    if GetS(113, 0, 0, 0) == 0 then
            say("原来这才是斗转的真正用法",0) 
	        say("好，那我可以试试",0) 
			if instruct_11(0,188) == true then
                say("斗转果然还是很厉害的武功",0) 					 
	            QZXS("领悟星辰化解大法！")
	            instruct_0();
	            say("哈哈，我也算是一个奇才",0) 
	            setLW1(43)
			else
				say("唉，罢了罢了",0) 
			end
        end			
	end
end

OEVENTLUA[708] = function() 
    instruct_1(2880,210,0);   --  1(1):[???]说: 少林木人巷，每个人只有一*次挑战机会，你想挑战吗？
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_5(2,0) ==false then    --  5(5):是否选择战斗？是则跳转到:Label0
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label0

    instruct_1(2881,210,0);   --  1(1):[???]说: 好，施主里边请！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_19(35,15);   --  19(13):主角移动至23-F
    instruct_0();   --  0(0)::空语句(清屏)
--[[
    if instruct_6(212,0,23,1) ==true then    --  6(6):战斗[212]否则跳转到:Label1
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景

        if instruct_6(213,0,15,1) ==true then    --  6(6):战斗[213]否则跳转到:Label2
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景]]

            if instruct_6(214,0,7,1) ==true then    --  6(6):战斗[214]否则跳转到:Label3
                instruct_19(34,10);   --  19(13):主角移动至22-A
                instruct_0();   --  0(0)::空语句(清屏)
                instruct_13();   --  13(D):重新显示场景
                instruct_0();   --  0(0)::空语句(清屏)
                do return; end
            end    --:Label3
--[[
            instruct_0();   --  0(0)::空语句(清屏)
        end    --:Label2

        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label1]]

    instruct_19(35,17);   --  19(13):主角移动至23-11
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_3(-2,-2,1,0,709,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
end

OEVENTLUA[303] = function() --倚天邪

    if instruct_4(219,2,0) ==false then    --  4(4):是否使用物品[一颗头颅]？是则跳转到:Label0
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0

    instruct_32(219,-1);   --  32(20):物品[一颗头颅]+[-1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1058,70,0);   --  1(1):[玄慈]说: 阿弥陀佛，这恶贼成昆终于*伏法。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1059,0,1);   --  1(1):[AAA]说: 范右使和谢法王呢？我是来*换书的。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1060,70,0);   --  1(1):[玄慈]说: 范遥已退隐江湖，不问世事*。谢逊已在少林出家，不见*外人。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1061,0,1);   --  1(1):[AAA]说: 那我的书怎么办啊？
    instruct_0();   --  0(0)::空语句(清屏)
	say("他们托我转告少侠，你想要的东西在光明顶。",70,0,"玄慈")
    --instruct_2(155,1);   --  2(2):得到物品[倚天屠龙记][1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1063,70,0);   --  1(1):[玄慈]说: 望少侠今后少生杀戮，多行*善事，阿弥陀佛，善哉善哉*。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_3(-2,-2,-2,-2,-2,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
	instruct_3(11,93,1,0,10000,0,0,2606,2606,2606,-2,-2,-2) --光明顶
end

OEVENTLUA[10000] = function() --倚天邪拿书
	instruct_3(11,93,1,0,0,0,0,2608,2608,2608,-2,-2,-2)	
	TalkEx("（五彩云烟起）这是......幻象？",0,1)
	if instruct_6(255) ==false then    --光明圣火阵
		instruct_15(0);   --  15(F):战斗失败，死亡
		do return; end
		instruct_0();   --  0(0)::空语句(清屏)
	end    --:Label1	
	instruct_13();   --  13(D):重新显示场景
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_2(155,1);   --  2(2):得到物品[倚天屠龙记][1]
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_2(43,1);   
	instruct_0();   --  0(0)::空语句(清屏)
    addthing(355)
	TalkEx("还有留言？",0,1);
    say("恭喜少侠闯过本教圣阵，请问少侠是否愿意重振明教，代行光明？",11,0,"杨逍")
    if DrawStrBoxYesNo(-1, -1, "要作为明教代行使者么？", C_WHITE, 30) == true then 
	JoinMP(0, 13, 5)
	TalkEx("明教的灭亡，我也有责任，引领正道，我也该担当一下",0,1)
	say("多谢少侠，这是本教秘传心法，【焚影圣诀】和【明尊琉璃】,请少侠多加研习",11,0,"杨逍")
	say("为善除恶，唯光明故。喜乐悲愁，皆归尘土。怜我世人，忧患实多！",11,0,"杨逍")
		if GetS(113,0,0,0) == 0 then
			say("呼，这阵还真难，还好有收获。咦？圣诀里怎夹了张纸？",0)
			instruct_0();
			say("上面好像画了把刀...还散发出一股莫名的压力...。",0); 
			instruct_0();
			say("要打开看看吗？",0); 
			if instruct_11(0,188) == true then
				say("好美的一把白色东瀛刀啊！等等，这画怎么就碎了？呜...呜呃...",0) 
				instruct_0();
				instruct_14();   --  14(E):场景变黑
				instruct_13();   --  13(D):重新显示场景
				say("啊...头好晕...。袖白雪、白霞罚...这都什么啊...",0) 
				instruct_0();
				say("这么寒冽凛然的刀招是怎么出现在我脑子里的啊...算了，不想了...。",0) 
				instruct_0();
				say("在我知道的武学里，只有阴风刀能把这些刀招发挥出来。啧，也算因祸得福了？",0) 
				instruct_0();
	            QZXS("领悟阴风刀！")
	            instruct_0();
	            SetS(113, 0, 0, 0,140)
				else
				say("算了，不要冒没必要的危险！把纸放回箱子吧",0) 
				instruct_0()
			end
		end
		if GetS(114,0,0,0) == 0 then
			say("呼，这阵还真难，还好有收获。",0)
			say("是说刚刚拿到的明教轻功，跟「焚影圣诀」好像有呼应阿...",0)
			say("拿圣诀来补充这本轻功看看？",0); 
			if instruct_11(0,188) == true then
				say("哈哈成功了，不虚此行了阿！",0) 
				instruct_0();
	            QZXS("领悟暗影迷踪！")
	            instruct_0();
	            SetS(114, 0, 0, 0,194)
			else
				say("算了，还是别乱来，练死自己就好笑了！",0)
			end
		end	
	end	
end

OEVENTLUA[610] = function() 
    if instruct_4(200,2,0) ==false then    --  4(4):是否使用物品[七宝指环]？是则跳转到:Label0
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label0

    instruct_1(2655,245,1);   --  1(1):[???]说: 丁春秋，你认得这七宝指环*吗？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2656,46,0);   --  1(1):[丁春秋]说: 你是谁，怎麽会有这东西．
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2657,245,1);   --  1(1):[???]说: 见到掌门还不跪下．
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2658,46,0);   --  1(1):[丁春秋]说: 这逍遥派掌门的信物是那偷*来的？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2659,245,1);   --  1(1):[???]说: 是你师父给的，他还要我们*来替他清理门户，除去你这*武林败类．
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2660,46,0);   --  1(1):[丁春秋]说: 那老贼被我打落山崖，居然*还没死，竟然还将这七宝指*环给了你．*也好，你亲自来送死，也免*得我去找这七宝指环了．
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2661,206,0);   --  1(1):[???]说: 师父功力，震烁古今，你竟*敢和我们作对，这叫萤火虫*与日月争光！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2662,206,0);   --  1(1):[???]说: 螳臂挡车，自不量力，可笑*啊！可笑！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2663,206,0);   --  1(1):[???]说: 我师父谈笑之间，便可将你*们这一干妖魔小丑置之死地*．．．
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2664,245,1);   --  1(1):[???]说: 你们烦不烦，要打就快打，*别在那大吹法螺．
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(86,4,0,0) ==false then    --  6(6):战斗[86]是则跳转到:Label1
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label1

    instruct_3(-2,0,1,0,0,0,0,6600,6600,6600,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
    instruct_3(-2,4,1,0,611,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [4]
    instruct_3(-2,14,1,0,611,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
    instruct_3(-2,13,1,0,611,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
    instruct_3(-2,12,1,0,611,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
    instruct_3(-2,10,1,0,611,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [10]
    instruct_3(-2,9,1,0,611,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [9]
    instruct_3(-2,8,1,0,611,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [8]
    instruct_3(-2,7,1,0,611,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [7]
    instruct_3(-2,6,1,0,611,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
    instruct_3(-2,5,1,0,611,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [5]
    instruct_3(53,0,1,0,612,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[擂鼓山]:场景事件编号 [0]
    SetS(60,34,30,3,99); --阿紫出现龙门客栈
	instruct_3(60,99,1,0,10001,0,0,6376,6376,6376,-2,-2,-2); --阿紫加入事件
	instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(2665,0,1);   --  1(1):[AAA]说: 好不容易解决了这老怪．
		if MPPD(0) == 1 and MPDJ(0) ~= nil then
			JoinMP(0,1,3)
		end	
			if GetS(111, 0, 0, 0) == 0 then
		        say("这是丁春秋的化功大法！？虽说歹毒，不过也要看谁用。",0); 
				if instruct_11(0,188) == true then
				     say("不学白不学！",0) 
					 instruct_0();
	                 QZXS("领悟化功大法！")
	                 instruct_0();
	                 SetS(111, 0, 0, 0,87)
				else
				     say("如此歹毒的武功还是不学了！",0) 
					 instruct_0()
				end	
			end
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2666,206,0);   --  1(1):[???]说: 少侠英雄无敌，小人忠诚归*附，死心塌地，愿为主人效*犬马之劳．
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2667,206,0);   --  1(1):[???]说: 这天下盟主一席，非少侠莫*属．只须主人下令动手，小*人赴汤蹈火，万死不辞．
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2668,206,0);   --  1(1):[???]说: 丁春秋这灯烛之火，居然也*敢和日月争光．
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2669,206,0);   --  1(1):[???]说: 少侠德配天地，威震当世，*古今无比．
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2670,247,1);   --  1(1):[???]说: 这些家伙转的真快，不愧是*星宿派的弟子．不过听了虽*有点肉麻，但也蛮舒服的．
    instruct_0();   --  0(0)::空语句(清屏)
	instruct_2(360,1)
	instruct_0();   --  0(0)::空语句(清屏)	
    instruct_37(5);   --  37(25):增加道德5
    instruct_0();   --  0(0)::空语句(清屏)
	if instruct_16(2) then
		say("原来这就是化功大法，果然了得。",2,0,"程灵素")
		instruct_0();   --  0(0)::空语句(清屏)	
		TalkEx("怎么，程姑娘对此这功夫也有兴趣？",0,1)
		instruct_0();   --  0(0)::空语句(清屏)
		say("我确实想看看，嗯？给我看？好吧。",2,0,"程灵素")
		instruct_0();   --  0(0)::空语句(清屏)	
		say("原来如此，这套功夫必须要配合这个神木王鼎才能大成，在练的过程中还不能中止，否则就会反噬。",2,0,"程灵素")
		instruct_0();   --  0(0)::空语句(清屏)	
		TalkEx("啊？这么邪门？那我还是不要了...",0,1)
		instruct_0();   --  0(0)::空语句(清屏)
		say("少侠不要害怕，只要将里面的毒物这样这样......今后的危害就小得多。",2,0,"程灵素")
		instruct_0();   --  0(0)::空语句(清屏)			
		TalkEx("是吗？不过程姑娘，你能确定？",0,1)
		instruct_0();   --  0(0)::空语句(清屏)
		say("嗯，你是怀疑我的专业水平？哼，我就练给你看。",2,0,"程灵素")
		instruct_0();   --  0(0)::空语句(清屏)		
		TalkEx("啊？不要啊。",0,1)
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_14();   --  14(E):场景变黑
		instruct_13();   --  13(D):重新显示场景	
		say("看吧，没事吧。",2,0,"程灵素")
		instruct_0();   --  0(0)::空语句(清屏)	
		instruct_35(2,1,87,0)	
		AddPersonAttrib(2, "轻功", 10);
		QZXS("程灵素学会化功大法。轻功增加10。");
		say("哦？这毒素居然和七星海棠合二为一了？妙哉，妙哉",2,0,"程灵素")
		say("看来我离师父的境界越来越近了",2,0,"程灵素")
		setJX(2,1)
		QZXS("程灵素觉醒了七星神木毒髓");
		instruct_0();   --  0(0)::空语句(清屏)	
		instruct_35(2,1,87,0)
		instruct_0();   --  0(0)::空语句(清屏)
	end	
end

OEVENTLUA[10001] = function() --阿紫加入
	say("我听说你大闹星宿海，还把星宿老仙给杀了？",47,0,"阿紫") 
	instruct_0();
	TalkEx("姑娘客气了，为民除害乃是我们侠客的本分。",0,1)
	instruct_0();
	say("谁管你做了什么。你拿到了那本化功大法？我加入你们，你把那本书给我看看好不好？",47,0,"阿紫") 
	instruct_0();	
	if instruct_9() == true then
		if not instruct_20() then		
			say("哈哈，我终于把化功大法弄到手了！",47,0,"阿紫") 
			instruct_0();			
			instruct_14();   --  14(E):场景变黑
			instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,-2,-2);
			instruct_3(104,66,1,0,960,0,0,6374,6374,6374,-2,-2,-2); --钓鱼岛
			if GetS(3, 0, 0, 0) == 1 then
				SetS(3,18,28,3,99); --铁头出现有间客栈
				instruct_3(3,99,1,0,10005,0,0,6380,6380,6380,-2,-2,-2); --铁头加入事件	
			else
				SetS(3, 0, 0, 0, 1)
			end
			instruct_13();   --  13(D):重新显示场景
			instruct_10(47);
		else
			say("笨蛋，你们太多人了！",47,0,"阿紫") 
			instruct_0();
		end
	else
		say("不要就算了！吃饭喝水的时候小心点！",47,0,"阿紫") 
		instruct_0();
	end
end


OEVENTLUA[547] = function() --铁头邪线出现
    if instruct_4(197,2,0) ==false then    --  4(4):是否使用物品[大燕皇帝世袭图表]？是则跳转到:Label0
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label0

    instruct_32(197,-1);   --  32(20):物品[大燕皇帝世袭图表]+[-1]
    instruct_1(2311,51,0);   --  1(1):[慕容复]说: 哈哈，有了大燕皇帝世系谱*表及传国玉玺，我就可号召*大燕後代，实行复国计划。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2312,0,1);   --  1(1):[AAA]说: 慕容公子此次不会再失信了*吧。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2313,51,0);   --  1(1):[慕容复]说: 我慕容复何时曾失信过人。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2314,246,1);   --  1(1):[???]说: ＜贵人多忘事＞
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2315,51,0);   --  1(1):[慕容复]说: 《天龙八部》一书在乔峰的*手里。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2316,0,1);   --  1(1):[AAA]说: 你该不会是随便说说的吧。*人家称你们为“南慕容，北*乔峰”，你就说书在他那。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2317,76,0);   --  1(1):[???]说: 我表哥没有说谎，此书的确*是流落在他的手中。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2318,247,1);   --  1(1):[???]说: 王姑娘说的话就可以信了。*好，我就上丐帮要书去了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2319,51,0);   --  1(1):[慕容复]说: 非也，非也～
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2320,0,1);   --  1(1):[AAA]说: 此话怎讲？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2321,51,0);   --  1(1):[慕容复]说: 你想想看，你打得过那乔峰*吗？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2322,0,1);   --  1(1):[AAA]说: 打不过也得打，*不然怎麽办？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2323,51,0);   --  1(1):[慕容复]说: 我有办法让乔峰乖乖的将书*交出来。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2324,0,1);   --  1(1):[AAA]说: 他为什麽会乖乖交出来？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2325,51,0);   --  1(1):[慕容复]说: 因为我知道他一个极大的秘*密，一个足以让他身败名裂*的秘密。总之，你若和我合*作，我可以让你轻易获得该*书。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2326,0,1);   --  1(1):[AAA]说: 你为什麽要帮我？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2327,51,0);   --  1(1):[慕容复]说: 没什麽，鱼帮水，水帮鱼。*我慕容氏人丁单薄，势力微*弱，想要重建邦国，谈何容*易？唯一的机会便是天下大*乱，武林动荡不安。而你也*可从中得到你要的东西。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2328,76,0);   --  1(1):[???]说: 表哥，你不要想复国想到疯*了，弄得天下大乱。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2329,51,0);   --  1(1):[慕容复]说: 住嘴！你以为我这慕容复的*"复"字是为何取的，我慕容*家族世世代代奔波一生，所*为何事？怎样，你要不要和*我合作？
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_11(119,0) ==false or cxzj() == 49 then    --  11(B):是否住宿是则跳转到:Label1
        instruct_37(2);   --  37(25):增加道德2
        instruct_3(104,91,1,0,1084,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[钓鱼岛]:场景事件编号 [91]
        instruct_1(2330,0,1);   --  1(1):[AAA]说: 慕容公子的好意，在下心领*了。但我不愿用卑鄙的方法*去得到那本《天龙八部》。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2331,51,0);   --  1(1):[慕容复]说: 哼，此事我势在必行，即使*没有你的合作，我也要去丐*帮。到时你得不到《天龙八*部》，那可是你咎由自取。*我们走。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2332,53,0);   --  1(1):[段誉]说: 王姑娘，等等我……
		instruct_1(5113,53,0); 
		instruct_2(359,1); 
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_14();   --  14(E):场景变黑
        instruct_3(-2,1,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
        instruct_3(-2,20,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [20]
        instruct_3(-2,5,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [5]
        instruct_3(-2,3,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
        instruct_3(-2,2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
        instruct_3(51,25,0,0,0,0,556,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[丐帮]:场景事件编号 [25]
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        do return; end
    end    --:Label1

    instruct_37(-8);   --  37(25):增加道德-8
    instruct_3(104,91,1,0,1085,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[钓鱼岛]:场景事件编号 [91]
    instruct_1(2333,51,0);   --  1(1):[慕容复]说: 好，少侠果然明事理。这封*书信就是揭发乔峰的证据，*你拿好，咱们丐帮见。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_2(216,1);   --  2(2):得到物品[带头大哥书信][1]
	instruct_2(118,1);
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,1,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
    instruct_3(-2,2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(2334,53,0);   --  1(1):[段誉]说: 唉，王姑娘走了，……*我也回大理吧……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
	JY.Person[49]["无用4"] = 1--天邪
	if GetS(3, 0, 0, 0) == 1 then
		SetS(3,18,28,3,99); --铁头出现有间客栈
		instruct_3(3,99,1,0,10005,0,0,6380,6380,6380,-2,-2,-2); --铁头加入事件	
	else
		SetS(3, 0, 0, 0, 1)
	end	
    instruct_3(-2,20,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [20]
    instruct_3(-2,3,1,0,548,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
    instruct_3(-2,5,1,0,549,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [5]
    instruct_3(51,25,0,0,0,0,585,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[丐帮]:场景事件编号 [25]
    instruct_3(77,0,1,0,1061,0,0,6414,6414,6414,-2,-2,-2);   --  3(3):修改事件定义:场景[万鳄岛]:场景事件编号 [0]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
end

OEVENTLUA[9003] = function()	--铁头和阿紫
	instruct_14();   --  14(E):场景变黑
	instruct_3(103,101,0,0,0,0,0,3187*2,3187*2,3187*2,-2,17,19)	--	3(3):修改事件定义:场景[药王庙]:场景事件编号 [101]
	instruct_3(103,102,0,0,0,0,0,3189*2,3189*2,3189*2,-2,17,18)	--	3(3):修改事件定义:场景[药王庙]:场景事件编号 [102]
	instruct_3(103,103,0,0,0,0,0,3186*2,3186*2,3186*2,-2,19,19)	--	3(3):修改事件定义:场景[药王庙]:场景事件编号 [103]
	instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
	TalkEx("铁头寒毒发作中",0,2)
	say("小师妹我看你还是交出来吧。别让我们动手，我们可不会怜香惜玉的。",264,0,"大师兄")
	TalkEx("大师兄，那东西根本不在我身上，真的我不骗你。",47,1)
	TalkEx("阿紫，别跟他们废话我帮你教训他们。我不怕死。",48,0)
	TalkEx("＜你不怕死我还怕死呢！要不是你没用中了冰蚕的毒到现在都没好，我用得着这样么＞",47,1)
	instruct_30(21,23,19,20)  --  30(1E):主角走动
    instruct_40(2);   --  40(28):改变主角站立方向2
	TalkEx("大师兄你后面有人。真的有个人，我不骗你。",47,0)
	say("小师妹，你别骗我了。我可是很了解你的。你想骗我回头你在跑掉是么。",264,1,"大师兄")
	TalkEx("这位大哥哥，你帮我们打跑他们，我把这个冰蚕送给你。",47,3)
	TalkEx("＜冰蚕，好东西。我要了＞行，就几只小猫小狗，我来帮你料理。",0,4)
	if instruct_6(276,4,0,0) ==false then    --  6(6):战斗[131]是则跳转到:Label1
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
    end    --:Label1
	say("东西都不要就跑了！", 0)
	addthing(174, 5000)
	addHZ(6)
	instruct_3(103,103,0,0,0,0,0,0,0,0,-2,19,19)	--	3(3):修改事件定义:场景[药王庙]:场景事件编号 [103]
	TalkEx("这位哥哥给你冰蚕。",47,0)
	TalkEx("啊.......小丫头你给我下毒。",0,1)
	TalkEx("嘻嘻，滋味不错吧。铁头我们上，一起杀了他。",47,0)
	if instruct_6(366,4,0,0) ==false then    --  6(6):战斗[131]是则跳转到:Label1
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
    end    --:Label1
	TalkEx("你这个小丫头胆子不小啊。我帮你反而还加害于我，看我了结了你。",0,0)
	TalkEx("这位大侠，求求你，你要杀就杀我吧，求你放了阿紫姑娘。",48,3)
	TalkEx("..................",47,1)
	TalkEx("＜这个丑八怪武功不错也许以后用的着＞放过她可以，你要答应我一件事",0,0)
	TalkEx("谢谢大侠，谢谢大侠！只要你答应不伤害阿紫姑娘，别说一件，一百件我都会答应大侠的。",48,1)
	TalkEx("你们现在准备去哪里。",0,0)
	TalkEx("我跟阿紫姑娘准备去丐帮。",48,1)
	TalkEx("哼！铁头我们走。",47,3)
	TalkEx("大侠我们走了。",48,1)
	TalkEx("就这样走了？不留点东西的话小丫头的性命我不敢担保了。",0,0)
	TalkEx("大侠这些东西给你，千万不要伤害阿紫姑娘。",48,1)
	addthing(8, 5)
	addHZ(91)
	instruct_3(103,100,0,0,0,0,0,0,0,0,-2,22,23)
	instruct_3(103,101,0,0,0,0,0,0,0,0,-2,17,19)
	instruct_3(103,102,0,0,0,0,0,0,0,0,-2,17,18)
	instruct_3(51,25,0,0,0,0,9004,-2,-2,-2,-2,-2,-2)
end
OEVENTLUA[9004] = function()	--丐帮帮铁头
	instruct_14();   --  14(E):场景变黑
	instruct_3(51,100,0,0,0,0,0,3188*2,3188*2,3188*2,-2,38,28)
	instruct_3(51,101,0,0,0,0,0,3190*2,3190*2,3190*2,-2,37,28)
    instruct_40(2);   --  40(28):改变主角站立方向2
	instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
	TalkEx("大侠你来了，我正和阿紫来丐帮寻找乔峰。可是他们说乔峰已不在丐帮了",48,0)
	TalkEx("是啊，不知道姐夫去了哪里。",47,3)
	TalkEx("＜既然乔峰不在了，我就助铁头当上帮主之位，丐帮情报天下第一这样也好帮我寻找天书下落。＞",0,1)
	TalkEx("兄弟，不知你可想当丐帮的帮主。",0,1)
	TalkEx("大侠，我...我...我...",48,0)
	TalkEx("好啊，好啊，求大哥哥帮助铁头当上帮主！",47,3)
	TalkEx("阿紫姑娘既然想，铁头就听阿紫姑娘的。",48,0)
	TalkEx("那好，你们跟我一起来。",0,1)
	instruct_14();   --  14(E):场景变黑
	instruct_3(51,100,0,0,0,0,0,0,0,0,-2,-2,-2)
	instruct_3(51,101,0,0,0,0,0,0,0,0,-2,-2,-2)
	instruct_3(51,39,0,0,0,0,0,3188*2,3188*2,3188*2,-2,-2,-2)
	instruct_3(51,38,0,0,0,0,0,3190*2,3190*2,3190*2,-2,-2,-2)
	instruct_19(17,29)
	instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
	say("不知几位来我丐帮所谓何事。",271,0,"丐帮长老")
	TalkEx("也没什么事就是想弄个帮主来当当，不知可不可以。",0,1)
	say("一群黄口小儿，居然有胆来我丐帮撒野，虽然前任乔帮主乔峰已经离开，我帮还未选任新帮主，那也轮不到你等黄口小儿在此撒野。",271,0,"丐帮长老")
	TalkEx("那就由不得你了，不服我打的你们服。",0,1)
	say("想当帮主，先过本帮打狗阵法在说。",271,0,"丐帮长老")
	TalkEx("那就让我会会丐帮的打狗阵法。",0,1)
	if instruct_6(82,4,0,0) ==false then    --  6(6):战斗[131]是则跳转到:Label1
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
    end    --:Label1
	say(".............",271,0,"丐帮长老")
	say("既然这位少侠过了本帮打狗阵法，那就当得本帮的帮主。",275,3,"全冠清")
	TalkEx("且慢，我虽侥幸过了打狗阵法，但是我却做不得丐帮帮主，我推荐一人，此人武功了得一样不输于我，我相信他一定能带领好丐帮上下。铁头",0,1)
	TalkEx("是少侠。",48,3)
	TalkEx("丐帮众人：..........",0,2)
	say("既然少侠推荐之人，必然不会差到哪里去。我全冠清一定会全力辅佐新帮主。",275,3,"全冠清")
	TalkEx("丐帮众人：参见新帮主。",0,2)
	TalkEx("主角：铁头你既以任新帮主，有一事你须你帮我查查。",0,0)
	TalkEx("不知少侠有何事需我帮忙。",48,1)
	TalkEx("我在找一本书天龙八部，此书现在乔峰身上，你让丐帮的人找一找乔峰的下落。",0,0)
	TalkEx("我一定全力帮少侠查找乔峰行踪。",48,1)
	TalkEx("＜查找不急一时不如我改日在来看看有什么结果＞",0,0)
	TalkEx("很好，我还有事，先走。",0,0)
	TalkEx("恭送少侠。",48,1)
	TalkEx("大哥哥，以后记得来丐帮玩玩。",47,3)
	instruct_3(51,25,0,0,0,0,0,-2,-2,-2,-2,-2,-2)
	instruct_3(51,24,0,0,0,0,9005,-2,-2,-2,-2,-2,-2)
end
OEVENTLUA[9005] = function()
	instruct_3(51,38,1,0,0,0,0,0,0,0,-2,-2,-2)
	instruct_3(51,14,1,0,9006,0,0,3189*2,3189*2,3189*2,-2,-2,-2)
	instruct_3(51,24,0,0,0,0,0,-2,-2,-2,-2,-2,-2)
end
OEVENTLUA[9006] = function()
	TalkEx("少侠来了。丐帮情报也无法找到乔峰的去向。",48,0)
	TalkEx("铁头,现在你以丐帮的名誉广发英雄帖，以选武林盟主之名聚集天下英雄上少林。到时乔峰一定出现。",0,1)
	TalkEx("少侠，这.........",48,0)
	TalkEx("好啊！好啊！武林盟主，一定好玩。",47,3)
	TalkEx("既然阿紫姑娘喜欢，铁头听少侠的便是。",48,0)
	TalkEx("......＜这也叫听我的.....＞",0,1)
	TalkEx("和我一起去找些帮手。",0,1)
	TalkEx("好的，少侠。",48,0)
	JoinMP(48,2,3)
	addthing(8, 5)
	addthing(338)
	addthing(349)
	if GetS(111,0,0,0) == 0 then 
        say("少侠，请留步！。",48)
		say("怎么了铁头？",0)
		say("这丐帮镇帮之宝是铁头报到少侠的恩情。",48)
		say("看看这丐帮镇帮之宝。",0)
        if yesno("是否领悟？") then 
	        QZXS("领悟擒龙功！")
	        say("丐帮武学果然厉害!") 
	        instruct_0();
	        SetS(111, 0, 0, 0,178)
        end
    end
	instruct_10(48);   --  10(A):加入人物[游坦之]
	instruct_10(47);   --  10(A):加入人物[阿紫]
	instruct_3(51,39,0,0,0,0,0,0,0,0,-2,-2,-2)
	instruct_3(51,14,0,0,0,0,0,0,0,0,-2,-2,-2)
	instruct_3(16,10,1,0,9007,0,0,8010,8010,8010,-2,-2,-2)	--鸠摩智
    instruct_3(52,1,1,0,9008,0,0,6302,6302,6302,-2,-2,-2)	--慕容复
end
OEVENTLUA[9007] = function()
	TalkEx("少侠找我何事。",103,0)
	TalkEx("我是来告诉大师一个消息的。",0,1)
	TalkEx("什么消息？",103,0)
	TalkEx("大师一直想得到的六脉神剑。",0,1)
	TalkEx("六脉神剑！告诉我段誉在哪里？",103,0)
	TalkEx("天下英雄即将在少林选武林盟主，到时段誉一定会现身，如此六脉神剑必是大师的。如果有其他麻烦我愿帮助大师得到此物。",0,1)
	TalkEx("你为什么要帮我？",103,0)
	TalkEx("明人不说暗话，我就想从段誉的结义大哥手中得到《天龙八部》一书，我帮了大师，大师也自然会帮我！是吧？大师！",0,1)
	TalkEx("此话在理！这是小僧的火焰刀绝技，希望少侠在武林大会上能助我擒获段誉。",103,0)
	addthing(75)
	addHZ(104)
	JoinMP(595,6,3)
	if hasthing(44) and PersonKF(0,195) then
		TalkEx("嗯？少侠请稍等",103,0)
		TalkEx("大师有何事要办？",0,1)
		TalkEx("不，小僧虽知少侠本就博览众家武学",103,0)
		TalkEx("但观少侠步履迈动之间的方法与变化...",103,0)
		TalkEx("少侠学过密宗秘传「踏雪无痕」吧？",103,0)
		TalkEx("敢问少侠与密宗有何关连！",103,0)
		TalkEx("（沉默半晌）大师可知此物？",0,1)
		TalkEx("血刀！？难道雪山上那些痕迹...！",103,0)
		TalkEx("看来大师去过雪山，想必也知道发生何事了",0,1)
		TalkEx("大师要为血刀老祖...复仇么？",0,1)
		TalkEx("复仇？哈哈哈哈哈哈哈哈",103,0)
		TalkEx("要是今天你口中的老祖是辟邪老祖，我还可能会出手",103,0)
		TalkEx("不对，要是你碰上辟邪老祖，你已经是尸体了哈哈哈",103,0)
		TalkEx("小僧反倒要感谢少侠，杀的好阿！！",103,0)
		TalkEx("此等淫邪败类，小僧本就欲杀之！",103,0)
		TalkEx("（...哼，倒是挺会说场面话）",0,1)
		TalkEx("总之，为感谢少侠为密宗除害",103,0)
		TalkEx("小僧就传授「踏雪无痕」的精髓与少侠如何？",103,0)
		if DrawStrBoxYesNo(-1, -1, "是否学习？", C_WHITE, 30) == true then
			QZXS("领悟踏雪无痕")
			setLW2(195)
			TalkEx("多谢大师",0,1)
			TalkEx("了却因果而已",103,0)
		else
			TalkEx("多谢大师好意，但在下当初不过练来好玩而已",0,1)
			TalkEx("可惜了，小僧就尽量帮少侠其他的忙吧。",103,0)
		end	
	end	
	instruct_3(16,10,0,0,0,0,0,0,0,0,-2,-2,-2)	--鸠摩智
	instruct_10(595);   --  10(A):加入人物[鸠摩智]
	instruct_3(52,2,1,0,587,0,0,6298,6298,6298,-2,-2,-2)
	if GetD(52,1,2) ~= 9008 then
		instruct_3(28,100,0,0,0,0,9010,0,0,0,-2,55,19)
		instruct_3(70,0,1,0,0,0,0,8818,8818,8818,-2,-2,-2)
	end
end
OEVENTLUA[9008] = function()
	TalkEx("慕容公子好，王姑娘好！",0,1)
	TalkEx("公子好！",76,1)
	TalkEx("少侠找到乔峰了？",51,0)
	TalkEx("没有，希望慕容公子能与我同行。",0,1)
	TalkEx("没问题？",51,0)
	TalkEx("慕容公子果然够朋友。",0,1)
	TalkEx("少侠言重了！",51,0)
	TalkEx("听南贤北丑两位说慕容公子是燕国后裔？",0,1)
	TalkEx(".........武林圣人真是无所不知",51,0)
	TalkEx("如果我能帮助慕容公子当上武林盟主，公子愿意帮我寻找天书吗？",0,1)
	TalkEx("当真？",51,0)
	TalkEx("当真！",0,1)
	TalkEx("如果少侠帮我夺得盟主之位，我慕容复一定为少侠搜遍全武林找到天书送给少侠！",51,0)
	TalkEx("那就先谢过慕容公子了！",0,1)
	TalkEx("少侠有什么大计需要我帮助的？",51,0)
	TalkEx("现在丐帮广发武林帖，邀请天下英雄在少林选武林盟主，到时候群雄聚集少林，如果慕容公子你到时力压群雄坐上盟主宝座，那么武林盟主就是公子的囊中之物，而后大燕复国还怕无望吗？",0,1)
	TalkEx("万一乔峰出现呢？或者还有其他人呢？",51,0)
	TalkEx("放心，我会邀请兄弟们帮忙，竭尽全力帮助公子夺得盟主之位！！！！！",0,1)
	TalkEx("哈哈哈！少侠这样助我慕容家，慕容复先在此谢过，这是我慕容家绝学，就送给少侠了。",51,0)
	addthing(270)
	addthing(314)
	addHZ(151)
	if GetS(111, 0, 0, 0) == 0 then
	    say("少侠，这本秘籍你练一练，会对你有帮助。",48) 
		say("这是梵文......不认识",0) 
		say("那么铁头就来指点少侠一番。",48) 
	    SetS(106, 63, 1, 0, 0)
        SetS(106, 63, 2, 0, 48)
	    if WarMain(288) == false then
	        instruct_13()  --场景变亮
		    say("真是可惜",0) 
	    else
		    say("真是好东西！",0) 
	        QZXS("领悟神足经！")
	        instruct_0();
	        SetS(111, 0, 0, 0, 188)
			addthing(349)
	    end
    end
	instruct_10(51);   --  10(A):加入人物[慕容复]
	instruct_10(76);   --  10(A):加入人物[王语嫣]
	instruct_3(52,1,0,0,0,0,0,0,0,0,-2,-2,-2)	--慕容复
	instruct_3(52,2,0,0,0,0,0,0,0,0,-2,-2,-2)	--王语嫣
	if GetD(16,10,2) ~= 9008 then
		instruct_3(28,100,0,0,0,0,9010,0,0,0,-2,55,19)
	end
end

OEVENTLUA[9010] = function()
	instruct_14();   --  14(E):场景变黑
	instruct_3(-2,37,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [37]
	instruct_3(-2,16,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [16]
	instruct_3(-2,0,0,0,0,0,0,5372,5372,5372,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
	instruct_3(-2,34,0,0,0,0,0,5372,5372,5372,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [34]
	instruct_3(-2,35,0,0,0,0,0,5372,5372,5372,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [35]
	instruct_3(-2,1,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
	instruct_3(-2,33,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [33]
	instruct_3(-2,32,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [32]
	instruct_3(-2,31,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [31]
	instruct_3(-2,30,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [30]
	instruct_3(-2,29,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [29]
	instruct_3(-2,28,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [28]
	instruct_3(-2,27,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
	instruct_3(-2,26,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [26]
	instruct_3(-2,6,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
	instruct_3(-2,5,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [5]
	instruct_3(-2,4,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [4]
	instruct_3(-2,3,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
	instruct_3(-2,2,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
	instruct_3(-2,48,0,0,0,0,0,6380,6380,6380,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [48]
	instruct_3(-2,58,0,0,0,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [58]
	instruct_3(-2,57,0,0,0,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [57]
	instruct_3(-2,56,0,0,0,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [56]
	instruct_3(-2,55,0,0,0,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [55]
	instruct_3(-2,54,0,0,0,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [54]
	instruct_3(-2,53,0,0,0,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [53]
	instruct_3(-2,52,0,0,0,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [52]
	instruct_3(-2,51,0,0,0,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [51]
	instruct_3(-2,50,0,0,0,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [50]
	instruct_3(-2,49,0,0,0,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [49]
	instruct_3(-2,59,0,0,0,0,0,6304,6304,6304,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [59]
	instruct_3(-2,61,0,0,0,0,0,6312,6312,6312,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [61]
	instruct_3(-2,60,0,0,0,0,0,7136,7136,7136,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [60]
	instruct_3(-2,62,0,0,0,0,0,6084,6084,6084,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [62]
	instruct_3(-2,63,0,0,0,0,0,5330,5330,5330,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [63]
	instruct_3(-2,64,0,0,0,0,0,8212,8212,8212,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [64]
	instruct_3(-2,65,0,0,0,0,0,7128,7128,7128,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [65]
	instruct_3(-2,66,0,0,0,0,0,7126,7126,7126,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [66]
	instruct_3(-2,70,0,0,0,0,0,8216,8216,8216,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [70]
	instruct_3(-2,102,0,0,0,0,0,8216,8216,8216,-2,51,45);   --  3(3):修改事件定义:当前场景:场景事件编号 [70]
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_13();   --  13(D):重新显示场景
	instruct_30(55,19,51,36);   --  30(1E):主角走动53-19--52-19
	instruct_40(2);   --  40(28):改变主角站立方向2
	instruct_0();   --  0(0)::空语句(清屏)
	TalkEx("我丐帮此次聚集各路英豪来少林，是想选出一位武功盖世的英雄为武林盟主，带领大家共抗外族，保我大宋。",48,0)
	TalkEx("既然各位选武林盟主，为何来我少林。",70,1)
	TalkEx("方丈此言差矣。大家都知道少林乃武林泰山北斗，方丈又是得高望重之人，来此选出盟主那是在合适不过了。",0,0)
	TalkEx(".....这个，但是佛门清净地",70,1)
	TalkEx("武林众人：这位少侠说的没错。",0,2)
	TalkEx("方丈无需担心，选武林盟主乃当世之大事，只能在少林此等庄严重地举行，方能显示盟主地位之重要。＜如果我当上盟主，到时群领各路英豪，我大燕复国有望了。＞",51,0)
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_14();   --  14(E):场景变黑
	instruct_3(-2,101,0,0,0,0,0,6292,6292,6292,-2,45,40);	--大王登场
	instruct_3(-2,102,0,0,0,0,0,3617*2,3617*2,3617*2,-2,45,39);	--虚竹登场
	instruct_3(-2,59,0,0,0,0,0,0,0,0,-2,-2,-2)
	instruct_3(-2,103,0,0,0,0,0,3154*2,3154*2,3154*2,-2,45,41);	--段誉登场
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_13();   --  13(D):重新显示场景
	TalkEx("萧施主也是来争武林盟主之位的。",70,0)
	TalkEx("哼。我萧峰来此并不是为武林盟主之位。只是我打听到带头大哥在少林。我想向方丈打听一下，不知道方丈可知道此人。",50,1)
	TalkEx("......老衲并不知道此人。",70,0)
	if inteam(49) then
	  instruct_21(49)
	  TalkEx("三弟！",49,0)
	end
	TalkEx("大哥你来了。我来向你介绍下，这位是虚竹，我新结拜的二哥，当时结拜我们都带上了你。",53,1)
	TalkEx("大哥。",49,0)
	TalkEx("好，好，好。不过两位兄弟我来此有重要的事情，此事过后我定与二弟三弟好好把酒言欢。",50,1)
	TalkEx("＜乔峰来了，看来天书有望了。不要怪我心狠手辣，我只为天书而已＞",0,0)
	TalkEx("乔兄，近来可好。",0,0)
	TalkEx("乔峰有何不好。倒是少侠为什么会在此出现？",50,1)
	TalkEx("乔兄是贵人事忙忘记了吧？我寻找的《天龙八部》一直在乔兄身上。",0,0)
	TalkEx("哈哈哈哈，原来如此。天书就在身上，少侠就凭本事来取吧！",50,1)
	TalkEx("既然如此，乔兄，得罪了！",0,0)
	if instruct_6(370,4,0,0) ==false then
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
    end
	instruct_12()
	TalkEx("大哥我来助你。",53,1)
	TalkEx("大哥，我也来助你。",49,0)
	TalkEx("好，我们三兄弟一起战斗。有兄弟如此不枉此生。",50,1)
	TalkEx("少侠，我来助你得天书。",48,0)
	TalkEx("＜此人，武功盖世，我若助他一臂之力，此人定然能有助我大燕复国。＞南慕容北乔峰，乔峰我慕容复来会会你。少侠，我来助你一臂之力。",51,1)
	TalkEx("＜段誉就在此，我定要得到六脉剑谱，＞小施主我来助你一臂之力。",103,0)
	TalkEx("好，大家上！",0,1)
	    --慕容复能力提升。
	    JY.Person[51]["攻击力"] = JY.Person[51]["攻击力"]+300
		JY.Person[51]["防御力"] = JY.Person[51]["防御力"]+300
		JY.Person[51]["轻功"] = JY.Person[51]["轻功"]+300
		JY.Person[51]["生命最大值"] = JY.Person[51]["生命最大值"] + 1000	
		JY.Person[51]["内力最大值"] = JY.Person[51]["内力最大值"] + 5000		
		JY.Person[51]["生命"] = JY.Person[51]["生命最大值"]	
		JY.Person[51]["内力"] = JY.Person[51]["内力最大值"]	
		JY.Person[51]["武功等级1"] = 999	
		--段誉能力提升。
        JY.Person[53]["攻击力"] = JY.Person[53]["攻击力"]+500
		JY.Person[53]["防御力"] = JY.Person[53]["防御力"]+500
		JY.Person[53]["轻功"] = JY.Person[53]["轻功"]+500
		JY.Person[53]["生命最大值"] = JY.Person[53]["生命最大值"] + 3000	
		JY.Person[53]["内力最大值"] = JY.Person[53]["内力最大值"] + 5000		
		JY.Person[53]["武功等级1"] = 999
		JY.Person[53]["武功等级2"] = 999
		JY.Person[53]["武功等级3"] = 999
		JY.Person[53]["武功4"] = 152
		JY.Person[53]["武功等级4"] = 999
		JY.Person[53]["声望"] = 152
		setJX(53)
		--虚竹能力提升。
	    JY.Person[49]["攻击力"] = JY.Person[49]["攻击力"]+500
		JY.Person[49]["防御力"] = JY.Person[49]["防御力"]+500
		JY.Person[49]["轻功"] = JY.Person[49]["轻功"]+500
		JY.Person[49]["生命最大值"] = JY.Person[49]["生命最大值"] + 3000	
		JY.Person[49]["内力最大值"] = JY.Person[49]["内力最大值"] + 8000		
		JY.Person[49]["武功1"] = 98
		JY.Person[49]["武功等级1"] = 999	
		JY.Person[49]["武功2"] = 101
		JY.Person[49]["武功等级2"] = 999
		JY.Person[49]["武功3"] = 8
		JY.Person[49]["武功等级3"] = 999
		JY.Person[49]["武功4"] = 14
		JY.Person[49]["武功等级4"] = 999
		JY.Person[49]["武功5"] = 176
		JY.Person[49]["武功等级5"] = 999
		JY.Person[49]["声望"] = 101
		setJX(49)
	if instruct_6(367,4,0,0) ==false then
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
    end
	instruct_12()
	instruct_1(2453,112,0);   --  1(1):[???]说: 哈哈哈……
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_14();   --  14(E):场景变黑
	instruct_3(-2,71,0,0,0,0,0,7134,7134,7134,-2,47,37);   --  3(3):修改事件定义:当前场景:场景事件编号 [71]
    instruct_3(-2,67,0,0,0,0,0,7132,7132,7132,-2,46,37);   --  3(3):修改事件定义:当前场景:场景事件编号 [67]
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_13();   --  13(D):重新显示场景
	TalkEx("住手峰儿，你忘了来此的目的了么。",112,0)
	TalkEx("你是？？",50,1)
	TalkEx("我是你爹萧远山。",112,0)
	TalkEx("爹！",50,1)
	TalkEx("难道你不想知道你的杀母仇人么。他现在就在少林室。而且是个德高望重之人。你想知道他是谁么。",112,0)
	TalkEx("杀母之仇不共带天。爹，你告诉我他是谁。",50,1)
	TalkEx("出来吧。。。既然来了为何不出来。",112,0)
	TalkEx("呵呵真是父子情深啊。复儿你过来。",113,1)
	TalkEx(".....你是谁？复儿是我父亲对我之称呼。难道！！！！！",51,0)
	TalkEx("复儿我是你爹，你过来。让我好好看看。",113,3)
	TalkEx("爹！！！爹！！！孩儿无能，到如今复国仍未见进展。孩儿无能啊。",51,0)
	TalkEx("不怪你，不怪你。哎，天意如此。",113,1)
	TalkEx("我们的仇人就是当今的少林的方丈。",112,0)
	TalkEx("想当年雁门关外......后来我抱着你们母亲的尸体和你，跳下悬崖，刚跳下去，就发现你还活着，你是无辜的，我就把你抛了上去......如此如此这般这般......你被汉人抚养成人。我当初侥幸未死，来到了少林室，三十年了，终于有一天我查出了仇人是谁。我等这这一天你来亲自报仇......终于盼来了，我的儿，你一定要为你母亲报仇啊！！",112,1)
	TalkEx("杀母之仇不共带天。少林方丈你拿命来。",50,0)
	TalkEx("当初是我们错，正所谓一错皆万错，错亦不能再弥补。请问慕容老居士，你可曾为此事后悔过么。当初要不是你假传消息我等，我等亦不会犯下如此大错。哎......错亦铸成老衲愿以命还之.......",70,1)
	TalkEx("慕容老贼原来是你当初假传消息，峰儿与我一起杀了此贼为你母亲报仇。",112,0)
	TalkEx("好，为母报仇。",50,1)
	TalkEx("谋事在人成事在天，区区几条人命算什么，复儿愿跟爹一起战他们父子么？",113,0)
	TalkEx("爹，孩儿愿意。",51,1)
	TalkEx("好，我的好孩儿。萧老兄，我们在战三百回合。",113,0)
	TalkEx("慕容公子，我来助你！",0,0)
	if GetS(113,0,0,0) == 0 and JY.Person[0]["拳掌功夫"] >= 250 then 
	    say("少侠助我复儿，老夫也不会亏待少侠，看好了。",113) 
	    instruct_0();
		if instruct_11(0,188) == true then 
	        QZXS("领悟参合指精要！")
			say("多谢慕容老先生",0)
	        instruct_0();
	        setLW1(133)
		    dark()
            light()
            --instruct_35(0,0,133,1)
		else
			say("如此，老夫也不勉强。",113) 
		end	
	end
	if GetS(111,0,0,0) == 0 and PersonKF(0, 43) then
		say("大敌当前，让老夫在指点少侠几招。",113)
		say("多谢慕容老先生。",0)
        if yesno("是否领悟？") then 
	        QZXS("领悟斗转星移！")
	        say("果然厉害!") 
	        instruct_0();
	        SetS(111, 0, 0, 0, 43)
		else
			say("少侠请小心。",113) 
		end	
	end
	instruct_6(368,4,0,0)
	instruct_12()
	    JY.Person[51]["攻击力"] = JY.Person[51]["攻击力"]-300
		JY.Person[51]["防御力"] = JY.Person[51]["防御力"]-300
		JY.Person[51]["轻功"] = JY.Person[51]["轻功"]-300
		JY.Person[51]["生命最大值"] = JY.Person[51]["生命最大值"] - 1000	
		JY.Person[51]["内力最大值"] = JY.Person[51]["内力最大值"] - 5000		
		JY.Person[51]["生命"] = JY.Person[51]["生命最大值"]	
		JY.Person[51]["内力"] = JY.Person[51]["内力最大值"]			
		JY.Person[51]["武功等级1"] = 500	
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_14();   --  14(E):场景变黑
	instruct_3(-2,104,0,0,0,0,0,3192*2,3192*2,3192*2,-2,45,38);	--扫地登场
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_13();   --  13(D):重新显示场景
	TalkEx("……",0,2)
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_14();   --  14(E):场景变黑
	instruct_3(-2,71,0,0,0,0,0,-2,-2,-2,-2,16,50);   --  3(3):修改事件定义:当前场景:场景事件编号 [71]
	instruct_3(-2,67,0,0,0,0,0,-2,-2,-2,-2,17,50);   --  3(3):修改事件定义:当前场景:场景事件编号 [67]
	instruct_3(-2,104,0,0,0,0,0,0,0,0,-2,-2,-2)
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_13();   --  13(D):重新显示场景
	TalkEx("……",0,2)
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_14();   --  14(E):场景变黑
	instruct_3(-2,104,0,0,0,0,0,3192*2,3192*2,3192*2,-2,45,38);	--扫地登场
	instruct_3(-2,71,0,0,0,0,0,-2,-2,-2,-2,47,37);   --  3(3):修改事件定义:当前场景:场景事件编号 [71]
	instruct_3(-2,67,0,0,0,0,0,-2,-2,-2,-2,46,37);   --  3(3):修改事件定义:当前场景:场景事件编号 [67]
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_13();   --  13(D):重新显示场景
	TalkEx("两位老施主都愿意皈依我佛，请乔施主，和慕容施主，回去吧。",114,0)
	TalkEx("乔峰，天书在哪？将天书交于我，我与你在无瓜葛。否则别怪我无情。",0,1)
	TalkEx("这位施主，劣行诸多，不如皈依我佛可好。",114,0)
	TalkEx("笑话，我为天书而来。关佛何事，让开........别在这倚老卖老。",0,1)
	TalkEx("佛曰：我不度人谁度人，小施主不愿，那就让老衲接你几招如何。你如若胜，那你自当拿书而去，你若不胜，就皈依我佛。",114,0)
	TalkEx("那就领教大师高招了。",0,1)
	if instruct_6(369,4,0,0) ==false then
        instruct_0();   --  0(0)::空语句(清屏)
		TalkEx("大师神功盖世，我自叹不如，往后皈依佛门，从此渡人渡己。",0,0)
		TalkEx("少侠资质非凡，佛已在心中，往少侠往后能留佛用存于心。渡人以善渡己以善。",114,1)
		TalkEx("谨遵大师教诲。乔兄，过去我亦于无形中堕落望乔兄海涵。",0,0)
		TalkEx("小兄弟亦是性情中人，我乔峰亦会如此小气，望小兄弟你往后能大义如此！",50,3)
		TalkEx("那多谢乔兄。我定当不孚众望。",0,1)
		TalkEx("乔某拜别大师。小兄弟告辞。",50,3)
		TalkEx("乔兄慢走。",0,1)
		instruct_2(147,1)--天龙八部
		AddPersonAttrib(0,"品德",10)
		if GetS(111,0,0,0) == 0 then 
            say("少侠既已悔改，老僧就破例指点少侠一二。",114)
		    say("多谢大师。",0)
            if yesno("是否领悟？") then 
	            QZXS("领悟金刚不坏神功！")
	            say("果然厉害!") 
	            instruct_0();
	            SetS(111, 0, 0, 0,151)
				addthing(288)
            end
        end
    else
		TalkEx("小施主武功盖世，老衲甘拜下风。望施主以后能少增杀戮。",114,0)
		TalkEx("这些东西就赠予施主，希望施主能悬崖勒马。",114,0)
		addHZ(32)
		addHZ(40)
		addHZ(48)
		addHZ(51)
		addHZ(79)
		addHZ(114)
		addHZ(115)
		addHZ(143)
		addthing(13, 10)
	    addthing(69)
		addthing(88)
		addthing(90)
		instruct_2(147,1)--天龙八部
	end
	instruct_12()
	TalkEx("少侠情况如何？",48,0)
	TalkEx("几位的恩怨已经清了，请群雄撤下少室山吧。",0,1)
	if PersonKF(0, 58) and GetS(113, 0, 0, 0) == 0 then
        say("少侠，这是我慕容氏八部修罗刀法的绝学精要，现在就送予少侠",51) 
	    say("难道是传说中的阿鼻道三刀？",0) 
	    say("现在父亲皈依佛门不问俗事，只是不希望先人的武学在他手上失传，而少侠帮我慕容家多次，这是报答少侠的",51)
		if instruct_11(0,188) == true then
            say("那就却之不恭了",0) 					 
	        QZXS("领悟修罗刀精要！")
	        instruct_0();
	        say("果然博大精深",0) 
	        setLW1(58)
			addthing(158)
		else
			say("我就不勉强少侠了",51) 
		end
    end			
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_14();   --  14(E):场景变黑
	instruct_3(-2,0,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
	instruct_3(-2,35,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [35]
	instruct_3(-2,34,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [34]
	instruct_3(-2,33,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [33]
	instruct_3(-2,32,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [32]
	instruct_3(-2,31,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [31]
	instruct_3(-2,30,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [30]
	instruct_3(-2,29,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [29]
	instruct_3(-2,28,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [28]
	instruct_3(-2,27,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
	instruct_3(-2,26,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [26]
	instruct_3(-2,6,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
	instruct_3(-2,5,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [5]
	instruct_3(-2,4,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [4]
	instruct_3(-2,3,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
	instruct_3(-2,2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
	instruct_3(-2,1,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
	instruct_3(-2,62,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [62]
	instruct_3(-2,66,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [66]
	instruct_3(-2,65,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [65]
	instruct_3(-2,64,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [64]
	instruct_3(-2,63,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [63]
	instruct_3(-2,70,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [70]
	instruct_3(-2,58,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [58]
	instruct_3(-2,57,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [57]
	instruct_3(-2,56,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [56]
	instruct_3(-2,55,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [55]
	instruct_3(-2,54,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [54]
	instruct_3(-2,53,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [53]
	instruct_3(-2,52,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [52]
	instruct_3(-2,51,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [51]
	instruct_3(-2,50,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [50]
	instruct_3(-2,49,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [49]
	instruct_3(-2,48,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [48]
	instruct_3(-2,68,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [68]
	instruct_3(-2,69,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [69]
	instruct_3(-2,71,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [71]
	instruct_3(-2,67,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [67]
	instruct_3(-2,59,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [59]
	instruct_3(-2,14,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
	instruct_3(-2,60,0,0,0,0,0,0,0,0,0,0,0);  --  3(3):修改事件定义:当前场景:场景事件编号 [60]
	instruct_3(-2,61,0,0,0,0,0,0,0,0,0,0,0);  --  3(3):修改事件定义:当前场景:场景事件编号 [61]
	instruct_3(-2,101,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
	instruct_3(-2,102,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
	instruct_3(-2,103,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
	instruct_3(-2,104,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
	instruct_3(-2,100,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
    instruct_3(52,1,1,0,586,0,0,6302,6302,6302,-2,-2,-2)
    instruct_3(52,2,1,0,587,0,0,6298,6298,6298,-2,-2,-2)
	instruct_3(51,39,0,0,596,0,0,3188*2,3188*2,3188*2,-2,-2,-2)--铁丑和阿紫可以加入
    instruct_3(51,14,1,0,596,0,0,3189*2,3189*2,3189*2,-2,-2,-2)
end

OEVENTLUA[10005] = function() --铁头加入
	if instruct_16(47) then
		say("阿紫姑娘！阿紫姑娘！",48,0,"游坦之") 
		instruct_0();
		say("你这个铁头，原来还活着啊。",47,0,"阿紫") 
		instruct_0();		
		say("为什么，为什么要离开我！",48,0,"游坦之") 
		instruct_0();	
		say("你这个人这么无趣，又没有用，这位少侠比你好玩多了。",47,0,"阿紫") 
		instruct_0();	
		say("原来是你这个家伙！",48,0,"游坦之") 
		instruct_0();		
		TalkEx("我，我什么都没做啊。。。",0,1)
		instruct_0();
		  --JY.Person[48]["攻击力"] = 100
		  --JY.Person[48]["防御力"] = 80
		 -- JY.Person[48]["轻功"] = 70		
		if instruct_6(88) ==false then     --单挑铁头
			instruct_15(0);   --  15(F):战斗失败，死亡
			do return; end
			instruct_0();   --  0(0)::空语句(清屏)
		end    --:Label1		
		instruct_13();   --  13(D):重新显示场景
		instruct_0();   --  0(0)::空语句(清屏)	
		TalkEx("这位大哥，你先息怒。如果你想跟着阿紫姑娘的话，不如加入我们吧。阿紫姑娘你就可怜一下这位大哥吧。",0,1)
		instruct_0();	
		say("好吧，看在你这么忠诚的份上，就让你跟着我们了。",47,0,"阿紫") 
		instruct_0();	
		say("谢谢，谢谢阿紫姑娘！谢谢这位少侠！我这就去小村帮你们收拾好屋子。",48,0,"游坦之") 
		instruct_0();					
		instruct_14();   --  14(E):场景变黑

		instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,-2,-2);
		instruct_3(104,74,1,0,961,0,0,6378,6378,6378,-2,-2,-2); --钓鱼岛
		instruct_3(70,24,1,0,135,0,0,6380,6380,6380,-2,-2,-2); 			
		instruct_13();   --  13(D):重新显示场景			
	else
		say("你是谁？别烦老子！",48,0,"游坦之") 
		instruct_0();		
	end	
end


OEVENTLUA[10002] = function() --欧阳克加入
	TalkEx("欧阳克！你怎么在这里！",0,1)
	instruct_0();
	say("你认识我吗？我什么都不记得了。。。我到底是谁？为什么我醒来后就到了这里的河边？",61,0,"欧阳克") 
	instruct_0();	
	TalkEx("（这家伙竟然还没死，他不会被我打得失去记忆了吧。。这样的话我是不是应该乘机引他走上正道呢？）",0,1)
	instruct_0();
	if instruct_9() == true then
		if not instruct_20() then		
			TalkEx("你是我以前的小弟，后来你被人追杀，我到处找你，原来你在这里。",0,1)
			instruct_0();
			say("你是我的大哥？大哥！",61,0,"欧阳克") 
			say("（突然蹦出来人说是我大哥，当我会信？）",61,0,"欧阳克")
			say("（但现在我也不知道我是谁，先跟著他吧）",61,0,"欧阳克")
			JY.Person[61]["武功等级1"]=10
			JY.Person[61]["武功等级2"]=400
			instruct_0();			
			instruct_14();   --  14(E):场景变黑
			instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,-2,-2);
			instruct_13();   --  13(D):重新显示场景
			instruct_10(61);	
			instruct_2(73,1) --得到蛤蟆功
			instruct_2(241,1) --得到瞬息千里
			--instruct_2(246,1) --得到扇子
			if MPPD(0) == 0 then
				say("看他这个样子，不知道他那些“弟子”们该怎么办？")
				if DrawStrBoxYesNo(-1, -1, "要去白驼山庄解决问题么？", C_WHITE, 30) == true then
					say("打傻了他终究是我的过失，总不能让那些女子失了依靠。")
					JoinMP(0, 8, 1)
				else
					say("...算了，那些女子也不是蠢人，自有出路。")
				end
			end
		else
			say("你们，你们这么多人想干什么...",61,0,"欧阳克") 
			instruct_0();
		end
	else
		say("我到底是谁啊...",61,0,"欧阳克") 
		instruct_0();
	end
end

OEVENTLUA[10003] = function()	--欧阳克离队事件
    Talk("小弟，你先回小村，有需要时，我再去找你帮忙。",0);
    instruct_21(61);   --  21(15):离队
	SetS(70,19,41,3,99); 
    instruct_3(70,99,1,0,10004,0,0,7972,7972,7972,-2,-2,-2);   --  3(3):修改事件定义:场景[小村]:场景事件编号 [47]
end

OEVENTLUA[10004] = function()	--欧阳克小村
		MyTalk("有需要我帮忙的地方吗？", 61);
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_9(0,29) ==true then    --  9(9):是否要求加入?否则跳转到:Label1

        if instruct_20(20,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label2
            instruct_10(61);   
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
            do return; end
        end    --:Label2

				MyTalk("你的队伍已满，我无法加入。", 61);
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label1
end

OEVENTLUA[883] = function() --笑傲邪线
    instruct_14();   --  14(E):场景变黑
    instruct_26(40,17,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_26(40,18,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [10]
    instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [11]
    instruct_3(-2,12,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
    instruct_35(19,0,48,999);   --  35(23):设置岳不群武功1:辟邪剑法攻击力999
    instruct_47(19,50);   --  47(2F):岳不群增加攻击力50
   --[[ instruct_35(36,0,48,999);   --  35(23):设置林平之武功0:辟邪剑法攻击力999
    instruct_47(36,100);   --  47(2F):林平之增加攻击力100
    instruct_45(36,200);   --  45(2D):林平之增加轻功200

    instruct_46(36,800);   --  46(2E):林平之增加内力1000
    instruct_48(36,300);   --  48(30):林平之增加生命500]]
	  JY.Person[36]["生命"] = 750
	  JY.Person[36]["生命最大值"] = 750
	  JY.Person[36]["内力"] = 3000
	  JY.Person[36]["内力最大值"] = 3000
	  JY.Person[36]["攻击力"] = 240
	  JY.Person[36]["防御力"] = 150
	  JY.Person[36]["轻功"] = 350
	  JY.Person[36]["等级"] = 20
	  JY.Person[36]["受伤程度"] = 0
	  JY.Person[36]["中毒程度"] = 0
	  JY.Person[36]["武功等级1"] = 999	
	  JY.Person[36]["御剑能力"] = JY.Person[36]["御剑能力"] + 30
    instruct_35(22,0,48,999);   --  35(23):设置左冷禅武功1:辟邪剑法攻击力999
    instruct_47(22,50);   --  47(2F):左冷禅增加攻击力50
    instruct_35(79,0,34,900);   --  35(23):设置岳灵珊武功0:太岳三青峰攻击力900
    instruct_35(79,1,31,900);   --  35(23):设置岳灵珊武功1:泰山十八盘攻击力900
    instruct_35(79,2,32,900);   --  35(23):设置岳灵珊武功2:云雾十三式攻击力900
    instruct_47(79,100);   --  47(2F):岳灵珊增加攻击力100
    instruct_46(79,1000);   --  46(2E):岳灵珊增加内力1000
    instruct_48(79,400);   --  48(30):岳灵珊增加生命400
    instruct_13();   --  13(D):重新显示场景
    instruct_25(18,27,13,20);   --  25(19):场景移动18-27--13-20
    instruct_1(3476,19,0);   --  1(1):[岳不群]说: 你终于醒了，你怎么会昏倒*在林家的向阳老宅？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3478,35,0);   --  1(1):[令狐冲]说: 师父，徒儿得知任我行重出*江湖，就想向师父通禀此事*，当我到了福建的时候看到*有人夺了去林师弟的辟邪剑*谱，我杀了那人，抢了回来*。可我也受了重伤，迷迷糊*糊的昏了过去。师父，我怎*么到了这里？是您救我回来*的么？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3479,19,0);   --  1(1):[岳不群]说: 今儿早晨到平之的向阳巷老*宅去，在门外见你晕在地下*。冲儿，辟邪剑谱你放在了*什么地方？这是平之的物事*，该当由他收管。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3480,35,0);   --  1(1):[令狐冲]说: 我受伤晕倒，蒙师父所救。*此后这剑谱，便不在我身上*。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3481,36,0);   --  1(1):[林平之]说: 令狐冲！依你说来，倒是师*父私吞了剑谱？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3482,35,0);   --  1(1):[令狐冲]说: 弟子不敢。不过弟子昏迷后*真的不知道剑谱的下落了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3483,36,0);   --  1(1):[林平之]说: 哼！师父，定是令狐冲贪恋*我家祖传的剑谱，私藏在秘*密的地方，却跟咱们做戏。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_25(13,20,18,27);   --  25(19):场景移动13-20--18-27
    instruct_1(3485,0,1);   --  1(1):[AAA]说: ＜按说令狐冲应该不会偷拿*林家的剑谱，但是人心隔肚*皮，谁又知道呢？我该相信*令狐冲吗？＞
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_11(0,218) ==true then    --  11(B):是否住宿否则跳转到:Label0
        instruct_1(3486,0,1);   --  1(1):[AAA]说: ＜令狐大哥绝不是那种人！*我要帮他！＞
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_30(18,27,15,27);   --  30(1E):主角走动18-27--15-27
        instruct_30(15,27,15,22);   --  30(1E):主角走动15-27--15-22
        instruct_1(3487,0,1);   --  1(1):[AAA]说: 林兄弟，你的祖传之物得而*复失，这种心情我们可以理*解，但是从我和令狐兄弟的*交往过程中，我可以担保拿*走剑谱的绝对另有其人，咱*们慢慢调查，不能妄下结论*，以免伤了同门之谊。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(3488,19,0);   --  1(1):[岳不群]说: 同门之谊？哼。他的剑法已*经远高于我了，早已不将我*当作他的师父了，他不仅不*听师训，结交奸邪，还和魔*教长老杀害我正派弟子，还*会念什么同门之谊？从今日*起，我把你逐出师门，以后*不要再说你是我华山门下了*。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(3489,0,1);   --  1(1):[AAA]说: ……*岳掌门，令狐兄弟的确做错*了不少事，您可以按门规处*罚，但是逐出门墙的责罚，*是不是有些太重了？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(3490,19,0);   --  1(1):[岳不群]说: 魔教任教主的小姐对他照顾*有加，他早已跟他们勾结在*一起，还要我这师父干甚么*？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(3491,35,0);   --  1(1):[令狐冲]说: 魔教任教主的小姐？师父这*话不知从何说起？虽然听说*那任我行有个女儿，可是弟*子从来没见过。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(3492,19,0);   --  1(1):[岳不群]说: 孽徒，到了此刻，你又何必*再说谎？那位任小姐召集平*一指给你医病，还送你上少*林，这你还能抵赖的掉么？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(3493,35,0);   --  1(1):[令狐冲]说: 她……她……盈盈是任教主*之女？这……这真是从何说*起？弟子当真不知呀。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(3494,19,0);   --  1(1):[岳不群]说: 你聪明伶俐，何等机警，怎*会猜想不到她便是任我行之*女？令狐冲，今天念在你重*伤在身，我不为难你，我已*经搜过你的身上了，剑谱现*在不在你的身上，限你3日*之内把剑谱乖乖交出来，否*则自古正邪不两立，下次再*见面的时候不是我杀了你，*就是你杀了我。你好自为之*吧。姗儿，平之，我们走。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(3495,36,0);   --  1(1):[林平之]说: 哼。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(3496,79,0);   --  1(1):[???]说: 令狐冲，你以后就不再是我*的大师兄了。你要是真拿了*小林子的剑谱，最好趁早交*出来！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(3497,35,0);   --  1(1):[令狐冲]说: 师父、小师妹……。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_14();   --  14(E):场景变黑
        instruct_3(-2,9,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [9]
        instruct_3(-2,8,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [8]
        instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [7]
        instruct_19(13,21);   --  19(13):主角移动至D-15
        instruct_40(0);   --  40(28):改变主角站立方向0
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_1(3498,0,1);   --  1(1):[AAA]说: 哎，事已至此，令狐大哥不*必难过。不知令狐大哥的伤*势如何了？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(3499,35,0);   --  1(1):[令狐冲]说: 自从修习了任教主的吸星大*法，已经好多了。唉……如*今师父也不要我了，我真的*做错了吗？。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(3500,0,1);   --  1(1):[AAA]说: 尊师只是一时误会，我们一*起去找剑谱，洗刷你的冤屈*。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(3501,35,0);   --  1(1):[令狐冲]说: 也只好如此了。好兄弟，陪*我到附近的酒馆喝两杯怎么*样？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(3502,0,1);   --  1(1):[AAA]说: 好啊，咱们这就走。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_3(1,15,0,0,0,0,884,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[河洛客栈]:场景事件编号 [15]
        instruct_45(35,40);   --  45(2D):令狐冲增加轻功40

        if instruct_20(18,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label1
            instruct_3(-2,6,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
            instruct_10(35);   --  10(A):加入人物[令狐冲]
            instruct_0();   --  0(0)::空语句(清屏)
            do return; end
        end    --:Label1

        instruct_1(12,35,0);   --  1(1):[令狐冲]说: 你的队伍已满，我就直接去*小村吧。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_3(-2,6,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
        instruct_3(70,15,1,0,121,0,0,5722,5748,5722,-2,-2,-2);   --  3(3):修改事件定义:场景[小村]:场景事件编号 [15]
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0

    instruct_1(3665,0,1);   --  1(1):[AAA]说: ＜算了，还是不要多管闲事*了，况且我也不知道是不是*令狐冲拿的。不知道这辟邪*剑谱到底是什么东西，既然*大家都在抢，一定是个好东*西。我就在旁边看看热闹，*说不定就能捡个便宜。＞
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3666,35,0);   --  1(1):[令狐冲]说: 师父，我是您从小看着长大*的，难道您还信不过徒儿的*为人吗？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3667,19,0);   --  1(1):[岳不群]说: 哼！就因为从小看着你长大*，我才会如此痛心。令狐冲*啊令狐冲，你怎么就不明正*邪之分呢？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3668,35,0);   --  1(1):[令狐冲]说: 师父，我……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3670,19,0);   --  1(1):[岳不群]说: 不要再叫我师父。你的剑法*早已超过我，我哪里还有资*格做你的师父！魔教任教主*的小姐对你照顾有加，你早*已跟他们勾结在一起，还要*我这师父干甚么？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3491,35,0);   --  1(1):[令狐冲]说: 魔教任教主的小姐？师父这*话不知从何说起？虽然听说*那任我行有个女儿，可是弟*子从来没见过。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3492,19,0);   --  1(1):[岳不群]说: 孽徒，到了此刻，你又何必*再说谎？那位任小姐召集平*一指给你医病，还送你上少*林，这你还能抵赖的掉么？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3493,35,0);   --  1(1):[令狐冲]说: 她……她……盈盈是任教主*之女？这……这真是从何说*起？弟子当真不知呀。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3494,19,0);   --  1(1):[岳不群]说: 你聪明伶俐，何等机警，怎*会猜想不到她便是任我行之*女？令狐冲，今天念在你重*伤在身，我不为难你，我已*经搜过你的身上了，剑谱现*在不在你的身上，限你3日*之内把剑谱乖乖交出来，否*则自古正邪不两立，下次再*见面的时候不是我杀了你，*就是你杀了我。你好自为之*吧。姗儿，平之，我们走。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3495,36,0);   --  1(1):[林平之]说: 哼。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3496,79,0);   --  1(1):[???]说: 令狐冲，你以后就不再是我*的大师兄了。你要是真拿了*小林子的剑谱，最好趁早交*出来！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3497,35,0);   --  1(1):[令狐冲]说: 师父、小师妹……。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,9,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [9]
    instruct_3(-2,8,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [8]
    instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [7]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_30(18,27,15,27);   --  30(1E):主角走动18-27--15-27
    instruct_30(15,27,15,22);   --  30(1E):主角走动15-27--15-22
    instruct_1(3671,0,1);   --  1(1):[AAA]说: 令狐大哥，你的内伤好些了*吗？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3672,35,0);   --  1(1):[令狐冲]说: 小兄弟，是你啊。自从修习*了任教主的吸星大法，已经*好多了。唉……如今师父也*不要我了，我真的做错了吗*？。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3673,0,1);   --  1(1):[AAA]说: 令狐大哥，我不知道你是不*是真的拿了那什么辟邪剑谱*。如果你真的拿了，又不想*让别人知道，小弟一定替你*保密，你放心好了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3674,35,0);   --  1(1):[令狐冲]说: 你……连你也不信我？师父*、师妹、师弟都不相信我，*小兄弟你也不相信我，难道*这世上便没有人相信我令狐*冲了吗？………………不，*不，还有盈盈，我要去找她*，我要去找盈盈！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,6,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
    instruct_3(93,2,0,0,0,0,912,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[少室山下]:场景事件编号 [2]
    instruct_3(81,0,0,0,0,0,919,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[思过崖]:场景事件编号 [0]
	--设置曲非烟龙门客栈事件
	SetS(60,51,29,3,36); --
	SetS(60,51,28,3,37); --
	SetS(60,51,27,3,38); --
	
	instruct_3(60,36,0,0,0,0,10008,0,0,0,-2,-2,-2); 
	instruct_3(60,37,0,0,0,0,10008,0,0,0,-2,-2,-2); 
	instruct_3(60,38,0,0,0,0,10008,0,0,0,-2,-2,-2); 
	
	--设置曲非烟龙门客栈贴图
	SetS(60,56,33,3,39); --
	SetS(60,54,33,3,40); --
	SetS(60,54,31,3,41); --	
	SetS(60,56,31,3,42); --	
	
	instruct_3(60,39,1,0,0,0,0,5238,5238,5238,-2,-2,-2); 
	instruct_3(60,40,1,0,0,0,0,7002,7002,7002,-2,-2,-2); 
	instruct_3(60,41,1,0,0,0,0,9288,9288,9288,-2,-2,-2); 
	instruct_3(60,42,1,0,0,0,0,9288,9288,9288,-2,-2,-2); 
	
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
end



OEVENTLUA[10006] = function()	--曲非烟离队事件
	Talk("曲姑娘，你先回小村，有需要时，我再去找你帮忙。",0);
    instruct_21(581);   --  21(15):离队
	instruct_3(70,35,1,0,10007,0,0,7002,7002,7002,-2,-2,-2);   --  3(3):修改事件定义:场景[小村]:场景事件编号 [35]
end

OEVENTLUA[10007] = function()	--曲非烟小村
		MyTalk("有需要我帮忙的地方吗？", 581);
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_9(0,29) ==true then    --  9(9):是否要求加入?否则跳转到:Label1

        if instruct_20(20,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label2
            instruct_10(581);   
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
            do return; end
        end    --:Label2

				MyTalk("你的队伍已满，我无法加入。", 581);
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label1
end

OEVENTLUA[10008] = function()	--曲非烟加入事件
	TalkEx("咦，前面有打斗声。",0,1)
	instruct_0();
	say("爷爷，爷爷你怎么了！",581) 
	instruct_0();
	say("嘿嘿，魔教曲洋已经伏诛，小丫头，这次轮到你了！",198,0,"嵩山弟子") 
	instruct_0();
	TalkEx("住手！",0,1)
	instruct_0();
	say("怎么，你这小子也是魔教妖孽？",198,0,"嵩山弟子") 
	instruct_0();
	TalkEx("你管我是谁，竟然对一个小姑娘下手，嵩山派果然都是无耻之徒！",0,1)
	instruct_0();
	say("臭小子！找死！",198,0,"嵩山弟子") 
	instruct_0();
	say("....",20,0,"？？？") 
	instruct_0();
	TalkEx("你是....？",0,1)
	instruct_0();
	say("....",20,0,"？？？") 
	instruct_0();
	
	if instruct_6(256) ==false then     --救非烟
		instruct_15(0);   --  15(F):战斗失败，死亡
		do return; end
		instruct_0();   --  0(0)::空语句(清屏)
	end    --:Label1
	addHZ(39)
	instruct_3(60,41,1,0,0,0,0,0,0,0,-2,-2,-2); 
	instruct_3(60,42,1,0,0,0,0,0,0,0,-2,-2,-2); 
	instruct_13();   --  13(D):重新显示场景
	instruct_0();   --  0(0)::空语句(清屏)		
	
	TalkEx("好快的剑....",0,1)	
	instruct_0();
	say("....",20,0,"？？？") 
	instruct_0();
	TalkEx("那位前辈怎么走得这么快。",0,1)	
	instruct_0();
	say("爷爷....呜呜呜....",581) 	
	instruct_0();
	TalkEx("小妹妹，人死不能复生....我们先把你爷爷葬了吧....",0,1)	
	instruct_0();
	say("呜呜呜....",581) 
	instruct_0();
	
	instruct_14();   --  14(E):场景变黑
	instruct_3(60,39,1,0,0,0,0,0,0,0,-2,-2,-2); 
	instruct_13();   --  13(D):重新显示场景
	
	instruct_0();
	TalkEx("小妹妹，你叫什么名字？",0,1)	
	instruct_0();
	say("曲非烟....",581) 	
	instruct_0();
	TalkEx("你....如果没有地方去的话，跟我们一起走吧？我叫人把你先送回小村，那里有很多很多朋友，我们都会照顾你的。",0,1)	
	instruct_0();
	say("大哥哥，谢谢....",581) 

	instruct_14();   --  14(E):场景变黑
	instruct_3(60,39,1,0,0,0,0,0,0,0,-2,-2,-2); 
	instruct_3(60,36,0,0,0,0,0,0,0,0,-2,-2,-2); 
	instruct_3(60,37,0,0,0,0,0,0,0,0,-2,-2,-2); 
	instruct_3(60,38,0,0,0,0,0,0,0,0,-2,-2,-2); 
	instruct_3(60,40,1,0,0,0,0,0,0,0,-2,-2,-2); 	
	instruct_13();   --  13(D):重新显示场景	
	instruct_3(70,35,1,0,10007,0,0,7002,7002,7002,-2,-2,-2);   --曲非烟加入
end


OEVENTLUA[10007] = function()	--曲非烟小村
		MyTalk("有需要我帮忙的地方吗？", 581);
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_9(0,29) ==true then    --  9(9):是否要求加入?否则跳转到:Label1

        if instruct_20(20,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label2
            instruct_10(581);   
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
            do return; end
        end    --:Label2

				MyTalk("你的队伍已满，我无法加入。", 581);
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label1
end

OEVENTLUA[301] = function() --天龙正+倚天邪，加入鸠摩智场景和少林入门
    if instruct_60(-2,38,2286,0,46) ==true then    --  60(3C):判断场景-2事件位置38是否有贴图2286否则跳转到:Label0

        if instruct_16(49,0,42) ==true then    --  16(10):队伍是否有[虚竹]否则跳转到:Label1
            instruct_3(-2,38,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [38]
            instruct_3(-2,16,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [16]
            instruct_14();   --  14(E):场景变黑
            instruct_13();   --  13(D):重新显示场景
            instruct_1(2599,49,0);   --  1(1):[虚竹]说: 谢谢施主送我回少林，我这*就去了。佛祖曾经对我说，*如果有人送我回少林，那这*个人就是个好人，因为他放*弃了小无相功、天山六阳掌*、天山折梅手、八荒六合功*等武功，因此佛祖要给这个*人加上十点道德。施主，你*真是个好人，再会。
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_21(49);   --  21(15):[虚竹]离队
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_37(10);   --  37(25):增加道德10
			dark()
			addevent(-2, 85, 0, 0, 0, 5374)
			light()			
			say("阿弥陀佛。施主把虚竹师侄送回寺内，这一路辛苦了。种因就得果，施主舍弃了一些东西，老衲就回赠给施主其他的东西吧。",169,0,"空见")	
			addthing(288)
			addthing(280)
			say("谢谢大师！")
	        if GetS(111, 0, 0, 0) == 0 then
	            say("阿弥陀佛，这是贫僧的一点心得，施主也且收下。",169,0,"空见") 
	            instruct_0();
			    if instruct_11(0,188) == true then
	                QZXS("领悟金刚不坏神功奥妙！")
	                instruct_0();
	                say("多谢大师",0) 
	                SetS(111, 0, 0, 0,151)
				else
				    say("在下岂能如此贪心，大师的好意在下心领了。",0) 
				end
            end
			dark()
			null(-2, 85)
			light()
			if GetS(106, 5, 1, 1) ~= -1 then
				SetS(106, 5, 1, 1, 2)
				SetS(28, 16, 12, 3, 99)
				instruct_3(28,99,1,0,31030,0,0,5374,5374,5374,-2,-2,-2); 		
			else
				SetS(106, 5, 1, 1, 1)
			end			
            do return; end
            instruct_0();   --  0(0)::空语句(清屏)
        end    --:Label1

    end    --:Label0


    if instruct_60(-2,36,2286,0,935) ==true then    --  60(3C):判断场景-2事件位置36是否有贴图2286否则跳转到:Label2
        instruct_14();   --  14(E):场景变黑
        instruct_3(-2,36,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [36]
        instruct_3(-2,16,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [16]
        instruct_3(-2,0,0,0,0,0,0,5372,5372,5372,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
        instruct_3(-2,34,0,0,0,0,0,5372,5372,5372,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [34]
        instruct_3(-2,35,0,0,0,0,0,5372,5372,5372,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [35]
        instruct_3(-2,1,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
        instruct_3(-2,33,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [33]
        instruct_3(-2,32,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [32]
        instruct_3(-2,31,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [31]
        instruct_3(-2,30,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [30]
        instruct_3(-2,29,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [29]
        instruct_3(-2,28,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [28]
        instruct_3(-2,27,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
        instruct_3(-2,26,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [26]
        instruct_3(-2,6,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
        instruct_3(-2,5,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [5]
        instruct_3(-2,4,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [4]
        instruct_3(-2,3,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
        instruct_3(-2,2,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_30(53,19,50,19);   --  30(1E):主角走动53-19--50-19
        instruct_30(50,19,50,40);   --  30(1E):主角走动50-19--50-40
        instruct_30(50,40,46,40);   --  30(1E):主角走动50-40--46-40
        instruct_1(1024,0,1);   --  1(1):[AAA]说: 咦？今天少林寺怎么这么大*阵势？难道是专门迎接我的*吗？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1025,70,0);   --  1(1):[玄慈]说: 施主远道而来，不知有何见*教？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1026,0,1);   --  1(1):[AAA]说: 我……随便看看……*＜嘿嘿*，老和尚想不到吧，我是来*替明教报仇的，想把少林寺*夷为平地……＞
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1027,70,0);   --  1(1):[玄慈]说: 据老衲所知，施主此来是要*为明教报仇，想把少林寺夷*为平地。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1028,0,1);   --  1(1):[AAA]说: 你——！*＜谢法王和范右使怎么还没*到，要坏……＞
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1029,70,0);   --  1(1):[玄慈]说: 明教已然覆灭，阁下何必再*添杀戮。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1030,0,1);   --  1(1):[AAA]说: 谁说明教覆灭了，金毛狮王*谢逊和光明右使范遥还都在*呢。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1031,70,0);   --  1(1):[玄慈]说: 他二人已然皈依我佛。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1032,245,1);   --  1(1):[???]说: 什么？不可能！老和尚，我*要见他二人！
        instruct_0();   --  0(0)::空语句(清屏)

        if instruct_6(80,1,0,1) ==false then    --  6(6):战斗[80]是则跳转到:Label3
            instruct_0();   --  0(0)::空语句(清屏)
        end    --:Label3

        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_1(1033,70,0);   --  1(1):[玄慈]说: 少林寺乃佛门圣地，施主不*要再打了，阿弥陀佛，我这*就带施主去见他二人
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_3(-2,0,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
        instruct_3(-2,35,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [35]
        instruct_3(-2,41,0,0,0,0,0,8232,8232,8232,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [41]
        instruct_3(-2,40,0,0,0,0,0,8232,8232,8232,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [40]
        instruct_3(-2,45,0,0,0,0,0,8232,8232,8232,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [45]
        instruct_3(-2,44,0,0,0,0,0,6388,6388,6388,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [44]
        instruct_3(-2,46,0,0,0,0,0,5334,5334,5334,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [46]
        instruct_3(-2,43,0,0,0,0,0,5294,5294,5294,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [43]
        instruct_3(-2,34,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [34]
        instruct_3(-2,33,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [33]
        instruct_3(-2,32,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [32]
        instruct_3(-2,31,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [31]
        instruct_3(-2,30,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [30]
        instruct_3(-2,29,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [29]
        instruct_3(-2,28,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [28]
        instruct_3(-2,27,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
        instruct_3(-2,26,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [26]
        instruct_3(-2,6,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
        instruct_3(-2,5,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [5]
        instruct_3(-2,4,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [4]
        instruct_3(-2,3,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
        instruct_3(-2,2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
        instruct_3(-2,1,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
        instruct_19(33,50);   --  19(13):主角移动至21-32
        instruct_25(33,50,33,50);   --  25(19):场景移动33-50--33-50
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_1(1034,13,0);   --  1(1):[谢逊]说: 无我相、无人相、无众生相*、无寿者相……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1035,0,1);   --  1(1):[AAA]说: 谢法王，真的是你？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1036,13,0);   --  1(1):[谢逊]说: 弟子罪孽深重，盼方丈收留*，赐予剃度。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1037,0,1);   --  1(1):[AAA]说: 啊？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1038,114,0);   --  1(1):[???]说: 老僧收你为徒。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1039,13,0);   --  1(1):[谢逊]说: 弟子不敢望此福缘。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1040,114,0);   --  1(1):[???]说: 空固是空，圆亦是空，我相*人相，好不懵懂！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1041,13,0);   --  1(1):[谢逊]说: 师父是空，弟子是空，无罪*无业，无德无功！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1042,114,0);   --  1(1):[???]说: 善哉，善哉！你归我门下，*仍是叫作谢逊，你懂了么？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1043,13,0);   --  1(1):[谢逊]说: 弟子懂得。牛屎谢逊，皆是*虚影，身既无物，何况于名*？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1044,0,1);   --  1(1):[AAA]说: ＜糟糕糟糕，看来成昆老贼*的计划要泡汤，我得赶紧另*想出路……＞**谢法王，这，那，我要的*《倚天屠龙记》一书怎么办*啊？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1045,10,0);   --  1(1):[范遥]说: 小兄弟，我们俩受少林高僧*点化，已知我明教真正的仇*人其实是成昆，只要你帮我*们除掉成昆，这本倚天屠龙*记就送给你。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1046,13,0);   --  1(1):[谢逊]说: 师父恕罪，弟子也有此念。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1047,70,0);   --  1(1):[玄慈]说: 杀恶人即使善念，那成昆为*祸武林……阿弥陀佛……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1048,0,1);   --  1(1):[AAA]说: 好，一言为定，我这就去找*成昆。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1049,70,0);   --  1(1):[玄慈]说: 阿弥陀佛，善哉善哉。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1049,169,0);   --  1(1):[???]说: 阿弥陀佛，善哉善哉。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1049,170,0);   --  1(1):[???]说: 阿弥陀佛，善哉善哉。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_14();   --  14(E):场景变黑
        instruct_3(-2,40,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [40]
        instruct_3(-2,45,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [45]
        instruct_3(-2,44,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [44]
        instruct_3(-2,46,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [46]
        instruct_3(-2,43,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [43]
        instruct_3(-2,41,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [41]
        instruct_3(-2,12,-2,0,-2,303,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
        instruct_3(9,0,0,0,0,0,302,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[成崑居]:场景事件编号 [0]
        instruct_3(9,1,0,0,0,0,0,5296,5296,5296,-2,-2,-2);   --  3(3):修改事件定义:场景[成崑居]:场景事件编号 [1]
        instruct_3(9,2,0,0,0,0,0,6092,6092,6092,-2,-2,-2);   --  3(3):修改事件定义:场景[成崑居]:场景事件编号 [2]
        instruct_3(9,3,0,0,0,0,0,6788,6788,6788,-2,-2,-2);   --  3(3):修改事件定义:场景[成崑居]:场景事件编号 [3]
        instruct_3(9,4,0,0,0,0,0,5892,5892,5892,-2,-2,-2);   --  3(3):修改事件定义:场景[成崑居]:场景事件编号 [4]
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label2


    if instruct_60(-2,37,2286,0,1815) ==true then    --  60(3C):判断场景-2事件位置37是否有贴图2286否则跳转到:Label4
        instruct_37(3);   --  37(25):增加道德3
        instruct_26(40,13,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
        instruct_26(40,16,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
        instruct_26(40,15,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
        instruct_26(40,14,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
        instruct_14();   --  14(E):场景变黑
        instruct_3(-2,37,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [37]
        instruct_3(-2,16,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [16]
        instruct_3(-2,0,0,0,0,0,0,5372,5372,5372,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
        instruct_3(-2,34,0,0,0,0,0,5372,5372,5372,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [34]
        instruct_3(-2,35,0,0,0,0,0,5372,5372,5372,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [35]
        instruct_3(-2,1,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
        instruct_3(-2,33,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [33]
        instruct_3(-2,32,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [32]
        instruct_3(-2,31,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [31]
        instruct_3(-2,30,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [30]
        instruct_3(-2,29,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [29]
        instruct_3(-2,28,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [28]
        instruct_3(-2,27,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
        instruct_3(-2,26,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [26]
        instruct_3(-2,6,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
        instruct_3(-2,5,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [5]
        instruct_3(-2,4,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [4]
        instruct_3(-2,3,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
        instruct_3(-2,2,0,0,0,0,0,5420,5420,5420,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
        instruct_3(-2,48,0,0,0,0,0,6380,6380,6380,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [48]
        instruct_3(-2,58,0,0,0,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [58]
        instruct_3(-2,57,0,0,0,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [57]
        instruct_3(-2,56,0,0,0,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [56]
        instruct_3(-2,55,0,0,0,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [55]
        instruct_3(-2,54,0,0,0,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [54]
        instruct_3(-2,53,0,0,0,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [53]
        instruct_3(-2,52,0,0,0,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [52]
        instruct_3(-2,51,0,0,0,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [51]
        instruct_3(-2,50,0,0,0,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [50]
        instruct_3(-2,49,0,0,0,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [49]
        instruct_3(-2,59,0,0,0,0,0,6304,6304,6304,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [59]
        instruct_3(-2,61,1,0,572,0,0,6312,6312,6312,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [61]
        instruct_3(-2,60,1,0,572,0,0,7136,7136,7136,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [60]
        instruct_3(-2,62,0,0,0,0,0,6084,6084,6084,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [62]
        instruct_3(-2,63,0,0,0,0,0,5330,5330,5330,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [63]
        instruct_3(-2,64,0,0,0,0,0,8212,8212,8212,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [64]
        instruct_3(-2,65,0,0,0,0,0,7128,7128,7128,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [65]
        instruct_3(-2,66,0,0,0,0,0,7126,7126,7126,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [66]
        instruct_3(-2,70,0,0,0,0,0,8216,8216,8216,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [70]
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_30(53,19,52,19);   --  30(1E):主角走动53-19--52-19
        instruct_30(52,19,52,37);   --  30(1E):主角走动52-19--52-37
        instruct_40(2);   --  40(28):改变主角站立方向2
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_25(52,37,43,37);   --  25(19):场景移动52-37--43-37
        instruct_25(43,37,43,44);   --  25(19):场景移动43-37--43-44
        instruct_25(43,44,52,44);   --  25(19):场景移动43-44--52-44
        instruct_25(52,44,52,37);   --  25(19):场景移动52-44--52-37
        instruct_25(52,37,48,36);   --  25(19):场景移动52-37--48-36
        instruct_1(2419,48,0);   --  1(1):[游坦之]说: 少林寺玄慈方丈，少林派是*武林中各门派之首，丐帮是*江湖第一大帮，向来并峙中*原，不相统属。今日咱们却*要分个高下，胜者为武林盟*主，败者服从武林盟主号令*，不得有违。天下各位英雄*好汉，今日都聚集在此，有*哪一位不服，尽可向武林盟*主挑战。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2420,70,0);   --  1(1):[玄慈]说: 阿弥陀佛。丐帮数百年来，*乃中原武林的侠义正道，天*下英雄，无不瞻仰。庄帮主*新任帮主，敝派得讯迟了，*未及遣使道贺，不免有简慢*之罪，谨此谢过。却不知庄*帮主今日何以忽兴问罪之师*，还盼见告。天下英雄，俱*在此间，是非曲直，自由公*论。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2421,48,0);   --  1(1):[游坦之]说: 我大宋南有辽国，西有西夏*、吐蕃，北有大理，四夷虎*视眈眈，这个……这个……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2422,245,1);   --  1(1):[???]说: 什么"南有辽国，北有大理"*，好大一个丐帮，竟由你这*种不学无术之人出任帮主，*岂不让天下英雄笑话！你要*争武林盟主是吗？不用玄慈*方丈动手，我先来领教领教*丐帮得降龙十八掌和打狗棒*法！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2423,48,0);   --  1(1):[游坦之]说: 降龙十八掌？……这个……*这个……
        instruct_0();   --  0(0)::空语句(清屏)

        if instruct_6(197,4,0,0) ==false then    --  6(6):战斗[197]是则跳转到:Label5
            instruct_15(0);   --  15(F):战斗失败，死亡
            do return; end
            instruct_0();   --  0(0)::空语句(清屏)
        end    --:Label5

        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_1(2424,245,1);   --  1(1):[???]说: 你这是什么毒功！！身为丐*帮帮主，为什么不用降龙十*八掌？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2425,48,0);   --  1(1):[游坦之]说: 这个……这是……因为……*这个武功比降龙十八掌厉害*……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2426,50,0);   --  1(1):[乔峰]说: 谁说这邪门毒功胜过了降龙*十八掌？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_14();   --  14(E):场景变黑
        instruct_3(-2,69,0,0,0,0,0,8240,8240,8240,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [69]
        instruct_3(-2,68,0,0,0,0,0,6084,6084,6084,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [68]
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_30(52,37,52,43);   --  30(1E):主角走动52-37--52-43
        instruct_30(52,43,45,43);   --  30(1E):主角走动52-43--45-43
        instruct_40(3);   --  40(28):改变主角站立方向3
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2427,247,1);   --  1(1):[???]说: 乔大哥、阿朱姑娘！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2428,50,0);   --  1(1):[乔峰]说: 小兄弟好。今后不要再叫我*乔大哥了。我是契丹人，萧*峰！
        instruct_0();   --  0(0)::空语句(清屏)
		JY.Person[50]["姓名"] = "萧峰"
        instruct_1(2429,247,1);   --  1(1):[???]说: 乔也罢，萧也罢，汉人也好*，契丹也好，你始终是我的*好大哥！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2430,50,0);   --  1(1):[乔峰]说: 哈哈哈，好兄弟！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2431,0,2);   --  1(1):[AAA]说: 众人：*姓乔的，你杀了我的兄长，*血仇未曾得报，今日和你拼*了！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2432,0,2);   --  1(1):[AAA]说: 众人：*这乔峰乃契丹胡虏，人人得*而诛之，今日可再也不能容*他或者走下少室山！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2433,51,0);   --  1(1):[慕容复]说: ＜这乔峰如今已被逐出丐帮*，成为中原武林的公敌，我*正好趁此机会，收揽人心，*以为己助。＞  萧兄，你是*契丹英雄，视我中原豪杰有*如无物，区区姑苏慕容复今*日想领教阁下高招。在下死*在萧兄掌下，也算是为中原*豪杰尽了一分微力，虽死犹*荣。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2434,245,1);   --  1(1):[???]说: 住口！你与萧大哥素无恩怨*，为何一再苦苦相逼！你处*心积虑，收买人心，就为了*你那虚无缥缈的皇帝梦！要*碰我大哥，先过我这一关！
        instruct_0();   --  0(0)::空语句(清屏)

        if instruct_6(198,4,0,0) ==false then    --  6(6):战斗[198]是则跳转到:Label6
            instruct_15(0);   --  15(F):战斗失败，死亡
            do return; end
            instruct_0();   --  0(0)::空语句(清屏)
        end    --:Label6

        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_1(2435,48,0);   --  1(1):[游坦之]说: 杀父之仇，不共戴天，姓萧*的，今日便来做个了断！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2436,50,0);   --  1(1):[乔峰]说: 尽管来吧，萧某何惧！
        instruct_0();   --  0(0)::空语句(清屏)

        if instruct_6(199,4,0,0) ==false then    --  6(6):战斗[199]是则跳转到:Label7
            instruct_15(0);   --  15(F):战斗失败，死亡
            do return; end
            instruct_0();   --  0(0)::空语句(清屏)
        end    --:Label7

        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_1(2437,103,0);   --  1(1):[???]说: 久闻降龙十八掌天下无双，*贫僧也要领教一二。
        instruct_0();   --  0(0)::空语句(清屏)

        if instruct_6(200,4,0,0) ==false then    --  6(6):战斗[200]是则跳转到:Label8
            instruct_15(0);   --  15(F):战斗失败，死亡
            do return; end
            instruct_0();   --  0(0)::空语句(清屏)
        end    --:Label8

        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_1(2438,98,0);   --  1(1):[???]说: ＜这萧峰武功卓绝，而且似*乎与段正淳他们交情不错，*不如今日借着人多势众，将*之除去……＞**我们也上！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2439,207,0);   --  1(1):[???]说: 这萧峰乃是契丹胡虏，武林*公敌，更是我们丐帮的叛徒*，丐帮兄弟们，一起上啊！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2440,245,1);   --  1(1):[???]说: 想仗着人多欺负人吗？来吧*！
        instruct_0();   --  0(0)::空语句(清屏)

        if instruct_6(81,4,0,0) ==false then    --  6(6):战斗[81]是则跳转到:Label9
            instruct_15(0);   --  15(F):战斗失败，死亡
            do return; end
            instruct_0();   --  0(0)::空语句(清屏)
        end    --:Label9

        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_1(2441,76,0);   --  1(1):[???]说: 啊……表哥小心！……公子*手下留情啊！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2442,245,1);   --  1(1):[???]说: 哼，看在王姑娘的面子上，*今日姑且留你一命！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2443,51,0);   --  1(1):[慕容复]说: ＜我……我今日数次惨败，*居然还要女人求情来保住性*命，我还有何颜面活在这世*上，不如干脆……＞
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2444,113,0);   --  1(1):[???]说: 住手！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_3(-2,67,0,0,0,0,0,7132,7132,7132,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [67]
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_1(2445,113,0);   --  1(1):[???]说: 你有儿子没有？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2446,51,0);   --  1(1):[慕容复]说: 我尚未婚配，何来子嗣？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2447,113,0);   --  1(1):[???]说: 你有祖宗没有？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2448,51,0);   --  1(1):[慕容复]说: 自然有！我自愿就死，与你*何干？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2449,113,0);   --  1(1):[???]说: 你高祖有儿子，你曾祖、祖*父、父亲都有儿子，便是你*没儿子！嘿嘿，大燕国当年*慕容恪、慕容垂何等英雄，*却不料都变成了断种绝代的*无后之人！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2450,51,0);   --  1(1):[慕容复]说: 这……慕容复见识短绌，得*蒙高人指点迷津，大恩大德*，没齿难忘。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2451,113,0);   --  1(1):[???]说: 萧大侠武功卓绝，果然名不*虚传，老夫想领教几招！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2452,50,0);   --  1(1):[乔峰]说: 不敢！请！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2453,112,0);   --  1(1):[???]说: 哈哈哈……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_14();   --  14(E):场景变黑
        instruct_3(-2,71,0,0,0,0,0,7134,7134,7134,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [71]
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_1(2454,113,0);   --  1(1):[???]说: 你……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2454,112,0);   --  1(1):[???]说: 你……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2455,113,0);   --  1(1):[???]说: 你在少林寺中一躲数十年，*所为何事？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2456,112,0);   --  1(1):[???]说: 我也正要问你，你在少林寺*中一躲数十年，又所为何事*？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2457,113,0);   --  1(1):[???]说: 我藏身少林，是为了寻找一*些东西。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2458,112,0);   --  1(1):[???]说: 我也是为了寻找一些东西，*我想找得东西已经找到，我*想你要找的东西也已经找到*了，否则我们三次较量，该*当分出了高下。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2459,113,0);   --  1(1):[???]说: 不错，尊驾武功了得，你我*互相钦服，不用再较量了。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2460,112,0);   --  1(1):[???]说: 甚好！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2461,50,0);   --  1(1):[乔峰]说: ＜这个声音……不正是那日*救我出聚贤庄的黑衣人吗？*……＞ **恩公，请受萧峰一拜！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2462,112,0);   --  1(1):[???]说: 恩公？哈哈哈，你再仔细看*看我！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2463,50,0);   --  1(1):[乔峰]说: 你……你是我爹爹……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2464,112,0);   --  1(1):[???]说: 好孩儿，好孩儿，我正是你*爹爹。咱爷俩一般的身形相*貌。不用记认，谁都知道我*是你的老子。那日雁门关外*，中原豪杰不问情由，便杀*了你不会武功的妈妈。孩儿*，你说此仇该不该报？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2465,50,0);   --  1(1):[乔峰]说: 杀母之仇，不共戴天，焉可*不报？智光大师、谭公、谭*婆、赵钱孙等人皆已死于非*命，可是孩儿至今不知那位*带头大哥是谁。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2466,112,0);   --  1(1):[???]说: 那些人都是我杀的！*那个带头大哥就在少室山！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2467,50,0);   --  1(1):[乔峰]说: 是谁？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2468,70,0);   --  1(1):[玄慈]说: 萧老施主，雁门关外一役，*老衲铸成大错。众家兄弟为*老衲包涵此事，又一一送命*。老衲今日再死，实在已经*晚了。**慕容博慕容老施主，*当日你假传音讯，说道契丹*武士要大举来少林寺夺取武*学典籍，以致酿成种种大错*，你可也曾有丝毫内疚于心*吗？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2469,113,0);   --  1(1):[???]说: 方丈大师，你眼光好生厉害*，居然将我认了出来
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2470,51,0);   --  1(1):[慕容复]说: 爹爹，你……你没有……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2471,70,0);   --  1(1):[玄慈]说: 慕容老施主，老衲今日听你*对令郎的劝导言语，才知你*姑苏慕容氏竟是帝王之裔，*所谋者大。那么你假传音讯*的用意，也就明白不过了。*只是你所图谋的大事，却也*终究难成，那不是枉自害死*了这许多无辜的性命么？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2472,113,0);   --  1(1):[???]说: 谋事在人，成事在天！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2473,112,0);   --  1(1):[???]说: 慕容老贼，原来你才是罪魁*祸首，上来领死吧！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2474,113,0);   --  1(1):[???]说: 哈哈哈，恕不奉陪！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2475,112,0);   --  1(1):[???]说: 想跑？追！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2476,50,0);   --  1(1):[乔峰]说: 追！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2477,51,0);   --  1(1):[慕容复]说: 爹爹……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_14();   --  14(E):场景变黑
        instruct_3(-2,59,0,0,0,0,0,-2,-2,-2,0,17,52);   --  3(3):修改事件定义:当前场景:场景事件编号 [59]
        instruct_3(-2,71,0,0,0,0,0,-2,-2,-2,-2,16,50);   --  3(3):修改事件定义:当前场景:场景事件编号 [71]
        instruct_3(-2,69,0,0,0,0,0,-2,-2,-2,-2,16,52);   --  3(3):修改事件定义:当前场景:场景事件编号 [69]
        instruct_3(-2,67,0,0,0,0,0,-2,-2,-2,-2,17,50);   --  3(3):修改事件定义:当前场景:场景事件编号 [67]
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_1(2478,0,1);   --  1(1):[AAA]说: 恩……他们竟然跑向了少林*的藏经阁，我得过去看看
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_14();   --  14(E):场景变黑
        instruct_19(26,52);   --  19(13):主角移动至1A-34
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_25(26,52,15,54);   --  25(19):场景移动26-52--15-54
        instruct_1(2479,0,1);   --  1(1):[AAA]说: ＜这老和尚是何方神圣？竟*然能降服萧远山和慕容博两*位老英雄？＞
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2480,114,0);   --  1(1):[???]说: 你二人由生到死、由死到生*地走了一遍，心中还有什么*放不下？倘若适才就此死了*，还有什么兴复大燕、报复*妻仇的念头？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2481,112,0);   --  1(1):[???]说: 弟子生平杀人，无虑百数，*倘若被我所杀之人的眷属皆*来向我复仇索命，弟子虽死*百次，亦自不足。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2482,114,0);   --  1(1):[???]说: 你呢？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2483,113,0);   --  1(1):[???]说: 庶民如尘土，帝王亦如尘土*。大燕不复国是空，复国亦*是空。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2484,114,0);   --  1(1):[???]说: 大彻大悟，善哉善哉，你二*人这就随我去吧。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2477,50,0);   --  1(1):[乔峰]说: 爹爹……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2477,51,0);   --  1(1):[慕容复]说: 爹爹……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_14();   --  14(E):场景变黑
        instruct_3(-2,0,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
        instruct_3(-2,35,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [35]
        instruct_3(-2,34,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [34]
        instruct_3(-2,33,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [33]
        instruct_3(-2,32,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [32]
        instruct_3(-2,31,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [31]
        instruct_3(-2,30,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [30]
        instruct_3(-2,29,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [29]
        instruct_3(-2,28,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [28]
        instruct_3(-2,27,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
        instruct_3(-2,26,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [26]
        instruct_3(-2,6,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
        instruct_3(-2,5,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [5]
        instruct_3(-2,4,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [4]
        instruct_3(-2,3,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
        instruct_3(-2,2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
        instruct_3(-2,1,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
        instruct_3(-2,62,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [62]
        instruct_3(-2,66,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [66]
        instruct_3(-2,65,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [65]
        instruct_3(-2,64,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [64]
        instruct_3(-2,63,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [63]
        instruct_3(-2,70,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [70]
        instruct_3(-2,58,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [58]
        instruct_3(-2,57,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [57]
        instruct_3(-2,56,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [56]
        instruct_3(-2,55,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [55]
        instruct_3(-2,54,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [54]
        instruct_3(-2,53,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [53]
        instruct_3(-2,52,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [52]
        instruct_3(-2,51,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [51]
        instruct_3(-2,50,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [50]
        instruct_3(-2,49,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [49]
        instruct_3(-2,48,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [48]
        instruct_3(-2,68,0,0,0,0,0,-2,-2,-2,-2,25,52);   --  3(3):修改事件定义:当前场景:场景事件编号 [68]
        instruct_3(-2,69,0,0,0,0,0,-2,-2,-2,-2,26,53);   --  3(3):修改事件定义:当前场景:场景事件编号 [69]
        instruct_3(-2,71,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [71]
        instruct_3(-2,67,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [67]
        instruct_3(-2,59,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [59]
        instruct_3(-2,14,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
        instruct_19(26,52);   --  19(13):主角移动至1A-34
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_1(2485,50,0);   --  1(1):[乔峰]说: 好兄弟，你是个顶天立地的*好男儿，我知道你在寻找《*天龙八部》一书，此书我今*日就赠送与你。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_2(147,1);   --  2(2):得到物品[天龙八部][1]
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2486,0,0);   --  1(1):[AAA]说: 多谢大哥。不知大哥今后有*何打算？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2508,50,0);   --  1(1):[乔峰]说: 我会与阿朱去塞外。塞外牛*羊，绝不是空许约！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2488,104,0);   --  1(1):[???]说: 大哥，你待我真好。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2489,50,0);   --  1(1):[乔峰]说: 这降龙十八掌乃天下至刚的*掌法，我不想此掌法从此失*传，今日也一并传给你吧。*希望你将此掌法用于正途，*发扬光大。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_2(86,1);   --  2(2):得到物品[降龙十八掌][1]
        instruct_0();   --  0(0)::空语句(清屏)
		if GetS(113,0,0,0) == 0 then 
	        say("小兄弟，这降龙精要也一并传与你，记住！这套掌法既非至刚亦非至柔，而是刚劲柔劲混而为一。",50) 
	        instruct_0();
			if instruct_11(0,188) == true then 
	            QZXS("领悟降龙精要！")
				say("多谢大哥",0)
	            instruct_0();
	            setLW1(26)
			else
				say("既然如此，大哥也不勉强你。",50) 
			end	
	    end
		addHZ(68)
		addHZ(144)
        instruct_1(2490,0,1);   --  1(1):[AAA]说: 多谢大哥。大哥教诲，小弟*紧记在心。
        instruct_0();   --  0(0)::空语句(清屏)
		if GetS(113,0,0,0) == 0 then 
	        say("小兄弟，还有这打狗棒法我也希望你学成之后再传到丐帮下一任帮主手中。",50) 
	        instruct_0();
			if instruct_11(0,188) == true then 
	            QZXS("领悟打狗精要！")
				say("大哥放心，我一定会的",0)
	            instruct_0();
	            setLW1(80)
			else
			    say("也罢，大哥有缘再传予下一任帮主。",50) 
		    end	
	    end
		addthing(167)
        instruct_1(2491,50,0);   --  1(1):[乔峰]说: 阿朱，我们走吧。兄弟，日*后有缘，也许还有相见之日*。告辞了。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_14();   --  14(E):场景变黑
        instruct_3(-2,68,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [68]
        instruct_3(-2,69,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [69]
        instruct_3(77,0,1,0,1061,0,0,6414,6414,6414,-2,-2,-2);   --  3(3):修改事件定义:场景[万鳄岛]:场景事件编号 [0]

		SetS(63,26,8,3,21); --鸠摩智位置
		SetS(63,28,9,3,22); --鸠摩智事件触发
		SetS(63,28,8,3,23); --鸠摩智事件触发
		SetS(63,28,7,3,24); --鸠摩智事件触发
	
		instruct_3(63,22,0,0,0,0,10009,0,0,0,-2,-2,-2); --鸠摩智事件触发
		instruct_3(63,23,0,0,0,0,10009,0,0,0,-2,-2,-2); --鸠摩智事件触发
		instruct_3(63,24,0,0,0,0,10009,0,0,0,-2,-2,-2); --鸠摩智事件触发
		
		instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        do return; end
    end    --:Label4

    instruct_0();   --  0(0)::空语句(清屏)
end

OEVENTLUA[10009] = function()	--鸠摩智加入事件
	instruct_14();   --  14(E):场景变黑
	instruct_3(63,21,0,0,0,0,0,8824,8824,8824,-2,-2,-2); --鸠摩智贴图
	instruct_3(63,22,0,0,0,0,0,0,0,0,-2,-2,-2); --事件取消
	instruct_3(63,23,0,0,0,0,0,0,0,0,-2,-2,-2); --事件取消
	instruct_3(63,24,0,0,0,0,0,0,0,0,-2,-2,-2); --事件取消
	instruct_13();   --  13(D):重新显示场景	
	
	say("咦，前面那个人是......") 
	instruct_0();
	say("那老贼秃说我以小无相功为底子，强练少林七十二绝技，戾气所中，种下了祸胎，本末倒置，大难便在旦夕之间。莫非，莫非这老贼秃的鬼话，当真应验了？",103,0,"鸠摩智") 
	instruct_0();
	say("现在我丹田热焰上腾，有如火焚，四肢百骸不由自主地颤抖不已，这可如何是好？",103,0,"鸠摩智") 
	instruct_0();
	say("＜鸠摩智惊惶之极，伸右手在左肩、左腿、右腿三处各戳一指，刺出三洞，要导引内息从三个洞孔中泄出，三个洞孔中血流如注，内息却没法宣泄。＞",103,0,"鸠摩智") 
	instruct_0();
	say("啊啊啊啊！！！！！！！",103,0,"鸠摩智") 
	instruct_0();
	say("大师！大师你怎么了！？") 	
	instruct_0();	
	say("啊啊啊啊啊啊啊啊啊！！！！！！！！！！！！",103,0,"鸠摩智") 
	instruct_0();
	say("糟糕，他走火入魔了，必须让他镇静下来！") 
	instruct_0();
	SetS(86,20,20,5,9) --设置战斗
	JY.Person[103]["内力最大值"] = JY.Person[103]["内力最大值"] + 1000
	JY.Person[103]["内力"] = JY.Person[103]["内力最大值"]
	
	if instruct_6(88) ==false then     --单挑鸠摩智
		instruct_15(0);   --  15(F):战斗失败，死亡
		do return; end
		instruct_0(); 
	end   	
	SetS(86,20,20,5,0)
	say("还是不行，他武功太高，此时状如疯魔更加难以压制。可是现在如果一走了之他肯定凶多吉少。怎么办？") 
	instruct_0();
	if DrawStrBoxYesNo(-1, -1, "要继续帮助鸠摩智吗?", C_WHITE, 30) == true then
		AddPersonAttrib(0, "品德", 2)
		say("不行，不能前功尽弃，再来一次！") 
		instruct_0(); 
		JY.Person[103]["攻击力"] = JY.Person[103]["攻击力"] + 100
		JY.Person[103]["轻功"] = JY.Person[103]["轻功"] + 100
		JY.Person[103]["防御力"] = JY.Person[103]["防御力"] + 100
		SetS(86,20,20,5,9) --设置战斗
		if instruct_6(88) ==false then     --单挑鸠摩智
			instruct_15(0);   --  15(F):战斗失败，死亡
			do return; end
			instruct_0(); 
		end  		
		JY.Person[103]["攻击力"] = JY.Person[103]["攻击力"] - 100
		JY.Person[103]["轻功"] = JY.Person[103]["轻功"] - 100
		JY.Person[103]["防御力"] = JY.Person[103]["防御力"] - 100
		JY.Person[103]["内力最大值"] = JY.Person[103]["内力最大值"] - 1000
		JY.Person[103]["内力"] = JY.Person[103]["内力最大值"]
		SetS(86,20,20,5,0)
		say("成功了！他冷静下来了！") 
		instruct_0(); 
		instruct_14();   --  14(E):场景变黑
		instruct_3(63,21,0,0,0,0,0,8818,8818,8818,-2,-2,-2); 
		instruct_13();   --  13(D):重新显示场景			
		instruct_0(); 
		say("大师，你觉得怎么样？") 
		instruct_0(); 
		say("唉，老衲错学少林七十二绝技，走火入魔，凶险万状。幸得少侠出手相助，如今我武功虽失，性命犹在，须得拜谢你的救命之恩才是。",103,0,"鸠摩智") 
		instruct_0();
		say("大师客气了，救人一命胜造七级浮屠，这乃是我辈的分内之事。只是不知大师以后有何打算？") 	
		instruct_0(); 
		say("老衲此番再世为人，思往日种种罪过，心自难安。只盼以后能与人向善，随遇而安。心安乐处，便是身安乐处。",103,0,"鸠摩智") 
		instruct_0();
		if JY.Person[zj()]["品德"] >= 85 and JY.Person[zj()]["内力最大值"] >= 5000 then
			instruct_0();
			say("大师一身武功如此失去，岂不是暴殄天物？不如让在下助大师你打通经脉，或许可以使武功恢复个几成。以后大师若是能把一身功夫用在正道上，也是无量功德。") 
			instruct_0(); 
			say("那就麻烦少侠辛苦了。",103,0,"鸠摩智") 
			instruct_14();   --  14(E):场景变黑
			instruct_13();   --  13(D):重新显示场景				
			JY.Person[zj()]["内力最大值"] = math.modf(JY.Person[zj()]["内力最大值"] * 0.5)
			JY.Person[zj()]["内力"] = 0
			instruct_0();
			say("大师淤塞的经脉已经被我打通，不如来小村住上一段时期安心休养？") 			
			instruct_0(); 
			say("如此也好，那老衲就叨扰了。",103,0,"鸠摩智")
			if GetS(113,0,0,0) == 0 then 
	            say("少侠，这是我宁玛教的无上神功，请一定收下。",103) 
	            instruct_0();
			    if instruct_11(0,188) == true then 
	                QZXS("领悟火焰刀精要！")
					say("多谢大师",0)
	                instruct_0();
	                setLW1(66)
				else
				    say("也罢。",103) 
				end	
	        end
			instruct_14();   --  14(E):场景变黑
			instruct_3(70,71,1,0,1094,0,0,8818,8818,8818,-2,-2,-2); --鸠摩智小村贴图
			instruct_3(63,21,0,0,0,0,0,0,0,0,-2,-2,-2); 
			instruct_13();   --  13(D):重新显示场景			
			return
		else
			instruct_0(); 
			say("这些身外物，老衲已无用处，就送给少侠吧。",103,0,"鸠摩智") 	
			instruct_0();
			say("多谢大师，祝大师此行一路顺风。")
			instruct_14();   --  14(E):场景变黑
			instruct_3(63,21,0,0,0,0,0,0,0,0,-2,-2,-2); 
			instruct_13();   --  13(D):重新显示场景		
			instruct_0();			
			instruct_32(8, 3)
			QZXS("得到三颗天王保命丹")
			addHZ(11)
			return
		end
	end	
	AddPersonAttrib(0, "品德", -1)
	JY.Person[103]["内力最大值"] = JY.Person[103]["内力最大值"] - 1000
	JY.Person[103]["内力"] = JY.Person[103]["内力最大值"]
	instruct_0(); 
	say("大师，不是我不想救你，只是你武功太高在下实在爱莫能助啊。") 
	instruct_0();
	say("啊啊啊啊啊啊啊啊啊啊啊啊啊啊！！！！！！！！！！！！！！！",103,0,"鸠摩智") 
	instruct_0();
	lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_RED, 128) --流血
	instruct_3(63,21,0,0,0,0,0,0,0,0,-2,-2,-2); --鸠摩智贴图消失
	ShowScreen()
	lib.Delay(80)
	lib.ShowSlow(15, 1)
	Cls()
	lib.ShowSlow(100, 0)		

	instruct_0();
	say("唉，一代宗师，最后也要归于尘土......我还是把他好好埋葬了吧。") 
	
	instruct_14();   --  14(E):场景变黑
	instruct_3(63,21,1,0,0,0,0,2770,2770,2770,-2,-2,-2); --墓贴图
	instruct_13();   --  13(D):重新显示场景	
	instruct_0();
	say("他的这些遗物，我还是收起来吧。") 	
	instruct_32(8, 3)
	QZXS("得到三颗天王保命丹")	
	instruct_0();   --  0(0)::空语句(清屏)	
	return
end


OEVENTLUA[347] = function() --袁承志加入增加属性
    instruct_1(1308,247,1);   --  1(1):[???]说: 袁公子，真没想到在这遇见*你。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1309,54,0);   --  1(1):[袁承志]说: 原来是你啊，我正要去找你*呢。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1310,0,1);   --  1(1):[AAA]说: 找我？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1311,54,0);   --  1(1):[袁承志]说: 是啊，我这些年到处游历，*无意中发现了一本奇书《碧*血剑》，我想可能就是你要*寻找的天书之一吧。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1312,0,1);   --  1(1):[AAA]说: 太好了，这正是我要找的书*！
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_28(0,75,999,0,103) ==true then    --  28(1C):判断AAA品德75-999否则跳转到:Label0
        instruct_37(1);   --  37(25):增加道德1
        instruct_1(1313,54,0);   --  1(1):[袁承志]说: 既然如此，这本书就送给你*吧。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1314,247,1);   --  1(1):[???]说: 哈哈，太好了，多谢袁公子！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_2(156,1);   --  2(2):得到物品[碧血剑][1]
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1315,54,0);   --  1(1):[袁承志]说: 看到你高兴的样子，我的心*也再度活跃起来。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1316,0,1);   --  1(1):[AAA]说: 那袁公子何不与我一同闯荡*江湖？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_3(104,75,1,0,966,0,0,6818,6818,6818,-2,-2,-2);   --  3(3):修改事件定义:场景[钓鱼岛]:场景事件编号 [75]

        if instruct_20(24,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label1
            JY.Person[54]["攻击力"]=JY.Person[54]["攻击力"]+20
			JY.Person[54]["防御力"]=JY.Person[54]["防御力"]+10	
			instruct_1(1317,54,0);   --  1(1):[袁承志]说: 好，愿陪少侠走一遭！
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_10(54);   --  10(A):加入人物[袁承志]
            instruct_0();   --  0(0)::空语句(清屏)
            do return; end
        end    --:Label1
		JY.Person[54]["攻击力"]=JY.Person[54]["攻击力"]+20
		JY.Person[54]["防御力"]=JY.Person[54]["防御力"]+10	
        instruct_1(12,54,0);   --  1(1):[袁承志]说: 你的队伍已满，我就直接去*小村吧。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_3(70,18,1,0,145,0,0,6818,6818,6818,-2,-2,-2);   --  3(3):修改事件定义:场景[小村]:场景事件编号 [18]
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0

    instruct_1(1318,54,0);   --  1(1):[袁承志]说: 不过少侠近来在江湖上似乎*做了不少不道德的事情啊…*…
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_3(-2,-2,1,0,348,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
end


OEVENTLUA[217] = function() --拿君子剑
    if instruct_4(201,2,0) ==false then    --  4(4):是否使用物品[断肠草]？是则跳转到:Label0
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0

    instruct_37(1);   --  37(25):增加道德1
    instruct_32(201,-1);   --  32(20):物品[断肠草]+[-1]
    instruct_1(503,0,1);   --  1(1):[AAA]说: 杨兄，你快将这服下。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(504,58,1);   --  1(1):[杨过]说: 这是什麽？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(505,0,1);   --  1(1):[AAA]说: 这是生长在情花丛旁的断肠*草。**我曾听人说过，凡毒蛇出没*之处，七步之内必有解毒之*药，其他毒物，无不如此。*这是天地间万物相生相克的*至理。**这断肠草正好生长在情花树*旁，虽说此草具有剧毒，但*我反覆思量，此草以毒攻毒*正是情花的对头克星。***服这毒草自是冒极大险，但*反正已无药可救，咱们就死*马当活马医，试它一试。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(506,58,0);   --  1(1):[杨过]说: 好，我便服这断肠草试试***……啊……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(507,0,1);   --  1(1):[AAA]说: 杨兄，怎么样？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,-2,1,0,0,0,0,6186,6186,6186,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(508,58,0);   --  1(1):[杨过]说: 我杨某这条命是少侠你救回*来的。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(509,0,1);   --  1(1):[AAA]说: 你身上的毒质当真都解了？*还好还好，我刚真捏了把冷*汗。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(510,58,0);   --  1(1):[杨过]说: 这次真谢谢少侠的帮忙，*让杨某从鬼门关回来。
    instruct_0();   --  0(0)::空语句(清屏)
	say("这把双剑请少侠收下。",58,0,"杨过") 
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_2(38,1)
	instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(511,0,1);   --  1(1):[AAA]说: 不知杨兄今後有何打算？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(512,58,0);   --  1(1):[杨过]说: 我要去寻找我的姑姑，咱们*后会有期。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
    instruct_26(19,24,0,0,1);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
end

OEVENTLUA[594] = function() --拿打狗
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,25,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [25]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
	
    instruct_30(39,30,17,30);   --  30(1E):主角走动39-30--17-30
	

	say("天下英雄，丐帮现在举行英雄大会，选出新的帮主！",207,0,"丐帮弟子") 
	instruct_0();		
	TalkEx("等等！你们看这是什么？",0,1)
	instruct_0();	
	say("这是。。打狗棒！怎么会在你的手上？",207,0,"丐帮弟子") 
	instruct_0();	
	TalkEx("这个你别管，总之打狗棒在我手上，我就是丐帮下一任帮主！",0,1)
	instruct_0();		
    instruct_1(2583,69,0);   --  1(1):[洪七公]说: 好大的口气，现问过我们再*说！
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(83,4,0,0) ==false then    --  6(6):战斗[83]是则跳转到:Label1
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label1

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_3(-2,12,1,0,595,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
    instruct_3(-2,37,1,0,595,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [37]
    instruct_3(-2,36,1,0,595,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [36]
    instruct_3(-2,35,1,0,595,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [35]
    instruct_3(-2,34,1,0,595,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [34]
    instruct_3(-2,33,1,0,595,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [33]
    instruct_3(-2,32,1,0,595,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [32]
    instruct_3(-2,31,1,0,595,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [31]
    instruct_3(-2,30,1,0,595,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [30]
    instruct_3(-2,29,1,0,595,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [29]
    instruct_3(-2,28,1,0,595,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [28]
    instruct_3(-2,27,1,0,595,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
    instruct_3(-2,26,1,0,595,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [26]
    instruct_3(-2,13,1,0,595,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
    instruct_13();   --  13(D):重新显示场景
    instruct_1(2584,247,1);   --  1(1):[???]说: 哈哈，这回没人反对了吧？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2585,207,0);   --  1(1):[???]说: ……***这位少侠武功盖世，自*是丐帮下一代帮主，这是丐*帮历代相传的打狗棒法。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2586,0,1);   --  1(1):[AAA]说: 嘿嘿，我就是为它而来的！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_2(167,1);   --  2(2):得到物品[打狗棒法][1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_37(-5);   --  37(25):增加道德-5
end

OEVENTLUA[300] = function() --崆峒三连中间恢复，取消掉了
    instruct_14();   --  14(E):场景变黑
    instruct_37(-9);   --  37(25):增加道德-9
    instruct_26(40,9,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_26(40,10,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_26(40,12,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_39(4);   --  39(27):打开场景崑仑仙境
    instruct_13();   --  13(D):重新显示场景
    instruct_30(46,28,39,28);   --  30(1E):主角走动46-28--39-28
    instruct_1(1018,8,0);   --  1(1):[唐文亮]说: 明教余孽，受死吧
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(152,3,0,0) ==false then    --  6(6):战斗[152]是则跳转到:Label0
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
    end    --:Label0
	--instruct_12()
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_2(89,1);   --  2(2):得到物品[七伤拳谱][1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,28,0,0,0,0,0,5962,5962,5962,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [28]
    instruct_3(-2,29,0,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [29]
    instruct_3(-2,39,0,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [39]
    instruct_3(-2,38,0,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [38]
    instruct_3(-2,37,0,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [37]
    instruct_3(-2,36,0,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [36]
    instruct_3(-2,35,0,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [35]
    instruct_3(-2,34,0,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [34]
    instruct_3(-2,33,0,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [33]
    instruct_3(-2,32,0,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [32]
    instruct_3(-2,31,0,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [31]
    instruct_3(-2,30,0,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [30]
    instruct_3(-2,40,0,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [40]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(1019,109,0);   --  1(1):[???]说: 崆峒派莫要惊惶，华山派得*到信息，前来增援
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1020,13,0);   --  1(1):[谢逊]说: 来得好，省得我们到处跑了*！
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(153,3,0,0) ==false then    --  6(6):战斗[153]是则跳转到:Label1
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
    end    --:Label1
	--instruct_12()
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_2(142,1);   --  2(2):得到物品[反两仪刀法][1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,43,0,0,0,0,0,5358,5358,5358,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [43]
    instruct_3(-2,41,0,0,0,0,0,5398,5398,5398,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [41]
    instruct_3(-2,51,0,0,0,0,0,5398,5398,5398,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [51]
    instruct_3(-2,50,0,0,0,0,0,5398,5398,5398,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [50]
    instruct_3(-2,49,0,0,0,0,0,5398,5398,5398,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [49]
    instruct_3(-2,48,0,0,0,0,0,5398,5398,5398,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [48]
    instruct_3(-2,47,0,0,0,0,0,5398,5398,5398,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [47]
    instruct_3(-2,46,0,0,0,0,0,5398,5398,5398,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [46]
    instruct_3(-2,45,0,0,0,0,0,5398,5398,5398,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [45]
    instruct_3(-2,44,0,0,0,0,0,5398,5398,5398,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [44]
    instruct_3(-2,42,0,0,0,0,0,5398,5398,5398,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [42]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(1021,6,0);   --  1(1):[灭绝]说: 魔教休得猖狂，峨嵋派前来*支援
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1022,10,0);   --  1(1):[范遥]说: 老贼尼，赶来送死，我们就*成全你！
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(154,3,0,0) ==false then    --  6(6):战斗[154]是则跳转到:Label2
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
    end    --:Label2
	
    instruct_3(-2,0,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
    instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
    instruct_3(-2,48,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [48]
    instruct_3(-2,47,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [47]
    instruct_3(-2,46,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [46]
    instruct_3(-2,45,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [45]
    instruct_3(-2,44,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [44]
    instruct_3(-2,43,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [43]
    instruct_3(-2,42,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [42]
    instruct_3(-2,41,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [41]
    instruct_3(-2,40,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [40]
    instruct_3(-2,39,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [39]
    instruct_3(-2,38,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [38]
    instruct_3(-2,37,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [37]
    instruct_3(-2,36,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [36]
    instruct_3(-2,35,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [35]
    instruct_3(-2,34,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [34]
    instruct_3(-2,33,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [33]
    instruct_3(-2,32,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [32]
    instruct_3(-2,31,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [31]
    instruct_3(-2,30,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [30]
    instruct_3(-2,29,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [29]
    instruct_3(-2,28,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [28]
    instruct_3(-2,27,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
    instruct_3(-2,26,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [26]
    instruct_3(-2,25,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [25]
    instruct_3(-2,24,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [24]
    instruct_3(-2,23,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [23]
    instruct_3(-2,22,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [22]
    instruct_3(-2,17,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [17]
    instruct_3(-2,16,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [16]
    instruct_3(-2,21,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [21]
    instruct_3(-2,20,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [20]
    instruct_3(-2,19,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [19]
    instruct_3(-2,18,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [18]
    instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [11]
    instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [10]
    instruct_3(-2,9,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [9]
    instruct_3(-2,8,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [8]
    instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [7]
    instruct_3(-2,6,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
    instruct_3(-2,5,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [5]
    instruct_3(-2,4,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [4]
    instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
    instruct_3(-2,2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
    instruct_3(-2,53,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [53]
    instruct_3(-2,51,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [51]
    instruct_3(-2,50,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [50]
    instruct_3(-2,49,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [49]
    instruct_3(33,13,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [13]
    instruct_3(33,12,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [12]
    instruct_3(33,11,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [11]
    instruct_3(33,10,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [10]
    instruct_3(33,9,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [9]
    instruct_3(33,8,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [8]
    instruct_3(33,7,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [7]
    instruct_3(33,6,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [6]
    instruct_3(33,5,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [5]
    instruct_3(33,4,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [4]
    instruct_3(33,3,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [3]
    instruct_3(33,2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [2]
    instruct_3(33,28,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [28]
    instruct_3(33,28,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [28]
    instruct_3(33,27,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [27]
    instruct_3(33,26,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [26]
    instruct_3(33,25,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [25]
    instruct_3(33,24,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [24]
    instruct_3(33,23,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [23]
    instruct_3(33,22,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [22]
    instruct_3(33,21,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [21]
    instruct_3(33,20,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[峨嵋派]:场景事件编号 [20]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_2(120,1);   --  2(2):得到物品[灭绝剑谱][1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_2(37,1);   --  2(2):得到物品[倚天剑][1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1023,13,0);   --  1(1):[谢逊]说: 哈哈哈，如今四派已灭，就*剩下少林和武当了。先诛少*林，再灭武当，唯我明教，*武林称王！哈哈哈……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_3(-2,54,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [54]
    instruct_3(-2,55,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [55]
    instruct_3(28,36,1,0,0,0,0,2286,2286,2286,-2,-2,-2);   --  3(3):修改事件定义:场景[少林寺]:场景事件编号 [36]
    instruct_0();   --  0(0)::空语句(清屏)
end

OEVENTLUA[231] = function()
    instruct_1(565,0,1);   --  1(1):[AAA]说: 杨兄，龙姑娘，一切可好，*龙姑娘伤势如何了？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(566,59,0);   --  1(1):[小龙女]说: 已经不碍事事了，多谢少侠*关心
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(567,58,0);   --  1(1):[杨过]说: 我夫妇得少侠多次多次相救*，深感大恩，若少侠有需要*之处，我夫妇自当尽力帮忙*。
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_9(2,0) ==false then    --  9(9):是否要求加入?是则跳转到:Label0
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label0

    instruct_1(568,247,1);   --  1(1):[???]说: 近日旅途有些不顺，如能得*杨兄和龙姑娘相助，真是再*好不过了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(569,58,0);   --  1(1):[杨过]说: 既然如此，我们就直接去小*村了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(104,68,1,0,969,0,0,6186,6186,6186,-2,-2,-2);   --  3(3):修改事件定义:场景[钓鱼岛]:场景事件编号 [68]
    instruct_3(104,76,1,0,970,0,0,7242,7242,7242,-2,-2,-2);   --  3(3):修改事件定义:场景[钓鱼岛]:场景事件编号 [76]
    instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
    instruct_3(-2,0,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
    instruct_3(70,19,1,0,151,0,0,6188,6188,6188,-2,-2,-2);   --  3(3):修改事件定义:场景[小村]:场景事件编号 [19]
    instruct_3(70,20,1,0,153,0,0,6068,6068,6068,-2,-2,-2);   --  3(3):修改事件定义:场景[小村]:场景事件编号 [20]
    instruct_37(2);   --  37(25):增加道德2
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
end

--鹿鼎记邪线
OEVENTLUA[63] = function() --神龙岛加入事件
    if instruct_16(664) then
    instruct_30(30,21,30,13);   --  30(1E):主角走动30-21--30-13
    instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
    instruct_1(277,87,0);   --  1(1):[???]说: 呵呵呵……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(275,225,1);   --  1(1):[???]说: 喂，你瞧，瞧……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(278,0,1);   --  1(1):[AAA]说: 什么啊？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(279,225,1);   --  1(1):[???]说: 大美女啊……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(280,246,1);   --  1(1):[???]说: 这个，小宝兄，那可是人家*的老婆啊。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(282,225,0);   --  1(1):[???]说: 想想办法，搞过来啊。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(276,71,0);   --  1(1):[洪教主]说: 什么人，胆敢擅闯神龙教！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(281,247,1);   --  1(1):[???]说: 啊？啊，我，就是来找找有*没有我要的书。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(283,71,0);   --  1(1):[洪教主]说: 你要找什么书？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(284,0,1);   --  1(1):[AAA]说: 就是《鹿鼎记》一书。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(285,71,0);   --  1(1):[洪教主]说: 哦，还好，我这没有。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(286,0,1);   --  1(1):[AAA]说: 那你这有什么书？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(287,71,0);   --  1(1):[洪教主]说: 没有……我哪有什么书？…*…什么也没有……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(288,246,1);   --  1(1):[???]说: ？？？你好像心里有鬼啊？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(289,71,0);   --  1(1):[洪教主]说: 我有什么鬼？没有就是没有*，你要是再不滚蛋，就休怪*我不客气了！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(290,0,1);   --  1(1):[AAA]说: 哼，打就打，谁怕谁。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(291,225,1);   --  1(1):[???]说: 啊，这就开打啦，你们先上*，我掩护。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_13();   --  13(D):重新显示场景
    instruct_1(292,225,1);   --  1(1):[???]说: 等一下，等一下，我还有件*重要的事……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(293,0,1);   --  1(1):[AAA]说: ？？？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(294,225,1);   --  1(1):[???]说: 千万要注意，别伤到美女。*好，你们继续！
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(95,4,0,0) ==false then    --  6(6):战斗[95]是则跳转到:Label0
        
		if instruct_43(228,0,143) == true and (instruct_16(2) or 
			instruct_16(25) or instruct_16(17) or instruct_16(83)) and JY.Person[0]["品德"] <= 30 then
			instruct_0();	
			say("呜......这老头子好强！") 
			instruct_0();	
			say("嘿嘿，臭小子，敬酒不吃吃罚酒，现在想滚蛋也晚了！咦......？",71,0,"洪安通") 		
			instruct_0();				
			say("＜啊，那半部四十二章经掉出来了！＞") 
			instruct_0();	
			say("小子，你怎么也有四十二章经？快点交出来，饶你不死！",71,0,"洪安通") 		
			instruct_0();
			say("＜罢了，君子忍一时之气，成万世之霸业。留得性命在，以后有的是机会报仇。＞") 		
			instruct_0();
			say("这是晚辈在某个岛上获得的，前辈如果想要，尽管拿去便是。") 				
			instruct_0();	
			say("嘿嘿，不错不错，算你小子识趣。让我看看......跟我手上的那半部刚好凑成一部。",71,0,"洪安通") 			
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_2(229,1);   --  2(2):得到物品[四十二章经][1]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(228,-1);   --  32(20):物品[半部四十二章经]+[-1]			
			instruct_0();	
			say("咦，怎么看不懂，这里面藏的到底是什么秘密......",71,0,"洪安通") 			
			instruct_0();
			say("＜哈哈，看这老家伙迷茫的怂样，八成是看不懂。好机会！＞") 				
			instruct_0();
			say("前辈武功高强智慧超群，自然能解开这书里的秘密。只是在下听说这书里的宝藏关系甚大，其中地点只有南贤北丑二人知晓。刚好那两人是我的叔伯，前辈如果不嫌弃，不妨把经书暂时交给在下，等起出宝藏之后在下定会双手奉上。") 
			instruct_0();	
			say("＜看这臭小子一脸奸诈，能信才有鬼。不过江湖传闻他真的认识南贤北丑，不如将计就计利用他一番。＞",71,0,"洪安通") 
			instruct_0();	
			say("好！如果你能替本座找到宝藏，本座便封你为白龙使！",71,0,"洪安通") 			
			instruct_0();
			say("教主宽宏大量知人善用，小的感激不尽！＜我呸！＞") 
			instruct_0();	
			say("来人，给白龙使，服下这丹丸。这是我们神龙教入教的仪式。",71,0,"洪安通") 
			instruct_0();
			say("＜难道这就是豹胎易筋丸？反正只能使高人变矮，胖人变瘦，说不定还能帮我减肥，吃就吃吧！＞谢教主！") 			
			instruct_14();   --  14(E):场景变黑
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_13();   --  13(D):重新显示场景		
			instruct_0();	
			say("我忘了说明，这是我新发明的百涎丸，采集一百种毒蛇毒虫的唾涎调制而成。实在是益处多多啊。",71,0,"洪安通") 
			instruct_0();
			say("＜我靠！你不早说！我吞都吞了！＞") 			
			instruct_0();	
			say("好了，你去帮我寻找宝藏吧。找到了有你好处，找不到的话，哼哼。",71,0,"洪安通") 
			instruct_0();
			say("＜老不死！＞属下必定鞠躬尽瘁死而后已！") 	
			instruct_0();
			say("有没有搞错！这么快就认怂了。这家伙果然靠不住，我还是趁机溜吧......",225,0,"韦小宝") 
			instruct_21(664)
		    setteam(664, 0)
			instruct_14();   --  14(E):场景变黑
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_13();   --  13(D):重新显示场景	
			instruct_30(30,13,30,28);   	
			instruct_0();
			say("＜终于出来了＞谁快来救命啊！我不想中毒！") 	
			if instruct_16(2) then
				instruct_0();
				say("别怕，有我在，百涎丸只是雕虫小技。",2,0,"程灵素") 
				instruct_14();   --  14(E):场景变黑
				instruct_0();   --  0(0)::空语句(清屏)
				instruct_13();   --  13(D):重新显示场景	
				instruct_0();
				say("谢谢程姑娘救命之恩，药王果然名不虚传。") 					
			elseif instruct_16(25) then
				instruct_0();
				say("怕什么，有我在，百涎丸只是雕虫小技。",25,0,"蓝凤凰") 		
				instruct_14();   --  14(E):场景变黑
				instruct_0();   --  0(0)::空语句(清屏)
				instruct_13();   --  13(D):重新显示场景	
				instruct_0();
				say("谢谢蓝姑娘救命之恩。") 					
			elseif instruct_16(17) then
				instruct_0();
				say("别怕，有我在，百涎丸只是雕虫小技。",17,0,"王难姑") 
				instruct_14();   --  14(E):场景变黑
				instruct_0();   --  0(0)::空语句(清屏)
				instruct_13();   --  13(D):重新显示场景	
				instruct_0();
				say("谢谢前辈救命之恩。") 				
			elseif instruct_16(83) then
				instruct_0();
				say("小师傅，你也有今天啊，哈哈。别怕别怕，百涎丸只是雕虫小技。看我的。",83,0,"何铁手") 
				instruct_14();   --  14(E):场景变黑
				instruct_0();   --  0(0)::空语句(清屏)
				instruct_13();   --  13(D):重新显示场景	
				instruct_0();
				say("好徒弟啊，幸好带了你来。") 				
			end
			instruct_0();
			say("好了，现在神清气爽。向着宝藏，出发！") 		
			instruct_3(-2,3,1,0,67,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
			instruct_3(-2,19,1,0,67,0,0,-2,-2,-2,-2,-2,-2)
			SetS(67,28,34,3,7)			
			do return; end
		else
			instruct_15(0);   --  15(F):战斗失败，死亡
			instruct_0();   --  0(0)::空语句(清屏)
			do return; end
		end
    end    --:Label0

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(295,0,1);   --  1(1):[AAA]说: 这回不横了吧？还不把书拿*来。
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_43(228,0,143) == true then    --  43(2B):是否有物品半部四十二章经否则跳转到:Label1
        instruct_26(1,10,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
        instruct_26(1,7,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
        instruct_1(305,0,1);   --  1(1):[AAA]说: 又是半部《四十二章经》？*这下我正好可以凑成一部了*……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_2(229,1);   --  2(2):得到物品[四十二章经][1]
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_32(228,-1);   --  32(20):物品[半部四十二章经]+[-1]
        instruct_1(297,225,1);   --  1(1):[???]说: 这位美女，啊不，教主夫人*，仙福永享，寿与天齐，那*个，你若没什么事，跟我们*一起走吧。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(298,71,0);   --  1(1):[洪教主]说: 你说什么！休打我夫人的主*意。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(299,87,0);   --  1(1):[???]说: 我原本以为呢，你就是武功*天下第一了，没想到随便来*几个人，就把你打得落花流*水，唉……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(300,71,0);   --  1(1):[洪教主]说: 我，我……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(301,225,1);   --  1(1):[???]说: 你什么你，你都七老八十了*，还霸占着这么漂亮的美眉*，你够了你。夫人，咱们走*吧。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(302,87,0);   --  1(1):[???]说: 走？好啊。*不过我为什么要跟你走啊？*我不会自己走吗*？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_14();   --  14(E):场景变黑
        instruct_3(-2,3,1,0,88,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
        instruct_3(-2,19,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [19]
        instruct_3(69,11,1,0,90,0,0,8256,8256,8256,-2,-2,-2);   --  3(3):修改事件定义:场景[丽春院]:场景事件编号 [11]
        instruct_3(69,10,1,0,91,0,0,7036,7036,7036,-2,-2,-2);   --  3(3):修改事件定义:场景[丽春院]:场景事件编号 [10]
        instruct_3(69,12,1,0,92,0,0,7030,7030,7030,-2,-2,-2);   --  3(3):修改事件定义:场景[丽春院]:场景事件编号 [12]
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_1(304,71,0);   --  1(1):[洪教主]说: 夫人，夫人……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(303,0,1);   --  1(1):[AAA]说: 人都走了，还傻看什么，小*宝，咱们也走吧，这没有要*找的书了。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(388,225,1);   --  1(1):[???]说: 唉，遇见两个大美女，都被*你放跑了，看来跟着你你甭*想泡到妞了，我要自己去追*！！
        instruct_0();   --  0(0)::空语句(清屏)
		instruct_21(664)
		setteam(664, 0)
        do return; end
    end    --:Label1

    instruct_2(228,1);   --  2(2):得到物品[半部四十二章经][1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(296,0,1);   --  1(1):[AAA]说: 这是什么书？看你的样子一*定有问题，我先替你保管着*吧。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(297,225,1);   --  1(1):[???]说: 这位美女，啊不，教主夫人*，仙福永享，寿与天齐，那*个，你若没什么事，跟我们*一起走吧。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(298,71,0);   --  1(1):[洪教主]说: 你说什么！休打我夫人的主*意。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(299,87,0);   --  1(1):[???]说: 我原本以为呢，你就是武功*天下第一了，没想到随便来*几个人，就把你打得落花流*水，唉……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(300,71,0);   --  1(1):[洪教主]说: 我，我……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(301,225,1);   --  1(1):[???]说: 你什么你，你都七老八十了*，还霸占着这么漂亮的美眉*，你够了你。夫人，咱们走*吧。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(302,87,0);   --  1(1):[???]说: 走？好啊。*不过我为什么要跟你走啊？*我不会自己走吗*？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,3,1,0,88,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
    instruct_3(-2,19,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [19]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(304,71,0);   --  1(1):[洪教主]说: 夫人，夫人……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(303,0,1);   --  1(1):[AAA]说: 人都走了，还傻看什么，小*宝，咱们也走吧，这没有要*找的书了。
    instruct_0();   --  0(0)::空语句(清屏)
	        do return; end
    end    
end

OEVENTLUA[703] = function()
    if instruct_29(0,900,999,20,0) ==false then
	    JY.Person[400]["姓名"] = "慧聪"
		JY.Person[400]["生命最大值"] = 2999
		JY.Person[400]["生命"] = 2999
		JY.Person[400]["内力最大值"] = 7000
		JY.Person[400]["内力"] = 7000
		JY.Person[400]["武功2"] = 96
		JY.Person[400]["武功等级2"] = 999
		JY.Person[400]["声望"] = 96
		JY.Person[400]["武功3"] = 143
		JY.Person[400]["武功等级3"] = 999
		JY.Person[400]["武功4"] = 65
		JY.Person[400]["武功等级4"] = 999
	    say("我刚刚开始学习罗汉拳，咱们一起练练吧。",210,0,"慧聪"); --我刚刚开始学习罗汉拳，咱*们一起练练吧。
		instruct_0();
		
		if instruct_5(2,0) == false then --是否选择战斗？是则跳转Label1
		   do return; end
        end 
		
	    if instruct_6(79,1,0,1) == true then
		    if PersonKF(zj(),96) and GetS(111, 0, 0, 0) == 0 then 
		        say("施主武艺已经如此高强，罗汉伏魔功却是未能精深，小僧可为施主指点一二。",210,0,"慧聪");
	            instruct_0(); 
			    if instruct_11(0,188) == true then
			  	    QZXS("领悟罗汉伏魔功精髓！")
	                instruct_0();
	                say("多谢小师傅",0) 
	                SetS(111, 0, 0, 0,96)
				else
				    say("小僧冒犯了。",615) 
				end
		            do return; end
	       end
        end 
		do return; end
	end
	say("施主武艺已经如此高强，小僧万万不是对手。",210,0,"慧聪"); --我刚刚开始学习罗汉拳，咱*们一起练练吧。
	instruct_0();
end
OEVENTLUA[94] = function() --开放鹿鼎山事件
    if instruct_4(229,6,0) ==false then    --  4(4):是否使用物品[四十二章经]？是则跳转到:Label0
        instruct_1(384,0,1);   --  1(1):[AAA]说: 这个，别烧了，还是留着吧
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0
	instruct_1(385,0,1);   --  1(1):[AAA]说: 燃烧吧，我的《四十二章经*》……咦，有字显示出来，*真神奇，*“鹿鼎山，（23，81）……”
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_32(229,-1);   --  32(20):物品[四十二章经]+[-1]
	instruct_39(67);   --  39(27):打开场景鹿鼎山
	do return; end
end

OEVENTLUA[95] = function() --鹿鼎山二战洪安通
    instruct_3(-2,-2,1,0,0,0,0,2608,2608,2608,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_2(150,1);   --  2(2):得到物品[鹿鼎记][1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_26(1,10,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_26(1,7,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
	if GetS(67,28,34,3) == 7 then
		instruct_0();
		say("宝藏终于到手了！嘿，鬼才会把这些东西给那个洪安通。") 			
		instruct_0();	
		say("臭小子！我就知道你会搞鬼！",71,0,"洪安通") 		
		instruct_14();   --  14(E):场景变黑
		instruct_3(-2,7,1,0,0,0,0,7986,7986,7986,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
		JY.Person[71]["攻击力"] = JY.Person[71]["攻击力"] + 100
		JY.Person[71]["轻功"] = JY.Person[71]["轻功"] + 50
		JY.Person[71]["防御力"] = JY.Person[71]["防御力"] + 100
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景	
		instruct_0();
		say("咦，你怎么也来了。") 			
		instruct_0();	
		say("哼，我就知道你不会乖乖听话，所以一路派人跟着。你小子难道不怕没有解药毒发身亡吗！",71,0,"洪安通") 			
		instruct_0();
		say("那种小药丸，早就被我解掉了！刚好你自己送上门来，看我报仇雪恨！") 			
		instruct_0();	
        if instruct_6(257,4,0,0) ==false then  
            instruct_15(0);  
            instruct_0();  
            do return; end
        end   		
		instruct_3(-2,7,1,0,0,0,0,6786,6786,6786,-2,-2,-2)
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
		instruct_0();
		say("嘿，那老家伙倒是逃得快。咦，怎么还有人留下来？") 			
		instruct_0();
		say("大哥，是我啊。",225,0,"韦小宝") 	
		instruct_0();
		say("韦兄弟？你怎么会混在神龙教当中？") 		
		instruct_0();
		say("嘿嘿，说来话长，不如不说。如今我已经找到了漂亮老婆，准备扬帆出海逍遥自在了。",225,0,"韦小宝") 	
		instruct_0();
		say("嘻嘻。",86,0,"阿珂") 	
		instruct_0();
		say("嘻嘻。",87,0,"苏荃") 	
		instruct_0();		
		say("＜靠！怎么一找就找到两个！＞韦兄弟还真是享尽齐人之福啊，恭喜恭喜。") 	
		instruct_0();
		say("这还是多亏了大哥把我带出那个破妓院。对了，你要不要回神龙教看看？说不定能赶上一处好戏呢。",225,0,"韦小宝") 	
		instruct_0();
		say("好戏？什么好戏？") 	
		instruct_0();
		say("说了就没意思了，大哥快点过去吧。我就先走了，后会有期。",225,0,"韦小宝") 	
		instruct_14();   --  14(E):场景变黑
		instruct_3(-2,7,1,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景			
		instruct_0();
		say("不知道他说的好戏是什么，去看看吧。") 	
		instruct_0();
		SetS(71,29,47,3,24)
		instruct_3(71,24,0,0,0,0,10010,0,0,0,-2,-2,-2);	
		SetS(71,26,37,3,25)
		instruct_3(71,25,0,0,0,0,0,7034,7034,7034,-2,-2,-2);
		SetS(71,26,36,3,26)
		instruct_3(71,26,0,0,0,0,0,7012,7012,7012,-2,-2,-2);
		SetS(71,28,37,3,27)
		instruct_3(71,27,0,0,0,0,0,8212,8212,8212,-2,-2,-2);
		instruct_3(71,5,0,0,0,0,0,0,0,0,-2,-2,-2)
		instruct_3(71,10,0,0,0,0,0,0,0,0,-2,-2,-2)
	end 
end

OEVENTLUA[10010] = function() --神龙岛收洪安通
	instruct_3(71,24,0,0,0,0,0,0,0,0,-2,-2,-2);	
	instruct_14()
	instruct_13()
	instruct_30(29,47,29,40)
	instruct_0();	
	say("这里怎么打的这么热闹。哎，那个不是洪安通吗？") 
	instruct_0();	
	say("嘿嘿，洪安通，看你跑到哪里去！你属下的五龙使都已经投降了，你还是乖乖认栽吧。",150,0,"冯锡范") 	
	instruct_0();	
	say("冯锡范！我和你向来井水不犯河水，为何领兵攻打我教！",71,0,"洪安通") 
	instruct_0();	
	say("那要怪你自己贪心不足，竟然妄想挖掘我大清的龙脉宝藏。幸亏鹿鼎公韦大人忍辱负重混入神龙教打听到了这个消息。否则不知道还要被你横行多久！",150,0,"冯锡范") 	
	instruct_0();	
	say("＜原来那小子竟然做到了鹿鼎公，不简单啊。光这一手翻云覆雨的厚黑学就够我学一本了。＞") 
	instruct_0();	
	say("你休得含血喷人！我什么宝藏都没动！",71,0,"洪安通") 	
	instruct_0();	
	say("哼，等你到天牢里再分辩吧！来人，给我上！",150,0,"冯锡范") 
	instruct_0();	
	say("＜好机会，我应该落井下石吗？＞") 
	if DrawStrBoxYesNo(-1, -1, "要帮助冯锡范攻打神龙教吗?", C_WHITE, 30) == true then	
		instruct_0();	
		say("君子报仇，德也。洪安通受死！") 
		JY.Person[71]["攻击力"] = JY.Person[71]["攻击力"] + 50
		JY.Person[71]["轻功"] = JY.Person[71]["轻功"] + 50
		JY.Person[71]["防御力"] = JY.Person[71]["防御力"] + 50				
        if instruct_6(257,4,0,0) == false then  
            instruct_15(0);  
            instruct_0();  
            do return; end
        end   	
		JY.Person[71]["攻击力"] = JY.Person[71]["攻击力"] - 150
		JY.Person[71]["轻功"] = JY.Person[71]["轻功"] - 100
		JY.Person[71]["防御力"] = JY.Person[71]["防御力"] - 150				
		instruct_3(-2,27,0,0,0,0,0,0,0,0,-2,-2,-2)
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景		
		instruct_0();	
		say("寇首洪安通已然伏诛，其他人等速速放下武器投降！",150,0,"冯锡范") 
		instruct_0();	
		say("多谢少侠出手相助，咱们以前虽然有些过节，但请看在鹿鼎公的面子上多多包涵。",150,0,"冯锡范") 
		instruct_0();	
		say("＜有官撑腰果然不同，舒服啊！＞冯先生客气了，为国为民于公于私在下都应该出手相助。") 
		instruct_0();	
		say("少侠果然仁义过人。在下这里有本书，是鹿鼎公再三吩咐要转交给少侠的。另外这些礼物为在下的一点心意，请勿推辞。",150,0,"冯锡范") 
		instruct_0();	
		say("冯先生盛情，那在下就却之不恭了。") 
		instruct_32(17, 2)
		instruct_32(174, 5000)
		instruct_32(240, 1)
		QZXS("得到天山雪莲2个，银子5000两，神行百变秘籍")
		instruct_0();
		say("来人，把这贼窝烧掉！",150,0,"冯锡范") 		
		instruct_0();	
		say("＜这么快就烧房子，八成是贪了一堆东西想毁灭证据吧。算了，反正我也赚了，回家去吧。＞") 	
		My_Enter_SubScene(70, 34 ,31 ,2)	
		JY.Scene[71]["进入条件"] = 1
		do return end
	else
		instruct_0();	
		say("＜嘿，虽然我跟那老家伙有仇，不过那帮忘恩负义的更加让我讨厌＞洪教主别怕，我来助你！") 		
		JY.Person[71]["内力"] = math.modf(JY.Person[71]["内力最大值"] * 0.5)
		--JY.Person[71]["生命"] = math.modf(JY.Person[71]["生命最大值"] * 0.5)
		--JY.Person[71]["受伤程度"] = 50
		JY.Person[71]["攻击力"] = JY.Person[71]["攻击力"] - 100
		JY.Person[71]["轻功"] = JY.Person[71]["轻功"] - 50
		JY.Person[71]["防御力"] = JY.Person[71]["防御力"] - 100				
        if instruct_6(258,4,0,0) ==false then  
            instruct_15(0);  
            instruct_0();  
            do return; end
        end   
		instruct_3(-2,25,0,0,0,0,0,0,0,0,-2,-2,-2)
		instruct_3(-2,26,0,0,0,0,0,0,0,0,-2,-2,-2)
		JY.Person[71]["内力"] = JY.Person[71]["内力最大值"] 
		JY.Person[71]["生命"] = JY.Person[71]["生命最大值"]
		JY.Person[71]["受伤程度"] = 0		
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景		
		instruct_0();	
		say("小子！你为什么要救我？",71,0,"洪安通") 	
		instruct_0();	
		say("第一，小爷我看他们不顺眼。第二，看着你现在狼狈落魄的样子更加让我觉得心旷神怡啊。") 
		instruct_0();	
		say("你！",71,0,"洪安通") 	
		instruct_0();	
		say("嘿，别急着动手。就你现在这样子，随便来个人都能把你灭了。怎么样，英雄落魄是常事，不如加入我手下说不定还可以东山再起。") 
		instruct_0();	
		say("＜可恶，不过这小子说得没错。罢了，就忍这一下，以后要他好看！＞好，我这就去小村！",71,0,"洪安通") 
		instruct_14()
		instruct_3(-2,27,0,0,0,0,0,0,0,0,-2,-2,-2)
		instruct_3(70,50,1,0,1097,0,0,6790,6790,6790,-2,-2,-2)	
		instruct_3(70,48,1,0,1097,0,0,6792,6792,6792,-2,-2,-2)	
		instruct_3(70,49,1,0,1097,0,0,6794,6794,6794,-2,-2,-2)	
		instruct_13()
		instruct_0();	
		say("还真是容易被忽悠。嘿，成了我手下以后要报仇就容易多了。")
		addHZ(133)
		instruct_0();	
		say("这地方到处起火，八成要塌了。安全起见，我还是快点回家吧。") 	
		My_Enter_SubScene(70, 34 ,31 ,2)	
		JY.Scene[71]["进入条件"] = 1
		do return end		
	end
end

OEVENTLUA[740] = function()
    instruct_14();   --  14(E):场景变黑
    instruct_26(40,17,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_26(40,18,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_13();   --  13(D):重新显示场景
    instruct_25(22,26,24,17);   --  25(19):场景移动22-26--24-17
    instruct_1(2917,200,0);   --  1(1):[???]说: 贾老二，你看旁边桌上那妞*，身材要得，脸蛋更是要得*。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_25(24,17,18,16);   --  25(19):场景移动24-17--18-16
    instruct_1(2918,35,0);   --  1(1):[令狐冲]说: （这次青城派大举南来，有*些古怪，师父叫我们来探探*动静。小师妹，要沉住气，*假装没听见。）
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2920,79,0);   --  1(1):[???]说: （好，大师哥，我听你的）
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_25(18,16,24,17);   --  25(19):场景移动18-16--24-17
    instruct_1(2919,200,0);   --  1(1):[???]说: 余兄弟，你要是喜欢，咱就*想想办法，把这妞弄回去，*嘿嘿嘿……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,23,0,0,0,0,0,5862,5862,5862,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [23]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(2921,36,0);   --  1(1):[林平之]说: 甚么东西，两个不带眼的狗*崽子，却到我们福州府来撒*野！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2922,200,0);   --  1(1):[???]说: 贾老二，你看这个小白脸眉*清目秀，要上台去唱花旦，*真勾引得人。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2923,200,0);   --  1(1):[???]说: 这位兔儿爷，我越瞧你越不*像男人，准是个大姑娘乔装*改扮的。你这脸蛋儿又红又*白，给我香个面孔好不好？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2924,36,0);   --  1(1):[林平之]说: 我乃福威镖局的少镖头，你*天大胆子，到太岁头上动土*？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2925,200,0);   --  1(1):[???]说: 福威镖局？从来没听见过！*那是干甚么的？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2926,36,0);   --  1(1):[林平之]说: 专打狗崽子的！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2927,245,1);   --  1(1):[???]说: 说的好，我来帮你！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_25(24,17,18,16);   --  25(19):场景移动24-17--18-16
    instruct_1(2928,35,0);   --  1(1):[令狐冲]说: 小师妹，你知不知道这青城*派最厉害的招数叫什么？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2929,79,0);   --  1(1):[???]说: 不知道，叫什么？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2930,35,0);   --  1(1):[令狐冲]说: 叫“屁股向后平沙落雁式”*我这就让他们演给你瞧瞧。
    instruct_0();   --  0(0)::空语句(清屏)
	
	JY.Person[35]["攻击力"] = JY.Person[35]["攻击力"] + 200
	JY.Person[35]["轻功"] = JY.Person[35]["轻功"] + 200
	JY.Person[35]["防御力"] = JY.Person[35]["防御力"] + 200		
	JY.Person[35]["生命最大值"] = JY.Person[35]["生命最大值"] + 1500	
	JY.Person[35]["内力最大值"] = JY.Person[35]["内力最大值"] + 2000		
	JY.Person[35]["生命"] = JY.Person[35]["生命最大值"]	
	JY.Person[35]["内力"] = JY.Person[35]["内力最大值"]	
	JY.Person[35]["武功等级1"] = 999
	JY.Person[35]["声望"] = 89
	
    if instruct_6(203,3,0,0) ==false then    --  6(6):战斗[203]是则跳转到:Label0
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
    end    --:Label0
	
	JY.Person[35]["攻击力"] = JY.Person[35]["攻击力"] - 200
	JY.Person[35]["轻功"] = JY.Person[35]["轻功"] - 200
	JY.Person[35]["防御力"] = JY.Person[35]["防御力"] - 200		
	JY.Person[35]["生命最大值"] = JY.Person[35]["生命最大值"] - 1500	
	JY.Person[35]["内力最大值"] = JY.Person[35]["内力最大值"] - 2000		
	JY.Person[35]["生命"] = JY.Person[35]["生命最大值"]	
	JY.Person[35]["内力"] = JY.Person[35]["内力最大值"]	
	JY.Person[35]["武功等级1"] = 500
	JY.Person[35]["声望"] = 0
	
    instruct_3(-2,26,0,0,0,0,0,7624,7624,7624,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [26]
    instruct_3(-2,27,0,0,0,0,0,7142,7142,7142,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
    instruct_3(-2,24,0,0,0,0,0,7144,7144,7144,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [24]
    instruct_3(-2,28,0,0,0,0,0,6772,6772,6772,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [28]
    instruct_3(-2,25,0,0,0,0,0,6772,6772,6772,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [25]
    instruct_19(21,20);   --  19(13):主角移动至15-14
    instruct_3(-2,14,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
    instruct_3(-2,13,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
    instruct_3(-2,12,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
    instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [11]
    instruct_3(-2,22,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [22]
    instruct_3(-2,20,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [20]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(2931,200,0);   --  1(1):[???]说: 你，你这兔儿爷，你竟敢杀*了我家少爷，咱们这梁子算*结下了，你们等着瞧吧。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,25,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [25]
    instruct_3(-2,24,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [24]
    instruct_3(-2,28,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [28]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(2932,0,1);   --  1(1):[AAA]说: 看来对方来头不善，林兄弟*还是小心为是。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2933,36,0);   --  1(1):[林平之]说: 我想以我家福威镖局名头并*无大事。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2934,35,0);   --  1(1):[令狐冲]说: 这几个人都是四川青城派的*，你杀了的似乎是青城派余*观主的儿子，恐怕福威镖局*会有麻烦啊。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2935,0,1);   --  1(1):[AAA]说: 刚才见二位剑法不凡，不知*是那一派门下，怎样称呼？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2936,35,0);   --  1(1):[令狐冲]说: 在下华山令狐冲。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2937,79,0);   --  1(1):[???]说: 在下华山岳灵珊。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2938,0,1);   --  1(1):[AAA]说: 华山派是名门大派，今日一*见果然名不虚传。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2939,35,0);   --  1(1):[令狐冲]说: 过奖过奖。林兄弟，我看这*青城派绝不会善罢甘休，你*还是回福威镖局早做准备吧*。我和师妹也要回华山禀明*家师。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2940,36,0);   --  1(1):[林平之]说: 也好，那咱们后会有期。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2941,79,0);   --  1(1):[???]说: 后会有期
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2941,0,1);   --  1(1):[AAA]说: 后会有期
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,23,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [23]
    instruct_3(-2,26,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [26]
    instruct_3(-2,27,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
    instruct_3(-2,15,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [15]
    instruct_3(56,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:场景[福威镖局]:场景事件编号 [3]
    instruct_3(56,0,1,0,744,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[福威镖局]:场景事件编号 [0]
    instruct_37(1);   --  37(25):增加道德1
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
end

OEVENTLUA[279] = function() --冰火岛战狮王
    instruct_1(870,0,1);   --  1(1):[AAA]说: 这里有一撮金毛，应该是金*毛狮王谢逊的吧，可是谢法*王怎么不见了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_2(211,1);   --  2(2):得到物品[一撮金毛][1]
    instruct_0();   --  0(0)::空语句(清屏)
	instruct_14()
    instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
	SetS(33, 31, 49, 3, 100)
	SetS(33, 32, 49, 3, 101)
	instruct_3(33,101,0,0,0,0,10011,0,0,0,-2,-2,-2); 
	instruct_3(33,100,0,0,0,0,10011,0,0,0,-2,-2,-2); 	
	instruct_13()
	instruct_0();	
	say("谁？？！！！") 	
	JY.Person[13]["攻击力"] = JY.Person[13]["攻击力"] + 150
	JY.Person[13]["轻功"] = JY.Person[13]["轻功"] + 150
	JY.Person[13]["防御力"] = JY.Person[13]["防御力"] + 150		
	if instruct_6(261,4,0,0) == true then	
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景 		
		instruct_0();	
		addthing(69)
	else
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景 	
	end
	instruct_0();
	JY.Person[13]["攻击力"] = JY.Person[13]["攻击力"] - 150
	JY.Person[13]["轻功"] = JY.Person[13]["轻功"] - 150
	JY.Person[13]["防御力"] = JY.Person[13]["防御力"] - 150		
	instruct_0();	
	say("那人在黑暗中也身法敏捷，内力奇高，难道是......") 	
	instruct_0();		
end


OEVENTLUA[33] = function() --飞狐邪线洗刀剑
    if instruct_16(4,2,0) ==false then    --  16(10):队伍是否有[阎基]是则跳转到:Label0
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label0


    if instruct_16(72,2,0) ==false then    --  16(10):队伍是否有[田归农]是则跳转到:Label1
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label1

    instruct_14();   --  14(E):场景变黑
    instruct_37(-3);   --  37(25):增加道德-3
    instruct_3(3,9,1,0,640,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[有间客栈]:场景事件编号 [9]
    instruct_3(3,12,1,0,640,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[有间客栈]:场景事件编号 [12]
    instruct_3(3,11,1,0,640,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[有间客栈]:场景事件编号 [11]
    instruct_3(3,10,1,0,640,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[有间客栈]:场景事件编号 [10]
    instruct_3(-2,1,0,0,0,0,0,7994,7994,7994,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
    instruct_1(171,72,1);   --  1(1):[田归农]说: 一切按计划行事
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(172,4,1);   --  1(1):[阎基]说: 您就放心吧，嘿嘿
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_30(41,31,35,31);   --  30(1E):主角走动41-31--35-31
    instruct_1(173,72,1);   --  1(1):[田归农]说: 苗兄，别来无恙？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(50,3,0);   --  1(1):[苗人凤]说: 姓田的，亏你还有脸来见我*！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(51,72,1);   --  1(1):[田归农]说: 苗兄，何必这么大的火气，*伤了你我兄弟的和气。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(52,3,0);   --  1(1):[苗人凤]说: ……**她还好吗？……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(174,72,1);   --  1(1):[田归农]说: ＜这个死阎基怎么还不动手*……＞
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(175,4,1);   --  1(1):[阎基]说: 着——！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(176,3,0);   --  1(1):[苗人凤]说: 啊——
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,1,0,0,0,0,0,5212,5212,5212,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(177,72,1);   --  1(1):[田归农]说: 哈哈，我看你是见不到她了*。这药是从毒手药王那弄来*的断肠草粉末，药效也真够*狠，现下你双眼已瞎，我看*"打遍天下无敌手"的金面佛*苗人凤，今日要上西天了，*小兄弟，咱们上！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(178,1,0);   --  1(1):[胡斐]说: 苗大侠莫慌，我来帮你。
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(0,4,0,0) ==false then    --  6(6):战斗[0]是则跳转到:Label2
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
    end    --:Label2

    instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
	instruct_3(49,1,0,0,0,0,0,0,0,0,0,0,0) --邪线无法触发药王庄事件
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_2(144,1);   --  2(2):得到物品[飞狐外传][1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_2(117,1);   --  2(2):得到物品[苗家剑法][1]
    instruct_0();   --  0(0)::空语句(清屏)
	instruct_2(225,1);   --  2(2):得到物品[闯王藏宝图][1]
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_39(5);   --  39(27):打开场景山洞	
	if JY.Person[72]["武功1"] == 44 then
		instruct_0();	
		say("苗家剑法果然厉害。嘿嘿，苗人凤你辛劳半生完善这武功，却没想到最后为他人做了嫁衣吧，哈哈哈。",72,0,"田归农") 
		instruct_0();	
		say("田大侠终于手刃苗人凤，实在可喜可贺。",4,0,"阎基") 
		instruct_0();	
		say("田某能有今日之功，阎大夫功不可没啊。对了，我听说如果一个人同时钻研这胡家刀法和苗家剑法可以从中得到启发，领悟更精妙的武学。如今胡家已经绝后，世上会这胡家刀法的就只有阎大夫一人了，不如我们来研究一下这两种武学的奥妙吧。",72,0,"田归农") 
		instruct_0();	
		say("田大侠有此美意，阎某自当尽力配合。",4,0,"阎基") 
		instruct_14()
		instruct_13()
		instruct_2(136,1);
		JY.Person[72]["武功2"] = 67
		JY.Person[72]["武功等级2"] = 0
		JY.Person[4]["武功2"] = 44
		JY.Person[4]["武功等级2"] = 0		
		instruct_0();	
		say("哈哈哈，好！这刀剑归真的奥妙终于被我俩领悟了！从此世上还有何人是我们敌手？",72,0,"田归农") 
		instruct_0();	
		say("（我怎么一点好处也没捞到......）") 
		instruct_0();			
	end
end

OEVENTLUA[20000] = function()	--杨逍离队事件
    say("杨左使，你先回小村，有需要时，我再去找你帮忙。");
    instruct_21(11);   --  21(15):离队
    instruct_3(70,100,1,0,20001,0,0,7982,7982,7982,-2,-2,-2); 
end

OEVENTLUA[20001] = function()	--杨逍小村
		MyTalk("有需要我帮忙的地方吗？", 11);
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_9(0,29) ==true then    --  9(9):是否要求加入?否则跳转到:Label1

        if instruct_20(20,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label2
            instruct_10(11);   
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
            do return; end
        end    --:Label2

         MyTalk("你的队伍已满，我无法加入。", 11);
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label1
end

OEVENTLUA[869] = function()	--韦小宝小村
    instruct_0();   --  0(0)::空语句(清屏)
	MyTalk("有需要我帮忙的地方吗？", 664);
    if instruct_9(0,29) ==true then    --  9(9):是否要求加入?否则跳转到:Label1
        if instruct_20(20,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label2
			if JY.Person[664]["觉醒"] <= 0 then
				MyTalk("又想拉我这个风流倜傥、有情有义的小宝哥入伙嘛？这次拿5000块大洋就再跟你跑跑！", 664);
				if JY.GOLD < 5000 then
					MyTalk("啥玩意？5000块都木有！？没钱就别来烦我！", 664);
					do return end
				end
				Cls()
				say("我怎敢赖小宝哥的帐，这5000块您收好") 
				MyTalk("你小子还算够意思，那就再跟你跑跑", 664);
				setJX(664)
				instruct_2(174, -5000)
			end
            instruct_10(664);   
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
            do return; end
        end    --:Label2
            MyTalk("你的队伍已满，我无法加入。", 664);
            instruct_0();   --  0(0)::空语句(清屏)
            do return; end
    end     --:Label1
end

OEVENTLUA[20002] = function()	--纪晓芙事件
    instruct_0()
	say("纪姑娘，这里可还住得惯吧？");
	instruct_0()
	say("谢谢少侠关心，我们在这里住得很好。",154,0,"纪晓芙")	
end

OEVENTLUA[1062] = function() --杀灭绝后杨逍支线关闭
    instruct_1(3974,6,0);   --  1(1):[灭绝]说: 魔教妖邪，来我峨嵋山有何*贵事．
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3975,0,1);   --  1(1):[AAA]说: 上回看你手中那把宝剑，*寒芒吞吐，电闪星飞，想必*就是传说中的”倚天剑”？*小侠我想向你借来用用．
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3976,6,0);   --  1(1):[灭绝]说: 光明顶上被你侥幸获胜，*你现在还敢来我峨嵋撒野，*莫非真视我峨嵋无人．
    instruct_0();   --  0(0)::空语句(清屏)
    if instruct_5(11,0) ==false then    --  5(5):是否选择战斗？是则跳转到:Label0
        instruct_1(3977,0,1);   --  1(1):[AAA]说: 那里，那里．我只不过是来*劝师太，与明教间的事能和*就和．*自古以来冤家宜解不宜结．
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(3978,6,0);   --  1(1):[灭绝]说: 阁下未免管的太多了吧，*难道你真以为你是*”武林盟主”吗！
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0
    if instruct_6(20,4,0,0) ==false then    --  6(6):战斗[20]是则跳转到:Label1
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label1
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3979,0,1);   --  1(1):[AAA]说: 宝剑还是应该配英雄，*怎样？师太，这”倚天剑”*可以让给我了吧．
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3980,6,0);   --  1(1):[灭绝]说: 魔教妖孽，想从我灭绝手中*拿走倚天剑，等下辈子吧！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_27(2,5468,5496);   --  27(1B):显示动画
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_3(-2,-2,-2,-2,1063,-1,-1,5238,5238,5238,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3981,191,0);   --  1(1):[???]说: 师父，师父！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3982,0,1);   --  1(1):[AAA]说: 师太，师太！何苦如此呢？*若真不想给我，跟我说一声*就行了．唉！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3983,191,0);   --  1(1):[???]说: 师父，师父！*可恶的魔教妖邪，*替我师父嚐命来．
    instruct_0();   --  0(0)::空语句(清屏)
    if instruct_6(21,4,0,0) ==false then    --  6(6):战斗[21]是则跳转到:Label2
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label2
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_3(-2,4,1,0,1064,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [4]
    instruct_3(-2,10,1,0,1064,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [10]
    instruct_3(-2,9,1,0,1064,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [9]
    instruct_3(-2,8,1,0,1064,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [8]
    instruct_3(-2,7,1,0,1064,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [7]
    instruct_3(-2,6,1,0,1064,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
    instruct_3(-2,5,1,0,1064,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [5]
    instruct_3(-2,3,1,0,1064,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
	addevent(-2, 100, 0, 0, 0, 0)
	addevent(-2, 101, 0, 0, 0, 0)
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_37(-5);   --  37(25):增加道德-5
    instruct_0();   --  0(0)::空语句(清屏)
end

OEVENTLUA[10011] = function()	--杨逍峨嵋事件	
	if instruct_16(9) and instruct_16(16) then
		instruct_14()
		SetS(33, 31, 42, 3, 99)
		instruct_3(33,99,0,0,0,0,0,7982,7982,7982,-2,-2,-2); 
		instruct_3(33,100,0,0,0,0,0,0,0,0,-2,-2,-2); 
		instruct_3(33,101,0,0,0,0,0,0,0,0,-2,-2,-2); 
		instruct_13()	
		instruct_0()
		say("咦？那个人是......杨左使？");
		instruct_0();	
		instruct_30(31,49,31,44)	
		instruct_0();	
		say("啊，属下参见教主和少侠！",11,0,"杨逍") 
		instruct_0();	
		say("杨左使不必多礼。为何你会在这里？",9,0,"张无忌") 
		instruct_0();	
		say("这......",11,0,"杨逍")
		instruct_0()
		say("杨左使似有难言之隐，无忌兄弟你也别追问了。");
		instruct_0();	
		say("不！教主既然问起，而少侠又对我明教有大恩，杨逍自当言无不尽。这事说来话长......其实我来这里，是想找一个人。",11,0,"杨逍")	
		instruct_0()
		say("峨嵋派的人？");
		instruct_0();	
		say("是的。在下曾与一位峨嵋派的姑娘私订了终身。可惜彼此之间始终有门派之别。我本来打算带她远走高飞，从此不问世事。但六大门派突然围攻光明顶，杨某深受阳教主大恩，不能不报，闻讯后日夜兼程赶回光明顶助拳。她见劝我不住，又恐彼此门派冤仇再也难解，郁郁之下远遁而去。",11,0,"杨逍")	
		instruct_0();	
		say("我见如今困局已解，便下山来寻访她的踪迹。可惜数个月来，我踏遍了所有她可能去的地方，都一无所获。失神之下，便来到了这峨嵋山，祈望能在这里打听出她的消息",11,0,"杨逍")	
		instruct_0()
		say("杨左使深情如此，令人动容。如不嫌弃，在下愿助杨左使一臂之力。不知那姑娘姓名特征？");	
		instruct_0();	
		say("她姓纪，名晓芙。",11,0,"杨逍")	
		instruct_0();	
		say("啊？这个名字......",16,0,"胡青牛")		
		instruct_0();	
		say("胡大夫是否有什么线索？",9,0,"张无忌") 	
		instruct_0();	
		say("属下不敢隐瞒。纪姑娘曾经来过我蝴蝶谷求医。本来我只救明教之人，但内子瞧她孤苦伶仃且身怀六甲，起了怜悯之心......",16,0,"胡青牛")		
		instruct_0();	
		say("身怀六甲？难道......难道！！！胡大夫可知她人现在在何处？",11,0,"杨逍")		
		instruct_0();	
		say("这个......她行动不便，应该走不了多远。我猜她应该住在蝴蝶谷附近吧。",16,0,"胡青牛")		
		instruct_0();	
		say("教主！少侠！杨逍告退！",11,0,"杨逍")		
		instruct_14()
		instruct_3(33,99,0,0,0,0,0,0,0,0,-2,-2,-2); 
		instruct_13()		
		instruct_0()
		say("杨左使！怎么走得这么快。罢了，无忌兄弟，我们也帮着找找吧。");
		instruct_0();	
		say("好！",9,0,"张无忌") 		
		SetS(40, 11, 36, 3, 61)
		SetS(40, 11, 35, 3, 62)
		instruct_3(40,62,0,0,0,0,0,5396,5396,5396,-2,-2,-2); 
		SetS(40, 12, 35, 3, 63)
		instruct_3(40,63,0,0,0,0,0,5362,5362,5362,-2,-2,-2); 
		SetS(40, 12, 40, 3, 64)
		instruct_3(40,64,0,0,0,0,10012,0,0,0,-2,-2,-2); 
		instruct_3(11,90,0,0,0,0,0,0,0,0,-2,-2,-2); 	
	end
end

OEVENTLUA[10012] = function()	--救纪晓芙事件	
	instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2); 
	instruct_0();	
	say("咦，里面有人在争执。")	
	instruct_0();	
	say("你还是不肯听师父的话吗！那杨逍与我峨嵋派有血海深仇，只要你肯假意接近，寻个机会把他杀了，峨嵋派的掌门之位就是你的了！",6,0,"灭绝")		
	instruct_0();	
	say("我....师父....我做不到....我....我肚子里已经有了他的骨肉....",154,0,"纪晓芙")		
	instruct_0();	
	say("什么！你，你个逆徒！！",6,0,"灭绝")		
	instruct_0();	
	say("住手！")	
	JY.Person[6]["攻击力"] = JY.Person[6]["攻击力"]+100
	JY.Person[6]["防御力"] = JY.Person[6]["防御力"]+100
	JY.Person[6]["轻功"] = JY.Person[6]["轻功"]+100	
    if instruct_6(262,4,0,0) ==false then   
        instruct_0();  
        instruct_15(0);  
        do return; end
    end    
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_13();   --  13(D):重新显示场景	
	instruct_0();	
	say("又是你！我自己管教徒弟关你何事！",6,0,"灭绝")		
	instruct_0();	
	say("人家两情相悦，师太何苦棒打鸳鸯。何况纪姑娘现在身怀六甲，这一剑刺下去一尸两命。师太既为出家人，理应持大慈悲戒，破除嗔恚障才是。")	
	instruct_0();	
	say("晓芙！晓芙！",11,0,"杨逍")		
	instruct_14()
	instruct_3(40,61,0,0,0,0,0,5340,5340,5340,-2,-2,-2); 
	instruct_13()
	instruct_0();	
	say("我终于找到你了，晓芙！",11,0,"杨逍")	
	instruct_0();	
	say("是你，真的是你....",154,0,"纪晓芙")		
	instruct_0();	
	say("呸，就是你！杨逍，拿命来！！",6,0,"灭绝")		
	JY.Person[11]["生命最大值"] = JY.Person[11]["生命最大值"] + 700	
	JY.Person[11]["内力最大值"] = JY.Person[11]["内力最大值"] + 1000		
	JY.Person[11]["生命"] = JY.Person[11]["生命最大值"]	
	JY.Person[11]["内力"] = JY.Person[11]["内力最大值"]	
    if instruct_6(263,4,0,0) ==false then   
        instruct_0();  
        instruct_15(0);  
        do return; end
    end  
	JY.Person[6]["攻击力"] = JY.Person[6]["攻击力"]-100
	JY.Person[6]["防御力"] = JY.Person[6]["防御力"]-100
	JY.Person[6]["轻功"] = JY.Person[6]["轻功"]-100	
	JY.Person[11]["生命最大值"] = JY.Person[11]["生命最大值"] - 700	
	JY.Person[11]["内力最大值"] = JY.Person[11]["内力最大值"] - 1000		
	JY.Person[11]["生命"] = JY.Person[11]["生命最大值"]	
	JY.Person[11]["内力"] = JY.Person[11]["内力最大值"]		
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_13();   --  13(D):重新显示场景	
	instruct_0();	
	say("灭绝！我今天看在晓芙面上不与你为难，你若是知趣就快快离开。",11,0,"杨逍")
	instruct_0();	
	say("师父....晓芙对不起你....",154,0,"纪晓芙")		
	instruct_0();	
	say("哼！我不是你师父！你以后也莫再自称是峨嵋弟子！",6,0,"灭绝")
	instruct_14()
	instruct_3(40,63,0,0,0,0,0,0,0,0,-2,-2,-2); 
	instruct_13()	
	instruct_0();	
	say("两位经过这一番风浪终于重逢，真是可喜可贺啊。")	
	instruct_0();	
	say("这都多亏了少侠为晓芙挡下那一剑。杨某亏欠少侠甚多，不知如何才能报答。",11,0,"杨逍")	
	instruct_0();	
	say("多谢少侠救命之恩。",154,0,"纪晓芙")	
	instruct_0();	
	say("两位客气了。我看纪姑娘身体多有不便，不如来我小村修养一阵，也好有个照应。")	
	instruct_0();	
	say("如今教内已稳定下来，光明顶又有几位护法和范兄弟坐镇，应该无碍。那我们就叨扰了。",11,0,"杨逍")	
	instruct_14()
	instruct_3(40,61,0,0,0,0,0,0,0,0,-2,-2,-2); 
	instruct_3(40,62,0,0,0,0,0,0,0,0,-2,-2,-2); 	
	SetS(70,19,23,3,100); 
	SetS(70,18,23,3,101); 
    instruct_3(70,100,1,0,20001,0,0,7982,7982,7982,-2,-2,-2); 	
	instruct_3(70,101,1,0,20002,0,0,5398,5398,5398,-2,-2,-2); 	
	instruct_13()	
	instruct_37(3)	
end

OEVENTLUA[573] = function()
    if cxzj() == 49 then
		instruct_1(4366,49,0) --[49虚竹]:三弟，好久不见了
	    instruct_0();
		instruct_1(4367,53,0); --[53段誉]:二哥！
		instruct_0();
		say("不知大哥和阿朱姑娘在塞外可好...", 53)
		instruct_0();
		instruct_1(4370,49,0) --[49虚竹]:应该不错吧，远离了这片江湖，远离了恩怨情仇，现在的大哥一定很幸福。
		instruct_0();
		say("不错，我还真向往乔大哥这种生活...", 53)
		instruct_0();
		say("呵呵，今天不谈其他，好好喝酒...", 49)
		instruct_0();
		instruct_14();
		instruct_13();
		if instruct_18(79,0,192) == true then
			instruct_1(4381,53,0); --[53段誉]:对了，二哥，这套北冥神功我教给你吧...
			instruct_35(zj(),1,85,999); --设置[49虚竹]武功[1]为[85北冥神功]经验为999
			instruct_0();
			instruct_1(4382,49,0) --[49虚竹]:那，三弟，王姑娘，这是灵鹫宫的特产，可以美容...
			instruct_0();
			instruct_1(4383,53,0); --[53段誉]:谢谢二哥，我们就不客气了。
	        instruct_0(); 
			instruct_48(53,100); --[53段誉]增加生命100
			instruct_48(76,200); --[76王语嫣]增加生命200
	        instruct_0();
		end	   
			say("...二哥，我们也去小村帮忙吧。", 53)
	        instruct_0();
			say("啊，可是三弟，这，这岂不是打扰你们的神仙生活了？", 49)
	        instruct_0();
			say("呵呵，我能和语嫣在一起可多愧二哥，少侠有事我们怎能不帮忙，对不对，王姑娘。", 53)
			instruct_0();
			say("对，我们这就去小村。", 76)
	        instruct_0();
	        instruct_14();
			instruct_3(104,59,1,0,965,0,0,6308,6308,6308,-2,-2,-2);--修改事件定义:场景[104钓鱼岛]:场景事件编号[59]
			instruct_3(104,51,1,0,977,0,0,6296,6296,6296,-2,-2,-2);--修改事件定义:场景[104钓鱼岛]:场景事件编号[59]
			instruct_3(-2,6,0,0,0,0,0,0,0,0,0,0,0); --修改事件定义:
			instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0); --修改事件定义:
			instruct_3(70,9,1,0,143,0,0,6310,6310,6310,-2,-2,-2); --修改事件定义:场景[70小村]:场景事件编号[27]
			instruct_3(70,27,1,0,167,0,0,6298,6298,6298,-2,-2,-2); --修改事件定义:场景[70小村]:场景事件编号[27]
	        instruct_0();
	        instruct_13();  
		do return end
	end		
        instruct_37(2) --增加道德2
	    instruct_1(2502,0,1); --段公子好，王姑娘好。恭喜*段公子终於虏获美人心。
	    instruct_0();
	    instruct_1(2503,53,0); --[53段誉]:呵呵，这都多亏了少侠的帮*忙啊。
	    instruct_0();
	    instruct_1(2504,0,1); --[0资]:哪里哪里，我不曾帮过任何*的忙，都是段公子精诚所至*，金石为开啊。但不知慕容*公子……
	    instruct_0();
	    instruct_1(2505,76,0); --[76王语嫣]:我表哥他……他心里只有那*个虚无飘渺的皇帝梦……我*现在才知道，真心待我的只*有段公子一个人。
	    instruct_0();
	    if instruct_16(49,0,198) == true then
		    if instruct_18(79,0,192) == true then
			   instruct_1(4366,49,0) --[49虚竹]:三弟，好久不见了
	           instruct_0();
			   instruct_1(4367,53,0); --[53段誉]:二哥！
			   instruct_0();
			   instruct_1(4368,0,1); --[0资]:哦？对了，你们是结拜兄弟吧，大哥就是乔大哥。
			   instruct_0();
			   instruct_1(4369,53,0);--[53段誉]:是啊，不知大哥和阿朱姑娘在塞外可好...
			   instruct_0();
			   instruct_1(4370,49,0) --[49虚竹]:应该不错吧，远离了这片江湖，远离了恩怨情仇，现在的大哥一定很幸福。
			   instruct_0();
			   instruct_1(4371,0,1); --[0资]:不错，我还真向往乔大哥这种生活，可惜我还有事情没有做完...
			   instruct_0();
			   instruct_1(4372,49,0) --[49虚竹]:呵呵，小兄弟的事我们也会尽力帮忙的，今天不谈其他，好好喝酒...
			   instruct_0();
			   instruct_1(4373,0,1); --[0资]:哈哈，我们好好喝喝，不过别把王姑娘冷落了，否则段兄可要遭殃..
			   instruct_0();
			   instruct_1(4374,76,0); --[76王语嫣]:少侠别胡说<脸红>
			   instruct_0();
			   instruct_1(4375,0,1); --[0资]:嘿，不说了不说了，我们还是说说别的...
			   instruct_0();
			   instruct_14();
			   instruct_13();
			   instruct_1(4381,53,0); --[53段誉]:对了，二哥，这套北冥神功我教给你吧...
			   instruct_35(49,1,85,999); --设置[49虚竹]武功[1]为[85北冥神功]经验为999
			   instruct_0();
			   instruct_1(4382,49,0) --[49虚竹]:那，三弟，王姑娘，这是灵鹫宫的特产，可以美容...
			   instruct_0();
			   instruct_1(4383,53,0); --[53段誉]:谢谢二哥，我们就不客气了。
	           instruct_0(); 
			   instruct_48(53,100); --[53段誉]增加生命100
			   instruct_48(76,200); --[76王语嫣]增加生命200
	           instruct_0();
			   instruct_1(4376,0,1); --[0资]:今天真开心啊，哎，这样交流的机会可不多了。。。
	           instruct_0();
			   instruct_0();
			   instruct_1(4377,53,0);--[53段誉]:...少侠，我们也去小村帮忙吧。
	           instruct_0();
			   instruct_1(4378,0,1);  --[0资]:啊，可是段兄，这，这岂不是打扰你们的神仙生活了？
	           instruct_0();
			   instruct_1(4379,53,0); --[53段誉]:呵呵，我能和语嫣在一起可多愧少侠，少侠有事我们怎能不帮忙，对不对，王姑娘。
			   instruct_0();
			   instruct_1(4380,0,1); --[0资]:对，少侠，我们这就去小村。
	           instruct_0();
	           instruct_14();
			   instruct_3(104,59,1,0,965,0,0,6308,6308,6308,-2,-2,-2);--修改事件定义:场景[104钓鱼岛]:场景事件编号[59]
			   instruct_3(104,51,1,0,977,0,0,6296,6296,6296,-2,-2,-2);--修改事件定义:场景[104钓鱼岛]:场景事件编号[59]
			   instruct_3(-2,6,0,0,0,0,0,0,0,0,0,0,0); --修改事件定义:
			   instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0); --修改事件定义:
			   instruct_3(70,9,1,0,143,0,0,6310,6310,6310,-2,-2,-2); --修改事件定义:场景[70小村]:场景事件编号[27]
			   instruct_3(70,27,1,0,167,0,0,6298,6298,6298,-2,-2,-2); --修改事件定义:场景[70小村]:场景事件编号[27]
	           instruct_0();
	           instruct_13();
			end
			   do return end
	    end
	instruct_1(2506,53,0);--[53段誉]:语嫣……这位少侠帮了我们*这么多，我们也帮帮他吧。
	instruct_0();
	instruct_1(2507,76,0); --[76王语嫣]:好啊，那我们就去小村吧
	instruct_0();
	instruct_14();
	instruct_3(104,59,1,0,965,0,0,6308,6308,6308,-2,-2,-2);--修改事件定义:场景[104钓鱼岛]:场景事件编号[59]
	instruct_3(104,51,1,0,977,0,0,6296,6296,6296,-2,-2,-2);--修改事件定义:场景[104钓鱼岛]:场景事件编号[59]
	instruct_3(-2,6,0,0,0,0,0,0,0,0,0,0,0); --修改事件定义:
	instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0); --修改事件定义:
	instruct_3(70,9,1,0,143,0,0,6310,6310,6310,-2,-2,-2); --修改事件定义:场景[70小村]:场景事件编号[27]
	instruct_3(70,27,1,0,167,0,0,6298,6298,6298,-2,-2,-2); --修改事件定义:场景[70小村]:场景事件编号[27]
	instruct_0();
	instruct_13();
end
OEVENTLUA[631] = function()
    instruct_2(99,1);   --  2(2):得到物品[天山折梅手][1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号

	if cxzj() == 49 then    --  16(10):队伍是否有[虚竹]否则跳转到:Label0
        instruct_33(zj(),14,0);   --  33(21):虚竹学会武功天山折梅手
		AddPersonAttrib(zj(), "拳掌功夫", 10)
		tb("虚竹拳掌加十点")
        instruct_0();   --  0(0)::空语句(清屏)
    end
    if instruct_16(49,0,5) ==true then    --  16(10):队伍是否有[虚竹]否则跳转到:Label0
        instruct_33(49,14,0);   --  33(21):虚竹学会武功天山折梅手
		AddPersonAttrib(49, "拳掌功夫", 10)
		tb("虚竹拳掌加十点")
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label0
end

OEVENTLUA[634] = function() --主角成为逍遥掌门灵鹫宫剧情变化
    if instruct_18(200,2,0) ==false then    --  18(12):是否有物品[七宝指环]是则跳转到:Label0
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label0

    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,2,1,0,0,0,0,5288,5288,5288,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
    instruct_3(-2,3,1,0,0,0,0,7128,7128,7128,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_25(45,45,39,45);   --  25(19):场景移动45-45--39-45
    instruct_1(2680,118,0);   --  1(1):[???]说: 哈哈哈，我的好师姐，我算*准了你返老还童的日子，你*躲不过去的，如今你的七经*八脉都已被我震断，你的死*期已到，哈哈哈……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2681,117,0);   --  1(1):[???]说: 你这个臭贱人……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2682,245,1);   --  1(1):[???]说: 那个老婆婆好像受伤了，赶*快救人。
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(202,4,0,0) ==false then    --  6(6):战斗[202]是则跳转到:Label1
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label1

    instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
    instruct_19(41,45);   --  19(13):主角移动至29-2D
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(2683,0,1);   --  1(1):[AAA]说: 老婆婆，你没事吧？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2684,117,0);   --  1(1):[???]说: 臭小子，什么没事，老婆子*就要死啦！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2685,0,1);   --  1(1):[AAA]说: 啊？这……这……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2686,117,0);   --  1(1):[???]说: 不过那个贱人总算死在了我*前头，老婆子还得谢谢你啊*……*咦？你手上拿的是什么？*你怎么会有我们逍遥派的*掌门指环？
    instruct_0();   --  0(0)::空语句(清屏)
	if MPPD(zj()) == 7 or cxzj() == 49 then
		say("这个是....我师父给我的，事情是这样的....")
	else
		instruct_1(2687,0,1);   --  1(1):[AAA]说: 这个是无崖子前辈给我兄弟*的，事情是这样的……
	end
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_13();   --  13(D):重新显示场景
    instruct_1(2688,117,0);   --  1(1):[???]说: 师兄，师兄，你怎么在我之*前走了……
    instruct_0();   --  0(0)::空语句(清屏)
	if MPPD(zj()) == 7 or cxzj() == 49 then
		say("难道你就是童姥师伯？那刚才那个女人是....？")
	else
		instruct_1(2689,0,1);   --  1(1):[AAA]说: 前辈原来是无崖子前辈的师*妹啊，那刚才那个女人是…*…？
	end
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2690,117,0);   --  1(1):[???]说: 那个贱人叫李秋水，是我师*妹，敢和我争师弟，哼，终*于死在我前头了。小子，帮*我个忙，把这个信号发到空*中。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,5,0,0,0,0,0,6084,6084,6084,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [5]
    instruct_3(-2,6,0,0,0,0,0,6084,6084,6084,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
    instruct_3(-2,8,0,0,0,0,0,6084,6084,6084,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [8]
    instruct_3(-2,7,0,0,0,0,0,6084,6084,6084,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [7]
    instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
    instruct_3(-2,0,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
    instruct_3(-2,4,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [4]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(2691,240,0);   --  1(1):[???]说: 姥姥，姥姥，你怎么了？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2692,117,0);   --  1(1):[???]说: 姥姥要死了，你们是不是很*开心啊？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2693,240,0);   --  1(1):[???]说: 属下不敢。姥姥，是谁把你*害成这样，我们去找他算帐*！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2694,117,0);   --  1(1):[???]说: 哼，你们倒好心！不用啦，*这位少侠已经杀了那个贱人*。你们听着，这位少侠以后*就是灵鹫宫的新主人，快点*拜见！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2695,240,0);   --  1(1):[???]说: 参见新主人！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2696,248,1);   --  1(1):[???]说: 啊？啊。好，好，（好别扭*……）
    instruct_0();   --  0(0)::空语句(清屏)
    if MPPD(zj()) == 7 and cxzj() ~= 49 then
		say("小子，以后灵鹫宫就是你的了。你既然去找那姓丁的报仇，我就传你一些功夫。", 117)
		if GetS(113,0,0,0) == 0 then 
	        say("这是逍遥祖师所创的生死符，我现在就传予你。",117) 
	        instruct_0();
			if instruct_11(0,188) == true then 
	            QZXS("领悟生死符精要！")
			    say("多谢师伯",0)
	            instruct_0();
	            setLW1(176)
			else
				say("臭小子。",117) 
			end	
	    end
	    addthing(336)
		say("谢谢师伯！")
		instruct_33(zj(),101,0)
		say("师弟，我要去找你了....", 117)
	elseif cxzj() == 49 then 	
	    say("小和尚，以后灵鹫宫就是你的了。你既然去找那姓丁的报仇，我就传你一些功夫。", 117)
		say("谢谢师叔！")
		dark()
		light()
		instruct_33(zj(),176,0);
		AddPersonAttrib(0, "暗器技巧", 50)
		tb("虚竹暗器加五十点")			
		addthing(336)
		say("师兄，我要去找你了....", 117)
	elseif inteam(49) then			
		say("你这小和尚就是新的逍遥掌门吧。", 117)
		say("这个..小僧..", 49)
		say("哼，看你武功低微畏畏缩缩的样子，唉，我就传授这生死符给你，也算是对师兄有个交待。", 117)
		setJX(49)
		dark()
		light()
		instruct_33(49,176,0);
		AddPersonAttrib(49, "暗器技巧", 50)
		tb("虚竹暗器加五十点")	
        say("小僧..似乎感觉到记忆的某个封印打开了..", 49)
        QZXS("虚竹领悟八部战意技【夜叉·轮回生死符】！")			
		addthing(336)
	end
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2698,240,0);   --  1(1):[???]说: 姥姥……
    instruct_0();   --  0(0)::空语句(清屏)
	if MPPD(zj()) == 7 and cxzj() ~= 49 then
		if (PersonKF(zj(), 85) or T1LEQ(0)) and GetS(111, 0, 0, 0) == 0 then
			say("咦？这是刚李秋水掉落的东西？北冥神功注解！！好东西，要不要学？",0) 
			instruct_0();
			if instruct_11(0,188) == true then
				QZXS("领悟北冥神功精义！")
				instruct_0();
				SetS(111, 0, 0, 0, 85)
			else
				say("还是算了，不知道会不会练死人。",0) 
			end
		end
		if PersonKF(zj(), 98) and GetS(113,0,0,0) == 0 then 
			say("这里还有半卷秘籍，内容写着模拟天下武学无迹可寻。",0) 
			instruct_0();
			if instruct_11(0,188) == true then 
				QZXS("领悟小无相功上半卷！")
				say("有半卷也不错了",0)
				instruct_0();
				setLW1(98)
			else
				say("如果把自己练死就亏大了！",0) 
			end	
		end
	end	
    instruct_3(-2,2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
    instruct_3(-2,8,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [8]
    instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [7]
    instruct_3(-2,6,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
    instruct_3(-2,5,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [5]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
end

OEVENTLUA[911] = function() --修正笑傲邪线解决隐形岳不群bug
    instruct_14();   --  14(E):场景变黑
    instruct_26(40,17,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_26(40,18,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_3(-2,83,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [83]
    instruct_3(-2,84,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [84]
    instruct_3(-2,85,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [85]
    instruct_13();   --  13(D):重新显示场景
    instruct_30(28,28,15,28);   --  30(1E):主角走动28-28--15-28
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3534,0,1);   --  1(1):[AAA]说: 你就是东方不败？*＜怎麽看起来像个娘们？＞
    instruct_0();   --  0(0)::空语句(清屏)
	JY.Person[27]["半身像"] = 530
	JY.Person[27]["性别"] = 1
	if JY.Person[0]["性别"] == 1 then
	say("啊！你便是到梅庄救走任我行的那小丫头．本教主早想见你一见...",27)
	say("小丫头，要不要来我神教做事？本教主可以给你任何你想要的！",27)
	else
	say("啊！你便是到梅庄救走任我行的那小子．本教主早想见你一见...",27)
	say("小子，要不要来我神教做事？本教主可以给你任何你想要的！",27)
	end
	say("。。。。。（任何想要的？那不是可以让他给我天书？我到底要不要加入？）",0)
	if instruct_11(0,188) == true then
		if JY.Person[0]["性别"] == 1 then
	say("小丫头，你想倒戈？",26)
	say("姑娘，东方不败作恶多端乃是人人得而诛之的魔头，你可不能误入歧途啊！！",35)
	say("。。。。。。。",0)
	say("嘻嘻嘻……本教主是魔头，难道你身边的这位就不是了么？",27)
	say("任前辈早已回头是岸，岂能相提并论",35)
	say("本教主做事又何须在意他人说法！",27)
	say("小丫头...你想好了没有?",27)
	say("本教主可是第一次亲自邀人入我神教。",27)
	say("东方...教主..",0)
	say("嘻嘻嘻……本教主就知道你会同意的，本教主观察你好久了，总算没让本教主失望。",27)
	say("（那开始说什么早想。。。。）",0)
	say("哼！都是叛徒！",26)
	say("姑娘，你...！唉！",35)
	    else
	say("小子，你想倒戈？",26)
	say("小兄弟，东方不败作恶多端乃是人人得而诛之的魔头，你可不能误入歧途啊！！",35)
	say("。。。。。。。",0)
	say("嘻嘻嘻……本教主是魔头，难道你身边的这位就不是了么？",27)
	say("任前辈早已回头是岸，岂能相提并论",35)
	say("本教主做事又何须在意他人说法！",27)
	say("小子...你想好了没有?",27)
	say("本教主可是第一次亲自邀人入我神教。",27)
	say("东方...教主..",0)
	say("嘻嘻嘻……本教主就知道你会同意的，本教主观察你好久了，总算没让本教主失望。",27)
	say("（那开始说什么早想。。。。）",0)
	say("哼！都是叛徒！",26)
	say("小兄弟，你...！唉！",35)
	    end
	say("爹，冲哥，东方不败有了帮手，我们要小心！",73)
	say("令狐冲，待会保护好盈盈！",26)
	say("放心吧任前辈，我一定会保护好盈盈的！",35)
	say("我亲自送你们上路！",27)
	SetS(54,0,0,1, 2)
	JoinMP(27,12,5)
	JoinMP(26,12,5)
	    if WarMain(54) ==false then    --  6(6):战斗[54]是则跳转到:Label0
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
        end
	say("啊！！",26)
	say("啊！！",234,0,"向问天")
	say("啊！！",35)
	say("啊！！",73)
	instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
	instruct_3(-2,0,1,0,5000,0,0,5720,5720,5720,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [5000]
    instruct_3(-2,55,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [55]
    instruct_3(-2,95,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [95]
    instruct_3(-2,96,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [55]
    instruct_3(-2,97,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [95]
    instruct_3(-2,2,1,0,888,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [35]
    instruct_3(-2,3,1,0,888,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [34]
    instruct_3(-2,4,1,0,888,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [33]
    instruct_3(-2,5,1,0,888,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [32]
    instruct_3(-2,6,1,0,888,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [31]
    instruct_3(-2,7,1,0,888,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [30]
    instruct_3(-2,8,1,0,888,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [29]
    instruct_3(-2,9,1,0,888,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [28]
    instruct_3(-2,10,1,0,888,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
    instruct_3(-2,11,1,0,888,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [26]
    instruct_3(-2,17,1,0,888,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [25]
    instruct_3(-2,18,1,0,888,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [24]
    instruct_3(-2,19,1,0,888,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [23]
    instruct_3(-2,20,1,0,888,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [16]
    instruct_3(-2,21,1,0,888,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [15]
    instruct_3(-2,22,1,0,888,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
	instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
		do return; end
    end
	SetS(54,0,0,1, 1)
    instruct_1(3692,0,1);   --  1(1):[AAA]说: 任教主、向大哥、令狐大哥*、任大小姐，你们怎么样？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3537,26,0);   --  1(1):[任我行]说: 还好，死不了。这东方不败*已经练成葵花宝典上的武功*，你们可千万小心。
    instruct_0();   --  0(0)::空语句(清屏)
	say("任教主，我看你是老糊涂了*。你的吸星大法，加上令狐*冲的独孤九剑，都不是我的*对手，你却让这个小娃娃来*送死，嘻嘻嘻……?",27)
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3694,245,1);   --  1(1):[???]说: ＜她一笑起来好恶心……我*最讨厌断背山了！＞，你这*个不男不女的老妖怪，我来*会会你！
    instruct_0();   --  0(0)::空语句(清屏)
	if JY.Person[0]["性别"] == 1 then
	say("小丫头，本教主对你没有恶意，你也要杀我！？既如此，本教主也不会手下留情！",27)
	else
	say("小子，本教主对你没有恶意，你也要杀我！？既如此，本教主也不会手下留情！",27)
	end
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(54,4,0,0) ==false then    --  6(6):战斗[54]是则跳转到:Label0
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label0

    instruct_3(-2,0,1,0,895,0,0,5910,5910,5910,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
    instruct_3(-2,1,1,0,895,0,0,5908,5908,5908,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
    instruct_3(-2,94,1,0,896,0,0,7218,7218,7218,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [94]
    instruct_3(-2,86,0,0,0,0,0,7966,7966,7966,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [86]
    instruct_3(-2,55,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [55]
    instruct_3(-2,95,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [95]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3547,26,0);   --  1(1):[任我行]说: 东方不败，今日终於．．．*终於教你落在我手里．
    instruct_0();   --  0(0)::空语句(清屏)
	say("任教主，终究是．．是．．*终究是．．是我输了．！",27)
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3549,26,0);   --  1(1):[任我行]说: 哈！哈！*你这大号，可得改一改罢？
    instruct_0();   --  0(0)::空语句(清屏)
	say("倘若单打独斗，*你们是不能打败我的．",27)
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3551,26,0);   --  1(1):[任我行]说: 不错，你武功比我高，*我很是佩服．
    instruct_0();   --  0(0)::空语句(清屏)
	if JY.Person[0]["性别"] == 1 then
	say("你能这麽说，*足见男子汉大丈夫气概．**唉，小丫头，我对你三番五次手下留情，不想你....望你好自为之。。。",27)
	else
	say("你能这麽说，*足见男子汉大丈夫气概．**唉，小子，我对你三番五次手下留情，不想你....望你好自为之。。。",27)
	end
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3553,26,0);   --  1(1):[任我行]说: 我现在不想杀你了，*我也找个地方安养你好了．**来人啊，把他带下去．
    instruct_0();   --  0(0)::空语句(清屏)
    say("你休想！呜。。呃。。。",27)
	say("！！！",0)
	say("死了也好，便宜你了。",26)
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,86,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [86]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_2(93,1);   --  2(2):得到物品[葵花宝典][1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3555,33,0);   --  1(1):[黑白子]说: 恭喜教主，今日诛却大逆．*从此我教在教主庇荫之下，*扬威四海．*教主千秋万载，一统江湖．
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3695,26,0);   --  1(1):[任我行]说:  胡说八道！什麽千秋万载*？哈！哈！哈！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3696,35,0);   --  1(1):[令狐冲]说: ＜坐在这位子上的，是任我*行还是东方不败，却有什么*分别？＞*（盈盈，我……想离开这里*……）
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3697,73,0);   --  1(1):[任盈盈]说: （冲哥，我知道你的心思。*如今东方不败已死，我也没*有留在黑木崖上的必要，我*们一起走吧，离开这里，找*一个没有人的地方，只有你*和我……）
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3698,35,0);   --  1(1):[令狐冲]说: （好盈盈，你果然是我的知*己，我们这就悄悄走吧。）
	instruct_0();   --  0(0)::空语句(清屏)	
		if GetS(113,0,0,0) == 0 then 
			say("对了，少侠，虽然事情发展已非我本意，但仍要感谢少侠的帮助。",73)
			say("任小姐这是哪里说话，是我误会令狐兄弟在先，不过弥补而已",0)
			say("不管怎么说我们都是承了情的。这样吧，我这里有一本古曲谱，但其中似有武学至理。",73)
			say("但是却于我与冲哥无用了，就赠与少侠，如何？",73)
			instruct_0();
			if instruct_11(0,188) == true then 
				QZXS("领悟天地双响！")
				say("谢谢任小姐！",0)
				instruct_0();
				setLW1(73)
			else
				say("那我就留下来聊表纪念了！",73) 
			end	
		end
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,96,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [96]
    instruct_3(-2,97,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [97]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
	if JY.Person[0]["性别"] == 1 then
	say("小丫头，这一役诛奸复位，*你实占首功．不如加入我日*月神教，我可以给你个副教*主做做，待我百年之后，这*教主的位置就是你的，如何*？",26)
	else
	say("小兄弟，这一役诛奸复位，*你实占首功．不如加入我日*月神教，我可以给你个副教*主做做，待我百年之后，这*教主的位置就是你的，如何*？",26)
	end
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3699,0,1);   --  1(1):[AAA]说: 在下还要继续寻找十四天书*，加入神教之事万难从命。*还望任教主话复前言，告诉*我《笑傲江湖》一书的所在*。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3700,26,0);   --  1(1):[任我行]说: 哼！就算你得到了十四天书*，你也未必当的成武林盟主*。当武林盟主要靠实力的！**《笑傲江湖》一书，就在*岳不群手上。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3701,0,1);   --  1(1):[AAA]说: 哦？此话当真？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3702,26,0);   --  1(1):[任我行]说: 当然是真的！《笑傲江湖》*一书一直在华山派，当年我*日月神教曾经为了此书，血*洗华山，不幸中了五岳剑派*的诡计，十长老尽数困死在*华山思过崖。此后《笑傲江*湖》一书便不知所踪。不过*经过老夫的明查暗访，终于*得知此书根本没离开过华山*派，就在岳不群手上。所谓*“不知所终”，不过是这个*伪君子散布的谣言罢了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3703,0,1);   --  1(1):[AAA]说: 多谢了，我这就上华山！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_3(-2,35,1,0,889,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [35]
    instruct_3(-2,34,1,0,889,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [34]
    instruct_3(-2,33,1,0,889,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [33]
    instruct_3(-2,32,1,0,889,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [32]
    instruct_3(-2,31,1,0,889,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [31]
    instruct_3(-2,30,1,0,889,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [30]
    instruct_3(-2,29,1,0,889,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [29]
    instruct_3(-2,28,1,0,889,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [28]
    instruct_3(-2,27,1,0,889,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
    instruct_3(-2,26,1,0,889,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [26]
    instruct_3(-2,25,1,0,889,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [25]
    instruct_3(-2,24,1,0,889,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [24]
    instruct_3(-2,23,1,0,889,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [23]
    instruct_3(-2,16,1,0,889,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [16]
    instruct_3(-2,15,1,0,889,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [15]
    instruct_3(-2,14,1,0,889,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
    instruct_3(-2,13,1,0,889,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
    instruct_3(-2,12,1,0,889,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
    instruct_3(57,1,1,0,913,0,0,5696,5696,5696,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [1]
    instruct_3(57,0,1,0,0,0,0,5694,5694,5694,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [0]
    instruct_3(57,32,1,0,900,0,0,5180,5180,5180,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [32]
end

OEVENTLUA[895] = function()
    if MPPD(0) == 0 then
		if JY.Person[0]["性别"] == 1 then
	       say("小丫头，回心转意了吗？要*不要加入我日月神教？",26)
	    else
	       say("小兄弟，回心转意了吗？要*不要加入我日月神教？",26);
	    end
	if instruct_11(0,188) == true then
		say("还望任教主收留！",0); 
	    say("哈哈哈！好，从今天开始，你便是我神教副教主！",26); 
	    JoinMP(0,12,4)
		if GetS(111, 0, 0, 0) == 0 then
		        say("本教主高兴，现在就传你吸星大法的秘诀！",26); 
				if instruct_11(0,188) == true then
				     say("多谢任教主！",0) 
					 instruct_0();
	                 QZXS("领悟吸星大法！")
	                 instruct_0();
	                 SetS(111, 0, 0, 0,88)
				else
				     say("在下不敢贪图教主神功！",0) 
					 say("哈哈哈哈！！！",26); 
					 instruct_0()
				end	
			end	
	else
	    say("我没有这个打算！",0); 
	    say("哼，你可要想清楚了！",26); 
	end
		do return end
	end
	say("我日月神教将一统江湖！",26); 
end

OEVENTLUA[899] = function()
	say("下月十五的嵩山大会上。*岳某将尽力而为！",19);
	instruct_0();
	say("我到时一定去阻止！",0);
	if PersonKF(0,198) and GetS(114,0,0,0) == 0 then
		say("少侠如此为我派之事尽力",19);
		say("而嵩山大会又是危险无比",19);
		say("不如让岳某给予少侠一点身法上的建议？",19);
		if DrawStrBoxYesNo(-1,-1,("是否要听取建议？"),C_WHITE, 30) == true then
			QZXS("领悟身法君子风！")
			setLW2(198)
			say("多谢岳掌门！",0);
			say("下月的嵩山大会，还要拜托少侠了",19);
			say("包在我身上吧",0);
		else
			say("岳掌门好意，在下心领了！",0);
			say("请岳掌门放心，嵩山大会我依然会尽力！",0);
			say("岳某感激不尽！",19);
		end
	end
	if instruct_16(35) then
		say("是阿，师父*到时我们一定会去帮你的",35);
	else
		do return end
	end
end

OEVENTLUA[1079] = function()   
instruct_3(-2,-2,1,0,0,0,0,2606,2606,2606,-2,-2,-2)  --修改场景事件
Cls()  --清屏
TalkEx("看针！！", 27, 0)
Cls()  --清屏
TalkEx("怎么会？", 0, 0)
Cls()  --清屏
TalkEx("哇哈哈，是作者让我来的！", 27, 0)
Cls()  --清屏
TalkEx("肯定是想作者想虐主，但又找不到理由，所以就让你来了！", 0, 0)
Cls()  --清屏
TalkEx("哇哈哈，开宝箱者--打！你不开就没事了！", 27, 0)
Cls()  --清屏
TalkEx(".......来呀，打就打，谁怕谁！", 0, 0)
Cls()  --清屏
TalkEx("有种，打赢我就让你领悟葵花神针！", 27, 0)
Cls()  --清屏
TalkEx("真的？", 0, 0)
Cls()  --清屏
TalkEx("打不赢从哪来回哪去！", 27, 0)
Cls()  --清屏
TalkEx("好！打啊！", 0, 0)
Cls()  --清屏
instruct_0();
if GetS(113, 0, 0, 0) == 0 then
	SetS(106, 63, 1, 0, 0)
    SetS(106, 63, 2, 0, 27)
	if WarMain(288) == false then
	    instruct_3(-2,-2,1,0,0,0,0,2608,2608,2608,0,-2,-2)  --修改场景事件
	    instruct_13()  --场景变亮
		say("小菜一碟",27) 
	    say("........")
	else
		say("不打了，拿去",27) 
		say("嘿嘿",0)
	    QZXS("领悟葵花神针！")
	    instruct_0();
	    SetS(113, 0, 0, 0, 177)
	    addthing(377)
	end
end
instruct_2(236, 1)  --得到真武剑
Cls()  --清屏
TalkEx("这把剑给你！", 27, 0)
Cls()  --清屏
TalkEx("一把破剑不稀罕！", 0, 0)
Cls()  --清屏
TalkEx("武当真武剑都不认识，真不识货！", 27, 0)
Cls()  --清屏
TalkEx("真武剑！！！我还是要吧。", 0, 0)
Cls()  --清屏
TalkEx("呆子！", 27, 0)
Cls()  --清屏
	do return end
end    

OEVENTLUA[10013] = function() --西毒vs北丐支线
	if instruct_18(148) == false then
		do return end
	end
	if inteam(620) or hasteam(620) then
		do return end
	end
	instruct_14()
	instruct_3(-2,20,0,0,0,0,0,0,0,0,-2,-2,-2)
	instruct_3(-2,21,0,0,0,0,0,0,0,0,-2,-2,-2)
	instruct_3(-2,22,0,0,0,0,0,0,0,0,-2,-2,-2)
	instruct_3(-2,23,0,0,0,0,0,0,0,0,-2,-2,-2)
	instruct_3(-2,24,0,0,0,0,0,0,0,0,-2,-2,-2)
	instruct_3(-2,25,-2,-2,-2,-2,-2,3114*2,3114*2,3114*2,-2,-2,-2)
	instruct_3(-2,26,-2,-2,-2,-2,-2,3552*2,3552*2,3552*2,-2,-2,-2)
	instruct_13()
	instruct_0();	
	say("咦？前面的两个人是......") 
	instruct_25(27, 48, 25, 39)	
	instruct_0();	
	say("是西毒和北丐！他们好像在比拼兵器。北丐使的难道就是传说中的打狗棒法？棒法精妙，果然已臻武学绝诣。西毒回击的招数也是攻守兼备、威力凌厉。不愧为当世高人！") 
	instruct_0();	
	say("啊，他们两个好像开始比拼内力了？我该怎么做？") 		
	local path = 0
	if instruct_16(58) then
		path = 3
	elseif JY.Person[0]["品德"] >= 90 and GetS(2, 0, 0, 0) ~= 1 then
		if DrawStrBoxYesNo(-1, -1, "要帮助北丐吗？", C_WHITE, 30) == true then		
			path = 1
		else
			path = 3
		end
	elseif JY.Person[0]["品德"] <= 30 then
		if DrawStrBoxYesNo(-1, -1, "要帮助西毒吗？", C_WHITE, 30) == true then		
			path = 2
		else
			path = 3
		end	
	else
		path = 3
	end
	instruct_30(27, 48, 25, 39)	
	if path == 1 then
		instruct_0();	
		say("洪帮主，我来助你！欧阳锋看招！") 	
		instruct_0();	
		say("你是谁？？我是谁？？？欧阳锋是谁？？？？？",60,0,"欧阳锋") 	
		JY.Person[60]["攻击力"] = JY.Person[60]["攻击力"] + 100
		JY.Person[60]["防御力"] = JY.Person[60]["防御力"] + 100
		JY.Person[60]["轻功"] = JY.Person[60]["轻功"] + 150		
		if instruct_6(265,4,0,0) == false then --单挑西毒
			instruct_15(0);   
			instruct_0();  
			do return; end		
		end
		JY.Person[60]["攻击力"] = JY.Person[60]["攻击力"] - 100
		JY.Person[60]["防御力"] = JY.Person[60]["防御力"] - 100
		JY.Person[60]["轻功"] = JY.Person[60]["轻功"] - 150			
		instruct_3(-2,26,-2,-2,-2,-2,-2,0,0,0,-2,-2,-2)
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
		instruct_0();	
		say("跑得还真快。他好像掉了件东西......") 			
		instruct_0();	
		instruct_2(252, 1)
		instruct_0();	
		say("嘿，看这老毒物疯疯癫癫的，没想到却越疯约厉害。小子，老叫化从来不欠人人情。这打狗棒法本来是丐帮镇帮之宝，不过你在旁边看了这许久，以你小子的资质八成已经领悟了不少。看你品性不坏，我就把运劲诀窍也传给你吧。",69,0,"洪七公") 		
		instruct_0();	
		say("谢谢洪老前辈！") 		
		instruct_14()		
		instruct_13()
		instruct_2(167, 1)
		instruct_0();	
		say("哈哈哈！我去也！",69,0,"洪七公") 		
		instruct_14()		
		instruct_3(-2,25,-2,-2,-2,-2,-2,0,0,0,-2,-2,-2)
		instruct_13()		
	elseif path == 2 then
		instruct_37(-3)
		instruct_0();	
		say("欧阳前辈，我来助你！") 	
		JY.Person[69]["内力"] = math.modf(JY.Person[69]["内力最大值"] * 0.5)
		JY.Person[60]["内力"] = math.modf(JY.Person[60]["内力最大值"] * 0.5)
		if instruct_6(264,4,0,0) == false then 
			instruct_15(0);   
			instruct_0();  
			do return; end		
		end	
		instruct_3(-2,25,-2,-2,-2,-2,-2,0,0,0,-2,-2,-2)		
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景	
		instruct_0();
		if GetS(113,0,0,0) == 0 then
			say("哈哈哈，乖儿子，乖儿子，你很好！",60,0,"欧阳锋")
			say("（这是要认我当干儿子？）") 
			say("爸爸教你武功！，哈哈哈",60,0,"欧阳锋")
			bgtalk("欧阳锋在雪地里耍起了一套杖法，一招一式精妙绝伦。")
			if DrawStrBoxYesNo(-1, -1, "是否记下招式？", C_WHITE, 30) == true then
				QZXS("领悟灵蛇杖法绝技")
				SetS(113,0,0,0,120)
				say("哈哈哈，多谢前辈...呃...") 
				say("前辈？什么前辈？",60,0,"欧阳锋")
			end
		end	
		say("你是谁？？？我又是谁？？？",60,0,"欧阳锋") 			
		instruct_0();	
		say("（不会真疯了吧，那我帮他岂不是自找麻烦？）") 
		instruct_0();	
		say("（罢了，好事成双，我再打！）") 
		if instruct_6(265,4,0,0) == false then 
			instruct_15(0);   
			instruct_0();  
			do return; end		
		end	
		JY.Person[69]["内力"] = math.modf(JY.Person[69]["内力最大值"] * 1)
		JY.Person[60]["内力"] = math.modf(JY.Person[60]["内力最大值"] * 1)		
		instruct_3(-2,26,-2,-2,-2,-2,-2,0,0,0,-2,-2,-2)		
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景			
		instruct_2(251, 1)
		instruct_2(252, 1)
		instruct_0();
		if MPPD(0) == 8 and MPDJ(0) < 2 then
			JoinMP(0, 8, 2)
		end
		say("哈哈，终于拿到好处了！") 		
	else
		instruct_37(3)
		if instruct_16(58) then
			instruct_0();	
			say("义父和洪老前辈有危险！少侠，请帮我分开他们二人。",58,0,"杨过") 	
			instruct_0();	
			say("好！")
		else
			instruct_0();	
			say("两个人这样下去肯定会油尽灯枯，不行，我要想办法分开他们。")
		end
		JY.Person[60]["攻击力"] = JY.Person[60]["攻击力"] + 100
		JY.Person[60]["防御力"] = JY.Person[60]["防御力"] + 100
		JY.Person[60]["轻功"] = JY.Person[60]["轻功"] + 100			
		JY.Person[69]["攻击力"] = JY.Person[69]["攻击力"] + 100
		JY.Person[69]["防御力"] = JY.Person[69]["防御力"] + 100
		JY.Person[69]["轻功"] = JY.Person[69]["轻功"] + 100	
		if instruct_6(266,4,0,0) == false then --单挑西毒北丐
			instruct_15(0);   
			instruct_0();  
			do return; end		
		end	
		JY.Person[60]["攻击力"] = JY.Person[60]["攻击力"] - 100
		JY.Person[60]["防御力"] = JY.Person[60]["防御力"] - 100
		JY.Person[60]["轻功"] = JY.Person[60]["轻功"] - 100			
		JY.Person[69]["攻击力"] = JY.Person[69]["攻击力"] - 100
		JY.Person[69]["防御力"] = JY.Person[69]["防御力"] - 100
		JY.Person[69]["轻功"] = JY.Person[69]["轻功"] - 100			
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景		
		instruct_0();	
		say("哈哈！老毒物，欧阳锋！老叫化今日服了你啦。",69,0,"洪七公") 	
		instruct_0();	
		say("我是欧阳锋！我是欧阳锋！我是欧阳锋！你是老叫化洪七公！哈哈哈！",60,0,"欧阳锋") 	
		instruct_14()		
		instruct_3(-2,25,-2,-2,-2,-2,-2,0,0,0,-2,-2,-2)
		instruct_3(-2,26,-2,-2,-2,-2,-2,0,0,0,-2,-2,-2)
		instruct_13()				
		instruct_0();	
		say("唉，想这北丐西毒数十年来反覆恶斗，互不相下，岂知竟同时在华山绝顶归天。一笑泯恩仇。天意啊。")
		instruct_0();	
		instruct_2(252, 1)
		instruct_0();
		say("他们二人的绝学如果就这样失传实在可惜。待我把所领悟到的招式整理成篇，也好传承下去。")
		local word = ""
		if JY.Person[zj()]["资质"] > 50 then
			instruct_0();	
			instruct_2(167, 1)	
			if instruct_16(58) then
				JY.Person[58]["武功3"] = 80
				JY.Person[58]["武功等级3"] = 0
				word = "打狗棒法"
			end
		else
			instruct_0();	
			instruct_2(251, 1)
			if instruct_16(58) then
				JY.Person[58]["武功3"] = 120
				JY.Person[58]["武功等级3"] = 0
				word = "灵蛇杖法"
			end			
		end
		AddPersonAttrib(0, "攻击力", 10);
		AddPersonAttrib(0, "防御力", 10);
		AddPersonAttrib(0, "轻功", 10);
		instruct_0();
		QZXS(JY.Person[zj()]["姓名"].."攻防轻增加10点")			
		if instruct_16(58) then
			instruct_0();	
			say("......",58,0,"杨过") 	
			instruct_0();	
			say("杨大哥，你别太难过了，二老毕竟最后是笑着去的。")		
			instruct_0();	
			say("唉，甚么荣名，甚么威风，也不过是大梦一场罢了。",58,0,"杨过") 	
			JY.Person[58]["攻击力"] = JY.Person[58]["攻击力"] + 10
			JY.Person[58]["防御力"] = JY.Person[58]["防御力"] + 10
			JY.Person[58]["轻功"] = JY.Person[58]["轻功"] + 10	
			instruct_0();
			QZXS("杨过攻防轻增加10点，领悟"..word)	
		end
	end
end

OEVENTLUA[10014] = function() --药王庄事件
	if instruct_18(144) == false or instruct_18(145) == false or 
		instruct_16(1) == false or instruct_16(2) == false then
		do return end
	end
	instruct_3(-2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_37(2)
	local pid = 9999;				
	JY.Person[pid] = {};
	for i=1, #PSX-8 do
		JY.Person[pid][PSX[i]] = JY.Person[16][PSX[i]];
	end
	JY.Person[pid]["姓名"] = "慕容景岳";
	JY.Person[pid]["生命最大值"] = 2500
	JY.Person[pid]["生命"] = 2500
	JY.Person[pid]["内力最大值"] = 5000
	JY.Person[pid]["内力"] = 5000
	JY.Person[pid]["防御力"] = 300
	JY.Person[pid]["攻击力"] = 250
	JY.Person[pid]["轻功"] = 250
	JY.Person[pid]["拳掌功夫"] = 100
	JY.Person[pid]["武功1"] = 21
	JY.Person[pid]["武功等级1"] = 999
	JY.Person[pid]["声望"] = 90	
	pid = 10000
	JY.Person[pid] = {};
	for i=1, #PSX-8 do
		JY.Person[pid][PSX[i]] = JY.Person[17][PSX[i]];
	end
	JY.Person[pid]["姓名"] = "薛鹊";
	JY.Person[pid]["生命最大值"] = 2500
	JY.Person[pid]["生命"] = 2500
	JY.Person[pid]["内力最大值"] = 5000
	JY.Person[pid]["内力"] = 5000
	JY.Person[pid]["防御力"] = 250
	JY.Person[pid]["攻击力"] = 250
	JY.Person[pid]["拳掌功夫"] = 100
	JY.Person[pid]["轻功"] = 300
	JY.Person[pid]["武功1"] = 21
	JY.Person[pid]["武功等级1"] = 999	
	JY.Person[pid]["声望"] = 90	
	pid = 10001
	JY.Person[pid] = {};
	for i=1, #PSX-8 do
		JY.Person[pid][PSX[i]] = JY.Person[45][PSX[i]];
	end
	JY.Person[pid]["姓名"] = "石万嗔";
	JY.Person[pid]["生命最大值"] = 2800
	JY.Person[pid]["生命"] = 2800
	JY.Person[pid]["内力最大值"] = 5500
	JY.Person[pid]["内力"] = 5500
	JY.Person[pid]["防御力"] = 350
	JY.Person[pid]["攻击力"] = 350
	JY.Person[pid]["轻功"] = 250
	JY.Person[pid]["拳掌功夫"] = 150
	JY.Person[pid]["武功1"] = 21
	JY.Person[pid]["武功等级1"] = 999	
	JY.Person[pid]["声望"] = 90		
	JY.Person[pid]["攻击带毒"] = 240	
	for i = 2, HHH_GAME_SETTING["WG_COUNT_MAX"] do
		for j = 9999, 10001 do
			JY.Person[j]["武功"..i] = 0
			JY.Person[j]["武功等级"..i] = 0
		end
	end
	SetS(49, 0, 0, 0, 1)
	instruct_0();	
	say("咦，等等！大家别动！",2,0,"程灵素") 
	instruct_0();	
	say("妹子，怎么了？",1,0,"胡斐") 	
	instruct_0();	
	say("我在门口的布置被人动过....难道有人入侵....",2,0,"程灵素") 	
	instruct_14()
	instruct_3(-2, 20, 0, 0, 0, 0, 0, 5286, 5286, 5286, 0, 0, 0)
	instruct_13()
	instruct_0();	
	say("哈哈，师妹好眼力！",16,0,"慕容景岳") 	
	instruct_0();	
	say("妹子小心！",1,0,"胡斐") 	
	if instruct_6(267,4,0,0) == false then 
		instruct_15(0);   
		instruct_0();  
		do return; end		
	end		
	instruct_0();	
	SetS(49, 0, 0, 0, 2)
	instruct_3(-2, 21, 0, 0, 0, 0, 0, 6416, 6416, 6416, 0, 0, 0)
	instruct_13()	
	instruct_0();	
	say("嘿嘿，好功夫！小丫头，你就是无嗔那贼秃的小徒弟？",624)  
	instruct_0();	
	say("程师妹，见了师叔怎不快磕头？",622) 	
	instruct_0();	
	say("咱们哪里钻出师叔来啦？没听见过。",2) 	
	instruct_0();	
	say("毒手神枭的名字听过没有？你师父难道从来不敢提我吗？",624)	
	instruct_0();	
	say("这名字倒听见过的。我师父说他从前确是有过一个师弟，只是他滥用毒药害人，不守门规，早给师祖逐出门墙了。石前辈，那便是你么？",2) 	
	instruct_0();	
	say("臭丫头，敬酒不吃吃罚酒！",624)	
	if WarMain(308) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end		
	instruct_0();	
	SetS(49, 0, 0, 0, 3)
	instruct_3(-2, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_21(1)
	instruct_21(2)
	instruct_13()		
	instruct_0();	
	say("大哥，小心！",2,0,"程灵素") 	
	instruct_14()	
	instruct_3(-2, 22, 0, 0, 0, 0, 0, 5286, 5286, 5286, 0, 0, 0)
	instruct_3(-2, 23, 0, 0, 0, 0, 0, 5290, 5290, 5290, 0, 0, 0)
	instruct_3(-2, 24, 0, 0, 0, 0, 0, 6416, 6416, 6416, 0, 0, 0)
	instruct_3(-2, 25, 0, 0, 0, 0, 0, 5436, 5436, 5436, 0, 0, 0)
	instruct_3(-2, 26, 0, 0, 0, 0, 0, 5166, 5166, 5166, 0, 0, 0)
	instruct_13()	
	instruct_0();	
	say("怎么两个人都跑掉了。不行，我得跟上去看看。") 
	instruct_14()
	instruct_19(15, 28)
	instruct_13()
	instruct_0();	
	say("啊！胡大哥，程姑娘她....？") 		
	instruct_0();	
	say("二妹....她为了救我....",1) 
	instruct_0();	
	say("嘿，哭什么。很快你们就能在下面团圆了。",624)		
	instruct_0();	
	say("（胡大哥心神不宁无法出战，只能挡一下了）想动手，先过我这一关！") 
	instruct_0();	
	say("着！",624)			
	instruct_0();	
	say("啊！") 	
	AddPersonAttrib(0, "中毒程度", 100)
	local path = 0
	if WarMain(308) == false then 
		--instruct_15(0);   
		--instruct_0();  
		--do return; end	
		path = 1
	end		
	instruct_0();	
	SetS(49, 0, 0, 0, 4)
	instruct_3(-2, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_13()		
	instruct_0();	
	say("二妹！二妹！",1,0,"胡斐") 		
	instruct_0();	
	say("大哥....你累啦....快歇一歇吧....",2,0,"程灵素") 		
	instruct_0();	
	say("生死有命....你不必难过....",2,0,"程灵素") 	
	instruct_0();	
	say("以后大哥....要是找到了大嫂....要待她好....你不见她面时....天天要十七八遍....挂在心....",2,0,"程灵素") 	
	instruct_0();	
	say("二妹！",1,0,"胡斐") 
	
	if JY.Person[zj()]["医疗能力"] >= 240 and instruct_18(26) and path ~= 1 then
		instruct_32(26,-1)
		instruct_0();	
		say("（背包里还有莽牯朱蛤，罢了，死马当做活马医）胡大哥先别难过，让我来看看。") 	
		instruct_14()	
		instruct_3(-2, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		instruct_3(-2, 27, 0, 0, 0, 0, 0, 9290, 9290, 9290, 0, 0, 0)
		instruct_13()				
		instruct_0();	
		say("呼，成功了！") 		
		instruct_0();	
		say("妹子！妹子你怎么样！",1,0,"胡斐") 		
		instruct_0();	
		say("我，我好像做了一个梦....",2,0,"程灵素") 	
		instruct_0();	
		say("胡大哥，程姑娘身体刚刚恢复，先让她静养数天吧。") 	
		instruct_0();	
		say("啊，说得对，说得对。",1,0,"胡斐") 	
		instruct_14()	
		instruct_13()			
		instruct_0();	
		say("谢谢少侠救命之恩，我身体好多了。",2,0,"程灵素") 	
		if putong() == 7 and zj() == 0 then
			instruct_0();	
			say("程姑娘太客气了。只是没想到莽牯朱蛤这百毒之王，却也能起到以毒攻毒的活命作用。") 
			instruct_0();	
			say("先师深悔一生用毒太多，晚年致力研究以毒入医，医毒本源的道理。",2,0,"程灵素")			
			instruct_0();	
			say("俗话说，一草一木一石，知之而善用者为药，不知之而滥用者为毒。",2,0,"程灵素")
			instruct_0();	
			say("世人常说人参杀人无过，大黄救人无功。其实对症下药，即使大毒者如巴豆天仙子者，若用得其法，也能活人。",2,0,"程灵素")		
			instruct_0();	
			say("在下受教了。药王果然名不虚传，只可惜晚生了十年，无幸聆听大师的教诲。") 	
			instruct_0();	
			say("少侠精通医毒两道，若是先师在此，定会把少侠引为知己呢。",2,0,"程灵素")	
			instruct_0();
			QZXS(JY.Person[zj()]["姓名"].."领悟医毒同源之道")					
		end
		if GetS(113,0,0,0) == 0 then
			say("承蒙少侠之恩，在下也当涌泉以报。",1,0,"胡斐") 
			say("我家刀法在我与少侠行走江湖的这些时日，我大有改进。",1,0,"胡斐") 
			say("如今就拿出来与少侠共同参研如何？。",1,0,"胡斐") 
			instruct_0();
			if instruct_11(0,188) == true then 
	        QZXS("领悟胡刀精义！")
			say("多谢胡大哥！",0)
	        instruct_0();
	        setLW1(67)
			else
			say("也好，大家各有各的武学路要走！",1,0,"胡斐") 
			end	
		end
		instruct_0();	
		say("耽误了小兄弟那么多天，真是心有愧疚。我们这便上路吧。",1,0,"胡斐") 	
		instruct_0();	
		say("好，两位请。") 		
		instruct_14()	
		instruct_3(-2, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		instruct_3(-2, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		instruct_10(1)
		instruct_10(2)	
		instruct_13()	
		instruct_2(253,1)	
	else
		instruct_14()	
		instruct_3(-2, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		instruct_3(104, 41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		instruct_10(1)
		instruct_13()	
		if path ~= 1 then
			Cls()
			instruct_2(253,1)
			Cls()
			addHZ(5)
		end
		instruct_0();	
		say("胡大哥，请节哀....") 		
		instruct_0();	
		say("二妹....",1,0,"胡斐") 		
		instruct_14()	
		instruct_3(-2, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		instruct_13()				
	end	
end

OEVENTLUA[20003] = function()	--李莫愁离队事件
    say("李仙子，你先回小村，有需要时，我再去找你帮忙。");
    instruct_21(161);   --  21(15):离队
    --instruct_3(70,102,1,0,20004,0,0,9292,9292,9292,-2,-2,-2); 
	setteam(161, 1)
end

--70,103 新队友传信

OEVENTLUA[20004] = function()	--李莫愁小村
		MyTalk("有需要我帮忙的地方吗？", 161);
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_9(0,29) ==true then    --  9(9):是否要求加入?否则跳转到:Label1

        if instruct_20(20,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label2
            instruct_10(161);   
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
            do return; end
        end    --:Label2

				MyTalk("你的队伍已满，我无法加入。", 161);
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label1
end


OEVENTLUA[20005] = function()
	local menu = {}
	local num = 1
	if JY.Person[0]["实战"] >= 500 and JY.Person[585]["等级"] < 30 and JY.Person[662]["等级"] == 30 then
		say("…………………………")
		say("…………………………",228,0,"小二")
		say("喂，您没事吧，连我都打？",228,0,"小二")
		CC.DYRW = 0
		CC.DYRW2 = 585
		if WarMain(341) then addHZ(107) addHZ(108) end
		JY.Person[585]["等级"] = 30
		say("…………………………")
		say("咋样，满意了吧，无敌了吧，空虚了吧？总有一天你也会像我一样，安安心心当个小二。",228,0,"小二")
		do return end
	end
	say("这是最新的服务，我们这里可以替您传信给朋友们，让他们立刻到您身边。",228,0,"小二") 	
	for i = 1, #TeamP do
		local pid = TeamP[i]
		menu[num] = {JY.Person[pid]["姓名"], nil, JY.Person[pid]["YES"], pid}
		num = num + 1
	end
	DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "要传信给哪位队友？", C_WHITE, CC.DefaultFont)
	local r2 = ShowMenu(menu,#menu,15,CC.MainSubMenuX,CC.MainSubMenuY+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);	
	if r2 <= 0 then
		do return end
	end
	local pid = menu[r2][4]
	if pid == 662 and JY.Person[662]["等级"] < 30 then --武骧金星：水镜四奇要求实战
		if T2SQ(zj()) then 
			say("您不就在这儿么，请别跟小的开玩笑了。",228,0,"小二") 	
			do return end
		end
		if JY.Person[0]["实战"] < 400 then
			say("水镜先生近日外出访友，请稍等数月吧。",228,0,"小二") 	
			do return end		
		end
		say("何事多愁频上楼，清宵冷月对影流。白雪冰河十年镜，为谁锁心独自囚。",565,0,"水镜四奇") 
		say("贵客远来，不亦说乎。未知有何见教？",565,0,"水镜四奇") 
		if DrawStrBoxYesNo(-1, -1, "是否与之过招？", C_WHITE, 30) == false then
			say("不敢打扰水镜先生，晚辈就此告退。") 
			do return end
		else
			say("晚辈久仰神州三绝大名，不自量力，特来请教。")
			say("切磋尚可，指教不敢，请。",565,0,"水镜四奇")
			CC.DYRW = 0
			CC.DYRW2 = 662
			if not WarMain(341) then
				say("多谢前辈指点。")
				say("后生可畏，好，好。",565,0,"水镜四奇")
				do return end
			else
				say("晚辈侥幸，多承前辈手下留情。")
				say("不愧是武林圣地的传人，也罢，我便随你走一遭，去见见南贤北丑两位老友吧。",565,0,"水镜四奇")
				addHZ(134)
				JY.Person[pid]["经验"] = 52000
				War_AddPersonLVUP(pid);  
				Cls()
			end
		end
	end
	if not instruct_20(20,0) then
		instruct_10(pid)
		tb(JY.Person[pid]["姓名"].."加入队伍")
		setteam(pid, 0)
	else
		say("您的队伍里没有位置了。",228,0,"小二") 	
	end
end

OEVENTLUA[20006] = function()
	say("阿青姑娘，请你先回家休息，有需要时，我再去找你帮忙。")
	instruct_21(614)
	setteam(614, 1)
end

OEVENTLUA[20007] = function()
	say("耶律兄弟，请你先回家休息，有需要时，我再去找你帮忙。")
	instruct_21(619)
	setteam(619, 1)
end

OEVENTLUA[20008] = function()
	say("杨公子，请你先回家休息，有需要时，我再去找你帮忙。")
	instruct_21(616)
	setteam(616, 1)
end

OEVENTLUA[20009] = function()
	say("欧阳前辈，请你先回家休息，有需要时，我再去找你帮忙。")
	instruct_21(620)
	setteam(620, 1)
end

OEVENTLUA[20010] = function()
	say("胡大侠，请你先回家休息，有需要时，我再去找你帮忙。")
	instruct_21(621)
	setteam(621, 1)
end

OEVENTLUA[20011] = function()
	say("苗大侠，请你先回家休息，有需要时，我再去找你帮忙。")
	instruct_21(3)
	setteam(3, 1)
end

OEVENTLUA[20012] = function()
	say("唐大小姐，请你先回家休息，有需要时，我再去找你帮忙。")
	instruct_21(93)
	setteam(93, 1)
end

OEVENTLUA[10015] = function() --神雕邪
	if instruct_18(153) and (instruct_16(58) or instruct_16(59)) then
	
	else
		do return end	
	end
	instruct_14()
	instruct_3(-2,20,0,0,0,0,0,0,0,0,0,0,0)
	instruct_3(-2,21,0,0,0,0,0,0,0,0,0,0,0)
	instruct_3(-2,22,0,0,0,0,0,0,0,0,0,0,0)
	instruct_3(-2,23,0,0,0,0,0,7172,7172,7172,0,0,0)
	instruct_3(-2,24,0,0,0,0,0,9292,9292,9292,0,0,0)
	instruct_13()
	instruct_0();	
	say("咦，前面有打斗声。快点过去看看。") 
	instruct_14()
	instruct_19(35, 28)
	instruct_13()
	instruct_0();	
	say("李道友，这情花之毒的解药配置方法，天下除我之外再无第二人知晓。",549,0,"公孙止") 	
	instruct_0();	
	say("只要你依了我，这绝情谷里面的东西，便什么都是你的了。",549,0,"公孙止") 	
	instruct_0();
	TalkEx("李莫愁心地狠毒，用情却是极专，她一生恶孽，便是因情之一字而来，听公孙止言语越来越是轻薄，心下恼火。却故意美目顾盼，巧笑嫣然。",0,2)
	instruct_0();	
	TalkEx("公孙止把持不住，正待上前....",0,2)
	instruct_0();	
	say("着！",161,0,"李莫愁") 	
	instruct_0();	
	say("啊！！好你个毒妇！！",549,0,"公孙止") 
	if instruct_16(58) then
		instruct_0();	
		say("师伯小心！",58,0,"杨过") 	
	elseif instruct_16(59) then
		instruct_0();	
		say("师姊小心！",59,0,"小龙女") 
	end
	local pid = 9999;				
	JY.Person[pid] = {};
	for i=1, #PSX-8 do
		JY.Person[pid][PSX[i]] = JY.Person[605][PSX[i]];
	end
	JY.Person[pid]["姓名"] = "公孙止";
	JY.Person[pid]["生命最大值"] = 2800
	JY.Person[pid]["生命"] = 2800
	JY.Person[pid]["内力最大值"] = 6000
	JY.Person[pid]["内力"] = 6000
	JY.Person[pid]["防御力"] = 500
	JY.Person[pid]["攻击力"] = 450
	JY.Person[pid]["轻功"] = 250
	JY.Person[pid]["特殊兵器"] = 300
	JY.Person[pid]["武功1"] = 77
	JY.Person[pid]["武功等级1"] = 999
	JY.Person[pid]["武功2"] = 97
	JY.Person[pid]["武功等级2"] = 999
	JY.Person[pid]["声望"] = 97	
	JY.Person[pid]["左右互搏"] = 1	
	JY.Person[pid]["资质"] = 20
	for i = 3, HHH_GAME_SETTING["WG_COUNT_MAX"] do
		JY.Person[pid]["武功"..i] = 0
		JY.Person[pid]["武功等级"..i] = 0
	end
	if instruct_6(268,4,0,0) == false then 
		instruct_15(0);   
		instruct_0();  
		do return; end		
	end	
    if instruct_16(627,0,190) == true then
	    say("爹，没想到您。。",627) 
		if GetS(113, 0, 0, 0) == 0 then
            say("貌似公孙止这个老贼武功很有点道道",0) 
	        say("也许公孙姑娘会知道一二，要不要问问？",0) 
			if instruct_11(0,188) == true then
				say("公孙姑娘。。",0) 
				say("我知道你要问什么",627) 
				say("罢了，没想到爹爹如此龌蹉",627) 
				say("我也把绝情谷的奥秘告诉你吧",627)
                say("也许可以对武林有所帮助，也好洗脱爹爹的罪孽",627)  					 
	            QZXS("领悟阴阳倒乱")
	            instruct_0();
	            say("多谢姑娘成全",0)
				say("无妨，我也跟着少侠一起走下去吧",627)
                setJX(627,1)
				instruct_35(627,0,77,10)	
	            setLW1(77)
			else
				say("算了，刚打败人家的爹",0) 
			end
        end	
    end	
	instruct_0();	
	instruct_3(-2,23,0,0,0,0,0,0,0,0,0,0,0)
	instruct_13()
	if instruct_16(58) then
		instruct_0();	
		say("哼，我不需要你这臭小子来救我！你那个不守门规的师父呢？",161,0,"李莫愁") 	
		instruct_0();	
		say("龙儿她....她已经去了....",58,0,"杨过") 
		instruct_0();	
		say("死了？哈哈！死得好！死了一了百了，独留你一个人在世上孤独半生。死得好啊！",161,0,"李莫愁") 
		instruct_0();	
		say("住口！龙儿为救我而死，你却是为情所困虽生犹死。我二人好歹也有几年幸福时光，你却要抱着那首雁丘词郁郁此生！",58,0,"杨过") 	
		instruct_0();	
		say("当年那个美貌温柔的好女子，如今却成了人人痛恨的赤炼魔头。师伯啊师伯，你可曾有后悔过。",58,0,"杨过") 	
		instruct_0();	
		say("你！哼！",161,0,"李莫愁") 
		instruct_14()
		instruct_3(-2,24,0,0,0,0,0,0,0,0,0,0,0)
		instruct_13()
		instruct_0();	
		say("啊，她身上的情花之毒还未解，怎么就走了。") 		
		instruct_0();	
		say("罢了，各人有各人的缘法。兄弟，我们也走吧。",58,0,"杨过") 			
	else
		instruct_0();	
		say("你怎么来了？杨过那小子呢？",161,0,"李莫愁") 	
		instruct_0();	
		say("他....他已经去了....",59,0,"小龙女") 		
		instruct_0();	
		say("死了？哈哈！死得好！死了一了百了，独留你一个人在世上孤独半生。死得好啊！",161,0,"李莫愁") 
		instruct_0();	
		say("师姊....你曾对我说过，我们做女子的，一生最有福气之事，是有个真心的郎君。",59,0,"小龙女") 	
		instruct_0();	
		say("他是为了救我而死，虽然天人两隔，但我心中....却是永远念着他的....",59,0,"小龙女") 	
		instruct_0();	
		say("....哼！",161,0,"李莫愁") 	
		instruct_14()
		instruct_3(-2,24,0,0,0,0,0,0,0,0,0,0,0)
		instruct_13()
		instruct_0();	
		say("啊，她身上的情花之毒还未解，怎么就走了。") 		
		instruct_0();	
		say("师姊性格偏激，希望不要出事才好。我们到处找找吧。",59,0,"小龙女") 	
		instruct_0();	
		say("好。") 			
	end	
	SetS(10, 20, 29, 3, 99)
	
	instruct_3(10,44,0,0,0,0,10016,0,0,0,0,0,0)
	instruct_3(10,46,0,0,0,0,10016,0,0,0,0,0,0)
	instruct_3(10,47,0,0,0,0,10016,0,0,0,0,0,0)
	setRW(104, 1)
end

OEVENTLUA[10016] = function() --神雕邪part2
	if instruct_16(63) and (instruct_16(58) or instruct_16(59)) then
	
	else
		do return end	
	end
	instruct_14()
	instruct_3(10,99,0,0,0,0,0,7174,7174,7174,0,0,0)
	instruct_3(10,44,0,0,0,0,0,0,0,0,0,0,0)
	instruct_3(10,46,0,0,0,0,0,0,0,0,0,0,0)
	instruct_3(10,47,0,0,0,0,0,0,0,0,0,0,0)
	instruct_13()
	instruct_0();	
	say("前面那个人是....李莫愁？") 	
	instruct_0();	
	say("啊啊啊！！！",161,0,"李莫愁") 
	instruct_0();
	TalkEx("李莫愁受了情花之刺，先前还仗真气护身，花毒一时不致发作。如今毒素行遍全身，真气涣散，花毒越发越猛。隐隐进入了疯魔状态。",0,2)	
	instruct_0();	
	if instruct_16(58) then
		instruct_0();	
		say("小心！",58,0,"杨过") 	
	elseif instruct_16(59) then
		instruct_0();	
		say("小心！",59,0,"小龙女") 
	end	
	JY.Person[161]["攻击力"] = JY.Person[161]["攻击力"] + 200
	JY.Person[161]["轻功"] = JY.Person[161]["轻功"] + 150
	JY.Person[161]["防御力"] = JY.Person[161]["防御力"] + 150	
	if instruct_6(269,4,0,0) == false then 
		instruct_15(0);   
		instruct_0();  
		do return; end		
	end			
	JY.Person[161]["攻击力"] = JY.Person[161]["攻击力"] - 200
	JY.Person[161]["轻功"] = JY.Person[161]["轻功"] - 150
	JY.Person[161]["防御力"] = JY.Person[161]["防御力"] - 150	
	instruct_0()
	instruct_13()
	instruct_0();
	TalkEx("李莫愁一生倨傲，从不向人示弱，但这时心中酸苦，身上剧痛。再也忍耐不住，突然间双臂一振，猛向程英手中所持长剑撞去。",0,2)	
	instruct_0();
	TalkEx("程英无日不在想替姨父全家报仇，但忽地见她向自己剑尖上撞来，出其不意，吃了一惊，自然而然的缩剑相避。",0,2)	
	instruct_0();
	TalkEx("李莫愁撞了个空，直往地上跌去。花毒发作起来，痛苦的翻滚嘶叫着，众人无不恻然。",0,2)	
	instruct_0();	
	say("少侠..请你想个法子，救救她吧。",63,0,"程英") 
	instruct_0();	
	say("（程姑娘心地善良，竟愿开口为仇人求助，我怎能袖手旁观）我记得那日为杨大哥采来的绝情草还剩下几棵....") 	
	instruct_14()
	instruct_37(2)
	instruct_13()
	instruct_0();	
	say("呃......",161,0,"李莫愁") 
	instruct_0();	
	say("行了，应该没有大碍。") 	
	instruct_0();	
	say("谁要你们救我的。",161,0,"李莫愁") 	
	instruct_0();	
	say("李仙子，这从生到死再到生的转了几圈，你还不肯放下执念吗？") 	
	instruct_0();	
	say("由爱故生忧，由爱故生怖。若离于爱者，无忧亦无怖。") 
	instruct_0();	
	say("你便如这情花，伤人亦自伤。其实恩爱也罢，不是恩爱也罢，总都是“无常难得久”。若能放下了便是海阔天空。") 	
	instruct_0();	
	say("......",161,0,"李莫愁") 	
	if instruct_16(58) then
		instruct_0();	
		say("师伯，龙儿这一去，我亦觉得两世为人。能为心爱的人郁郁一生我心甘情愿，但为一个负心人含恨终老，你认为值得吗？？",58,0,"杨过") 			
	elseif instruct_16(59) then
		instruct_0();	
		say("师姊，记得你还跟我说过，男人家变了心，你便用一千匹马也拉不回来。就算你把钢刀架在他头颈里，逼得他回到你身边，他虚情假意，跟你花言巧语的再骗你一阵，你又有什么味道？",59,0,"小龙女") 
		instruct_0();	
		say("你为他自叹自唉，他又哪里会怜惜半分了。",59,0,"小龙女") 
	end		
	instruct_0();	
	say("......罢了，你们要怎么样。",161,0,"李莫愁") 	
	instruct_0();	
	say("来小村吧，愿李仙子能从此放下一切，重新为人。") 		
	instruct_0();	
	say("......好，我这就去小村。",161,0,"李莫愁") 	
	instruct_14()
	instruct_3(10,99,0,0,0,0,0,0,0,0,0,0,0)
	--SetS(70,30,23,3,102)
	--instruct_3(70,102,1,0,20004,0,0,9292,9292,9292,-2,-2,-2); 
	setteam(161, 1)
	instruct_13()
	instruct_0();	
	say("程姑娘....") 	
	instruct_0();	
	say("少侠放心，我没事。只盼她真的可以改过自新。",63,0,"程英") 
	instruct_0();	
	say("唉，其实她也是个可怜的人....我多少可以理解她的心境....",63,0,"程英") 
	instruct_0();	
	say("啊？") 	
	instruct_0();	
	say("啊，没事，我们继续上路吧。",63,0,"程英")
	if MPPD(0) == 3 then
		instruct_0();
		if instruct_16(58) then 
			say("少侠为我夫妻二人辛苦奔忙，这里是我派武功的一些心得，请少侠收下吧。", 58)
		elseif instruct_16(59) then
			say("少侠为我夫妻二人辛苦奔忙，这里是我派武功的一些心得，请少侠收下吧。", 59)
		end
		JoinMP(0, 3, 2)
	end
	if putong() == 6 then
		instruct_0();
		TalkEx(JY.Person[zj()]["姓名"].."见她娇脸凝脂，眉黛鬓青，想象她这些年来香闺寂寞，相思难遣，不禁暗暗为她难过。",0,2)	
		instruct_0();	
		say("唉，我自以为持圣仁之道便能无敌于天下。却不知，太上忘情，最下不及情，情之所钟，正在吾辈。这情之一物，千古年来，又有几人能够参透？") 			
		QZXS(JY.Person[zj()]["姓名"].."领悟以情入圣之道！")
	end
	SetS(22, 0, 0, 0, 5)
end

OEVENTLUA[10017] = function() --神雕正
	if instruct_18(153) and instruct_16(63) and (instruct_16(78) or instruct_16(56)) then
	
	else
		do return end	
	end
	instruct_14()
	instruct_3(-2,20,0,0,0,0,0,0,0,0,0,0,0)
	instruct_3(-2,21,0,0,0,0,0,0,0,0,0,0,0)
	instruct_3(-2,22,0,0,0,0,0,0,0,0,0,0,0)
	instruct_3(-2,24,0,0,0,0,0,9292,9292,9292,0,0,0)
	instruct_13()
	instruct_0();	
	say("咦，前面突然传来一阵歌声，过去看看。") 
	instruct_14()
	instruct_19(35, 28)
	instruct_13()
	instruct_0();	
	say("问世间，情是何物，直教生死相许？天南地北双飞客，老翅几回寒暑？欢乐趣，离别苦，就中更有痴儿女。君应有语，渺万里层云，千山暮雪，只影向谁去？",161,0,"李莫愁") 	
	instruct_0();	
	say("李莫愁！陆家上上下下数十口人命，你可还记得！",63,0,"程英") 	
	instruct_0();	
	say("哼，小丫头，我不去找你，你倒找上门来了。接招！",161,0,"李莫愁") 	
	if instruct_16(56) then
		instruct_0();	
		say("师妹小心！",56,0,"黄蓉") 	
	elseif instruct_16(78) then
		instruct_0();	
		say("师妹小心！",78,0,"梅超风") 
	end
	JY.Person[161]["攻击力"] = JY.Person[161]["攻击力"] + 200
	JY.Person[161]["轻功"] = JY.Person[161]["轻功"] + 200
	JY.Person[161]["防御力"] = JY.Person[161]["防御力"] + 200	
	if instruct_6(268,4,0,0) == false then 
		instruct_15(0);   
		instruct_0();  
		do return; end		
	end		
	instruct_0();	
	instruct_13()
	instruct_0();	
	say("嘿，桃花岛门人恃众为胜，果然了得。",161,0,"李莫愁") 		
	instruct_0();	
	say("且慢。你说桃花岛武功不过如此，那就错了。我听他说过一路玉箫剑法，尽可破得你的拂尘功夫......") 	
	instruct_0();
	TalkEx(JY.Person[zj()]["姓名"].."边画边说，每一句话都入情入理，所说的功夫每一项均巧妙无比。只把李莫愁听得脸如土色。",0,2)	
	instruct_0();	
	say("罢了，罢了！",161,0,"李莫愁") 		
	instruct_14()
	instruct_3(-2,24,0,0,0,0,0,0,0,0,0,0,0)
	instruct_13()	
	local word
	if instruct_16(56) then
		instruct_0();	
		say("嘿，好口才。竟然能把李莫愁吓走，你也足以自豪了。",56,0,"黄蓉") 
		AddPersonAttrib(56, "攻击力", 10);
		AddPersonAttrib(56, "防御力", 10);
		AddPersonAttrib(56, "轻功", 10);		
		word = "黄蓉"
	elseif instruct_16(78) then
		instruct_0();	
		say("嘿，好口才。竟然能把李莫愁吓走，你也足以自豪了。",78,0,"梅超风") 
		word = "梅超风"
		AddPersonAttrib(78, "攻击力", 10);
		AddPersonAttrib(78, "防御力", 10);
		AddPersonAttrib(78, "轻功", 10);			
	end	
	instruct_0();	
	say("少侠这一番见解，真是令人豁然开窍。",63,0,"程英") 		
	instruct_0();	
	say("两位见笑了。桃花岛武学确有过人之处。假以时日，两位必能成为一代宗师。") 	
	AddPersonAttrib(63, "攻击力", 10);
	AddPersonAttrib(63, "防御力", 10);
	AddPersonAttrib(63, "轻功", 10);
	QZXS("程英和"..word.."攻防轻加10点");
	if instruct_16(56) and GetS(114,0,0,0) == 0 and PersonKF(0,193) then
		say("说到宗师境界，反倒是你更有可能吧。",56,0,"黄蓉") 
		say("我自己是没在奢求什么宗师境界了。",56,0,"黄蓉")
		say("不过要是能帮上一个未来宗师的忙",56,0,"黄蓉")
		say("感觉也挺有趣的，嘻嘻",56,0,"黄蓉")
		say("这样吧，我把我爹爹新创的轻功传给你好了？",56,0,"黄蓉") 
		if DrawStrBoxYesNo(-1,-1,"要接受吗？", C_WHITE, 30) == true then
			QZXS("领悟旋风扫叶腿法")
			setLW2(193)
			say("多谢黄姑娘！")
			say("嘿嘿，以后要是靖哥哥不在",56,0,"黄蓉")
			say("你可就要帮我打架阿！",56,0,"黄蓉")	
			say("那是当然！")
		else
			say("多谢黄姑娘美意。")
			say("但听闻黄岛主对其武功传人的待遇...")
			say("哼，不然你以为爹爹为什么叫「东邪」？",56,0,"黄蓉")	
			say("不识货的家伙，不要也罢！",56,0,"黄蓉")	
		end
	end	
	SetS(10, 20, 29, 3, 99)
	instruct_3(10,44,0,0,0,0,10018,0,0,0,0,0,0)
	instruct_3(10,46,0,0,0,0,10018,0,0,0,0,0,0)
	instruct_3(10,47,0,0,0,0,10018,0,0,0,0,0,0)
	setRW(104, 1)
end

OEVENTLUA[10018] = function() --神雕正part2
	if instruct_16(58) and instruct_16(59) then
	
	else
		do return end	
	end
	instruct_14()
	instruct_3(10,99,0,0,0,0,0,7174,7174,7174,0,0,0)
	instruct_3(10,44,0,0,0,0,0,0,0,0,0,0,0)
	instruct_3(10,46,0,0,0,0,0,0,0,0,0,0,0)
	instruct_3(10,47,0,0,0,0,0,0,0,0,0,0,0)
	instruct_13()
	instruct_0();	
	say("前面那个人是....李莫愁？") 	
	instruct_0();	
	say("师姊，你怎么在这里？",59,0,"小龙女") 
	instruct_0();	
	say("是你们？把玉女心经交出来！",161,0,"李莫愁") 
	instruct_0();	
	say("龙儿小心！",58,0,"杨过") 	
	if instruct_6(270,4,0,0) == false then 
		instruct_15(0);   
		instruct_0();  
		do return; end		
	end			
	JY.Person[161]["攻击力"] = JY.Person[161]["攻击力"] - 200
	JY.Person[161]["轻功"] = JY.Person[161]["轻功"] - 200
	JY.Person[161]["防御力"] = JY.Person[161]["防御力"] - 200	
	instruct_0()
	instruct_13()
	instruct_0();	
	say("这就是玉女心经上的武功？哼，为何师父如此偏心，只传你不传我！",161,0,"李莫愁") 	
	instruct_0();	
	say("师姊....其实这玉女心经，给了你也是无用。",59,0,"小龙女") 
	instruct_0();	
	say("为什么？",161,0,"李莫愁") 	
	instruct_0();
	TalkEx("小龙女回头看了杨过一眼，甜蜜一笑，接着从怀里掏出一本书，向李莫愁掷去。",0,2)	
	instruct_0();	
	say("〈将玉女心经急急阅毕，一脸茫然〉原来是这样....竟然是这样....『若非二人互持，时时关切，小则重病，大则丧身』",161,0,"李莫愁") 		
	instruct_0();
	TalkEx("李莫愁蓦地里伤痛难禁，遥遥望见杨过和小龙女并肩而立，一个是英俊潇洒的美少年，一个是娇柔婀娜的俏姑娘，眼睛一花，模模糊糊的竟看到是自己刻骨相思的意中人陆展元，另一个却是他的妻子何沅君。",0,2)		
	instruct_0();
	TalkEx("突然纵声而歌，音调凄婉，转头便走，霎时之间，身形已在山后隐没，只剩下余音绕梁。",0,2)
	addHZ(119)
	instruct_14()
	instruct_3(10,99,0,0,0,0,0,0,0,0,0,0,0)
	instruct_13()	
	if putong() == 6 then
		instruct_0();
		instruct_0();	
		say("唉，当年娇俏温柔的小姑娘，今日七分癫狂的赤炼魔头。叹世间情为何物。") 			
		instruct_0();	
		say("我自以为持圣仁之道便能无敌于天下。却不知，太上忘情，最下不及情，情之所钟，正在吾辈。这情之一物，千古年来，又有几人能够参透？") 			
		QZXS(JY.Person[zj()]["姓名"].."领悟以情入圣之道！")
		addHZ(103)
	end	
	instruct_0();	
	say("过儿，我们虽经这重重波折，但最后....还是能在一起了。",59,0,"小龙女") 
	instruct_0();
	TalkEx("小龙女满脸红晕，依偎在杨过怀中。杨过只是微笑着看着她，不禁把她的手握得更紧了些。",0,2)	
	instruct_0();	
	say("我二人能有今日，都是多得兄弟相助。这本书我留着也无用，就送给兄弟了。",58,0,"杨过") 	
	instruct_0();	
	say("谢谢杨大哥。") 	
	instruct_0();
	if MPPD(0) == 3 then JoinMP(0, 3, 2) end	
	instruct_2(254, 1)
	SetS(22, 0, 0, 0, 5)
end

OEVENTLUA[10019] = function() --河洛客栈小二打传闻
	if T9ZY(0) and instruct_18(255) == false and JY.GOLD >= 1888 and juexing() >= 2 then
		instruct_0()
		say("啊啊，客官您真面善。怎么好像在哪里见过您？",220,0,"神秘小二") 	
		instruct_0()
		say("啊啊啊，我想起来了。原来您就是那位七进七出耐力持久的赵爷啊。",220,0,"神秘小二") 	
		instruct_0()
		say("您能不能跟我说说陈某会怎样安排您在长坂坡出场啊？",220,0,"神秘小二") 	
		instruct_0()
		say("什么什么？您不懂我在说啥？好吧，貌似我还真的有点穿越了。",220,0,"神秘小二") 		
		instruct_0()
		say("哎呀我们回归正题吧。我家有一把家传的枪，那简直就是为赵爷您量身订造的啊。",220,0,"神秘小二") 		
		instruct_0()
		say("看在您这么英明神武的份上，只要您1888大元？成不？",220,0,"神秘小二") 		
		if DrawStrBoxYesNo(-1, -1, "要买吗？", C_WHITE, 30) == true then	
			instruct_0()
			say("赵爷您真是有眼光！",220,0,"神秘小二") 					
			instruct_2(174, -1888)
			instruct_2(255, 1)
			instruct_0()
			say("赵爷您慢走哎。",220,0,"神秘小二") 	
			instruct_0()
			say("..........") 				
		end
		do return end
	elseif GetS(113,0,0,0) == 68 and JY.GOLD >= 1888 and instruct_18(255) == false then
		say("哎呀客官，看您一身正气，站在那就像一把长枪似的",220,0,"神秘小二") 		
		instruct_0()
		say("让我想到了赵子龙七近七出的传奇了呢",220,0,"神秘小二") 		
		instruct_0()
		say("这样吧，我家有一把家传的好枪",220,0,"神秘小二") 		
		instruct_0()
		say("看在您这么英明神武的份上，只要您1888大元？成不？",220,0,"神秘小二") 		
		if DrawStrBoxYesNo(-1, -1, "要买吗？", C_WHITE, 30) == true then	
			instruct_0()
			say("您真是有眼光！",220,0,"神秘小二") 					
			instruct_2(174, -1888)
			instruct_2(255, 1)
			instruct_0()
			say("您慢走哎。",220,0,"神秘小二") 	
			instruct_0()
			say("..........") 				
		end
		do return end
	else
		--addthing(340)
	end
	instruct_0()
	local pid, eid = -1
	local number = math.random(2, 3)
	say("这里是河洛江湖传闻小站，一切皆有可能，本客栈概不负责任。",220,0,"传闻站") 	
	Cls()
	if GetS(106, 63, 20, 0) >= math.modf(6 + 5 * tianshu()) then
		say("最近暂时没有什么传闻，过段时间再来吧。",220,0,"传闻站") 	
		do return end
	end	
	local event = math.random(#CC.battlee)
	say(CC.battlee[event][4],220,0,"传闻站") 
	Cls()
	if not inteam(CC.battlee[event][2]) then
		do return end
	end
	say("咦？难道你就是传闻中的人？",220,0,"传闻站") 	
	Cls()
	if DrawStrBoxYesNo(-1, -1, "要接受吗？", C_WHITE, 30) == false then		
		say("对不起，原来我看错了。",220,0,"传闻站") 	
		do return end
	end		
	SetS(106, 63, 21, 0, CC.battlee[event][1])
	SetS(106, 63, 20, 0, GetS(106, 63, 20, 0) + 1)
	
	pid = CC.battlee[event][2]
	eid = CC.battlee[event][3]
	local tmp1 = JY.Person[eid]["攻击力"] 	
	local tmp2 = JY.Person[eid]["轻功"]
	local tmp3 = JY.Person[eid]["防御力"]	
	
	JY.Person[eid]["攻击力"] = math.modf(JY.Person[pid]["攻击力"] * 0.7) + math.random(100)
	JY.Person[eid]["轻功"] = math.modf(JY.Person[pid]["轻功"] * 0.6) + 50
	JY.Person[eid]["防御力"] = math.modf(JY.Person[pid]["防御力"] * 0.7) + math.random(100)
	
	if WarMain(364) == false then
		Cls()
		JY.Person[eid]["攻击力"] = tmp1
		JY.Person[eid]["轻功"] = tmp2
		JY.Person[eid]["防御力"] = tmp3
		light()
		say("看来你修行还不够啊....",220,0,"传闻站") 	
		for i = 1, number do
			local str = math.random(2, 7)
			str = conversion(str)
			QZXS(changeattrib(pid, str, 2))
		end
		do return end
	end
	Cls()
	JY.Person[eid]["攻击力"] = tmp1
	JY.Person[eid]["轻功"] = tmp2
	JY.Person[eid]["防御力"] = tmp3	
	light()
	for i = 1, number + 1 do
		local str = math.random(2, 7)
		str = conversion(str)
		QZXS(changeattrib(pid, str, 1))
	end	
	Cls()
	say("恭喜你顺利解决了传闻。",220,0,"传闻站") 			
end

OEVENTLUA[314] = function() --武当入门
    OEVENTLUA[31020]()
end

OEVENTLUA[600] = function() --擂鼓山
    instruct_27(3,6342,6348) --显示动画(图1,图2,图3)
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(2623,115,0); --[115苏星河]:逍遥派不肖弟子苏星河，拜*见本派新任掌门．
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(2624,49,1); --[49虚竹]:老前辈行此大礼，*可折杀小僧了．
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(2625,115,0); --[115苏星河]:师弟，你是我师父的关门弟*子，又是本派掌门．我虽是*师兄，却也要向你磕头！
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(2626,49,1); --[49虚竹]:这个．．这个．．．
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(2627,115,0); --[115苏星河]:师弟，你真是福泽深厚．我*和丁春秋想这宝石指环，想*了几十年，始终都无法到手*，你却在一个时辰之内，便*受到师父的垂青．
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(2628,49,1); -- [49虚竹]:前辈拿去便是．这只指环，*小僧半点用处也没有．
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(2629,115,0) --[115苏星河]:师弟，你受师父临死时的重*托，岂能推卸责任？**师父将指环交给你，是叫你*除灭丁春秋那厮，是不是？
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(2630,49,1); -- [49虚竹]:正是．但小僧功行浅薄，*怎能当此重任？
	instruct_0();   --  0(0)::空语句(清屏)
	if cxzj() == 49 then 
	Cls()
	say("丁春秋如今正在星宿海为恶一方,还望师弟能给师傅报仇。",115,0,"苏星河")
	Cls()
	say("师，师兄，我会帮师父和你报仇的。")	
	Cls()
	say("多谢掌门。我还有八个弟子散落各地，我准备出游一趟，把他们找回来重建逍遥派。",115,0,"苏星河")	
	Cls()
	say("那就有劳师兄了。")	
	instruct_2(105,1); --[49虚竹]得到物品[105天山六阳掌]数量[1]
	instruct_2(75,1); --[49虚竹]得到物品[75小无相功]数量[1]
	instruct_2(200,1); --[49虚竹]得到物品[200七宝指环]数量[1]	
	instruct_45(zj(),20) --[49虚竹]增加轻功20
	instruct_46(zj(),3000)--[49虚竹]增加内力3000
	instruct_47(zj(),60)--[49虚竹]增加武功60
	instruct_48(zj(),200)--[49虚竹]增加生命200
	instruct_35(zj(),0,8,0) --设置[49虚竹]武功[0]为[8天山六阳掌]经验为0
	instruct_35(zj(),1,98,0)--设置[49虚竹]武功[1]为[98小无相功]经验为0
	instruct_3(-2,1,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
	instruct_3(-2,2,1,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
	instruct_3(-2,3,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
	instruct_3(-2,0,1,0,601,0,0,6340,6340,6340,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
	instruct_3(-2,4,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
	instruct_2(247,1); --得到物品[247逍遥神仙环]1个
	instruct_0();
	instruct_34(zj(),10);
	instruct_0();
	else
	instruct_1(2631,0,1); --[0资]:苏前辈，这是怎麽回事？
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(2632,115,0) --[115苏星河]:事情是这样子的．本派乃逍*遥派，师父收了我和丁春秋*两个弟子．我师父有个规矩*，因他所学甚杂，谁要做掌*门，各种本事都要比试，不*但比武，还　得比琴棋书画*．但丁春秋於各种杂学一窍*不通，眼见掌门人无望，竟*忽施暗算将师父打落深谷，*又将我打得重伤．
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(2633,0,1); --[0资]:这人真是可恶．
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(2634,115,0) --[115苏星河]:后来师父趁机诈死，*又设下了这个棋局，*想藉此找出悟性高的人．*立他为掌门，并传他功力，*将来好除去丁春秋这恶贼．**今天，我们终於出现了能破*解此珍珑的人，师父在传完*他功力后也仙逝了．*掌门师弟，我逍遥派的门户*就靠你清理了．
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(2635,49,1); -- [49虚竹]:我是误打误撞的，并没有什*麽悟性．更何况我是少林弟*子，怎能改投别派．
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(2636,0,1); --[0资]:贤弟，这位老前辈因为要传*你毕生功力而逝去，你还忍*心拒绝人家吗．况且，那丁*春秋也是个无恶不作，罪无*可赦的恶徒呀．
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(2637,49,1); --[49虚竹]:．．．．．．．
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(2638,0,1); --[0资]:好，我看就这样了．*苏前辈，我们会去找那星宿*老怪，杀了他替你师父报仇
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(2639,115,0)--[115苏星河]:老朽谢谢这位少侠的帮忙．***掌门师弟，此去路上一切要*小心，丁春秋那老贼行事卑*鄙．．．．*对了，我有一个徒弟医术高*明，人称”阎王敌”的薛神*医，你可以去找他帮忙．*见到他时只要出示掌门信物*的”七宝指环”即可．
	instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
	instruct_3(-2,1,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
	instruct_3(-2,2,1,0,602,0,0,6522,6522,6522,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
	instruct_3(-2,3,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
	instruct_3(-2,0,1,0,601,0,0,6340,6340,6340,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
	instruct_3(-2,4,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
	instruct_41(49,105,1); --[49虚竹]得到物品[105天山六阳掌]数量[1]
	instruct_41(49,75,1); --[49虚竹]得到物品[75小无相功]数量[1]
	instruct_41(49,200,1); --[49虚竹]得到物品[200七宝指环]数量[1]
	instruct_45(49,20) --[49虚竹]增加轻功20
	instruct_46(49,3000)--[49虚竹]增加内力3000
	instruct_47(49,60)--[49虚竹]增加武功60
	instruct_48(49,200)--[49虚竹]增加生命200
	instruct_35(49,0,8,0) --设置[49虚竹]武功[0]为[8天山六阳掌]经验为0
	instruct_35(49,1,98,0)--设置[49虚竹]武功[1]为[98小无相功]经验为0
	instruct_2(247,1); --得到物品[247逍遥神仙环]1个
	instruct_0();
	instruct_34(49,10);
	instruct_0();
			do return end
	end
	instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();
	instruct_0();
end

OEVENTLUA[630] = function()
    instruct_1(2679,0,1); -- [0资]:啊，原来是这样啊……
	instruct_0();
	instruct_2(79,1); --得到物品[79八荒六合功]1个
	instruct_0();
	if GetS(111, 0, 0, 0) == 0 then
		say("咦这是？？？",0) 
		SetS(106, 63, 1, 0, 0)
        SetS(106, 63, 2, 0, 117)
		if WarMain(288) == false then
			say("真是可惜",0) 
		else
			say("原来如此",0) 
	        QZXS("领悟八荒六合！")
	        instruct_0();
	        SetS(111, 0, 0, 0,101)
		end
    end
	instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);
	if cxzj() == 49 then
	    instruct_33(zj(),101,0)--[49虚竹]学会[101八荒六合功]
	    instruct_0();
	    instruct_34(zj(),10);--[49虚竹]增加资质[10]
	    instruct_0();
	    if instruct_16(53,0,16) == true then
	      instruct_1(4384,53,0) --[53段誉]:二哥，这套武功原来是这样运行啊。
	      instruct_0();
		  instruct_1(4385,49,0) --[49虚竹]:对了，三弟，你学过北冥神功吧，那这套武功你应该很容易学会。
	      instruct_0();
		  instruct_33(53,101,0)--[53段誉]学会[101八荒六合功]
	    end 
        do return end
    end
	if instruct_16(49) then
	    instruct_33(49,101,0)--[49虚竹]学会[101八荒六合功]
	    instruct_0();
	    instruct_34(49,10);--[49虚竹]增加资质[10]
	    instruct_0();
	    if instruct_16(53,0,16) == true then
	      instruct_1(4384,53,0) --[53段誉]:二哥，这套武功原来是这样运行啊。
	      instruct_0();
		  instruct_1(4385,49,0) --[49虚竹]:对了，三弟，你学过北冥神功吧，那这套武功你应该很容易学会。
	      instruct_0();
		  instruct_33(53,101,0)--[53段誉]学会[101八荒六合功]
	    end 
        do return end
    end	
end

OEVENTLUA[598] = function()
    instruct_1(2591,49,1); --[49虚竹]:佛祖啊，我找不到回少林的*路了，请您指引我一条明路*吧。
	instruct_0(); 
	    if instruct_9(2,0) == false then 
			do return end
	    end
	instruct_0();	
	instruct_1(2592,0,1); --[0资]:小和尚，不如我送你回少林*吧。
	instruct_0();
	instruct_1(2593,49,1);--[49虚竹]:哇哇哇，佛祖显灵了……
	instruct_0();
	    if instruct_28(0,75,999,7,0) == false then 
		   instruct_1(2594,49,1); --[49虚竹]:施主眼中充满戾气，恐入魔*道，小僧知道，这一定是佛*祖对我的考验，阿弥陀佛，*小僧不能与你同行。
	       instruct_0();
			do return end
	    end
		    if instruct_20(20,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label2
			instruct_1(2595,49,1); --[49虚竹]:师傅说的没错，佛祖真是灵*验啊，阿弥陀佛。
			instruct_0();
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,15,1,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_3(-2,2,1,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_3(28,38,1,0,0,0,0,2286,2286,2286,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
			if cxzj() ~= 49 then
			instruct_10(49);
			else
			for i = 1,HHH_GAME_SETTING["WG_COUNT_MAX"] do
			JY.Person[zj()]["武功"..i] = JY.Person[49]["武功"..i]
			end
			end
                do return; end
            end
	instruct_1(2596,49,1); --[49虚竹]:阿弥陀佛，你队伍已满，我无法加入。
	instruct_0();
	instruct_1(2597,0,1); --[0资]:那你就去小村等我吧
	instruct_0();
	instruct_1(2598,49,1); --[49虚竹]:阿弥陀佛，小僧不知道去小*村的路。
	instruct_0();
end

OEVENTLUA[599] = function() --擂鼓山
    instruct_1(2600,0,1);   --  1(1):[AAA]说: 老先生，怎麽一个人坐在这*下棋，这棋一个人下的起来*吗？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2601,115,0);   --  1(1):[???]说: 小兄弟，难道你对我这"珍*珑"也有兴趣？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2602,0,1);   --  1(1):[AAA]说: "珍珑"？这盘局很难解吗？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2603,115,0);   --  1(1):[???]说: 这个珍珑棋局乃先师所设。*先师当年穷三年之心血，这*才布成，深盼当世棋道中的*知心之士，予以破解。*老朽三十年来苦加钻研，皆*未能参解得透。*精通禅理之人，自知禅宗要*旨，在於"顿悟"。穷年累*月的苦功，未必能及具有宿*根慧心之人的一见即悟。*棋道也是一般，才气横溢的*八九岁小儿，棋枰上往往能*胜一流高手。虽然老朽参研*不透，但天下才士甚众，未*必都破解不得。*先师当年留下了这个心愿，*倘若有人破解开了，完了先*师这个心愿，先师虽已不在*人世，泉下有知，也必大感*欣慰。
    instruct_0();   --  0(0)::空语句(清屏)
	
	if hasppl(49) == false and JY.Person[zj()]["资质"] >= 80 then
		OEVENTLUA[31050]()
		instruct_3(35,0,-2,-2,609,-2,-2,-2,-2,-2,-2,-2,-2)
		if PersonKF(0, 85) == false and not T1LEQ(0) then
			instruct_35(0, 0, 85, 900)
		end
		do return end
	end
	
	if hasppl(49) == false and MPPD(0) == 5 and JY.Person[zj()]["资质"] < 80 and cxzj() ~= 49 then
		OEVENTLUA[31051]()
		instruct_3(35,0,-2,-2,609,-2,-2,-2,-2,-2,-2,-2,-2)
		if PersonKF(0, 85) == false and not T1LEQ(0) then
			instruct_35(0, 0, 85, 900)
		end
		do return end
	end
	
    if instruct_16(49,11,0) ==false and cxzj() ~= 49 then    --  16(10):队伍是否有[虚竹]是则跳转到:Label0
        instruct_1(2604,0,1);   --  1(1):[AAA]说: 可惜晚辈棋力不佳，否则我*倒也想试一试。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(2605,115,0);   --  1(1):[???]说: 这棋原是极难，棋力不弱之*人，若解不开甚至有可能走*火入魔。公子不勉强自己，*也好。
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0
    if cxzj() == 49 then 
	instruct_1(2606,0,1);   --  1(1):[AAA]说: 晚辈棋力不佳，不过我玩玩*看好了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2607,115,0);   --  1(1):[???]说: 公子请。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_13();   --  13(D):重新显示场景
    instruct_1(2610,115,0);   --  1(1):[???]说: 胡闹，胡闹，你自填一气，*自己杀死一块白棋，那有这*等的下法。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2611,0,1);   --  1(1):[AAA]说: 咦！难道竟是这样？*前辈你看，白棋故意挤死了*一大块後，接下来就好下多*了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2612,115,0);   --  1(1):[???]说: 这。。这。。。*这"珍珑"竟然解了，原来*关键在於第一着的怪棋。*这局棋原本纠缠於得失胜败*之中，以至无可破解，小和*尚这一着不着意於生死，更*不着意於胜败，反而勘破了*生死，得到解脱。。。。。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2613,49,1);   --  1(1):[虚竹]说: 小僧棋艺低劣，胡乱下子，*志在救人。。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2614,247,1);   --  1(1):[???]说: 贤弟误打误撞，反而收其效*果。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2615,115,0);   --  1(1):[???]说: 神僧天赋英才，可喜可贺。*请入屋内。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
	instruct_3(-2,1,0,0,0,0,0,6486,6486,6486,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
    instruct_3(-2,2,0,0,0,0,0,6450,6450,6450,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
	JoinMP(zj(), 7, 2)
    else
    instruct_1(2606,0,1);   --  1(1):[AAA]说: 晚辈棋力不佳，不过我玩玩*看好了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2607,115,0);   --  1(1):[???]说: 公子请。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_13();   --  13(D):重新显示场景
    instruct_1(2608,244,1);   --  1(1):[???]说: 嗯。。。前去无路，後有追*兵，正也不是，邪也不是，*那可难也！。。。*＜咦，棋局上的白子黑子似*乎都化做了各派高手，东一*堆使剑，西一堆使拳，你围*住我，我围住你，互相纠缠*不清的厮杀。。。。。。。*我方白色的人马被黑色各派*高手给围住了，左冲右突，*始终杀不出重围。。。。＞**难道我天命已尽，一切枉费*心机了。我这样努力的找寻*"十四天书"，终究要化作*一场梦！*时也命也，夫复何言？*我不如死了算了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2609,49,1);   --  1(1):[虚竹]说: 不可如此！*＜大哥似乎入魔障了，怎麽*办？*有了，我解不开这棋局，但*捣乱一番，让他心神一分，*便有救了。。。。。。。＞*我来解这棋局。*嗯！就下在这里好了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2610,115,0);   --  1(1):[???]说: 胡闹，胡闹，你自填一气，*自己杀死一块白棋，那有这*等的下法。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2611,0,1);   --  1(1):[AAA]说: 咦！难道竟是这样？*前辈你看，白棋故意挤死了*一大块後，接下来就好下多*了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2612,115,0);   --  1(1):[???]说: 这。。这。。。*这"珍珑"竟然解了，原来*关键在於第一着的怪棋。*这局棋原本纠缠於得失胜败*之中，以至无可破解，小和*尚这一着不着意於生死，更*不着意於胜败，反而勘破了*生死，得到解脱。。。。。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2613,49,1);   --  1(1):[虚竹]说: 小僧棋艺低劣，胡乱下子，*志在救人。。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2614,247,1);   --  1(1):[???]说: 贤弟误打误撞，反而收其效*果。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2615,115,0);   --  1(1):[???]说: 神僧天赋英才，可喜可贺。*请入屋内。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
	instruct_3(-2,1,0,0,0,0,0,6486,6486,6486,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
    instruct_3(-2,2,0,0,0,0,0,6450,6450,6450,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
    instruct_21(49);   --  21(15):[虚竹]离队
	JoinMP(49, 7, 2)
    end
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_25(17,28,24,19);   --  25(19):场景移动17-28--24-19
    instruct_44(1,6486,6520,2,6450,6484);   --  44(2C):显示动画
    instruct_44(1,6486,6520,2,6450,6484);   --  44(2C):显示动画
    instruct_44(1,6486,6520,2,6450,6484);   --  44(2C):显示动画
    instruct_1(2616,116,0);   --  1(1):[???]说: 小和尚，你体内已没有半分*少林内力，而我七十年的逍*遥派内功也尽数传给了你，*你已经对我磕过了头，难道*就不肯叫我一声师父吗？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2617,49,1);   --  1(1):[虚竹]说: 师……师父……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2618,116,0);   --  1(1):[???]说: 好。这是我逍遥派的掌门指*环，今日传给你，你要替我*杀了我们逍遥派的大仇人，*恶贼星宿老怪丁春秋！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2619,49,1);   --  1(1):[虚竹]说: 我听说那丁……丁施主……*是个恶人，但是武功高强，*小和尚本领低微，恐怕……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2620,116,0);   --  1(1):[???]说: 你体内已有我七十年的内功*，难道还怕那丁春秋不成！*你的武功招式不行，这是我*们逍遥派的武功秘笈，你拿*去学学吧。另外，我还有两*个师妹……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2621,49,0);   --  1(1):[虚竹]说: 哦……*老前辈、老前辈，你怎么了*……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_25(24,19,17,28);   --  25(19):场景移动24-19--17-28
    instruct_14();   --  14(E):场景变黑
    instruct_17(-2,1,22,24,1532);   --  17(11):修改场景贴图:当前场景层1坐标16-18
    instruct_17(-2,1,22,23,1534);   --  17(11):修改场景贴图:当前场景层1坐标16-17
    instruct_17(-2,1,23,24,0);   --  17(11):修改场景贴图:当前场景层1坐标17-18
    instruct_17(-2,1,24,24,1536);   --  17(11):修改场景贴图:当前场景层1坐标18-18
    instruct_17(-2,1,24,23,1538);   --  17(11):修改场景贴图:当前场景层1坐标18-17
    instruct_3(-2,0,1,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
    instruct_3(-2,3,1,0,0,0,0,6342,6342,6342,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
    instruct_3(-2,2,1,0,0,0,0,6522,6522,6522,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
    instruct_3(-2,1,1,0,0,0,0,6524,6524,6524,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
	instruct_3(35,0,-2,-2,609,-2,-2,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
	if cxzj() == 49 then
	   OEVENTLUA[600]()
	         do return; end
    end   
    instruct_1(2622,0,1);   --  1(1):[AAA]说: 奇怪，怎麽进去这麽久．．*我也进去看看好了．
    instruct_0();   --  0(0)::空语句(清屏)	
end

OEVENTLUA[702] = function() --修复玄慈不给书
    instruct_1(2873,70,0);   --  1(1):[玄慈]说: 阿弥陀佛，习武之道在于循*序渐进，施主切忌操之过急*。
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_28(0,80,999,2,0) ==false then    --  28(1C):判断AAA品德80-999是则跳转到:Label0
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0

--[[
    if instruct_29(0,0,100,2,0) ==false then    --  29(1D):判断AAA武力0-100是则跳转到:Label1
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label1]]
	if JY.Person[zj()]["御剑能力"] > JY.Person[zj()]["耍刀技巧"] then
		say("少侠人品素雅，更难得的是以武行侠，老衲这里有本秘笈，就赠与少侠吧。", 70)
		instruct_2(273, 1) --得到达摩剑法
	else
		instruct_1(2887,70,0);   --  1(1):[玄慈]说: 少侠人品素雅，但武功似乎*还有所欠缺，老衲这里有本*秘笈，就赠与少侠吧。
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_2(276,1);   --  2(2):得到物品[降魔刀法][1]
	end
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2888,0,1);   --  1(1):[AAA]说: 多谢玄慈大师。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_3(-2,-2,1,0,886,-2,-2,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
end

OEVENTLUA[583] = function() --智光给慈悲或燃木
    if instruct_28(0,75,999,6,0) ==false then    --  28(1C):判断AAA品德75-999是则跳转到:Label0
		say("阿弥陀佛，施主眉间戾气太重，我这里有本刀谱，希望施主修习后能慈悲为怀。", 250, 0, "智光")
		say("多谢大师。")
		addthing(160)
		instruct_3(-2,-2,1,0,584,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
	else
		say("施主能够扶危济困，善哉善哉。这本刀谱就赠与施主，望施主能用于正途。", 250, 0, "智光")
		say("多谢大师。")
		instruct_2(137,1);   --  2(2):得到物品[慈悲刀法][1]
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_3(-2,-2,1,0,584,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
	end	
end

OEVENTLUA[693] = function() --修复南贤的剧情bug
    if instruct_50(144,145,146,147,148,0,173)== true then    --  50(32):新指令，暂时没有解释
    if instruct_50(149,150,151,152,153,0,164)==true then    --  50(32):新指令，暂时没有解释
    if instruct_50(154,155,156,157,157,0,155)==true then   --  50(32):新指令，暂时没有解释
    instruct_1(3744,255,0);   --  1(1):[???]说: 年轻人，你终于找齐了十四*天书？很好，你做的很好。*这十四本书都是经典小说，*值得你永久珍藏。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3745,0,1);   --  1(1):[AAA]说: 你曾经和我说什么武林浩劫*啊，什么天命啊，什么大事*等着我啊，闹了半天这些书*仅仅是小说？？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3746,255,0);   --  1(1):[???]说: 年轻人应该多读点书，所以*我让你去找书……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3747,245,1);   --  1(1):[???]说: 死老头，你知不知道，我为*了找这几本烂书，差点送掉*小命啊！！！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3748,255,0);   --  1(1):[???]说: 子曾经曰过，天将降大任于*斯人也，必先苦其心志，劳*其筋骨……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3749,245,1);   --  1(1):[???]说: 你不要和我掉书包了，没看*见我很气愤吗？还有什么大*任，快说！！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3750,255,0);   --  1(1):[???]说: 你知道华山论剑吗？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3751,0,1);   --  1(1):[AAA]说: 知道啊，你让我去参加华山*论剑？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3752,255,0);   --  1(1):[???]说: 现在华山论剑已经取消了…*…
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3753,0,1);   --  1(1):[AAA]说: 你知道吗？*我现在很想揍你……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3754,255,0);   --  1(1):[???]说: 年轻人就是性子急。其实华*山论剑并没有真正取消，只*是改了名字，现在叫做"奥*林匹克"大会。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3755,246,1);   --  1(1):[???]说: 这是什么烂名字啊。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_3(-2,0,0,0,0,0,0,7220,7220,7220,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3756,256,0);   --  1(1):[???]说: 你错了，这个名字很有意义*。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3757,245,1);   --  1(1):[???]说: 丑叔，不要突然冒出来吓人*！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3758,256,0);   --  1(1):[???]说: "奥"，就是深奥，象征武学*的精深；"林"，就是森林，*象征武学的博大；"匹"，就*是匹敌，象公平的规则；"*克"，就是克人克己，这才*是武学的真谛。我当初取这*个名字，是很有意义的。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3759,246,1);   --  1(1):[???]说: 闹了半天这么蹩嘴的名字是*你起的！！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3760,255,0);   --  1(1):[???]说: 我从前说过，有件大事等着*你，绝不是骗你。现在你经*过寻找十四天书的过程，已*经练就了一身非凡的武功，*现在就是参加"奥林匹克"大*会的时候了，你挑选一下伙*伴，准备好了就到华山的武*道大会场来吧。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_39(25);   --  39(27):打开场景武道大会
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_17(83,1,39,37,0);   --  17(11):修改场景贴图:场景[大功坊地窖]层1坐标27-25
    instruct_3(-2,0,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
    instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
    instruct_3(-2,4,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [4]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    do return; end

	end
	end
	end
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2841,255,0);   --  1(1):[???]说: 在江湖上行走，最重要的就*是使自己保持在正道之上*……
    instruct_0();   --  0(0)::空语句(清屏)
end

OEVENTLUA[928] = function() --比武大会+技能点
    instruct_14();   --  14(E):场景变黑
    instruct_13();   --  13(D):重新显示场景
    instruct_25(33,26,21,26);   --  25(19):场景移动33-26--21-26
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3761,255,0);   --  1(1):[???]说: 又是一年秋风送爽，又是一*日天高云淡。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3762,256,0);   --  1(1):[???]说: 我们怀着无比激动的心情，*迎来了第29届奥林匹克大会*。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3763,255,0);   --  1(1):[???]说: 本次大会的主题是——同一*个武林，同一个梦想！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3764,256,0);   --  1(1):[???]说: 首先进行的是个人赛，下面*请一号选手上场！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3765,255,0);   --  1(1):[???]说: （叫你呢，快上来！）
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3766,0,1);   --  1(1):[AAA]说: 哦？我是一号吗？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_30(31,25,25,25);   --  30(1E):主角走动31-25--25-25
    instruct_1(3767,256,0);   --  1(1):[???]说: 比赛规则是，一号选手为擂*主。任何人都可以向擂主挑*战，战胜擂主的人将成为新*的擂主，直到无人挑战为止*。每个人上台前请先通名报*姓。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3768,246,1);   --  1(1):[???]说: 这就是你的公平规则啊！！*为什么我是一号？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3769,255,0);   --  1(1):[???]说: 好，我宣布，比赛正式开始*！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3770,43,0);   --  1(1):[白万剑]说: 雪山掌门白万剑，前来领教
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(102,4,0,0) ==false then    --  6(6):战斗[102]是则跳转到:Label0
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label0

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3771,98,0);   --  1(1):[???]说: 让你尝尝我恶贯满盈段延庆*的厉害
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(103,4,0,0) ==false then    --  6(6):战斗[103]是则跳转到:Label1
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label1

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3772,150,0);   --  1(1):[???]说: 我就是一剑无血冯锡范
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(104,4,0,0) ==false then    --  6(6):战斗[104]是则跳转到:Label2
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label2

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3773,255,0);   --  1(1):[???]说: 年轻人，你已连赛三场，可*以稍微休息一下。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_12();   --  12(C):住宿休息
    instruct_1(3774,162,0);   --  1(1):[???]说: 我丁不三今日还没杀够三个*人，算你一个吧。
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(105,4,0,0) ==false then    --  6(6):战斗[105]是则跳转到:Label3
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label3

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3775,67,0);   --  1(1):[裘千仞]说: 铁掌水上飘裘千仞来也。
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(106,4,0,0) ==false then    --  6(6):战斗[106]是则跳转到:Label4
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label4

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3776,19,0);   --  1(1):[岳不群]说: 华山君子剑向你挑战。
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(107,4,0,0) ==false then    --  6(6):战斗[107]是则跳转到:Label5
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label5

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3773,255,0);   --  1(1):[???]说: 年轻人，你已连赛三场，可*以稍微休息一下。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_12();   --  12(C):住宿休息
    instruct_1(3777,189,0);   --  1(1):[???]说: 晋阳大侠萧半和前来讨教。
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(108,4,0,0) ==false then    --  6(6):战斗[108]是则跳转到:Label6
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label6

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3778,71,0);   --  1(1):[洪教主]说: 我乃神龙教主洪安通是也！
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(109,4,0,0) ==false then    --  6(6):战斗[109]是则跳转到:Label7
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label7

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3779,70,0);   --  1(1):[玄慈]说: 阿弥陀佛，少林方丈玄慈来*领教阁下高招。
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(110,4,0,0) ==false then    --  6(6):战斗[110]是则跳转到:Label8
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label8

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3773,255,0);   --  1(1):[???]说: 年轻人，你已连赛三场，可*以稍微休息一下。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_12();   --  12(C):住宿休息
    instruct_1(3780,103,0);   --  1(1):[???]说: 我乃吐蕃国师，鸠摩智！
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(111,4,0,0) ==false then    --  6(6):战斗[111]是则跳转到:Label9
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label9

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3781,26,0);   --  1(1):[任我行]说: 日月神教教主任我行驾到！
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(112,4,0,0) ==false then    --  6(6):战斗[112]是则跳转到:Label10
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label10

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3782,57,0);   --  1(1):[黄药师]说: 我乃桃花岛主，人称东邪黄*药师的便是
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(119,4,0,0) ==false then    --  6(6):战斗[119]是则跳转到:Label11
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label11

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3773,255,0);   --  1(1):[???]说: 年轻人，你已连赛三场，可*以稍微休息一下。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_12();   --  12(C):住宿休息
    instruct_1(3783,69,0);   --  1(1):[洪七公]说: 北丐洪七公！
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(113,4,0,0) ==false then    --  6(6):战斗[113]是则跳转到:Label12
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label12

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3784,62,0);   --  1(1):[金轮法王]说: 贫僧乃蒙古国师金轮法王。
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(114,4,0,0) ==false then    --  6(6):战斗[114]是则跳转到:Label13
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label13

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3785,60,0);   --  1(1):[欧阳锋]说: 我是欧阳锋，我就是西毒欧*阳锋。
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(115,4,0,0) ==false then    --  6(6):战斗[115]是则跳转到:Label14
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label14

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3773,255,0);   --  1(1):[???]说: 年轻人，你已连赛三场，可*以稍微休息一下。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_12();   --  12(C):住宿休息
    instruct_1(3786,64,0);   --  1(1):[周伯通]说: 我老顽童周伯通来陪你玩玩*。
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(116,4,0,0) ==false then    --  6(6):战斗[116]是则跳转到:Label15
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label15

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3787,129,0);   --  1(1):[???]说: 全真教主，中神通王重阳，*再次复活。
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(117,4,0,0) ==false then    --  6(6):战斗[117]是则跳转到:Label16
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label16

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3788,5,0);   --  1(1):[张三丰]说: 老朽武当掌门张三丰。
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(118,4,0,0) ==false then    --  6(6):战斗[118]是则跳转到:Label17
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label17

	tb(skpoint(150 * JY.DIFF))
	
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3789,256,0);   --  1(1):[???]说: 还挑战吗？还有人吗？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3790,255,0);   --  1(1):[???]说: 好，个人赛结束，下面进行*的是团体赛。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3791,256,0);   --  1(1):[???]说: 团体战的规则是：有仇报仇*，有冤报冤，一场定输赢，*人数无限制！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3792,246,1);   --  1(1):[???]说: 你这是什么规则啊！
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_28(0,50,999,16,0) ==false then    --  28(1C):判断AAA品德50-999是则跳转到:Label18
        instruct_1(3794,69,0);   --  1(1):[洪七公]说: 小子，你看看你都干了些什*么！武林正道绝不容你！
        instruct_0();   --  0(0)::空语句(清屏)

        if instruct_6(134,4,0,0) ==false then    --  6(6):战斗[134]是则跳转到:Label19
            instruct_15(0);   --  15(F):战斗失败，死亡
            do return; end
            instruct_0();   --  0(0)::空语句(清屏)
        end    --:Label19

        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
    end    --:Label18
	

    if instruct_28(0,50,999,0,16) ==true then    --  28(1C):判断AAA品德50-999否则跳转到:Label20
        instruct_1(3793,60,0);   --  1(1):[欧阳锋]说: 哈哈，小子，我们单打不是*你的对手，一群人来怎么样*？
        instruct_0();   --  0(0)::空语句(清屏)

        if instruct_6(133,4,0,0) ==false then    --  6(6):战斗[133]是则跳转到:Label21
            instruct_15(0);   --  15(F):战斗失败，死亡
            do return; end
            instruct_0();   --  0(0)::空语句(清屏)
        end    --:Label21

        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
    end    --:Label20

    instruct_1(3795,0,1);   --  1(1):[AAA]说: 呼～终于都解决了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3796,256,0);   --  1(1):[???]说: 好，团体赛结束。现在我宣*布，本次大会的冠军是——**这小子！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3797,0,1);   --  1(1):[AAA]说: ……怎么从头到尾都没人叫*我的名字啊……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3798,255,0);   --  1(1):[???]说: 请到这边领取冠军奖牌——*盟主神杖！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_19(11,43);   --  19(13):主角移动至B-2B
    instruct_40(0);   --  40(28):改变主角站立方向0
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
end
OEVENTLUA[996] = function()
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
    instruct_13();   --  13(D):重新显示场景
    instruct_30(32,44,32,35);   --  30(1E):主角走动32-44--32-35
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3825,266,0);   --  1(1):[???]说: 你的，狡猾狡猾的。我们的*，相互支援的，不能！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3826,245,1);   --  1(1):[???]说: 哈哈哈，大胆倭人，敢来犯*我中华。今日就让你们知道*中国人的厉害。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3827,266,0);   --  1(1):[???]说: 你的，一个人的，对手的不*是！队员的，找好！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_30(32,35,32,42);   --  30(1E):主角走动32-35--32-42
    instruct_40(2);   --  40(28):改变主角站立方向2
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3828,0,1);   --  1(1):[AAA]说: 大家都在摩拳擦掌，准备与*倭寇一决高下。我看这样吧*，每次由我来挑选队员，打*过一场的人就下去休息，下*一场战斗再从其他人中挑选*。这第一仗该选哪些人呢？
    instruct_0();   --  0(0)::空语句(清屏)
	for i = 1, CC.TeamNum do
		local pid = JY.Base["队伍" .. i]
		if pid > 0 then
			for i = 1, #TeamN do
				if pid == TeamN[i] then
					setteam(pid)
				end
			end		
			instruct_21(pid)
		end
	end	
end

--function oldevent_997()
OEVENTLUA[997] = function()
    if instruct_5(2,0) ==false then    --  5(5):是否选择战斗？是则跳转到:Label0
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0


    if instruct_6(128,4,0,0) ==false then    --  6(6):战斗[128]是则跳转到:Label1
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
    end    --:Label1

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3829,266,0);   --  1(1):[???]说: 八个牙鹿！！*我们的精兵的，还有！*再战的干活！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_26(-2,3,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
	for i = 1, CC.TeamNum do
		local pid = JY.Base["队伍" .. i]
		if pid > 0 then
			instruct_21(pid)
		end
	end	
end

OEVENTLUA[998] = function()

    if instruct_5(2,0) ==false then    --  5(5):是否选择战斗？是则跳转到:Label0
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0


    if instruct_6(129,4,0,0) ==false then    --  6(6):战斗[129]是则跳转到:Label1
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
    end    --:Label1

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3829,266,0);   --  1(1):[???]说: 八个牙鹿！！*我们的精兵的，还有！*再战的干活！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_26(-2,3,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
	for i = 1, CC.TeamNum do
		local pid = JY.Base["队伍" .. i]
		if pid > 0 then
			instruct_21(pid)
		end
	end	
end

OEVENTLUA[999] = function()
    if instruct_5(2,0) ==false then    --  5(5):是否选择战斗？是则跳转到:Label0
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0


    if instruct_6(130,4,0,0) ==false then    --  6(6):战斗[130]是则跳转到:Label1
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
    end    --:Label1

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3829,266,0);   --  1(1):[???]说: 八个牙鹿！！*我们的精兵的，还有！*再战的干活！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_26(-2,3,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
	for i = 1, CC.TeamNum do
		local pid = JY.Base["队伍" .. i]
		if pid > 0 then
			instruct_21(pid)
		end
	end	
end

OEVENTLUA[1000] = function()	--最后一战增加周目
    if instruct_5(2,0) ==false then    --  5(5):是否选择战斗？是则跳转到:Label0
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0
    if instruct_6(131,4,0,0) ==false then    --  6(6):战斗[131]是则跳转到:Label1
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
    end    --:Label1
	if JY.Thing[203][WZ6] < 1 then
		JY.Thing[203][WZ6] = 1
	end	
	if JY.TERM == JY.Thing[203][WZ6] then
		JY.Thing[203][WZ6] = limitX(JY.Thing[203][WZ6] + 1,1,60)	--周目累计
		JY.Person[GetS(103, 0, 0, 1)]["解锁"] = 1
		tb(skpoint(math.modf(500 + 300 * JY.DIFF + RW.fame * 2 + JY.Base["点数"] / 50)))
		QZXS("周目增加至"..JY.Thing[203][WZ6].."周")
	end
	saveConstant()	
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_3(-2,39,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [39]
    instruct_3(-2,38,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [38]
    instruct_3(-2,37,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [37]
    instruct_3(-2,36,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [36]
    instruct_3(-2,35,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [35]
    instruct_3(-2,34,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [34]
    instruct_3(-2,33,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [33]
    instruct_3(-2,32,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [32]
    instruct_3(-2,31,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [31]
    instruct_3(-2,30,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [30]
    instruct_3(-2,29,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [29]
    instruct_3(-2,28,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [28]
    instruct_3(-2,27,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
    instruct_3(-2,26,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [26]
    instruct_3(-2,25,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [25]
    instruct_3(-2,24,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [24]
    instruct_3(-2,23,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [23]
    instruct_3(-2,22,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [22]
    instruct_3(-2,21,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [21]
    instruct_3(-2,20,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [20]
    instruct_3(-2,19,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [19]
    instruct_3(-2,18,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [18]
    instruct_3(-2,17,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [17]
    instruct_3(-2,16,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [16]
    instruct_3(-2,15,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [15]
    instruct_3(-2,14,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
    instruct_3(-2,13,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
    instruct_3(-2,12,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
    instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [11]
    instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [10]
    instruct_3(-2,9,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [9]
    instruct_3(-2,8,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [8]
    instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [7]
    instruct_3(-2,6,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [6]
    instruct_3(-2,5,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [5]
    instruct_3(-2,4,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [4]
    instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
    instruct_19(25,20);   --  19(13):主角移动至19-14
    instruct_40(0);   --  40(28):改变主角站立方向0
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_66(23);   --  66(42):播放音乐23
    instruct_1(3830,57,0);   --  1(1):[黄药师]说: 禀盟主，东门已经攻克
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3831,70,0);   --  1(1):[玄慈]说: 阿弥陀佛，南门已经攻克
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3832,60,0);   --  1(1):[欧阳锋]说: 西门已也攻克了
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3833,5,0);   --  1(1):[张三丰]说: 北门大捷。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3834,0,1);   --  1(1):[AAA]说: 好，众位齐心协力，倭寇不*堪一击。你！还有什么话说*？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3835,266,0);   --  1(1):[???]说: 中华，伟大的！*入侵，我们永远地不敢。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3836,255,0);   --  1(1):[???]说: 你终于不辱使命，拯救了中*华武林啊。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3837,256,0);   --  1(1):[???]说: 也没有枉费我兄弟二人对你*的一番培养。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_40(2);   --  40(28):改变主角站立方向2
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3838,0,1);   --  1(1):[AAA]说: 对了，你们曾经说过，我来*自龙之国度，这龙之国度到*底在哪里呢？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3839,256,0);   --  1(1):[???]说: 看到这面镜子了吗？你在镜*子中看到的，就是龙之国度*。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3840,255,0);   --  1(1):[???]说: 回去吧，年轻人，回到真正*的龙之国度。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_30(25,20,25,19);   --  30(1E):主角走动25-20--25-19
    instruct_30(25,19,21,19);   --  30(1E):主角走动25-19--21-19
    instruct_1(3841,0,1);   --  1(1):[AAA]说: 每一位龙的传人，都应该以*国家的富强和民族的兴旺为*己任，巨龙正在苏醒，巨龙*终将腾飞！*我要走了，龙之国度正需要*我！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_62(0,0,0,0,0,0);   --  62(3E):播放进入时空机动画
end

OEVENTLUA[1099] = function() --金轮加入
    instruct_1(4530,0,0);   --  1(1):[慕容惜花]说: 金轮大师，好久不见...
    instruct_1(4531,62,0);   --  1(1):[金轮法王]说: 臭小子是你！这怎么找到这来的？
    if instruct_16(58,449,0) ==false then    --  16(10):队伍是否有[杨过]是则跳转到:Label0
        if instruct_5(431,0) ==false then    --  5(5):是否选择战斗？是则跳转到:Label1    
            instruct_1(4539,0,0);   --  1(1):[慕容惜花]说: 大师你就别管我怎么找来的，我只问你，你可是要对付郭靖？     
            instruct_1(4540,62,0);   --  1(1):[金轮法王]说: 哼哼...本座听说你把一灯杀了并与郭靖结怨，你可是也要对付郭靖？
            instruct_1(4541,0,0);   --  1(1):[慕容惜花]说: 嘿嘿，明人不说暗话，不错，我想和你一起对付郭靖。
            instruct_1(4542,62,0);   --  1(1):[金轮法王]说: 哈哈哈，好好，欢迎欢迎，还有人本座已经通知，我们等他们到齐了，就去对付郭靖。
            instruct_1(4543,55,0);   --  1(1):[郭靖]说: 他们到不了了！
            instruct_1(4544,0,0);   --  1(1):[慕容惜花]说: ！
            instruct_1(4545,62,0);   --  1(1):[金轮法王]说: ！
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,12,0,0,0,0,0,9288,9288,9288,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
            instruct_13();   --  13(D):重新显示场景
            instruct_1(4546,62,0);   --  1(1):[金轮法王]说: 郭靖！
            instruct_1(4547,55,0);   --  1(1):[郭靖]说: 金轮法王，你们的阴谋已经被我们知道了，你要等的人已经来不了了！
            instruct_1(4548,62,0);   --  1(1):[金轮法王]说: 可恶，郭靖，今天就算只有我一人，我也要干掉你！
            instruct_1(4549,0,0);   --  1(1):[慕容惜花]说: 不错，大师，只有郭靖一人，我们不用怕。
            instruct_1(4550,69,0);   --  1(1):[洪七公]说: 哈哈，可不是靖儿一人啊。
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,13,0,0,0,0,0,7104,7104,7104,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
            instruct_13();   --  13(D):重新显示场景
            instruct_1(4551,0,0);   --  1(1):[慕容惜花]说: 该死，是洪七公，黄老邪，还有...欧阳锋？！他怎么和郭靖等人在一起？
            instruct_1(4554,56,0);   --  1(1):[黄蓉]说: 锋阳欧，那就是欧阳锋，只要打赢他，你就是天下第一了。
            instruct_1(4553,60,0);   --  1(1):[欧阳锋]说: 我练了九阴神功，我才是天下第一，看我打败他，欧阳锋受死！
            instruct_1(4555,0,0);   --  1(1):[慕容惜花]说: ！大师小心，欧阳锋已经疯了，但是更厉害了！
            instruct_1(4556,69,0);   --  1(1):[洪七公]说: 哼，小子，就是你杀了一灯大师？你恶贯满盈，今天我就代表正义消灭你们！
            if instruct_6(253,4,0,0) ==false then    --  6(6):战斗[253]是则跳转到:Label2
                instruct_15(0);   --  15(F):战斗失败，死亡
                do return; end
            end    --:Label2
            instruct_13();   --  13(D):重新显示场景
			addHZ(105)
			addHZ(106)
            instruct_2(77,1);   --  2(2):得到物品[金蜈钩][1]
            instruct_1(4557,69,0);   --  1(1):[洪七公]说: 对手厉害，大家快走。
            instruct_1(4558,60,0);   --  1(1):[欧阳锋]说: 我不是欧阳锋，我是...我是谁啊？？
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,12,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
            instruct_3(-2,13,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
            instruct_13();   --  13(D):重新显示场景
            instruct_1(4559,0,0);   --  1(1):[慕容惜花]说: 大师，你还好吧？
            instruct_1(4560,62,0);   --  1(1):[金轮法王]说: ...不行了，我受伤严重，看来是不行了...
            if instruct_18(8,0,156) ==true then    --  18(12):是否有物品[雪参玉蟾丸]否则跳转到:Label3
                instruct_1(4562,0,2);   --  1(1):[慕容惜花]说: <是否给金轮服用天王保命丹？>
                if instruct_11(0,147) ==true then    --  11(B):是否住宿否则跳转到:Label4
                    instruct_1(4566,0,0);   --  1(1):[慕容惜花]说: 大师挺住，这是天王保命丹，快吃！
                    instruct_2(8,-1);   --  2(2):得到物品[雪参玉蟾丸][-1]
                    instruct_14();   --  14(E):场景变黑
                    instruct_13();   --  13(D):重新显示场景
                    instruct_1(4567,0,0);   --  1(1):[慕容惜花]说: ...可恶，不够...
                    if instruct_18(8,0,126) ==true then    --  18(12):是否有物品[雪参玉蟾丸]否则跳转到:Label5
                        instruct_1(4562,0,2);   --  1(1):[慕容惜花]说: <是否给金轮服用天王保命丹？>
                        if instruct_11(0,114) ==true then    --  11(B):是否住宿否则跳转到:Label6
                            instruct_1(4566,0,0);   --  1(1):[慕容惜花]说: 大师挺住，这是天王保命丹，快吃！
                            instruct_2(8,-1);   --  2(2):得到物品[雪参玉蟾丸][-1]
                            instruct_14();   --  14(E):场景变黑
                            instruct_13();   --  13(D):重新显示场景
                            instruct_1(4567,0,0);   --  1(1):[慕容惜花]说: ...可恶，不够...
                            if instruct_18(8,0,93) ==true then    --  18(12):是否有物品[雪参玉蟾丸]否则跳转到:Label7
                                instruct_1(4562,0,2);   --  1(1):[慕容惜花]说: <是否给金轮服用天王保命丹？>
                                if instruct_11(0,81) ==true then    --  11(B):是否住宿否则跳转到:Label8
                                    instruct_1(4566,0,0);   --  1(1):[慕容惜花]说: 大师挺住，这是天王保命丹，快吃！
                                    instruct_2(8,-1);   --  2(2):得到物品[雪参玉蟾丸][-1]
                                    instruct_14();   --  14(E):场景变黑
                                    instruct_13();   --  13(D):重新显示场景
                                    instruct_1(4569,62,0);   --  1(1):[金轮法王]说: 咳咳，多谢少侠救命之恩...
                                    instruct_1(4570,0,0);   --  1(1):[慕容惜花]说: <金轮一身好功夫，不如让他来帮我>大师身上的伤还很重，不如跟我回小村好好休养再作打算？
                                    instruct_1(4571,62,0);   --  1(1):[金轮法王]说: ...<我一身重伤，也回不了蒙古，不如就在他那里好好休养...>那本座就打扰了。
                                    instruct_1(4572,62,0);   --  1(1):[金轮法王]说: 本座就先回小村了。
                                    instruct_14();   --  14(E):场景变黑
                                    instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
                                    instruct_3(70,68,1,0,1091,0,0,8010,8010,8010,-2,-2,-2);   --  3(3):修改事件定义:场景[燕子坞]:场景事件编号 [68]
                                    instruct_3(104,83,1,0,1093,0,0,8010,8010,8010,-2,-2,-2);   --  3(3):修改事件定义:场景[襄阳城]:场景事件编号 [83]
                                    instruct_13();   --  13(D):重新显示场景
                                    instruct_2(81,1);   --  2(2):得到物品[金蛇剑][1]
									do return end
                                end    --:Label8
                                instruct_1(4568,0,0);   --  1(1):[慕容惜花]说: <算了，还是留着自己用>
                            end    --:Label7
                        end    --:Label6
                        instruct_1(4568,0,0);   --  1(1):[慕容惜花]说: <算了，还是留着自己用>
                    end    --:Label5
                end    --:Label4
            end    --:Label3
            instruct_1(4561,62,0);   --  1(1):[金轮法王]说: 可恶，只差一点...就能.....<咽气>  
            instruct_1(4563,0,0);   --  1(1):[慕容惜花]说: ！大师...哎，竟然死都不倒下，虽然鄙视他的人品，还是把他葬了吧。
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
            instruct_3(-2,1,1,0,0,0,0,6700,6700,6700,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
            instruct_3(-2,3,1,0,0,0,0,6696,6696,6696,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
            instruct_13();   --  13(D):重新显示场景
            instruct_1(4564,0,0);   --  1(1):[慕容惜花]说: 这些就是金轮法王的遗物了，反正也没人要，我就拿走了。
            instruct_2(13,10);   --  2(2):得到物品[九转熊蛇丸][10]
            instruct_2(170,1);   --  2(2):得到物品[大金刚拳秘要][1]
            instruct_2(27,2);   --  2(2):得到物品[冰蚕][2]       
            instruct_2(6,5);   --  2(2):得到物品[白云熊胆丸][5]      
            instruct_2(17,2);   --  2(2):得到物品[天山雪莲][2]      
            instruct_1(4565,0,0);   --  1(1):[慕容惜花]说: 好多药，可惜都无法救他。
			do return end
        end    --:Label1
        instruct_1(4535,0,0);   --  1(1):[慕容惜花]说: 金轮法王，你们元蒙想入侵中原，我们会阻止你们的！   
        instruct_1(4536,62,0);   --  1(1):[金轮法王]说: 那要看你没有没有这个本事了。  
        instruct_1(4537,0,0);   --  1(1):[慕容惜花]说: 哼，你们的阴谋我必阻止，不过你今天的对手可不是我！
    end    --:Label0
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,12,0,0,0,0,0,6186,6186,6186,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
    instruct_13();   --  13(D):重新显示场景
    instruct_1(4538,0,0);   --  1(1):[慕容惜花]说: 杨大哥...
    instruct_1(4532,58,0);   --  1(1):[杨过]说: 金轮法王，纳命来
    if instruct_6(252,4,0,0) ==false then    --  6(6):战斗[252]是则跳转到:Label9
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
    end    --:Label9
	if not checkpic(3, 21, 1) or not inteam(92) then
		instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2)
	end    
	if checkpic(3, 21, 1) and inteam(92) then
		say("等一下，杨大哥，请看在我的份上放过他吧....", 92)
		say("襄儿妹子？", 58)
		say("他虽然不是好人，可是我毕竟喊过他一声师父....他对我也是关怀备至，嘘寒问暖....", 92)
		say("他现在武功尽失，已经受到报应了....", 92)
		say("好吧，反正杀了他龙儿也无法复生....既然小妹子你这样要求，那就让他走吧....", 58)
		say("谢谢杨大哥！大和尚....师父....你回蒙古去吧。我知道以你的佛法精深，就算失去了武功，也能振兴密宗的....", 92)
		say("唉，罢了....小徒弟，我大弟子早逝，二弟子悟性有限，三弟子却天性凉薄。如今我把衣钵正式传给你，水能载舟亦能覆舟，你好自为之吧。", 62)	
	    if GetS(111, 0, 0, 0) == 0 and PersonKF(zj(),103) then
	        say("小子...你...也跟着学一学吧...",62) 
	        instruct_0();
			if instruct_11(0,188) == true then
	            QZXS("领悟龙象之力！")
	            instruct_0();
	            say("多谢..金轮大师。",0) 
	            SetS(111, 0, 0, 0,103)
			else
				say("我还是算了吧",0) 
			end
		elseif MPPD(zj())==6 and MPPD(zj())<3 and GetS(111, 0, 0, 0) == 0 then
		    say("小子...看你做派，是血刀门的弟子吧...",62)
			say("是的..大师。",0)
			say("只可惜，步入邪道，终究不是长久之计...",62)
			say("还好，终究沉湎不深，我密宗门下也人才凋零...也罢...",62)
			say("我也把我密宗的秘传，交给你吧...",62)
			instruct_0();
			if instruct_11(0,188) == true then
	            QZXS("领悟龙象之力！")
	            instruct_0();
	            say("多谢..金轮大师。",0) 
				say("襄儿，还请你多照顾照顾...",62)
	            SetS(111, 0, 0, 0,103)
				JoinMP(zj(),6,3)
			else
				say("我还是算了吧",0)
                say("也罢，一切随缘...",62)					 
			end
	else
            say("小子...你...要不加入密宗吧...",62)		   
		    if DrawStrBoxYesNo(-1, -1, "我要不加入密宗吧？", C_WHITE, 30) == true then 
	            JoinMP(0, 6, 3)
		        say("多谢..金轮大师。",0)
		        say("不错，小子，你与佛法有缘...",62)
		    else
		        say("我还是算了吧",0)
		    end
        end
		say("师父....", 92)
		say("你也叫了我一声师父，可否执掌密宗金轮寺", 62)
        if DrawStrBoxYesNo(-1, -1, "郭襄要执掌金轮寺么？", C_WHITE, 30) == true then 
	        say("弟子愿意",92)
	        say("本座再也没有遗憾了",62)
	        JoinMP(92, 6, 3)
	    else		
	        say("对不起，师父",92)
		    say("唉，罢了罢了",62)
	    end
		if GetS(113, 0, 0, 0) == 0 then
            say("小子，我手上还有一本青海派的绝学残本，可惜本人不研习刀术...",62) 
	        say("当年灵智上人资质有限，也没有领悟到上层精要",62)
	        say("我看你资质倒也过得去，传给你，倒也不负青海派的嘱托",62) 
	        say("给他们留一点衣钵，你看如何",62) 		   
			if instruct_11(0,188) == true then
                say("多谢法王",0) 					 
	            QZXS("领悟真空大手印！")
	            instruct_0();
	            say("如此本座可以安心去了",62) 
	            setLW1(155)
			else
				say("法王客气了，小子受之有愧",0) 
                say("也罢，一切随缘...",62)	
			end
        end	
		if GetS(111,0,0,0) == 0 then
		    say("小徒弟，这密宗不传之秘希望你拿去后能发扬光大。",62) 
		    say("师傅！！！！",92)  
			say("小子，你也算有些慧根，就和小徒弟一起研修吧。",62) 
			say("这..........好吧",0) 
	        QZXS("领悟瑜伽密乘！")
	        instruct_0();
	        SetS(111, 0, 0, 0, 184)
			addthing(345)
	    end	
		dark()
		instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2)
		light()
		instruct_2(81,1);  
		instruct_2(170,1);  	
		if PersonKF(92, 103) and PersonKF(92, 184) == false then
			JY.Person[92]["武功等级2"] = 0
			JY.Person[92]["武功2"] = 103
			JY.Person[92]["武功等级3"] = 0
			JY.Person[92]["武功3"] = 184
			JY.Person[578]["防御力"] = 103
			tb("郭襄习得龙象般若功，内力硬上限加一千！")
		else
			AddPersonAttrib(92, "攻击力", 20)
			tb("郭襄攻击力上升二十点，内力硬上限加一千！")
		end			
		setJX(92)	
		say("小兄弟，我们也走吧....", 58)
		instruct_14();   --  14(E):场景变黑
		instruct_3(80,12,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[朝阳峰]:场景事件编号 [12]
		instruct_13();   --  13(D):重新显示场景			
		AddPersonAttrib(58, "攻击力", 10)	
		AddPersonAttrib(58, "防御力", 10)	
		AddPersonAttrib(58, "轻功", 10)	
		tb("杨过攻防轻各上升十点！")		
	else	
		instruct_37(10);   --  37(25):增加道德10
		instruct_2(81,1);   --  2(2):得到物品[金蛇剑][1]
		instruct_2(170,1);   --  2(2):得到物品[大金刚拳秘要][1]
		instruct_1(4533,58,0);   --  1(1):[杨过]说: 小兄弟，谢谢，我终于报仇了...
		instruct_1(4534,0,0);   --  1(1):[慕容惜花]说: 没什么，这是我应该做的...
		instruct_14();   --  14(E):场景变黑
		instruct_3(80,12,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[朝阳峰]:场景事件编号 [12]
		instruct_13();   --  13(D):重新显示场景		
		AddPersonAttrib(58, "攻击力", 10)	
		AddPersonAttrib(58, "防御力", 10)	
		AddPersonAttrib(58, "轻功", 10)	
		tb("杨过攻防轻各上升十点！")
	end
end
OEVENTLUA[589] = function() --金轮支线开启
    if instruct_60(-2,25,2286,0,590) ==true then    --  60(3C):判断场景-2事件位置25是否有贴图2286否则跳转到:Label0
        instruct_1(2561,207,0);   --  1(1):[丐帮弟子]说: 嘿嘿，我叫何师我。
        instruct_1(2562,0,1);   --  1(1):[慕容惜花]说: 咦，你手上拿的是什么？
        instruct_1(2563,207,0);   --  1(1):[丐帮弟子]说: 这个，是我讨饭用的……
        instruct_1(2564,0,1);   --  1(1):[慕容惜花]说: 这，这明明是丐帮丢失的打狗棒……
        instruct_14();   --  14(E):场景变黑
        instruct_3(-2,-2,1,0,0,0,0,7138,7138,7138,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
        instruct_13();   --  13(D):重新显示场景
        instruct_1(2565,84,0);   --  1(1):[霍都]说: 哼，居然被你发现了，你待*怎样？
        if instruct_5(0,397) ==true then    --  5(5):是否选择战斗？否则跳转到:Label1
            instruct_1(2566,245,1);   --  1(1):[史小翠]说: 大胆狂徒，还不将宝物归还*丐帮！   
            instruct_1(2567,84,0);   --  1(1):[霍都]说: 小子，你找死。
            if instruct_6(201,4,0,0) ==false then    --  6(6):战斗[201]是则跳转到:Label2
                instruct_15(0);   --  15(F):战斗失败，死亡
                do return; end     
            end    --:Label2
            instruct_3(51,12,1,0,592,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[杏子林]:场景事件编号 [12]
            instruct_3(51,13,1,0,592,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[杏子林]:场景事件编号 [13]
            instruct_13();   --  13(D):重新显示场景
            if instruct_18(233,0,336) and instruct_16(58,0,309) and instruct_18(148,0,293) then    --  18(12):是否有物品[金娃娃]否则跳转到:Label3
 --  16(10):队伍是否有[杨过]否则跳转到:Label4
				instruct_1(4500,84,0);   --  1(1):[霍都]说: 少侠饶命啊！                 
				instruct_1(4501,0,0);   --  1(1):[慕容惜花]说: 哼                    
				if instruct_28(0,40,999,282,0) ==false then    --  28(1C):判断慕容惜花品德40-999是则跳转到:Label8
					instruct_1(4503,0,0);   --  1(1):[慕容惜花]说: 我有事要问你，你如果回答的让我满意，我就饶了你。                         
					instruct_1(4504,84,0);   --  1(1):[霍都]说: 少侠只要肯饶我一命，我一定知无不言... 
					instruct_1(4505,0,0);   --  1(1):[慕容惜花]说: 这封书信，是谁写的，是谁寄给裘千仞的！
					instruct_2(233,-1);   --  2(2):得到物品[金娃娃][-1]			
					instruct_1(4506,84,0);   --  1(1):[霍都]说: 啊，这是裘...这是我师傅寄给他的。			
					instruct_1(4507,0,0);   --  1(1):[慕容惜花]说: 这上面说了些什么？			
					instruct_1(4508,84,0);   --  1(1):[霍都]说: 这是我师傅邀他商量...商量杀掉郭靖的事...			
					instruct_1(4509,0,0);   --  1(1):[慕容惜花]说: 是吗...<郭靖与我也有仇，不如我也去>			
					instruct_1(4514,0,0);   --  1(1):[慕容惜花]说: 那你师傅现在在哪儿？			
					instruct_1(4512,84,0);   --  1(1):[霍都]说: 我...我不知道啊，这上面没说...			
					instruct_1(4513,0,0);   --  1(1):[慕容惜花]说: 哼，我又不是傻子，既然邀他去杀郭靖怎么可能不说地点，快说！			
					instruct_1(4515,84,0);   --  1(1):[霍都]说: 就...就在华山！
					instruct_1(4510,0,0);   --  1(1):[慕容惜花]说: 好，你现在可以滚了。			
					instruct_1(4516,84,0);   --  1(1):[霍都]说: 谢少侠，谢少侠...			
					instruct_37(-2);   --  37(25):增加道德-2
					instruct_14();   --  14(E):场景变黑
					instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号			
					instruct_13();   --  13(D):重新显示场景			
					instruct_2(49,1);   --  2(2):得到物品[四丈银鞭][1]	
					instruct_1(4518,58,0);   --  1(1):[杨过]说: 小兄弟，你可是要去华山见那金轮？		
					instruct_1(4519,0,0);   --  1(1):[慕容惜花]说: <糟了，杨大哥可是和那金轮仇深似海，这可怎么办？>		
					instruct_1(4520,0,0);   --  1(1):[慕容惜花]说: ...不错，杨大哥你可是要阻我？
					if instruct_29(0,350,999,0,74) ==true then    --  29(1D):判断慕容惜花武力350-999否则跳转到:Label9
						instruct_1(4524,58,0);   --  1(1):[杨过]说: 我要去找金轮报仇，你可要阻止我？
						instruct_1(4525,0,0);   --  1(1):[慕容惜花]说: ..杨大哥，冤冤相报...
						instruct_1(4526,58,0);   --  1(1):[杨过]说: 不要多说，来吧！
						if instruct_6(251,0,51,1) ==true then    --  6(6):战斗[251]否则跳转到:Label10			
							instruct_13();   --  13(D):重新显示场景
							instruct_1(4527,0,0);   --  1(1):[慕容惜花]说: 杨大哥，现在你能听我说了吗？				
							instruct_1(4528,58,0);   --  1(1):[杨过]说: 抱歉，我想一个人静一静，先回去了。				
							instruct_14();   --  14(E):场景变黑
							instruct_21(58);   --  21(15):[杨过]离队
							instruct_3(70,19,1,0,151,0,0,6188,6188,6188,-2,-2,-2);   --  3(3):修改事件定义:场景[燕子坞]:场景事件编号 [19]
							addpoint(80, 20, 25, 16)
							instruct_3(80,20,1,0,1099,0,0,8010,8010,8010,-2,-2,-2);   --  3(3):修改事件定义:场景[朝阳峰]:场景事件编号 [3]
							instruct_13();   --  13(D):重新显示场景				
							instruct_1(4529,0,0);   --  1(1):[慕容惜花]说: 杨大哥！...算了，让他回去静一静吧。
							do return end
						end    --:Label10			
						instruct_13();   --  13(D):重新显示场景	
					end    --:Label9
					instruct_1(4521,58,0);   --  1(1):[杨过]说: ...小兄弟，我很失望，算了，我走了...
					instruct_14();   --  14(E):场景变黑
					instruct_21(58);   --  21(15):[杨过]离队
					instruct_3(70,19,0,0,0,0,0,0,0,0,0,-2,-2);   --  3(3):修改事件定义:场景[燕子坞]:场景事件编号 [19]
					instruct_3(104,68,0,0,0,0,0,0,0,0,0,-2,-2);   --  3(3):修改事件定义:场景[襄阳城]:场景事件编号 [68]
					addpoint(80, 20, 25, 16)
					instruct_3(80,20,1,0,1099,0,0,8010,8010,8010,-2,-2,-2);   --  3(3):修改事件定义:场景[朝阳峰]:场景事件编号 [3]
					instruct_3(70,20,0,0,0,0,0,0,0,0,0,-2,-2);   --  3(3):修改事件定义:场景[燕子坞]:场景事件编号 [20]
					instruct_3(104,76,0,0,0,0,0,0,0,0,0,-2,-2);   --  3(3):修改事件定义:场景[襄阳城]:场景事件编号 [76]		
					instruct_13();   --  13(D):重新显示场景
					instruct_1(4522,0,0);   --  1(1):[慕容惜花]说: 啊，杨大哥！啊，走了...
					instruct_1(4523,0,0);   --  1(1):[慕容惜花]说: 哎，算了，我去找法王吧。
					do return end
				end   
                instruct_1(4502,0,0);   --  1(1):[慕容惜花]说: 像你这种人渣，我何必饶你！    
                instruct_14();   --  14(E):场景变黑
                instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
                instruct_13();   --  13(D):重新显示场景 
            end    --:Label3
            instruct_2(49,1);   --  2(2):得到物品[四丈银鞭][1]  
            instruct_37(1);   --  37(25):增加道德1  
            do return; end
        end    --:Label1


        if instruct_9(0,125) ==true then    --  9(9):是否要求加入?否则跳转到:Label11
            if instruct_28(0,50,999,99,0) ==false then    --  28(1C):判断慕容惜花品德50-999是则跳转到:Label12
                instruct_37(-5);   --  37(25):增加道德-5
                instruct_1(2570,84,0);   --  1(1):[霍都]说: 哈哈，原来阁下也看上了这*丐帮帮主之位。少侠在江湖*上早已英名远播，呵呵，在*下愿意跟随少侠。
                if instruct_20(39,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label13
                    instruct_14();   --  14(E):场景变黑
                    instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
                    instruct_3(51,25,0,0,0,0,594,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[杏子林]:场景事件编号 [25]           
                    instruct_13();   --  13(D):重新显示场景
                    instruct_2(49,1);   --  2(2):得到物品[四丈银鞭][1]          
                    instruct_10(84);   --  10(A):加入人物[霍都]           
                    do return; end
                end    --:Label13
                instruct_14();   --  14(E):场景变黑
                instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
                instruct_3(70,34,1,0,183,0,0,7016,7016,7016,-2,-2,-2);   --  3(3):修改事件定义:场景[燕子坞]:场景事件编号 [34]
                instruct_3(51,25,0,0,0,0,594,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[杏子林]:场景事件编号 [25] 
                instruct_13();   --  13(D):重新显示场景
                instruct_2(49,1);   --  2(2):得到物品[四丈银鞭][1]
                do return; end
            end    --:Label12
            instruct_1(2569,84,0);   --  1(1):[霍都]说: 这个，道不同不相为谋。
            instruct_3(-2,-2,1,0,590,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
            do return; end
        end    --:Label11
        instruct_1(2568,0,1);   --  1(1):[慕容惜花]说: 这事与我无关，我才懒得理*。
        instruct_3(-2,-2,1,0,590,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
        do return; end
    end    --:Label0
    instruct_1(2560,207,0);   --  1(1):[丐帮弟子]说: 嘿嘿嘿嘿……
    instruct_0();   --  0(0)::空语句(清屏)
end

OEVENTLUA[512] = function() --欧阳锋加入，需杨过
	if hasppl(58) then
		say("义父！", 58)
		say("你，你是谁？", 60)
		say("是我啊！我是过儿！", 58)
		say("过儿？过儿？啊啊，我的头好痛！", 60)	
		say("杨兄小心！")
		if WarMain(304) then
			say("你使的是蛤蟆功！", 60)
			say("是啊，是你传授给我的蛤蟆功！", 58)		
			say("过儿！儿子！你是我的儿子！", 60)
			say("杨大哥，欧阳前辈这个样子，还是把他带回小村慢慢疗养才是。")
			say("说的也是....", 58)		
			say("义父，你跟我们回小村吧，来....", 58)
			instruct_14();   --  14(E):场景变黑
			instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_13();   --  13(D):重新显示场景	
			if MPPD(0) == 0 and JY.Person[0]["品德"] <= 30 then
				say("嘿嘿嘿嘿，老毒物已经疯了，他的白驼山庄就由我接收啦。", 0)
				JoinMP(0, 8, 3)
			elseif MPPD(0) == 8 and MPDJ(0)==1 then
				say("嘿嘿嘿嘿，老毒物已经疯了，他的白驼山庄就由我接收啦。", 0)
				say("啦啦啦，蛇奴翻身做主人。", 0)
				JoinMP(0, 8, 3)
			end			
			instruct_2(82,1)
			instruct_2(251,1)
			setteam(620, 1)
		else
			instruct_1(2149,60,0);   --  1(1):[欧阳锋]说: 不对，不对，我脑子有点不*清楚，我要一个人想想……
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_14();   --  14(E):场景变黑
			instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_13();   --  13(D):重新显示场景		
			say("义父....唉....", 58)
		end
	else
		instruct_1(2142,0,1);   --  1(1):[AAA]说: ＜这不是西毒欧阳锋吗？怎*么在这倒立……＞
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(2143,60,0);   --  1(1):[欧阳锋]说: 乖儿子，快叫爸爸！
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(2144,246,1);   --  1(1):[???]说: ＜不是吧，占我便宜……＞
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(2145,60,0);   --  1(1):[欧阳锋]说: 快叫爸爸，爸爸传授高深的*武功给你！
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(2146,0,1);   --  1(1):[AAA]说: ＜高深的武功？＞
		instruct_0();   --  0(0)::空语句(清屏)

		if instruct_11(1,0) ==false then    --  11(B):是否住宿是则跳转到:Label0
			do return; end
		end    --:Label0

		instruct_37(-1);   --  37(25):增加道德-1
		instruct_1(2147,247,1);   --  1(1):[???]说: ＜你不是我的＞*爸爸！
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(2148,60,0);   --  1(1):[欧阳锋]说: 哈哈哈，乖儿子，我现在就*把九阴真经传给你
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_2(82,1);   --  2(2):得到物品[逆运真经][1]
		instruct_0();   --  0(0)::空语句(清屏)
		addHZ(157)
		if GetS(111, 0, 0, 0) == 0 then
	        say("乖儿子，我刚刚想到了一些招数，现在就传给你。",60) 
	        instruct_0();
			if instruct_11(0,188) == true then
	            QZXS("领悟逆运真经奥妙！")
	            instruct_0();
	            say("多谢爸爸（才怪）！",0) 
				instruct_0()
	            SetS(111, 0, 0, 0,104)
			else
				say("乖儿子，我刚说什么来着？？",60) 
				instruct_0()
				say("（刚才等于白说啊。。。。。）",0) 
				instruct_0()
			end	
		end	
		if GetS(111,0,0,0) ~= 104 and GetS(114,0,0,0) == 0 then
			say("乖儿子，现在跟我走吧。",60)
			say("(嘴上喊喊就算了，现在我可得溜之大吉)，那，那个，我还有事，就先...哇！",0)
			say("你的视线甫离欧阳锋一瞬，他就已出现在你面前。无论你怎么窜跳腾挪，都是如此。")
			say("嘿嘿嘿，爸爸这轻功不错吧？我教你",60)
			if instruct_11(0,188) == true then
	            QZXS("领悟瞬息千里奥妙！")
	            instruct_0();
	            say("多谢爸爸（才怪）！",0) 
				instruct_0()
	            SetS(114, 0, 0, 0,118)
				addthing(241)
			else
				say("鬼、鬼阿！！(口吐白沫，晕了)",0) 
				instruct_0()
				say("臭小子不识货，爸爸这套轻功可是鼎鼎大名的......",60) 
				instruct_0()
				say("的啥？",60) 
				instruct_0()
			end
		end	
		instruct_1(2149,60,0);   --  1(1):[欧阳锋]说: 不对，不对，我脑子有点不*清楚，我要一个人想想……
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_14();   --  14(E):场景变黑
		instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
		if (MPPD(0) == 0 or MPPD(0) == 8) and JY.Person[0]["品德"] <= 30 then
			say("嘿嘿嘿嘿，老毒物已经疯了，他的白驼山庄就由我接收啦。", 0)
			JoinMP(0, 8, 3)
		end		
	end
end


OEVENTLUA[10020] = function() --郭襄支线1
	if not inteam(92) or not GX(92) then
		do return end
	end
	dark()
	light()
	say("......", 92)
	say("襄儿，你怎么了？")
	say("大哥，你愿意陪我在这城中走走吗？", 92)
	say("（为何襄儿刚一进这屋里就变得满腹沉重....）好....")
	addevent(-2, 16, 0, 10021, 3)
	addevent(-2, 17, 0, 10021, 3)
	addevent(-2, 11, 0, 0, 0)
	addevent(-2, 12, 0, 0, 0)	
	addevent(-2, 13, 0, 0, 0)	
end

OEVENTLUA[10021] = function() --郭襄支线2
	if not inteam(92) or not GX(92) then
		do return end
	end
	dark()
	light()
	say("这襄阳城真是好地方，民风淳朴，城町兴旺，又远离纷争，和平得很呐。",200,0,"酒客") 	
	say("唉，你知道什么！这襄阳城二十年前却是经历过重重战火洗礼，几乎就要生灵涂炭。",207,0,"酒客") 	
	say("真的？这是怎么回事？",200,0,"酒客") 	
	say("你久居塞外，自然不知。这城当年曾被外族侵略，眼看就要城破家亡，幸亏当年有一郭姓大侠挺身而出，领导武林中人奋力抗争，终于打退了外族。可惜他和他的妻子却战死沙场，以身殉城，可叹可敬啊！",207,0,"酒客") 	
	say("当年那郭大侠本来可以隐居世外桃源置身事外，却偏偏把一身精力放在这守城当中，据说他的一个女儿也因此流落民间，从此再也无了音讯。他时常说，行侠仗义济人困厄自然是我辈本分，可真正的侠之大者，却要抱着忧国忧民之心才是。",207,0,"酒客") 	
	say("好汉子！不愧那一句大侠的尊称！",200,0,"酒客") 	
	say("为国为民，侠之大者！来，为这八个字干一杯！",207,0,"酒客") 
	say("干！",200,0,"酒客") 	
	say("（郭大侠？殉城？刚刚那座屋子....难道是？）")
	say("大哥....我们去那边的桥上走走吧....", 92)	
	say("啊？好....")	
	addevent(-2, 15, 0, 10022, 3)
	addevent(-2, 14, 0, 10022, 3)
	addevent(-2, 16, 0, 0, 0)
	addevent(-2, 17, 0, 0, 0)	
end

OEVENTLUA[10022] = function() --郭襄支线3
	if not inteam(92) or not GX(92) then
		do return end
	end
	dark()
	light()
	say("大哥....这里风景真好....", 92)	
	say("襄儿....")	
	say("大哥，你可知道，我的名字，就来自于这座城呢。", 92)		
	say("啊？")		
	say("这里，是我爹娘当年相遇的地方。", 92)	
	say("桃李春风一杯酒，江湖夜雨十年灯。我娘当年，常常念着这句诗。", 92)	
	say("他们本来可以做对神仙眷侣，远遁江湖，可是我爹却偏偏把家国这两个字放在嘴边，然后守襄阳守了二十年。", 92)	
	say("我在这里出生，这里长大，可是我厌倦这里的一切，所以我终于离开了这里。", 92)	
	say("那一天，我听到襄阳城难，拼了命的往这里赶，可是只来得及亲手在江边埋葬了他们。", 92)	
	say("爹....娘....女儿看你们来了....", 92)		
	say("襄儿....")	
	dark()
	light()
	say("大哥，我们走吧。", 92)		
	say("嗯....")		
	say("别担心我，前面的路还长呢，不是吗？嘻嘻。", 92)		
	addevent(-2, 15, 0, 0, 0)
	addevent(-2, 14, 0, 0, 0)	
	addevent(-2, 18, 0, 10023, 3)	
	addevent(-2, 19, 0, 10023, 3)	
end

OEVENTLUA[10023] = function() --郭襄支线4
	if not inteam(92) or not GX(92) then
		do return end
	end
	if getzx(153) > 0 then
		do return end
	end
	dark()
	addevent(-2, 20, 0, 0, 0, 4108*2)	
	light()
	say("两位请留步。", 62)
	say("大和尚，你有什么事？", 92)
	say("小姑娘可是姓郭名襄？", 62)
	say("你怎么知道我的名字？", 92)	
	say("我与郭大侠乃过命的交情，已有二十余年不见，今闻郭大侠已经逝世，老僧心痛如绞，因此兼程赶来，要到他灵前去一拜。", 62)
	say("大和尚原来是我爹的好友，那倒是失敬了。", 92)	
	say("今天见到故人之女风采盈然，实在是老僧之幸。老僧下榻之处离此不远，两位愿意赏脸一叙吗？", 62)
	say("赏脸倒是不必，赏一巴掌倒是有的。我爹生前没说过有什么古怪和尚朋友，倒是有一蒙古僧人叫什么轮子的忒是讨厌，总是和他作对。大师看上去圆墩浑厚，倒是像个轮子，不知怎么称呼啊。", 92)	
	say("小丫头，竟然敢消遣我！", 62)
	say("嘿，就知道是你！装神弄鬼，我爹怎么可能有你这样鬼祟的朋友！", 92)	
	say("找死！", 62)
	say("襄儿小心！")	
	if WarMain(302) then
		addHZ(45) 
        AddPersonAttrib(92, "拳掌功夫", 10)
        AddPersonAttrib(92, "御剑能力", 10)
        AddPersonAttrib(92, "耍刀技巧", 10)
        AddPersonAttrib(92, "特殊兵器", 10)
		AddPersonAttrib(92, "暗器技巧", 10) --武骧金星：添加暗器
		tb("郭襄兵器值提升十点！")
	else --武骧金星：修正输给金轮也算赢的BUG
		instruct_15()
		do return end
	end		
	say("嘿，大哥做得好。封了你的穴，看你这和尚还嚣张！", 92)
	say("襄儿，我们要拿这和尚怎么办？")	
	say("恶和尚，姑娘今日不杀你，你以后可要知道好歹，不能再害人了罢！", 92)
	say("小姑娘心地倒好，老和尚很喜欢你啊！", 62)	
	say("啊！你不是被封穴了吗？", 92)	
	say("我金轮国师武功独步天下，难道这推经转脉，易宫换穴的粗浅功夫也不会么？小姑娘，你只须拜我为师，我便将这一身功夫，尽数传你。", 62)		
	say("你想得美！", 92)		
	say("嘿，这可由不得你。", 62)		
	say("啊！", 92)	
	say("哈哈，小姑娘乖乖跟我走吧！", 62)	
	say("襄儿！！！")	
	dark()
	addevent(-2, 20, 0, 0, 0, 0)	
	addevent(-2, 18, 0, 0, 0, 0)	
	addevent(-2, 19, 0, 0, 0, 0)	
	instruct_21(92)
	light()
	say("糟糕！襄儿被那老和尚捉走了，我得快点去找她！")	
	addevent(3, 20, 0, 10024, 3)	
end

OEVENTLUA[10024] = function() --郭襄支线5
	if instruct_20() then
		do return end
	end
	dark()
	addevent(3, 21, 1, 10024, 1, 4108*2)	
	light()
	say("老和尚，是你！快点把襄儿交出来！")	
	say("哼！我还要找她呢！你来得正好，等我把你捉了引她出来！", 62)	
	if WarMain(303) == false then
		instruct_15()
		do return end
	end
	say("哼！臭小子武功有进步，看在我徒弟份上今天就饶了你！", 62)	
	dark()
	addevent(3, 21, 0, 0, 0, 0)	
	light()
	say("徒弟....？")	
	say("大哥！", 92)	
	dark()
	addevent(3, 21, 1, 10024, 1, 4604*2)	
	light()	
	say("襄儿！你没事了？")	
	say("嗯，说来话长。那和尚捉了我之后，不知为何突然想收我为徒。我和他虛以委蛇了一番，趁机逃了出来....", 92)
	say("那就好....你没事吧？")
	say("我没事，他虽然是恶人，但对我却挺好的....", 92)	
	say("我们趁他找回来之前快点走吧。")	
	say("好....", 92)		
	dark()
	addevent(3, 20, 0, 0, 0, 0)	
	addevent(3, 21, 0, 0, 0, 0)	
	addpic(3, 21, 1)
	instruct_10(92)
	light()	
	setJX(92,1)
	JoinMP(92, 17, 4)
	addthing(351)
	if MPPD(0) == 0 and JY.Person[0]["品德"] >= 85 then 
	    say("大哥，襄儿这段时间在峨眉山上开山立派",92)
        say("襄儿你的意思是？",0)
	    say("襄儿想请大哥助我一臂之力，造福武林",92)
	    if DrawStrBoxYesNo(-1, -1, "是否加入峨眉派？", C_WHITE, 30) == true then 
	        say("就助襄儿一臂之力",0)
	        say("多谢大哥",92)
	        JoinMP(0,17,3)
			addthing(290)
			addthing(347)
		end
	end 	
end

OEVENTLUA[837] = function() --幽冥符 924
	--TalkEx("东汉蔡邕之墓",0,2)
	instruct_1(3344, 0, 1)
	local pid = -1
	if hasppl(581) then pid = 581 end
	if hasppl(73) then pid = 73 end	
	if pid ~= -1 and hasthing(54) and (not hasHZ(76)) then
		say("蔡邕？那不就是制作这焦尾琴的蔡中郎么。这个叫小虾米的人好可恶....", pid)
		say("（看她这个样子，还是不要说我也去盗墓了的好....）")
		say("同为爱乐之人，我应该拜祭一下前辈的墓才是。", pid)
		dark()
		addevent(-2, -2, -2, 0, 0, 2770*2)
		light()
		say("咦？这东西是？", pid)
		addHZ(76)		
	end
end

OEVENTLUA[1046] = function() --耶律齐觉醒
	if hasppl(619) and JX(619) == false then
		say("师父，弟子磕头，您老人家万福金安。", 619)
		say("免礼平身！你小娃儿也万福金安！", 64)
		say("耶律兄原来是周前辈的弟子啊。（师徒本性也差太多了吧！）")
		say("来来，让我看看你武功有没有进步。", 64)
		if WarMain(305) then
			say("小娃子有进步！只是这分心二用的本事还差点火候，仔细看好了....", 64)
			dark()
			light()
			say("谢师父指点。", 619)
			tb("耶律齐学会左右互搏，攻防轻各加十五点！")
			setJX(619)
			setTF(619, 98)
			JY.Person[619]["左右互搏"] = 1
			AddPersonAttrib(619, "攻击力", 15)
			AddPersonAttrib(619, "防御力", 15)
			AddPersonAttrib(619, "轻功", 15)
			if GetS(111, 0, 0, 0) == 0 then
	            say("我突然领悟了金关玉锁诀关于杀意的使用方法",619)
	            instruct_0();
			    say("不如和兄弟你分享一下", 619)	
			    instruct_0(); 
			    if instruct_11(0,188) == true then
	                QZXS("领悟杀意波动！")
	                instruct_0();
	                say("多谢耶律兄",0) 
	                SetS(111, 0, 0, 0,150)
				else
				    say("不要啊？那算啦。",150)					 
				end
            end
		else
			say("小娃儿本事还差点，去练练再来！", 64)
		end
		do return end
	end
    instruct_1(3898,64,0);   --  1(1):[周伯通]说: 来来来，和老顽童过两招。
    instruct_0();   --  0(0)::空语句(清屏)
    if instruct_5(6,0) ==false then    --  5(5):是否选择战斗？是则跳转到:Label0
        instruct_1(3899,0,1);   --  1(1):[慕容惜花]说: 前辈别开玩笑了，晚辈哪里*是您的对手！
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0
    if instruct_6(67,8,0,1) ==false then    --  6(6):战斗[67]是则跳转到:Label1
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_1(3900,64,0);   --  1(1):[周伯通]说: 你的功夫还不行，去练练再*来！
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label1
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(3901,64,0);   --  1(1):[周伯通]说: 小兄弟，你这是什么功夫？*教教我好不好？
    instruct_0();   --  0(0)::空语句(清屏)
	if not hasHZ(24) and checkpic(20, 0, 1) then --hasHZ(32) 武骧金星：修正BUG
		say("前辈别开玩笑了。")
		say("拜托你一定要教教我！不然我就不让你走！", 64)
	    if JY.Person[zj()]["左右互搏"] == 1 and GetS(111, 0, 0, 0) == 0 then
	        say("（随便教点东西打发他好了）那前辈请看清楚了....")
	        instruct_0();
			say("哈哈，小兄弟，我也教你几招！", 64)	
			instruct_0(); 
			if instruct_11(0,188) == true then
	            QZXS("领悟左右互搏精义！")
	            instruct_0();
	            say("多谢前辈",0) 
	            SetS(111, 0, 0, 0,999)
			else
				say("不要啊？那算啦。",64)					 
			end
		        tb("周伯通攻击力加二十点！")
		        AddPersonAttrib(64, "攻击力", 20)				  
				addHZ(24)
                do return; end
        end
		say("（随便教点东西打发他好了）那前辈请看清楚了....")
		dark()
		light()
		tb("周伯通攻击力加二十点！")
		AddPersonAttrib(64, "攻击力", 20)
		say("哈哈，小兄弟，下次来的时候叫你看看老顽童的进展！", 64)	
		addHZ(24)		
		addHZ(156)
	end
	if PersonKF(0, 15) and GetS(113,0,0,0) == 0 then 
	    say("小娃娃也会老顽童的空明拳？",64) 
		say("前辈忘记了吗？不久之前您教过晚辈的。",0) 
		say("小娃娃并没有掌握要诀，看好了，空明拳应该这样玩。",64) 
	    instruct_0();
	    if instruct_11(0,188) == true then 
	        QZXS("领悟空明奥义！")
			say("多谢周老前辈！",0)
	        instruct_0();
	        setLW1(15)
		else
			say("不好玩。",64) 
		end	
	end
end

OEVENTLUA[843] = function() --陆无双支线1
	if hasppl(92) and LWS(92) then
		say("表姊！", 92)
		say("双儿！你怎么会在这里？", 63)
		say("原来你们是表姊妹？")
		say("这事说来话长....当年.....", 63)
		dark()
		light()
		say("后来我找了个机会，就逃离了那魔头的身边，然后就跟着你到处跑了....", 92)
		say("对了，双儿，这是我桃花岛的旋风扫叶腿法，虽然不能根治你腿脚的旧伤，但也能让你行动更加方便。", 63)
		say("谢谢表姊。", 92)
		dark()
		AddPersonAttrib(92, "轻功", 100)		
		light()
		tb("陆无双轻功增加100点！")
		addHZ(80)
		say("那李莫愁随时可能回来找你们姊妹的麻烦，程姑娘不如随我们回小村，也好有个照应。")
		say("那就有劳公子了。", 63)
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_3(104,60,1,0,971,0,0,7244,7244,7244,-2,-2,-2);   --  3(3):修改事件定义:场景[襄阳城]:场景事件编号 [60]

		if instruct_20(19,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label1
			instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_10(63);   --  10(A):加入人物[程英]
			instruct_0();   --  0(0)::空语句(清屏)
			do return; end
		end    --:Label1
		instruct_1(12,63,0);   --  1(1):[程英]说: 你的队伍已满，我就直接去*小村吧。
		instruct_14();   --  14(E):场景变黑
		instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
		instruct_3(70,30,1,0,155,0,0,6120,6120,6120,-2,-2,-2);   --  3(3):修改事件定义:场景[燕子坞]:场景事件编号 [30]
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
		do return end
	end
    instruct_1(3357,0,1);   --  1(1):[慕容惜花]说: 适才听那李莫愁之言，姑娘*似乎是桃花岛主黄药师之徒*？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3358,63,0);   --  1(1):[程英]说: 不错，我算是恩师黄药师的*关门弟子吧。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3359,0,1);   --  1(1):[慕容惜花]说: 如此说来，姑娘武功一定是*不错的了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3360,63,0);   --  1(1):[程英]说: 哪里哪里，恩师传我一套玉*箫剑法，我还未练得纯熟。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3361,0,1);   --  1(1):[慕容惜花]说: 那程姑娘可否与在下一游，*帮忙在下寻找那十四天书？
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_28(0,65,999,20,0) ==false then    --  28(1C):判断慕容惜花品德65-999是则跳转到:Label0
        instruct_1(3362,63,0);   --  1(1):[程英]说: 我看公子脸上泛有戾气，公*子还是多做些善事才是．
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_3(-2,-2,-2,0,844,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
        do return; end
    end    --:Label0

    instruct_1(3363,63,0);   --  1(1):[程英]说:  嗯！好吧．*反正我一人在此也是无聊，*就随公子一游吧．
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_3(104,60,1,0,971,0,0,7244,7244,7244,-2,-2,-2);   --  3(3):修改事件定义:场景[襄阳城]:场景事件编号 [60]

    if instruct_20(19,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label1
        instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_10(63);   --  10(A):加入人物[程英]
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label1

    instruct_1(12,63,0);   --  1(1):[程英]说: 你的队伍已满，我就直接去*小村吧。
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
    instruct_3(70,30,1,0,155,0,0,6120,6120,6120,-2,-2,-2);   --  3(3):修改事件定义:场景[燕子坞]:场景事件编号 [30]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
end

OEVENTLUA[1051] = function() --瑛姑送寒阴箭七绝针
	TalkEx("小兄弟，多谢你了。我这二十多年研究出了两套武功，这就传授给你吧。", 237, 0, "瑛姑")
	addthing(281, 1)
	addthing(331)
	TalkEx("多谢前辈。", 0, 1) 
	instruct_3(-2, -2,1,0,1048,0,0,-2,-2,-2,-2,-2,-2)  --修改场景事件
end

OEVENTLUA[730] = function()  --林平之觉醒
	if instruct_16(36) then  --是否在队伍
		TalkEx("余沧海，你还认得我吗？", 36, 1)  --对话
		Cls()  --清屏
		TalkEx("你，你，你是福威镖局的林*平之！", 24, 0)  --对话
		Cls()  --清屏
		TalkEx("不错，正是我！你为了辟邪*剑谱，害的我家破人亡，今*日，我就让你见识一下辟邪*剑法，你看清楚了！", 36, 1)  --对话
		Cls()  --清屏
		--JY.Person[24]["武功1"] = 48
		JY.Person[24]["攻击力"] = JY.Person[24]["攻击力"] + 50
		JY.Person[24]["防御力"] = JY.Person[24]["防御力"] + 50
		JY.Person[24]["轻功"] = JY.Person[24]["轻功"] + 50
		if WarMain(51, 0) == false then  --战斗开始
			instruct_15()  --死亡
			Cls()  --清屏
			do return end  --无条件结束事件
			Cls()  --清屏
		else
			if GetS(54,0,0,1) == 2 then
				instruct_3(-2, 0,0,0,0,0,0,0,0,0,0,0,0)  --修改场景事件
				instruct_3(-2, 4,0,0,0,0,0,0,0,0,0,0,0)  --修改场景事件
				instruct_3(-2, 3,0,0,0,0,0,0,0,0,0,0,0)  --修改场景事件
				instruct_3(-2, 2,0,0,0,0,0,0,0,0,0,0,0)  --修改场景事件
				instruct_3(-2, 1,0,0,0,0,0,0,0,0,0,0,0)  --修改场景事件
				addevent(56,1,1,8653,1,5862)
				JY.Person[36]["性别"] = 0
				setJX(36)
				Cls()  --清屏
				instruct_13()  --场景变亮
				instruct_37(-5)  --增加品德
				say("哈...哈哈哈...爹、妈，我、我给你们...哈哈", 36, 0)
				say("哈哈哈哈哈哈哈哈！！！", 36, 0)
				bgtalk("林平之狂笑不止，本就仅初窥门径的葵花内力更是在心神影响下无比紊乱")
				bgtalk("同时林平之体内更是爆发出一股诡异的力量，阳刚暴烈，与葵花内力诡异的融合了")
				say("林平之，你，你快冷静下来！", 0, 1) 
				say("哈哈哈哈哈哈哈哈！！！", 36, 0)
				bgtalk("你眼前陡然一花，空荡荡的青城派只剩你一人")
				bgtalk("却是哪里还有林平之的影子？")
				say("该死，好可怕的速度...这下我要去哪里找人？", 0, 1)
				say("（传音入密：他往东南方去了～还不去追？）", 27, 1)
				say("东方姐姐？你怎么也...算了。", 0, 1)
				say("东南方？那不就是福威镖局么？", 0, 1)
				say("去镖局看看吧。", 0, 1)
				instruct_21(36)
				null(70,25)
				do return end  --无条件结束事件
			else 
				instruct_3(-2, 0,0,0,0,0,0,0,0,0,0,0,0)  --修改场景事件
				instruct_3(-2, 4,0,0,0,0,0,0,0,0,0,0,0)  --修改场景事件
				instruct_3(-2, 3,0,0,0,0,0,0,0,0,0,0,0)  --修改场景事件
				instruct_3(-2, 2,0,0,0,0,0,0,0,0,0,0,0)  --修改场景事件
				instruct_3(-2, 1,0,0,0,0,0,0,0,0,0,0,0)  --修改场景事件
				--addevent(56,1,1,8653,1,5862)
				--JY.Person[36]["性别"] = 0
				--setJX(36)
				Cls()  --清屏
				instruct_13()  --场景变亮
				instruct_37(-5)  --增加品德
				say("哈...哈哈哈...爹、妈，我给你们报仇了！", 36, 0)
				say("哈哈哈哈哈哈哈哈！！！", 36, 0)
			end	
		end
	else
		TalkEx("嘿嘿嘿，我要想办法把青城*派发扬广大……", 24, 0)  --对话
		Cls()  --清屏
		do return end
	end
end

OEVENTLUA[8653] = function()--辟邪领悟事件
	say("林平之，你果然在这里！", 0, 1)
	say("（眼神散乱）滚，给我滚，你们这些该死的...", 36, 0)
	say("青城派的野兽！！！！！", 36, 0)
	SetS(106, 63, 1, 0, 0)
	SetS(106, 63, 2, 0, 36)
	JY.Person[36]["武功1"] = 48
	JY.Person[36]["武功2"] = 105
	JY.Person[36]["武功等级1"] = 999
	JY.Person[36]["武功等级2"] = 999
	JY.Person[36]["声望"] = 105
	if WarMain(288) == false then  
		instruct_15(0);   
		instruct_0(); 
		do return; end
	else
		if GetS(113,0,0,0) == 0 then
			say("呜阿阿阿阿阿阿阿！！！！！！！！", 36, 0)
			say("（这样下去林平之会死的！）", 0, 1)
			say("（传音入密：唉...真的是傻孩子）", 27, 1)
			say("（传音入密：东方姐姐？姐姐有方法？）", 0, 1)
			say("（传音入密：当然有。你没发现林小子身上的暴乱气息，跟我的内力有关联么？）", 27, 1)
			say("（传音入密：现在跟著我的口诀催动内力，我教你把那股气息钓出来...）", 27, 1)
			dark()
			light()
			say("呼...呼...还、还好成功了...", 0, 1)
			say("被钓出来的气息都被我第一时间驱散", 0, 1)
			say("虽然有些气息依然附在了我的内力上，但温驯的很，应该没事吧。", 0, 1)
			say("（传音入密：谢谢东方姐姐！）", 0, 1)
			say("（传音入密：小事。林小子看来神智清明点了，我就继续看戏吧）", 27, 1)
			bgtalk("林平之狂乱涣散的双眼逐渐恢复清明")
			say("林平之，你清醒了么？", 0, 1)
			say("（大口大口喘著气）我...我...我没事...", 36, 0)
			say("感...感谢少侠与东方教主救命之恩...", 36, 0)
			say("救你的另有其人，不用言...嗯！？", 0, 1)
			say("嗯？！", 27, 1)
			say("少侠不用...呼...惊慌，适才的传音入密，我都有听到", 36, 0)
			say("其实我的意识在回到镖局后就正常了，只是那股气息让我无法控制自己", 36, 0)
			say("那股气息也与我的身世有关...其名为「妖力」", 36, 0)
			say("妖、妖力，难道林平之...你不是人？", 0, 1)
			say("呵呵（苦笑），于此世中，或许我真的不是人", 36, 0)
			say("我能听到传音入密，也是因为妖力之故。", 36, 0)
			say("唉，总之在被妖力控制的过程中，我想起了许多我族的历史与秘辛", 36, 0)
			say("个中种种，实在难以向少侠细说。且我现在妖力也所剩无几，更没立场谈论我族之事。", 36, 0)
			say("但我可以教少侠如何运用这股残留妖力于「辟邪剑法」中", 36, 0)
			say("算是对少侠的报答吧。", 36, 0)
			dark()
			light()
			QZXS("领悟辟邪剑法！")
			setLW1(48)
			if hasthing(303) then
				say("对了，借少侠「紫薇剑」一用", 36, 0)
				say("给！", 0, 1)
				say("呵，误伤义士而不祥...这把剑本就是我族凶剑阿", 36, 0)
				say("就用我最后的妖力，为这把剑回复本来面貌吧", 36, 0)
				dark()
				light()
				JY.Thing[303]["名称"] = "太岁凶剑"
				JY.Thing[303]["物品说明"] = "异族古传凶剑，不知为何流落此世"
			end
			say("多谢了，林平之。", 0, 1)	
			say("唉，那请你代我向东方教主致谢吧", 36, 0)
			say("在我苏醒的记忆中，我族还有其他族人流落此世", 36, 0)
			say("我想我得去找到他们", 36, 0)
			say("言下之意是，你要离开？", 0, 1)
			say("是", 36, 0)
			say("...你既心意已决，那就如此吧", 0, 1)
			say("但...别忘了那个对你一直不离不弃的女人", 0, 1)
			say("我还算懂点医术，我发现妖力从你身体浮现的瞬间", 0, 1)	
			say("就已经修复了你的「残缺」，你再没有理由抛下她了", 0, 1)	
			say("（身躯一震）...好，请少侠保重", 36, 0)
			dark()
			if hasppl(79) then
				instruct_21(79)
			end	
			null(-2,1)
			null(70,42)
			Cls()
			light()
		else
			say("呜阿阿阿阿阿阿阿！！！！！！！！", 36, 0)
			say("（这样下去林平之会死的！）", 0, 1)
			say("（传音入密：唉...真的是傻孩子）", 27, 1)
			say("（传音入密：东方姐姐？姐姐有方法？）", 0, 1)
			say("（传音入密：当然有。你没发现林小子身上的暴乱气息，跟我的内力有关联么？）", 27, 1)
			say("（传音入密：现在跟著我的口诀催动内力，我教你把那股气息钓出来...）", 27, 1)
			dark()
			light()
			say("呼...呼...还、还好我武功够强，成功了...", 0, 1)
			say("被钓出来的气息都被我第一时间全部驱散", 0, 1)
			say("（传音入密：谢谢东方姐姐！）", 0, 1)
			say("（传音入密：小事。林小子看来神智清明点了，我就继续看戏吧）", 27, 1)
			bgtalk("林平之狂乱涣散的双眼逐渐恢复清明")
			say("林平之，你清醒了么？", 0, 1)
			say("（大口大口喘著气）我...我...我没事...", 36, 0)
			say("感...感谢少侠与东方教主救命之恩...", 36, 0)
			say("救你的另有其人，不用言...嗯！？", 0, 1)
			say("嗯？！", 27, 1)
			say("少侠不用...呼...惊慌，适才的传音入密，我都有听到", 36, 0)
			say("其实我的意识在回到镖局后就正常了，只是那股气息让我无法控制自己", 36, 0)
			say("那股气息也与我的身世有关...其名为「妖力」", 36, 0)
			say("妖、妖力，难道林平之...你不是人？", 0, 1)
			say("呵呵（苦笑），于此世中，或许我真的不是人", 36, 0)
			say("我能听到传音入密，也是因为妖力之故。", 36, 0)
			say("唉，总之在被妖力控制的过程中，我想起了许多我族的历史与秘辛", 36, 0)
			say("个中种种，实在难以向少侠细说。且我现在妖力也所剩无几，更没立场谈论我族之事。", 36, 0)
			say("没关系的，每个人都有秘密", 0, 1)
			say("...那么，请你代我向东方教主致谢吧", 36, 0)
			say("在我苏醒的记忆中，我族还有其他族人流落此世", 36, 0)
			say("我想我得去找到他们", 36, 0)
			say("言下之意是，你要离开？", 0, 1)
			say("是", 36, 0)
			say("那你何必离开？小村伙伴多，大家一起找不也好？", 0, 1)
			say("但十四天书...？", 36, 0)
			say("找天书是找，找族人是找，不一样么？", 0, 1)
			say("那林平之在此叩谢少侠了", 36, 0)
			say("使不得使不得阿！", 0, 1)
			say("现在林平之你的身体还虚弱，快回小村找平大夫看看吧", 0, 1)
			say("好吧，那我先回小村了", 36, 0)
			instruct_3(70, 25, 1, 0, 123, 0, 0, 5862, 5886, 5862, -2, -2, -2)
			if hasthing(303) then
				say("对了，借少侠「紫薇剑」一用", 36, 0)
				say("给！", 0, 1)
				say("呵，误伤义士而不祥...这把剑本就是我族凶剑阿", 36, 0)
				say("就用我最后的妖力，为这把剑回复本来面貌吧", 36, 0)
				dark()
				light()
				JY.Thing[303]["名称"] = "太岁凶剑"
				JY.Thing[303]["物品说明"] = "异族古传凶剑，不知为何流落此世"
				say("我们小村再见吧", 36, 0)
				null(-2,1)
				Cls()
			else
				dark()
				null(-2,1)
				light()
			end
		end	
	end
end

--学葵花
OEVENTLUA[5000] = function()
	if JY.Person[0]["性别"] == 1 then
	    say("妹妹，以后你就是副教主了。",27);
		say("（我什么时候成了你妹妹？。。。）",0);
        say("姐姐很早就想要一个你这样的妹妹了，嘻嘻。",27);
        say("姐。姐姐。。（反正也不会亏本？。。。）",0);
	else
	    say("弟弟，以后你就是副教主了。",27);
        say("（我什么时候成了你弟弟？。。。）",0);
        say("姐姐很早就想要一个你这样的弟弟了，嘻嘻。",27);
        say("姐。姐姐。。（反正也不会亏本？。。。）",0);
	end
    if MPPD(0) ~= 0 then 
   		if JY.Person[0]["性别"] == 1 then
            say("那个..妹妹已经有门派了...",0);
	    else
	        say("那个..弟弟已经有门派了...",0);
	    end
		say("没关系，换一下门派而已。",27);  
		if instruct_11(0,188) == true then	
            JoinMP(0,12,4)
			say("姐姐会好好疼你的。",27);
		else   
            say("那就不勉强你了。",27);
		end
    else
        JoinMP(0,12,4)
    end
        if JY.Person[0]["性别"] == 1 then
say("好妹妹，姐姐教你葵花神功。",27);
say("（！！！我还不想变性啊！！！）",0);
instruct_2(93,1);   --  2(2):得到物品[葵花宝典][1]
instruct_2(357,1)
say("放心好了，不会让妹妹失望的，这可是姐姐千辛万苦为妹妹准备的礼物哦。",27);
say("咦？男女都可以练？",0);
say("姐姐怎么可能害妹妹呢。",27);
	    else
say("乖弟弟，姐姐教你葵花神功。",27);
say("（！！！我还不想变性啊！！！）",0);
instruct_2(93,1);   --  2(2):得到物品[葵花宝典][1]
instruct_2(357,1)
say("放心好了，不会让弟弟失望的，这可是姐姐千辛万苦为弟弟准备的礼物哦。",27);
say("咦？男女都可以练？",0);
say("姐姐怎么可能害弟弟呢。",27); 
	    end
instruct_0();   --  0(0)::空语句(清屏)
	        if GetS(111, 0, 0, 0) == 0 then
				if instruct_11(0,188) == true then
				     say("谢谢东方姐姐！",0); 
					 instruct_0();
	                 QZXS("领悟葵花真解！")
	                 instruct_0();
	                 SetS(111, 0, 0, 0,105)
					 
				else
				     say("姐姐的好意心领了。",0) 
					 say("那好吧。",27);
					 instruct_0()
				end	
			end	
        if JY.Person[0]["性别"] == 1 then
say("今天姐姐高兴，说吧，妹妹想要什么，姐姐都帮你取来",27);
say("东方姐姐可知道《笑傲江湖》此书？",0);
say("这本书到是听过，好像在华山岳不群那里，妹妹可是想要？姐姐帮你取来便是。",27);
say("不劳烦东方姐姐，妹妹自己动手便可。",0);
say("不愧是本教主的妹妹，有气魄，要是有什么麻烦直接叫上姐姐，姐姐帮你摆平。",27);
	    else
say("今天姐姐高兴，说吧，弟弟想要什么，姐姐都帮你取来",27);
say("东方姐姐可知道《笑傲江湖》此书？",0);
say("这本书到是听过，好像在华山岳不群那里，弟弟可是想要？姐姐帮你取来便是。",27);
say("不劳烦东方姐姐，弟弟自己动手便可。",0);
say("不愧是本教主的弟弟，有气魄，要是有什么麻烦直接叫上姐姐，姐姐帮你摆平。",27);
	    end
    instruct_3(57,1,1,0,913,0,0,5696,5696,5696,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [1]
    instruct_3(57,0,1,0,0,0,0,5694,5694,5694,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [0]
    instruct_3(57,32,1,0,900,0,0,5180,5180,5180,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [32]
	instruct_3(-2,0,1,0,5001,0,0,5720,5720,5720,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [5000]
end

OEVENTLUA[5001] = function()
        if JY.Person[0]["性别"] == 1 then
say("妹妹可是需要姐姐帮忙么。",27);
say("不劳烦姐姐，妹妹可以解决，就是来看看姐姐",0);
say("嘻嘻...真是可贴心的妹妹。",27);
	    else
say("弟弟可是需要姐姐帮忙么。",27);
say("不劳烦姐姐，弟弟可以解决，就是来看看姐姐",0);
say("嘻嘻...真是可贴心的弟弟。",27);
	    end
end

OEVENTLUA[5002] = function()
        if MPPD(0) ~= 11 and JY.Person[0]["觉醒"] > 0 then
            say("阁下来我刀宗有何贵干？",597);
            say("途经此地，特来拜会。",0);
            say("怕是阁下有备而来吧。",597);
            say("宗主英明，在下听闻刀宗乃是从东瀛而来，特来拜会。",0);
            say("我刀宗从未与中原有所接触，不知阁下所为何事？",597);
            say("不知宗主可否知晓天书？",0);
			say("哼哼，自然。",597);
			say("不知宗主为何抢我天书？",0);
			say("阁下可是在质疑本宗主？",597);
			say("在下不敢。",0);
			say("哼！本宗对天书并无兴趣，也未曾抢夺天书。",597);
			say("那不知从何而来的东瀛武士？",0);
			say("哦？那些家伙已经动手了么？阁下当真不走运。",597);
			say("听宗主之言，想来是知道些什么，望宗主明示。",0);
			say("一些野心勃勃之人，怕是想要入侵这中原大地吧。",597);
			say("！！！",0);
			say("我刀宗来中原不过是跟随本宗另一位宗主谢云流而来。",597);
			say("谢云流？",0);
			say("阁下无需知晓，只需知晓谢云流也是中原人便可。",597);
			say("阁下在江湖中寻找十四天书，想来应该会碰到他，若是遇到他，务必告诉本宗主。",597);
			say("若是在下遇到，定当告知宗主。",0);
			say("嗯？你果真是个麻烦，都追到本宗主这来了。",597);
                instruct_0();   --  0(0)::空语句(清屏)
                instruct_14();   --  14(E):场景变黑
			    --instruct_3(-2, 2, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2, -2) --加贴图
				instruct_3(-2, 0, 0, 0, 0, 0, 0, 7260, 7260, 7260, -2, 16, 13) --加贴图
                instruct_0();   --  0(0)::空语句(清屏)
                instruct_13();   --  13(D):重新显示场景
			say("宫本？你擅闯我刀宗可是想死？",597);	
			say("...宫本..只为此人而来...",516);	
			say("你想在我刀宗动手？。",597);	
			say("...宫本...不敢.",516);
			say("离开刀宗地界本宗主不管，但是在刀宗地界，谁敢擅自动手，可别怪本宗主不客气。",597);
			say("..多谢..宫本告辞。",516);
                instruct_0();   --  0(0)::空语句(清屏)
                instruct_14();   --  14(E):场景变黑
			    --instruct_3(-2, 2, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2, -2) --加贴图
				instruct_3(-2, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 16, 13) --加贴图
                instruct_0();   --  0(0)::空语句(清屏)
                instruct_13();   --  13(D):重新显示场景

			say("此人好大的杀气！！",0);
			say("这是自然，宫本乃是东瀛数一数二的高手，你在他手上走不过一招，不过宫本既然参与此事，阁下怕是麻烦了。",597);
			say(".....",0);
			say("想来抢夺阁下天书的便是他们吧。",597);
			say("多谢谢宗主救命之恩。",0);
			say("不用谢我，本宗规矩，刀宗之内禁止争斗。",597);
            say("在下为宗主所救却是事实。",0);
			say("随你如何想，本宗主无需阁下感谢。",597);
			say("........",0);
			say("森九岚，怕是需要你跑一趟了。",597);
			say("不知殿下有何吩咐？",929)
			say("陪这位少侠一同去寻找谢云流。",597);
			say("遵命。",929)
			say("若是他死在路途中，你便直接回来便是。",597);
			say("是。",929)
			say("............",0);
			say("阁下的路途怕是不平静了。",597);
				if instruct_20() then 
				    setteam(929,1)
				    say("我去小村等你。",929)
				else 
				    instruct_10(929)
				end
                instruct_0();   --  0(0)::空语句(清屏)
                instruct_14();   --  14(E):场景变黑
			    instruct_3(-2, 2, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2, -2) --加贴图
				instruct_3(-2, -2, 1, 0, 5007, 0, 0, -2, -2, -2, -2, -2, -2) --加贴图
                instruct_0();   --  0(0)::空语句(清屏)
                instruct_13();   --  13(D):重新显示场景
				SetS(99,1,0,0,1)
		    	do return end
		end	
	say("（你到底去哪了呢？）",597);	
	say("实力不够到处乱跑可是会死的哦～",597);	
end

OEVENTLUA[5006] = function()
if XYL(0) then 
    say("师傅！",929);
    instruct_10(929)
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2, 2, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2, -2) --加贴图
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
	do return end
end
say("阁下有何见教？？",929);
end
OEVENTLUA[5007] = function()
say("还有事么？",597);
	if MPPD(0) == 0 and JY.Person[0]["御剑能力"] >= 350 then 
		say("我想加入刀宗，不知宗主可否答应？",0);
		say("你？。。谢云流不在我还真不敢随便给他找徒弟，嘛，既然他给我找不自在，我也给他找一次。好吧我答应你了。",597);
		say("多谢宗主",0);
		say("如若叛门，杀无赦！",597);
		say("弟子谨记。",0);
		if DrawStrBoxYesNo(-1, -1, "要学一刀流的武功么？", C_WHITE, 30) == true then 
			JoinMP(0, 11, 3) 
			instruct_2(268) 
			instruct_2(340)
			instruct_35(zj(), 0, 131,999)	
			if zj() == 0 and (putong() > 0 or teshu() > 0) then 
				DrawStrBoxWaitKey(string.format("%s 学会武功 %s", JY.Person[zj()]["姓名"], JY.Wugong[131]["名称"]), C_ORANGE, CC.DefaultFont)
				if DrawStrBoxYesNo(-1, -1, "要切换外功精通么？", C_WHITE, 30) == true then 
					SetS(112,1,0,0,131)
				end
			end
		end
	end
	if GetS(111,0,0,0) == 0 and JY.Person[0]["觉醒"] > 0 and JY.Person[0]["御剑能力"] >= 350 then
	    say("你的实力已经可以学习太虚剑意，需要参悟么？",597)
		if instruct_11(0,188) == true then
	        QZXS("领悟太虚剑意！")
	        instruct_0();
	        say("多谢！",0)  
			instruct_2(340)
	        SetS(111,0,0,0,180)
		end
	end	
end

OEVENTLUA[5008] = function()
 instruct_0();   --  0(0)::空语句(清屏)
 instruct_14();   --  14(E):场景变黑
 instruct_3(-2, 0, 0, 0, 0, 0, 0, 9398, 9398, 9398, -2, 27, 31) --加贴图
 instruct_0();   --  0(0)::空语句(清屏)
 instruct_13();   --  13(D):重新显示场景
 if XYL(0) then 
    say("师傅，您回来啦？",929);
	say("顺道回来看看，对了，无悠那丫头呢？",0)
	say("公主殿下出去找您去了。",929);
	say("那算了，你随我走一趟吧，有些事情需要处理。",0)
	say("是，师傅。",929);
	if instruct_20() then 
		say("我去小村等你。",929)
		setteam(929,1)
	else 
		instruct_10(929)
	end
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_14();   --  14(E):场景变黑
		instruct_3(-2, 2, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2, -2) --加贴图
		instruct_3(-2, -2,0, 0, 0, 0, 0, 0, 0, 0, -2, -2, -2) --加贴图
		instruct_3(-2, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2, -2) --加贴图
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
		do return end
 end
 if JY.Person[0]["觉醒"] > 0 then
    say("何人擅闯刀宗？",929);
	say("在下恰逢路过，特来拜会。",0)
	say("让他进来吧。",597);
	say("遵命。",929);
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 27, 31) --加贴图
    instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2, -2) --加贴图
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    do return end
 end
    say("何人擅闯刀宗？",929);
	say("在下恰逢路过，特来拜会。",0)
	say("此地不欢迎任何人，请回。",929);
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 27, 31) --加贴图
    instruct_19(28,32);   --  19(13):主角移动至19-14
    instruct_40(0);   --  40(28):改变主角站立方向0
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    --instruct_3(113, 3, 0, 0, 0, 0, 5008, 0, 0, 0, -2, 28, 31) --加贴图 --1-26-
end

OEVENTLUA[5003] = function()
    if hasthing(147) then 
        say("这是？？",0);
        addthing(339)
		if PersonKF(0,200) and PersonKF(0,87) then
			if GetS(114,0,0,0) == 0 then
				say("这凌波微步...跟摘星功好像阿",0)
				say("丁春秋那家伙果然摆脱不了逍遥武学阿",0)
				say("如今我有完整的凌波微步和化功大法",0)
				say("不如来试著完善一下摘星功？",0)
				if DrawStrBoxYesNo(-1, -1, "开始完善吗？", C_WHITE, 30) == true then
					QZXS("领悟摘星功！")
					setLW2(200)
					say("哈哈，这下我真的可以自称星宿真仙了",0)
				else
					say("...算了，我还是走我自己的路来完善摘星功吧",0)
				end
			end
		end		
        instruct_3(-2, -2, -2, 0, 5004, 0, 0, -2, -2, -2, -2, -2, -2)
    end
end

OEVENTLUA[5004] = function() --放水之战
if MPPD(zj()) == 7 and MPDJ(zj()) >= 2 then 
    say("这是？？",0);
    SetS(86, 1, 9, 5, 1)
    SetS(86, 2, 13, 5, 3)
    if WarMain(226) then
        say("我逍遥派就靠你传承了。",116)
        SetS(111,0,0,0,998)
        JoinMP(0,7,5)
        SetS(86, 2, 13, 5, 1)
        SetS(86, 1, 9, 5, 0)
        instruct_3(-2, -2, -2, 0, 0, 0, 0, -2, -2, -2, -2, -2, -2)
    end
        SetS(86, 2, 13, 5, 1)
        SetS(86, 1, 9, 5, 0)
        instruct_3(-2, -2, -2, 0, 0, 0, 0, -2, -2, -2, -2, -2, -2)
end
end

OEVENTLUA[5005] = function() --放水之战
if JY.Person[0]["觉醒"] > 0 then 
local aa = 0
for i = 1,HHH_GAME_SETTING["WG_COUNT_MAX"] do
if yongnei(JY.Person[0]["武功"..i]) and JY.Person[0]["武功"..i] > 0 then
   aa = aa + 1
end
end
if aa < 2 then 
   do return end
end  
                instruct_0();   --  0(0)::空语句(清屏)
                instruct_14();   --  14(E):场景变黑
				instruct_3(-2, -2, -2, 0, 0, 0, 0, -2, -2, -2, -2, -2, -2)
				                instruct_0();   --  0(0)::空语句(清屏)
                instruct_13();   --  13(D):重新显示场景

say("我闯荡江湖这么多年，终究是走他人之路，我为何不走出自己的路，今日我便自创属于我自己的武功！！")
instruct_0(); 
local menu
	local WGid
	Cls();
	DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY,"选择融合功体", C_WHITE, CC.DefaultFont);
	menu = {};
	for i = 1, HHH_GAME_SETTING["WG_COUNT_MAX"] do
		WGid = JY.Person[0]["武功"..i];
		if yongnei(WGid, 0) and WGid ~= 91 then	---显示内功
		   menu[#menu + 1] = {JY.Wugong[WGid]["名称"],nil,1,WGid};
		end
	end
	local r = ShowMenu(menu,#menu,0,CC.MainSubMenuX,CC.MainSubMenuY+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);
	if r <= 0 then
		return 0
	end	

	JY.Thing[224]["加攻击力"] = menu[r][4] --设置功体
	local a = 0
	for i = 1,HHH_GAME_SETTING["WG_COUNT_MAX"] do 
	   if JY.Person[0]["武功"..i] == JY.Thing[224]["加攻击力"] then 
	     -- JY.Person[0]["武功"..i] = JY.Person[0]["武功"..i+1]
		 a=i
	   end
	end
		Cls()
		DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY,"选择融合功体", C_WHITE, CC.DefaultFont);
		menu = {};
		for i = 1, HHH_GAME_SETTING["WG_COUNT_MAX"] do
			WGid = JY.Person[0]["武功"..i];
			if yongnei(WGid, 0) and WGid ~= 91 and WGid ~= JY.Thing[224]["加攻击力"] then	---显示内功
			   menu[#menu + 1] = {JY.Wugong[WGid]["名称"],nil,1,WGid};
			end
		end	
		local r = ShowMenu(menu,#menu,0,CC.MainSubMenuX,CC.MainSubMenuY+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);
		if r <= 0 then
			return 0
		end	
    
	JY.Thing[224]["加防御力"] = menu[r][4] --设置功体
	JY.Person[0]["武功"..a] = 9999
	JY.Person[0]["武功等级"..a] = 999
	local a = 0
	for i = 1,HHH_GAME_SETTING["WG_COUNT_MAX"] do 
	   if JY.Person[0]["武功"..i] == JY.Thing[224]["加防御力"] then 
	     -- JY.Person[0]["武功"..i] = JY.Person[0]["武功"..i+1]
		 a=i
	   end
	end
    for i = a,HHH_GAME_SETTING["WG_COUNT_MAX"] do 
	      JY.Person[0]["武功"..i] = JY.Person[0]["武功"..i+1]
		  JY.Person[0]["武功等级"..i] = JY.Person[0]["武功等级"..i+1] 
	end
		JY.Person[0]["武功"..HHH_GAME_SETTING["WG_COUNT_MAX"]] = 0
		JY.Person[0]["武功等级"..HHH_GAME_SETTING["WG_COUNT_MAX"]] = 0
		
	JY.Thing[224]["名称2"] = "";
	while JY.Thing[224]["名称2"] == "" do
		JY.Thing[224]["名称2"] = Shurufa(32, CC.ScreenH - 6 * CC.Fontbig)
		if JY.Thing[224]["名称2"] == "" then
			DrawStrBoxWaitKey("请给你的武功命名", C_WHITE, 30)
		end
	end
	JY.Wugong[9999]["名称"] = JY.Thing[224]["名称2"]
	say("终于练成了，哈哈哈哈！")
instruct_3(-2, -2, -2, 0, 0, 0, 0, -2, -2, -2, -2, -2, -2)
end
end

OEVENTLUA[498] = function() --止水
    say("你准备好了吗？",129,0);   --  1(1):[???]说: 你准备好了吗？
    instruct_0();   --  0(0)::空语句(清屏)
    if instruct_6(177,8,0,1) == false then
	say("少侠还需努力一番。",129,0);
    do return end 
    end
	instruct_2(77,1)----  2(2):得到物品[先天功][1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    say("好，好，少侠武功盖世，这*本书理应归少侠所有。",129,0);   --  1(1):[???]说: 好，好，少侠武功盖世，这*本书理应归少侠所有。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_2(148,1);   --  2(2):得到物品[射鵰英雄传][1]
    instruct_0();   --  0(0)::空语句(清屏)
	    if GetS(111, 0, 0, 0) == 0 then
	        say("少侠身具先天功，却是未能领悟其中之奥妙，可需要本座为少侠指点一番？",129) 
	        instruct_0();
			if instruct_11(0,188) == true then
	            QZXS("领悟先天功奥秘！")
	            instruct_0();
	            say("多谢重阳真人！",0) 
	            SetS(111, 0, 0, 0,100)
		    else
				say("既如此，相信少侠才智过人，应当能自行领悟。",129) 
		    end 
        end
		if GetS(113,0,0,0) == 0 then 
	        say("本道见少侠宅心仁厚，有意传授摧坚神爪，少侠可否愿意？",129) 
	        instruct_0();
	        if instruct_11(0,188) == true then 
	            QZXS("领悟摧坚神爪！")
			    say("多谢重阳真人！",0)
	            instruct_0();
	            setLW1(11)
				addthing(102)
		    else
			    say("也罢，本道不勉强少侠。",129) 
		    end	
	    end
		if PersonKF(0, 39) and GetS(113,0,0,0) == 0 then 
			say("少侠也学过北斗剑法，但无精髓，本道就来指点一二。",129) 
			instruct_0();
			if instruct_11(0,188) == true then 
				QZXS("领悟北斗罡剑！")
				say("多谢重阳真人！",0)
				instruct_0();
				setLW1(39)
			else
				say("也罢。",129) 
			end	
		end
		
		if PersonKF(0, 107) and GetS(113,0,0,0) == 0 and JY.Person[0]["品德"] >= 95 then 
			say("少侠也学会九阴真经上的武学吧？",129)
			say("不瞒重阳真人，晚辈机缘之下看过。",0) 
			say("哈哈哈，一切皆是你的福源。",129)
			say("<傻笑>。",0)
			say("但老道见少侠未得其精髓。",129)
			say("多谢重阳真人关心，晚辈以后会慢慢参悟的。",0)
			say("好，难得少侠不贪图这宝典的精要。",129)
			say("<傻笑>。",0)
			say("宝典中有话说到，有缘人请到不老长春古一见。",129)
			say("重阳真人的意思是？？？",0)
			say("少侠可取一看，说不定对寻找天书有帮助。",129)
			say("晚辈明白了。",0)
			say("少侠保重。",129)
			say("重阳真人保重。",0)
			instruct_3(114,6,1,0,6016,0,0,9386,9386,9386,-2,-2,-2)
		end	
	
    if DT(0,601) then
		SetS(112,5,0,0,601)
	end	
	if instruct_16(59,0,167) ==true then    --  16(10):队伍是否有[小龙女]否则跳转到:Label2
        say("你是王重阳。",59,0);   --  1(1):[小龙女]说: 你是王重阳。
        instruct_0();   --  0(0)::空语句(清屏)
        say("？不知这位姑娘是？",129,0);   --  1(1):[???]说: ？不知这位姑娘是？
        instruct_0();   --  0(0)::空语句(清屏)
        say("看招！",59,0);   --  1(1):[小龙女]说: 看招！
        instruct_0();   --  0(0)::空语句(清屏)

        if instruct_6(248,74,0,1) ==false then    --  6(6):战斗[248]是则跳转到:Label3
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
            say("原来是朝英的传人，你为什么挑战本座？",129,0);   --  1(1):[???]说: 原来是朝英的传人，你为什么挑战本座？
            instruct_0();   --  0(0)::空语句(清屏)
            say("古墓石棺。",59,0);   --  1(1):[小龙女]说: 古墓石棺。
			instruct_0();   --  0(0)::空语句(清屏)
            say("原来如此，唉，可笑我枉为修道之人，却看不透胜败，以致...唉...",129,0);   --  1(1):[???]说: 原来如此，唉，可笑我枉为修道之人，却看不透胜败，以致...唉...
            instruct_0();   --  0(0)::空语句(清屏)
            say("......",59,0);   --  1(1):[小龙女]说: ......
            instruct_0();   --  0(0)::空语句(清屏)
            say("以你现在的功力，虽然在武林中也算不错，但还是有所不足，我指点你一番吧。",129,0);   --  1(1):[???]说: 以你现在的功力，虽然在武林中也算不错，但还是有所不足，我指点你一番吧。
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_14();   --  14(E):场景变黑
            instruct_35(59,1,107,0);   --  35(23):设置小龙女武功1:九阴神功攻击力0
            instruct_35(59,2,100,0);   --  35(23):设置小龙女武功2:先天功攻击力0
            instruct_13();   --  13(D):重新显示场景
            instruct_0();   --  0(0)::空语句(清屏)
            say("咱们有缘再见！",129,0);   --  1(1):[???]说: 咱们有缘再见！
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
            instruct_3(-2,0,1,0,499,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
            instruct_0();   --  0(0)::空语句(清屏)
        else   
			instruct_13();   --  13(D):重新显示场景
			instruct_0();   --  0(0)::空语句(清屏)
			say("原来是朝英的传人，你为什么挑战本座？",129,0);   --  1(1):[???]说: 原来是朝英的传人，你为什么挑战本座？
			instruct_0();   --  0(0)::空语句(清屏)
			say("古墓石棺。",59,0);   --  1(1):[小龙女]说: 古墓石棺。
			instruct_0();   --  0(0)::空语句(清屏)
			say("原来如此，唉，可笑我枉为修道之人，却看不透胜败，以致....唉....",129,0);   --  1(1):[???]说: 原来如此，唉，可笑我枉为修道之人，却看不透胜败，以致...唉...
			instruct_0();   --  0(0)::空语句(清屏)
			say("......",59,0);   --  1(1):[小龙女]说: ......
			instruct_0();   --  0(0)::空语句(清屏)
			say("也罢，你师祖一生都想胜过我，导致她在古墓里孤老终生，我也心中有愧，你也胜过我也算了一桩心愿。",129,0);   --  1(1):[???]说: 也罢，你师祖一生都想胜过我，导致她在古墓里孤老终生，我也心中有愧，你也胜过我也算了一桩心愿。
			instruct_45(59,20);   --  45(2D):小龙女增加轻功30
			instruct_47(59,20);   --  47(2F):小龙女增加攻击力30
			instruct_46(59,1000);   --  46(2E):小龙女增加内力2000
			instruct_48(59,100);   --  48(30):小龙女增加生命200
			instruct_0();   --  0(0)::空语句(清屏)
			say("咱们有缘再见！",129,0);   --  1(1):[???]说: 咱们有缘再见！
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_3(-2,0,1,0,499,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
			instruct_0();   --  0(0)::空语句(清屏)
			addHZ(27)
		end	
        --:Label2
    else
		say("咱们有缘再见！",129,0);   --  1(1):[???]说: 咱们有缘再见！
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
		instruct_3(-2,0,1,0,499,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
		instruct_0();   --  0(0)::空语句(清屏)
	end
end

OEVENTLUA[486] = function() --止水
say("洪帮主，近来可好？")
say("我现在只是个糟老头儿，再*也没半点功夫了。",69)
say("洪帮主不必担心，一灯大师*让晚辈给您带来了疗伤之法。")
say("什么疗伤之法？",69)
say("据一灯大师讲，这是九阴真*经中记载的疗伤圣法，您依*照此法练功，很快就能复原*。")
say("当真？待我练来。",69)
dark()
light()
say("这九阴真经真是一部奇书啊*，我这么重的伤势也能复原*。小兄弟，谢谢你啊。",69)
say("洪帮主何必客气。")
    if GetS(111,0,0,0) == 0 then 
        say("你为老叫花的伤势也是费心了，观你一路作为，也是光明磊落之人，帮老叫花师徒许多。",69)
        say("老叫花传你一门功夫，你可愿学？",69)
        if yesno("是否要学？") then 
	        QZXS("领悟擒龙功！")
	        say("多谢洪老前辈!") 
	        instruct_0();
	        SetS(111, 0, 0, 0,178)
	        addthing(338)
        end
    end
say("我听说你正在寻找十四天书*？",69)
say("是啊，洪老前辈可有线索？")
say("据我所知，《射鵰英雄传》*一书，应该是在重阳真人手*上。",69)
say("可是重阳真人已经仙去了呀*？")
say("此书被全真教视为镇教至宝*，应该会传给下一代掌门。",69)
say("你老人家的意思是，此书现*在丘真人手上？")
say("我也只是猜测。",69)
say("多谢洪前辈指点。<去重阳宫吧>")
    --if PersonKF(0, 141) and GetS(113,0,0,0) == 0 then 
	if GetS(113,0,0,0) == 0 and JY.Person[0]["耍刀技巧"] >= 200 then 
	    say("少侠留步，老叫花见少侠也是用刀之人，这套刀法是无意中得到，现在就赠予少侠。",69) 
	    instruct_0();
	    if instruct_11(0,188) == true then 
	        QZXS("领悟霹雳刀法！")
			say("多谢洪老前辈！",0)
	        instruct_0();
	        setLW1(141)
			addthing(278)
			addthing(299)
		else
			say("也罢，老叫花就不勉强了。",69) 
		end	
	end
JY.Person[60]["声望"] = 104
JY.Person[60]["武功5"] = 104
JY.Person[60]["武功等级5"] = 999
JY.Person[620]["声望"] = 104
JY.Person[620]["武功5"] = 104
JY.Person[620]["武功等级5"] = 999
addevent(-2,0,1,487,1)
addevent(19,0,1,496,1)
end

OEVENTLUA[3503] = function() -- 雪山飞狐玉笔山庄剧情1
	if inteam(1) then
		say("喝个酒就走吧", 0, 1);
		addthing(25)
		for i = 50, 56 do
			null(108,i)
		end
	else	
		dark()
		addevent(-2, 52, 0, 0, 0, 2584*2, 11, 22)
		addevent(-2, 53, 0, 0, 0, 3049*2, 15, 21)
		addevent(-2, 54, 0, 0, 0, 3049*2, 15, 22)
		addevent(-2, 55, 0, 0, 0, 3049*2, 15, 23)
		light()
		say("和尚，你以武力相逼，强迫我们大伙到这山庄来，究竟有何目的？", 177, 1,"陶百岁");
		say("诸位稍安勿躁，我今天请诸位来这里，是要讲一个故事。", 4, 1,"宝树");
		say("这个故事要从这把刀说起……", 4, 1,"宝树");
		say("宝树谈起宝刀的来历，继而，分别由宝树、金面佛大侠苗人凤之女苗若兰、平阿四及陶百岁之口讲述了与此相关的一段武林往事。", 928, 2);
		dark()
		light()
		say("如此这般，苗范田三家子孙，世世代代与胡家为仇，冤冤相报，无一代能得善终。", 4, 1,"宝树");
		say("而这铁盒中的宝刀，便是闯王李自成的遗物。", 4, 1,"宝树");
		dark()
		addevent(-2, 56, 0, 0, 0, 2583*2, 12, 20)
		light()
		say("阁下是何人？", 4, 1,"宝树");
		say("雪山飞狐。", 1, 1,"胡斐");
		say("＜好一个俊朗的青年＞", 571, 1,"苗若兰");
		say("＜听闻雪山飞狐与这山庄庄主有约，在此决斗。我还是暂避其锋的好。＞", 4, 1,"宝树");
		say("诸位长途跋涉，想必也都累了，何不到内室稍作休息？", 4, 1,"宝树");
		dark()
		null(3, 17) ---关闭常规邪线
		null(0, 4)  ---关闭常规正线
		addevent(3, 2, 1, 666, 1) --关闭飞雪前代线
		addevent(3, 3, 1, 666, 1) --关闭飞雪前代线
		for i = 50, 56 do
			null(108,i)
		end
		instruct_3(108, 57, 0, -1, -1, -1, 3504, -2, -2, -2, -2, 9, 15) -- 开启雪山飞狐玉笔山庄剧情2
		light()
	end	
end

OEVENTLUA[3504] = function() -- 雪山飞狐玉笔山庄剧情2
	dark()
	addevent(-2, 58, 0, 0, 0, 2584*2, 9, 10)
	addevent(-2, 59, 0, 0, 0, 3048*2, 9, 13)
	addevent(-2, 60, 0, 0, 0, 3048*2, 10, 13)
	addevent(-2, 61, 0, 0, 0, 3048*2, 11, 13)
	addevent(-2, 62, 0, 0, 0, 4370*2, 12, 13)
	addevent(-2, 63, 0, 0, 0, 4477*2, 12, 10)
	light()
	say("哼，原来这便是闯王军刀的秘密，看来那宝藏就在峰后了。", 4, 1,"宝树");
	say("＜这小妮子是苗人凤之女，又与那雪山飞狐眉来眼去，带她去怕是要坏我大事。＞", 4, 1,"宝树");
	say("宝树上前两步，已在苗若兰颈口“天突”与背心“神通”两穴上各点了一指。苗若兰全身酸软，瘫在椅上，心里又羞又急，却说不出话。", 928, 2);
	say("苗家妹子，坐在这里可不好看，我扶你到厢房休息吧。", 456, 1,"田青文");
	dark()
	null(108,62)
	null(108,63)
	light()
	say("我们走。", 4, 1,"宝树");
	dark()
	for i = 57, 61 do
		null(108,i)
	end
	light()
	say("宝藏？莫非是天书？这可不能错过。不过我还是先去看看苗姑娘怎么样了。", 0, 1);
	instruct_3(108, 64, 0, -1, -1, -1, 3505, -2, -2, -2, -2, 15, 11) -- 开启雪山飞狐玉笔山庄正邪分支
	instruct_3(108, 65, 0, -1, -1, -1, 3505, -2, -2, -2, -2, 16, 11)
end

OEVENTLUA[3505] = function() -- 雪山飞狐玉笔山庄正邪分支
	dark()
	light()
	say("这被中竟睡著一个女子？难道是苗姑娘？", 0, 1);
	say("只见苗若兰向外而卧，脸蛋儿羞得与海棠花一般，烛光映过珠罗纱帐照射进来，更显得眼前枕上，这张脸蛋娇美艳丽，难描难画。", 928, 2);
	say("这……四下无人，苗姑娘被点了穴道，我……", 0, 1);
	if DrawStrBoxYesNo(-1, -1, "要碰苗若兰吗？", C_WHITE, 30) == true then
		say("这大好的机会，此时不上，更待何时？", 0, 1);
		say("公子……", 571, 1,"苗若兰");
		dark()
		addevent(-2, 66, 0, 0, 0, 4692*2, 17, 10)
		light()
		say("苗姑娘！", 1, 1,"胡斐");
		say("小子，你想做什么？", 1, 1,"胡斐");
		dark()
		addevent(-2, 67, 0, 0, 0, 4686*2, 18, 13)
		light()
		say("放开我女儿！", 3, 1,"苗人凤");
		say("看来是跑不掉了，那就开打吧！", 0, 1);
		if WarMain(312) == false then
			instruct_15(0);   
			instruct_0();  
			do return; end			
		end
		say("苗大侠，这淫贼有两下子，你带着令千金先撤，我来断后。", 1, 1,"胡斐");
		dark()
		null(108,66)
		null(108,67)
		null(108,64)
		null(108,65)
		light()
		say("美人没碰着，还差点送了命。我还是去找找宝藏吧。", 0, 1);
		instruct_39(5) -- 开启闯王宝藏洞
		instruct_3(5,8,0,0,0,0,0,0,0,0,0,0,0);   --  开启闯王宝藏铁门
    	instruct_17(5,1,21,21,0);   --  17(11):修改场景贴图:当前场景层1坐标15-15
    	instruct_17(5,1,20,20,3694);   --  17(11):修改场景贴图:当前场景层1坐标14-14
    	instruct_17(5,1,20,21,4064);  --  17(11):修改场景贴图:当前场景层1坐标14-15
		--删除雪人
		for i = 0, 6 do
		null(5,i)
		end
		null(5,14)
		null(5,15)
		instruct_3(5, 20, 0, -1, -1, -1, 3506, -2, -2, -2, -2, 21, 21) -- 开启雪山飞狐邪线闯王宝藏洞剧情
		addevent(5, 21, 0, 0, 0, 2584*2, 18, 16)
		addevent(5, 22, 0, 0, 0, 4369*2, 20, 15)
	else
		say("＜罪过罪过，差点就把持不住。＞", 0, 1);
		say("咦？那边好像有动静，苗姑娘莫慌，我等下便来救你。", 0, 1);
		if JY.Base["人X1"] == 15 then			--两个触发地方的移动方式不一样
			instruct_30(-3,0,0,0);
			instruct_30(0,-3,0,0);
			instruct_30(9,-1,0,0);
		else
			instruct_30(-2,0,0,0);
			instruct_30(0,-3,0,0);
			instruct_30(9,-1,0,0);
		end
		dark()
		addevent(-2, 69, 0, 0, 0, 2983*2, 8, 20)
		addevent(-2, 70, 0, 0, 0, 3049*2, 9, 20)
		light()
		say("嘿嘿，什么金面佛，雪山飞狐，这次我杜希孟要让他们有来无回！", 179, 1,"杜希孟");
		dark()
		null(108,69)
		null(108,70)
		light()
		say("原来他就是玉笔山庄的庄主杜希孟，想不到他已经串通官府，要害胡苗二位大侠，我得尽快通报他们。", 0, 1);
		instruct_30(0,1,0,0);
		instruct_30(-6,0,0,0);
		dark()
		addevent(-2, 68, 0, 0, 0, 2583*2, 17, 10)
		addevent(-2, 67, 0, 0, 0, 4686*2, 18, 13)
		addevent(108, 71, 1, 3507, 1, 4368*2, 14, 11) -- 雪山飞狐正线雪山决斗
		light()
		say("放开我女儿！", 3, 1,"苗人凤");
		say("爹，他是……", 571, 1,"苗若兰");
		say("苗大侠快住手，事情并非你所想的那样。", 0, 1);
		say("兰儿你留在这儿，我和这人有几句话说。", 3, 1,"苗人凤");
		say("兰妹，你爹既这般说，我就过去一会儿，你在这里等著。这个包裹你先替我保管。", 1, 1,"胡斐");
		dark()
		null(108,67)
		null(108,68)
		light()
		null(108,64)
		null(108,65)
	end
end

OEVENTLUA[3506] = function() -- 雪山飞狐邪线闯王宝藏洞剧情
	dark()
	addevent(-2, 23, 0, 0, 0, 3387*2, 20, 23)
	addevent(-2, 24, 0, 0, 0, 3387*2, 21, 23)
	addevent(-2, 25, 0, 0, 0, 3387*2, 22, 23)
	addevent(-2, 26, 0, 0, 0, 3387*2, 23, 23)
	addevent(-2, 27, 0, 0, 0, 2611*2, 20, 25)
	addevent(-2, 28, 0, 0, 0, 2611*2, 21, 25)
	addevent(-2, 29, 0, 0, 0, 2611*2, 22, 25)
	addevent(-2, 30, 0, 0, 0, 2611*2, 23, 25)
	light()
	say("你小子也想分一杯羹？大伙一起上！先干掉他。", 4, 1,"宝树");
	if WarMain(306) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end
	for i = 23, 30 do
		null(5,i)
	end
	say("少侠武艺高强，小人万万不是对手，这宝藏理应归少侠所有。", 4, 1,"宝树");
	say("少侠武功盖世，小女愿意跟随您。", 456, 1,"田青文");
	say("你们倒是会见风使舵，以后就跟着我吧。", 0, 1);
	JY.Person[72]["姓名"] = "田青文"
	JY.Person[72]["性别"] = 1
	JY.Person[72]["半身像"] = 456
	null(5,21)
	--阎基入队
	teammate(4)
	instruct_3(104,57,1,0,947,0,0,2584*2,2584*2,2584*2,-2,-2,-2);   --  3(3):修改事件定义:场景[钓鱼岛]:场景事件编号 [84]
	null(5,22)
	--田归农入队
    teammate(72)
	instruct_3(104,84,1,0,973,0,0,7012,7012,7012,-2,-2,-2);   --  3(3):修改事件定义:场景[钓鱼岛]:场景事件编号 [84]
	null(5,20)
end

OEVENTLUA[3507] = function() -- 雪山飞狐正线雪山决斗
	say("苗若兰缓缓打开包裹，里面是是几件婴儿衣衫，一双婴儿鞋子，还有一块黄布包袱，包上绣著“打遍天下无敌手”七个黑字。", 928, 2);
	say("这……少侠，爹嫉恶如仇，胡大哥又不善言辞。我担心他们发生什么误会，我们快跟去看看吧。", 571, 1,"苗若兰");
	say("还是苗姑娘考虑的周全，我们这就走。", 0, 1);
	say("他们刚刚似乎是往那边的山峰上去了。", 0, 1);
	null(108,71)
	for i = 0, 2 do
		null(2,i)
	end
	null(2,3) -- 删除血刀老祖
	addevent(2,50,1,3509,1,4692*2,27,29); --添加胡斐
	addevent(2,51,1,3508,1,4686*2,27,32); --添加苗人凤
	--删除落花流水
	instruct_17(2,1,24,31,0);   --  17(11):修改场景贴图:当前场景层1坐标15-15
	instruct_17(2,1,25,29,0);   --  17(11):修改场景贴图:当前场景层1坐标15-15
    instruct_17(2,1,27,27,0);   --  17(11):修改场景贴图:当前场景层1坐标14-14
    instruct_17(2,1,30,34,0);  --  17(11):修改场景贴图:当前场景层1坐标14-15
	transferme(2, 27, 47, 0)
	say("一路上山，转了几个弯，但觉山道愈来愈险，一个失足便会摔得粉身碎骨。奔到后来，山壁间全是凝冰积雪，滑溜异常，竟难有下足之处。", 928, 2);
	instruct_25(27,47,27,30); --镜头移动
    say("且住！你可识得胡一刀么？", 3, 1,"苗人凤");
	say("胡大侠乃前辈英雄，不幸为奸人所害。我若有福气能得他教诲几句，立时死了，也所甘心。", 1, 1,"胡斐");
	say("＜他这几句话说得甚好，单凭这几句话，我就交了他这个朋友。但他却欺辱兰儿，我又怎能留他？＞", 3, 1,"苗人凤");
	say("接招！", 3, 1,"苗人凤");
	--自定义战斗
	SetS(106, 63, 1, 0, 1)
   	SetS(106, 63, 2, 0, 3)
	JY.Person[1]["实战"]=500
	JY.Person[1]["攻击力"]=999
	JY.Person[1]["防御力"]=999
	JY.Person[1]["轻功"]=999 
	JY.Person[1]["生命最大值"] = 2000
	JY.Person[1]["生命"] = 2000
    JY.Person[1]["内力最大值"] = 10000
	JY.Person[1]["内力"] = 10000
	JY.Person[1]["武功1"] = 67
	JY.Person[1]["武功等级1"] = 999
	if WarMain(288) == false then
    	instruct_0();   --  0(0)::空语句(清屏)
	else
		addHZ(3)
    	instruct_0();   --  0(0)::空语句(清屏)
	end
	say("苗人凤就要使出一招“提撩剑白鹤舒翅”。这招剑掌齐施，要逼得对方非跌下岩去不可，只是他自幼习惯使然，出招之前不禁背脊微微一耸。", 928, 2);
	say("其时月明如洗，长空一碧，月光将山壁映得一片光亮。那山壁上全是晶光的凝冰，犹似镜子一般，将苗人凤背心反照出来。", 928, 2);
	say("＜平四叔曾说，父亲当年与他比武时，母亲在他背后咳嗽示意，已知他下一步非出“提撩剑白鹤舒翅”不可，我若用一招“八方藏刀式”，便可抢了先著，将他劈下岩去。＞", 1, 1,"胡斐");
	say("＜但我曾答应过兰儿，决不能伤她父亲。然而若不劈他，容他将一招使全了，我便非死不可。＞", 1, 1,"胡斐");
	say("霎时之间，胡斐心中转过了千百个念头。", 928, 2);
	if DrawStrBoxYesNo(-1, -1, "这一刀到底劈下去还是不劈？", C_WHITE, 30) == true then
		if hasthing (298) then
			say(JY.Person[zj()]["姓名"].."掷出两根绣花针。针如闪电般划过长空，竟同时击落了胡斐与苗人凤手中的武器。", 928, 2);
			instruct_25(27,30,27,47);
			instruct_30(0,13,0,0);
			say("且慢！", 0, 1);
			say("爹！胡大哥！", 571, 1,"苗若兰");
			say("苗若兰将事情原委向两人诉说。", 928, 2);
			addevent(24,8,1,3510,1,2608*2);
			transferme(24, 18, 23, 2)
			null(2,50)
			null(2,51)
		else
			say("八方藏刀式！你是胡斐贤侄！", 3, 1,"苗人凤");
			say("然而已经太迟了……", 928, 2);
			dark()
			null(2,51)
			light()
			instruct_25(27,30,27,47);
		end
	else
		if hasthing (298) then
			say(JY.Person[zj()]["姓名"].."掷出两根绣花针。针如闪电般划过长空，竟同时击落了胡斐与苗人凤手中的武器。", 928, 2);
			instruct_25(27,30,27,47);
			instruct_30(0,13,0,0);
			say("且慢！", 0, 1);
			say("爹！胡大哥！", 571, 1,"苗若兰");
			say("苗若兰将事情原委向两人诉说。", 928, 2);
			addevent(24,8,1,3510,1,2608*2);
			transferme(24, 18, 23, 2)
			null(2,50)
			null(2,51)
		else
			say("啊！", 1, 1,"胡斐");
			dark()
			null(2,50)
			light()
			instruct_25(27,30,27,47);
		end
	end
end

OEVENTLUA[3508] = function() -- 胡斐挂
	say("爹……", 571, 1,"苗若兰");
	say("我一生嫉恶如仇，却不想铸下如此大错。现在纵使一死，又有何脸面去面对泉下的胡兄？", 3, 1,"苗人凤");
	dark()
	null(2,51)
	light()
	say("哎，世事难尽如人意。我还是继续寻找天书吧。", 0, 1);
	instruct_39(5) -- 开启闯王宝藏洞
	instruct_3(5,8,0,0,0,0,0,0,0,0,0,0,0);   --  开启闯王宝藏铁门
    instruct_17(5,1,21,21,0);   --  17(11):修改场景贴图:当前场景层1坐标15-15
    instruct_17(5,1,20,20,3694);   --  17(11):修改场景贴图:当前场景层1坐标14-14
    instruct_17(5,1,20,21,4064);  --  17(11):修改场景贴图:当前场景层1坐标14-15
	--删除雪人
	for i = 0, 6 do
	null(5,i)
	end
	null(5,14)
	null(5,15)
	instruct_3(5, 20, 0, -1, -1, -1, 3511, -2, -2, -2, -2, 21, 21) -- 开启雪山飞狐正线闯王宝藏洞最终战
end

OEVENTLUA[3509] = function() -- 苗人凤挂
	say("胡大哥……", 571, 1,"苗若兰");
	say("若兰，我言而无信，不配再见你，从此天地间再没有胡斐这个人。", 1, 1,"胡斐");
	dark()
	null(2,50)
	light()
	say("哎，世事难尽如人意。我还是继续寻找天书吧。", 0, 1);
	instruct_39(5) -- 开启闯王宝藏洞
	instruct_3(5,8,0,0,0,0,0,0,0,0,0,0,0);   --  开启闯王宝藏铁门
    instruct_17(5,1,21,21,0);   --  17(11):修改场景贴图:当前场景层1坐标15-15
    instruct_17(5,1,20,20,3694);   --  17(11):修改场景贴图:当前场景层1坐标14-14
    instruct_17(5,1,20,21,4064);  --  17(11):修改场景贴图:当前场景层1坐标14-15
	--删除雪人
	for i = 0, 6 do
	null(5,i)
	end
	null(5,14)
	null(5,15)
	instruct_3(5, 20, 0, -1, -1, -1, 3511, -2, -2, -2, -2, 21, 21) -- 开启雪山飞狐正线闯王宝藏洞最终战
end

OEVENTLUA[3510] = function() -- 和解
	say("想不到雪山飞狐便是故人之子。贤侄英武不下胡兄当年，胡兄泉下有知，也当感欣慰了。", 3, 1,"苗人凤");
	say("这些年来我一直深感愧对胡兄，今次多亏了这位小兄弟相助，才没有铸成大错，也解开了我多年的心结。", 3, 1,"苗人凤");
	say("苗大侠客气了，这是我辈中人应尽之事。", 0, 1);
	say("贤侄，兰儿，听说小兄弟在寻找天书，你们去帮帮他吧。", 3, 1,"苗人凤");
	JY.Person[1]["携带物品1"] = -1 --取消胡斐自带的闯王军刀
	JY.Person[1]["携带物品数量1"] = 0
	teammate(1)
	instruct_3(104,40,1,0,945,0,0,7222,7222,7222,-2,-2,-2);   --  3(3):修改事件定义:场景[钓鱼岛]:场景事件编号 [84]
	null(24,8)
	instruct_39(5) -- 开启闯王宝藏洞
	instruct_3(5,8,0,0,0,0,0,0,0,0,0,0,0);   --  开启闯王宝藏铁门
    instruct_17(5,1,21,21,0);   --  17(11):修改场景贴图:当前场景层1坐标15-15
    instruct_17(5,1,20,20,3694);   --  17(11):修改场景贴图:当前场景层1坐标14-14
    instruct_17(5,1,20,21,4064);  --  17(11):修改场景贴图:当前场景层1坐标14-15
	--删除雪人
	for i = 0, 6 do
	null(5,i)
	end
	null(5,14)
	null(5,15)
	instruct_3(5, 20, 0, -1, -1, -1, 3511, -2, -2, -2, -2, 21, 21) -- 开启雪山飞狐正线闯王宝藏洞最终战
end

OEVENTLUA[3511] = function() -- 雪山飞狐正线最终战
	dark()
	addevent(5, 21, 0, 0, 0, 2584*2, 18, 16)
	addevent(5, 22, 0, 0, 0, 3627*2, 20, 16)
	light()
	say("大人请看，这里就是昔年闯王李自成留下的宝藏了。", 4, 1,"宝树");
	say("……", 454, 1,"真田幸村");
	say("宝树！想不到你居然通敌卖国！", 0, 1);
	say("！！！", 454, 1,"真田幸村");
	if WarMain(128) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end
	addthing()
	null(5,20)
	null(5,21)
	null(5,22)
end



OEVENTLUA[3512] = function() -- 神雕线，初遇杨过
	null(22,0) -- 删除断肠草
	JY.Person[58]["携带物品1"] = -1 --初始化杨过
	JY.Person[58]["携带物品数量1"] = 0
	JY.Person[58]["携带物品2"] = -1
	JY.Person[58]["携带物品数量2"] = 0
	JY.Person[58]["携带物品3"] = -1
	JY.Person[58]["携带物品数量3"] = 0
	JY.Person[58]["武功1"] = -1
    JY.Person[58]["武功等级1"] = 0
	JY.Person[58]["武功2"] = -1
    JY.Person[58]["武功等级2"] = 0
	JY.Person[58]["武功3"] = -1
    JY.Person[58]["武功等级3"] = 0
	JY.Person[58]["武功4"] = -1
    JY.Person[58]["武功等级4"] = 0
	JY.Person[58]["半身像"] = 41
	JY.Person[58]["资质"] = 90
	JY.Person[58]["拳掌功夫"] = 30
	JY.Person[58]["御剑能力"] = 30
	JY.Person[58]["耍刀技巧"] = 30
	JY.Person[58]["特殊兵器"] = 30
	JY.Person[58]["暗器技巧"] = 30
	JY.Person[58]["等级"] = 5
	JY.Person[58]["实战"] = 0
	JY.Person[58]["攻击力"]=30
    JY.Person[58]["防御力"]=30
	JY.Person[58]["轻功"]=30
	JoinMP(58, 0, 0)
	say("面前这名少年衣衫褴褛，左手提著一只公鸡，口中唱著俚曲，脸上贼忒嘻嘻。", 928, 2);
	say("大美人和小美人都走了。大美人留下的这些银针倒是有趣。", 41, 1,"？？");
	say("这名少年俯身拾起一枚银针，去拨弄了几下地上的蚂蚁，那几只蚂蚁兜了几个圈子，便即翻身僵毙，连试几只小虫都是如此。", 928, 2);
	say("不好，针上有毒！", 41, 1,"？？");
	dark()
	null(32,30)
	addevent(32, 31, 0, 0, 0, 3552*2, 31, 29)
	addevent(32, 32, 0, 0, 0, 4624*2, 32, 30)
	light()
	say("小娃娃，知道厉害了罢？", 60, 1,"欧阳锋");
	say("你……你是谁？", 41, 1,"？？");
	say("我……我是谁？我知道我是谁就好啦。", 60, 1,"欧阳锋");
	say("求老公公救我性命。你本事这么大，一定可以救我。", 41, 1,"？？");
	say("好，救你不难，但你须得答应我一件事。", 60, 1,"欧阳锋");
	say("＜那人不就是西毒欧阳锋吗？他看起来有些不正常，不知道他要让这孩子做什么？＞", 0, 1);
	if DrawStrBoxYesNo(-1, -1, "是否出手干预？", C_WHITE, 30) == true then
		say("住手！", 0, 1);
		SetS(106, 63, 1, 0, 0)
   		SetS(106, 63, 2, 0, 60)
		if WarMain(288) == false then
			instruct_15(0);   
			instruct_0();  
			do return; end			
		end
		addHZ(34)
		null(32,31)
		say("小兄弟，毒我帮你解，那个人不是好人。", 0, 1);
		say("空中忽然几声雕唳，两头大雕在半空飞掠而过。柳树林后转出一男一女，来到近前，双雕分别停在二人肩头。", 928, 2);
		dark()
		null(32, 32)
		addevent(32, 33, 0, 0, 0, 4001*2, 31, 29)	
		addevent(32, 34, 0, 0, 0, 4002*2, 33, 29)
		addevent(32, 35, 0, 0, 0, 4625*2, 32, 30)
		light()
		say("你们是谁？", 41, 1,"？？");
		say("你姓杨名过，你妈妈姓穆，是不是？", 56, 1,"黄蓉");
		say("那少年正是姓杨名过，突然被黄蓉说了出来，不由得惊骇无比，胸间气血上涌，手上毒气突然回冲，脑中一阵胡涂，登时晕了过去。", 928, 2);
		say("他……他原来是杨康兄弟的孩子。", 55, 1,"郭靖");
		say("咱们先投客店，到城里配几味药，再带他回桃花岛。", 56, 1,"黄蓉");
		dark()
		null(32, 33)
		null(32, 34)
		null(32, 35)
		light()
		say("桃花岛……我改天有时间过去看看杨过小兄弟吧。", 0, 1);
		null(7,6) -- 取消神雕洞杨过
		null(75,30) -- 取消桃花岛老顽童
		addevent(75, 60, 1, 3513, 1, 3044*2, 25, 12) -- 桃花岛增加郭靖
		addevent(75, 61, 1, 3514, 1, 3045*2, 27, 12) -- 桃花岛增加黄蓉
		addevent(75, 62, 1, 3517, 1, 3588*2, 18, 27) -- 桃花岛增加大武
		addevent(75, 63, 1, 3518, 1, 3589*2, 18, 26) -- 桃花岛增加小武
		addevent(75, 64, 1, 3516, 1, 4627*2, 19, 24) -- 桃花岛增加郭芙
		addevent(75, 65, 1, 3525, 1, 4624*2, 21, 26) -- 桃花岛增加杨过
		addevent(75, 66, 1, 3519, 1, 4106*2, 31, 22) -- 桃花岛增加柯镇恶
	else
		say("＜各人自有各人的因缘，我还是不要插手了。＞", 0, 1);
		say("公公，我答应你，你不论说什么，我都听你的。", 41, 1,"？？");
		say("你别叫我公公，要叫爸爸！", 60, 1,"欧阳锋");
		say("＜我自出生就没有爸爸，现在妈妈也死了。这人虽然举止怪异，疯疯癫癫，但他若真肯救我，叫他声爸爸又有何妨？＞", 41, 1,"？？");
		say("爸爸！", 41, 1,"？？");
		say("乖儿子，来，爸爸这就教你解毒之法。", 60, 1,"欧阳锋");
		JY.Person[58]["武功1"] = 95
		JY.Person[58]["武功等级1"] = 999
		JY.Person[58]["声望"] = 95
		QZXS("？？学会蛤蟆功！")
		say("空中忽然几声雕唳，两头大雕在半空飞掠而过。欧阳锋向双雕呆望，以手击额，皱眉苦苦思索，突然间似乎想起了什么，登时脸色大变。", 928, 2);
		say("不……我不要见他们。", 60, 1,"欧阳锋");
		dark()
		null(32, 31)
		null(32, 32)
		addevent(32, 33, 0, 0, 0, 4001*2, 31, 29)	
		addevent(32, 34, 0, 0, 0, 4002*2, 33, 29)
		addevent(32, 35, 0, 0, 0, 4625*2, 32, 30)
		light()
		say("爸爸，你去哪儿？", 41, 1,"？？");
		say("你姓杨名过，你妈妈姓穆，是不是？", 56, 1,"黄蓉");
		say("那少年正是姓杨名过，突然被黄蓉说了出来，不由得惊骇无比，胸间气血上涌，手上毒气突然回冲，脑中一阵胡涂，登时晕了过去。", 928, 2);
		say("他……他原来是杨康兄弟的孩子。", 55, 1,"郭靖");
		say("咱们先投客店，到城里配几味药，再带他回桃花岛。", 56, 1,"黄蓉");
		dark()
		null(32, 33)
		null(32, 34)
		null(32, 35)
		light()
		say("桃花岛……我改天有时间过去看看杨过小兄弟吧。", 0, 1);
		null(7,6) -- 取消神雕洞杨过
		null(75,30) -- 取消桃花岛老顽童
		addevent(75, 60, 1, 3513, 1, 3044*2, 25, 12) -- 桃花岛增加郭靖
		addevent(75, 61, 1, 3514, 1, 3045*2, 27, 12) -- 桃花岛增加黄蓉
		addevent(75, 62, 1, 3517, 1, 3588*2, 18, 27) -- 桃花岛增加大武
		addevent(75, 63, 1, 3518, 1, 3589*2, 18, 26) -- 桃花岛增加小武
		addevent(75, 64, 1, 3524, 1, 4627*2, 19, 24) -- 桃花岛增加郭芙
		addevent(75, 65, 1, 3515, 1, 4624*2, 21, 26) -- 桃花岛增加杨过
		addevent(75, 66, 1, 3519, 1, 4106*2, 31, 22) -- 桃花岛增加柯镇恶
	end
end

OEVENTLUA[3513] = function() -- 神雕线，桃花岛郭靖
	say("郭大侠好。", 0, 1);
	say("少侠是来看望过儿的？他就在外面。", 55, 1,"郭靖");
end

OEVENTLUA[3514] = function() -- 神雕线，桃花岛黄蓉
	say("黄女侠好。", 0, 1);
	say("少侠是来看望过儿的？他就在外面。", 56, 1,"黄蓉");
end

OEVENTLUA[3515] = function() -- 神雕线，桃花岛杨过，会蛤蟆功
	say("小兄弟，你在这里还习惯吗？", 0, 1);
	say("他们都当我是外人，都欺负我，我要去找爸爸。", 41, 1,"杨过");
end

OEVENTLUA[3517] = function() -- 神雕线，桃花岛大武
	say("我叫武敦儒。", 700, 1,"武敦儒");
end

OEVENTLUA[3518] = function() -- 神雕线，桃花岛小武
	say("我叫武修文。", 700, 1,"武修文");
end

OEVENTLUA[3519] = function() -- 神雕线，桃花岛柯镇恶
	say("……", 130, 1,"柯镇恶");
end

OEVENTLUA[3516] = function() -- 神雕线，杨过不会蛤蟆功，挨打事件
	say("大武小武，打他！用力打！", 569, 1,"郭芙");
	say("武氏兄弟武功本有根柢，杨过先前就已抵敌不过，再加上郭靖这几个月来的教导，他如何再是敌手？厮打片刻，头脸腰背已连中七八下拳脚。", 928, 2);
	dark()
	null(75,65)
	addevent(75, 66, 1, 0, 1, 2577*2, 21, 26)
	light()
	say("住手！", 0, 1);
	dark()
	null(75,60)
	null(75,61)
	addevent(75, 67, 1, 0, 1, 4001*2, 18, 22)
	addevent(75, 68, 1, 0, 1, 4002*2, 20, 22)
	addevent(75, 69, 1, 0, 1, 3993*2, 19, 29)
	light()
	say("怎么回事？", 55, 1,"郭靖");
	say("芙儿？你伤到没有？", 56, 1,"黄蓉");
	say("以后不可再动手。", 55, 1,"郭靖");
	dark()
	null(75,62)
	null(75,63)
	null(75,64)
	null(75,67)
	null(75,68)
	null(75,69)
	null(75,66)
	addevent(75, 70, 1, 3520, 1, 4623*2, 21, 26)
	light()
end

OEVENTLUA[3520] = function() -- 神雕线，杨过不会蛤蟆功，挨打事件2
	say("小兄弟，你怎么不还手？", 0, 1);
	say("黄伯母只教我读书，《论语》读完又教《孟子》，却从不教我武功。", 41, 1,"杨过");
	say("哪有这样的道理？也罢，我便传你两招，以后起码可做防身之用。", 0, 1);
	JY.Person[58]["武功1"] = 90
	JY.Person[58]["武功等级1"] = 999
	JY.Person[58]["声望"] = 90
	QZXS("杨过学会混元功！")
	say("谢谢大哥。", 41, 1,"杨过");
	dark()
	null(75,70)
	light()
	say("郭小姐刁蛮任性，这位杨过小兄弟住在这，免不了遭欺负。我过段时间再来看他吧。", 0, 1);
	addevent(75, 70, 0, 3521, 3, 0, 28, 56)
end

OEVENTLUA[3521] = function() -- 神雕线，杨过不会蛤蟆功，挨打事件3
	addevent(75, 71, 1, 3522, 1, 3044*2, 25, 12) -- 桃花岛增加郭靖
	addevent(75, 72, 1, 3523, 1, 3045*2, 27, 12) -- 桃花岛增加黄蓉
end

OEVENTLUA[3522] = function() -- 神雕线，桃花岛郭靖
	say("郭大侠好。", 0, 1);
	say("少侠是来看望过儿的？他已经去终南山重阳宫学艺了。", 55, 1,"郭靖");
	say("＜重阳宫？过儿生性顽皮，重阳宫那等清修之所，他能适应吗？＞", 0, 1);
	dark()
	addevent(19, 50, 0, 3528, 3, 0, 32, 49)
	light()
end

OEVENTLUA[3523] = function() -- 神雕线，桃花岛黄蓉
	say("黄女侠好。", 0, 1);
	say("少侠是来看望过儿的？他已经去终南山重阳宫学艺了。", 56, 1,"黄蓉");
	say("＜重阳宫？过儿生性顽皮，重阳宫那等清修之所，他能适应吗？＞", 0, 1);
end

OEVENTLUA[3524] = function() -- 神雕线，杨过会蛤蟆功，反击事件
	say("大武小武，打他！用力打！", 569, 1,"郭芙");
	say("武氏兄弟武功本有根柢，杨过先前就已抵敌不过，再加上郭靖这几个月来的教导，他如何再是敌手？厮打片刻，头脸腰背已连中七八下拳脚。", 928, 2);
	say("武敦儒双手按住他头，问道：“你服了没有？”杨过怒道：“谁服你这疯狗？”武敦儒大怒，将他脸孔向沙地上直按下去。", 928, 2);
	say("杨过眼睛口鼻中全是沙粒，登时无法呼吸，又过片刻，全身如欲爆裂。武敦儒双手用力按住他头，武修文骑在他头颈之中，杨过始终挣扎不脱。", 928, 2);
	say("窒闷难当之际，这些日子来所练欧阳锋传授的内力突然崩涌，只觉丹田中一股热气激升而上，不知不觉间便使出了蛤蟆功，击向武氏兄弟。", 928, 2);
	dark()
	null(75,62)
	null(75,63)
	addevent(75, 73, 1, 0, 1, 2577*2, 18, 26)
	addevent(75, 74, 1, 0, 1, 2577*2, 18, 27)
	null(75,60)
	null(75,61)
	addevent(75, 67, 1, 0, 1, 4001*2, 18, 22)
	addevent(75, 68, 1, 0, 1, 4002*2, 20, 22)
	addevent(75, 69, 1, 0, 1, 3993*2, 19, 29)
	light()
	say("怎么回事？", 55, 1,"郭靖");
	say("欧阳锋呢？他在哪里？", 56, 1,"黄蓉");
	say("快说！欧阳锋在哪里？", 56, 1,"黄蓉");
	say("欧阳锋这奸贼在哪里？你不说，一杖就打死了你！", 130, 1,"柯镇恶");
	say("他不是奸贼！他是好人。你有种就打死我，我怕你这老瞎子吗？", 41, 1,"杨过");
	say("郭靖纵身上前，重重打了杨过一个耳光。", 928, 2);
	say("你胆敢对师祖爷爷无礼！", 55, 1,"郭靖");
	say("你们也不用动手，要我性命，我自己死好了！", 41, 1,"杨过");
	dark()
	null(75,73)
	null(75,74)
	null(75,64)
	null(75,67)
	null(75,68)
	null(75,69)
	null(75,66)
	null(75,65)
	light()
	say("想不到事情竟发展成如此局面，我过段时间再来看看吧。", 0, 1);
	addevent(75, 70, 0, 3526, 3, 0, 28, 56)
end

OEVENTLUA[3525] = function() -- 神雕线，桃花岛杨过，不会蛤蟆功
	say("小兄弟，你在这里还习惯吗？", 0, 1);
	say("他们都当我是外人，都欺负我。", 41, 1,"杨过");
end

OEVENTLUA[3526] = function() --神雕线，杨过会蛤蟆功，反击事件2
	addevent(75, 71, 1, 0, 1, 3044*2, 25, 12) -- 桃花岛增加郭靖
	addevent(75, 72, 1, 0, 1, 3045*2, 27, 12) -- 桃花岛增加黄蓉
	addevent(75, 75, 1, 0, 1, 4625*2, 25, 14) -- 桃花岛增加杨过
	addevent(75, 76, 0, 3527, 3, 0, 26, 20) -- 
	addevent(75, 77, 0, 3527, 3, 0, 28, 20) -- 
end

OEVENTLUA[3527] = function() --神雕线，杨过会蛤蟆功，反击事件3
	say("过儿，过去的事，大家也不提了。你对师祖爷爷无礼，不能再在我的门下，以后你只叫我郭伯伯便是。", 55, 1,"郭靖");
	say("你郭伯伯不善教诲，只怕反耽误了你。过几天我送你去终南山重阳宫，求全真教长春子丘真人收你入门。全真派武功是武学正宗，你好好在重阳宫中用功，修心养性，盼你日后做个正人君子。", 55, 1,"郭靖");
	say("是，郭伯伯。", 41, 1,"杨过");
	dark()
	null(75,70)
	null(75,71)
	null(75,72)
	null(75,75)
	null(75,76)
	null(75,77)
	light()
	say("＜重阳宫？过儿生性顽皮，重阳宫那等清修之所，他能适应吗？＞", 0, 1);
	addevent(19, 50, 0, 3528, 3, 0, 32, 49)
end

OEVENTLUA[3528] = function() --神雕线，杨过逃出重阳宫
	null(75,71)
	null(75,72)
	dark()
	addevent(19, 51, 0, 0, 0, 4551*2, 25, 34)--鹿清笃
	addevent(19, 52, 0, 0, 0, 4625*2, 25, 39)--杨过
	addevent(19, 53, 0, 0, 0, 3053*2, 22, 33)--观众
	addevent(19, 54, 0, 0, 0, 3053*2, 22, 34)--
	addevent(19, 55, 0, 0, 0, 3053*2, 22, 35)--
	addevent(19, 56, 0, 0, 0, 3053*2, 22, 36)--
	addevent(19, 57, 0, 0, 0, 3053*2, 22, 37)--
	addevent(19, 58, 0, 0, 0, 3053*2, 22, 38)--
	addevent(19, 59, 0, 0, 0, 3053*2, 22, 39)--
	addevent(19, 60, 0, 0, 0, 3053*2, 22, 40)--
	light()
	instruct_30(0,12,0,0);
	instruct_30(3,0,0,0);
	say("＜我倒要看看这杨过小子到底会不会功夫。＞", 68, 1,"崔志方");
	say("清笃，你与杨师弟过过招，下手有分寸些，别太重了！", 68, 1,"崔志方");
	say("＜这小子首日上山，便使诈令我险些烧死，此后我受尽师兄弟的讥笑，说我本事还不及一个小小孩儿。今天我便要他好看！＞", 180, 1,"鹿清笃");
	say("遵命！", 180, 1,"鹿清笃");
	say("鹿清笃右掌打出，这一掌“虎门手”劲力不小，砰的一响，正中杨过胸口。若非杨过已有内功护体，非当场口喷鲜血不可。", 928, 2);
	say("鹿清笃见一掌打杨过不倒，接连又出数拳，杨过被殴得昏天黑地，摇摇幌幌的就要跌倒，不知怎地，忽然间一股热气从丹田中直冲上来。", 928, 2);
	say("这时鹿清笃一拳又向杨过面门击至，闪无可闪，避无可避，杨过自然而然的双腿一弯，口中阁的一声叫喝，手掌推出，正中鹿清笃小腹。", 928, 2);
	dark()
	null(19,51)
	addevent(19, 61, 0, 0, 0, 2720*2, 25, 34)--鹿清笃倒地
	light()
	say("杨过！你学的这是什么妖法！", 406, 1,"赵志敬");
	say("杨过心知已闯下了大祸，昏乱中不及细想，掌下撒腿便奔。赵志敬立传号令，命众人分头追拿杨过。", 928, 2);
	dark()
	null(19,52)
	light()
	say("且慢！", 0, 1);
	if WarMain(73) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end
	say("阁下是何人？竟敢来管我全真教的闲事？", 406, 1,"赵志敬");
	say("不敢，只是这位杨过小兄弟与我曾有几面之缘，这次他自知闯祸，定然不敢回来见你们，不如由我去将他寻回，再来给诸位一个交代。", 0, 1);
	say("哼，那就有劳了。", 406, 1,"赵志敬");
	say("＜不知杨过跑去了哪里，我先在这附近找一找吧。＞", 0, 1);
	dark()
	for i = 52, 61 do
		null(19,i)
	end
	null(19,50)
	addevent(18, 20, 1, 3529, 1, 4622*2, 23, 31) --古墓杨过
	addevent(18, 21, 1, 3530, 1, 3621*2, 23, 30) --古墓龙女
	addevent(18, 22, 1, 3531, 1, 3565*2, 25, 27) --古墓孙婆婆
	light()
end

OEVENTLUA[3529] = function()--古墓杨过
	say("大哥！你来了，我在树林中昏倒，是这位老婆婆救了我。", 41, 1,"杨过");
end

OEVENTLUA[3530] = function()--古墓龙女
	say("……", 59, 1,"小龙女");
	say("眼前的少女披著一袭轻纱般的白衣，犹似身在烟中雾里，看来约莫十六七岁年纪，除了一头黑发之外，全身雪白，面容秀美绝俗。", 928, 2);
	say("＜好一个清丽脱俗的女子！＞", 0, 1);
end

OEVENTLUA[3531] = function()--古墓孙婆婆
	say("姑娘，这孩子若是回到重阳宫中，他师父定要难为他。", 117, 1,"孙婆婆");
	say("你送他回去，跟他师父说说，教他别难为孩子。", 59, 1,"小龙女");
	say("唉，旁人教门中的事，咱们也管不著。", 117, 1,"孙婆婆");
	say("你送一瓶玉蜂蜜浆去，再跟他说，那老道不能不依。", 59, 1,"小龙女");
	say("杨过霍地站起，向二人作了一揖。", 928, 2);
	say("多谢婆婆和姑姑医伤，我这便走。", 41, 1,"杨过");
	say("孩子，非是我们姑娘不肯留你过宿，实是此处向有严规，不容旁人入来，你别难过。", 117, 1,"孙婆婆");
	say("婆婆说哪里话来？咱们后会有期了。", 41, 1,"杨过");
	say("孙婆婆叹了口气，她知小龙女自来执拗，多说也是无用，只是望著杨过，目光中甚有怜惜之意。", 928, 2);
	say("你不认得路，我带你出去。", 117, 1,"孙婆婆");
	if JY.Person[58]["武功1"] == 90 then
		say("这样吧，我与二位同去。", 0, 1);
		say("也好。", 59, 1,"小龙女");
		null(109,0)
		null(109,1)
		transferme(109, 41, 31, 2)
		instruct_30(4,0,0,0);
		for i = 20, 22 do
			null(18,i)
		end
		say("三人出了墓门，穿过丛林，来到林前空地。月光下只见六七名道人一排站著。群道见到杨过，轻声低语，不约而同的走上了几步。", 928, 2);
		dark()
		addevent(109, 30, 0, 0, 0, 3053*2, 34, 28)
		addevent(109, 31, 0, 0, 0, 3053*2, 34, 29)
		addevent(109, 32, 0, 0, 0, 3053*2, 34, 30)
		addevent(109, 33, 0, 0, 0, 3053*2, 34, 31)
		addevent(109, 34, 0, 0, 0, 3053*2, 34, 32)
		addevent(109, 35, 0, 0, 0, 3053*2, 34, 33)
		addevent(109, 36, 0, 0, 0, 4624*2, 37, 32)--杨过
		addevent(109, 37, 0, 0, 0, 3565*2, 36, 29)--孙婆婆
		light()
		say("全真门下弟子甄志丙，奉师命拜见龙姑娘。", 204, 1,"甄志丙");
		say("我在这里，要杀要剐，全凭你们就是。", 41, 1,"杨过");
		say("群道人料不到他小小一个孩儿居然这般刚硬，都是出乎意料之外。一个道人抢将上来，伸手抓住杨过後领拖了过去。", 928, 2);
		say("我又不逃，你急什么？", 41, 1,"杨过");
		say("这道人是赵志敬的大弟子，心想做徒弟的居然会对师父如此忤逆，实是无法无天之至，听杨过出言冲撞，顺手在他头上就是一拳。", 928, 2);
		say("孙婆婆本欲与群道好言相说，眼见杨过被人强行拖去，已是大为不忍，突然见他被殴，心头怒火哪里还按捺得下？", 928, 2);
		say("立时大踏步上前，衣袖一抖，拂在那道人手上。那人只觉手腕上热辣辣的一阵剧痛，不由得松手，待要喝问，孙婆婆已将杨过抱起，转身而行。", 928, 2);
		say("放人下来！", 700, 1,"群道");
		say("你们要怎地？", 117, 1,"孙婆婆");
		say("大家散开，不得在前辈面前无礼。", 204, 1,"甄志丙");
		say("弟子甄志丙拜见前辈。", 204, 1,"甄志丙");
		say("干什么？", 117, 1,"孙婆婆");
		say("这孩子是我全真教的弟子，请前辈赐还。", 204, 1,"甄志丙");
		say("你们当我之面，已将他这般毒打，待得拉回道观之中，更不知要如何折磨他。要我放回，万万不能！", 117, 1,"孙婆婆");
		say("这孩子顽劣无比，欺师灭祖，大壤门规。武林中人讲究的是敬重师长，敝教责罚于他，想来也是应该的。", 204, 1,"甄志丙");
		say("什么欺师灭祖，全是一面之词。", 117, 1,"孙婆婆");
		say("孩子跟这胖道士比武，是你们全真教自己定下的规矩。他本来不肯比，给你们硬逼著下场。既然动手，自然有输有赢，这胖道人自己不中用，又怪得谁了？", 117, 1,"孙婆婆");
		say("这是我的弟子，爱打爱骂，全凭于我。不许师父管弟子，武林中可有这等规矩？", 406, 1,"赵志敬");
		say("我偏不许你管教，那便怎么？", 117, 1,"孙婆婆");
		say("这孩子是你什么人？你凭什么来横加插手？", 406, 1,"赵志敬");
		say("他早不是你全真教的门人啦。这孩子已改拜我家小龙女姑娘为师，他好与不好，天下只小龙女姑娘一人管得。你们乘早别来多管闲事。", 117, 1,"孙婆婆");
		say("杨过，此事当真？", 406, 1,"赵志敬");
		say("臭道士，贼头狗脑的山羊胡子牛鼻子，你这般打我，我为什么还认你为师？不错，我已拜了孙婆婆为师，又拜了龙姑姑为师啦。", 41, 1,"杨过");
		say("赵志敬气得胸口几欲炸裂，飞身而起，双手往杨过肩头抓去。孙婆婆右臂格出，碰向赵志敬手腕。", 928, 2);
		say("得罪！", 204, 1,"甄志丙");
		if WarMain(73) == false then
			instruct_15(0);   
			instruct_0();  
			do return; end			
		end
		for i = 30, 35 do
			null(109,i)
		end
		say("婆婆，你没事吧？", 41, 1,"杨过");
		say("好孩子，我没事。我们这就回古墓，我定会说服小龙女姑娘收留了你。", 117, 1,"孙婆婆");
		dark()
		null(109,36)
		null(109,37)
		light()
		say("＜这婆婆相貌虽丑，心肠倒是很好。但愿杨过小兄弟这次能平安。＞", 0, 1);
		addevent(18, 23, 1, 3533, 1, 2644*2, 14, 20)--古墓孙婆婆
		addevent(18, 24, 1, 3534, 1, 4623*2, 15, 16)--古墓杨过
		addevent(18, 25, 1, 3535, 1, 3034*2, 16, 16)--古墓小龙女
	else
		say("＜这样也好，我先回去吧。＞", 0, 1);
		transferme(70, 8, 28, 1)
		for i = 20, 22 do
			null(18,i)
		end
		say("＜数月不见，不知杨过小兄弟在重阳宫过的如何了，我去看看吧。＞", 0, 1);
		addevent(19, 62, 1, 3532, 1, 3054*2, 36, 34)
	end
end

OEVENTLUA[3532] = function()--杨过未回重阳宫
	say("杨过？自从那日他逃下山去，就再没回来过。", 291, 1);
	dark()
	null(19,62)
	addevent(18, 24, 1, 3537, 1, 4623*2, 15, 16)--古墓杨过
	addevent(18, 25, 1, 3538, 1, 3034*2, 16, 16)--古墓小龙女
	light()
	say("＜难道当日发生了什么变故？我还是去古墓再看看。＞", 0, 1);
end

OEVENTLUA[3533] = function()--孙婆婆未死
	say("唉，小龙女姑娘终究是不肯收留这孩子。", 117, 1,"孙婆婆");
	say("少侠，老婆子这一生从没求过人，我看你也是个好心人，能不能请你代为照顾这孩子？", 117, 1,"孙婆婆");
	say("婆婆不必多礼，婆婆所托，晚辈自当尽力。", 0, 1);
	say("那就多谢少侠了。", 117, 1,"孙婆婆");
	dark()
	null(18,24)
	teammate(58)
	null(80,150)
	addevent(80, 150, 1, 3536, 1, 4712*2, 15, 21) -- 华山后山
	light()
	say("＜虽然答应了，但我闯荡江湖，前路漂泊无定，带着个孩子总是不方便，还是得给他找个安身之所才是。＞", 0, 1);
	if XYL(0) then
	say("＜据探路的忍者报道，无悠好像在华山后山出现，那么，这孩子也该和我一刀流有缘，去找找无悠吧。＞", 0, 1);
	say("＜也许看在这么多年的情分，他会答应。＞", 0, 1);
	end
end

OEVENTLUA[3534] = function()
	say("大哥好。", 41, 1,"杨过");
end

OEVENTLUA[3535] = function()
	say("……", 59, 1,"小龙女");
end

OEVENTLUA[3536] = function() -- 杨过入一刀流
	if hasppl(58) then
		addevent(80, 151, 1, 3536, 1, 4624*2, 16, 22) -- 华山后山
		light()
		say("找了一年也没有找到谢云流，这坑爹的风花小雪，我还是回东瀛去吧。", 578, 1,"谢无悠");
		if XYL(0) then
		say("无悠，好久不见。", 0, 1);
		say("可恶的谢云流，你让我找的好苦。", 578, 1,"谢无悠");
		say("吃我一剑。", 578, 1,"谢无悠");
		say("别啊！咱们一见面就刀刃相见，旁边还有孩子，看到了多不好。", 0, 1);
		say("哼，今天暂且饶过你一次。", 578, 1,"谢无悠");
		say("今天怎么特地来找我呢？", 578, 1,"谢无悠");
		say("是这样的，我在中原碰到了这个孩子。", 0, 1);
		dark()
		say("好吧，大概事情我也知道了", 578, 1,"谢无悠");
		say("这孩子也和我一刀流有缘，你得好好培养。", 0, 1);
		say("你看中的自然是好的", 578, 1,"谢无悠");
		say("小子，你混元功练得不错嘛", 578, 1,"谢无悠");
		say("是大哥教的好，大姐姐，你真厉害，连大哥都不敢跟你打。", 0, 1);
		say("这话我爱听，你这小家伙倒是会说话，我正好打算收个弟子回去，看你悟性也不差，不如跟我走吧？", 578, 1,"谢无悠");
		say("好啊！", 41, 1,"杨过");
		say("大哥，再见！", 41, 1,"杨过");
		say("嘿，这小子。。。", 0, 1);
		say("有空回刀宗看我", 578, 1,"谢无悠");
		else
		say("大姐姐，你真厉害。", 41, 1,"杨过");
		say("你怎么知道我厉害？", 578, 1,"谢无悠");
		say("隔壁的大叔都打不过你，你自然是厉害了。", 41, 1,"杨过");
		say("你这小家伙倒是会说话，我正好打算收个弟子回去，看你悟性也不差，不如跟我走吧？", 578, 1,"谢无悠");
		say("好啊！", 41, 1,"杨过");
		say("大哥，再见！", 41, 1,"杨过");
		end
		dark()
		null(80,150)
		null(80,151)
		instruct_21(58) -- 杨过离队
		light()
		say("这么快就走了，也好，让这孩子出去锻炼一下。", 0, 1);
		if XYL(0) then
		say("不过无悠这丫头虽然傲娇了点，教弟子的水平还不错，也罢，就让这小子磨她几年。", 0, 1);	
		say("省的她总找我。", 0, 1);	
		end
		JoinMP(58, 11, 3)
		addevent(80, 152, 1, 3539, 1, 3093*2, 15, 21)
	else
		say("……", 578, 1,"谢无忧");
	end
end




OEVENTLUA[3537] = function() -- 杨过入古墓
	say("小兄弟，你在这儿啊？怎么不见那位婆婆？", 0, 1);
	say("大哥，那日婆婆送我回重阳宫，不想……遭了那帮贼道人的毒手，她临终之前托付龙姑姑照顾我，我这才留了下来。", 41, 1,"杨过");
	say("过儿，祖师婆婆这套功夫叫作‘玉女心经’须得二人同练，互为臂助。", 59, 1,"小龙女");
	say("是，姑姑。", 41, 1,"杨过");
	JoinMP(58, 3, 2)
	null(18,24)
	addevent(18, 24, 1, 3538, 1, 4623*2, 15, 16)--古墓杨过
	for i = 0, 9 do
		null(62,i)
	end
	--addevent(62, 10, 1, 3539, 1, 3621*2, 19, 34) -- 破庙小龙女，暂时弃用
	addevent(62, 11, 0, 3540, 3, 0, 43, 24) -- 杨龙分离事件
	addevent(62, 12, 0, 3540, 3, 0, 43, 25)
	addevent(62, 13, 0, 3540, 3, 0, 43, 26)
	addevent(62, 14, 1, 0, 0, 3093*2, 33, 25)--杨过
	addevent(62, 15, 1, 0, 0, 3034*2, 34, 24)--龙女
	say("＜杨过小兄弟这次应该是安定下来了，希望他能跟着龙姑娘好好学武。＞", 0, 1);	
end

OEVENTLUA[3538] = function() -- 杨过入古墓
	say("过儿，祖师婆婆这套功夫叫作‘玉女心经’须得二人同练，互为臂助。", 59, 1,"小龙女");
	say("是，姑姑。", 41, 1,"杨过");
end

OEVENTLUA[3539] = function() -- 一刀流线 重逢
	instruct_30(8,0,0,0);
    JY.Person[58]["武功1"] = 180
    JY.Person[58]["武功等级1"] = 999
	JY.Person[58]["武功2"] = 115
    JY.Person[58]["武功等级2"] = 999
	JY.Person[58]["武功3"] = 131
    JY.Person[58]["武功等级3"] = 999
	JY.Person[58]["武功4"] = 107
    JY.Person[58]["武功等级4"] = 1
	JY.Person[58]["武功5"] = 104
    JY.Person[58]["武功等级5"] = 999
	JY.Person[58]["武功6"] = 95
    JY.Person[58]["武功等级6"] = 999
	JY.Person[58]["半身像"] = 172
	JY.Person[58]["声望"] = 180
	JY.Person[58]["拳掌功夫"] = JY.Person[58]["拳掌功夫"]+50
	JY.Person[58]["御剑能力"] = JY.Person[58]["御剑能力"]+100
	JY.Person[58]["耍刀技巧"] = 30
	JY.Person[58]["特殊兵器"] = JY.Person[58]["特殊兵器"]+20
	JY.Person[58]["暗器技巧"] = JY.Person[58]["暗器技巧"]+20
	JY.Person[58]["等级"] = 5
	JY.Person[58]["实战"] = 50
	JY.Person[58]["攻击力"]=JY.Person[58]["攻击力"]+100
    JY.Person[58]["防御力"]=JY.Person[58]["防御力"]+50
	JY.Person[58]["轻功"]=JY.Person[58]["轻功"]+100
	QZXS("杨过学会太虚剑意！")
	QZXS("杨过学会梯云纵！")
	QZXS("杨过学会斩流剑法！")
	QZXS("杨过学会九阴真经！")
	QZXS("杨过学会逆运经脉！")
	QZXS("杨过学会蛤蟆功！")
	say("？这位是……杨兄弟？", 0, 1);
	say("大哥，好久不见。", 172, 1,"杨过");
	say("是啊，自从上次一别，已经有几个年头了。我差点都认不出你了。你怎么会在这儿？", 0, 1);
	say("师父回刀宗去了，我到了这里，遇到了义父。", 172, 1,"杨过");
	say("义父？你有义父了？", 0, 1);
	say("是这样。", 172, 1,"杨过");
	say("杨过讲述了自己如何遇到欧阳锋，又如何拜他为义父的。", 928, 2);
	say("可惜义父疯疯癫癫地，又不知道到哪去了。", 172, 1,"杨过");
	dark()
	light()
	say("杨兄弟莫慌，我们一起找回你义父。", 0, 1);
	say("好，那就打扰大哥了。义父，他年纪大了，又有疯病在身，我担心他。", 172, 1,"杨过");
	say("天下除了孙婆婆，你和师傅，就只有他对我最好了，我一定要找到他。", 172, 1,"杨过");
	teammate(58)
	null(80,152)
	null(80,153)
	addevent(80, 152, 0, 3541, 3, 0, 48, 36)
end
--[[OEVENTLUA[3539] = function() -- 骑龙未遂事件，暂时弃用
	say("咦？这不是龙姑娘么？怎么被人点了穴道？", 0, 1);	
	say("有人！", 0, 1);
	SetS(106, 63, 1, 0, 0)
   	SetS(106, 63, 2, 0, 291)
	if WarMain(288) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end
	say("甄志丙遁去", 928, 2);
	say(JY.Person[zj()]["姓名"].."解开小龙女穴道", 928, 2);
	say("龙姑娘，你怎么到了这里？", 0, 1);
	say("多谢少侠相助，事情是这样的……", 59, 1,"小龙女");
	say("小龙女讲述了李莫愁如何来抢夺玉女心经，自己和杨过是又如何离开古墓，到了这里。", 928, 2);
	say("那大胡子疯汉原来是过儿的义父。他要传授过儿武功，怕我跟去偷学，便点了我的穴道。", 59, 1,"小龙女");
	say("原来是这样。", 0, 1);
	dark()
	addevent(62, 11, 1, 3539, 1, 3621*2, 20, 34) -- 破庙杨过
	light()
	say("大哥？你怎么在这？", 41, 1,"杨过");
	say("方才我被你义父点了穴道，又被人偷袭，多亏这位少侠相助。", 59, 1,"小龙女");
	say("是什么人？", 41, 1,"杨过");
	say("那人蒙着面，看不清脸，看装束似乎是全真派弟子。", 0, 1);
	say("姑姑，我义父患病已深，性子又古怪，你别同他计较。", 41, 1,"杨过");
	say("没事。", 59, 1,"小龙女");
	say("这一年来，那遗刻上的法门，我们也练的差不多了。我同你下山去找你义父吧。", 59, 1,"小龙女");
	say("大哥，就此别过。", 41, 1,"杨过");
	dark()
	null(62,10) -- 杨龙离开
	null(62,11)
	light()
end ]]

OEVENTLUA[3540] = function() -- 杨龙分离事件
	null(62,11)
	null(62,12)
	null(62,13)
	null(18,24)
	null(18,25)
	instruct_30(8,0,0,0);
    JY.Person[58]["武功2"] = 121
    JY.Person[58]["武功等级2"] = 999
	JY.Person[58]["武功3"] = 119
    JY.Person[58]["武功等级3"] = 999
	JY.Person[58]["武功4"] = 107
    JY.Person[58]["武功等级4"] = 1
	JY.Person[58]["武功5"] = 104
    JY.Person[58]["武功等级5"] = 999
	JY.Person[58]["武功6"] = 42
    JY.Person[58]["武功等级6"] = 999
	JY.Person[58]["武功7"] = 39
  	JY.Person[58]["武功等级7"] = 999
	JY.Person[58]["半身像"] = 172
	JY.Person[58]["声望"] = 121
	JY.Person[58]["拳掌功夫"] = JY.Person[58]["拳掌功夫"]+50
	JY.Person[58]["御剑能力"] = JY.Person[58]["御剑能力"]+50
	JY.Person[58]["耍刀技巧"] = 30
	JY.Person[58]["特殊兵器"] = JY.Person[58]["特殊兵器"]+20
	JY.Person[58]["暗器技巧"] = JY.Person[58]["暗器技巧"]+20
	JY.Person[58]["等级"] = 5
	JY.Person[58]["实战"] = 50
	JY.Person[58]["攻击力"]=JY.Person[58]["攻击力"]+100
    JY.Person[58]["防御力"]=JY.Person[58]["防御力"]+50
	JY.Person[58]["轻功"]=JY.Person[58]["轻功"]+100
	QZXS("杨过学会玉女心经！")
	QZXS("杨过学会天罗地网！")
	QZXS("杨过学会九阴神功！")
	QZXS("杨过学会逆运筋脉！")
	QZXS("杨过学会玉女素心剑！")
	say("龙姑娘？这位是……杨兄弟？", 0, 1);
	say("大哥，好久不见。", 172, 1,"杨过");
	say("是啊，自从上次一别，已经有几个年头了。我差点都认不出你了。你们怎么会在这儿？", 0, 1);
	say("是这样。", 172, 1,"杨过");
	say("杨过讲述了李莫愁如何来抢夺玉女心经，自己和小龙女是又如何离开古墓，到了这里，遇到义父。", 928, 2);
	say("姑姑，我义父做事颠三倒四，你莫跟他一般见识。", 172, 1,"杨过");
	say("你还叫我姑姑？", 59, 1,"小龙女");
	say("我不叫你姑姑叫什么？要我叫师父么？", 172, 1,"杨过");
	say("你这般对我，我还能做你师父么？", 59, 1,"小龙女");	
	say("我……我怎么啦？", 172, 1,"杨过");
	say("小龙女淡淡一笑，卷起衣袖，露出一条雪藕也似的臂膀，但见洁白似玉，竟无半分瑕疵，本来一点殷红的守宫砂已不知去向。", 928, 2);
	say("你瞧。", 59, 1,"小龙女");	
	say("姑姑，我不懂啊。", 172, 1,"杨过");
	say("你怎么仍是叫我姑姑？难道你没真心待我么？", 59, 1,"小龙女");	
	say("小龙女见杨过不答，心中焦急起来。", 928, 2);
	say("你到底当我是什么人？", 59, 1,"小龙女");
	say("你是我师父，你怜我教我，我发过誓，要一生一世敬你重你，听你的话。", 172, 1,"杨过");
	say("难道你不当我是你妻子？", 59, 1,"小龙女");
	say("不，不！你不能是我妻子，我怎么配？你是我师父，是我姑姑。", 172, 1,"杨过");
	say("小龙女气得全身发抖，突然“哇”的一声，喷出一口鲜血。", 928, 2);
	say("龙姑娘！", 0, 1);
	say("姑姑！", 172, 1,"杨过");
	say("小龙女听杨过仍是这么叫，狠狠凝视著他，举起左掌，便要向他天灵盖拍落，但这一掌始终落不下去，她目光渐渐的自恼恨转为怨责，又自怨责转为怜惜，叹了一口长气。", 928, 2);
	say("既是这样，以后你别再见我。", 59, 1,"小龙女");
	dark()
	null(62,15) -- 龙女离开
	light()
	say("大哥，姑姑这是生我的气了吗？可我真的不知道做错了什么。", 172, 1,"杨过");
	say("杨兄弟莫慌，此事颇有蹊跷。你不妨再把事情经过向我详细讲一遍，我们再一起找回你姑姑，向她解释清楚。", 0, 1);
	say("好，那就打扰大哥了。不过我想先找到义父，他年纪大了，又有疯病在身，我担心他。", 172, 1,"杨过");
	teammate(58)
	null(62,14)
	addevent(80, 152, 0, 3541, 3, 0, 48, 36)
end

OEVENTLUA[3541] = function() -- 华山绝顶事件
	if hasppl(58) == false then
		do return end
	end	
	dark()
	addevent(80, 153, 0, 0, 0, 3985*2, 31, 25)-- 欧阳锋
	addevent(80, 154, 0, 0, 0, 4000*2, 31, 33)-- 洪七公
	light()
	instruct_30(12,0,0,0);
	instruct_30(0,7,0,0);
	instruct_30(2,0,0,0);
	dark()
	addevent(80, 155, 0, 0, 0, 3093*2, 28, 29)-- 杨过
	light()
	say("爸爸！洪老前辈！", 172, 1,"杨过");
	say("爸爸！这些日子你在哪儿？", 172, 1,"杨过");
	say("我在找你。", 60, 1,"欧阳锋");
	say("爸爸，你就是欧阳锋。这位洪老前辈是好人，你别跟他打架了。", 172, 1,"杨过");
	say("他是欧阳锋，欧阳锋是坏人。", 60, 1,"欧阳锋");
	say("不错，欧阳锋是坏人，欧阳锋该死。", 69, 1,"洪七公");
	say("洪老前辈，他是我的义父。你怜他身患重病，神智胡涂，别跟他为难了罢。", 172, 1,"杨过");
	say("好小子，原来他是你义父。", 69, 1,"洪七公");
	say("欧阳锋，咱们拳脚比不出胜败，再比兵器。", 60, 1,"欧阳锋");
	say("臭蛤蟆，你服了我么？", 69, 1,"洪七公");
	say("服什么？我还有许多武功尚未使出，若是尽数施展，定要打得你一败涂地。", 60, 1,"欧阳锋");
	say("正巧我也有好多武功未用。你听见过丐帮的打狗棒法没有？", 69, 1,"洪七公");
	say("打狗棒法有什么了不起？", 60, 1,"欧阳锋");
	say("洪七公日前与欧阳锋拼斗，已耗损了大半力气，眼下已经使不出这路打狗棒法，但听得欧阳锋这么说，心中甚不服气。", 928, 2);
	say("小子，你过来。我这有一套武功传给你。这武功向来只传本帮帮主，不传旁人，只是你义父出言小觑於我，我却要你演给他瞧瞧。", 69, 1,"洪七公");
	say("老前辈这武功既然不传外人，晚辈以不学为是。", 172, 1,"杨过");
	say("臭蛤蟆，你义儿知道你敌不过我的打狗棒法，不肯摆式子给你瞧。", 69, 1,"洪七公");
	say("孩儿，我还有好些神奇武功未曾使用，怕他怎地？快摆出来我瞧。", 60, 1,"欧阳锋");
	say("两人如此大费唇舌的比武，比到傍晚，也不过拆了十来招，杨过却已累得满身大汗。次晨又比，直过了三天，三十六路棒法方始说完。", 928, 2);
	say("到这日傍晚，洪七公将第三十六路棒法“天下无狗”的第六变说了，这是打狗棒法最後一招最後一变的绝招，棒法之精妙，已臻武学中的绝诣。", 928, 2);
	say("当晚，欧阳锋翻来覆去，折腾了一夜，直到次晨。", 928, 2);
	dark()
	light()
	say("有了，有了。孩儿，你便以这杖法破他。", 60, 1,"欧阳锋");
	say("杨过向他望去，欧阳锋虽然年老，但因内功精湛，须发也只略现灰白，而昨晚用心过度，一夜之间竟然须眉尽白，似乎忽然老了十多岁。", 928, 2);
	say("爸爸……", 172, 1,"杨过");
	say("杨过心中难过，欲求洪七公休要再比，欧阳锋却连声相催。这一招十分繁复，欧阳锋反覆解说，杨过方行领悟，于是依式演了出来。", 928, 2);
	JY.Person[58]["武功7"] = 80
	JY.Person[58]["武功等级7"] = 999
	JY.Person[58]["武功8"] = 120
  	JY.Person[58]["武功等级8"] = 999
	JY.Person[58]["特殊兵器"] = JY.Person[58]["特殊兵器"]+100
	JY.Person[58]["实战"] = JY.Person[58]["实战"]+50
	JY.Person[58]["攻击力"]=JY.Person[58]["攻击力"]+50
    JY.Person[58]["防御力"]=JY.Person[58]["防御力"]+50
	JY.Person[58]["轻功"]=JY.Person[58]["轻功"]+50
	QZXS("杨过学会打狗棒法！")
	QZXS("杨过学会灵蛇杖法！")
	instruct_0();   --  0(0)::空语句(清屏)
	local title = "西毒/北丐真传";
	local str = "可以获得一种武功秘籍，请选择"
	local btn = {"灵蛇杖法","打狗棒法"};
	local num = #btn;
	local r = JYMsgBox(title,str,btn,num);
	if r == 1 then
	    addthing(251)
		SetS(106, 63, 1, 0, 58)
 		SetS(106, 63, 2, 0, 69)
		if WarMain(288) == false then
            instruct_14();   --  14(E):场景变黑
   	        instruct_0();   --  0(0)::空语句(清屏)
			instruct_13();   --  13(D):重新显示场景
		else
			addHZ(105)
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_14();   --  14(E):场景变黑
			instruct_0();   --  0(0)::空语句(清屏)
 			instruct_13();   --  13(D):重新显示场景
		end		
	elseif r == 2 then
		addthing(167)
		SetS(106, 63, 1, 0, 58)
	   	SetS(106, 63, 2, 0, 60)
		if WarMain(288) == false then
	        instruct_14();   --  14(E):场景变黑
	        instruct_0();   --  0(0)::空语句(清屏)
	        instruct_13();   --  13(D):重新显示场景
		else
			addHZ(106)
	        instruct_0();   --  0(0)::空语句(清屏)
	        instruct_14();   --  14(E):场景变黑
	        instruct_0();   --  0(0)::空语句(清屏)
	        instruct_13();   --  13(D):重新显示场景
		end
	end
	say("老毒物，欧阳锋！老叫化今日服了你啦。", 69, 1,"洪七公");
	say("我是欧阳锋！我是欧阳锋！我是欧阳锋！你是老叫化洪七公！", 60, 1,"欧阳锋");
	say("爸爸！老前辈！", 172, 1,"杨过");
	say("北丐西毒数十年来反覆恶斗，互不相下，竟同时在华山绝顶归天。两人毕生怨愤纠结，临死之际却相抱大笑。数十年的深仇大恨，一笑而罢！", 928, 2);
	dark()
	null(80,153)
	null(80,154)
	null(80,155)
	light()
	instruct_30(0,10,0,0);
	dark()
	addevent(80, 156, 1, 3543, 1, 1385*2, 34, 15)
	addevent(80, 157, 1, 3542, 1, 1385*2, 35, 15)-- 加洪七欧阳锋墓
	addevent(75, 78, 1, 3544, 1, 3044*2, 25, 12) -- 桃花岛增加郭靖
	addevent(75, 79, 1, 3544, 1, 3045*2, 27, 12) -- 桃花岛增加黄蓉
	addevent(75, 80, 1, 3545, 1, 4581*2, 18, 27) -- 桃花岛增加大武
	addevent(75, 81, 1, 3546, 1, 4577*2, 18, 26) -- 桃花岛增加小武
	addevent(75, 82, 1, 3547, 1, 4587*2, 19, 24) -- 桃花岛增加郭芙
	light()
	say("杨兄弟……", 0, 1);
	say("大哥，我想回桃花岛看看郭伯父他们，顺便告知洪老前辈的死讯。", 172, 1,"杨过");	
	say("嗯，我们走吧。", 0, 1);
	addthing(252)
	null(80,152)
end

OEVENTLUA[3542] = function() --欧阳锋墓
	say("西毒欧阳锋之墓", 928, 2);
end

OEVENTLUA[3543] = function() --洪七公墓
	say("北丐洪七公之墓", 928, 2);
end

OEVENTLUA[3544] = function() -- 再遇郭靖黄蓉
	if hasppl(58) == false then
		say("……", 55, 1,"郭靖");
	else
		say("郭伯父，黄伯母。", 172, 1,"杨过");	
		say("过儿？过几日在陆家庄有英雄大宴，你同少侠一起来吧。", 55, 1,"郭靖");
		say("是。", 172, 1,"杨过");	
		JY.Scene[54]["名称"] = "陆家庄"
		if MPPD(58)==11 then
		addevent(54, 50, 0, 3564, 3, 0, 43, 31) -- 英雄大会
		addevent(54, 51, 0, 3564, 3, 0, 43, 30) -- 英雄大会
		else
		addevent(54, 50, 0, 3548, 3, 0, 43, 31) -- 英雄大会
		addevent(54, 51, 0, 3548, 3, 0, 43, 30) -- 英雄大会
		end
	end
end

OEVENTLUA[3545] = function() -- 大武
	if hasppl(58) == false then
		say("我叫武敦儒。", 700, 1,"武敦儒");
	else
		say("两位武兄，别来安好。", 172, 1,"杨过");	
		say("恕小弟眼拙，尊兄是谁？", 700, 1,"武敦儒");
	end
end

OEVENTLUA[3546] = function() -- 小武
	if hasppl(58) == false then
		say("我叫武修文。", 700, 1,"武修文");
	else
		say("两位武兄，别来安好。", 172, 1,"杨过");	
		say("恕小弟眼拙，尊兄是谁？", 700, 1,"武修文");
	end
end

OEVENTLUA[3547] = function() -- 郭芙
	if hasppl(58) == false then
		say("……", 358, 1,"郭芙");
	else
		say("杨大哥？你不在这住几天吗？", 358, 1,"郭芙");	
		say("不了。", 172, 1,"杨过");
	end
end

OEVENTLUA[3548] = function() --神雕古墓线，英雄大会
	if hasppl(58) == false then
		do return end
	end	
	null(75,78)
	null(75,79)
	null(75,80)
	null(75,81)
	null(75,82)
	dark()
	--右侧
	addevent(54, 52, 0, 0, 0, 2602*2, 28, 23) -- 英雄大会观众
	addevent(54, 53, 0, 0, 0, 2602*2, 29, 23) -- 英雄大会观众
	addevent(54, 54, 0, 0, 0, 2602*2, 30, 23) -- 英雄大会观众
	addevent(54, 55, 0, 0, 0, 3054*2, 31, 23) -- 英雄大会观众
	addevent(54, 56, 0, 0, 0, 3054*2, 32, 23) -- 英雄大会观众
	addevent(54, 57, 0, 0, 0, 3054*2, 33, 23) -- 英雄大会观众
	addevent(54, 58, 0, 0, 0, 2703*2, 34, 23) -- 英雄大会观众
	addevent(54, 59, 0, 0, 0, 2703*2, 35, 23) -- 英雄大会观众
	addevent(54, 60, 0, 0, 0, 2703*2, 36, 23) -- 英雄大会观众
	addevent(54, 61, 0, 0, 0, 3133*2, 37, 23) -- 英雄大会观众
	addevent(54, 62, 0, 0, 0, 3133*2, 38, 23) -- 英雄大会观众
	addevent(54, 63, 0, 0, 0, 3133*2, 39, 23) -- 英雄大会观众
	addevent(54, 64, 0, 0, 0, 2602*2, 28, 24) -- 英雄大会观众
	addevent(54, 65, 0, 0, 0, 2602*2, 29, 24) -- 英雄大会观众
	addevent(54, 66, 0, 0, 0, 2602*2, 30, 24) -- 英雄大会观众
	addevent(54, 67, 0, 0, 0, 3054*2, 31, 24) -- 英雄大会观众
	addevent(54, 68, 0, 0, 0, 3054*2, 32, 24) -- 英雄大会观众
	addevent(54, 69, 0, 0, 0, 3054*2, 33, 24) -- 英雄大会观众
	addevent(54, 70, 0, 0, 0, 2703*2, 34, 24) -- 英雄大会观众
	addevent(54, 71, 0, 0, 0, 2703*2, 35, 24) -- 英雄大会观众
	addevent(54, 72, 0, 0, 0, 2703*2, 36, 24) -- 英雄大会观众
	addevent(54, 73, 0, 0, 0, 3133*2, 37, 24) -- 英雄大会观众
	addevent(54, 74, 0, 0, 0, 3133*2, 38, 24) -- 英雄大会观众
	addevent(54, 75, 0, 0, 0, 3133*2, 39, 24) -- 英雄大会观众
	--左侧
	addevent(54, 76, 0, 0, 0, 2603*2, 28, 32) -- 英雄大会观众
	addevent(54, 77, 0, 0, 0, 2603*2, 29, 32) -- 英雄大会观众
	addevent(54, 78, 0, 0, 0, 2603*2, 30, 32) -- 英雄大会观众
	addevent(54, 79, 0, 0, 0, 3055*2, 31, 32) -- 英雄大会观众
	addevent(54, 80, 0, 0, 0, 3055*2, 32, 32) -- 英雄大会观众
	addevent(54, 81, 0, 0, 0, 3055*2, 33, 32) -- 英雄大会观众
	addevent(54, 82, 0, 0, 0, 2704*2, 34, 32) -- 英雄大会观众
	addevent(54, 83, 0, 0, 0, 2704*2, 35, 32) -- 英雄大会观众
	addevent(54, 84, 0, 0, 0, 2704*2, 36, 32) -- 英雄大会观众
	addevent(54, 85, 0, 0, 0, 3134*2, 37, 32) -- 英雄大会观众
	addevent(54, 86, 0, 0, 0, 3134*2, 38, 32) -- 英雄大会观众
	addevent(54, 87, 0, 0, 0, 3134*2, 39, 32) -- 英雄大会观众
	addevent(54, 88, 0, 0, 0, 2603*2, 28, 33) -- 英雄大会观众
	addevent(54, 89, 0, 0, 0, 2603*2, 29, 33) -- 英雄大会观众
	addevent(54, 90, 0, 0, 0, 2603*2, 30, 33) -- 英雄大会观众
	addevent(54, 91, 0, 0, 0, 3055*2, 31, 33) -- 英雄大会观众
	addevent(54, 92, 0, 0, 0, 3055*2, 32, 33) -- 英雄大会观众
	addevent(54, 93, 0, 0, 0, 3055*2, 33, 33) -- 英雄大会观众
	addevent(54, 94, 0, 0, 0, 2704*2, 34, 33) -- 英雄大会观众
	addevent(54, 95, 0, 0, 0, 2704*2, 35, 33) -- 英雄大会观众
	addevent(54, 96, 0, 0, 0, 2704*2, 36, 33) -- 英雄大会观众
	addevent(54, 97, 0, 0, 0, 3134*2, 37, 33) -- 英雄大会观众
	addevent(54, 98, 0, 0, 0, 3134*2, 38, 33) -- 英雄大会观众
	addevent(54, 99, 0, 0, 0, 3134*2, 39, 33) -- 英雄大会观众
	addevent(54, 100, 0, 0, 0, 3619*2, 26, 29) -- 郭靖
	addevent(54, 101, 0, 0, 0, 3620*2, 26, 27) -- 黄蓉
	addevent(54, 102, 0, 0, 0, 4588*2, 23, 27) -- 郭芙
	addevent(54, 103, 0, 0, 0, 4581*2, 23, 28) -- 大武
	addevent(54, 104, 0, 0, 0, 4577*2, 23, 29) -- 小武
	light()
	if JY.Base["人Y1"] == 31 then		--两个触发地方的移动方式不一样
		instruct_30(3,0,0,0);
		instruct_30(0,9,0,0);
		instruct_30(13,0,0,0);
		instruct_30(0,-2,0,0);
	else
		instruct_30(3,0,0,0);
		instruct_30(0,8,0,0);
		instruct_30(13,0,0,0);
		instruct_30(0,-2,0,0);
	end
	dark()
	addevent(54, 105, 0, 0, 0, 3094*2, 26, 24) -- 杨过
	light()
	say("黄蓉按着帮规宣布后，将历代帮主相传的打狗棒交给了鲁有脚，众弟子一齐向他唾吐，只吐得他满头满身都是痰涎，于是新帮主接任之礼告成。", 928, 2);
	say("洪老帮主有令，命我传达。", 700, 1,"丐帮弟子");
	say("恭祝洪老帮主安好！", 700, 1,"众丐");
	say("＜众人这等欢欣，我又何忍将洪老帮主逝世的讯息说了出来？何况我人微言轻，述说这等大事，他们未必肯信。我何必扫他们的兴？＞", 172, 1,"杨过");	
	say("迎接贵宾！", 700, 1,"陆冠英");
	dark()
	addevent(54, 106, 0, 0, 0, 4108*2, 31, 28) -- 金轮
	addevent(54, 107, 0, 0, 0, 3032*2, 30, 26) -- 霍都
	addevent(54, 108, 0, 0, 0, 3381*2, 33, 27) -- 达尔巴等人
	addevent(54, 109, 0, 0, 0, 3381*2, 33, 28) -- 
	addevent(54, 110, 0, 0, 0, 3381*2, 33, 29) -- 
	addevent(54, 111, 0, 0, 0, 3381*2, 34, 27) -- 
	addevent(54, 112, 0, 0, 0, 3381*2, 34, 28) -- 
	addevent(54, 113, 0, 0, 0, 3381*2, 34, 29) --
	light()
	say("各位远道到来，就请入座喝上几杯。", 55, 1,"郭靖");
	say("师父，我给你老人家引见中原两位大名鼎鼎的英雄……", 84, 1,"霍都");
	say("这位是做过咱们蒙古西征右军元帅的郭靖郭大侠，这位是郭夫人，也即是丐帮的黄帮主。", 84, 1,"霍都");
	say("这位是在下的师尊，西藏圣僧，人人尊称金轮法王，当今大蒙古国皇后封为第一护国大师。", 84, 1,"霍都");
	say("盛会难得，良时不再，天下英雄尽聚于此，依小王之见，须得推举一位群雄的盟主，领袖武林，以为天下豪杰之长，各位以为如何？", 84, 1,"霍都");
	say("这话不错。我们已推举了丐帮洪老帮主为群雄盟主，现下正在推举副盟主，阁下有何高见？", 700, 1,"雷猛");
	say("莫说洪七公此时死活难知，就算他好端端的坐在此处，凭他的武功德望，又怎及得上我师父金轮法王？", 84, 1,"霍都");
	say("群雄听了这一番话，都已明白这些人的来意。若金轮法王凭武功夺得盟主，中原豪杰虽然决不会听他号令，却也是削弱了汉人抗拒蒙的声势。", 928, 2);
	say("这样罢，咱们言明比武三场，那一方胜得两场，就取盟主之位。", 84, 1,"霍都");
	say("郭靖、黄蓉与众人低声商量，觉得对方此议实难以拒却。今日与会之人，除黄蓉不能出阵外，算来以郭靖、郝大通，和朱子柳三人武功最强。", 928, 2);
	say("蒙古乃蛮夷之邦，未受圣人教化，阁下既然请教，敝人自当指点指点。", 122, 1,"朱子柳");
	say("你出言辱我蒙古，须饶你不得！", 84, 1,"霍都");
	dark()
	light()
	say("堂上群雄一齐注目朱子柳与霍都二人，这时外面走进来一个白衣少女。她周身犹如笼罩着一层轻烟薄雾，似真似幻，实非尘世中人。", 928, 2);
	say("姑姑，姑姑！", 172, 1,"杨过");
	dark()
	addevent(54, 114, 0, 0, 0, 3034*2, 25, 24) -- 龙女
	light()	
	say("过儿，你果然在此，我终于找到你啦。", 59, 1,"小龙女");
	say("你……你不再撇下我了罢？", 172, 1,"杨过");
	say("我不知道。", 59, 1,"小龙女");
	say("你今后到哪里，我便跟你到哪里。", 172, 1,"杨过");
	dark()
	for i = 106, 113 do
		null(54,i)
	end
	addevent(54, 116, 0, 0, 0, 3033*2, 33, 28) -- 霍都上场
	addevent(54, 117, 0, 0, 0, 4108*2, 37, 26) -- 金轮
	addevent(54, 118, 0, 0, 0, 3381*2, 37, 27) -- 达尔巴等人
	addevent(54, 119, 0, 0, 0, 3381*2, 37, 28) -- 
	addevent(54, 120, 0, 0, 0, 3381*2, 37, 29) -- 
	addevent(54, 121, 0, 0, 0, 3381*2, 38, 27) -- 
	addevent(54, 122, 0, 0, 0, 3381*2, 38, 28) -- 
	addevent(54, 123, 0, 0, 0, 3381*2, 38, 29) --
	light()
	say("霍都使诈用暗器偷袭胜了第一场，第二场达尔巴与点苍渔隐以力相拼，铁桨竟被黄金杵震断。", 928, 2);
	say("咱们言明在先，三赛两胜。各位说过的话，算人话不算？", 84, 1,"霍都");
	say("今日争武林盟主，都是徒弟替师父打架，是也不是？", 172, 1,"杨过");
	say("不错，我们三场中胜了两场，因此我师父是盟主。", 84, 1,"霍都");
	say("就算你胜了他们，那又怎地？我师父的徒弟你可没打胜。", 172, 1,"杨过");
	say("你师父的徒弟是谁？", 84, 1,"霍都");
	say("蠢才！我师父的徒弟，自然是我。", 172, 1,"杨过");
	say("众人听他说到此处，均想莫非他师父当真是大有来头的人物，要来争武林盟主，不管他师父是谁，总是汉人，自胜于让蒙古国师抢了盟主去。", 928, 2);
	say("对，对，除非你们蒙古人再胜得两场。", 700, 1,"众人");
	dark()
	null(54,105)
	addevent(54, 115, 0, 0, 0, 3093*2, 29, 28) -- 杨过上场
	light()	
	say("天下英雄请了，小王杀此顽童，那是他自取其咎，须怪不得小王。", 84, 1,"霍都");
	say("天下英雄请了，小顽童杀此王子，那是他自取其咎，须怪不得小顽童！", 172, 1,"杨过");
	SetS(106, 63, 1, 0, 58)
   	SetS(106, 63, 2, 0, 84)
	if WarMain(288) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end	
	say("我三番四次提醒，要放暗器了，要放暗器了，你总是不信。可没骗你，是不是？", 172, 1,"杨过");
	say("小孩子，我来和你比武！＜藏语＞", 160, 1,"达尔巴");
	say("达尔巴说罢，金刚杵横扫，疾向杨过腰间打去。杨过双脚不动，腰身向后缩了尺许，金刚杵恰好在他腰前掠过。", 928, 2);
	dark()
	null(54,116)
	null(54,118)
	addevent(54, 124, 0, 0, 0, 4490*2, 33, 28) -- 达尔巴上场
	light()
	say("小孩子的功夫很不错，是谁教你的啊？＜藏语＞", 160, 1,"达尔巴");
	say("＜这和尚叽哩咕噜说什么？想来是在骂我，待我学他骂回去。＞", 172, 1,"杨过");
	say("小孩子的功夫很不错，是谁教你的啊？＜这几个字发音既准，次序也是丝毫不乱＞", 172, 1,"杨过");
	say("我师父是金轮法王。我又不是小孩子，你该叫我大和尚。＜藏语＞", 160, 1,"达尔巴");
	say("＜不管你如何恶毒的骂我，我只要全盘奉还，口头上就不会输了。＞", 172, 1,"杨过");
	say("我师父是金轮法王。我又不是小孩子，你该叫我大和尚。＜藏语＞", 172, 1,"杨过");
	say("我是法王的首代弟子，你是第几代的？＜藏语＞", 160, 1,"达尔巴");
	say("我是法王的首代弟子，你是第几代的？＜藏语＞", 172, 1,"杨过");
	say("＜师傅早年曾收过一个弟子，可这弟子不到二十岁就死了，这人莫非是大师兄转世？否则他年纪轻轻，怎能有如此武功？＞", 160, 1,"达尔巴");
	say("大师兄，师弟达尔巴参见。＜藏语＞", 160, 1,"达尔巴");
	say("…………", 62, 1,"金轮法王");
	say("达尔巴，他不是你大师兄转世，快起来跟他比武。＜藏语＞", 62, 1,"金轮法王");
	SetS(106, 63, 1, 0, 58)
   	SetS(106, 63, 2, 0, 160)
	if WarMain(288) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end
	say("我们又胜了第二场！武林盟主是大宋高手！蒙古鞑子快快滚出去罢，别来中原现世啦！", 700, 1,"众人");
	dark()
	null(54,124)
	null(54,117)
	addevent(54, 125, 0, 0, 0, 4108*2, 33, 28) -- 金轮上场
	light()
	say("少年，你的师父是谁？", 62, 1,"金轮法王");
	dark()
	null(54,114)
	addevent(54, 126, 0, 0, 0, 3621*2, 29, 27) -- 龙女上场
	light()
	say("我师父就是这一位，你快来拜见武林盟主罢！", 172, 1,"杨过");
	say("哼，你这小丫头也配做武林盟主？只要你接得住我这金轮的十招，我就认你是盟主。", 62, 1,"金轮法王");
	SetS(106, 63, 1, 0, 59)
 	SetS(106, 63, 2, 0, 62)
	if WarMain(288) == false then
        instruct_14();   --  14(E):场景变黑
   	    instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
	else
		addHZ(125)
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_14();   --  14(E):场景变黑
		instruct_0();   --  0(0)::空语句(清屏)
 		instruct_13();   --  13(D):重新显示场景
	end
	say("还不认输？你的兵刃都失了，还有甚么脸面？世上可有兵刃给人收去的武林盟主么？", 172, 1,"杨过");
	say("我们也不难为你，你们大多儿好好的去罢。", 172, 1,"杨过");
	say("郭大侠，黄帮主，今日领教高招。青山不改，绿水长流，咱们后会有期。", 62, 1,"金轮法王");
	dark()
	null(54,126)
	null(54,115)
	null(54,125)
	for i = 119, 123 do
		null(54,i)
	end
	addevent(54, 105, 0, 0, 0, 3094*2, 26, 24) -- 杨过
	addevent(54, 114, 0, 0, 0, 3034*2, 25, 24) -- 龙女
	light()
	say("龙姑娘，令徒过世了的父亲当年与在下有八拜之交。杨郭两家累世交好，在下单生一女，相貌与武功都还过得去……", 55, 1,"郭靖");
	say("在下意欲将小女许配给贤徒。他父母都已过世，此事须得请龙姑娘作主。", 55, 1,"郭靖");
	say("我自己要做过儿的妻子，他不会娶你女儿的。", 59, 1,"小龙女");
	say("龙姑娘，你是天下武林盟主，群望所属，观瞻所系，此事还须三思。", 56, 1,"黄蓉");
	say("我做不来什么盟主不盟主，姊姊你若是喜欢，就请你当罢。", 59, 1,"小龙女");
	say("过儿，你可要立定脚跟，好好做人，别闹得身败名裂。你的名字是我取的，你可知这个‘过’字的用意么？", 55, 1,"郭靖");
	say("若是我错了，自然要改。可我和姑姑清清白白，天日可表。我敬她爱她，难道这就错了？", 172, 1,"杨过");
	say("这番话当真是语惊四座。当时人哪里听见过这般叛逆之伦？郭靖一生最是敬重师父，只听得气向上冲，抢上一步，伸手便往杨过胸口抓去。", 928, 2);
	say("姑姑全心全意的爱我，我对她也是这般。郭伯伯，你要杀我便下手，我这主意是永生永世不改的。", 172, 1,"杨过");
	say("郭靖左掌在空际停留片时，又向杨过瞧了一眼，但见他咬紧口唇，双眉紧蹙，宛似杨康当年的模样，心中一阵酸痛，长叹一声，放松了他领口。", 928, 2);
	say("你好好的想想去罢。", 55, 1,"郭靖");
	say("过儿，这些人横蛮得紧，咱们走罢。", 59, 1,"小龙女");
	say("群雄眼睁睁的望著二人背影，有的鄙夷，有的惋惜，有的愤怒，有的惊诧。", 928, 2);
	dark()
	for i = 50, 105 do
		null(54,i)
	end
	null(54,114)
	null(111,10)
	instruct_21(58) -- 杨过离队
	addevent(111, 30, 0, 3549, 3, 0, 24, 39) -- 神雕古墓线，双剑战金轮
	addevent(111, 31, 0, 3549, 3, 0, 25, 39) -- 神雕古墓线，双剑战金轮
	addevent(111, 32, 0, 3549, 3, 0, 26, 39) -- 神雕古墓线，双剑战金轮
	light()
	say("想不到事态竟有如此发展，现在天色已晚，我先找个地方借宿吧。", 0, 1);
	transferme(111, 46, 42, 2)
end




OEVENTLUA[3549] = function() -- 神雕古墓线，双剑战金轮，龙女再度离开
	dark()
	null(111,30)
	null(111,31)
	null(111,32)
	addevent(111, 33, 0, 0, 0, 3554*2, 25, 31) -- 金轮一行
	addevent(111, 34, 0, 0, 0, 3380*2, 24, 32) -- 金轮一行
	addevent(111, 35, 0, 0, 0, 3380*2, 25, 32) -- 金轮一行
	addevent(111, 36, 0, 0, 0, 3380*2, 26, 32) -- 金轮一行
	addevent(111, 37, 0, 0, 0, 3094*2, 24, 28) -- 杨过
	addevent(111, 38, 0, 0, 0, 3034*2, 26, 28) -- 龙女
	addevent(111, 39, 0, 0, 0, 3045*2, 29, 25) -- 黄蓉
	addevent(111, 40, 0, 0, 0, 4587*2, 30, 25) -- 郭芙
	light()
	instruct_30(0,5,0,0);
	say("＜金轮法王？他们怎么在这？＞", 0, 1);
	say("杨兄弟，龙姑娘，我来助你们！", 0, 1);
	if instruct_6(74,4,0,0) ==false then    --  6(6):战斗[74]是则跳转到:Label2
        instruct_15(0);   --  15(F):战斗失败，死亡
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label2
	say("今日见识中原武功，老衲佩服得紧。你们这套剑法叫做什么名堂？", 62, 1,"金轮法王");
	say("中原武功，以打狗棒法与刺驴剑术为首，我们这套剑法，就是刺驴剑术了。", 172, 1,"杨过");
	say("刺驴剑术？", 62, 1,"金轮法王");
	say("是啊，刺秃驴的剑术。", 172, 1,"杨过");
	say("无礼小儿，终须叫你知道金轮法王的手段。", 62, 1,"金轮法王");
	say("大师兄，你杀我不杀？", 160, 1,"达尔巴");
	say("你们走吧。", 172, 1,"杨过");
	say("大师兄，多谢。", 160, 1,"达尔巴");
	dark()
	for i = 33, 40 do
		null(111, i)
	end
	addevent(111, 41, 0, 0, 0, 3094*2, 24, 31) -- 杨过
	addevent(111, 42, 0, 0, 0, 3034*2, 24, 28) -- 龙女
	addevent(111, 43, 0, 0, 0, 3045*2, 26, 31) -- 黄蓉
	addevent(111, 44, 0, 0, 0, 4587*2, 26, 28) -- 郭芙
	light()
	say("今儿大伙儿累了，咱们找个客店休息一宵，明日分手动身不迟。", 56, 1,"黄蓉");
	say("龙姑娘，你来，我有一件事送给你。", 56, 1,"黄蓉");
	dark()
	for i = 41, 44 do
		null(111, i)
	end
	light()
	if JY.Base["人X1"] == 26 then		--三个触发地方的移动方式不一样
		instruct_30(0,-11,0,0);
	elseif  JY.Base["人X1"] == 25 then
		instruct_30(-1,0,0,0);
		instruct_30(0,-11,0,0);
	else
		instruct_30(-2,0,0,0);
		instruct_30(0,-11,0,0);
	end
	instruct_25(26,45,33,45)--镜头移动
	dark()
	addevent(111, 45, 1, 3550, 1, 3094*2, 33, 44) -- 杨过
	addevent(111, 46, 0, 0, 0, 3621*2, 32, 45) -- 龙女
	light()
	say("郭伯母说，今晚你跟她母女俩睡一间房，我跟武氏兄弟俩睡一间房。", 172, 1,"杨过");
	say("不！为什么要那两个男人来陪你？我要和你睡你一起。", 59, 1,"小龙女");
	say("过儿，有一件事你须得真心答我。你和我住在古墓之中，多过得几年，可会想到外边的花花世界？", 59, 1,"小龙女");
	say("杨过一怔，半晌不答。", 928, 2);
	say("你若是不能出来，可会烦恼？你虽爱我之心始终不变，在古墓中时日久了，可会气闷？", 59, 1,"小龙女");
	say("姑姑，要是咱们气闷了、厌烦了，那便一同出来便是。", 172, 1,"杨过");
	say("＜郭夫人的话倒非骗我。将来他终究会气闷，要出墓来，那时人人都瞧他不起，他做人有何乐趣？＞", 59, 1,"小龙女");
	dark()
	null(111,46)
	instruct_25(33,45,26,45)--镜头移动
	light()
end

OEVENTLUA[3550] = function() --对话杨过
	say("大哥，姑姑她又走了！", 172, 1,"杨过");
	say("这是……龙姑娘留下的字？", 0, 1);
	say("只见桌面上用金针刻著细细的八个字道：“善自珍重，勿以为念。”", 928, 2);
	say("姑姑她……", 172, 1,"杨过");
	say("杨兄弟莫慌，我们再去寻回她便是。", 0, 1);
	teammate(58)
	null(111,45)
	addevent(22,49,1,3551,1,4585*2,36,23)--公孙绿萼
end

OEVENTLUA[3551] = function()
	if hasppl(58) == false then
		do return end
	end
	say("两人来到一幽谷之中，一名绿衫少女正在道旁摘花，只见那女郎将花瓣一瓣瓣的摘下，再送入口中。", 928, 2);
	say("难道花儿也吃得的？", 172, 1,"杨过");
	say("杨过说罢伸手便去摘花。", 928, 2);
	say("留神！树上有刺，别碰上了！", 313, 1,"绿衫少女");
	say("杨过避开枝上尖刺，落手甚是小心，岂知花朵背後又隐藏著小刺，还是将手指刺损了。", 928, 2);
	say("这谷叫做‘绝情谷’，偏偏长著这许多情花。", 313, 1,"绿衫少女");
	dark()
	addevent(22,50,1,3551,1,3391*2,31,24) --绝情谷弟子
	light()
	say("谷主有请几位贵客相见。", 700, 1,"绝情谷弟子");
	dark()
	null(22,49)
	null(22,50)
	light()
	if JY.Base["人X1"] == 35 then
		instruct_30(0,-3,0,0);
		instruct_30(10,0,0,0);
	else
		instruct_30(0,-2,0,0);
		instruct_30(11,0,0,0);
	end
	dark()
	addevent(22,51,1,0,1,4509*2,14,27)--公孙止
	addevent(22,52,1,0,1,3621*2,14,26)--小龙女
	addevent(22,53,1,0,1,4005*2,17,23)--金轮
	addevent(22,54,1,0,1,3507*2,18,23)--尼摩星
	addevent(22,55,1,0,1,4553*2,19,23)--潇湘子
	addevent(22,56,1,0,1,2568*2,20,23)--尹克西
	addevent(22,57,1,0,1,3393*2,17,30)--弟子
	addevent(22,58,1,0,1,3393*2,18,30)
	addevent(22,59,1,0,1,3393*2,19,30)
	addevent(22,60,1,0,1,3393*2,20,30)
	light()
	instruct_25(24,26,19,26)--镜头移动
	instruct_21(58) -- 杨过离队
	say("今日午后，小弟续弦行礼，想屈各位大驾观礼。", 509, 1,"公孙止");
	say("姑姑！", 172, 1,"杨过");
	say("那白衣女郎“啊”的一声大叫，身子颤抖，坐倒在地，合了双眼，似乎晕了过去。过了半晌，才缓缓睁眼。", 928, 2);
	say("阁下是谁？你对我是怎生称呼？", 59, 1,"小龙女");
	say("姑姑，我是过儿啊，怎……怎地你不认得我了么？你身子好么？什么地方不舒服？", 172, 1,"杨过");
	say("我与阁下素不相识。", 59, 1,"小龙女");
	say("这位柳姑娘便是兄弟的新婚夫人，已择定今日午后行礼成亲。", 509, 1,"公孙止");
	say("不知谷主如何与她结识？", 172, 1,"杨过");
	say("半月之前，我到山边采药，遇到她卧在山脚之下，身受重伤，气息奄奄。我用家传灵药助她调养。说到相识的因缘，实是出于偶然。", 509, 1,"公孙止");
	say("这正所谓千里姻缘一线牵。想必柳姑娘由是感恩图报，委身以事了。那真是郎才女貌，佳偶天成啊。", 62, 1,"金轮法王");
	say("杨过一听此言，脸色大变，全身发颤，突然间喉头微甜，一口鲜血喷在地下。", 928, 2);
	say("你……你……", 59, 1,"小龙女");
	say("杨兄弟！", 0, 1);
	say("姑姑，倘若我有不是，你尽可打我骂我，便是一剑将我杀了，我也甘心。可是你怎能不认我啊？", 172, 1,"杨过");
	say("公孙止偷瞧小龙女的脸色，只见她目中泪珠滚来滚去，终於忍耐不住，一滴滴的溅在胸口鲜血之上。", 928, 2);
	say("＜瞧来他二人定是一对情侣。只因有甚言语失和，柳妹才愤而允我婚事，看来留这小子不得。＞", 509, 1,"公孙止");
	say("将这小子拿下了！", 509, 1,"公孙止");
	say("姑姑，过儿今日有难，你的金铃索与掌套给我一用。", 172, 1,"杨过");
	say("小龙女只想著杨过安危，此外更无别样念头，听了这话，当即从怀中取出一双白色手套、一条白绸带子，递了给杨过。", 928, 2);
	say("你现在认我了么？", 172, 1,"杨过");
	say("我心中早就认你啦！", 59, 1,"小龙女");
	say("＜我纵然得不了你的心，也须得到你的人。我一掌将这小畜生击毙，你不跟我也得跟我！＞", 509, 1,"公孙止");
	say("看剑！", 509, 1,"公孙止");
	local pid = 9999;				
	JY.Person[pid] = {};
	for i=1, #PSX-8 do
		JY.Person[pid][PSX[i]] = JY.Person[96][PSX[i]];
	end
	JY.Person[pid]["姓名"] = "公孙止";
	JY.Person[pid]["生命最大值"] = 2800
	JY.Person[pid]["生命"] = 2800
	JY.Person[pid]["内力最大值"] = 6000
	JY.Person[pid]["内力"] = 6000
	JY.Person[pid]["防御力"] = 500
	JY.Person[pid]["攻击力"] = 450
	JY.Person[pid]["轻功"] = 250
	JY.Person[pid]["特殊兵器"] = 150
	JY.Person[pid]["武功1"] = 77
	JY.Person[pid]["武功等级1"] = 999
	JY.Person[pid]["声望"] = 97	
	JY.Person[pid]["左右互搏"] = 1	
	JY.Person[pid]["资质"] = 20
	for i = 2, 10 do
		JY.Person[pid]["武功"..i] = 0
		JY.Person[pid]["武功等级"..i] = 0
	end
	SetS(106, 63, 1, 0, 58)
 	SetS(106, 63, 2, 0, 9999)
	if WarMain(288) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end
	say("杨兄弟小心！", 0, 1);
	say("老衲愿领教公子高招。", 62, 1,"金轮法王");
	if instruct_6(74,4,0,0) ==false then    --  6(6):战斗[74]是则跳转到:Label2
        instruct_15(0);   --  15(F):战斗失败，死亡
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label2
	addevent(22,61,1,0,1,2581*2,17,27)--杨过倒地
	say("不好！", 0, 1);
	say("这姓杨的小子已中情花之毒！每过一个时辰，疼痛便增一分，三十六日后全身剧痛而死。", 509, 1,"公孙止");
	say("柳姑娘，十二个时辰之内你如回心转意，只须呼叫一声，我便拿解药来救他性命。若拖过一天，那便是神仙难救了。", 509, 1,"公孙止");
	say("小龙女见杨过全身发颤，咬唇出血，双目本来朗若流星，此刻已是黯然无光，想得到他身上如何痛苦，只怕地狱之中也无如此苦刑。", 928, 2);
	say("公孙先生，我允你成亲便了。你快放了他，取药解救。", 59, 1,"小龙女");
	dark()
	for i= 51, 61 do
		null(22,i)
	end
	light()
	instruct_25(19,26,24,26)--镜头移动
	say("不想竟生如此变故，杨兄弟落入他们手里。这情花之毒，我看也未必无药可解，先回小村问问贤叔吧。", 0, 1);
	say("不必了，我已经知道了。", 255, 1,"南贤");
	say("凡毒蛇出没之处，七步之内必有解蛇毒之药。其他毒物，无不如此，这是天地间万物生克的至理。", 255, 1,"南贤");
	say("如此说来，这解药定在那情花丛附近了。", 0, 1);
	say("谢谢贤叔，不过你是怎么知道现在的情况的？", 0, 1);
	say("还有，你怎么会心灵沟通这么牛的技能啊？", 0, 1);
	say(".....哈哈,今天天气不错啊。", 255, 1,"南贤");
	say("......", 0, 1);
	say("不管了，快去绝情谷", 0, 1);
	addevent(22,62,0,3553,3,0,22,50)
	addevent(22,63,0,3553,3,0,23,50)
	addevent(22,64,0,3553,3,0,24,50)
end



OEVENTLUA[3553] = function()
	transferme(22, 24, 26, 2)
	for i= 62, 64 do
		null(22,i)
	end
	for i= 0, 10 do
		null(7,i)
	end
	for i= 12, 17 do
		null(7,i)
	end
	instruct_39(7)
	addevent(7, 11, 1, 3554) -- 神雕
	addevent(7, 30, 1, 3555, 1, 3095*2, 14, 17) -- 杨过
	addevent(7, 32, 1, 3556, 1, 3524*2, 35, 11) -- 利剑
	addevent(7, 33, 1, 3557, 1, -2, 36, 10) -- 紫薇软剑
	addevent(7, 34, 1, 3558, 1, 3524*2, 37, 11) -- 玄铁剑
	addevent(7, 35, 1, 3559, 1, 3524*2, 38, 11) -- 木剑
	addthing(201)
	say("这断肠草应该便是情花毒的解药了。可这谷中为何空无一人？杨兄弟，龙姑娘，还有公孙止都到哪里去了呢？", 0, 1);
end

OEVENTLUA[3554] = function() -- 神雕
	say("嘎，嘎，嘎……", 226, 1,"神雕");
end


OEVENTLUA[3555] = function() -- 杨过
	JY.Person[58]["武功9"] = 45  --杨过洗玄铁
	JY.Person[58]["武功等级9"] = 999
	QZXS("杨过学会玄铁剑法！")
	say("杨兄弟？你怎么在这儿？你的手臂是怎么回事？", 0, 1);
	say("大哥，说来话长……", 172, 1,"杨过");
	say("杨过讲述了自绝情谷一别后的种种遭遇。", 928, 2);
	say("＜想到杨过一生孤苦，现今又失去了一条手臂，不禁心中难过。＞", 0, 1);
	say("是大哥没有好好照料你。想不到那郭姑娘竟下此毒手，大哥这就去襄阳，找那郭靖黄蓉讨个公道。", 0, 1);
	say("算了，大哥，我中毒已深，没有几天活头了。郭伯伯为人忠厚，为国为民，事已至此，我又何必再去令他们难过。", 172, 1,"杨过");
	say("杨兄弟，我听前辈说，这断肠草或许可解情花之毒，你不妨试它一试。", 0, 1);
	instruct_32(201,-1)
	dark()
	instruct_0();  
	addevent(7, 31, 1, 3555, 1, 3093*2, 14, 17) -- 杨过
	light()
	say("多谢大哥。大哥，我要去找姑姑。", 172, 1,"杨过");
	say("我们这就走。", 0, 1);
	--say("此时此刻，重阳宫内……", 928, 2);
	QZXS("此时此刻，重阳宫内……")
	addevent(19,63,1,0,0,3034*2,26,35)--小龙女被围攻
	addevent(19,64,1,0,0,3554*2,26,37)--金轮
	addevent(19,65,1,0,0,4499*2,26,33)--尹克西
	addevent(19,66,1,0,0,4493*2,24,35)--尼摩星
	addevent(19,67,1,0,0,4502*2,28,35)--潇湘子
	addevent(19,68,1,0,0,4548*2,24,39)--全真弟子
	addevent(19,69,1,0,0,4548*2,25,39)--全真弟子
	addevent(19,70,1,0,0,4548*2,26,39)--全真弟子
	addevent(19,71,1,0,0,4548*2,27,39)--全真弟子
	addevent(19,72,1,0,0,4548*2,28,39)--全真弟子
	addevent(19,73,1,0,0,4551*2,24,31)--全真弟子
	addevent(19,74,1,0,0,4551*2,25,31)--全真弟子
	addevent(19,75,1,0,0,4551*2,26,31)--全真弟子
	addevent(19,76,1,0,0,4551*2,27,31)--全真弟子
	addevent(19,77,1,0,0,4551*2,28,31)--全真弟子
	addevent(19,78,1,0,0,4549*2,22,33)--全真弟子
	addevent(19,79,1,0,0,4549*2,22,34)--全真弟子
	addevent(19,80,1,0,0,4549*2,22,35)--全真弟子
	addevent(19,81,1,0,0,4549*2,22,36)--全真弟子
	addevent(19,82,1,0,0,4549*2,22,37)--全真弟子
	addevent(19,83,1,0,0,4550*2,30,33)--全真弟子
	addevent(19,84,1,0,0,4550*2,30,34)--全真弟子
	addevent(19,85,1,0,0,4550*2,30,35)--全真弟子
	addevent(19,86,1,0,0,4550*2,30,36)--全真弟子
	addevent(19,87,1,0,0,4550*2,30,37)--全真弟子
	dark()
	null(7,31) -- 删除神雕洞杨过贴图
	My_Enter_SubScene2(19, 5,35, 2)
	instruct_25(5,35,26,35)--镜头移动
	light()
	say("今日我是来向全真教的道人寻仇，与旁人无干，你们快退开了。", 59, 1,"小龙女");
	say("＜赵志敬已受蒙古大汗敕封，怎能杀他？＞", 158, 1,"尹克西");
	say("这位赵真人为人很好啊，姑娘只怕有点误会。", 158, 1,"尹克西");
	say("小龙女秀眉微蹙，左手剑倏地递出，快如电闪，向尹克西刺了过去。", 928, 2);
	say("啊！", 158, 1,"尹克西");
	say("龙姑娘剑法不差，我也得领教领教！", 157, 1,"潇湘子");
	say("你们让是不让？", 59, 1,"小龙女");
	say("我们偏偏不让，你这小妖女有什么本事，一塌胡涂施展出来的？", 159, 1,"尼摩星");
	say("既不肯让，我可要得罪了！", 59, 1,"小龙女");
	JY.Person[59]["实战"]=500
	JY.Person[59]["攻击力"]=999
	JY.Person[59]["防御力"]=999
	JY.Person[59]["轻功"]=999 
	JY.Person[59]["生命最大值"] = 1500
    JY.Person[59]["生命"] = 1500
    JY.Person[59]["内力最大值"] = 10000
    JY.Person[59]["内力"] = 10000	
	JY.Person[59]["武功1"] = 112
	JY.Person[59]["武功等级1"] = 999
	JY.Person[59]["武功2"] = 107
	JY.Person[59]["武功等级2"] = 999
	JY.Person[59]["武功3"] = 106
	JY.Person[59]["武功等级3"] = 999
	JY.Person[59]["武功4"] = 119
	JY.Person[59]["武功等级4"] = 999
	JY.Person[59]["武功5"] = 108
	JY.Person[59]["武功等级5"] = 999
	JY.Person[59]["武功6"] = 103
	JY.Person[59]["武功等级6"] = 999
	JY.Person[59]["武功7"] = 101
	JY.Person[59]["武功等级7"] = 999
	QZXS("为方便测试，小龙女能力大幅提高。") --神雕重阳宫小龙女1vN，测试用
	SetS(106, 63, 1, 0, 59)
 	SetS(106, 63, 2, 0, 62)
	if WarMain(288) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end
	say("小龙女不断抓起地上被击落的长剑，一一掷上半空，待落下时，她一接住跟著又掷了上去。但见数十柄长剑此上彼落，寒光闪烁，煞是奇观。", 928, 2);
	say("当年小龙女传授杨过武功之时，要他以双掌拦住八十一只麻雀。这“天罗地网势”使将出来，活的麻雀尚能拦住，数十柄长剑随接随抛，在她自是浑若无事。她手中每一刻都有兵刃，也是每一刻都无兵刃，只瞧得潇湘子等目瞪口呆。", 928, 2);
	say("大伙一齐上啊！", 159, 1,"尼摩星");
	SetS(106, 63, 1, 0, 59)
 	SetS(106, 63, 2, 0, 62)
	if WarMain(288) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end
	dark()
	addevent(19,88,1,0,0,3058*2,28,29)
	addevent(19,89,1,0,0,3058*2,29,29)
	addevent(19,90,1,0,0,3058*2,30,29)
	addevent(19,91,1,0,0,3058*2,31,29)
	addevent(19,92,1,0,0,3058*2,32,29)
	light()
	say("金轮法王率人来攻之时，全真五子正在玉虚洞中修炼“七星聚会”，万万分心不得，直到五人练到五力归一，融合无间，这才破洞而出。", 928, 2);
	say("师父！您没事！", 204, 1,"甄志丙");
	say("丘处机等人见金轮法王等四人围著小龙女剧斗方酣。五人不禁面面相觑，都暗想原来古墓派的武功精妙若斯，要想胜她，那是终身无望了。", 928, 2);
	say("＜若是先师在世，自能胜得过他们，周师叔大概也胜他们一筹，但若同时受这四人围攻，十九要抵敌不住。＞", 68, 1,"丘处机");
	say("小龙女自闯入大殿，到这时已斗了将近一个时辰，气力渐感不支，而强敌越逼越近。丘处机等五人又环伺在侧，四下里尽是敌人，自己孤身一人，今日定要丧身重阳宫中了。", 928, 2);
	say("＜我遭际若此，一死又有什么可惜？只是临死之时，却不能见过儿一面。＞", 59, 1,"小龙女");
	say("＜他这时是在哪里呢？多半是在跟郭姑娘亲热，说不定已成了亲，新婚燕尔，怎会想到我这苦命女子在此受人围攻？＞", 59, 1,"小龙女");
	say("＜不……不！过儿不会这样，他便和郭姑娘成了亲，也决不会忘了我。我只要能再见他一面……＞", 59, 1,"小龙女");
	say("她一想到杨过，本来分心二用突然变为心有专注，再无“玉女素心剑法”的威力。法王见机，当下踏上半步，右手金轮往她剑上碰去。", 928, 2);
	say("小龙女淡淡一笑，已不愿再挣扎力抗，瞥眼望见三丈外的一株青松旁生著一丛玫瑰，花朵娇艳欲滴，突然想起当年与杨过练玉女心经的光景。", 928, 2);
	say("＜我既已见不到过儿，那便在临死之时心中想念著他。＞", 59, 1,"小龙女");
	say("龙姑娘，小心！", 204, 1,"甄志丙");
	dark()
	addevent(19,93,1,0,0,2720*2,26,36) -- 甄志丙倒地
	light()
	say("天罡北斗阵！", 68, 1,"丘处机");
	SetS(106, 63, 1, 0, 59)
 	SetS(106, 63, 2, 0, 68)
	if WarMain(288) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end
	say("各位道兄且退，这小妖女待老衲来料理罢！", 62, 1,"金轮法王");
	SetS(106, 63, 1, 0, 59)
 	SetS(106, 63, 2, 0, 68)
	if WarMain(288) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end
	teammate(58)
	--say("便在此时，法王金轮迎面砸去，全真五子那招“七星聚会”却自后心击了上来……", 928, 2);
	QZXS("便在此时，法王金轮迎面砸去，全真五子那招“七星聚会”却自后心击了上来……")
	My_Enter_SubScene2(7, 15,17, 2)
	addevent(19,94,0,3560,3,0,32,49)
end

OEVENTLUA[3556] = function() -- 利剑
	say("凌厉刚猛，无坚不摧，弱冠前以之与河朔群雄争锋。", 928, 2);
end
OEVENTLUA[3557] = function() -- 紫薇软剑
	say("紫薇软剑，三十岁前所用，误伤义士不祥，乃弃之深谷。", 928, 2);
end
OEVENTLUA[3558] = function() -- 玄铁剑
	say("重剑无锋，大巧不工，四十岁之前恃之横行天下。", 928, 2);
	SetS(106, 63, 1, 0, 0)
 	SetS(106, 63, 2, 0, 607)
	if WarMain(288) == false then
        instruct_14();   --  14(E):场景变黑
   	    instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
	else
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_14();   --  14(E):场景变黑
		instruct_0();   --  0(0)::空语句(清屏)
 		instruct_13();   --  13(D):重新显示场景
	end
	say("重剑无锋，大巧不工……好剑法！", 0, 1);
	dark()
	null(7,34)
	light()
	addthing(36)
	addthing(116)
end
OEVENTLUA[3559] = function() -- 木剑
	say("四十岁后，不滞于物，草木竹石均可为剑。自此精修，渐进于无剑胜有剑之境。", 928, 2);
	SetS(106, 63, 1, 0, 0)
 	SetS(106, 63, 2, 0, 592)
	if WarMain(288) == false then
        instruct_14();   --  14(E):场景变黑
   	    instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
	else
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_14();   --  14(E):场景变黑
		instruct_0();   --  0(0)::空语句(清屏)
 		instruct_13();   --  13(D):重新显示场景
	end

	if XYL(0) then
	say("不错嘛，独孤这小子。", 0, 1);
	else
	say("独孤前辈神技，真令人难以想像。", 0, 1);	
	end
	dark()
	null(7,35)
	light()
	addthing(302)
end

OEVENTLUA[3560] = function() -- 重阳宫决战
	say("姑姑！", 172, 1,"杨过");
	instruct_25(32,49,26,35)--镜头移动
	say("过儿，是你，这不是做梦么？", 59, 1,"小龙女");
	say("杨过窜入法王和全真五子之间，伸左臂抱起小龙女，一闪一幌，又已跃出圈子，迳自坐在青松之下、玫瑰花旁，将小龙女抱在怀里。", 928, 2);
	instruct_25(26,35,32,49)--镜头移动
	dark()
	null(19,63)
	null(19,93)
	addevent(19,64,1,0,0,4005*2,26,37)--金轮
	addevent(19,65,1,0,0,4499*2,26,33)--尹克西
	addevent(19,66,1,0,0,4495*2,24,35)--尼摩星
	addevent(19,67,1,0,0,4503*2,28,35)--潇湘子
	addevent(19,68,1,0,0,4551*2,24,39)--全真弟子
	addevent(19,69,1,0,0,4551*2,25,39)--全真弟子
	addevent(19,70,1,0,0,4551*2,26,39)--全真弟子
	addevent(19,71,1,0,0,4551*2,27,39)--全真弟子
	addevent(19,72,1,0,0,4551*2,28,39)--全真弟子
	addevent(19,73,1,0,0,4551*2,24,31)--全真弟子
	addevent(19,74,1,0,0,4551*2,25,31)--全真弟子
	addevent(19,75,1,0,0,4551*2,26,31)--全真弟子
	addevent(19,76,1,0,0,4551*2,27,31)--全真弟子
	addevent(19,77,1,0,0,4551*2,28,31)--全真弟子
	addevent(19,78,1,0,0,4551*2,22,33)--全真弟子
	addevent(19,79,1,0,0,4551*2,22,34)--全真弟子
	addevent(19,80,1,0,0,4551*2,22,35)--全真弟子
	addevent(19,81,1,0,0,4551*2,22,36)--全真弟子
	addevent(19,82,1,0,0,4551*2,22,37)--全真弟子
	addevent(19,83,1,0,0,4551*2,30,33)--全真弟子
	addevent(19,84,1,0,0,4551*2,30,34)--全真弟子
	addevent(19,85,1,0,0,4551*2,30,35)--全真弟子
	addevent(19,86,1,0,0,4551*2,30,36)--全真弟子
	addevent(19,87,1,0,0,4551*2,30,37)--全真弟子
	light()
	instruct_30(0,5,0,0);
	instruct_30(6,0,0,0);
	instruct_30(0,3,0,0);
	dark()
	addevent(19,98,1,0,1,3093*2,18,42)--杨过
	addevent(19,99,1,0,1,3621*2,18,43)--龙女
	light()
	say("过儿！你的右臂呢？怎么没了？", 59, 1,"小龙女");
	say("可怜的过儿，断了很久吗？这时还疼么？", 59, 1,"小龙女");
	say("早就不痛了。只要我见了你面，永远不跟你分开，少一条臂膀又算得什么？我一条左臂不是也能抱著你么？", 172, 1,"杨过");
	say("杨过和小龙女在无数高手虎视眈眈之下缠绵互怜，将所有强敌全都视如无物。爱到极处，富贵荣华完全不放在心上，甚至生死大事也视作等闲。", 928, 2);
	say("金轮法王，咱们的帐是今日算呢，还是留待异日？", 172, 1,"杨过");
	say("杨兄弟，恭喜你又有异遇，得了这柄威猛绝伦的神剑啊！你这件希奇古怪的法宝，只怕老衲也对付不了。", 62, 1,"金轮法王");
	say("杨兄弟，你看护好龙姑娘，这和尚就交给我了！", 0, 1);
	instruct_21(58) -- 杨过离队
	if instruct_6(74,4,0,0) ==false then    --  6(6):战斗[74]是则跳转到:Label2
        instruct_15(0);   --  15(F):战斗失败，死亡
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label2
	for i= 68,72 do
		null(19,i)
	end
	addevent(19,94,1,0,0,3983*2,26,37)--金轮
	say("法王岔了内息，惟觉郁闷欲死，委顿在地，全无抗拒之力。达尔巴举起金杵，勉力护住师父。", 928, 2);
	say("师哥，小弟回藏边勤练武功，十年后定要找上这姓杨的小子，替师父和你报仇。", 84, 1,"霍都");
	say("霍都说著转身急跃，飞也似的去了。", 928, 2);
	say("大师兄，你饶小弟一命，待我救回师父，找那狼心狗肺的师弟来碎尸万段，然后自行投上，住凭处置。要杀要剐，小弟决不敢皱一皱眉头。", 160, 1,"达尔巴");
	say("＜霍都临危逃命，此人倒是对师忠义，是条汉子。＞", 172, 1,"杨过");
	say("你去罢！", 172, 1,"杨过");
	say("谢大师兄，这是师门的典籍，还请大师兄回来。", 160, 1,"达尔巴");
	addthing(81)
	addthing(170)
	dark()
	for i= 65, 67 do
		null(19,i)
	end
	null(19,94)
	light()
	say("杨过，你武功练到了这等地步，我辈远远不及。但这里我教数百人在此，你自忖能闯出重围么？", 68, 1,"丘处机");
	say("要想动他，先过得了我这一关！", 0, 1);
	if WarMain(73) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end
	say("少侠当真要与我全真教为敌？", 68, 1,"丘处机");
	say("甄志丙呢？", 59, 1,"小龙女");
	say("龙姑娘……", 204, 1,"甄志丙");
	say("过儿，我的清白已为此人玷污，纵然伤愈，也不能和你长相厮守。但他……但他舍命救我，你也别再难为他。", 59, 1,"小龙女");
	say("师父，四位师伯师叔，弟子罪孽深重，你们千万不能难为了龙姑娘和杨过。", 204, 1,"甄志丙");
	say("甄志丙说罢纵身跃起，扑向众道士手中兀自向前挺出的八九柄长剑，数剑穿身而过，登时毙命。", 928, 2);
	say("志丙！", 68, 1,"丘处机");
	say("过儿，这时候，我在你身边死了，心里……心里很快活。只是你孤苦伶仃的一个儿，你……没人陪伴……", 59, 1,"小龙女");
	say("＜那日姑姑在终南山上，曾问我愿不愿要她做妻子，那时我愕然不答，以致生出这许多灾难困苦。眼前为时无多，务须让她明白我的心意。＞", 172, 1,"杨过");
	say("什么师徒名分，什么名节清白，咱们通通当是放屁！通通滚他妈的蛋！死也罢，活也罢，咱俩谁也没命苦，谁也不会孤苦伶仃。从今而后，你不是我师父，不是我姑姑，是我妻子。", 172, 1,"杨过");
	say("这是你的真心话么？是不是为了让我欢喜，故意说些好听言语？", 59, 1,"小龙女");
	say("当年重阳先师和我古墓派祖师婆婆原该好好结为夫妻，不知为了什么古怪礼教，弄得各自遗恨而终，咱俩今日便在重阳祖师的座前拜堂成亲，结为夫妇，让咱们祖师婆婆出了这口恶气。", 172, 1,"杨过");
	dark()
	null(19,98)
	null(19,99)
	My_Enter_SubScene2(19, 28, 27, 3)
	addevent(19,95,1,0,0,3094*2,27,22)--杨过
	addevent(19,96,1,0,0,3034*2,28,22)--小龙女
	addevent(19,73,1,0,0,4548*2,24,31)--全真弟子
	addevent(19,74,1,0,0,4548*2,25,31)--全真弟子
	addevent(19,75,1,0,0,4548*2,26,31)--全真弟子
	addevent(19,76,1,0,0,4548*2,27,31)--全真弟子
	addevent(19,77,1,0,0,4548*2,28,31)--全真弟子
	addevent(19,78,1,0,0,4548*2,22,33)--全真弟子
	addevent(19,79,1,0,0,4548*2,22,34)--全真弟子
	addevent(19,80,1,0,0,4548*2,22,35)--全真弟子
	addevent(19,81,1,0,0,4548*2,22,36)--全真弟子
	addevent(19,82,1,0,0,4548*2,22,37)--全真弟子
	addevent(19,83,1,0,0,4548*2,30,33)--全真弟子
	addevent(19,84,1,0,0,4548*2,30,34)--全真弟子
	addevent(19,85,1,0,0,4548*2,30,35)--全真弟子
	addevent(19,86,1,0,0,4548*2,30,36)--全真弟子
	addevent(19,87,1,0,0,4548*2,30,37)--全真弟子
	addevent(19,88,1,0,0,4522*2,28,29)--五子
	addevent(19,89,1,0,0,4522*2,29,29)
	addevent(19,90,1,0,0,4522*2,30,29)
	addevent(19,91,1,0,0,4522*2,31,29)
	addevent(19,92,1,0,0,4522*2,32,29)
	light()
	say("杨过，老子今天就跟你拼了！", 406, 1,"赵志敬");
	say("杨兄弟，借剑一用！", 0, 1);
	say("赵志敬提剑刺来，实是使上了毕生的修为劲力。"..JY.Person[zj()]["姓名"].."抽玄铁剑击出，势挟风雷，只听得轰然一声响，赵志敬连人带剑已飞出丈远。", 928, 2);
	dark()
	null(19,76)
	addevent(19,97,1,0,0,2720*2,26,40) -- 赵志敬倒地
	light()
	say("弟子杨过和弟子龙氏，今日在重阳祖师之前结成夫妇，此间全真教数百位道长，都是见证。", 172, 1,"杨过");
	say("我既非清白之躯，又是个垂死之人，你何必……你何必待我这样好？", 59, 1,"小龙女");
	say("老天爷只许咱们再活一天，咱们便做一天夫妻，只许咱们再活一个时辰，咱们就做一个时辰的夫妻。", 172, 1,"杨过");
	say("小龙女见杨过脸色诚恳，目光中深情无限，心中激动，真不知要怎样爱惜他才好，凄苦的脸上慢慢露出笑靥，泪珠未乾，便在蒲团上盈盈跪倒。", 928, 2);
	say("弟子杨过和龙氏真心相爱，始终不渝，愿生生世世，结为夫妇。", 172, 1,"杨过");
	say("愿祖师爷保佑，让咱俩生生世世，结为夫妇。", 59, 1,"小龙女");
	say("当年王重阳和林朝英互有深情，全真五子尽皆知晓，虽均敬仰师父挥慧剑斩情丝，是一位了不起的英雄好汉，但想到林朝英以绝世之姿、妙龄之年，竟在古墓中自闭一生，自也无不感叹。", 928, 2);
	say("撤了剑阵，让他二人去罢！", 68, 1,"丘处机");
	dark()
	for i= 73,92 do
		null(19,i)
	end
	null(19,97)
	My_Enter_SubScene2(19, 28, 27, 0)
	light()
	say("大哥，此番恩情，无以为报，但龙儿重伤，我们要先回古墓去了。", 172, 1,"杨过");
	say("＜他二人新婚燕尔，我自是不好叨扰，不过龙姑娘这伤……还须想个法子。＞", 0, 1);
	say("好，你们先去吧。", 0, 1);
	dark()
	null(19,95)
	null(19,96)
	addevent(18,30,0,3561,3,0,44,30)
	addevent(18,31,0,3561,3,0,44,31)
	light()
end

OEVENTLUA[3561] = function() -- 重阳宫决战
	My_Enter_SubScene2(18,25,30,2)
	null(18,30)
	null(18,31)
	say("这古墓之中怎会空无一人？龙姑娘重伤在身……难道……", 0, 1);
	addevent(40,81,0,3562,3,0,28,41)
	addevent(40,82,0,3562,3,0,28,42)
end

OEVENTLUA[3562] = function() -- 神雕古墓线洛阳
	dark()
	null(40,81)
	null(40,82)
	addevent(40,83,0,0,3,4602*2,20,41)--郭襄
	light()
	say("请问老兄，那襄阳围城之中，是怎生光景？", 700, 1,"酒客一");
	say("那一年蒙古十多万大军猛攻襄阳，守军统制吕大人是个昏庸无能之徒，幸蒙郭大侠夫妇奋力抗敌……", 700, 1,"酒客二");
	say("这十多年来，倘若不是襄阳坚守不屈，大宋半壁江山只怕早已不在了。", 700, 1,"酒客二");
	say("其实守城的好官各地都有，只是朝廷忠奸不分，往往奸臣享尽荣华富贵，忠臣却含冤而死。", 700, 1,"酒客三");
	say("听老弟口音，是京都临安人氏了？然则王惟忠将军受刑是的情状，老弟可曾听人说起过？", 700, 1,"酒客二");
	say("小弟还是亲眼看见呢。王将军临死时脸色兀自不变，威风凛凛，骂丁大全和陈大方祸国殃民，而且还有一件异事。", 700, 1,"酒客三");
	say("什么异事？", 700, 1,"众人");
	say("王将军是陈大方谋害的。王将军被绑赴刑场之时，在长街上高声大叫，说死后决向玉皇大帝诉冤。王将军死后第三天，那陈大方果在家中暴毙。", 700, 1,"酒客三");
	say("这位老弟的话的确不错。只不过杀陈大方的，并不是天神天将，却是一位英雄豪杰。", 700, 1,"酒客二");
	say("那陈大方家将亲兵，防卫何等周密，常人怎杀得了他？再说，要把这奸臣的首级高高挑在钟楼的檐角之上，除非是生了翅膀，才有这等本领。", 700, 1,"酒客三");
	say("本领非凡的奇人侠士，世上毕竟还是有的。但小弟若不是北眼目睹，可也真的难以相信。", 700, 1,"酒客二");
	say("这位侠客是谁？怎生模样？", 700, 1,"酒客三");
	say("这位大侠行侠仗义，好打抱不平，可是从来不肯说自己姓名，江湖上朋友见他和一头怪鸟形影不离，便送了一个外号，叫作‘神雕大侠’。", 700, 1,"酒客二");
	say("……", 0, 1);
	say("＜神雕大侠……神雕……莫非是杨兄弟？这一别不知不觉已有十六年了。＞", 0, 1);
	say("这时，旁边一位少女听得悠然神往，随手端起酒碗，喝了一大口。", 928, 2);	
	say("你们许多人都见过神雕侠，我却没福见过。若能见他一面，能听他说几句话，我……我可比什么都欢喜了。", 154, 1, "郭襄");	
	dark()
	addevent(40,84,0,0,3,4108*2,21,41)--金轮
	light()
	say("郭小姐，正好我也要找那神雕侠，我便随我来吧！", 62, 1,"金轮法王");
	dark()
	null(40,83)
	null(40,84)
	light()
	say("那人不是金轮法王么？他称那姑娘为郭小姐，莫非与郭大侠有关？看来我要去襄阳一趟了。", 0, 1);
	addevent(107,30,1,3563,1,3619*2,18,45)--郭靖
	addevent(107,31,1,3563,1,3620*2,18,46)--黄蓉
end

OEVENTLUA[3563] = function() --神雕古墓线最终战
	say("郭大侠，黄女侠。", 0, 1);
	say(JY.Person[zj()]["姓名"].."将所见之事与二人说了。", 928, 2);
	say("鞑子猛攻襄阳，我夫妇二人无法脱身，襄儿的安危，只得暂且不去理会了。", 56, 1,"黄蓉");
	say("侠之大者，为国为民。我虽算不上大侠，此事也定当尽力。", 0, 1);
	say("多谢少侠义助。", 55, 1,"郭靖");
	dark()
	My_Enter_SubScene2(107,30,51,3)
	null(107,30)
	null(107,31)
	addevent(107,32,1,0,1,4001*2,29,50)--郭靖
	addevent(107,33,1,0,1,4002*2,31,50)--黄蓉
	addevent(107,34,1,0,1,3047*2,29,48)--小兵
	addevent(107,35,1,0,1,3047*2,30,48)--
	addevent(107,36,1,0,1,3047*2,31,48)--
	addevent(107,37,1,0,1,3047*2,29,47)--
	addevent(107,38,1,0,1,3047*2,30,47)--
	addevent(107,39,1,0,1,3047*2,31,47)--	
	light()
	say("报！城外四万蒙古军队已经围住北门，筑起了一座十余丈高的高台，",700, 1,"小校");
	say("是襄儿，是襄儿。", 56, 1,"黄蓉");
	say("什么！", 55, 1,"郭靖");
	JY.Scene[38]["名称"] = "襄阳城外"
	addevent(38,20,1,0,1,3406*2,28,25)--金轮
	addevent(38,21,1,0,1,3407*2,29,25)--金轮
	addevent(38,22,1,0,1,3408*2,30,25)--金轮
	addevent(38,23,1,0,1,4602*2,32,24)--郭襄
	addevent(38,24,1,0,1,3996*2,28,37)--黄药师
	addevent(38,25,1,0,1,4120*2,29,37)--
	addevent(38,26,1,0,1,4112*2,30,37)--
	addevent(38,27,1,0,1,2703*2,27,23)--小兵
	addevent(38,28,1,0,1,2703*2,28,23)--
	addevent(38,29,1,0,1,2703*2,29,23)--
	addevent(38,30,1,0,1,2703*2,30,23)--
	addevent(38,31,1,0,1,2703*2,31,23)--
	transferme(38,29,35,0)
	for i = 32,39 do
		null(107,i)
	end
	instruct_25(29,35,29,30); --镜头移动
	say("襄儿，你别急，爹爹妈妈都来救你了！", 55, 1,"郭靖");
	say("郭大侠，令爱聪明伶俐，老衲本有意收之为徒，传以衣钵。但大汗有旨，你若不归降，便将她火焚于高台之上。此事还请三思。", 62, 1,"金轮法王");
	say("郭靖只见四个万人队将这高台守得如此严密，血肉之躯如何冲得过去？何况即使冲近了，台下军士点火烧台，又怎能救得出女儿下来？", 928, 2);
	say("襄儿听着，你是大宋的好女儿，慷慨就义，不可害怕。爹娘今日救你不得，日后定当杀了这万恶奸僧，为你报仇。懂得了么！", 55, 1,"郭靖");
	say("爹爹妈妈，女儿不怕！", 154, 1, "郭襄");
	say("金轮法王，你料敌不明，是为不智；欺侮弱女，是为不仁；不敢与我们真刀真枪决战，是为不勇。如此不智慧不仁不勇之人，还充甚么英雄好汉？你在绝情谷给我擒住，向小姑娘郭襄连磕了十八个响头求饶，她才放你。你这忘恩负义、贪生怕死之徒，还有脸面身居蒙古第一国师之位？", 57, 1, "黄药师");
	say("向郭襄磕头求饶，其实并无此事，但黄药师深谋远虑，早在发兵之前便要黄蓉将这一番斥责法王的言辞译成了蒙古话，暗暗记熟。", 928, 2);
	say("这时以丹田之气朗声说了出来，虽在千万人大呼酣战之际，仍是人人听得明白，却教法王辩也不是，不辩也不是。蒙古人自来最尊敬的是勇士，最贱视的是懦夫，众军听了黄药师这几句话，不由得仰视高台，脸有鄙色。", 928, 2);
	say("郭靖，你听着，我从一数到十，‘十’字出口，你的爱女便成焦炭。一……二……三……四……", 62, 1,"金轮法王");
	say("……", 0, 1);	
	say("八……九……十！好，举火！", 62, 1,"金轮法王");
	say("忽听得远处一声清嘶鼓风而至，霎时间似乎将那千军万马的厮杀一齐淹没。郭襄心头一凛，这啸声动人心魄，当即转头往啸声处望去，只见西北方的蒙古兵翻翻滚滚，不住向两旁散开，两个人在刀山枪林中急驱而前，犹如大船破浪冲波而行。", 928, 2);
	say("但见左首一人青冠黄衫，正是杨过；右首那人白衣飘飘，却是个美貌女子。两人各执长剑，舞起一团白光，随在神雕身后，冲向高台。", 928, 2);
	dark()
	addevent(38,32,1,0,1,3093*2,26,30)--杨过
	addevent(38,33,1,0,1,3621*2,26,31)--龙女
	addevent(38,34,1,0,1,3096*2,26,32)--神雕
	light()
	JY.Person[58]["武功10"] = 25  --杨过洗黯然
	JY.Person[58]["武功等级10"] = 999
	JY.Person[58]["等级"] = 30
	JY.Person[58]["实战"] = 250
	JY.Person[58]["攻击力"]=JY.Person[58]["攻击力"]+500
    JY.Person[58]["防御力"]=JY.Person[58]["防御力"]+500
	JY.Person[58]["轻功"]=JY.Person[58]["轻功"]+500
	JY.Person[58]["生命最大值"] = 1500
	JY.Person[58]["内力最大值"] = 10000
	QZXS("杨过学会黯然销魂掌！")
	QZXS("杨过能力大增！")
	if not JX(58) then
	setJX(58,1)
	end
	say("小妹子莫慌，我来救你。", 58, 1,"杨过");	
	say("……", 62, 1,"金轮法王");
	SetS(106, 63, 1, 0, 58)
 	SetS(106, 63, 2, 0, 62)
	if WarMain(288) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end
	null(38,20)
	null(38,21)
	null(38,22)
	addevent(38,30,1,0,1,3983*2,29,25)--金轮挂
	say("巨奸虽毙，敌军未败，咱们再战。你累不累？", 58, 1,"杨过");
	say("这四句话前三句慷慨激昂，最后一句却转成了温柔体贴的调子。小龙女听罢淡淡一笑。", 928, 2);
	say("你说上，便上罢！", 59, 1,"小龙女");
	say("回救襄阳，去杀了那鞑子大汗！", 55, 1,"郭靖");
	for i = 20,34 do
		null(38,i)
	end
	addevent(107,30,1,3563,1,3619*2,18,45)--郭靖
	addevent(107,31,1,3563,1,3620*2,18,46)--黄蓉
	addevent(107,40,1,3563,1,3093*2,18,44)--杨过
	addevent(107,41,1,3563,1,3621*2,18,43)--龙女
	transferme(107,19,45,2)
	say("杨过飞石击毙蒙古大汗蒙哥，一国之主丧于城下，令得军心大沮。蒙古军兵败如山倒，无力再南攻，襄阳城得保太平。", 928, 2);
	say("过儿，你今日立此大功，天下扬名固不待言，合城军民，无不重感恩德。", 55, 1,"郭靖");
	say("少侠，听说你在找天书，这本《神雕侠侣》，你拿去吧。", 55, 1,"郭靖");
	addthing(153)
	say("多谢郭大侠。", 0, 1);	
	say("大哥，小弟这一生受你恩惠太多，若非大哥，杨过焉能得有今日？我夫妇二人今后愿跟随大哥。", 58, 1,"杨过");
	dark()
	null(107,30)
	null(107,31)
	null(107,40)
	null(107,41)
	light()	
	teammate(58)
	teammate(59)
end

OEVENTLUA[3564] = function() --神雕一刀线，英雄大会
	if hasppl(58) == false then
		do return end
	end	
	dark()
	--右侧
	addevent(54, 52, 0, 0, 0, 2602*2, 28, 23) -- 英雄大会观众
	addevent(54, 53, 0, 0, 0, 2602*2, 29, 23) -- 英雄大会观众
	addevent(54, 54, 0, 0, 0, 2602*2, 30, 23) -- 英雄大会观众
	addevent(54, 55, 0, 0, 0, 3054*2, 31, 23) -- 英雄大会观众
	addevent(54, 56, 0, 0, 0, 3054*2, 32, 23) -- 英雄大会观众
	addevent(54, 57, 0, 0, 0, 3054*2, 33, 23) -- 英雄大会观众
	addevent(54, 58, 0, 0, 0, 2703*2, 34, 23) -- 英雄大会观众
	addevent(54, 59, 0, 0, 0, 2703*2, 35, 23) -- 英雄大会观众
	addevent(54, 60, 0, 0, 0, 2703*2, 36, 23) -- 英雄大会观众
	addevent(54, 61, 0, 0, 0, 3133*2, 37, 23) -- 英雄大会观众
	addevent(54, 62, 0, 0, 0, 3133*2, 38, 23) -- 英雄大会观众
	addevent(54, 63, 0, 0, 0, 3133*2, 39, 23) -- 英雄大会观众
	addevent(54, 64, 0, 0, 0, 2602*2, 28, 24) -- 英雄大会观众
	addevent(54, 65, 0, 0, 0, 2602*2, 29, 24) -- 英雄大会观众
	addevent(54, 66, 0, 0, 0, 2602*2, 30, 24) -- 英雄大会观众
	addevent(54, 67, 0, 0, 0, 3054*2, 31, 24) -- 英雄大会观众
	addevent(54, 68, 0, 0, 0, 3054*2, 32, 24) -- 英雄大会观众
	addevent(54, 69, 0, 0, 0, 3054*2, 33, 24) -- 英雄大会观众
	addevent(54, 70, 0, 0, 0, 2703*2, 34, 24) -- 英雄大会观众
	addevent(54, 71, 0, 0, 0, 2703*2, 35, 24) -- 英雄大会观众
	addevent(54, 72, 0, 0, 0, 2703*2, 36, 24) -- 英雄大会观众
	addevent(54, 73, 0, 0, 0, 3133*2, 37, 24) -- 英雄大会观众
	addevent(54, 74, 0, 0, 0, 3133*2, 38, 24) -- 英雄大会观众
	addevent(54, 75, 0, 0, 0, 3133*2, 39, 24) -- 英雄大会观众
	--左侧
	addevent(54, 76, 0, 0, 0, 2603*2, 28, 32) -- 英雄大会观众
	addevent(54, 77, 0, 0, 0, 2603*2, 29, 32) -- 英雄大会观众
	addevent(54, 78, 0, 0, 0, 2603*2, 30, 32) -- 英雄大会观众
	addevent(54, 79, 0, 0, 0, 3055*2, 31, 32) -- 英雄大会观众
	addevent(54, 80, 0, 0, 0, 3055*2, 32, 32) -- 英雄大会观众
	addevent(54, 81, 0, 0, 0, 3055*2, 33, 32) -- 英雄大会观众
	addevent(54, 82, 0, 0, 0, 2704*2, 34, 32) -- 英雄大会观众
	addevent(54, 83, 0, 0, 0, 2704*2, 35, 32) -- 英雄大会观众
	addevent(54, 84, 0, 0, 0, 2704*2, 36, 32) -- 英雄大会观众
	addevent(54, 85, 0, 0, 0, 3134*2, 37, 32) -- 英雄大会观众
	addevent(54, 86, 0, 0, 0, 3134*2, 38, 32) -- 英雄大会观众
	addevent(54, 87, 0, 0, 0, 3134*2, 39, 32) -- 英雄大会观众
	addevent(54, 88, 0, 0, 0, 2603*2, 28, 33) -- 英雄大会观众
	addevent(54, 89, 0, 0, 0, 2603*2, 29, 33) -- 英雄大会观众
	addevent(54, 90, 0, 0, 0, 2603*2, 30, 33) -- 英雄大会观众
	addevent(54, 91, 0, 0, 0, 3055*2, 31, 33) -- 英雄大会观众
	addevent(54, 92, 0, 0, 0, 3055*2, 32, 33) -- 英雄大会观众
	addevent(54, 93, 0, 0, 0, 3055*2, 33, 33) -- 英雄大会观众
	addevent(54, 94, 0, 0, 0, 2704*2, 34, 33) -- 英雄大会观众
	addevent(54, 95, 0, 0, 0, 2704*2, 35, 33) -- 英雄大会观众
	addevent(54, 96, 0, 0, 0, 2704*2, 36, 33) -- 英雄大会观众
	addevent(54, 97, 0, 0, 0, 3134*2, 37, 33) -- 英雄大会观众
	addevent(54, 98, 0, 0, 0, 3134*2, 38, 33) -- 英雄大会观众
	addevent(54, 99, 0, 0, 0, 3134*2, 39, 33) -- 英雄大会观众
	addevent(54, 100, 0, 0, 0, 3619*2, 26, 29) -- 郭靖
	addevent(54, 101, 0, 0, 0, 3620*2, 26, 27) -- 黄蓉
	addevent(54, 102, 0, 0, 0, 4588*2, 23, 27) -- 郭芙
	addevent(54, 103, 0, 0, 0, 4581*2, 23, 28) -- 大武
	addevent(54, 104, 0, 0, 0, 4577*2, 23, 29) -- 小武
	light()
	if JY.Base["人Y1"] == 31 then		--两个触发地方的移动方式不一样
		instruct_30(3,0,0,0);
		instruct_30(0,9,0,0);
		instruct_30(13,0,0,0);
		instruct_30(0,-2,0,0);
	else
		instruct_30(3,0,0,0);
		instruct_30(0,8,0,0);
		instruct_30(13,0,0,0);
		instruct_30(0,-2,0,0);
	end
	dark()
	addevent(54, 105, 0, 0, 0, 3094*2, 26, 24) -- 杨过
	light()
	say("黄蓉按着帮规宣布后，将历代帮主相传的打狗棒交给了鲁有脚，众弟子一齐向他唾吐，只吐得他满头满身都是痰涎，于是新帮主接任之礼告成。", 928, 2);
	say("洪老帮主有令，命我传达。", 700, 1,"丐帮弟子");
	say("恭祝洪老帮主安好！", 700, 1,"众丐");
	say("＜众人这等欢欣，我又何忍将洪老帮主逝世的讯息说了出来？何况我人微言轻，述说这等大事，他们未必肯信。我何必扫他们的兴？＞", 172, 1,"杨过");	
	say("迎接贵宾！", 700, 1,"陆冠英");
	dark()
	addevent(54, 106, 0, 0, 0, 4108*2, 31, 28) -- 金轮
	addevent(54, 107, 0, 0, 0, 3032*2, 30, 26) -- 霍都
	addevent(54, 108, 0, 0, 0, 3381*2, 33, 27) -- 达尔巴等人
	addevent(54, 109, 0, 0, 0, 3381*2, 33, 28) -- 
	addevent(54, 110, 0, 0, 0, 3381*2, 33, 29) -- 
	addevent(54, 111, 0, 0, 0, 3381*2, 34, 27) -- 
	addevent(54, 112, 0, 0, 0, 3381*2, 34, 28) -- 
	addevent(54, 113, 0, 0, 0, 3381*2, 34, 29) --
	light()
	say("各位远道到来，就请入座喝上几杯。", 55, 1,"郭靖");
	say("师父，我给你老人家引见中原两位大名鼎鼎的英雄……", 84, 1,"霍都");
	say("这位是做过咱们蒙古西征右军元帅的郭靖郭大侠，这位是郭夫人，也即是丐帮的黄帮主。", 84, 1,"霍都");
	say("这位是在下的师尊，西藏圣僧，人人尊称金轮法王，当今大蒙古国皇后封为第一护国大师。", 84, 1,"霍都");
	say("盛会难得，良时不再，天下英雄尽聚于此，依小王之见，须得推举一位群雄的盟主，领袖武林，以为天下豪杰之长，各位以为如何？", 84, 1,"霍都");
	say("这话不错。我们已推举了丐帮洪老帮主为群雄盟主，现下正在推举副盟主，阁下有何高见？", 700, 1,"雷猛");
	say("莫说洪七公此时死活难知，就算他好端端的坐在此处，凭他的武功德望，又怎及得上我师父金轮法王？", 84, 1,"霍都");
	say("群雄听了这一番话，都已明白这些人的来意。若金轮法王凭武功夺得盟主，中原豪杰虽然决不会听他号令，却也是削弱了汉人抗拒蒙的声势。", 928, 2);
	say("这样罢，咱们言明比武三场，那一方胜得两场，就取盟主之位。", 84, 1,"霍都");
	say("郭靖、黄蓉与众人低声商量，觉得对方此议实难以拒却。今日与会之人，除黄蓉不能出阵外，算来以郭靖、郝大通，和朱子柳三人武功最强。", 928, 2);
	say("蒙古乃蛮夷之邦，未受圣人教化，阁下既然请教，敝人自当指点指点。", 122, 1,"朱子柳");
	say("你出言辱我蒙古，须饶你不得！", 84, 1,"霍都");
	dark()
	light()
	say("堂上群雄一齐注目朱子柳与霍都二人，这时外面走进来一个花衣少女。她周身犹如笼罩着一层淡淡剑气，似真似幻，实非尘世中人。", 928, 2);
	say("而旁边还有一个伟岸的男子并肩而立，腰上系着一个酒葫芦。", 928, 2);
	say("师父！", 172, 1,"杨过");
	dark()
	addevent(54, 114, 0, 0, 0, 4712*2, 25, 24) -- 谢无悠
	addevent(54, 124, 0, 0, 0, 4712*2, 27, 24) -- 谢无悠
	light()	
	say("好小子，你果然在这里，看起来又长大了不少。", 597);
	say("咦，这位是？", 172, 1,"杨过");
	say("哦，这是我的夫君；老公，这就是我说的那个新徒弟。", 597);
	say("果然是好小子，今天一定要和你喝几杯。",455);
	if XYL(0) then
	say("...", 0);
say(".....................",455)
say(".....................",0)
	say("谢宗主也在啊。。。",455);
say(".....................",455)
say(".....................",0)
    say("....那丫头，算了，帮我照顾好她<心里松了一口气>。",0)
    say("这是自然。",455)
	end
	dark()
	for i = 106, 113 do
		null(54,i)
	end
	addevent(54, 116, 0, 0, 0, 3033*2, 33, 28) -- 霍都上场
	addevent(54, 117, 0, 0, 0, 4108*2, 37, 26) -- 金轮
	addevent(54, 118, 0, 0, 0, 3381*2, 37, 27) -- 达尔巴等人
	addevent(54, 119, 0, 0, 0, 3381*2, 37, 28) -- 
	addevent(54, 120, 0, 0, 0, 3381*2, 37, 29) -- 
	addevent(54, 121, 0, 0, 0, 3381*2, 38, 27) -- 
	addevent(54, 122, 0, 0, 0, 3381*2, 38, 28) -- 
	addevent(54, 123, 0, 0, 0, 3381*2, 38, 29) --
	light()
	say("霍都使诈用暗器偷袭胜了第一场，第二场达尔巴与点苍渔隐以力相拼，铁桨竟被黄金杵震断。", 928, 2);
	say("咱们言明在先，三赛两胜。各位说过的话，算人话不算？", 84, 1,"霍都");
	say("今日争武林盟主，都是徒弟替师父打架，是也不是？", 172, 1,"杨过");
	say("不错，我们三场中胜了两场，因此我师父是盟主。", 84, 1,"霍都");
	say("就算你胜了他们，那又怎地？我师父的徒弟你可没打胜。", 172, 1,"杨过");
	say("你师父的徒弟是谁？", 84, 1,"霍都");
	say("蠢才！我师父的徒弟，自然是我。", 172, 1,"杨过");
	say("众人听他说到此处，均想莫非他师父当真是大有来头的人物，要来争武林盟主，不管他师父是谁，总是汉人，自胜于让蒙古国师抢了盟主去。", 928, 2);
	say("对，对，除非你们蒙古人再胜得两场。", 700, 1,"众人");
	dark()
	null(54,105)
	addevent(54, 115, 0, 0, 0, 3093*2, 29, 28) -- 杨过上场
	light()	
	say("天下英雄请了，小王杀此顽童，那是他自取其咎，须怪不得小王。", 84, 1,"霍都");
	say("天下英雄请了，小顽童杀此王子，那是他自取其咎，须怪不得小顽童！", 172, 1,"杨过");
	SetS(106, 63, 1, 0, 58)
   	SetS(106, 63, 2, 0, 84)
	if WarMain(288) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end	
	say("我三番四次提醒，要放暗器了，要放暗器了，你总是不信。可没骗你，是不是？", 172, 1,"杨过");
	say("小孩子，我来和你比武！＜藏语＞", 160, 1,"达尔巴");
	say("达尔巴说罢，金刚杵横扫，疾向杨过腰间打去。杨过双脚不动，腰身向后缩了尺许，金刚杵恰好在他腰前掠过。", 928, 2);
	dark()
	null(54,116)
	null(54,118)
	addevent(54, 124, 0, 0, 0, 4490*2, 33, 28) -- 达尔巴上场
	light()
	say("小孩子的功夫很不错，是谁教你的啊？＜藏语＞", 160, 1,"达尔巴");
	say("＜这和尚叽哩咕噜说什么？想来是在骂我，待我学他骂回去。＞", 172, 1,"杨过");
	say("小孩子的功夫很不错，是谁教你的啊？＜这几个字发音既准，次序也是丝毫不乱＞", 172, 1,"杨过");
	say("我师父是金轮法王。我又不是小孩子，你该叫我大和尚。＜藏语＞", 160, 1,"达尔巴");
	say("＜不管你如何恶毒的骂我，我只要全盘奉还，口头上就不会输了。＞", 172, 1,"杨过");
	say("我师父是金轮法王。我又不是小孩子，你该叫我大和尚。＜藏语＞", 172, 1,"杨过");
	say("我是法王的首代弟子，你是第几代的？＜藏语＞", 160, 1,"达尔巴");
	say("我是法王的首代弟子，你是第几代的？＜藏语＞", 172, 1,"杨过");
	say("＜师傅早年曾收过一个弟子，可这弟子不到二十岁就死了，这人莫非是大师兄转世？否则他年纪轻轻，怎能有如此武功？＞", 160, 1,"达尔巴");
	say("大师兄，师弟达尔巴参见。＜藏语＞", 160, 1,"达尔巴");
	say("…………", 62, 1,"金轮法王");
	say("达尔巴，他不是你大师兄转世，快起来跟他比武。＜藏语＞", 62, 1,"金轮法王");
	if XYL(0) then
	say("不必了。＜藏语＞，小子，你先下去，看你欢哥的手段", 455);
	say("一刀流的事一刀流解决，你一边去", 0);
	SetS(106, 63, 1, 0, 0)
   	SetS(106, 63, 2, 0, 160)
	else
	say("不必了。＜藏语＞，小子，你先下去，看你欢哥的手段", 455);
	SetS(106, 63, 1, 0, 455)
   	SetS(106, 63, 2, 0, 160)
	end
	if WarMain(288) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end
	say("我们又胜了第二场！武林盟主是大宋高手！蒙古鞑子快快滚出去罢，别来中原现世啦！", 700, 1,"众人");
	dark()
	null(54,124)
	null(54,117)
	addevent(54, 125, 0, 0, 0, 4108*2, 33, 28) -- 金轮上场
	light()
	say("少年，你的师父是谁？", 62, 1,"金轮法王");
	dark()
	null(54,114)
	addevent(54, 126, 0, 0, 0, 4712*2, 29, 27) -- 无悠上场
	light()
	say("我师父就是这一位，你快来拜见武林盟主罢！", 172, 1,"杨过");
	say("哼，你这小丫头也配做武林盟主？只要你接得住我这金轮的十招，我就认你是盟主。", 62, 1,"金轮法王");
	say("死秃驴，你说谁呢？好，今天你要是能接我一剑，我谢无悠的名字倒过来念", 597);
	SetS(106, 63, 1, 0, 597)
 	SetS(106, 63, 2, 0, 62)
	if WarMain(288) == false then
        instruct_14();   --  14(E):场景变黑
   	    instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
	else
		addHZ(125)
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_14();   --  14(E):场景变黑
		instruct_0();   --  0(0)::空语句(清屏)
 		instruct_13();   --  13(D):重新显示场景
	end
	say("呔，九天一流奥义.一之太刀", 597);
	say("只见刀光一闪，两人身形似乎都未挪动，但见金轮法王眼睛瞪得很大，似乎要说什么。", 928, 2);
	say("忽见金轮袈裟断开滑落，全身血光四溅，从身上的各处喷溅出鲜血，然后颓然倒地，须臾间地上已形成了不小的血泊。", 928, 2);
	say("切，不堪一击，连我一刀都接不住", 597);
	say("还不认输？你们的师父都被废了，还有甚么脸面？世上可有全身喷血的武林盟主么？", 172, 1,"杨过");
	say("我们也不难为你，你们大多儿好好的去罢。", 172, 1,"杨过");
	say("郭大侠，黄帮主，今日领教高招。青山不改，绿水长流，咱们后会有期。", 84, 1,"霍都");
	say("说着，和达尔巴一起背起金轮法王，几个起落，就不见了踪影。", 928, 2);
	say("哈哈，逃得还真快。", 172, 1,"杨过");
	say("把袈裟都给忘了，里面还有本书。", 172, 1,"杨过");
    addthing(81)
	dark()
	null(54,126)
	null(54,115)
	null(54,125)
	for i = 119, 123 do
		null(54,i)
	end
	addevent(54, 105, 0, 0, 0, 3094*2, 26, 24) -- 杨过
	addevent(54, 114, 0, 0, 0, 4712*2, 25, 24) -- 龙女
	light()
	say("天下竟有如此高手，实在让郭某大开眼界，这武林盟主还非姑娘你莫属……", 55, 1,"郭靖");
	say("承让，承让", 597);
	say("龙姑娘，令徒过世了的父亲当年与在下有八拜之交。杨郭两家累世交好，在下单生一女，相貌与武功都还过得去……", 55, 1,"郭靖");
	say("在下意欲将小女许配给贤徒。他父母都已过世，此事须得请龙姑娘作主。", 55, 1,"郭靖");
	say("他的事由他自己做主，不用过问我。", 597);
	say("无悠说得对啊", 35,0,"无酒不欢");
	say("我不愿意娶郭芙。", 172, 1,"杨过");
	say("我要和师父一起闯荡江湖。", 172, 1,"杨过");
	say("乖徒儿，师父心愿已了，要回刀宗去了，你不如跟着你大哥闯荡江湖，也有个照应。", 597);
    say("华山那个隔壁的大叔也有东西要交给你，你可以好好用用，虽然不如咱们的斩流剑法，但也很不错。", 597);
	JY.Person[58]["武功9"] = 45  --杨过洗玄铁
	JY.Person[58]["武功等级9"] = 999
	addthing(36)
	addthing(116)
	addthing(302)
	QZXS("杨过学会玄铁剑法！")
	setJX(58,1)
	QZXS("杨过领悟【玄铁九剑奥义】！")
    say("看来二哥蛮看好你的，把他的绝学都给你了",35,0,"无酒不欢");
    if	XYL(0) then
	say("你要我做的事我做完了，这小子还给你", 597);
	say("有空回刀宗看我，不然...", 597);
	say("<打一寒战>，好的。", 0, 1);	
	else
	say("我这徒儿就交给你了，你要好好照顾他。少一个汗毛，我也把你做成喷泉", 597);
	say("<打一寒战>，好的。", 0, 1);
	end
	say("武林盟主，哈哈，真无聊，我去也！", 597);
	null(54,114)
	say("大哥，我想回古墓看看婆婆，然后去全真教找回当年的场子。", 58, 1,"杨过");
	say("过儿，你可要立定脚跟，好好做人，别闹得身败名裂。你的名字是我取的，你可知这个‘过’字的用意么？", 55, 1,"郭靖");
	say("若是我错了，自然要改。可赵志敬那个牛鼻子老道对我不是打就是骂，这个场子一定要找回来", 172, 1,"杨过");
	say("过儿，赵道长是你师父，你怎么能这么说他", 55, 1,"郭靖");
	say("赵志敬这个狗贼，我恨不得喝他的血吃他的肉，他算哪门子师父，我一定要找他报仇", 172, 1,"杨过");
	say("这番话当真是语惊四座。当时人哪里听见过这般叛逆之伦？郭靖一生最是敬重师父，只听得气向上冲，抢上一步，伸手便往杨过胸口抓去。", 928, 2);
	say("冤有头，债有主，我和全真教势不两立。郭伯伯，你要杀我便下手，我这主意是永生永世不改的。", 172, 1,"杨过");
	say("郭靖左掌在空际停留片时，又向杨过瞧了一眼，但见他咬紧口唇，双眉紧蹙，宛似杨康当年的模样，心中一阵酸痛，长叹一声，放松了他领口。", 928, 2);
	say("你好好的想想去罢。", 55, 1,"郭靖");
	say("大哥，这些人横蛮得紧，我走了。", 172, 1,"杨过");
	say("群雄眼睁睁的望著他的背影，有的鄙夷，有的惋惜，有的愤怒，有的惊诧。", 928, 2);
	say("这位兄弟，还请你好好规劝过儿，不要误入歧途", 55, 1,"郭靖");
	say("郭大侠，您放心，我会好好看着杨兄弟", 0, 1);
	dark()
	for i = 50, 105 do
		null(54,i)
	end
	instruct_21(58) -- 杨过离队
	addevent(18, 24, 1, 3565, 1, 3093*2, 15, 16)--古墓杨过
	light()
	say("想不到事态竟有如此发展，我得赶快去古墓。", 0, 1);
end

OEVENTLUA[3565] = function() -- 回古墓
    null(18,25)
	say("杨兄弟，你在这儿啊？怎么不见那位婆婆？", 0, 1);
	say("大哥，婆婆让赵志敬那个老贼给害死了，她临终之前托付我照顾龙姑姑。", 58, 1,"杨过");
	say("那龙姑娘呢？", 0, 1);
	say("我来的时候，她已经不在了，听婆婆说，她去重阳宫了。", 58, 1,"杨过");
	say("不好，我来的时候看见金轮那个秃驴也带着一帮人在上山！", 0, 1);
	say("那我们赶快去，姑姑有危险。", 58, 1,"杨过");
	dark()
	null(18,24)
	--say("此时此刻，重阳宫内……", 928, 2);
	QZXS("此时此刻，重阳宫内……")
	addevent(19,63,1,0,0,3034*2,26,35)--小龙女被围攻
	addevent(19,64,1,0,0,3554*2,26,37)--金轮
	addevent(19,65,1,0,0,4499*2,26,33)--尹克西
	addevent(19,66,1,0,0,4493*2,24,35)--尼摩星
	addevent(19,67,1,0,0,4502*2,28,35)--潇湘子
	addevent(19,68,1,0,0,4548*2,24,39)--全真弟子
	addevent(19,69,1,0,0,4548*2,25,39)--全真弟子
	addevent(19,70,1,0,0,4548*2,26,39)--全真弟子
	addevent(19,71,1,0,0,4548*2,27,39)--全真弟子
	addevent(19,72,1,0,0,4548*2,28,39)--全真弟子
	addevent(19,73,1,0,0,4551*2,24,31)--全真弟子
	addevent(19,74,1,0,0,4551*2,25,31)--全真弟子
	addevent(19,75,1,0,0,4551*2,26,31)--全真弟子
	addevent(19,76,1,0,0,4551*2,27,31)--全真弟子
	addevent(19,77,1,0,0,4551*2,28,31)--全真弟子
	addevent(19,78,1,0,0,4549*2,22,33)--全真弟子
	addevent(19,79,1,0,0,4549*2,22,34)--全真弟子
	addevent(19,80,1,0,0,4549*2,22,35)--全真弟子
	addevent(19,81,1,0,0,4549*2,22,36)--全真弟子
	addevent(19,82,1,0,0,4549*2,22,37)--全真弟子
	addevent(19,83,1,0,0,4550*2,30,33)--全真弟子
	addevent(19,84,1,0,0,4550*2,30,34)--全真弟子
	addevent(19,85,1,0,0,4550*2,30,35)--全真弟子
	addevent(19,86,1,0,0,4550*2,30,36)--全真弟子
	addevent(19,87,1,0,0,4550*2,30,37)--全真弟子
	dark()
	null(18,31) -- 删除神雕洞杨过贴图
	My_Enter_SubScene2(19, 5,35, 2)
	instruct_25(5,35,26,35)--镜头移动
	light()
	say("今日我是来向全真教的道人寻仇，与旁人无干，你们快退开了。", 59, 1,"小龙女");
	say("＜赵志敬已受蒙古大汗敕封，怎能杀他？＞", 158, 1,"尹克西");
	say("这位赵真人为人很好啊，姑娘只怕有点误会。", 158, 1,"尹克西");
	say("小龙女秀眉微蹙，左手剑倏地递出，快如电闪，向尹克西刺了过去。", 928, 2);
	say("啊！", 158, 1,"尹克西");
	say("龙姑娘剑法不差，我也得领教领教！", 157, 1,"潇湘子");
	say("你们让是不让？", 59, 1,"小龙女");
	say("我们偏偏不让，你这小妖女有什么本事，一塌胡涂施展出来的？", 159, 1,"尼摩星");
	say("既不肯让，我可要得罪了！", 59, 1,"小龙女");
	JY.Person[59]["实战"]=500
	JY.Person[59]["攻击力"]=999
	JY.Person[59]["防御力"]=999
	JY.Person[59]["轻功"]=999 
	JY.Person[59]["生命最大值"] = 1500
    JY.Person[59]["生命"] = 1500
    JY.Person[59]["内力最大值"] = 10000
    JY.Person[59]["内力"] = 10000	
	JY.Person[59]["武功1"] = 112
	JY.Person[59]["武功等级1"] = 999
	JY.Person[59]["武功2"] = 107
	JY.Person[59]["武功等级2"] = 999
	JY.Person[59]["武功3"] = 106
	JY.Person[59]["武功等级3"] = 999
	JY.Person[59]["武功4"] = 119
	JY.Person[59]["武功等级4"] = 999
	JY.Person[59]["武功5"] = 108
	JY.Person[59]["武功等级5"] = 999
	JY.Person[59]["武功6"] = 103
	JY.Person[59]["武功等级6"] = 999
	JY.Person[59]["武功7"] = 101
	JY.Person[59]["武功等级7"] = 999
	QZXS("为方便测试，小龙女能力大幅提高。") --神雕重阳宫小龙女1vN，测试用
	SetS(106, 63, 1, 0, 59)
 	SetS(106, 63, 2, 0, 62)
	if WarMain(288) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end
	say("小龙女不断抓起地上被击落的长剑，一一掷上半空，待落下时，她一接住跟著又掷了上去。但见数十柄长剑此上彼落，寒光闪烁，煞是奇观。", 928, 2);
	say("当年小龙女传授杨过武功之时，要他以双掌拦住八十一只麻雀。这“天罗地网势”使将出来，活的麻雀尚能拦住，数十柄长剑随接随抛，在她自是浑若无事。她手中每一刻都有兵刃，也是每一刻都无兵刃，只瞧得潇湘子等目瞪口呆。", 928, 2);
	say("大伙一齐上啊！", 159, 1,"尼摩星");
	SetS(106, 63, 1, 0, 59)
 	SetS(106, 63, 2, 0, 62)
	if WarMain(288) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end
	dark()
	addevent(19,88,1,0,0,3058*2,28,29)
	addevent(19,89,1,0,0,3058*2,29,29)
	addevent(19,90,1,0,0,3058*2,30,29)
	addevent(19,91,1,0,0,3058*2,31,29)
	addevent(19,92,1,0,0,3058*2,32,29)
	light()
	say("金轮法王率人来攻之时，全真五子正在玉虚洞中修炼“七星聚会”，万万分心不得，直到五人练到五力归一，融合无间，这才破洞而出。", 928, 2);
	say("师父！您没事！", 204, 1,"甄志丙");
	say("丘处机等人见金轮法王等四人围著小龙女剧斗方酣。五人不禁面面相觑，都暗想原来古墓派的武功精妙若斯，要想胜她，那是终身无望了。", 928, 2);
	say("＜若是先师在世，自能胜得过他们，周师叔大概也胜他们一筹，但若同时受这四人围攻，十九要抵敌不住。＞", 68, 1,"丘处机");
	say("小龙女自闯入大殿，到这时已斗了将近一个时辰，气力渐感不支，而强敌越逼越近。丘处机等五人又环伺在侧，四下里尽是敌人，自己孤身一人，今日定要丧身重阳宫中了。", 928, 2);
	say("＜我遭际若此，一死又有什么可惜？只是临死之时，却不能为婆婆报仇。＞", 59, 1,"小龙女");
	say("她一想到婆婆，本来分心二用突然变为心有专注，再无“玉女素心剑法”的威力。法王见机，当下踏上半步，右手金轮往她剑上碰去。", 928, 2);
	say("小龙女淡淡一笑，已不愿再挣扎力抗，瞥眼望见三丈外的一株青松旁生著一丛玫瑰，花朵娇艳欲滴，突然想起当年与杨过初见的光景。", 928, 2);
	say("＜不知道当年那个小子长成怎样了＞", 59, 1,"小龙女");
	say("＜奇怪，怎么突然想到那个小子了＞", 59, 1,"小龙女");
	say("＜过儿....＞", 59, 1,"小龙女");
	dark()
	light()
	QZXS("便在此时，法王金轮迎面砸去，全真五子那招“七星聚会”却自后心击了上来……")
	teammate(58)
	My_Enter_SubScene2(18, 15,17, 2)
	addevent(19,94,0,3566,3,0,32,49)
end

OEVENTLUA[3566] = function() -- 重阳宫决战
	say("姑姑！", 172, 1,"杨过");
	instruct_25(32,49,26,35)--镜头移动
	say("过儿，难道是你？", 59, 1,"小龙女");
	say("杨过窜入法王和全真五子之间，伸左臂抱起小龙女，一闪一幌，又已跃出圈子，迳自坐在青松之下、玫瑰花旁，将小龙女抱在怀里。", 928, 2);
	instruct_25(26,35,32,49)--镜头移动
	dark()
	null(19,63)
	null(19,93)
	addevent(19,64,1,0,0,4005*2,26,37)--金轮
	addevent(19,65,1,0,0,4499*2,26,33)--尹克西
	addevent(19,66,1,0,0,4495*2,24,35)--尼摩星
	addevent(19,67,1,0,0,4503*2,28,35)--潇湘子
	addevent(19,68,1,0,0,4551*2,24,39)--全真弟子
	addevent(19,69,1,0,0,4551*2,25,39)--全真弟子
	addevent(19,70,1,0,0,4551*2,26,39)--全真弟子
	addevent(19,71,1,0,0,4551*2,27,39)--全真弟子
	addevent(19,72,1,0,0,4551*2,28,39)--全真弟子
	addevent(19,73,1,0,0,4551*2,24,31)--全真弟子
	addevent(19,74,1,0,0,4551*2,25,31)--全真弟子
	addevent(19,75,1,0,0,4551*2,26,31)--全真弟子
	addevent(19,76,1,0,0,4551*2,27,31)--全真弟子
	addevent(19,77,1,0,0,4551*2,28,31)--全真弟子
	addevent(19,78,1,0,0,4551*2,22,33)--全真弟子
	addevent(19,79,1,0,0,4551*2,22,34)--全真弟子
	addevent(19,80,1,0,0,4551*2,22,35)--全真弟子
	addevent(19,81,1,0,0,4551*2,22,36)--全真弟子
	addevent(19,82,1,0,0,4551*2,22,37)--全真弟子
	addevent(19,83,1,0,0,4551*2,30,33)--全真弟子
	addevent(19,84,1,0,0,4551*2,30,34)--全真弟子
	addevent(19,85,1,0,0,4551*2,30,35)--全真弟子
	addevent(19,86,1,0,0,4551*2,30,36)--全真弟子
	addevent(19,87,1,0,0,4551*2,30,37)--全真弟子
	light()
	instruct_30(0,5,0,0);
	instruct_30(6,0,0,0);
	instruct_30(0,3,0,0);
	dark()
	addevent(19,98,1,0,1,3093*2,18,42)--杨过
	addevent(19,99,1,0,1,3621*2,18,43)--龙女
	light()
	say("过儿！当年将你逐出古墓，你可曾怪我？", 59, 1,"小龙女");
	say("早就不怪了。只要我见了你面，永远不跟你分开，", 172, 1,"杨过");
	say("没想到我在临死之前还能再见到你", 59, 1,"小龙女");
	say("别说这么丧气的话，来日方长呢！", 172, 1,"杨过");
	say("杨过和小龙女在无数高手虎视眈眈之下缠绵互怜，将所有强敌全都视如无物。", 928, 2);
	say("金轮法王，咱们的帐是今日算呢，还是留待异日？", 172, 1,"杨过");
	say("呸，臭小子，你师父给我带来的伤痛，我要你一并偿还。", 62, 1,"金轮法王");
	say("杨兄弟，你看护好龙姑娘，这和尚就交给我了！", 0, 1);
	instruct_21(58) -- 杨过离队
	if instruct_6(74,4,0,0) ==false then    --  6(6):战斗[74]是则跳转到:Label2
        instruct_15(0);   --  15(F):战斗失败，死亡
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label2
	for i= 68,72 do
		null(19,i)
	end
	addevent(19,94,1,0,0,3983*2,26,37)--金轮
	say("法王岔了内息，惟觉郁闷欲死，委顿在地，全无抗拒之力。达尔巴举起金杵，勉力护住师父。", 928, 2);
	say("师哥，小弟回藏边勤练武功，十年后定要找上这姓杨的小子，替师父和你报仇。", 84, 1,"霍都");
	say("霍都说著转身急跃，飞也似的去了。", 928, 2);
	say("大师兄，你饶小弟一命，待我救回师父，找那狼心狗肺的师弟来碎尸万段，然后自行投上，住凭处置。要杀要剐，小弟决不敢皱一皱眉头。", 160, 1,"达尔巴");
	say("＜霍都临危逃命，此人倒是对师忠义，是条汉子。＞", 172, 1,"杨过");
	say("你去罢！", 172, 1,"杨过");
	dark()
	for i= 65, 67 do
		null(19,i)
	end
	null(19,94)
	light()
	say("杨过，你武功练到了这等地步，我辈远远不及。但这里我教数百人在此，你自忖能闯出重围么？", 68, 1,"丘处机");
	say("要想动他，先过得了我这一关！", 0, 1);
	if WarMain(73) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end
	say("少侠当真要与我全真教为敌？", 68, 1,"丘处机");
	say("赵志敬呢？", 59, 1,"小龙女");
	say("让那个牛鼻子道士出来，今天一定要他血债血偿", 172, 1,"杨过");
	dark()
	null(19,98)
	null(19,99)
	My_Enter_SubScene2(19, 28, 27, 3)
	addevent(19,95,1,0,0,3094*2,27,22)--杨过
	addevent(19,96,1,0,0,3034*2,28,22)--小龙女
	addevent(19,73,1,0,0,4548*2,24,31)--全真弟子
	addevent(19,74,1,0,0,4548*2,25,31)--全真弟子
	addevent(19,75,1,0,0,4548*2,26,31)--全真弟子
	addevent(19,76,1,0,0,4548*2,27,31)--全真弟子
	addevent(19,77,1,0,0,4548*2,28,31)--全真弟子
	addevent(19,78,1,0,0,4548*2,22,33)--全真弟子
	addevent(19,79,1,0,0,4548*2,22,34)--全真弟子
	addevent(19,80,1,0,0,4548*2,22,35)--全真弟子
	addevent(19,81,1,0,0,4548*2,22,36)--全真弟子
	addevent(19,82,1,0,0,4548*2,22,37)--全真弟子
	addevent(19,83,1,0,0,4548*2,30,33)--全真弟子
	addevent(19,84,1,0,0,4548*2,30,34)--全真弟子
	addevent(19,85,1,0,0,4548*2,30,35)--全真弟子
	addevent(19,86,1,0,0,4548*2,30,36)--全真弟子
	addevent(19,87,1,0,0,4548*2,30,37)--全真弟子
	addevent(19,88,1,0,0,4522*2,28,29)--五子
	addevent(19,89,1,0,0,4522*2,29,29)
	addevent(19,90,1,0,0,4522*2,30,29)
	addevent(19,91,1,0,0,4522*2,31,29)
	addevent(19,92,1,0,0,4522*2,32,29)
	light()
	say("杨过，老子今天就跟你拼了！", 406, 1,"赵志敬");
	say("杨兄弟，借剑一用！", 0, 1);
	say("赵志敬提剑刺来，实是使上了毕生的修为劲力。"..JY.Person[zj()]["姓名"].."抽玄铁剑击出，势挟风雷，只听得轰然一声响，赵志敬连人带剑已飞出丈远。", 928, 2);
	dark()
	null(19,76)
	addevent(19,97,1,0,0,2720*2,26,40) -- 赵志敬倒地
	light()
	say("弟子杨过和弟子龙氏，今日在重阳祖师之前结成夫妇，此间全真教数百位道长，都是见证。", 172, 1,"杨过");
	say("我当年将你逐出古墓，现又是个垂死之人，你何必……你何必待我这样好？", 59, 1,"小龙女");
	say("我一生境遇悲惨，当年也得到你和婆婆的照顾，虽然只有几天，但我真的看到了人生的光芒", 172, 1,"杨过");
	say("世上待我好的人不多，有大哥，有师傅，有义父，有孙婆婆，还有你，姑姑。", 172, 1,"杨过");
	say("老天爷只许咱们再活一天，咱们便做一天夫妻，只许咱们再活一个时辰，咱们就做一个时辰的夫妻。", 172, 1,"杨过");
	say("小龙女见杨过脸色诚恳，目光中深情无限，心中激动，真不知要怎样爱惜他才好，凄苦的脸上慢慢露出笑靥，泪珠未乾，便在蒲团上盈盈跪倒。", 928, 2);
	say("弟子杨过和龙氏真心相爱，始终不渝，愿生生世世，结为夫妇。", 172, 1,"杨过");
	say("愿祖师爷保佑，让咱俩生生世世，结为夫妇。", 59, 1,"小龙女");
	say("当年王重阳和林朝英互有深情，全真五子尽皆知晓，虽均敬仰师父挥慧剑斩情丝，是一位了不起的英雄好汉，但想到林朝英以绝世之姿、妙龄之年，竟在古墓中自闭一生，自也无不感叹。", 928, 2);
	say("撤了剑阵，让他二人去罢！", 68, 1,"丘处机");
	dark()
	for i= 73,92 do
		null(19,i)
	end
	null(19,97)
	My_Enter_SubScene2(19, 28, 27, 0)
	light()
	say("大哥，此番恩情，无以为报，但龙儿重伤，我们要先回古墓去了。", 172, 1,"杨过");
	say("＜他二人新婚燕尔，我自是不好叨扰，不过龙姑娘这伤……还须想个法子。＞", 0, 1);
	say("好，你们先去吧。", 0, 1);
	dark()
	null(19,95)
	null(19,96)
	addevent(18,30,0,3561,3,0,44,30)
	addevent(18,31,0,3561,3,0,44,31)
	light()
end
