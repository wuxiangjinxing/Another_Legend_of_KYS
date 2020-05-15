--滚动文字
function DrawTimer()
    local t2 = lib.GetTime();
	local name
	if JY.Status==GAME_SMAP or JY.Status==GAME_MMAP then
	if CC.Timer.status==0  then
	if  GetS(92,60,20,5)==1 then
	SetS(92,60,13,5,0);
	SetS(92,60,10,5,0);
	end
	if GetS(92,60,13,5) == 1 then
	if GetS(92,60,16,5)==419 or GetS(92,60,16,5)==440 then
		name="传说中的"
		else
		name="魔头"
		end
		    CC.Timer.status=1;
			CC.Timer.str="紧急召集令："..name..JY.Person[GetS(92,60,16,5)]["姓名"].."在"..JY.Scene[GetS(92,60,14,5)]["名称"].."现身了！大家快去为民除害！★"
			CC.Timer.len=string.len(CC.Timer.str)/2+3;
		    CC.Timer.pic=4360
			
			SetS(92,60,10,5,GetS(92,60,10,5)+1);
			
			if GetS(92,60,10,5)==3 then 
			SetS(92,60,13,5,0);
			SetS(92,60,10,5,0); 
			end
		
		end
		
		if GetS(92,60,12,5)==1 then 
		local tt1=GetS(92,60,21,5)
		local tt2=GetS(92,60,22,5)
		local tt3=GetS(92,60,24,5)
		local tt4=GetS(92,60,25,5)
		
		if  (tt1*60+tt2)- (tt3*60+tt4)>=(5-GetS(92,60,33,5)) then 
		SetS(92,60,15,5,1);
		SetS(92,60,27,5,2)
		JL()
		SetS(92,60,12,5,0); 
		end
		end
		if GetS(92,60,15,5)==1 then 
		local DD=GetS(92,60,14,5);
		local x=GetS(92,60,18,5)
        local y=GetS(92,60,19,5)
		SetS(92,60,11,5,1);
		SetS(92,60,12,5,2); 
		SetS(DD,x,y,2,0);
        SetS(DD,x,y,5,0);
		instruct_3(DD,168,0,0,0,0,0,0,0,0,0,0,0);
		SetS(DD,x,y,3,-1) 
		if GetS(92,60,16,5)==419 or GetS(92,60,16,5)==440 then
		name="魔物"
		else
		name="魔头"
		end
		local bq ={4365,4367}
		local xmb={"攻击力","防御力","轻功","拳掌功夫","御剑能力","特殊兵器","耍刀技巧"}
		local rw=GetS(92,60,28,5)
		local jl=GetS(92,60,29,5)
		local xm=GetS(92,60,30,5)
		    CC.Timer.status=1;
			CC.Timer.str=name..JY.Person[GetS(92,60,16,5)]["姓名"].."被"..JY.Person[rw]["姓名"].."给打跑了（"..JY.Person[rw]["姓名"]..xmb[xm].."增加了"..jl.."），江湖传为佳话！★"
			CC.Timer.len=string.len(CC.Timer.str)/2+3;
		    CC.Timer.pic=bq[math.random(2)]
			SetS(92,60,10,5,GetS(92,60,10,5)+1);
			
			if GetS(92,60,10,5)==3 then 
			SetS(92,60,12,5,0); 
			SetS(92,60,11,5,0);
			SetS(92,60,15,5,0); 
			SetS(92,60,10,5,0);
			end
		end
		if t2-CC.Timer.stime>10000 and  GetS(92,60,31,5)==0 and  GetS(92,60,13,5) ==0 and GetS(92,60,15,5) ==0 then 
			SetS(92,60,26,5,1);
			CC.Timer.stime=t2;
			CC.Timer.status=1;
			CC.Timer.str=CC.RUNSTR[math.random(#CC.RUNSTR)];
			CC.Timer.len=string.len(CC.Timer.str)/2+3;
			CC.Timer.pic=4359 
		end
		if GetS(92,60,26,5)==0 and math.random(5000)<(GetS(92,60,32,5)*35+5) and GetS(92,60,11,5) == 0  and GetS(92,60,13,5) ==0 and GetS(92,60,15,5) ==0 then
		    
			if GetS(92,60,12,5)==0 then 
			SetS(92,60,20,5,0); 
			SJRW(1);
			SetS(92,60,13,5,1);
			SetS(92,60,23,5,1);
			SetS(92,60,12,5,1); 
			end
		
		end
		
	else
		CC.Timer.fun(t2);
	end
	end
end


--处理时间字符串，显示时间专用
function demostr(t)
  local tt = t - CC.Timer.stime
  tt = math.modf(tt / 10) % (CC.ScreenW + CC.Timer.len * CC.Fontsmall)
  if runword(CC.Timer.str, C_GOLD, CC.Fontsmall, 1, tt,CC.Timer.pic) == 1 and Rnd(2) == 1 then
    CC.Timer.status = 0
    CC.Timer.stime = t
	SetS(92,60,26,5,0);
  end
end

function runword(str, color, size, place, offset,pic)
  offset = CC.ScreenW - offset
  local y1, y2 = nil, nil
  if place == 0 then
    y1 = 0
    y2 = size
  elseif place == 1 then
    y1 = CC.ScreenH - size
    y2 = CC.ScreenH
  end
  lib.Background(0, y1, CC.ScreenW, y2, 128)
  if (CC.Timer.len - 1) * size < -(offset) then
    return 1
  end
  DrawString(offset, y1, str, color, size)
  lib.PicLoadCache(0,pic*2,offset-20, y1+15, 2, 256);
  return 0
end


function SJRW(lv) --随机任务

local zdbh
local x,y
local t1
local tt
local CX 
local DD 
--lv可以让不同等级的敌人出场，本次统统归入lv1
if lv==1 then

local boss={60,184,98,150,67,71,61,4,31,32,33,34,161,419,440,97,118,103,26,62,27,18,19,22,46,604,606,607,603,602,599,598} 
local place={0,1,3,9,19,20,22,23,24,28,30,32,35,36,37,38,40,41,43,44,47,49,50,53,54,56,59,60,61,62,63,64,65,69,70,73,76,78,80,92,94,95,96,97,98,100,102,103,105} 

CX= boss[math.random(#boss)]
DD= place[math.random(#place)]


--出现的坐标
if DD==0 then --胡斐居
x=math.random(15,19)
y=math.random(33,36)
elseif DD==1 then --河洛
x=math.random(3,18)
y=math.random(29,39)
elseif DD==3 then --有间
x=math.random(17,31)
y=math.random(28,46)
elseif DD==9 then --成昆居
x=math.random(20,35)
y=math.random(22,25)
elseif DD==19 then --重阳宫
x=math.random(14,24)
y=math.random(42,45)
elseif DD==20 then --百花谷
x=math.random(31,42)
y=math.random(16,30)
elseif DD==22 then --绝情谷
x=math.random(14,30)
y=math.random(22,29)
elseif DD==23 then --七公居
x=math.random(30,38)
y=math.random(18,28)
elseif DD==24 then --苗人凤居
x=math.random(26,36)
y=math.random(17,24)
elseif DD==28 then --少林寺
x=math.random(14,18)
y=math.random(37,41)
elseif DD==30 then --平一指居
x=math.random(14,18)
y=math.random(30,36)
elseif DD==32 then --牛家村
x=math.random(17,23)
y=math.random(30,38)
elseif DD==35 then --星宿海
x=math.random(16,24)
y=math.random(11,16)
elseif DD==36 then --青城派
x=math.random(12,18)
y=math.random(26,32)
elseif DD==37 then --五毒教
x=math.random(32,36)
y=math.random(14,21)
elseif DD==38 then --恒山山麓
x=math.random(15,21)
y=math.random(32,40)
elseif DD==40 then --洛阳
x=math.random(29,35)
y=math.random(14,17)
elseif DD==41 then --藏仙山洞
x=math.random(38,45)
y=math.random(15,19)
elseif DD==43 then --武当
x=math.random(28,35)
y=math.random(16,23)
elseif DD==44 then --蝴蝶谷
x=math.random(18,25)
y=math.random(17,22)
elseif DD==47 then --一灯居
x=math.random(34,42)
y=math.random(17,25)
elseif DD==49 then --药王庄
x=math.random(13,18)
y=math.random(19,33)
elseif DD==50 then --阎基居
x=math.random(19,27)
y=math.random(36,42)
elseif DD==53 then --擂鼓山
x=math.random(26,34)
y=math.random(26,30)
elseif DD==54 then --聚贤庄
x=math.random(16,20)
y=math.random(16,22)
elseif DD==56 then --福威镖局
x=math.random(20,33)
y=math.random(19,25)
elseif DD==59 then --金龙帮
x=math.random(22,28)
y=math.random(14,22)
elseif DD==60 then --龙门客栈
x=math.random(20,32)
y=math.random(29,38)
elseif DD==61 then --高升客栈
x=math.random(23,32)
y=math.random(29,36)
elseif DD==62 then --破庙
x=math.random(15,22)
y=math.random(31,37)
elseif DD==63 then --天宁寺
x=math.random(32,40)
y=math.random(18,29)
elseif DD==64 then --田伯光居
x=math.random(18,30)
y=math.random(24,29)
elseif DD==65 then --唐诗山洞
x=math.random(20,30)
y=math.random(14,20)
elseif DD==69 then --丽春院
x=math.random(36,40)
y=math.random(14,27)
elseif DD==70 then --小村
x=math.random(24,32)
y=math.random(42,48)
elseif DD==73 then --灵蛇岛
x=math.random(14,19)
y=math.random(32,45)
elseif DD==76 then --台湾
x=math.random(22,35)
y=math.random(14,19)
elseif DD==78 then --伯尼岛
x=math.random(22,32)
y=math.random(24,30)
elseif DD==80 then --华山后市
x=math.random(24,30)
y=math.random(15,23)
elseif DD==92 then --朱府
x=math.random(26,40)
y=math.random(11,16)
elseif DD==94 then --长乐帮
x=math.random(13,20)
y=math.random(28,36)
elseif DD==95 then --大工方
x=math.random(23,37)
y=math.random(32,38)
elseif DD==96 then --五仙教
x=math.random(15,20)
y=math.random(23,30)
elseif DD==97 then --紫烟岛
x=math.random(16,20)
y=math.random(18,35)
elseif DD==98 then --明霞岛
x=math.random(10,18)
y=math.random(18,29)
elseif DD==100 then --天台山
x=math.random(15,20)
y=math.random(21,40)
elseif DD==102 then --老祖居
x=math.random(36,40)
y=math.random(28,40)
elseif DD==103 then --药王庙
x=math.random(28,38)
y=math.random(15,20)
elseif DD==105 then --西部农村
x=math.random(15,28)
y=math.random(26,38)


end


--出现的人物贴图和战斗编号

if CX==60 then --	欧阳锋
tt={3985,4109,3552,4135}
t1=tt[math.random(4)]
zdbh=370
elseif CX==184 then --玉真子
t1=math.random(4552,4555)
zdbh=371
elseif CX==98 then --段延庆
t1=math.random(4388,4391)
zdbh=372
elseif CX==150 then --冯锡范
t1=math.random(4442,4445)
zdbh=373
elseif CX==67 then --裘千仞
t1=3052
zdbh=374
elseif CX==71 then --洪教主
tt={4106,3993,4131,4132}
t1=tt[math.random(4)]
zdbh=375
elseif CX==61 then --欧阳克
tt={3986,4134}
t1=tt[math.random(2)]
zdbh=376
elseif CX==4 then --阎基
tt={2584,4133}
t1=tt[math.random(2)]
zdbh=377
elseif CX==31 then --丹青生
t1=math.random(3023,3026)
zdbh=378
elseif CX==32 then --秃笔翁
t1=math.random(3027,3030)
zdbh=379
elseif CX==33 then --黑白子
t1=math.random(3031,3033)
zdbh=380
elseif CX==34 then --黄中公
t1=math.random(3035,3037)
zdbh=381
elseif CX==161 then --李莫愁
tt={3587,4136,4137,4138}
t1=tt[math.random(4)]
zdbh=382
elseif CX==419 then --大蛇
t1=math.random(4139,4142)
zdbh=383
elseif CX==440 then --火蟆
t1=math.random(4143,4146)
zdbh=384
elseif CX==97 then --血刀老祖
t1=math.random(4372,4375)
zdbh=385
elseif CX==118 then --李秋水
t1=math.random(4425,4428)
zdbh=386
elseif CX==103 then --鸠摩智
t1=math.random(4409,4412)
zdbh=387
elseif CX==26 then --任我行
t1=math.random(4150,4153)
zdbh=388
elseif CX==62 then --金轮法王
tt={4108,4005,3554,4154}
t1=tt[math.random(4)]
zdbh=389
elseif CX==27 then --东方不败
t1=math.random(4155,4158)
zdbh=390
elseif CX==18 then --成昆
t1=math.random(2648,2649)
zdbh=391

elseif CX==19 then --岳不群
t1=math.random(2979,2982)
zdbh=392
elseif CX==22 then --左冷禅
tt={2617,2618,2973,2974}
t1=tt[math.random(4)]
zdbh=393

elseif CX==46 then --丁春秋
t1=2566
zdbh=394

elseif CX==604 then --鳌拜
t1=math.random(4653,4656)
zdbh=395

elseif CX==606 then --鹿杖客
t1=math.random(4632,4635)
zdbh=396

elseif CX==607 then --鹤笔翁
t1=math.random(4636,4639)
zdbh=397
elseif CX==603 then --公孙止
t1=math.random(4661,4664)
zdbh=398
elseif CX==602 then --石万嗔
t1=3631
zdbh=399
elseif CX==599 then --宝象
t1=math.random(4488,4491)
zdbh=400
elseif CX==598 then --其长发
t1=2948
zdbh=401


end


end

SetS(DD,x,y,3,168); 
SetS(DD,x,y,2,4366*2);
SetS(DD,x,y,5,75);
SetS(92,60,14,5,DD);
SetS(92,60,16,5,CX);
SetS(92,60,17,5,zdbh);
SetS(92,60,18,5,x);
SetS(92,60,19,5,y);
instruct_3(DD,168,1,0,6800,0,0,t1*2,t1*2,t1*2,0,0,0);

end


OEVENTLUA[6800] = function() 


local DD=GetS(92,60,14,5);
local CX=GetS(92,60,16,5);
local zdbh=GetS(92,60,17,5);
local x=GetS(92,60,18,5)
local y=GetS(92,60,19,5)
 SetS(DD,x,y,2,0); 
 SetS(DD,x,y,5,0);
 
 
say(string.format("Ｇ%sＷ！你作恶多端，今日小爷来为民除害，纳命来！",JY.Person[CX]["姓名"]),0,1)


        if CX==419  then
		TalkEx("咝～～咝咝～～～",212,1)
		elseif CX==440 then
		TalkEx("呱～～呱呱～～～",216,1)
		elseif CX==604 then
		TalkEx("找死!!",316,1)
		elseif CX==606 then
		TalkEx("找死!!",317,1)
		elseif CX==607 then
		TalkEx("找死!!",322,1)
		elseif CX==603 then
		TalkEx("找死!!",315,1)
		elseif CX==602 then
		say("找死!!",45,1,"石万嗔")
		elseif CX==599 then
		say("找死!!",160,1,"宝象")
		elseif CX==598 then
		say("找死!!",140,1,"戚长发")
		else
		TalkEx("找死!!",CX,1)
		end


if WarMain(zdbh)==true then
            SetS(92,60,27,5,1)
            instruct_13();
			
		if CX==419  then
		TalkEx("你不爱护动物!咱们走着瞧！",212,1)
		TalkEx("果然是蛇精，都会说人话了。",0,1)
		elseif CX==440 then
	    TalkEx("竟敢这么对待小动物!咱们走着瞧！",216,1)
		TalkEx("果然是蛤蟆精，都会说人话了。",0,1)
		elseif CX==604 then
		TalkEx("小子挺厉害啊!咱们走着瞧！",316,1)
		elseif CX==606 then
		TalkEx("小子挺厉害啊!咱们走着瞧！",317,1)
		elseif CX==607 then
		TalkEx("小子挺厉害啊!咱们走着瞧！",322,1)
	    elseif CX==603 then
		TalkEx("小子挺厉害啊!咱们走着瞧！",315,1)
		elseif CX==602 then
		say("小子挺厉害啊!咱们走着瞧！",45,1,"石万嗔")
		elseif CX==599 then
		say("小子挺厉害啊!咱们走着瞧！",160,1,"宝象")
		elseif CX==598 then
		say("小子挺厉害啊!咱们走着瞧！",140,1,"戚长发")
		else
		TalkEx("小子挺厉害啊!咱们走着瞧！",CX,1)
		end
		instruct_3(DD,168,0,0,0,0,0,0,0,0,0,0,0);
			local money=math.random(100,500)
			instruct_32(174,money); 
            DrawStrBoxWaitKey(string.format("您打跑了%s，恭喜您获得%d兩银子！",JY.Person[CX]["姓名"],money),C_WHITE,CC.DefaultFont);
		    JL()
		else
		    instruct_13();
			
			if CX==419  then
		 TalkEx("本蛇不发威，你当我是薯条啊，暂且饶你狗命！",212,1)
		TalkEx("果然是蛇精，都会说人话了。",0,1)
		elseif CX==440 then
	     TalkEx("本蟾不发威，你当我是汉堡啊，暂且饶你狗命！",216,1)
		TalkEx("果然是蛤蟆精，都会说人话了。",0,1)
		elseif CX==604 then
		 TalkEx("不知死活的东西，杀了你玷污了老子的名声，暂且饶你狗命！",316,1)
		elseif CX==606 then
		 TalkEx("不知死活的东西，杀了你玷污了老子的名声，暂且饶你狗命！",317,1)
		elseif CX==607 then
		 TalkEx("不知死活的东西，杀了你玷污了老子的名声，暂且饶你狗命！",322,1)
		elseif CX==603 then
		 TalkEx("不知死活的东西，杀了你玷污了老子的名声，暂且饶你狗命！",315,1)
		elseif CX==602 then
		say("不知死活的东西，杀了你玷污了老子的名声，暂且饶你狗命！",45,1,"石万嗔")
		elseif CX==599 then
		say("不知死活的东西，杀了你玷污了老子的名声，暂且饶你狗命！",160,1,"宝象")
		elseif CX==598 then
		say("不知死活的东西，杀了你玷污了老子的名声，暂且饶你狗命！",140,1,"戚长发")
		else
		 TalkEx("不知死活的东西，杀了你玷污了老子的名声，暂且饶你狗命！",CX,1)
		end
		
		
		
		 instruct_3(DD,168,0,0,0,0,0,0,0,0,0,0,0);
		end
	 SetS(92,60,20,5,1)	
    CC.Timer.status=1;
	CC.Timer.str=""
    CC.Timer.len=-99	
	SetS(92,60,12,5,0); 
    SetS(92,60,11,5,0);
    SetS(DD,x,y,3,-1);
end

function JL()--奖励点数

local xm={"攻击力","防御力","轻功","拳掌功夫","御剑能力","特殊兵器","耍刀技巧"}
local sz={10,10,10,5,5,5,5}
local jl=math.random(7)


if GetS(92,60,27,5)==1 then
local jl2=math.random(1,sz[jl])
JY.Person[0][xm[jl]]=JY.Person[0][xm[jl]]+jl2
DrawStrBoxWaitKey(string.format("您的%s，上升了%d",xm[jl],jl2),C_GOLD,CC.DefaultFont);

elseif GetS(92,60,27,5)==2 then
local jl3=math.random(10,20)
local rb={5,6,39,50,129,116,57,64,68,69,70,65,185,140,114,164}
local rw=rb[math.random(#rb)]

JY.Person[rw][xm[jl]]=JY.Person[rw][xm[jl]]+jl3
SetS(92,60,28,5,rw);
SetS(92,60,29,5,jl3);
SetS(92,60,30,5,jl);
end

SetS(92,60,27,5,0);

end



function Menu_GD()
local menu = {
{"常规提示开关", Menu_CGTS, 1}, 
{"任务概率调节", Menu_RWTJ, 1},
{"任务时限调节", Menu_RWSX, 1},
} 
local r = ShowMenu(menu, #menu, 0, CC.MainSubMenuX+140, CC.MainSubMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)
if r<=0 then
return 1
end
end

function Menu_CGTS()
local menu={{"开",nil,1},
            {"关",nil,1},}
if GetS(92,60,31,5)==0 then
menu[1][1]="开√"
end	
if GetS(92,60,31,5)==1 then
menu[2][1]="关√"
end	
	
local r = ShowMenu(menu, #menu, 0, CC.MainSubMenuX+140, CC.MainSubMenuY+115, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)				

if r==1 then
SetS(92,60,31,5,0);
SetS(92,60,26,5,0);
end
if r==2 then
SetS(92,60,31,5,1);
SetS(92,60,26,5,0);
end		
if r<=0 then
return 1
end			
end

function Menu_RWTJ()
local menu={{"低",nil,1},
            {"中",nil,1},
			{"高",nil,1},
			}
if GetS(92,60,32,5)==0 then
menu[1][1]="低√"
end	
if GetS(92,60,32,5)==1 then
menu[2][1]="中√"
end	
if GetS(92,60,32,5)==2 then
menu[3][1]="高√"
end		
local r = ShowMenu(menu, #menu, 0, CC.MainSubMenuX+140, CC.MainSubMenuY+115, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)				
if r==1 then
SetS(92,60,32,5,0);
end	
if r==2 then
SetS(92,60,32,5,1);
end	
if r==3 then
SetS(92,60,32,5,2);
end	
if r<=0 then
return 1
end
end

function Menu_RWSX()
local menu={{"五分钟",nil,1},
            {"四分钟",nil,1},
			{"三分钟",nil,1},
            {"二分钟",nil,1},
			{"一分钟",nil,1},
			}
if GetS(92,60,33,5)==0 then
menu[1][1]="五分钟√"
end	
if GetS(92,60,33,5)==1 then
menu[2][1]="四分钟√"
end	
if GetS(92,60,33,5)==2 then
menu[3][1]="三分钟√"
end	
if GetS(92,60,33,5)==3 then
menu[4][1]="二分钟√"
end	
if GetS(92,60,33,5)==4 then
menu[5][1]="一分钟√"
end	

local r = ShowMenu(menu, #menu, 0, CC.MainSubMenuX+140, CC.MainSubMenuY+115, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)				

if r==1 then
SetS(92,60,33,5,0);
end
if r==2 then
SetS(92,60,33,5,1);
end	
if r==3 then
SetS(92,60,33,5,2);
end
if r==4 then
SetS(92,60,33,5,3);
end	
if r==5 then
SetS(92,60,33,5,4);
end		
if r<=0 then
return 1
end			
end






