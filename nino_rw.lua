--  找到使用武功攻击 收益最大的(移动位置、攻击位置)选择
--		如果找到，则移动到该位置，在该攻击施放位置进行武功攻击
--		如果找不到，就移动一下，再蓄力防御休息一下
function unnamed(kfid)
	local pid=WAR.Person[WAR.CurID]["人物编号"]
	local kungfuid=JY.Person[pid]["武功"..kfid]
    local kungfulv=JY.Person[pid]["武功等级" .. kfid];
	if kungfulv>=999 then 
		kungfulv=11
	else
		kungfulv=math.modf(kungfulv/100)+1
	end
	local m1,m2,a1,a2,a3,a4,a5= refw(kungfuid,kungfulv)
	local mfw={m1,m2}
	local atkfw={a1,a2,a3,a4,a5}
	if kungfulv>10 then kungfulv=10 end
	local kungfuatk=JY.Wugong[kungfuid]["攻击力"..kungfulv]
	local atkarray={}
	local num=0
	
 	CleanWarMap(4,-1);
	local mv = math.min(WAR.Person[WAR.CurID]["移动步数"], 15)
	local movearray=War_CalMoveStep(WAR.CurID,mv,0)		-- 记录所有可移动到的位置
	local starttime=lib.GetTime();
	for i=0,mv do
		local step_num=movearray[i].num ;
		if step_num==nil or step_num==0 then
			break;
		end
		
		for j=1,step_num do
			local xx=movearray[i].x[j]
			local yy=movearray[i].y[j]
			num=num+1
			atkarray[num]={}
			atkarray[num].x,atkarray[num].y=xx,yy																											-- 记录 人物可移动到的位置
			atkarray[num].p,atkarray[num].ax,atkarray[num].ay=GetAtkNum(xx,yy,mfw,atkfw,kungfuatk)		-- 记录 人物移动到该位置后，收益最高 的武功施放点位置，以及对应的收益值
			atkarray[num].p=atkarray[num].p*5/(3+math.max(i,2))																				-- 优先选距离近的位置
		end
		
	end

	--[[
	local function quickSort(array, piv, r)
		local function partition(array, piv, r)
			local x = array[r].p
			local i = piv - 1
			for j = piv, r - 1 do
				if array[j].p >= x then
					i = i + 1
					array[i], array[j] = array[j], array[i]
				end
			end
			array[i + 1], array[r] = array[r], array[i + 1]
			return i + 1
		end
		
		piv = piv or 1
		r = r or #array
		if piv < r then
			local q = partition(array, piv, r)
			quickSort(array, piv, q - 1)
			quickSort(array, q + 1, r)
		end
	end

	quickSort(atkarray)
	]]
	
	for i=1,num-1 do																				-- 按收益值，对移动位置、施放位置的选择组合	进行排序
		for j=i+1,num do
			if atkarray[i].p<atkarray[j].p then
				atkarray[i],atkarray[j]=atkarray[j],atkarray[i]
			end
		end
	end

	if atkarray[1].p>0 then
		for i=1,num do
			if atkarray[i].p==0 or atkarray[i].p<atkarray[1].p/2 then			-- 过滤掉 收益值 低于最高收益值一半的那些选择
				num=i-1
				break;
			end
		end
		for i=1,num do
			atkarray[i].p=atkarray[i].p+GetMovePoint(atkarray[i].x,atkarray[i].y)
		end
		for i=1,num-1 do														-- 再次排序
			for j=i+1,num do
				if atkarray[i].p<atkarray[j].p then
					atkarray[i],atkarray[j]=atkarray[j],atkarray[i]
				elseif atkarray[i].p==atkarray[j].p then
					if math.random(2)==1 then
						atkarray[i],atkarray[j]=atkarray[j],atkarray[i]
					end
				end
			end
		end
		--quickSort(atkarray)
		for i=2,num do
			if atkarray[i].p<atkarray[1].p-15 then		-- 过滤掉 收益值 低于最高收益值-15 的那些选择
				num=i-1
				break;
			end
		end
		if num > 6 then																-- 这里是不是应该改成 小于，不过也没关系，反正后面也不用
			for i=num,6 do
				if atkarray[i]~=nil and atkarray[i].p~=nil and atkarray[i].p<atkarray[1].p-50 then
					num=i-1
					break
				end
			end
		end
		local endtime=starttime+100-lib.GetTime()
		if endtime>0 then
			lib.Delay(endtime)
		end
		local select
		select=1																		-- 上面还过滤干啥，反正这里选了第一个最大收益值的那个
		War_CalMoveStep(WAR.CurID,mv,0)					-- 展示选择移动位置的动画
		War_MovePerson(atkarray[select].x,atkarray[select].y)										-- 移动到最优移动位置的动画展示
		WAR.Person[WAR.CurID]["Action"]={'atk',kfid,atkarray[select].ax-atkarray[select].x,atkarray[select].ay-atkarray[select].y}
		War_Fight_Sub(WAR.CurID,kfid,atkarray[select].ax,atkarray[select].ay)		-- 在最优施放位置 进行武功施放
	else
		local endtime=starttime+100-lib.GetTime()		-- 找不到攻击会有正收益的(移动位置、攻击位置)选择，于是移动一下，再蓄力防御休息一下
		if endtime>0 then
			lib.Delay(endtime)
		end
		local jl,nx,ny=War_realjl()
		if jl==-1 then
			AutoMove()
		else
			local vv
			vv=GetWarMap(nx+1,ny,2)
			if vv>-1 and WAR.Person[vv]["我方"]~=WAR.Person[WAR.CurID]["我方"] then
		
			else
				vv=GetWarMap(nx-1,ny,2)
				if vv>-1 and WAR.Person[vv]["我方"]~=WAR.Person[WAR.CurID]["我方"] then
			
				else
					vv=GetWarMap(nx,ny+1,2)
					if vv>-1 and WAR.Person[vv]["我方"]~=WAR.Person[WAR.CurID]["我方"] then
				
					else
						vv=GetWarMap(nx,ny-1,2)
					end
				end
			end
			local array={}
			local an=0
			local movearray=War_CalMoveStep(WAR.CurID,mv,0)
			War_CalMoveStep(vv,jl,0)
			for i=1,mv do
				local step_num=movearray[i].num ;
				if step_num==nil or step_num==0 then
					break;
				end		
				for j=1,step_num do
					local xx=movearray[i].x[j]
					local yy=movearray[i].y[j]
					local Dest=GetWarMap(xx,yy,3)
					if Dest<255 then
						an=an+1
						array[an]={}
						array[an].x=xx
						array[an].y=yy
						array[an].p=jl-Dest
					end
				end
			end
			for i=1,an-1 do
				for j=i+1,an do
					if array[i].p<array[j].p then
						array[i],array[j]=array[j],array[i]
					end
				end
			end
			for i=2,an do
				if array[i].p<array[1].p/2 then
					an=i-1
					break
				end
			end
			for i=1,an do
				array[i].p=array[i].p+GetMovePoint(array[i].x,array[i].y)
			end
			for i=1,an-1 do
				for j=i+1,an do
					if array[i].p<array[j].p then
						array[i],array[j]=array[j],array[i]
					end
				end
			end
			if an>0 then
				War_CalMoveStep(WAR.CurID,mv,0)
				War_MovePerson(array[1].x,array[1].y)
			else
				AutoMove()
			end
		end
		if JY.Person[pid]["体力"] < 20 or JY.Person[pid]["内力"] < War_GetMinNeiLi(pid) * 10 then
			War_RestMenu()
		elseif PersonKF(pid, 103) then
			War_ActupMenu()
		elseif PersonKF(pid, 101) then
			War_DefupMenu()
		elseif JY.Person[pid]["生命"] > math.modf(JY.Person[pid]["生命最大值"] * 0.5) then
			War_ActupMenu()
		else
			War_DefupMenu()
		end
	end
	return
end
function ReadKDEF(id)
	--id事件编号
	local kidx=Byte.create(id*4+4)
	Byte.loadfile(kidx,CC.KDX,0,id*4+4)
	local idx1,idx2
	if id<1 then
		idx1=0
	else
		idx1=Byte.get32(kidx,(id-1)*4)
	end
	idx2=Byte.get32(kidx,id*4)
	--idx,编号为id的事件的索引值
	local len=idx2-idx1
	local kdef=Byte.create(len)
	Byte.loadfile(kdef,CC.KRP,idx1,len)
	local E={}
	len=len/2
	--lib.Debug(len)
	for i=0,len-1 do
		--lib.Debug(lib.GetTime())
		E[i]=Byte.get16(kdef,2*i)
	end
	local idx=0		--
	
local function NewInstruct_50(code,e1,e2,e3,e4,e5,e6)
	lib.Debug(string.format('50code::[%d:%d:%d:%d:%d:%d:%d]start:%d',code,e1,e2,e3,e4,e5,e6,lib.GetTime()))
	local function getb(b,num)
		num=math.modf(num/(2^b))
		num=math.fmod(num,2)
		return num
	end
	local function getvaule(b,t,ee)
		if getb(b,t)==1 then
			return Byte.get16(x50,ee*2)
		else
			return ee
		end
	end
	local newinstruct_50_sub={
							[0]=function()	--3.1.	变量赋值50(0,x,v,-1,-1,-1,-1)
								Byte.set16(x50,e1*2,e2)
							end,
							[1]=function()	--3.2.	数组变量赋值50(1, type1,type2,x, I , y , -1)
								--e3=Byte.get16(x50,e3*2)
								e4=getvaule(0,e1,e4)
								e5=getvaule(1,e1,e5)
								--lib.Debug((e3+e4)..','..e5)
								if e2==0 then
									Byte.set16(x50,(e3+e4)*2,e5)
								elseif e2==1 then
									local num=Byte.get16(x50,(e3+e4)*2)
									num=math.modf(num/256)
									e5=math.fmod(num,256)
									e5=num*256+e5
									Byte.set16(x50,(e3+e4)*2,e5)
								end
								lib.Debug(e3..','..e4..'|'..e5)
							end,
							[2]=function()	--3.3.	取数组变量值50(2, type1,type2,x, I , y , -1)
								--e3=Byte.get16(x50,e3*2)
								e4=getvaule(0,e1,e4)
								--e5=Byte.get16(x50,e5*2)
								local num=Byte.get16(x50,(e3+e4)*2)
								if e2==1 then
									num=math.fmod(num,256)
								end
								Byte.set16(x50,e5*2,num)
							end,
							[3]=function()	--3.4.	四则运算(3, type1,type2,y, a , b , -1 )
								if e2==5 then
									e4=Byte.getu16(x50,e4*2)
									e2=3
								else
									e4=Byte.get16(x50,e4*2)
								end
								--e3=Byte.get16(x50,e3*2)
								e5=getvaule(0,e1,e5)
								if e2==0 then
									Byte.set16(x50,e3*2,e4+e5)
								elseif e2==1 then
									Byte.set16(x50,e3*2,e4-e5)
								elseif e2==2 then
									Byte.set16(x50,e3*2,e4*e5)
								elseif e2==3 then
									Byte.set16(x50,e3*2,math.modf(e4/e5))
								elseif e2==4 then
									Byte.set16(x50,e3*2,math.fmod(e4,e5))
								end
								lib.Debug(e3..','..e4..'|'..e5)
							end,
							[4]=function()	--3.5.	变量判断(4, Type1, Type2,a, b , -1, -1 )
								Byte.set16(x50,28672,1)
								lib.Debug(e3)
								e3=Byte.get16(x50,e3*2)
								lib.Debug(e3)
								e4=getvaule(0,e1,e4)
								if e2==0 and e3<e4 then
									Byte.set16(x50,28672,0)
								elseif e2==1 and e3<=e4 then
									Byte.set16(x50,28672,0)
								elseif e2==2 and e3==e4 then
									Byte.set16(x50,28672,0)
								elseif e2==3 and e3~=e4 then
									Byte.set16(x50,28672,0)
								elseif e2==4 and e3>=e4 then
									Byte.set16(x50,28672,0)
								elseif e2==5 and e3>e4 then
									Byte.set16(x50,28672,0)
								elseif e2==6 then
									Byte.set16(x50,28672,0)
								end
							end,
							[5]=function()	--3.6.	全部变量清零(5,-1,-1,-1,-1,-1,-1)
								for i=0,32764,4 do
									Byte.set32(x50,i,0)
								end
							end,
							[8]=function()	--4.1.	读对话到字符串(8,type,id,x ,-1 , -1, -1)
								e2=getvaule(0,e1,e2)
								--e3=Byte.get16(x50,e3*2)
								local tidx=Byte.create(e2*4+4)
								Byte.loadfile(tidx,CC.TDX,0,e2*4+4)
								local idx1,idx2
								if e2<1 then
									idx1=0
								else
									idx1=Byte.get32(tidx,(e2-1)*4)
								end
								idx2=Byte.get32(tidx,e2*4)
								local len=idx2-idx1
								local talk=Byte.create(len)
								Byte.loadfile(talk,CC.TRP,idx1,len)
								local str=''
								for i=0,len-2 do
									local byte=Byte.getu16(talk,i)
									byte=255-math.fmod(byte,256)
									str=str..string.char(byte)
									--Byte.setu16(x50,e3*2+i,byte)
								end
								str=lib.CharSet(str,0)
								for i=0,len-1 do
									local byte=string.byte(str,i+1)
									Byte.setu16(x50,e3*2+i,byte)
								end
								lib.Debug(e3..','..str)
							end,
							[9]=function()	--4.2.	sprintf(9, type,s, format, x, -1, -1)
								e4=getvaule(0,e1,e4)
								local str=''
								for i=0,1000 do
									local byte=Byte.getu16(x50,e3*2+i)
									byte=math.fmod(byte,256)
									if byte>0 then
										str=str..string.char(byte)
									else
										break
									end
								end
								str=string.format(str,e4)
								for i=0,string.len(str)-1 do
									Byte.setu16(x50,e2*2+i,string.byte(str,i+1))
								end
								lib.Debug('50-9[['..str..'[['..e4)
							end,
							[10]=function()	--4.3.	取字符串长度(10,s,l,-1,-1,-1)
								for i=0,1000 do
									local byte=Byte.getu16(x50,e1*2+i)
									byte=math.fmod(byte,256)
									if byte==0 then
										Byte.setu16(x50,e2*2,i)
										break
									end
								end
							end,
							[11]=function()	--4.4.	字符串合并(11,x,a,b,-1,-1)
								local stra,strb,strx='',''
								for i=0,1000 do
									local byte=Byte.getu16(x50,e2*2+i)
									byte=math.fmod(byte,256)
									if byte>0 then
										stra=stra..string.char(byte)
									else
										break
									end
								end
								for i=0,1000 do
									local byte=Byte.getu16(x50,e3*2+i)
									byte=math.fmod(byte,256)
									if byte>0 then
										strb=strb..string.char(byte)
									else
										break
									end
								end
								strx=stra..strb	
								for i=0,string.len(strx)-1 do
									Byte.setu16(x50,e1*2+i,string.byte(strx,i+1))
								end
								lib.Debug('50-10[['..strx)
							end,
							[12]=function()	--4.5.	产生空格字符串(12,type,s,n,-1,-1)
								if e1==1 then
									e3=Byte.get16(x50,e3*2)
								end
								for i=0,e3-1 do
									Byte.setu16(x50,e2*2+i,32)
								end
							end,
							[16]=function()	--5.1.	保存人物物品等属性(16, type1,type2,id, i , x, -1)
								e3=getvaule(0,e1,e3)
								e4=getvaule(1,e1,e4)
								e5=getvaule(2,e1,e5)
								local v
								if e2==0 then
									Byte.set16(JY.Data_Person,CC.PersonSize*e3+e4,e5)
								elseif e2==1 then
									Byte.set16(JY.Data_Thing,CC.ThingSize*e3+e4,e5)
								elseif e2==2 then
									Byte.set16(JY.Data_Scene,CC.SceneSize*e3+e4,e5)
								elseif e2==3 then
									Byte.set16(JY.Data_Wugong,CC.WugongSize*e3+e4,e5)
								elseif e2==4 then
									Byte.set16(JY.Data_Shop,CC.ShopSize*e3+e4,e5)
								end
								lib.Debug('OOO|'..e3..','..e4..','..e5)
							end,
							[17]=function()	--5.2.	取人物物品等属性(17, type1,type2，id, i , x, -1)
								e3=getvaule(0,e1,e3)
								e4=getvaule(1,e1,e4)
								--e5=Byte.get16(x50,e5*2)
								local v
								if e2==0 then
									v=Byte.get16(JY.Data_Person,CC.PersonSize*e3+e4)
								elseif e2==1 then
									v=Byte.get16(JY.Data_Thing,CC.ThingSize*e3+e4)
								elseif e2==2 then
									v=Byte.get16(JY.Data_Scene,CC.SceneSize*e3+e4)
								elseif e2==3 then
									v=Byte.get16(JY.Data_Wugong,CC.WugongSize*e3+e4)
								elseif e2==4 then
									v=Byte.get16(JY.Data_Shop,CC.ShopSize*e3+e4)
								end
								Byte.set16(x50,e5*2,v)
								lib.Debug(e2..','..e3..','..e4..','..v)
							end,
							[18]=function()	--5.3.	存队伍(18, type,id, x , -1, -1, -1)
								e2=getvaule(0,e1,e2)
								e3=getvaule(1,e1,e3)
								JY.Base['队伍'..e2]=e3
							end,
							[19]=function()	--5.4.	取队伍(19, type,id, x , -1, -1, -1)
								e2=getvaule(0,e1,e2)
								--e3=Byte.get16(e3*2)
								Byte.set16(x50,e3*2,JY.Base['队伍'..(e2+1)])
							end,
							[20]=function()	--5.5.	得到主角携带的物品数量 (20,type,i, x , -1, -1, -1)
								e2=getvaule(0,e1,e2)
								--e3=Byte.get16(e3*2)
								for i=1,CC.MyThingNum do
									if JY.Base['物品'..i]==e2 then
										Byte.set16(x50,e3*2,JY.Base['物品数量'..i])
										break
									end
								end
							end,
							[21]=function()	--5.6.	存D*数据(21,type,id, i , j, x, -1)
								e2=getvaule(0,e1,e2)
								e3=getvaule(1,e1,e3)
								e4=getvaule(2,e1,e4)
								e5=getvaule(3,e1,e5)
								lib.SetD(e2,e3,e4,e5)
							end,
							[22]=function()	--5.7.	取D*数据(22,type,id, i , j, x, -1)
								e2=getvaule(0,e1,e2)
								e3=getvaule(1,e1,e3)
								e4=getvaule(2,e1,e4)
								--e5=Byte.get16(x50,e5*2)
								Byte.set16(x50,e5*2,lib.GetD(e2,e3,e4))
							end,
							[23]=function()	--5.8.	存S*数据(23,type,id, i , x, y, v)
								e2=getvaule(0,e1,e2)
								e3=getvaule(1,e1,e3)
								e4=getvaule(2,e1,e4)
								e5=getvaule(3,e1,e5)
								e6=getvaule(4,e1,e6)
								lib.SetS(e2,e3,e4,e5,e6)
							end,
							[24]=function()	--5.9.	取S*数据(24,type,id, i , x, y, v)
								e2=getvaule(0,e1,e2)
								e3=getvaule(1,e1,e3)
								e4=getvaule(2,e1,e4)
								e5=getvaule(3,e1,e5)
								--e6=Byte.get16(x50,e6*2)
								Byte.set16(x50,e6*2,lib.GetS(e2,e3,e4,e5))
							end,
							[25]=function()	--5.10.	存给定内存地址数据(25,type1,type2, AddressL ,AddressH , x, i)	
								e5=getvaule(0,e1,e5)
								e6=getvaule(1,e1,e6)
								local v
								local address=e4*65536+e3+e6
								if e2==1 then
									local num=Byte.get16(x50,e5*2)
									num=math.modf(num/256)
									v=math.fmod(num,256)
									v=num*256+v
								end
								if address==1838072 then	--主角贴图号
									JY.MyPic=e5
								elseif address==345330 then
									JY.Base['人方向']=e5
								elseif address==1911134 then
									JY.SubScene=e5
								elseif address==1911132 then
									JY.Base['人X1']=e5
								elseif address==1911130 then
									JY.Base['人Y1']=e5
								elseif address==1911128 then
									JY.Base['人X']=e5
								elseif address==1911126 then
									JY.Base['人Y']=e5
								end
							end,
							[26]=function()	--5.11.	取给定内存地址数据(26,type1,type2, AddressL ,AddressH , x, i)
								--e5=getvaule(0,e1,e5)
								--e6=getvaule(1,e1,e6)
								local v
								local address=e4*65536+e3+e6
								if address==1838072 then	--主角贴图号
									v=JY.MyPic
								elseif address==345330 then
									v=JY.Base['人方向']
								elseif address==1911134 then
									v=JY.SubScene
								elseif address==1911132 then
									v=JY.Base['人X1']
								elseif address==1911130 then
									v=JY.Base['人Y1']
								elseif address==1911128 then
									v=JY.Base['人X']
								elseif address==1911126 then
									v=JY.Base['人Y']
								end
								if e2==0 then
									Byte.set16(x50,e5*2,v)
								elseif e2==1 then
									local num=Byte.get16(x50,e5*2)
									num=math.modf(num/256)
									v=math.fmod(num,256)
									v=num*256+v
									Byte.set16(x50,e5*2,v)
								end
							end,
							[27]=function()	--5.12.	取人物物品等属性名称(27, type1,type2,id, s , -1, -1)
								e3=getvaule(0,e1,e3)
								--e4=Byte.get16(x50,e4*2)
								local str
								lib.Debug('50-27[['..e3)
								if e2==0 then
									str=JY.Person[e3]['姓名']
								elseif e2==1 then
									str=JY.Thing[e3]['名称']
								elseif e2==2 then
									str=JY.Scene[e3]['名称']
								elseif e2==3 then
									str=JY.Wugong[e3]['名称']
								end
								for i=0,string.len(str)-1 do
									Byte.setu16(x50,e4*2+i,string.byte(str,i+1))
								end
							end,
							[32]=function()	--6.1.	修改指令参数(32, type ,x,i,-1 , -1, -1)
								e3=getvaule(0,e1,e3)
								E[idx+8+e3]=Byte.get16(x50,e2*2)
							end,
							[33]=function()	--6.2.	显示字符串(33,type,s,x,y ,color,-1)
								--e2=Byte.get16(x50,e2*2)
								e3=getvaule(0,e1,e3)
								e4=getvaule(1,e1,e4)
								e5=getvaule(2,e1,e5)
								local str=''
								for i=0,1000 do
									local byte=Byte.getu16(x50,e2*2+i)
									byte=math.fmod(byte,256)
									if byte>0 then
										str=str..string.char(byte)
									else
										break
									end
								end
								DrawStrBox(e3,e4,str,C_ORANGE,CC.DefaultFont)
								ShowScreen()
							end,
							[34]=function()	--6.3.	处理背景(34,type,x,y,w , h,-1)
								--e2=getvaule(0,e1,e2)
								--e3=getvaule(1,e1,e3)
								--e4=getvaule(2,e1,e4)
								--e5=getvaule(3,e1,e5)
								--DrawBox(e2,e3,e2+e4,e3+e5,C_WHITE)
								--ShowScreen()
								return
							end,
							[35]=function()	--6.4.	读键盘(35,x,-1,-1,-1 , -1,-1)
								--e1=Byte.get16(x50,e1*2)
								local key=WaitKey()
								Byte.set16(x50,e1*2)
							end,
							[36]=function()	--6.5.	显示字符串并等待击键(36,type,s,x,y ,color,-1)
								--e2=Byte.get16(x50,e2*2)
								e3=getvaule(0,e1,e3)
								e4=getvaule(1,e1,e4)
								e5=getvaule(2,e1,e5)
								local str=''
								for i=0,1000 do
									local byte=Byte.getu16(x50,e2*2+i)
									byte=math.fmod(byte,256)
									if byte>0 then
										str=str..string.char(byte)
									else
										break
									end
								end
								DrawStrBox(e3,e4,str,C_ORANGE,CC.DefaultFont)
								ShowScreen()
								Byte.set16(x50,28672,1)
								if WaitKey()==121 then
									Byte.set16(x50,28672,0)
								end
							end,
							[37]=function()	--6.6.	延时(37,type,n, -1,-1 , -1, -1, -1)
								e2=getvaule(0,e1,e2)
								lib.Delay(e2)
							end,
							[38]=function()	--6.7.	随机数(38,type, n,x , -1, -1, -1)
								e2=getvaule(0,e1,e2)
								--e3=Byte.get16(x50,e3*2)
								Byte.set16(x50,e3*2,math.random(e2)-1)
							end,
							[39]=function()	--6.8.	菜单选择(39,type,n,s,r,x,y)
								e2=getvaule(0,e1,e2)
								e5=getvaule(1,e1,e5)
								e6=getvaule(2,e1,e6)
								local mymenu={}
								for i=1,e2 do
									local str=''
									local start=Byte.get16(x50,(e3+i-1)*2)
									lib.Debug(i..','..e3..','..start)
									for i=0,1000 do
										local byte=Byte.getu16(x50,start*2+i)
										byte=math.fmod(byte,256)
										if byte>0 then
											str=str..string.char(byte)
										else
											break
										end
									end
									lib.Debug(str)
									mymenu[i]={str,nil,1}
								end
								local select
								select=ShowMenu(mymenu,e2,e2,e5,e6+10,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE)
								Byte.set16(x50,e4*2,select)
							end,
							[40]=function()
								e2=getvaule(0,e1,e2)
								e5=getvaule(1,e1,e5)
								e6=getvaule(2,e1,e6)
								local mymenu={}
								for i=1,e2 do
									local str=''
									local start=Byte.getu16(x50,e3+i)
									for i=0,1000 do
										local byte=Byte.getu16(x50,start*2+i)
										byte=math.fmod(byte,256)
										if byte>0 then
											str=str..string.char(byte)
										else
											break
										end
									end
									mymenu[i]={str,nil,1}
								end
								local select
								select=ShowMenu(mymenu,e2,e2,e5,e6,0,0,1,0,CC.DefaultFont,C_WHITE,C_ORANGE)
								Byte.set16(x50,e4*2,select)
							end,
							[41]=function()	--6.10.	显示图片指令(41,type1,type2,x,y,n,-1)
								e3=getvaule(0,e1,e3)
								e4=getvaule(1,e1,e4)
								e5=getvaule(2,e1,e5)
								local id
								if e2==0 then
									id=0
								elseif e2==1 then
									id=1
								end
								lib.PicLoadCache(id,e5,e3,e4)
							end,
							[42]=function()	--6.11.	改变主地图坐标(42,type,x,y,0,0,0)
								e2=getvaule(0,e1,e2)
								e3=getvaule(1,e1,e3)
								JY.Base['人X']=e2
								JY.Base['人Y']=e3
							end,
							[43]=function()	--6.12.	调用其它事件(43,type,n,x1,x2,x3,x4)
								e2=getvaule(0,e1,e2)
								e3=getvaule(1,e1,e3)
								e4=getvaule(2,e1,e4)
								e5=getvaule(3,e1,e5)
								e6=getvaule(4,e1,e6)
								Byte.set16(x50,28928,e3)
								Byte.set16(x50,28930,e4)
								Byte.set16(x50,28932,e5)
								Byte.set16(x50,28934,e6)
								ReadKDEF(e2)
							end,
						}

	newinstruct_50_sub[code]()--(e1,e2,e3,e4,e5,e6)
	--lib.Debug('50code::['..code..']end:'..lib.GetTime())
end

	
	while idx<len do
		if E[idx]==0 then	--OK
			Cls()
			idx=idx+1
		elseif E[idx]==1 then	--OKing
			--instruct_1(E[idx+1],E[idx+2],E[idx+3])
			TalkEx(ReadTALK(E[idx+1]),E[idx+2],E[idx+3],"１２３４５６ｍａｒｋ")
			idx=idx+4
		elseif E[idx]==2 then	--OK
			instruct_2(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==3 then	--OK
			instruct_3(
							E[idx+1],E[idx+2],E[idx+3],
							E[idx+4],E[idx+5],E[idx+6],
							E[idx+7],E[idx+8],E[idx+9],
							E[idx+10],E[idx+11],E[idx+12],
							E[idx+13]
						)
			idx=idx+14
		elseif E[idx]==4 then	--OK
			if instruct_4(E[idx+1]) then
				idx=idx+E[idx+2]
			else
				idx=idx+E[idx+3]
			end
			idx=idx+4
		elseif E[idx]==5 then	--OK
			if instruct_5() then
				idx=idx+E[idx+1]
			else
				idx=idx+E[idx+2]
			end
			idx=idx+3
		elseif E[idx]==6 then	--OK
			if WarMain(E[idx+1],E[idx+4]) then
				idx=idx+E[idx+2]
			else
				idx=idx+E[idx+3]
			end
			idx=idx+5
		elseif E[idx]==7 then	--OK
			idx=idx+1
			break
		elseif E[idx]==8 then	--OK
			instruct_8(E[idx+1])
			idx=idx+2
		elseif E[idx]==9 then	--OK
			if instruct_9() then
				idx=idx+E[idx+1]
			else
				idx=idx+E[idx+2]
			end
			idx=idx+3
		elseif E[idx]==10 then	--OK
			instruct_10(E[idx+1])
			idx=idx+2
		elseif E[idx]==11 then	--OK
			if instruct_11() then
				idx=idx+E[idx+1]
			else
				idx=idx+E[idx+2]
			end
			idx=idx+3
		elseif E[idx]==12 then	--OK
			instruct_12()
			idx=idx+1
		elseif E[idx]==13 then	--OK
			instruct_13()
			idx=idx+1
		elseif E[idx]==14 then	--OK
			instruct_14()
			idx=idx+1
		elseif E[idx]==15 then	--OK
			instruct_15()
			idx=idx+2
		elseif E[idx]==16 then	--OK
			if instruct_16(E[idx+1]) then
				idx=idx+E[idx+2]
			else
				idx=idx+E[idx+3]
			end
			idx=idx+4
		elseif E[idx]==17 then	--OK
			instruct_17(E[idx+1],E[idx+2],E[idx+3],
						E[idx+4],E[idx+5])
			idx=idx+6
		elseif E[idx]==18 then	--OK
			if instruct_18(E[idx+1]) then
				idx=idx+E[idx+2]
			else
				idx=idx+E[idx+3]
			end
			idx=idx+4
		elseif E[idx]==19 then	--OK
			instruct_19(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==20 then	--OK
			if instruct_20() then
				idx=idx+E[idx+1]
			else
				idx=idx+E[idx+2]
			end
			idx=idx+3
		elseif E[idx]==21 then	--OK
			instruct_21(E[idx+1])
			idx=idx+2
		elseif E[idx]==22 then	--OK
			instruct_22()
			idx=idx+1
		elseif E[idx]==23 then	--OK
			instruct_23(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==24 then	--OK
			instruct_24()
			idx=idx+1
		elseif E[idx]==25 then	--OK
			instruct_25(E[idx+1],E[idx+2],E[idx+3],E[idx+4])
			idx=idx+5
		elseif E[idx]==26 then	--OK
			instruct_26(E[idx+1],E[idx+2],E[idx+3],
						E[idx+4],E[idx+5])
			idx=idx+6
		elseif E[idx]==27 then	--OK
			instruct_27(E[idx+1],E[idx+2],E[idx+3])
			idx=idx+4
		elseif E[idx]==28 then	--OK
			if instruct_28(E[idx+1],E[idx+2],E[idx+3]) then
				idx=idx+E[idx+4]
			else
				idx=idx+E[idx+5]
			end
			idx=idx+6
		elseif E[idx]==29 then	--OK
			if instruct_29(E[idx+1],E[idx+2],E[idx+3]) then
				idx=idx+E[idx+4]
			else
				idx=idx+E[idx+5]
			end
			idx=idx+6
		elseif E[idx]==30 then	--OK
			instruct_30(E[idx+1],E[idx+2],E[idx+3],E[idx+4])
			idx=idx+5
		elseif E[idx]==31 then	--OK
			if instruct_31(E[idx+1]) then
				idx=idx+E[idx+2]
			else
				idx=idx+E[idx+3]
			end
			idx=idx+4
		elseif E[idx]==32 then	--OK
			instruct_32(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==33 then	--OK
			instruct_33(E[idx+1],E[idx+2],E[idx+3])
			idx=idx+4
		elseif E[idx]==34 then	--OK
			instruct_34(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==35 then	--OK
			instruct_35(E[idx+1],E[idx+2],E[idx+3],E[idx+4])
			idx=idx+5
		elseif E[idx]==36 then	--OK
			if E[idx+1]<256 then
				if instruct_36(E[idx+1]) then
					idx=idx+E[idx+2]
				else
					idx=idx+E[idx+3]
				end
			else
				local tzflag=Byte.get16(x50,28672)
				if tzflag==0 then
					idx=idx+E[idx+2]
				elseif tzflag==1 then
					idx=idx+E[idx+3]
				end
			end
			idx=idx+4
		elseif E[idx]==37 then	--OK
			instruct_37(E[idx+1])
			idx=idx+2
		elseif E[idx]==38 then	--OK
			instruct_38(E[idx+1],E[idx+2],E[idx+3],E[idx+4])
			idx=idx+5
		elseif E[idx]==39 then	--OK
			instruct_39(E[idx+1])
			lib.Debug('xx')
			idx=idx+2
		elseif E[idx]==40 then	--OK
			instruct_40(E[idx+1])
			idx=idx+2
		elseif E[idx]==41 then	--OK
			instruct_41(E[idx+1],E[idx+2],E[idx+3])
			idx=idx+4
		elseif E[idx]==42 then	--OK
			if instruct_42() then
				idx=idx+E[idx+1]
			else
				idx=idx+E[idx+2]
			end
			idx=idx+3
		elseif E[idx]==43 then	--OK
			if instruct_43(E[idx+1]) then
				idx=idx+E[idx+2]
			else
				idx=idx+E[idx+3]
			end
			idx=idx+4
		elseif E[idx]==44 then	--OK
			instruct_44(E[idx+1],E[idx+2],E[idx+3],
						E[idx+4],E[idx+5],E[idx+6])
			idx=idx+7
		elseif E[idx]==45 then
			instruct_45(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==46 then
			instruct_46(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==47 then
			instruct_47(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==48 then
			instruct_48(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==49 then
			instruct_49(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==50 then
			if E[idx+1]>128 then
				instruct_50(E[idx+1],E[idx+2],E[idx+3],E[idx+4],
							E[idx+5],E[idx+6],E[idx+7])
			else
				NewInstruct_50(E[idx+1],E[idx+2],E[idx+3],E[idx+4],
								E[idx+5],E[idx+6],E[idx+7])
			end
			idx=idx+8
		elseif E[idx]==51 then
			instruct_51()
			idx=idx+1
		elseif E[idx]==52 then
			instruct_52()
			idx=idx+1
		elseif E[idx]==53 then
			instruct_53()
			idx=idx+1
		elseif E[idx]==54 then
			instruct_54()
			idx=idx+1
		elseif E[idx]==55 then	--OK
			if instruct_55(E[idx+1],E[idx+2]) then
				idx=idx+E[idx+3]
			else
				idx=idx+E[idx+4]
			end
			idx=idx+5
		elseif E[idx]==56 then
			instruct_56(E[idx+1])
			idx=idx+2
		elseif E[idx]==57 then
			instruct_57()
			idx=idx+1
		elseif E[idx]==58 then
			instruct_58()
			idx=idx+1
		elseif E[idx]==59 then
			instruct_59()
			idx=idx+1
		elseif E[idx]==60 then
			if instruct_60(E[idx+1],E[idx+2],E[idx+3]) then
				idx=idx+E[idx+4]
			else
				idx=idx+E[idx+5]
			end
			idx=idx+6
		elseif E[idx]==61 then
			if instruct_61() then
				idx=idx+E[idx+1]
			else
				idx=idx+E[idx+2]
			end
			idx=idx+3
		elseif E[idx]==62 then
			instruct_62(E[idx+1],E[idx+2],E[idx+3],E[idx+4],E[idx+5],E[idx+6])
			idx=idx+7
		elseif E[idx]==63 then	--OK
			instruct_63(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==64 then
			instruct_64()
			idx=idx+1
		elseif E[idx]==65 then
			instruct_65()
			idx=idx+1
		elseif E[idx]==66 then
			instruct_66(E[idx+1])
			idx=idx+2
		elseif E[idx]==67 then
			instruct_67(E[idx+1])
			idx=idx+2
		else
			break
		end
	end
end

function cxlist()
	local plist = {}
	local menu = {}

	say("请输入人物等级（2~8）", 585)
	local T = {}
	for a = 1, 1000 do
	  local b = "" .. a
	  T[b] = a
	end
	local dj = -1
	while dj == -1 do
		local r = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
		if T[r] ~= nil and T[r] >= 2 and T[r] <= 8 then
		  dj = T[r]
		else
			DrawStrBoxWaitKey("输入错误", C_WHITE, 30)
		end
	end
	
	for i = 1, JY.PersonNum - 1 do
		local pid = i
		if not xiaobin(i) and JY.Person[pid]["排行"] == dj and CC.NLJS[JY.Person[pid]["姓名"]] ~= nil and i ~= 92
			and i ~= 456 and i ~= 457 and i ~= 594 and i ~= 595 and i ~= 596 and i ~= 620 and i ~= 597 and i ~= 598 
			and i ~= 600 and i ~= 617 and i ~= 665 and i ~= 666 and i ~= 667 and JY.Person[i]["排行"] > 1 then
			--and JY.Person[pid]["技能1"] > 0 then					
			menu [#menu + 1] = 700 + 300 * (JY.Person[i]["排行"] - 2)
			plist[#plist + 1]	= {}
			local person = {}
			person[0] = i		
			person[1] = JY.Person[pid]["姓名"]
			person[2] = "等级"..JY.Person[pid]["排行"].."人物，解锁需"..menu[#menu].."技能点"		
			person[3] = ""
			if CC.NLJS[JY.Person[pid]["姓名"]][1] ~= "称号：" then
				for j = 1, #CC.NLJS[JY.Person[pid]["姓名"]] do
					person[#person+1] = CC.NLJS[JY.Person[pid]["姓名"]][j]
				end			
				person[#person+1] = ""
			end
			for i = 1, 5 do
				if JY.Person[pid]["技能"..i] > 0 then				
					if i == 1 and JY.Person[pid]["技能"..i + 1] <= 0 then
						person[#person+1] = "天赋".."："..CC.TFlist[JY.Person[pid]["技能"..i]][1]	
					else
						person[#person+1] = "天赋"..CC.NUM[i].."："..CC.TFlist[JY.Person[pid]["技能"..i]][1]	
					end
					person[#person+1] = CC.TFlist[JY.Person[pid]["技能"..i]][2]
				else
					break
				end
				if i ~= 5 then
					person[#person+1] = ""
				end
			end			
			--[[person[#person+1] = "所习武功："
			for i = 1, 10 do
				if JY.Person[pid]["武功"..i] > 0 then]]
					--person[#person] = person[#person]..JY.Wugong[JY.Person[pid]["武功"..i]]["名称"]
					--[[if i ~= 10 and JY.Person[pid]["武功"..i + 1] ~= nil and 
						JY.Person[pid]["武功"..i + 1] > 0 then
						person[#person] = person[#person].."，"
					end
				elseif i == 1 then
					person[#person] = person[#person].."无"
					break
				else
					break
				end
			end]]
			breakdown(person, 50)		
			plist[#plist] = person
		end	
	end	
	return plist
end	

function newgame()
	CC.ICONPICFILE = {CONFIG.DataPath .. "icon.idx", CONFIG.DataPath .. "icon.grp"}
	lib.PicLoadFile(CC.ICONPICFILE[1], CC.ICONPICFILE[2], 54)
	say("欢迎进入这个刀光剑影的世界，这里有山峦，有城寨，有江湖，简称－Ｏ山寨江湖。", 585)
	local hard, mode, fight = gamemode()
	JY.Thing[202][WZ7] = hard
	JY.DIFF = JY.Thing[202][WZ7] --难度 
	if fight == 1 then --战斗模式
		SetS(4, 7, 7, 5, 0)	
	elseif fight == 2 then
		SetS(4, 7, 7, 5, 1)
	elseif fight == 3 then
		SetS(4, 7, 7, 5, 2)
	end
	
	for p = 1, JY.PersonNum - 1 do
		if (not duiyou(p)) and (JY.Person[p]["资质"] == 10 or JY.Person[p]["资质"] == 60) and xiaobin(p) then
			JY.Person[p]["资质"] = math.random(10, 90)
		end
	end  
	Cls()
	SetS(103, 0, 0, 1, 0)
	if mode == 3 then
		local menu = {}
		local r
		say("在开始你的旅程之前，请回答几个问题。", 585)
		say("请问你的Ｏ性别Ｗ是？", 585)
		menu = {
			{"  须眉  ", nil, 1},
			{"  巾帼  ", nil, 1},	
		}
		r = ShowMenu3(menu,#menu,1,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,nil, nil,M_DimGray,C_RED)
		JY.Person[0]["性别"] = r - 1
		say("请问你Ｏ尊姓大名Ｗ？", 585)	
		JY.Person[0][CC.s23] = "";
		while JY.Person[0][CC.s23] == "" do
			JY.Person[0][CC.s23] = Shurufa(32, CC.ScreenH - 6 * CC.Fontbig)
			if JY.Person[0][CC.s23] == "" then
				DrawStrBoxWaitKey("没名字怎么玩游戏", C_WHITE, 30)
			end
		end	
		say("久仰久仰，江湖上一定给了你一个响亮的称号吧，你的Ｏ称号Ｗ是？", 585)
		JY.Person[578]["姓名"] = "";
		while JY.Person[578]["姓名"] == "" do
			JY.Person[578]["姓名"] = Shurufa(32, CC.ScreenH - 6 * CC.Fontbig)
			if JY.Person[578]["姓名"] == "" then
				DrawStrBoxWaitKey("给自己起个称号吧", C_WHITE, 30)
			end
		end		
		
		say("虽然有些冒昧，但你的Ｏ长相Ｗ是怎么样的呢？", 585)
		JY.Person[0]["半身像"] = pickhead()
		say("果然是一表人才，那么你在Ｏ战斗中又是什么样子Ｗ的呢？", 585)
		local body = pickbody()
		JY.Person[0]["头像代号"] = JY.Person[body]["头像代号"]
		for i = 1, 5 do
			JY.Person[0]["出招动画帧数" .. i] = JY.Person[body]["出招动画帧数" .. i]
			JY.Person[0]["出招动画延迟" .. i] = JY.Person[body]["出招动画延迟" .. i]
			JY.Person[0]["武功音效延迟" .. i] = JY.Person[body]["武功音效延迟" .. i]
		end	
		say("请问你认为自己的Ｏ资质Ｗ如何？？", 585)
		--DrawStrBoxWaitKey(CC.EVB124, C_WHITE, 30)
		local T = {}
		for a = 1, 1000 do
		  local b = "" .. a
		  T[b] = a
		end
		JY.Person[0]["资质"] = -1
		while JY.Person[0]["资质"] == -1 do
			local r = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
			if T[r] ~= nil and T[r] > -1 and T[r] < 101 then
			  JY.Person[0]["资质"] = T[r]
			else
				DrawStrBoxWaitKey(CC.EVB125, C_WHITE, 30)
			end
		  end	
		say("那么你所学的Ｏ内力性质Ｗ倾向于哪一方面呢？", 585)
		Cls()
		local nl = JYMsgBox(CC.EVB122, CC.EVB123, CC.EVB126, 3, 280)
		if nl == 1 then
		  JY.Person[0]["内力性质"] = 0
		elseif nl == 2 then
		  JY.Person[0]["内力性质"] = 1
		else
		  JY.Person[0]["内力性质"] = 2
		end	
		say("在踏上江湖路之前，给你一个学习的机会吧，请善用你的技能点数。", 585)
		tb("你现在最多可以学习"..4 + JY.Thing[203][WZ6].."个技能")

		learnSK()
		say("其实你还可以创建自己的战意技，请善用你的技能点数。", 585)
		tb("你现在最多可以领悟".."3".."个战意组件")
		learnDZ()
		say("果然厉害，那么给战意技取个名字吧。", 585)
		JY.Person[579]["姓名"] = "";
		while JY.Person[579]["姓名"] == "" do
			JY.Person[579]["姓名"] = Shurufa(32, CC.ScreenH - 6 * CC.Fontbig)
			if JY.Person[579]["姓名"] == "" then
				DrawStrBoxWaitKey("给自己战意技起个名字吧", C_WHITE, 30)
			end
		end	
		tb("好的，你的战意技可在觉醒后开启")
		say("最后一个问题，既然是测试版，那么就给你特别服务吧。请问小二最喜欢的称号是什么？回答出来的话有奖哦。", 585)
		local ss = "";
		while ss == "" do
			ss = Shurufa(32, CC.ScreenH - 6 * CC.Fontbig)
			if ss == "杀人名医" then
				say("恭喜你答对了！", 585)
				instruct_2(174, math.random(10) * 1000)
				--10%学武功，10%印章，10%秘籍
				local gift = math.random(10)
				if gift <= 7 then
					instruct_2(math.random(14, 17), math.random(5))
				elseif gift == 8 then
					local thing = randomwugong2(8, 15)
					JY.Person[0]["武功1"] = JY.Thing[thing]["练出武功"]
					JY.Person[0]["武功等级1"] = 900			
				elseif gift == 9 then
					local thing = randomwugong2(7, 10)
					instruct_2(thing, 1)
				else
					addHZ(CC.HZ[math.random(#CC.HZ)][1])
				end

			else
				say("可惜答错了，不过没关系，下次再努力吧。", 585)
			end
		end		   
		JY.Person[0]["生命最大值"] = 50
		JY.Person[0]["内力最大值"] = 100
		JY.Person[0]["攻击力"] = 30
		JY.Person[0]["防御力"] = 30
		JY.Person[0]["轻功"] = 30
		JY.Person[0]["医疗能力"] = 30
		JY.Person[0]["用毒能力"] = 30
		JY.Person[0]["解毒能力"] = 30
		JY.Person[0]["抗毒能力"] = 30
		JY.Person[0]["拳掌功夫"] = 40
		JY.Person[0]["御剑能力"] = 40
		JY.Person[0]["耍刀技巧"] = 40
		JY.Person[0]["特殊兵器"] = 40
		JY.Person[0]["暗器技巧"] = 40
		zjtype(4)
	elseif mode == 2 then
		local r = -1
		local plist = cxlist()
		r = sidetoside(plist, 3)
		CC.SKpoint = CC.SKpoint - (700 + 300 * (JY.Person[r]["排行"] - 2))
		SetS(103, 0, 0, 1, r)
		zjtype(3)
		Cls()
		JY.Person[0]["姓名"] = JY.Person[r]["姓名"]
		JY.Person[0]["性别"] = JY.Person[r]["性别"]
		JY.Person[0]["头像代号"] = JY.Person[r]["头像代号"]
		JY.Person[0]["半身像"] = JY.Person[r]["半身像"]
		JY.Person[0]["无用"] = JY.Person[r]["无用"]
		JY.Person[0]["声望"] = JY.Person[r]["声望"]
		JY.Person[0]["生命增长"] = JY.Person[r]["生命增长"]	
		JY.Person[0]["生命最大值"] = limitX(math.modf(JY.Person[r]["生命最大值"]/3),100,500)
		JY.Person[0]["生命"] = JY.Person[0]["生命最大值"]
		JY.Person[0]["内力最大值"] = limitX(math.modf(JY.Person[r]["内力最大值"]/3),100,1000)
		JY.Person[0]["内力"] = JY.Person[0]["内力最大值"]
		JY.Person[0]["攻击力"] = 30
		JY.Person[0]["防御力"] = 30
		JY.Person[0]["轻功"] = 30
		JY.Person[0]["攻击带毒"] = limitX(JY.Person[r]["攻击带毒"],0,50)		
		JY.Person[0]["武学常识"] = limitX(JY.Person[r]["武学常识"],0,20)
		JY.Person[0]["医疗能力"] = limitX(JY.Person[r]["医疗能力"],30,50)
		JY.Person[0]["用毒能力"] = limitX(JY.Person[r]["用毒能力"],30,50)
		JY.Person[0]["解毒能力"] = limitX(JY.Person[r]["解毒能力"],30,50)
		JY.Person[0]["抗毒能力"] = limitX(JY.Person[r]["抗毒能力"],30,50)
		JY.Person[0]["拳掌功夫"] = limitX(JY.Person[r]["拳掌功夫"],20,50)
		JY.Person[0]["御剑能力"] = limitX(JY.Person[r]["御剑能力"],20,50)
		JY.Person[0]["耍刀技巧"] = limitX(JY.Person[r]["耍刀技巧"],20,50)
		JY.Person[0]["特殊兵器"] = limitX(JY.Person[r]["特殊兵器"],20,50)
		JY.Person[0]["暗器技巧"] = limitX(JY.Person[r]["暗器技巧"],20,50) --武骧金星：微调
		JY.Person[0]["资质"] = JY.Person[r]["资质"]
		JY.Person[0]["左右互搏"] = JY.Person[r]["左右互搏"]
		if r == 76 then
			JY.Person[0]["等级"] = 20
			JY.Person[0]["攻击力"] = 1
			JY.Person[0]["防御力"] = 1
			JY.Person[0]["轻功"] = 1			
		end			
		if r == 75 then
			JY.Person[0]["拳掌功夫"] = 5
			JY.Person[0]["御剑能力"] = 5
			JY.Person[0]["耍刀技巧"] = 5
			JY.Person[0]["特殊兵器"] = 5
		end
		for i = 1, 10 do
			JY.Person[0]["武功"..i] = JY.Person[r]["武功"..i]
			JY.Person[0]["武功等级"..i] = JY.Person[r]["武功等级"..i]
				    for ii = 0,JY.ThingNum - 1 do
					if JY.Thing[ii]["练出武功"] == JY.Person[0]["武功"..i] then
						local level = math.modf((JY.Person[0]["武功等级" ..i])/100) + 1
						if level > 10 then level = 10 end
						AddPersonAttrib(0, "内力最大值", JY.Thing[ii]["加内力最大值"]*2* level)
						AddPersonAttrib(0, "攻击力", JY.Thing[ii]["加攻击力"]*2* level)
						AddPersonAttrib(0, "轻功", JY.Thing[ii]["加轻功"]*2* level)
						AddPersonAttrib(0, "防御力", JY.Thing[ii]["加防御力"]*2* level)	
						AddPersonAttrib(0, "医疗能力", JY.Thing[ii]["加医疗能力"]*2* level)
						AddPersonAttrib(0, "用毒能力", JY.Thing[ii]["加用毒能力"]*2* level)
						AddPersonAttrib(0, "解毒能力", JY.Thing[ii]["加解毒能力"]*2* level)
						AddPersonAttrib(0, "抗毒能力", JY.Thing[ii]["加抗毒能力"]*2* level)
						AddPersonAttrib(0, "拳掌功夫", JY.Thing[ii]["加拳掌功夫"]*2* level)
						AddPersonAttrib(0, "御剑能力", JY.Thing[ii]["加御剑能力"]*2* level)
						AddPersonAttrib(0, "耍刀技巧", JY.Thing[ii]["加耍刀技巧"]*2* level)
						AddPersonAttrib(0, "特殊兵器", JY.Thing[ii]["加特殊兵器"]*2* level)	
						AddPersonAttrib(0, "暗器技巧", JY.Thing[ii]["加暗器技巧"]*2* level)
						break
					end
				end
		end
		for i = 1, 5 do
			JY.Person[0]["出招动画帧数" .. i] = JY.Person[r]["出招动画帧数" .. i]
			JY.Person[0]["出招动画延迟" .. i] = JY.Person[r]["出招动画延迟" .. i]
			JY.Person[0]["武功音效延迟" .. i] = JY.Person[r]["武功音效延迟" .. i]
		end		
		for i = 1, 5 do
			JY.Person[0]["技能" .. i] = JY.Person[r]["技能" .. i]
		end	
		Cls()
		local T = {}
		for a = 1, 1000 do
			local b = "" .. a
			T[b] = a
		end
		DrawStrBoxWaitKey(CC.EVB124, C_WHITE, 30)
		JY.Person[0]["资质"] = -1
		while JY.Person[0]["资质"] == -1 do
			local r = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
			if T[r] ~= nil and T[r] > -1 and T[r] < 101 then
				JY.Person[0]["资质"] = T[r]
			else
				DrawStrBoxWaitKey(CC.EVB125, C_WHITE, 30)
			end
		end	
		Cls()
		DrawStrBoxWaitKey("请输入角色的体质 范围1-10", C_WHITE, 30)
		JY.Person[0]["生命增长"] = -1
		while JY.Person[0]["生命增长"] == -1 do
			local r = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
			if T[r] ~= nil and T[r] > 0 and T[r] < 11 then
				JY.Person[0]["生命增长"] = T[r]
			else
				DrawStrBoxWaitKey("输入错误 范围1-10 请重新输入", C_WHITE, 30)
			end
		end
		Cls()
		local nl = JYMsgBox(CC.EVB122, CC.EVB123, CC.EVB126, 3, 280)
		if nl == 1 then
		  JY.Person[0]["内力性质"] = 0
		elseif nl == 2 then
		  JY.Person[0]["内力性质"] = 1
		else
		  JY.Person[0]["内力性质"] = 2
		end		
	else
		local t, c = newselect()	
		JY.Person[0]["生命最大值"] = 50
		JY.Person[0]["内力最大值"] = 100
		JY.Person[0]["攻击力"] = 30
		JY.Person[0]["防御力"] = 30
		JY.Person[0]["轻功"] = 30
		JY.Person[0]["医疗能力"] = 30
		JY.Person[0]["用毒能力"] = 30
		JY.Person[0]["解毒能力"] = 30
		JY.Person[0]["抗毒能力"] = 30
		JY.Person[0]["拳掌功夫"] = 30
		JY.Person[0]["御剑能力"] = 30
		JY.Person[0]["耍刀技巧"] = 30
		JY.Person[0]["特殊兵器"] = 30
		JY.Person[0]["暗器技巧"] = 30	
		JY.Person[0]["生命增长"] = math.random(1, 10)
		JY.Person[0]["左右互搏"] = 0
		if t == 1 then
			DrawStrBoxWaitKey(CC.EVB156, C_WHITE, 30)
			JY.Person[0][CC.s23] = "";
			while JY.Person[0][CC.s23] == "" do
				JY.Person[0][CC.s23] = Shurufa(32, CC.ScreenH - 6 * CC.Fontbig)
				if JY.Person[0][CC.s23] == "" then
					DrawStrBoxWaitKey("没名字怎么玩游戏", C_WHITE, 30)
				end
			end	
			local T = {}
			for a = 1, 1000 do
				local b = "" .. a
				T[b] = a
			end
			DrawStrBoxWaitKey("请选择性别", C_WHITE, 30)
			local mm = {
				{"  须眉  ", nil, 1},
				{"  巾帼  ", nil, 1},	
			}
			Cls()
			local aa = ShowMenu3(mm,#mm,1,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,nil, nil,M_DimGray,C_RED)
			JY.Person[0]["性别"] = aa - 1				
			DrawStrBoxWaitKey(CC.EVB124, C_WHITE, 30)
			JY.Person[0]["资质"] = -1
			while JY.Person[0]["资质"] == -1 do
				local r = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
				if T[r] ~= nil and T[r] > -1 and T[r] < 101 then
					JY.Person[0]["资质"] = T[r]
				else
					DrawStrBoxWaitKey(CC.EVB125, C_WHITE, 30)
				end
			end	
			DrawStrBoxWaitKey("请输入角色的体质 范围1-10", C_WHITE, 30)
			JY.Person[0]["生命增长"] = -1
			while JY.Person[0]["生命增长"] == -1 do
				local r = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
				if T[r] ~= nil and T[r] > 0 and T[r] < 11 then
					JY.Person[0]["生命增长"] = T[r]
				else
					DrawStrBoxWaitKey("输入错误 范围1-10 请重新输入", C_WHITE, 30)
				end
			end				
			zjtype(1)
			putong(c)
				SetS(112,1,0,0,0)
				SetS(112,2,0,0,0)
				SetS(112,3,0,0,0)
			if c == 1 then         --拳
			  JY.Person[0][CC.s15] = 60
			elseif c == 2 then     --剑
			  JY.Person[0][CC.s16] = 60   
			elseif c == 3 then     --刀
			  JY.Person[0][CC.s17] = 60
			elseif c == 4 then		 --特 
			  JY.Person[0][CC.s18] = 60
			elseif c == 13 then
			  JY.Person[0]["暗器技巧"] = 60	
			elseif c == 5 then		 --罡
			  JY.Person[0][CC.s19] = 500
			  JY.Person[0]["内力"] = 500
			  JY.Person[0][CC.s20] = 2
			elseif c == 6 or c == 9 or c == 12 then		 --仁 武骧金星：补全阵的设定
			  JY.Person[0][CC.s15] = 40
			  JY.Person[0][CC.s16] = 40
			  JY.Person[0][CC.s17] = 40
			  JY.Person[0][CC.s18] = 40
			  JY.Person[0]["暗器技巧"] = 40	
			elseif c == 7 then		 --医 
			  --JY.Person[0][PSX[37]] = 200
			  --JY.Person[0][PSX[38]] = 200
			  --JY.Person[0][PSX[39]] = 200	  
			end	

			if c == 6 then JY.Person[0][CC.s21] = 100 end
			if c == 9 then 
				RWWH[0] = "血海飘零";
				RWTFLB[0] = "血手仁义";
			end
			Cls()
			local nl = JYMsgBox(CC.EVB122, CC.EVB123, CC.EVB126, 3, 280)
			if nl == 1 then
			  JY.Person[0]["内力性质"] = 0
			elseif nl == 2 then
			  JY.Person[0]["内力性质"] = 1
			else
			  JY.Person[0]["内力性质"] = 2
			end				
			DrawStrBoxWaitKey("请选择头像", C_WHITE, 30)			
			JY.Person[0]["半身像"] = pickhead()
			DrawStrBoxWaitKey("请选择战斗形象", C_WHITE, 30)	
			local body = pickbody()
			JY.Person[0]["头像代号"] = JY.Person[body]["头像代号"]
			for i = 1, 5 do
				JY.Person[0]["出招动画帧数" .. i] = JY.Person[body]["出招动画帧数" .. i]
				JY.Person[0]["出招动画延迟" .. i] = JY.Person[body]["出招动画延迟" .. i]
				JY.Person[0]["武功音效延迟" .. i] = JY.Person[body]["武功音效延迟" .. i]
			end	
            tfkf()				
		else
			zjtype(2)
			teshu(c)
			JY.Thing[201][WZ7] = 8
			JY.Person[0]["攻击力"] = 40
			JY.Person[0]["防御力"] = 40
			JY.Person[0]["轻功"] = 40
				SetS(112,1,0,0,0)
				SetS(112,2,0,0,0)
				SetS(112,3,0,0,0)
			--JY.Person[0]["暗器技巧"] = 50 武骧金星：取消
			if c == 1 then
				JY.Person[0]["生命增长"] = 8
				JY.Person[0]["拳掌功夫"] = 50
				JY.Person[0]["御剑能力"] = 50
				JY.Person[0]["耍刀技巧"] = 50
				JY.Person[0]["特殊兵器"] = 50
				JY.Person[0]["资质"] = 100
				JY.Person[0]["内力最大值"] = 300
				JY.Person[0]["生命最大值"] = 100
				JY.Person[0][CC.s23] = "零二七"
				JY.Person[0]["半身像"] = 577
				JY.Person[0]["技能1"] = 10
				JY.Person[0]["技能2"] = 16
				SetS(112,2,0,0,105)
				SetS(112,1,0,0,0)
				SetS(112,3,0,0,0)
			elseif c == 2 then 
				JY.Person[0]["生命增长"] = 4
				JY.Person[0]["拳掌功夫"] = 50
				JY.Person[0]["御剑能力"] = 50
				JY.Person[0]["耍刀技巧"] = 50
				JY.Person[0]["特殊兵器"] = 50	
				JY.Person[0]["左右互搏"] = 1
				JY.Person[0]["资质"] = 50
				JY.Person[0][CC.s23] = "水镜先生"
				JY.Person[0]["半身像"] = 565
				JY.Person[0]["技能1"] = 112
				JY.Person[0]["技能2"] = 16
			elseif c == 3 then
				JY.Person[0]["生命增长"] = 7
				JY.Person[0]["内力最大值"] = 200
				JY.Person[0]["拳掌功夫"] = 40
				JY.Person[0]["御剑能力"] = 40
				JY.Person[0]["耍刀技巧"] = 40
				JY.Person[0]["特殊兵器"] = 40
				JY.Person[0]["暗器技巧"] = 50
				JY.Person[0]["资质"] = 80
				JY.Person[0]["左右互搏"] = 1
				JY.Person[0][CC.s23] = "萧雨客"
				JY.Person[0]["半身像"] = 450
				JY.Person[0]["技能1"] = 65
				JY.Person[0]["技能2"] = 16
				JY.Person[0]["头像代号"] = 349
				for i = 1, 5 do
					if i == 5 then 
						JY.Person[0]["出招动画帧数"..i] = 17
						JY.Person[0]["出招动画延迟"..i] = 14
						JY.Person[0]["武功音效延迟"..i] = 13
					else
						JY.Person[0]["出招动画帧数"..i] = 0
						JY.Person[0]["出招动画延迟"..i] = 0
						JY.Person[0]["武功音效延迟"..i] = 0
					end
				end
			elseif c == 4 then
				JY.Person[0]["生命增长"] = 8
				JY.Person[0]["御剑能力"] = 60
				JY.Person[0]["耍刀技巧"] = 60
				JY.Person[0]["左右互搏"] = 1
				JY.Person[0]["资质"] = 80
				JY.Person[0][CC.s23] = "王小石"
				JY.Person[0]["半身像"] = 536
				JY.Person[0]["技能1"] = 31
				JY.Person[0]["技能2"] = 16
			elseif c == 5 then
				JY.Person[0]["生命增长"] = 2
				JY.Person[0]["拳掌功夫"] = 60
				JY.Person[0]["资质"] = 90
				JY.Person[0][CC.s23] = "白愁飞"
				JY.Person[0]["半身像"] = 543
				JY.Person[0]["技能1"] = 38
				JY.Person[0]["技能2"] = 16
				JY.Person[0]["头像代号"] = 353
				for i = 1, 5 do
					if i == 2 then 
						JY.Person[0]["出招动画帧数"..i] = 10
						JY.Person[0]["出招动画延迟"..i] = 8
						JY.Person[0]["武功音效延迟"..i] = 7
					else
						JY.Person[0]["出招动画帧数"..i] = 0
						JY.Person[0]["出招动画延迟"..i] = 0
						JY.Person[0]["武功音效延迟"..i] = 0
					end
				end
			elseif c == 6 then
				JY.Person[0]["生命增长"] = 5
				JY.Person[0]["内力最大值"] = 300
				JY.Person[0]["御剑能力"] = 50
				JY.Person[0]["资质"] = 90
				JY.Person[0][CC.s23] = "萧秋水"	
				JY.Person[0]["半身像"] = 334	
				JY.Person[0]["技能1"] = 40	
				JY.Person[0]["技能2"] = 16	
				JoinMP(0,0,0)
			elseif c == 7 then
				JY.Person[0]["拳掌功夫"] = 20
				JY.Person[0]["御剑能力"] = 20
				JY.Person[0]["耍刀技巧"] = 20
				JY.Person[0]["特殊兵器"] = 20
				JY.Person[0]["资质"] = 90
				JY.Person[0][CC.s23] = "东方未明"	
				JY.Person[0]["半身像"] = 534
				JY.Person[0]["技能1"] = 51
				JY.Person[0]["技能2"] = 16
				SetS(112,1,0,0,43)
				SetS(112,2,0,0,97)
				SetS(112,3,0,0,0)
			elseif c == 8 then
                for i,v in pairs(CC.Person_S) do
                JY.Person[0][i] = JY.Person[7][i]
				end
				JY.Person[0]["技能1"] = 0
	            JY.Person[0]["技能2"] = 0
				JY.Person[0]["技能3"] = 0
				JY.Person[0]["技能4"] = 0
				JY.Person[0]["携带物品1"] = -1
	            JY.Person[0]["携带物品数量1"] = 0
				JY.Person[0]["携带物品2"] = -1
	            JY.Person[0]["携带物品数量2"] = 0
				JY.Person[0]["携带物品3"] = -1
	            JY.Person[0]["携带物品数量3"] = 0
				JY.Person[0]["携带物品4"] = -1
	            JY.Person[0]["携带物品数量4"] = 0
				JY.Person[0]["等级"] = 1
				JY.Person[0]["生命最大值"] = 50
				JY.Person[0]["医疗能力"] = 30
				JY.Person[0]["用毒能力"] = 30
				JY.Person[0]["解毒能力"] = 30
				JY.Person[0]["实战"] = 0
				JY.Person[0]["头像代号"] = 345
				JY.Person[0]["内力最大值"] = 200
				JY.Person[0]["武功1"] = 0
				JY.Person[0]["武功等级1"] = 0
				JY.Person[0]["生命增长"] = 3
				JY.Person[0]["攻击力"] = 50
				JY.Person[0]["防御力"] = 30
				JY.Person[0]["轻功"] = 40
				JY.Person[0]["拳掌功夫"] = 30
				JY.Person[0]["御剑能力"] = 60
				JY.Person[0]["耍刀技巧"] = 30
				JY.Person[0]["特殊兵器"] = 30
				JY.Person[0]["暗器技巧"] = 80
				JY.Person[0]["资质"] = 90
				JY.Person[0][CC.s23] = "李逍遥"
				JY.Person[0]["半身像"] = 440
				JY.Person[0]["头像代号"] = 345
				JY.Person[0]["技能1"] = 83
				JY.Person[0]["技能2"] = 16
				JY.Person[0]["声望"] = 0
				for z = 2, 12 do 
					JY.Person[0]["武功"..z] = 0
					JY.Person[0]["武功等级"..z] = 0
				end	
				JoinMP(0,0,0)
				instruct_10(655) --武骧金星：让仙剑三女直接加入
				instruct_10(656)
				instruct_10(657)				
			elseif c == 9 then --武骧金星：允许选择赵云
                for i,v in pairs(CC.Person_S) do
                JY.Person[0][i] = JY.Person[592][i]
				end
				JY.Person[0]["等级"] = 1
				JY.Person[0]["生命最大值"] = 50
				JY.Person[0]["攻击力"] = 40
				JY.Person[0]["防御力"] = 40
				JY.Person[0]["医疗能力"] = 30
				JY.Person[0]["用毒能力"] = 30
				JY.Person[0]["解毒能力"] = 30
				JY.Person[0]["轻功"] = 40
				JY.Person[0]["实战"] = 0
				JY.Person[0]["头像代号"] = 344
				JY.Person[0]["技能1"] = 0
	            JY.Person[0]["技能2"] = 0
				JY.Person[0]["技能3"] = 0
				JY.Person[0]["技能4"] = 0
				JY.Person[0]["武功1"] = 0
				JY.Person[0]["武功等级1"] = 0
				JY.Person[0]["生命增长"] = 7
				JY.Person[0]["内力最大值"] = 200
				JY.Person[0]["特殊兵器"] = 60
				JY.Person[0]["资质"] = 80
				JY.Person[0][CC.s23] = "赵云"
				JY.Person[0]["半身像"] = 575
				JY.Person[0]["拳掌功夫"] = 40
				JY.Person[0]["御剑能力"] = 50
				JY.Person[0]["耍刀技巧"] = 40
				JY.Person[0]["特殊兵器"] = 60
				JY.Person[0]["暗器技巧"] = 40
				JY.Person[0]["武功2"] = 0
				JY.Person[0]["武功等级2"] = 0
				JY.Person[0]["武功3"] = 0
				JY.Person[0]["武功等级3"] = 0
				JY.Person[0]["技能1"] = 69
				JY.Person[0]["技能2"] = 16
				SetS(112,1,0,0,112)
				SetS(112,2,0,0,0)
				SetS(112,3,0,0,0)
			elseif c == 10 then --武骧金星：允许选择萧笑竹
				JY.Person[0][CC.s23] = "萧笑竹"
				JY.Person[0]["半身像"] = 576
				JY.Person[0]["资质"] = 100
				JY.Person[0]["拳掌功夫"] = 40
				JY.Person[0]["御剑能力"] = 40
				JY.Person[0]["耍刀技巧"] = 40
				JY.Person[0]["特殊兵器"] = 40
				JY.Person[0]["暗器技巧"] = 40
				JY.Person[0]["生命增长"] = 10
				JY.Person[0]["技能1"] = 21
				JY.Person[0]["技能2"] = 16
			elseif c == 11 then --武骧金星：增加藏镜人
				for i,v in pairs(CC.Person_S) do--谢无悠
                JY.Person[0][i] = JY.Person[930][i]
				end
				JY.Person[0][CC.s23] = "藏镜人"
				JY.Person[0]["半身像"] = 492
				JY.Person[0]["资质"] = 70
				JY.Person[0]["拳掌功夫"] = 70
				JY.Person[0]["生命增长"] = 7
				JY.Person[0]["头像代号"] = 346
				JY.Person[0]["技能1"] = 27
				JY.Person[0]["技能2"] = 16
			elseif c == 12 then --武骧金星：增加杨妙真
			for i,v in pairs(CC.Person_S) do
                JY.Person[0][i] = JY.Person[636][i]
			end
				JY.Person[0]["等级"] = 1
	            JY.Person[0]["武功2"] = 0
	            JY.Person[0]["武功等级2"] = 999
	            JY.Person[0]["武功3"] = 0
				JY.Person[0]["医疗能力"] = 30
				JY.Person[0]["用毒能力"] = 30
				JY.Person[0]["解毒能力"] = 30
	            JY.Person[0]["武功等级3"] = 999
				JY.Person[0]["攻击力"] = 120
				JY.Person[0]["防御力"] = 120
				JY.Person[0]["轻功"] = 120
				JY.Person[0]["武功1"] = 0
                JY.Person[0]["武功等级1"] = 999
				JY.Person[0]["技能1"] = 0
	            JY.Person[0]["技能2"] = 0
				JY.Person[0]["技能3"] = 0
				JY.Person[0]["携带物品1"] = -1
	            JY.Person[0]["携带物品数量1"] = 0
				JY.Person[0]["携带物品2"] = -1
	            JY.Person[0]["携带物品数量2"] = 0
				JY.Person[0][CC.s23] = "杨妙真"
				JY.Person[0]["半身像"] = 92
				JY.Person[0]["头像代号"] = 343
				JY.Person[0]["资质"] = 50
				JY.Person[0]["特殊兵器"] = 60
				JY.Person[0]["生命增长"] = 4
				JY.Person[0]["性别"] = 1
				JY.Person[0]["技能1"] = 79
				JY.Person[0]["技能2"] = 16
				SetS(112,1,0,0,112)
				SetS(112,2,0,0,0)
				SetS(112,3,0,0,0)		
			elseif c == 13 then --武骧金星：增加滕青山
				JY.Person[0][CC.s23] = "滕青山"
				JY.Person[0]["半身像"] = 502
				JY.Person[0]["资质"] = 80
				JY.Person[0]["拳掌功夫"] = 50
				JY.Person[0]["耍刀技巧"] = 50
				JY.Person[0]["特殊兵器"] = 50
				JY.Person[0]["生命增长"] = 10
			elseif c == 14 then --武骧金星：增加谢云流
                for i,v in pairs(CC.Person_S) do
                JY.Person[0][i] = JY.Person[72][i]
				end
				JY.Person[0][CC.s23] = "谢云流"
				JY.Person[0]["等级"] = 1
				JY.Person[0]["头像代号"] = 302
				JY.Person[0]["生命最大值"] = 50
				JY.Person[0]["内力最大值"] = 100
				JY.Person[0]["攻击力"] = 40
				JY.Person[0]["防御力"] = 40
				JY.Person[0]["医疗能力"] = 30
				JY.Person[0]["用毒能力"] = 30
				JY.Person[0]["解毒能力"] = 30
				JY.Person[0]["轻功"] = 40
				JY.Person[0]["实战"] = 0
				JY.Person[0]["半身像"] = 494
				JY.Person[0]["资质"] = 50
				JY.Person[0]["御剑能力"] = 90
	            JY.Person[0]["无用"] = 1104
                JY.Person[0]["生命增长"] = 10
                JY.Person[0]["武学常识"] = 20
				JY.Person[0]["武功1"] = 0
				JY.Person[0]["武功等级1"] = 0
				JY.Person[0]["武功2"] = 0
				JY.Person[0]["武功等级2"] = 0
				JY.Person[0]["技能1"] = 0
				JY.Person[0]["出招动画帧数3"] = 20
				JY.Person[0]["出招动画延迟3"] = 13
				JY.Person[0]["武功音效延迟3"] = 11
				SetS(112,1,0,0,131)
				SetS(112,2,0,0,180)
				SetS(112,3,0,0,115)
			elseif c == 15 then --武骧金星：增加聂风
			for i,v in pairs(CC.Person_S) do
                JY.Person[0][i] = JY.Person[1][i]
			end
				JY.Person[0][CC.s23] = "聂风"
				JY.Person[0]["半身像"] = 312
				JY.Person[0]["头像代号"] = 1
				JY.Person[0]["资质"] = 100
				JY.Person[0]["拳掌功夫"] = 80
				JY.Person[0]["御剑能力"] = 80
				JY.Person[0]["耍刀技巧"] = 90
				JY.Person[0]["特殊兵器"] = 80
				JY.Person[0]["暗器技巧"] = 80
				JY.Person[0]["生命增长"] = 8
				JY.Person[0]["轻功"] = 200
				JY.Person[0]["武功1"] = 88
				JY.Person[0]["武功等级1"] = 1
				JY.Person[0]["武功2"] = 155
				JY.Person[0]["武功等级2"] = 1
				JY.Person[0]["武功3"] = 98
				JY.Person[0]["武功等级3"] = 1
				JY.Person[0]["技能1"] = 83
				JY.Person[0]["技能2"] = 105
				JY.Person[0]["技能3"] = 114
				SetS(112,1,0,0,111)
				SetS(112,2,0,0,181)
				SetS(112,3,0,0,179)			
			elseif c == 16 then --竹风雨滴：增加步惊云
			for i,v in pairs(CC.Person_S) do
                JY.Person[0][i] = JY.Person[668][i]
			end
				JY.Person[0][CC.s23] = "步惊云"
				JY.Person[0]["头像代号"] = 300
				JY.Person[0]["半身像"] = 473
				JY.Person[0]["资质"] = 90
				JY.Person[0]["拳掌功夫"] = 90
				JY.Person[0]["御剑能力"] = 90
				JY.Person[0]["耍刀技巧"] = 80
				JY.Person[0]["特殊兵器"] = 80
				JY.Person[0]["暗器技巧"] = 80
				JY.Person[0]["生命增长"] = 10
				JY.Person[0]["攻击力"] = 200
				JY.Person[0]["防御力"] = 100
				JY.Person[0]["轻功"] = 100
				JY.Person[0]["武功1"] = 88
				JY.Person[0]["武功等级1"] = 1
				JY.Person[0]["武功2"] = 132
				JY.Person[0]["武功等级2"] = 1
				JY.Person[0]["技能1"] = 31
				JY.Person[0]["技能2"] = 52
				JY.Person[0]["技能3"] = 83
				JY.Person[0]["出招动画帧数2"] = 15
				JY.Person[0]["出招动画延迟2"] = 14
				JY.Person[0]["武功音效延迟2"] = 13
				JY.Person[0]["出招动画帧数3"] = 9
				JY.Person[0]["出招动画延迟3"] = 8
				JY.Person[0]["武功音效延迟3"] = 7
				SetS(112,1,0,0,25)
				SetS(112,2,0,0,103)
				SetS(112,3,0,0,116)
			end			
			Cls()
			local nl = JYMsgBox(CC.EVB122, CC.EVB123, CC.EVB126, 3, 280)
			if nl == 1 then
			  JY.Person[0]["内力性质"] = 0
			elseif nl == 2 then
			  JY.Person[0]["内力性质"] = 1
			else
			  JY.Person[0]["内力性质"] = 2
			end	
		--if c ~= 14 and c ~= 12 and c ~= 9 and c ~= 7 and c ~= 1 then
        tfkf() 
		--end
		end	
	end 

	JY.Person[0]["生命"] = JY.Person[0]["生命最大值"]
	JY.Person[0]["内力"] = JY.Person[0]["内力最大值"]
	Cls()
	ShowScreen()	
end

function tfkf()
        if GetS(112,1,0,0) < 1 then 
        DrawStrBoxWaitKey("请选择天赋外功", C_WHITE, 30)
		--DrawStrBoxWaitKey("请选择性别", C_WHITE, 30)
			local mm = {
				{"  拳  ", nil, 1},
				{"  剑  ", nil, 1},	
				{"  刀  ", nil, 1},
				{"  特  ", nil, 1},
				{"  暗  ", nil, 1},
			}
			Cls()
			local aa = ShowMenu3(mm,#mm,1,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,nil, nil,M_DimGray,C_RED)
		local list = {}
		local x1 = CC.MainSubMenuX
		local y1 = CC.MainSubMenuY		
			if aa == 1 then
				list = {1,3,4,5,7,8,9,10,11,12,13,14,15,16,17,19,20,21,22,23,24,25,26,126,127,128,129,130,132,133}
			elseif aa == 2 then
				list = {27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,114,123,125,134,135,136,137,154}
			elseif aa == 3 then
				list = {50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,138,139,140,141,155,156,157}
			elseif aa == 4 then
				list = {68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,86,120,142,144,145,146,147,202}
			elseif aa == 5 then
				list = {148,149,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,18,175,176,177}
			end
		local menu = {}
		for i = 1, #list do
			menu[i] = {JY.Wugong[list[i]]["名称"], nil, 1}
		end
		local r = ShowMenu(menu,#menu,15,x1,y1+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);	
		SetS(112,1,0,0,list[r])
		end
		if GetS(112,2,0,0) < 1 then 
        DrawStrBoxWaitKey("请选择天赋内功", C_WHITE, 30)
		local list = {}
		local x1 = CC.MainSubMenuX
		local y1 = CC.MainSubMenuY		
		list = {6,85,88,87,89,90,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,121,124,150,151,152,153,189,178,180,181,182,183,184,185,186,187,188,203}
		local menu = {}
		for i = 1, #list do
			menu[i] = {JY.Wugong[list[i]]["名称"], nil, 1}
		end
		local r = ShowMenu(menu,#menu,15,x1,y1+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);	
		SetS(112,2,0,0,list[r])
		end 
		if GetS(112,3,0,0) < 1 then 
        DrawStrBoxWaitKey("请选择天赋轻功", C_WHITE, 30)
		local list = {}
		local x1 = CC.MainSubMenuX
		local y1 = CC.MainSubMenuY		
		list = {115,116,117,118,119,143,179,190,191,192,193,194,195,196,197,199,200}
		local menu = {}
		for i = 1, #list do
			menu[i] = {JY.Wugong[list[i]]["名称"], nil, 1}
		end
		local r = ShowMenu(menu,#menu,15,x1,y1+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);	
		SetS(112,3,0,0,list[r])
		end
end

function mmtfkf()
        DrawStrBoxWaitKey("请选择天赋武功", C_WHITE, 30)
--		JY.Person[578]["攻击力"] = 0
		local list = {}
		local x1 = CC.MainSubMenuX
		local y1 = CC.MainSubMenuY		
		list = {1,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,
                27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,
				50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,
				68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,86,
				109,110,111,112,114,120,123,125,126,127,128,129,130,132,133,134,
				135,136,137,138,139,140,141,142,144,145,146,147,148,149,154,155,156,
				157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177}
		local menu = {}
		for i = 1, #list do
			menu[i] = {JY.Wugong[list[i]]["名称"], nil, 1}
		end
		local r = ShowMenu(menu,#menu,15,x1,y1+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);
		if r <= 0 then
		JY.Person[578]["攻击力"]=0
		else
		JY.Person[578]["攻击力"]=list[r]
		end
        DrawStrBoxWaitKey("请选择天赋内功", C_WHITE, 30)
--		JY.Person[578]["防御力"]=0
		local list = {}
		local x1 = CC.MainSubMenuX
		local y1 = CC.MainSubMenuY		
		list = {6,85,88,87,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,121,124,150,151,152,153,189,178,180,181,182,183,184,188}
		local menu = {}
		for i = 1, #list do
			menu[i] = {JY.Wugong[list[i]]["名称"], nil, 1}
		end
		local r = ShowMenu(menu,#menu,15,x1,y1+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);	
		if r <= 0 then
		JY.Person[578]["防御力"]=0
		else
		JY.Person[578]["防御力"]=list[r]
		end
        DrawStrBoxWaitKey("请选择天赋轻功", C_WHITE, 30)
	--	JY.Person[578]["轻功"]=0
		local list = {}
		local x1 = CC.MainSubMenuX
		local y1 = CC.MainSubMenuY		
		list = {197,115,116,117,118,119,143,179,190,191,192,193,194,195,196}
		local menu = {}
		for i = 1, #list do
			menu[i] = {JY.Wugong[list[i]]["名称"], nil, 1}
		end
		local r = ShowMenu(menu,#menu,15,x1,y1+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);	
		if r <= 0 then
		JY.Person[578]["轻功"]=0
		else
		JY.Person[578]["轻功"]=list[r]
		end
        DrawStrBoxWaitKey("请选择一项天赋能力", C_WHITE, 30)
		local menu = {}
	    for i = 1, #CC.TFlist do
		menu[i] = {CC.TFlist[i][1], nil, 1}
		if hasTF(92,i) then 
		menu[i][3] = 0
		end
		end
		local r = ShowMenu(menu,#menu,15,x1,y1+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);	
		if r <= 0 then
		JY.Person[92]["技能3"]=0
		else
		JY.Person[92]["技能3"]= r
		end
end

function gamemode()
	local s1 = "第"..JY.Thing[203][WZ6].."周目"
	local s2 = "剩余"..CC.SKpoint.."技能点"
	local size = 25
	local a = {
		{"无名小卒", "新手适用，敌方能力很低"}, 
		{"江湖侠客", "进阶适用，敌方能力较低，会习得随机内功"}, 
		{"一代宗师", "高手适用，敌方能力正常，会习得随机主功体"}, 
		{"武林泰斗", "骨灰适用，敌方能力较高，会习得随机主功体以及天赋"}, 
		{"不败传说", "挑战适用，敌方能力很高，会习得随机主功体以及天赋，并获得一个随机人物称号效果"}, 
		{"天下独步", "？？？？？"}, 
	}
	local b = {
		{"一般模式", "选择普通主角或者特殊主角"},
		{"畅想模式", "用技能点数解锁NPC进行游戏，至少须1000点技能点"},
		{"自由模式", "自选造型以及用技能点习得各种技能，至少须1000点技能点"},
	}
	local c = {
		{"一般模式", "一般的战斗模式，喜欢群殴的可选"},
		{"单通模式", "大部分战斗只能主角上场，主角拥有队伍中队友的特效"},
		{"普单模式", "用于高手挑战的模式，大部分战斗只能主角上场且不能获得队友的特效"},
	}
	local t = {a, b, c}
	local t2 = {1, 1, 1}
	local count1 = 1
	local count2 = 1
	local x1 = 240 --110
	local y1 = 230 --50
	local x2 = 110
	local y2 = 50

	while true do
		Cls()
		lib.PicLoadFile(CC.ThingPicFile[1], CC.ThingPicFile[2], 93)
		lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_BLACK)
		lib.PicLoadCache(93,8, 500, 300)
		--lib.LoadPicture(CONFIG.PicturePath.."scroll2.png", -1, -1)  
		tb2(s1, -1, 130, C_ORANGE)
		tb2(s2, -1, 160, C_ORANGE)
		DrawBox(x1 + x2 * (count2 - 1) - 5, y1 + y2 * (count1 - 1) - 5, x1 + x2 * (count2 - 1) + 105, y1 + y2 * (count1 - 1) + 30, C_WHITE)	
		DrawStrBox(-1, 390, t[count1][count2][2], C_ORANGE, 22)
		DrawString(120, 230, "难度", C_ORANGE, 25)
		DrawString(240, 230, "无名小卒", C_GOLD, 25)
		DrawString(350, 230, "江湖侠客", C_GOLD, 25)
		DrawString(460, 230, "一代宗师", C_GOLD, 25)
		DrawString(570, 230, "武林泰斗", C_GOLD, 25)
		DrawString(680, 230, "不败传说", C_GOLD, 25)
		DrawString(790, 230, "天下独步", C_GOLD, 25)
		DrawString(120, 280, "主角模式", C_ORANGE, 25)
		DrawString(240, 280, "一般模式", C_GOLD, 25)
		DrawString(350, 280, "畅想模式", C_GOLD, 25)
		DrawString(460, 280, "自由模式", C_GOLD, 25)
		DrawString(120, 330, "战斗模式", C_ORANGE, 25)
		DrawString(240, 330, "一般模式", C_GOLD, 25)
		DrawString(350, 330, "单通模式", C_GOLD, 25)
		DrawString(460, 330, "普单模式", C_GOLD, 25)
		tb2("上下左右键移动选框  按回车键选择  全部满意后按Y键确定", -1, 450, C_ORANGE)
		DrawString(x1 + x2 * (t2[1] - 1), y1, t[1][t2[1]][1], C_RED, 25)
		DrawString(x1 + x2 * (t2[2] - 1), y1 + y2, t[2][t2[2]][1], C_RED, 25)
		DrawString(x1 + x2 * (t2[3] - 1), y1 + y2 * 2, t[3][t2[3]][1], C_RED, 25)
		--DrawString(x1 + x2 * (count2 - 1), y1 + y2 * (count1 - 1), t[count1][count2][1], C_RED, 25)
		if CC.SKpoint < 1000 then
			DrawString(350, 280, "畅想模式", M_Gray, 25)
			DrawString(460, 280, "自由模式", M_Gray, 25)
		end
		ShowScreen()
		local p = WaitKey()
		if p == VK_SPACE or p == VK_RETURN then
			if count1 == 2 then
				if (count2 == 2 or count2 == 3) and CC.SKpoint < 1000 then
					
				else
					t2[count1] = count2
				end
			else
				t2[count1] = count2
			end		
		elseif p == VK_ESCAPE then
			--break
		elseif p == VK_UP then
			count1 = count1 - 1
			if count1 < 1 then count1 = #t end
		elseif p == VK_DOWN then			
			count1 = count1 + 1
			if count1 > #t then count1 = 1 end
		elseif p == VK_LEFT then
			count2 = count2 - 1
			if count2 < 1 then count2 = #t[count1] end		
		elseif p == VK_RIGHT then
			count2 = count2 + 1
			if count2 > #t[count1] then count2 = 1 end
		elseif p == 121 then
			return t2[1], t2[2], t2[3]
		end
		if count2 > #t[count1] then count2 = #t[count1] end
	end
end

function newselect()
	local function ph(t, c)
		if t == 1 then
			if c <= 7 then
				return 280 + c
			else
				return 340 - 8 + c
			end
		else
			return 287 + c
		end
	end
	local function disable(t, c)
		local dd = {}
		local dd2 = {}
		if t == 1 then
			for i = 1, #dd do
				if c == dd[i] then
					return true
				end
			end
		end
		if t == 2 then
			for i = 1, #dd2 do
				if c == dd2[i] then
					return true
				end
			end
		end		
		return false
	end
	local start = {80, 100}
	local t = 1
	local c = 1
	local maxc = {13, 16} --武骧金星：允许选择赵云和萧笑竹
	local tmp = {280, 287}
	CleanMemory()
	CC.ICONPICFILE = {CONFIG.DataPath .. "icon.idx", CONFIG.DataPath .. "icon.grp"}
	CC.HeadPicFile = {CONFIG.DataPath .. "atmb.idx", CONFIG.DataPath .. "atmb.grp"}
	--lib.PicLoadFile(CC.HeadPicFile[1], CC.HeadPicFile[2], 53)	
	CC.HeadPicFile = {CONFIG.DataPath .. "shead.idx", CONFIG.DataPath .. "shead.grp"}
	lib.PicLoadFile(CC.ThingPicFile[1], CC.ThingPicFile[2], 93)

	while true do
		Cls()
		lib.PicLoadCache(93, 0, 500, 300)
		--lib.LoadPicture(CONFIG.PicturePath .. "bj0.png", 0, 0)
		--lib.LoadPicture(CC.STA, -1, -1)
		if disable(t,c ) then
			lib.PicLoadCache(53, ph(t, c) * 2, 495, 300)	
			lib.PicLoadCache(54, 80 * 2, 495, 300)			
		else
			lib.PicLoadCache(53, ph(t, c) * 2, 495, 300)	
			lib.PicLoadCache(54, (start[t] + c) * 2, 495, 300)
		end
		--lib.PicLoadCache(54, 75 * 2, CC.ScreenW/2 - 125, CC.ScreenH / 2 - 152, 1, 256)
		if c > 1 then
			lib.PicLoadCache(54, 71 * 2, CC.ScreenW/2 - 210, CC.ScreenH / 2 - 40, 1, 256)
		end
		if c < maxc[t] then
			lib.PicLoadCache(54, 72 * 2, CC.ScreenW/2 + 110, CC.ScreenH / 2 - 40, 1, 256)
		end
		if t ~= 1 then
			lib.PicLoadCache(54, 73 * 2, CC.ScreenW/2 - 15, CC.ScreenH / 2 - 240, 1, 256)
		else
			lib.PicLoadCache(54, 74 * 2, CC.ScreenW/2 - 15, CC.ScreenH / 2+120, 1, 256)
		end
		tb2("上/下键切换标准主角/特殊主角  左/右键选择主角  满意后按空格键确认", -1, 670, C_ORANGE)
		ShowScreen()
		local p = WaitKey()
		if p == VK_SPACE or p == VK_RETURN then
			if not disable(t, c) then
				return t, c
			end
		elseif p == VK_ESCAPE then
			--break
		elseif p == VK_UP then
			if t ~= 1 then
				c = 1
			end
			t = 1		
		elseif p == VK_DOWN then
			if t ~= 2 then
				c = 1
			end	
			t = 2
		elseif p == VK_LEFT then
			c = limitX(c - 1, 1, maxc[t])
		elseif p == VK_RIGHT then
			c = limitX(c + 1, 1, maxc[t])
		end
	end
	
end

function gettitle(pid)
	local title = ""
	local name = JY.Person[pid]["姓名"]
	if pid == 77 and GetS(99,0,1,0) > 0 then 
	   name = "萧中慧1"
	end  
	if pid == 0 then
		if zjtype() == 1 then
			title = ZJTF[putong()]
		elseif zjtype() == 2 then
			title = ZJTF2[teshu()]
		elseif zjtype() == 3 then
			title = gettitle(GetS(103, 0, 0, 1))
		elseif zjtype() == 4 then
			title = JY.Person[578]["姓名"]
		end
	elseif pid == 92 and name ~= "郭襄" and name ~= "陆无双" and name ~= "苗若兰" and name ~= "森九岚" and name ~= "唐萌浅" then --武骧金星：增加特殊山洞女主
		title = "悠悠我心"
	else
		if CC.NLJS[name] ~= nil and CC.NLJS[name][1] ~= nil then		
			title = string.sub(CC.NLJS[name][1], 7)
		end
	end
	return title
end


function jiadian(a) --积分系统
	JY.Base["点数"] = limitX(JY.Base["点数"] + a, 0, 32000)
	if a < 0 then
		return "积分点数减少"..math.abs(a).."点"
	else
		return "积分点数增加"..a.."点"
	end
end

function skpoint(a)
	CC.SKpoint = limitX(CC.SKpoint + a, 0, 32000)
	if a < 0 then
		return "技能点减少"..math.abs(a).."点"
	else
		return "技能点增加"..a.."点"
	end	
end

function hasSK(sk)
	--[[if CC.SKlist[sk][3] == 1 then
		return true
	end]]
	--if hasTF(zj(), sk) then return true end
	return false
end

function setSK(sk, n)
	if n == nil then n = 1 end
	CC.SKlist[sk][3] = n
end

function setDZ(dz, n)
	if n == nil then n = 1 end
	CC.DZlist[dz][3] = n
end

function hasTF(pid, tf)
	if JY.Status == GAME_WMAP then
		if WAR.NOTF ~= nil then
			if pid == 0 and putong() == 10 and tf == WAR.NOTF[2] then
				return true
			end
			if WAR.NOTF[1] == pid and WAR.NOTF[2] == tf and WAR.NOTF[3] > 0 then
				return false
			end
		end
	end
	if pid == zj() and zjtype() == 4 then
		if tf <= #CC.SKlist and CC.SKlist[tf][3] == 1 then
			return true
		end
	end
	for i = 1, 5 do
		if JY.Person[pid]["技能"..i] == tf then
			return true
		end
	end
	if getHZ2(pid, tf) then
		return true
	end
	if DT(pid, 455) then return true end --武骧金星：无酒不欢判定
	if WAR.ZDDH == 226 and GetS(86, 1, 9, 5) == 1 and GetS(86, 2, 12, 5) == 3 and (pid == 5 or pid == 27 or pid == 50 or pid == 114) 
	and (tf == 48 or tf == 53 or tf == 93 or tf == 17 or tf == 127 or tf == 7 or tf == 31 or tf == 47 or tf == 137 or tf == 115 or tf == 29) then --四神封绝
	return true
	end
	return false
end

function hasDZ(pid, dz)
	if pid == zj() and zjtype() == 4 then
		if dz <= #CC.DZlist and CC.DZlist[dz][3] == 1 then
			return true
		end
	end
end

function setTF(pid, tf, n)
	if not hasTF(pid, tf) then
		if n ~= nil then
			JY.Person[pid]["技能"..n] = tf
		else
			for i = 1, 5 do
				if JY.Person[pid]["技能"..i] == 0 then
					JY.Person[pid]["技能"..i] = tf
					break
				end
			end
		end
	end
end


function sidetoside(menu, flag)	--1 异常状态 2 学技能 3 畅想
	local size = CC.DefaultFont - 5
	local start = 1
	local stop = 20
	local stop2 = 20
	local menu2 = {}
	if flag == 1 then
		local tmpmenu = {}
		for i = 1, #menu do
			tmpmenu[i] = {}
			menu2[i] = {}
			for j = 1, #menu[i] - 1 do				
				tmpmenu[i][j] = menu[i][j]
			end
			menu2[i] = menu[i][#menu[i]]
		end
		menu = tmpmenu
	end	
	if #menu < stop2 then stop2 = #menu end
	local current = 1	
	local size1 = size - 5
	local h = size + CC.PersonStateRowPixel
	local height = h * stop2 + 10
	if flag==3 then 
	height = h * 20 + 10 
	end
	local width = 5 * size + 10
	local x0 = 10
	local y0 = 5
	local i = 0
	local p
	while true do
		i = 0
		Cls()
		if flag == 3 or flag == 2 then
			lib.LoadPicture(CONFIG.PicturePath.."scroll.png", -1, -1)  
		elseif flag ~= 2 then
			lib.LoadPicture(CC.STA, -1, -1)  
		end
		DrawBox(x0, y0, x0 + width, y0 + height, C_WHITE)
		
		for j = start, stop do
			if menu[j] ~= nil and menu[j][1] ~= nil then				
				if current == j then
					DrawString(x0 + 5, y0 + h * (i) + 5, menu[j][1], C_WHITE, size)
				else
					if flag == 2 and menu[j][0] == 0 then
						DrawString(x0 + 5, y0 + h * (i) + 5, menu[j][1], M_DimGray, size)
					elseif flag == 3 then
						if CC.SKpoint >= 700 + 300 * (JY.Person[menu[j][0]]["排行"] - 2) then
							DrawString(x0 + 5, y0 + h * (i) + 5, menu[j][1], C_GOLD, size)
						else
							DrawString(x0 + 5, y0 + h * (i) + 5, menu[j][1], M_DimGray, size)
						end
					else
						DrawString(x0 + 5, y0 + h * (i) + 5, menu[j][1], C_GOLD, size)
					end
				end
				i = i + 1
			end
		end
		if flag == 3 then
			DrawBox(x0 + x0 + width, y0, CC.ScreenW - 10, y0 + height, C_WHITE)
		else
			DrawBox(x0 + x0 + width, y0, CC.ScreenW - 10,  #menu[current] * h + y0 + 10, C_WHITE)
		end
		for j = 1, #menu[current] do
			if menu[current][j] ~= nil then
				if j == 1 then
					DrawString(x0 + 15 + width, y0 + h * (j - 1) + 5, menu[current][j], C_ORANGE, size)
					if flag == 1 then
						lib.PicLoadFile(CC.WMAPPicFile[1], CC.WMAPPicFile[2], 11)
						lib.PicLoadCache(11,menu2[current]*2,x0 + 15 + width + size * 3, y0 + h * (j - 1) + 5 + 13, 0, 256);	
					end
					if flag == 3 then
						lib.PicLoadCache(55, gethead(menu[current][0]) * 2, CC.ScreenW - 10 - 442, y0 + height - 398, 1)
					end
				else
					DrawString(x0 + 15 + width, y0 + h * (j - 1) + 5, menu[current][j], M_Wheat, size)
				end
			end
		end
		
		ShowScreen()
		p = WaitKey()
		if p == VK_ESCAPE then
			if flag ~= 3 then
				return -1
			else
				local plist = cxlist()
				return sidetoside(plist, 3)
			end
		elseif p == VK_SPACE or p == VK_RETURN then
			if flag == 3 then
				if CC.SKpoint >= 700 + 300 * (JY.Person[menu[current][0]]["排行"] - 2) then
					return menu[current][0]
				end
			elseif flag == 2 and (menu[current][0] ~= nil and menu[current][0] == 0) then
			else
				return current
			end
		elseif p == VK_DOWN then
			if current == #menu then
				current = 1
				start = 1
				stop = 20
			else
				current = limitX(current + 1, 1, #menu)
				if current > stop then
					start = limitX(start + 1, 1, #menu)
					stop = limitX(stop + 1, stop2, #menu)
				end
			end
		elseif p == VK_UP then
			if current == 1 then
				current = #menu
				stop = #menu
				start = stop - 19
			else
				current = limitX(current - 1, 1, #menu)
				if current < start then
					start = limitX(start - 1, 1, #menu)
					stop = limitX(stop - 1, stop2, #menu)
				end	
			end
		elseif p == VK_LEFT then
			current = current - 20
			start = start - 20
			stop = stop - 20
			if start < 1 then
				current = 1
				start = 1
				stop = 20
			end
		elseif p == VK_RIGHT then
			current = current + 20
			start = start + 20
			stop = stop + 20			
			if stop > #menu then
				current = #menu
				stop = #menu
				start = stop - 19
			end			
		end
	end
end

function JYZTB() --游戏显示
  local mode = 0
  if JY.Thing[202][WZ7] == 1 then
    mode = "易"
  elseif JY.Thing[202][WZ7] == 2 then
    mode = "普"
  else
    mode = "难"
  end
  
  local day = {
	{1, "初一"},
	{2, "初二"},
	{3, "初三"},
	{4, "初四"},
	{5, "初五"},
	{6, "初六"},
	{7, "初七"},
	{8, "初八"},
	{9, "初九"},
	{10, "初十"},
	{11, "十一"},
	{12, "十二"},
	{13, "十三"},
	{14, "十四"},
	{15, "十五"},
	{16, "十六"},
	{17, "十七"},
	{18, "十八"},
	{19, "十九"},
	{20, "廿十"},
	{21, "廿一"},
	{22, "廿二"},
	{23, "廿三"},
	{24, "廿四"},
	{25, "廿五"},
	{26, "廿六"},
	{27, "廿七"},
	{28, "廿八"},
	{29, "廿九"},
	{30, "三十"},  
  }
  
  local month = {
	--[[{1, "寅月"},
	{2, "卯月"},
	{3, "辰月"},
	{4, "巳月"},
	{5, "午月"},
	{6, "未月"},
	{7, "申月"},
	{8, "酉月"},
	{9, "戌月"},
	{10, "亥月"},
	{11, "子月"},
	{12, "丑月"}, ]]
	{1, "一月"},
	{2, "二月"},
	{3, "三月"},
	{4, "四月"},
	{5, "五月"},
	{6, "六月"},
	{7, "七月"},
	{8, "八月"},
	{9, "九月"},
	{10, "十月"},
	{11, "十一月"},
	{12, "十二月"}, 	
  }
  
  local year = {
	{1, "甲子"},
	{2, "乙丑"},
	{3, "丙寅"},
	{4, "丁卯"},
	{5, "戊辰"},
	{6, "己巳"},
	{7, "庚午"},
	{8, "辛未"},
	{9, "壬申"},
	{10, "癸酉"},
	{11, "甲戌"},
	{12, "乙亥"},
	{13, "丙子"},
	{14, "丁丑"},
	{15, "戊寅"},
	{16, "己卯"},
	{17, "庚辰"},
	{18, "辛己"},
	{19, "壬午"},
	{20, "癸未"},
	{21, "甲申"},
	{22, "乙酉"},
	{23, "丙戌"},
	{24, "丁亥"},
	{25, "戊子"},
	{26, "己丑"},
	{27, "庚寅"},
	{28, "辛卯"},
	{29, "壬辰"},
	{30, "癸巳"},
	{31, "甲午"},
	{32, "乙未"},
	{33, "丙申"},
	{34, "丁酉"},
	{35, "戊戌"},
	{36, "己亥"},
	{37, "庚子"},
	{38, "辛丑"},
	{39, "壬寅"},
	{40, "癸丑"},
	{41, "甲辰"},
	{42, "乙巳"},
	{43, "丙午"},
	{44, "丁未"},
	{45, "戊申"},
	{46, "己酉"},
	{47, "庚戌"},
	{48, "辛亥"},
	{49, "壬子"},
	{50, "癸丑"},
	{51, "甲寅"},
	{52, "乙卯"},
	{53, "丙辰"},
	{54, "丁巳"},
	{55, "戊午"},
	{56, "己未"},
	{57, "庚申"},
	{58, "辛酉"},
	{59, "壬戌"},
	{60, "癸亥"},
  }
	if JY.RANDOM == 0 and JY.Status == GAME_MMAP then --随机事件
		local str = "【"..JY.MONTH.."·"..JY.DAY.."】今日无大事发生"
		if CC.SuiName ~= "" then
			str = "【"..JY.MONTH.."·"..JY.DAY.."】".. CC.SuiName.." "..CC.SuiThing.." "..CC.SuiResult 
		end
		lib.Background(0, CC.ScreenH - 20, CC.ScreenW, CC.ScreenH, 128)

		if CC.SuiType == 0 then
			DrawString(10, CC.ScreenH - 20, str, C_WHITE, 20)
		elseif CC.SuiType == 1 then
			DrawString(10, CC.ScreenH - 20, str, C_GOLD, 20)
		end  
	end
  local t = math.modf((lib.GetTime() - JY.LOADTIME) / 60000 + GetS(14, 2, 1, 4))
  --[[local t1, t2 = 0, 0
  while t >= 60 do
    t = t - 60
    t1 = t1 + 1
  end
  t2 = t]]
--[[
  local dd, mm, yy = 1, 1, 1
  while t >= 360 do
	t = t - 360
	yy = yy + 1
  end

  while t >= 30 do
	t = t - 30
	mm = mm + 1
  end 
  dd = dd + t]]
	if JY.Thing[203][WZ6] < 1 then JY.Thing[203][WZ6] = 1 end
  
  DrawBox(10, 10, 225, 130, C_GOLD)
  DrawString(15, 15, string.format("周目%d 难%d 天书:%d", JY.Thing[203][WZ6], JY.Thing[202][WZ7], tianshu()), M_Orange, 20) --武骧金星：修正
  DrawString(15, 40, string.format(CC.s54, JY.Person[0]["品德"], JY.GOLD), M_Orange, 20)
  if JY.WGLVXS == 1 then
    --DrawString(15, 40, string.format(CC.s55, t1, t2) .. mode, C_GOLD, 20)
	--DrawString(15, 40, year[JY.YEAR][2].."年 "..month[JY.MONTH][2].." "..day[JY.DAY][2], M_Orange, 20)
	DrawString(15, 65, "第"..year[JY.YEAR][1].."年 "..month[JY.MONTH][2].." "..day[JY.DAY][2], M_Orange, 20)
  else
    --DrawString(15, 40, string.format(CC.s55, t1, t2), C_GOLD, 20)
	DrawString(15, 65, "第"..year[JY.YEAR][1].."年 "..month[JY.MONTH][2].." "..day[JY.DAY][2], M_Orange, 20)
  end
  DrawString(16, 90, "体", M_Orange, 15)
  DrawString(16, 105, "力", M_Orange, 15)
	lib.SetClip(35, 92, 35 + math.modf(JY.TL/100 * 160), 92 + 75)
	lib.PicLoadCache(0, 498 * 2, 35, 92 + 75, 1)
	lib.PicLoadCache(0, 499 * 2, 35, 92, 1)  	
end


function NLJS(id, page) --能力说明 
	local size = CC.DefaultFont
	local size1 = 24
	local p = JY.Person[id]
	local p0 = JY.Person[0]
	local width = 18 * size + 15
	local h = size + CC.PersonStateRowPixel
	local h1 = size1 + CC.PersonStateRowPixel
	local height = 13 * h + 10
	local dx = (CC.ScreenW - width) / 2
	local dy = (CC.ScreenH - height) / 2
	dx = 0
	dy = 0
	local x1, y1 = nil, nil
	local start = 1
	local over = 14 
	local gap = 3
	local gap2 = 14
	local name = p["姓名"]
	local hid = gethead(id)
	--if id > JY.PersonNum then return 1 end
	if zjtype() == 1 and id == 0 then
		name = tostring(putong())
	end	
	if id == 77 and GetS(99,0,1,0) > 0 then 
	   name = "萧中慧1"
	end   
	if id == 92 and name ~= "郭襄" and name ~= "陆无双" and name ~= "苗若兰" and name ~= "森九岚" and name ~= "唐萌浅" then name = "92" end --武骧金星：增加特殊山洞女主
	x1 = dx + 5 + size
	y1 = dy + 5
	--快捷键ESC返回属性界面\上下换行\左右分页
	local realname = p["姓名"]
	local NLJS = {}
	NLJS[name] = {}
	if CC.NLJS[name] ~= nil and string.sub(CC.NLJS[name][1], 7) ~= "" then --普通能力解说
		for i = 1, #CC.NLJS[name] do
			NLJS[name][i] = CC.NLJS[name][i]
			if i == #CC.NLJS[name] then
				NLJS[name][#NLJS[name] + 1] = ""
			end
		end
	end
	if duiyou(id) and CC.NLJS[name] ~= nil and CC.NLJS2[name] ~= nil then --觉醒能力解说
		NLJS[name][#NLJS[name]] = nil
		if JX(id) then
			local lc = #NLJS[name]
			for i = 1, #CC.NLJS2[name] do
				NLJS[name][lc + i] = CC.NLJS2[name][i]
				if i == #CC.NLJS2[name] then
					NLJS[name][#NLJS[name] + 1] = ""
				end
			end
		else
			local lc = #NLJS[name]
			for i = 1, #CC.NLJS2[name] do
				local length = string.len(CC.NLJS2[name][i])
				NLJS[name][lc + i] = ""
				for ll = 1, math.modf(length / 2) do
					NLJS[name][lc + i] = NLJS[name][lc + i].."？"			
				end		
				if i == #CC.NLJS2[name] then
					NLJS[name][#NLJS[name] + 1] = ""
				end						
			end
		end
	end
	if JY.Thing[202][WZ7] >= 5 and (JY.Person[id]["无用12"] or 0) > 0 and (not duiyou(id)) and (#CC.NLJS[JY.Person[JY.Person[id]["无用12"]]["姓名"]] or 0) > 1 then
		NLJS[name][#NLJS[name] + 1] = "（"..CC.NLJS[JY.Person[JY.Person[id]["无用12"]]["姓名"]][2].."）"
	end
	if id > 0 or (id == 0 and zjtype() == 3) or (id == 0 and T10XXZ(id)) then
		for i = 1, 5 do
			if JY.Person[id]["技能"..i] > 0 then
				local ss = JY.Person[id]["技能"..i]			
				if i == 1 and JY.Person[id]["技能"..i + 1] <= 0 then
					NLJS[name][#NLJS[name] + 1] = "天赋".."："..CC.TFlist[ss][1]
				else
					NLJS[name][#NLJS[name] + 1] = "天赋"..CC.NUM[i].."："..CC.TFlist[ss][1]
				end
				NLJS[name][#NLJS[name] + 1]  = CC.TFlist[ss][2]
				NLJS[name][#NLJS[name] + 1] = ""
			end
		end
	end

	local title = gettitle(id)
	if title ~= "" then
		title = "【"..title.."】"
	else
		title = "【※】"
	end	
	if NLJS[name][#NLJS[name]] == "" then NLJS[name][#NLJS[name]] = nil end
	while true do
		Cls()
		--lib.LoadPicture(CONFIG.PicturePath .. "bk6.png", 0, 0)
		--lib.LoadPicture(CONFIG.PicturePath .. "bt0.png", 0, CC.ScreenH-34)
		lib.PicLoadFile(CC.ThingPicFile[1], CC.ThingPicFile[2], 93)
		lib.PicLoadCache(93, 6, 500, 300)
		DrawBox(dx, dy, CC.ScreenW, CC.ScreenH, C_WHITE)
		--[[lib.PicLoadCache(55, hid * 2, CC.ScreenW - dx - 441, CC.ScreenH - dy - 397, 1)
		lib.PicLoadCache(55, 0, CC.ScreenW - dx - 330, CC.ScreenH - dy - 147, 1)
		MyDrawString(CC.ScreenW - dx - 260, CC.ScreenW, CC.ScreenH - dy - 77, realname, C_WHITE, 30) 
		MyDrawString(CC.ScreenW - dx - 260, CC.ScreenW, CC.ScreenH - dy - 47, title, C_GOLD, 30) ]]
		DrawString(x1, y1, realname.."能力解说", C_ORANGE, size - 3)
		DrawString(x1 + size * 5, y1 + h + h * 15 , "上下键浏览，左右键切换，ESC退出", C_ORANGE, size - 3)	
		if id == 0 then
			if zjtype() == 1 then
				name = tostring(putong())
			elseif zjtype() == 3 then
				name = JY.Person[cxzj()]["姓名"]
			elseif zjtype() == 4 then
				name = "自创"
				NLJS[name] = {"称号："..JY.Person[578]["姓名"], "", "技能："}
				local cc = 4
				for i = 1, #CC.SKlist do
					if hasTF(zj(), i) then				
						NLJS[name][cc] = CC.SKlist[i][1].."："..CC.SKlist[i][2]
						cc = cc + 1
					end
				end
				for i = 1, #CC.DZlist do
					if hasDZ(zj(), i) then				
						NLJS[name][cc] = CC.DZlist[i][1].."："..CC.DZlist[i][2]
						cc = cc + 1
					end
				end
			end
		end

		local j = 0
		DrawString(x1, y1 + h + h1 * j + 10, "印信：", M_Wheat, size1)
		local function tmp(aa)
			if aa ~= 0 then
				return true
			else
				return false
			end
		end
		local m = limitX(2 + math.modf(JY.Person[id]["实战"] / 250), 2, 4) --m = limitX(m + math.modf(JY.Person[id]["实战"] / 250), 0, 4) 
		if MPPD(id) ~= 0 then 
			m = 2
		end		
		for i = 1, m do
			local chk = JY.Person[id]["HZ"..i]
			if tmp(chk) then
				DrawString(x1 + size1 * (3 * (math.modf(i / 3) * 2 + 1)), y1 + h + h1 * j + 10 + h1 - (h1 * math.fmod(i, 2)), CC.HZ[chk][2], M_Wheat, size1)
			else
				DrawString(x1 + size1 * (3 * (math.modf(i / 3) * 2 + 1)), y1 + h + h1 * j + 10 + h1 - (h1 * math.fmod(i, 2)), "－－－－", M_Wheat, size1)
			end	
		end
		
		if NLJS[name] ~= nil then
			breakdown(NLJS[name], 62)
			local i = gap
			if start > 1 then
				DrawString(x1 - size1 - 3, y1 + h + h1 * i, "↑", C_ORANGE, size1)
			end
			if over < #NLJS[name] then
				DrawString(x1 - size1 - 3, y1 + h + h1 * 17, "↓", C_ORANGE, size1)
			end
			if #NLJS[name] <= gap2 then
				for j = 1, #NLJS[name] do
					local tt = string.sub(NLJS[name][j], 1, 4)
					if tt == "天赋" or tt == "称号" or tt == "指令" or tt == "技能" 
						or tt == "觉醒" then
						DrawString(x1, y1 + h + h1 * i + 10, NLJS[name][j], C_GOLD, size1)	
					else
						DrawString(x1, y1 + h + h1 * i + 10, NLJS[name][j], C_WHITE, size1)	
					end
					i = i + 1					
				end		
			else
				for j = start, over do
					local tt = string.sub(NLJS[name][j], 1, 4)
					if tt == "天赋" or tt == "称号" or tt == "指令" or tt == "技能" 
						or tt == "觉醒" then
						DrawString(x1, y1 + h + h1 * i + 10, NLJS[name][j], C_GOLD, size1)	
					else
						DrawString(x1, y1 + h + h1 * i + 10, NLJS[name][j], C_WHITE, size1)	
					end
					i = i + 1	
				end
			end
		end	
		ShowScreen()
		local keypress = WaitKey()
		lib.Delay(100)
		if keypress == VK_SPACE or keypress > 1999999 then
		
		elseif keypress == VK_ESCAPE then
			return -1
		elseif NLJS[name] ~= nil and keypress == VK_UP then
			if start > 1 then
				start = start - 1
				over = over - 1
			end
		elseif NLJS[name] ~= nil and keypress == VK_DOWN then
			if over < #NLJS[name] then
				start = start + 1
				over = over + 1
			end
		elseif keypress == VK_LEFT then
			break
		elseif keypress == VK_RIGHT then
			
		end
	end
	return 1
end

------------------------------------------

function cheat()
	if CONFIG.Cheat == "给我食物其余免谈" then
		return true
	else
		return false
	end
end


function pickhead()
	local sx = 60
	local sy = 60
	--local bg = CONFIG.PicturePath .. "game.jpg"
	local tmp = {} --x, y, num
	local current = 1
	local count = 0
	local count2 = 0
	local count3 = 0
	local dx, dy = 1, 1
	local start = 1
	local stop = 56
	local result = -1
	local maxhead = 589
	local x0 = 50
	local y0 = CC.ScreenH/2 - (sy/2 + 10) * 5
	local headfile = {CONFIG.DataPath .. "shead.idx", CONFIG.DataPath .. "shead.grp"}
	--lib.PicLoadFile(headfile[1], headfile[2], 1)		
	local list = {}
	for i = 1, maxhead do 
		list[#list + 1] = i
	end	
	maxhead = #list
	for i = 1, maxhead do		
		tmp[i] = {x0, y0, i - 1}
		count = count + 1
		count2 = count2 + 1
		x0 = x0 + 62
		if count >= 7 then
			count = 0
			x0 = 50
			y0 = y0 + 62
		end
		if count2 >= 56 then
			count2 = 0
			y0 = CC.ScreenH/2 - (sy/2 + 10) * 5	
		end
	end		
	while true do	
		Cls()
		lib.LoadPicture(CC.STA, -1, -1)
		DrawStrBox(-1, 10, "请选择头像", C_GOLD, 30)	
		local count3 = 1
		current = start + 7 * (dy - 1) + dx - 1
		--tb2("dx"..dx.." dy"..dy.." c"..current, 0, 0, C_GOLD, 20)
		for i = start, stop do	
			if tmp[count3] ~= nil and list[i] ~= nil then
				DrawBox(tmp[count3][1] - 31, tmp[count3][2] - 31, tmp[count3][1] + 31,  tmp[count3][2] + 31, C_WHITE)	
				lib.PicLoadCache(1, list[i] * 2, tmp[count3][1], tmp[count3][2])	
			end			
			if i == current then
				DrawBox(tmp[count3][1] - 31, tmp[count3][2] - 31, tmp[count3][1] + 31,  tmp[count3][2] + 31, C_RED)	
			end
			count3 = count3 + 1
		end
		if current <= maxhead then
			lib.PicLoadCache(55, current * 2, CC.ScreenW - 440, CC.ScreenH - 396, 1)
		end
		ShowScreen()
		local p = WaitKey()

		if (p == VK_SPACE or p == VK_RETURN) and list[current] ~= nil then
			result = list[current]
			break
		elseif p == VK_UP then
			current = limitX(current - 7, 1, maxhead)
			dy = limitX(dy - 1, 1, 8)
			if current < start then
				start = limitX(start - 7, 1, maxhead)
				stop = limitX(stop - 7, 56, maxhead)
			end
		elseif p == VK_DOWN then
			current = limitX(current + 7, 1, maxhead)
			dy = limitX(dy + 1, 1, 8)
			if current > stop then
				start = limitX(start + 7, 1, maxhead)
				stop = limitX(stop + 7, 1, maxhead)
				if stop == maxhead then
					if math.fmod(math.fmod(maxhead, 56), 7) ~= 0 then
						stop = stop + 7 - math.fmod(math.fmod(maxhead, 56), 7)
					end
				end
			end
		elseif p == VK_LEFT then
			current = limitX(current - 1, 1, maxhead)
			if start == 1 and dy == 1 and dx == 1 then
			else
				dx = dx - 1
			end
			if dx < 1 then
				dy = limitX(dy - 1, 1, 8)
				dx = 7
			end
			if current < start then
				start = limitX(start - 7, 1, maxhead)
				stop = limitX(stop - 7, 56, maxhead)
			end
		elseif p == VK_RIGHT then
			current = limitX(current + 1, 1, maxhead)
			local tt = math.fmod(maxhead, 56)
			if stop == maxhead and dy == 8 and dx == tt then			
			else
				dx = dx + 1
			end
			if dx > 7 then
				dy = limitX(dy + 1, 1, 8)
				dx = 1
			end			
			if current > stop then
				start = limitX(start + 7, 1, maxhead)
				stop = limitX(stop + 7, 1, maxhead)
			end
		end		
	end
		
	return result
end


function calbody(id)
  local n = 2554*2
  n = n + JY.Person[id]["头像代号"] * 8 
  if JY.Person[id]["头像代号"] >= 314 then
	n = 4402 * 2 + (JY.Person[id]["头像代号"] - 314) * 8 
  end
  if JY.Person[id]["头像代号"] >= 340 then
	n = 4511 * 2 + (JY.Person[id]["头像代号"] - 340) * 8 
  end 
  if JY.Person[id]["头像代号"] >= 342 then
    n = 4519 * 2 + (JY.Person[id]["头像代号"] - 342) * 8
  end
  return n
end

function pickbody()
	local sx = 65
	local sy = 65
	--local bg = CONFIG.PicturePath .. "game.jpg"
	local tmp = {} --x, y, num
	local current = 1
	local count = 0
	local count2 = 0
	local count3 = 0
	local dx, dy = 1, 1
	local start = 1
	local stop = 70
	local result = -1
	local list = {}
	for i = 0, JY.PersonNum - 1 do 
		local dup = false
		for j = 1, #list do
			if list[j] ~= nil then
				if list[j][2] == calbody(i) then
					dup = true
					break
				end
			end
		end
		if not dup and i ~= 579 then
			list[#list + 1] = {i, calbody(i)}
		end
	end
	local maxhead = #list
	local x0 = CC.ScreenW/2 - (sx/2 + 10) * 8
	local y0 = CC.ScreenH/2 - (sy/2 + 10) * 5	
	for i = 1, maxhead do		
		tmp[i] = {x0, y0, i - 1}
		count = count + 1
		count2 = count2 + 1
		x0 = x0 + 75
		if count >= 10 then
			count = 0
			x0 = CC.ScreenW/2 - (sx/2 + 10) * 8
			y0 = y0 + 75
		end
		if count2 >= 70 then
			count2 = 0
			y0 = CC.ScreenH/2 - (sy/2 + 10) * 5	
		end
	end	
	lib.PicLoadFile(CC.WMAPPicFile[1], CC.WMAPPicFile[2], 12)
	lib.PicLoadFile(CC.WMAPPicFile[1], CC.WMAPPicFile[2], 13, 50)	
	while true do	
		Cls()
		lib.LoadPicture(CC.STA, -1, -1)
		DrawStrBox(-1, 10, "请选择战斗造型", C_GOLD, 25)	
		local count3 = 1
		current = start + 10 * (dy - 1) + dx - 1
		for i = start, stop do	
			if tmp[count3] ~= nil and list[i] ~= nil then
				local w1, h1, x1_off, y1_off = lib.PicGetXY(12, list[i][2]) 
				local x0, y0
				if CONFIG.Zoom == 1 then
					x1_off = x1_off / 2
					x1_off = x1_off - 32 
					y1_off = y1_off / 2
					y1_off = y1_off - 62 
					x0 = tmp[count3][1] - x1_off - 40
					y0 = tmp[count3][2] - y1_off - 35		
				else
					x0 = tmp[count3][1]
					y0 = tmp[count3][2] + 25
				end
				--DrawStrBox(tmp[count3][1] - 40, tmp[count3][2] - 40, ""..i, C_GOLD, 25)
				DrawBox(tmp[count3][1] - 40, tmp[count3][2] - 40, tmp[count3][1] + 35,  tmp[count3][2] + 35, C_WHITE)	
				lib.PicLoadCache(12 + CONFIG.Zoom, list[i][2], x0, y0, 2, 256)	
			end			
			if i == current then
				--DrawStrBox(tmp[count3][1] - 40, tmp[count3][2] - 40, ""..current.."::"..start.."::"..stop, C_GOLD, 25)
				DrawBox(tmp[count3][1] - 40, tmp[count3][2] - 40, tmp[count3][1] + 35,  tmp[count3][2] + 35, C_RED)	
			end
			count3 = count3 + 1
		end
		ShowScreen()
		local p = WaitKey()

		if (p == VK_SPACE or p == VK_RETURN) and list[current] ~= nil then
			result = list[current][1]
			break
		elseif p == VK_UP then
			current = limitX(current - 10, 1, maxhead)
			dy = limitX(dy - 1, 1, 7)
			if current < start then
				start = limitX(start - 10, 1, maxhead)
				stop = limitX(stop - 10, 70, maxhead)
			end
		elseif p == VK_DOWN then
			current = limitX(current + 10, 1, maxhead)
			dy = limitX(dy + 1, 1, 7)
			if current > stop then
				start = limitX(start + 10, 1, maxhead)
				stop = limitX(stop + 10, 1, maxhead)
				if stop == maxhead then
					if math.fmod(math.fmod(maxhead, 70), 10) ~= 0 then
						stop = stop + 10 - math.fmod(math.fmod(maxhead, 70), 10)
					end
				end
			end
		elseif p == VK_LEFT then
			current = limitX(current - 1, 1, maxhead)
			if start == 1 and dy == 1 and dx == 1 then
			else
				dx = dx - 1
			end
			if dx < 1 then
				dy = limitX(dy - 1, 1, 7)
				dx = 10
			end
			if current < start then
				start = limitX(start - 10, 1, maxhead)
				stop = limitX(stop - 10, 70, maxhead)
			end
		elseif p == VK_RIGHT then
			current = limitX(current + 1, 1, maxhead)
			local tt = math.fmod(maxhead, 70)
			if stop == maxhead and dy == 7 and dx == tt then			
			else
				dx = dx + 1
			end
			if dx > 10 then
				dy = limitX(dy + 1, 1, 7)
				dx = 1
			end			
			if current > stop then
				start = limitX(start + 10, 1, maxhead)
				stop = limitX(stop + 10, 1, maxhead)
			end
		end		
	end
	lib.PicLoadFile(CC.HeadPicFile[1], CC.HeadPicFile[2], 1)	
	return result
end

function learnSK()
	local num = 0
	local nummax = 4 + JY.Thing[203][WZ6]
	local m = {
		{"学习技能", nil, 1},
		{"开始旅程", nil, 1},
	}
	local menu = {}
	for i = 1, #CC.SK do
		menu[i] = {}
		menu[i][1] = CC.SK[i][1]
		menu[i][2] = CC.SK[i][2]
		breakdown(menu[i], 50)
		menu[i][#menu[i] + 1] = "需要"..CC.SK[i][3].."点".."，还剩"..CC.SKpoint.."个技能点"
		menu[i][0] = 1

		if hasTF(zj(), i) then
			menu[i][0] = 0
		end
	end
	
	while true do
		Cls()
		local r = ShowMenu3(m,#m,1,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,"已学"..num.."个技能", nil,M_DimGray,C_RED)
		if r == 2 then
			break
		end
		if r == 1 and num >= nummax then
			tb("已超过所能学的最大技能数")
			break
		end
		local s = sidetoside(menu, 2)
		if s > 0 then
			if CC.SKpoint < CC.SK[s][3] then
				tb("技能点数不足！")
			else
				CC.SKpoint = CC.SKpoint - CC.SK[s][3]
				menu[s][0] = 0
				setSK(s, 1)
				num = num + 1
				for i = 1, #CC.SK do
					menu[i][3] = "需要"..CC.SK[i][3].."点".."，还剩"..CC.SKpoint.."个技能点"
				end
			end
		end
	end
end

function learnDZ()
	local num = 0
	local nummax = 3
	local m = {
		{"学习技能", nil, 1},
		{"开始旅程", nil, 1},
	}
	local menu = {}
	for i = 1, #CC.DZ do
		menu[i] = {}
		menu[i][1] = CC.DZ[i][1]
		menu[i][2] = CC.DZ[i][2]
		breakdown(menu[i], 50)
		menu[i][#menu[i] + 1] = "需要"..CC.DZ[i][3].."点".."，还剩"..CC.SKpoint.."个技能点"
		menu[i][0] = 1

		if hasDZ(zj(), i) then
			menu[i][0] = 0
		end
	end
	
	while true do
		Cls()
		local r = ShowMenu3(m,#m,1,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,"已学"..num.."个战意组件", nil,M_DimGray,C_RED)
		if r == 2 then
			break
		end
		if r == 1 and num >= nummax then
			tb("已超过所能学的最大技能数")
			break
		end
		local s = sidetoside(menu, 2)
		if s > 0 then
			if CC.SKpoint < CC.DZ[s][3] then
				tb("技能点数不足！")
			else
				CC.SKpoint = CC.SKpoint - CC.DZ[s][3]
				menu[s][0] = 0
				setDZ(s, 1)
				num = num + 1
				for i = 1, #CC.DZ do
					menu[i][3] = "需要"..CC.DZ[i][3].."点".."，还剩"..CC.SKpoint.."个技能点"
				end
			end
		end
	end
end

function setRW(n, flag)
	if flag ~= nil then
		SetS(103, 63, n, 0, flag)
	else
		if GetS(103, 63, n, 0) ~= 1 then
			return false
		else
			return true
		end
	end
end

function setteam(id, n)
	if n == nil then
		n = 1
	end
	JY.Person[id]["YES"] = n
end

function hasteam(id)
	if JY.Person[id]["YES"] == 1 then
		return true
	else
		return false
	end
end

function DIYglobal()
	JY.nglist = {6,89,90,92,93,94,95,96,97,98,99,121,124,150,151,152,153,178,185,186,187}
	JY.nglist2 = {100,101,102,103,104,105,106,107,108,180,181,182,183,184,188,189,203,204}
	JY.qglist = {115,116,117,118,119,143,179,190,191,192,193,194,195,196,197,198,199,200,205}
	CC.HZlist = {} --id, 拥有0/1，使用人id-1/id
	for i = 1, CC.HZNumMax do 
		CC.HZlist[i] = {i, 0, 0}
	end
	CC.SKlist = {} --0/1
	for i = 1, #CC.SK do
		CC.SKlist[i] = {CC.SK[i][1], CC.SK[i][2], 0}
	end
	CC.DZlist = {} --0/1
	for i = 1, #CC.DZ do
		CC.DZlist[i] = {CC.DZ[i][1], CC.DZ[i][2], 0}
	end
	--CC.SKpoint = 0
	BJ.fame = 0
	BJ.cash = 0
	BJ.bouncer = 0
	BJ.team = 0
	BJ.total = 0
	BJ.win = 0
	BJ.lose = 0  	
	RW = {}
	RW.event = -1
	RW.scene = -1
	RW.location = -1
	RW.targetscene = -1
	RW.target = -1
	RW.tmp = -1
	RW.current = -1	
	RW.type = -1
	RW.t1 = -1
	RW.n1 = -1
	RW.t2 = -1
	RW.n2 = -1
	RW.t3 = -1
	RW.n3 = -1
	RW.t4 = -1
	RW.n4 = -1
	RW.t5 = -1
	RW.n5 = -1	
	RW.fame = 0
	RW.list = {
	[1] = {0, 1, 7, 10, 3, 5},
	[3] = {1, 9, 10, 11, 2, 3, 6, 8, 0},
	[12] = {12, 10, 9, 11},
	[16] = {11, 12, 13, 17, 18, 14},
	[17] = {1, 2},
	[19] = {4, 5, 6},
	[26] = {12, 13, 14, 15, 16, 23, 24, 26, 25, 27, 7, 8, 9, 10, 11, 32, 33, 34, 35,28, 29, 30, 31, 18, 19, 20, 21},
	[27] = {2, 3, 51, 52},
	[28] = {8, 9, 10, 11, },
	[29] = {3, 4, 5, 6},
	[31] = {6},
	[35] = {4, 5, 6, 7, 8, 9, 10, 12, 13, 14},
	[37] = {0, 1, 2, 3, 4},
	[39] = {5, 6, 7, 8},
	[40] = {1, 13, 14, 15, 17, 18, 10, 12},
	[43] = {1, 2},
	[48] = {4, 5, 23, 24, 6, 7, 8, 9, 10, 11},
	--[51] = {6, 7, 8, 9, 10, 11, 12, 13},
	[58] = {1, 2, 12, 13},
	[60] = {1, 27, 28, 29, 4, 5, 7, 8, 9},
	[61] = {4, 0, 8, 17, 18, 19},
	[69] = {20, 21, 1, 2, 3, 4, 5, 6},
	[71] = {5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18},
	[76] = {7, 8, 9, 10},
	--[96] = {1, 2, 3, 4, 5, 6, 7, 8},
	[107] = {3, 4, 5, 6, 7, 8},
	[108] = {0, 1, 2, 3, 4, 5, 6, 7},
	--[] = {},
	}	
	RW.zb = {36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,58,59,60,61,62,63,230,236,243,244,245,246,247,248,249,250,253,255,256}
	RW.wg = {}
	RW.mp = {
		{"全真教", 19, 291, 300},
		{"日月神教", 26, 231, 240},
		{"嵩山派", 27, 191, 200},
		{"少林寺", 28, 461, 469}, --461-478, 479-496, 400-409
		{"泰山派", 29, 201, 210},
		{"恒山派", 31, 380, 389},
		{"峨嵋派", 33, 330, 339},
		{"崆峒派", 34, 350, 359},
		{"星宿派", 35, 261, 270},
		{"青城派", 36, 211, 220},
		{"五毒教", 37, 221, 230},
		{"雪山派", 39, 241, 250},
		{"武当派", 43, 320, 329},
		{"铁掌帮", 48, 281, 290},		
		{"丐帮", 51, 271, 280},
		{"华山派", 57, 360, 369},
		{"衡山派", 58, 370, 379},
		{"昆仑派", 68, 340, 349},
		{"神龙教", 71, 390, 399},
		--{"明教", 11, 301, 310},
	}
	--特别任务
	RW.special = {
		{101, 41, 39, 15},
		{102, 46, 18, 40}, 
		{104, 40, 22, 45}, 
		{104, 40, 24, 42}, 
		{106, 108, 11, 41},
		{107, 10, 22, 37},
		{107, 10, 22, 39},
		{108, 109, 24, 26},
		{108, 109, 22, 28},	
		{109, 107, 34, 12},	
		{109, 107, 36, 8},	
		{109, 107, 40, 8},			
	}
	RW.s = {
		{101, "寒冰？？？", "寒气的来源", "无", "无名山洞"},
		{102, "捕蛇人", "巨蛇", nil, "金蛇山洞"},
		{103, "射雕比赛", "胜利！", "无", "有间客栈"},
		{104, "乞丐与道姑", "？？？", "无", "洛阳"},
		{105, "蜀中唐门", "？？？", "？？？", "？？？"},
		{106, "恩怨难清", "？？？", "无", "玉笔山庄"},
		{107, "蛛儿与蛛儿", "？？？", "无", "沙漠山洞"},
		{108, "白猿与少女", "？？？", "无", "树林"},
		{109, "比武招亲", "？？？", "无", "襄阳"},
	}
	YC.BG = "home"
	YC.PET = {3, 2, 1, 1}
	CC.SuiType = 0
	CC.SuiName = ""
	CC.SuiThing = ""
	CC.SuiResult = ""
	YC.PLOT = {}
	for i = 1, 1000 do
		YC.PLOT[i] = {0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0} 
		--开始1年2月3日，关闭4年5月6日，7事件编号，8完成 - 0未激活1激活未完成2完成3错过，9地点，10显示, 11后续编号
	end
end

function saveConstant()
	--保存解锁进度
	local data=Byte.create(JY.PersonNum*2)
	Byte.set16(data,0,JY.Thing[203][WZ6])
	for i = 1, JY.PersonNum - 1 do
		Byte.set16(data,i*2,JY.Person[i]["解锁"])
	end
	Byte.savefile(data,'.\\data\\SAVE\\week.data',0,JY.PersonNum*2)
	--save skpoint
	local data = Byte.create(8)
	Byte.set32(data, 0, CC.SKpoint)	
	Byte.set32(data, 2, JY.Thing[203][WZ6])	
	Byte.savefile(data, CC.R_GRPFilename[0], 1652, 4)	
	
end

function loadConstant()
	--读取周目数据
	local data=Byte.create(JY.PersonNum*2)
	Byte.loadfile(data,'.\\data\\SAVE\\week.data',0,JY.PersonNum*2)
	JY.Thing[203][WZ6] = Byte.get16(data,0)
	if JY.Thing[203][WZ6] < 1 then JY.Thing[203][WZ6] = 1 end
	for i = 1, JY.PersonNum - 1 do
		JY.Person[i]["解锁"] = Byte.get16(data,i*2)
	end		
	--load skpoint
	local data = Byte.create(8)
	Byte.loadfile(data, CC.R_GRPFilename[0], 1652, 2)
	CC.SKpoint = Byte.get32(data, 0, 2)
	Byte.loadfile(data, CC.R_GRPFilename[0], 1654, 2)
	JY.Thing[203][WZ6] = Byte.get32(data, 0)	
end

function DIYsave(r)
	savebj(r)
	saveConstant()
	--save RW
	local size = 20 * 4
	local data = Byte.create(size * 4)
	local tmp = r - 1
	Byte.set32(data, 0, RW.event)	
	Byte.set32(data, 4, RW.scene)	
	Byte.set32(data, 8, RW.location)	
	Byte.set32(data, 12, RW.targetscene)	
	Byte.set32(data, 16, RW.target)		
	Byte.set32(data, 20, RW.tmp)	
	Byte.set32(data, 24, RW.current)	
	Byte.set32(data, 28, RW.type)	
	Byte.set32(data, 32, RW.t1)	
	Byte.set32(data, 36, RW.n1)	
	Byte.set32(data, 40, RW.t2)	
	Byte.set32(data, 44, RW.n2)	
	Byte.set32(data, 48, RW.t3)	
	Byte.set32(data, 52, RW.n3)	
	Byte.set32(data, 56, RW.t4)	
	Byte.set32(data, 60, RW.n4)	
	Byte.set32(data, 64, RW.t5)	
	Byte.set32(data, 68, RW.n5)	
	Byte.set32(data, 72, RW.fame)	
	--Byte.savefile(data, '.\\data\\SAVE\\rwdata', tmp * size, size)
	Byte.savefile(data, '.\\data\\SAVE\\rwdata' .. r, 0, size)
	
	--save HZ
	local size = 4 * 2 * CC.HZNumMax
	local data = Byte.create(size * 4)
	local tmp = r - 1
	for i = 1, CC.HZNumMax do
		Byte.set32(data, (i - 1) * 8, CC.HZlist[i][2])	
		Byte.set32(data, (i - 1) * 8 + 4, CC.HZlist[i][3])	
	end
	--Byte.savefile(data, '.\\data\\SAVE\\hzdata', tmp * size, size)	
	Byte.savefile(data, '.\\data\\SAVE\\hzdata' .. r, 0, size)	
	
	--save SK
	local size = 4 * #CC.SK
	local data = Byte.create(size * 4)
	local tmp = r - 1
	for i = 1, #CC.SK do
		Byte.set32(data, (i - 1) * 4, CC.SKlist[i][3])	
	end
	--Byte.savefile(data, '.\\data\\SAVE\\skdata', (tmp * size) + 4, size)	
	Byte.savefile(data, '.\\data\\SAVE\\skdata' .. r, 4, size)	
		--save DZ
	local size = 4 * #CC.DZ
	local data = Byte.create(size * 4)
	local tmp = r - 1
	for i = 1, #CC.DZ do
		Byte.set32(data, (i - 1) * 4, CC.DZlist[i][3])	
	end
	--Byte.savefile(data, '.\\data\\SAVE\\dzdata', (tmp * size) + 4, size)
	Byte.savefile(data, '.\\data\\SAVE\\dzdata' .. r, 4, size)	
end

function DIYload(r)
	loadbj(r)
	loadConstant()
	--load RW
	local size = 20 * 4
	local data = Byte.create(size * 4)
	local tmp = r - 1
	--Byte.loadfile(data, '.\\data\\SAVE\\rwdata', tmp * size, r * size)
	Byte.loadfile(data, '.\\data\\SAVE\\rwdata' .. r, 0, size)
	RW.event = Byte.get32(data, 0)
	RW.scene = Byte.get32(data, 4)
	RW.location = Byte.get32(data, 8)
	RW.targetscene = Byte.get32(data, 12)
	RW.target = Byte.get32(data, 16)	
	RW.tmp = Byte.get32(data, 20)	
	RW.current = Byte.get32(data, 24)		
	RW.type = Byte.get32(data, 28)	
	RW.t1 = Byte.get32(data, 32)	
	RW.n1 = Byte.get32(data, 36)		
	RW.t2 = Byte.get32(data, 40)	
	RW.n2 = Byte.get32(data, 44)		
	RW.t3 = Byte.get32(data, 48)	
	RW.n3 = Byte.get32(data, 52)		
	RW.t4 = Byte.get32(data, 56)	
	RW.n4 = Byte.get32(data, 60)	
	RW.t5 = Byte.get32(data, 64)	
	RW.n5 = Byte.get32(data, 68)	
	RW.fame = Byte.get32(data, 72)
	
	--load HZ
	local size = 4 * 2 * CC.HZNumMax
	local data = Byte.create(size * 4)
	local tmp = r - 1	
	--Byte.loadfile(data, '.\\data\\SAVE\\hzdata', tmp * size, r * size)
	Byte.loadfile(data, '.\\data\\SAVE\\hzdata' .. r, 0, size)
	for i = 1, CC.HZNumMax do
		CC.HZlist[i][2] = Byte.get32(data, (i - 1) * 8)
		CC.HZlist[i][3] = Byte.get32(data, (i - 1) * 8 + 4)	
	end
	
	--load SK
	local size = 4 * #CC.SK
	local data = Byte.create(size * 4)
	local tmp = r - 1
	--Byte.loadfile(data, '.\\data\\SAVE\\skdata', (tmp * size) + 4, r * size)
	Byte.loadfile(data, '.\\data\\SAVE\\skdata' .. r, 4, size)
	for i = 1, #CC.SK do
		CC.SKlist[i][3] = Byte.get32(data, (i - 1) * 4)	
	end	
		--load DZ
	local size = 4 * #CC.DZ
	local data = Byte.create(size * 4)
	local tmp = r - 1
	--Byte.loadfile(data, '.\\data\\SAVE\\dzdata', (tmp * size) + 4, r * size)
	Byte.loadfile(data, '.\\data\\SAVE\\dzdata' .. r, 4, size)
	for i = 1, #CC.DZ do
		CC.DZlist[i][3] = Byte.get32(data, (i - 1) * 4)	
	end	
end

function resetRW()
	RW.event = -1
	RW.scene = -1
	RW.location = -1
	RW.targetscene = -1
	RW.target = -1
	RW.tmp = -1
	RW.current = -1		
	RW.type = -1
	RW.t1 = -1
	RW.n1 = -1
	RW.t2 = -1
	RW.n2 = -1
	RW.t3 = -1
	RW.n3 = -1
	RW.t4 = -1
	RW.n4 = -1
	RW.t5 = -1
	RW.n5 = -1		
end

function rwlocation(a, s, l)
	if a == 1 then
		if s == nil or l == nil then
			s = RW.scene
			l = RW.location
		end		
	elseif a == 2 then
		if s == nil or l == nil then
			s = RW.targetscene
			l = RW.target
		end	
	end
	return GetD(s, l, 9), GetD(s, l, 10)
end

function randomlocation()
	local a
	while true do
		a = math.random(106)
		if RW.list[a] == nil then
		else
			break
		end
	end
	return a, RW.list[a][math.random(#RW.list[a])]
end
	
function initializerw(flag,teshu)
	local event = -1
	local scene = -1
	local location = -1
	local targetscene = -1
	local target = -1
	local mp = false
	for i = 1, #RW.mp do
		if JY.SubScene == RW.mp[i][2] then
			mp = true
			break
		end
	end

	local special = 109
	--if JLSD(10, 20 + math.modf(RW.fame * 0.5), 0) then
	--	event = math.random(101, special)
	--	if setRW(event - 100) then --or event == 105 then
	--		event = -1
	--	end
	--end

	if teshu ~= nil then event = teshu end
	
	local total = 6
	if event == -1 then
		if mp then --总数需要修改
			event = math.random(total)
		else
			event = math.random(total - 1)
		end	
	end
	if JY.Person[0]["等级"] == 1 then event = 3 end --武骧金星：一开始只能送货
	--event = math.random(5) --测试
	--event = 101 --测试   特别任务

	if event == 1 then --寻宝
		if math.random(100) <= 50 then
			target = RW.zb[math.random(#RW.zb)]
		else
			target = randomwugong(1, 15)
		end
	elseif event == 2 or event == 3 then --送信 and 送货
		while true do
			targetscene, target = randomlocation()
			if targetscene ~= JY.SubScene then
				break
			end
		end
	elseif event == 4 or event == 5 then --杀怪/杀贼
		
	elseif event == 6 then --巡逻
		local enemy
		while true do
			enemy = math.random(#RW.mp)
			if RW.mp[enemy][2] ~= JY.SubScene then
				break
			end
		end
		target = enemy
	end
	
	if event >= 101 and event <= special then --特别任务
		local num = 1
		for i = 1, #RW.special do
			if RW.special[i][1] == event then
				if targetscene == -1 then
					targetscene = RW.special[i][2]
				end
				local b = RW.special[i][3]
				local c = RW.special[i][4]
				SetS(targetscene, b, c, 3, 109 + num)		
				SetD(targetscene, 109 + num, 9, b)
				SetD(targetscene, 109 + num, 10, c)
				num = num + 1
			end
		end
		target = 110
		if event == 103 then
			targetscene = 3
			target = 1
		end		
	end
	
	scene = JY.SubScene
	local x, y = RWpoint()
	location = GetS(scene, x, y, 3)
	return event, scene, location, targetscene, target
end

function getRW(k,teshu)
	--真正的任务初始化，场景接口需要加个“伪任务”，只有图标？只有接受了才改全局变量
	local function createhead()	
		local h = math.random(350, 575)
		--[[
		while true do
			h = math.random(1, 596)
			if h == 190 or (h >= 311 and h <= 319) or (h >= 410 and h <= 440) or h == 580 or h == 582 then
				
			else
				break
			end
		end]]
		return h
	end
	if teshu == nil and (RWPD() == 0 or k ~= VK_SPACE) then
		do return end
	end
	if (teshu ~= nil or RWPD() == 1) and k == VK_SPACE then		
		local flag = 1 --随机种类
		local e, s, l, ts, t = initializerw(flag,teshu)
		local pid = 584
		randomstats(pid)
		local head = JY.Person[pid]["头像代号"]
		if RW.event == 102 then
			nEvent[102]()
			do return end
		elseif RW.event == 105 then
			nEvent[105]()
			do return end
		elseif RW.fame < 0 then
			say("你这不讲信用的混球，白痴才会委托你办事。", head, 0, "委托人")
			do return end
		elseif RW.event ~= -1 then
			if l ~= RW.location then
				say("我还是先把手上的任务完成再说吧。")			
			else
				say("那就拜托你了。", RW.tmp, 0, "委托人")	
			end
			do return end			
		end		
		--local tmp = GetD(s, l, 2)	
		
		if teshu ~= nil then e = teshu end
		if e == 1 then
			local name = JY.Thing[t]["名称"]
			say("这么多年来我一直在寻找Ｇ"..name.."Ｗ，可惜一无所获。如果谁能帮我找到的话我一定重重酬谢。", head, 0, "委托人")
			if yesno("要接受任务吗？") == false then
				say("那我还是去找其他人吧。", head, 0, "委托人")
				displayRW(3, s, l)
				do return end
			else
				tb("接受任务：寻找"..name.."！")
				
			end
		elseif e == 2 then
			local name = JY.Scene[ts]["名称"]
			say("我有一封急信需要送到Ｇ"..name.."Ｗ，你愿意帮我跑这一趟吗？", head, 0, "委托人")
			if yesno("要接受任务吗？") == false then
				say("那我还是去找其他人吧。", head, 0, "委托人")
				displayRW(3, s, l)
				do return end
			else
				tb("接受任务：送信到"..name.."！")	
				displayRW(2, ts, t)
			end		
		elseif e == 3 then
			local name = JY.Scene[ts]["名称"]
			say("我有一些货物需要送到Ｇ"..name.."Ｗ，你愿意帮我跑这一趟吗？", head, 0, "委托人")
			if yesno("要接受任务吗？") == false then
				say("那我还是去找其他人吧。", head, 0, "委托人")
				displayRW(3, s, l)
				do return end
			else
				tb("接受任务：送货到"..name.."！")	
				displayRW(2, ts, t)
				My_Enter_SubScene(s, JY.Scene[s]["入口X"], JY.Scene[s]["入口Y"], -1)
				say("这些货物沉甸甸的，似乎蛮值钱呢....")
				if yesno("要私吞吗？") == false then
					say("不管了，受人钱财替人消灾，我跑这一趟就是了。")
				else
					say("反正左右没人，吞掉也没人知道。")
					rewardRW(3)
					displayRW(3, s, l)
					displayRW(3, ts, t)
					e, s, l, ts, t = -1, -1, -1, -1
					resetRW()
					AddPersonAttrib(zj(), "品德", -3)
					tb("品德减少！")
					tb(addfame(-2))
				end
			end				
		elseif e == 4 then
			local name = JY.Scene[s]["名称"]
			say("附近最近有Ｇ野兽Ｗ横行伤人，你可以去帮我赶走它们吗？", head, 0, "委托人")
			if yesno("要接受任务吗？") == false then
				say("那我还是去找其他人吧。", head, 0, "委托人")
				displayRW(3, s, l)
				do return end
			else
				tb("接受任务：驱除"..name.."附近的野兽！")	
			end			
		elseif e == 5 then
			local name = JY.Scene[s]["名称"]
			say("附近的Ｇ山贼Ｗ越来越猖狂了，如果有人能去讨伐他们就好了。", head, 0, "委托人")
			if yesno("要接受任务吗？") == false then
				say("那我还是去找其他人吧。", head, 0, "委托人")
				displayRW(3, s, l)
				do return end
			else
				tb("接受任务：讨伐"..name.."附近的山贼！")	
			end	
		elseif e == 6 then
			local name = RW.mp[t][1]
			say("最近我派弟子在山下附近发现Ｇ"..name.."Ｗ的踪影，恐怕是来刺探门中机密的。无奈现在门中人手不够，你要帮忙巡逻吗？", head, 0, "委托人")
			if yesno("要接受任务吗？") == false then
				say("那我还是去找其他人吧。", head, 0, "委托人")
				displayRW(3, s, l)
				do return end
			else
				tb("接受任务：提防附近的"..name.."门人！")	
			end			
		end
		
		--特别任务
		if e == 101 then			
			say("听说最近高升客栈附近的Ｇ山洞Ｗ里面一夜结成了寒冰，也不知道是真是假，你要去看看吗？", head, 0, "委托人")
			if yesno("要去探究吗？") == false then
				displayRW(3, s, l)
				do return end
			else
				tb("接受任务："..RW.s[e - 100][2])	
				addevent(41, 110, 1, nil, nil, 2529 * 2)
				displayRW(2, ts, t)
				displayRW(3, s, l)
				l = -1
				s = -1				
			end			
		elseif e == 102 then
			say("我与友人去Ｇ金蛇山洞Ｗ探险的时候被一条巨蟒袭击，我朋友中了毒现正危在旦夕。大夫说需要那条巨蟒的蛇胆以毒攻毒才能救治。请你帮帮我们吧！", head, 0, "委托人")
			if yesno("要帮忙吗？") == false then
				say("啊啊，谁能帮帮我们！", head, 0, "委托人")
				displayRW(3, s, l)
				do return end
			else
				tb("接受任务："..RW.s[e - 100][2])	
				addevent(46, 110, 1, nil, nil, 4685 * 2)
				displayRW(2, ts, t)
			end				
		elseif e == 103 then
			say("听说Ｇ东北边的客栈Ｗ那里正在举行射击大赛，据说奖品很丰富哦。", head, 0, "路人")
			if yesno("要去看看吗？") == false then
				displayRW(3, s, l)
				do return end
			else
				tb("接受任务："..RW.s[e - 100][2])	
				displayRW(3, s, l)
				l = -1
				s = -1				
				displayRW(2, ts, t)
			end				
		elseif e == 104 then
			say("有人在Ｇ洛阳Ｗ见过赤炼仙子李莫愁。听说丐帮弟子偷了她的五毒秘籍，她现在正在到处找丐帮的晦气呢。", head, 0, "路人")
			if yesno("要去探究吗？") == false then
				displayRW(3, s, l)
				do return end
			else
				tb("接受任务："..RW.s[e - 100][2])	
				addevent(40, 110, 1, nil, nil, 7174)
				displayRW(2, ts, t)
				displayRW(3, s, l)
				l = -1
				s = -1						
			end					
		elseif e == 105 then
			head = 589
			say("啊，差一点点就完成了，可是附近的药物都被买光了，奇怪....", head, 0, "唐萌浅") --武骧金星：唐萌浅的任务改成找药
			say("难道是温家的人在作怪？可恶....", head, 0, "唐萌浅")
			say("哎，看你这样子是要找任务的吧，有没有兴趣接下我的委托啊？", head, 0, "唐萌浅")
			if yesno("要接受任务吗？") == false then
				say("那我还是去找其他人吧。", head, 0, "唐萌浅")
				displayRW(3, s, l)
				do return end
			else
				say("那你去给我找各式丹药每样五个，我有急用。", head, 0, "唐萌浅")
				ts = s
				t = l
				displayRW(2, s, l)
			end					
		elseif e == 106 then --袁紫衣事件
			say("听说恶霸风天南残害忠良，终于被看不过眼的侠客逼得仓皇出逃。据说有人最近在Ｇ玉笔山庄Ｗ又见到了他，似乎还在祸害乡里。唉，谁能治治他啊。", head, 0, "路人")
			if yesno("要去看看吗？") == false then
				displayRW(3, s, l)
				do return end
			else
				tb("接受任务："..RW.s[e - 100][2])	
				addevent(108, 110, 1, nil, nil, 5926)
				displayRW(2, ts, t)
				displayRW(3, s, l)
				l = -1
				s = -1						
			end					
		elseif e == 107 then --殷离事件
			say("听说沙漠山洞里最近有蜘蛛精出现，有人看到一群蜘蛛里面有一个女孩子呢。", head, 0, "路人")
			if yesno("要去看看吗？") == false then
				displayRW(3, s, l)
				do return end
			else
				tb("接受任务："..RW.s[e - 100][2])	
				addevent(10, 110, 1, nil, nil, 7038)
				displayRW(2, ts, t)
				displayRW(3, s, l)
				l = -1
				s = -1						
			end				
		elseif e == 108 then --阿青事件
			say("听说南边森林里面最近出现了一只罕见的白毛猿猴，经常袭击路人，如果有人能把它赶跑就好了。", head, 0, "路人")
			if yesno("要去看看吗？") == false then
				displayRW(3, s, l)
				do return end
			else
				tb("接受任务："..RW.s[e - 100][2])	
				addevent(109, 110, 1, nil, nil, 9404)
				displayRW(2, ts, t)
				displayRW(3, s, l)
				l = -1
				s = -1						
			end				
		elseif e == 109 then --穆念慈事件
			say("襄阳城最近有位姑娘搭了个擂台比武招亲，我也应该去碰碰运气才是。", head, 0, "路人")
			if yesno("要去看看吗？") == false then
				displayRW(3, s, l)
				do return end
			else
				tb("接受任务："..RW.s[e - 100][2])	
				addevent(107, 110, 1, nil, nil, 9130)
				displayRW(2, ts, t)
				displayRW(3, s, l)
				l = -1
				s = -1						
			end			
		end				
		RW.event = e
		RW.scene = s
		RW.location = l
		RW.targetscene = ts
		RW.target = t
		RW.tmp = head
		RW.current = 0			
	elseif RWPD() == 2 and k == VK_SPACE then
		doneRW()
	end
end

function doneRW()
	local function dowar(id)
		return WarMain(id)
	end
	local function dead()
		instruct_15(0)
		instruct_0()
	end
	local pid = 584
	if RW.current == 1 then --任务完成
		local lv = 1
		if RW.event == 1 and hasthing(RW.target) then
			addthing(RW.target, -1)
			say("竟然真的被你找到了！少侠果然名不虚传！小小薄礼，不成敬意。", RW.tmp, 0, "委托人")
			tb(addfame(3))
			tb(jiadian(math.modf(JY.Thing[RW.target]["价钱"] / 1.5)))		
		elseif RW.event == 2 and RW.scene == JY.SubScene then
			if RW.type == 1 then --1普通 2战书 3黑店
				say("这一趟辛苦你了，这是你的酬金。", RW.tmp, 0, "委托人")
				tb(addfame(1))
			elseif RW.type == 2 then
				say("这一趟辛苦你了，这是你的酬金。", RW.tmp, 0, "委托人")
				if yesno("要给他一个教训吗？") then
					say("那个家伙的反应如何？哈哈哈！", RW.tmp, 0, "委托人")
					say("可恶，你这家伙竟然敢拖我下水！看我给你点教训！")
					say("啊啊，等一下，我真的不知道那个家伙的反应会这么大啊。我多给你点补偿好了。", RW.tmp, 0, "委托人")
					lv = 2
				else
					tb(addfame(2))
				end
			elseif RW.type == 3 then
				say("你！你怎么没事？", RW.tmp, 0, "委托人")
				say("宰肥羊竟然宰到我身上来了，我今天就要为民除害！")
				JY.Person[pid]["姓名"] = "强盗"
				if not dowar(294) then
					dead()
					do return end
				end
				light()
				say("大侠饶命啊！我是被逼上梁山的！给我个机会改过自新吧！", RW.tmp, 0, "委托人")
				say("（怎么所有人都是说这一句话）哼！今天只是小惩大诫，若有再犯，决不轻饶！")	
				say("是！是！", RW.tmp, 0, "委托人")
				tb(addfame(1))				
			end
		elseif RW.event == 3 and RW.scene == JY.SubScene then
			say("你做得很好，这是你的酬金。", RW.tmp, 0, "委托人")
			tb(addfame(2))			
		elseif RW.event == 4 then
			say("多亏了你，附近的人不会受野兽骚扰了。这是你的酬金。", RW.tmp, 0, "委托人")
			if JY.Person[0]["品德"] < 75 then
	                instruct_37(1)
		        tb("品德增加1点！")
	                end
			lv = 3
			tb(addfame(2))			
		elseif RW.event == 5 then
			say("谢谢你把山贼赶跑了，这是你的酬金。", RW.tmp, 0, "委托人")
			if JY.Person[0]["品德"] < 75 then
	                instruct_37(1)
		        tb("品德增加1点！")
	                end
			lv = 3
			tb(addfame(2))			
		elseif RW.event == 6 then
			say("谢谢你帮忙巡逻，虽然不能给你什么钱，但是这里有些独门的补药可以帮你增进修为。", RW.tmp, 0, "委托人")
			lv = 4
			tb(addfame(3))		
		end
		
		--特别任务
		
		if RW.event == 102 then
			if RW.type == 1 then
				say("这瓶子？不是蛇胆啊？", RW.tmp, 0, "委托人")
				say("这是蛇涎，经过提炼，效用更胜蛇胆。")
				say("真的....？罢了，死马当作活马医！", RW.tmp, 0, "委托人")
				dark()
				light()
				say("醒了！醒了！少侠真是再世华佗！这些药物本来是打算做延命之用的，请少侠笑纳！", RW.tmp, 0, "委托人")
				lv = 5
			else
				say("蛇胆！太好了，有救了！拜谢少侠救命之恩！", RW.tmp, 0, "委托人")
				lv = 2
			end
			setRW(RW.event - 100, 1)
			tb(addfame(2))
		end
		
		if RW.event == 105 then --特殊任务也有第二步
			nEvent[105]()
			do return end
		end
		
		
		--添加奖品
		
		displayRW(3, RW.scene, RW.location)		
		rewardRW(lv)
		resetRW()	
	
	elseif RW.current == 0 then --任务第二步
		local pid = 583
		local str = ""
		randomstats(pid)
		local head = JY.Person[pid]["头像代号"]	
		if RW.event == 2 and RW.targetscene == JY.SubScene then
			str = "收信人"
			say("这是给我的信？让我看看这写的是什么....", head, 0, str)
			dark()
			light()
			local tmp = math.random(3) --1普通 2战书 3黑店
			RW.type = tmp
			if tmp == 1 then
				say("原来如此。辛苦你大老远跑这一趟，你现在可以回去交差了。", head, 0, str)
			elseif tmp == 2 then
				JY.Person[pid]["姓名"] = "发怒的人"
				str = "发怒的人"
				say("什么！可恶，那家伙竟然敢这样骂我！你小子一定是帮凶！", head, 0, str)		
				say("喂！我什么都没做啊！")
				if not dowar(293) then
					dead()
					do return end
				end
				light()	
				say("你给我冷静一下！")
				say("哼，你给我回去告诉那个家伙，让他给我走着瞧！", head, 0, str)		
				say("（害得我被无辜牵连，看我回去找那个家伙算账！）")				
			else
				JY.Person[pid]["姓名"] = "强盗"
				str = "强盗"
				say("嘿嘿，原来如此。你小子就是这次的肥羊啊。把身上的东西都交出来！", head, 0, str)		
				say("不会吧，我被仙人跳了？")	
				if not dowar(293) then
					dead()
					do return end
				end
				light()		
				say("大侠饶命啊！我是被逼上梁山的！给我个机会改过自新吧！", head, 0, str)
				say("罚你把抢来的财产全部充公，以后要是再敢犯事，小心你的脑袋！")	
				say("是！是！", head, 0, str)			
				rewardRW(2)
				tb(addfame(2))
			end
		
		elseif RW.event == 3 and RW.targetscene == JY.SubScene then
			str = "收货人"
			say("让我清点一下....不错，货物一件不少。你大老远跑这一趟也不容易，这点钱请拿去买酒吧。你可以回去交差了。", head, 0, str)			
			addthing(174, math.random(5) * 100)
		end
		RW.current = 1
		displayRW(2, RW.scene, RW.location)	
		displayRW(3, RW.targetscene, RW.target)	--不一定？？
		
		--特别任务
		if RW.targetscene == JY.SubScene and RW.event >= 101 and RW.event <= 111 then
			if RW.event == 101 then
				nEvent[RW.event]()
				setRW(RW.event - 100, 1)
				displayRW(3, RW.scene, RW.location)		
				resetRW()				
			elseif RW.event == 102 then
				nEvent[RW.event]()
			elseif RW.event == 103 then
				nEvent[RW.event]()
				setRW(RW.event - 100, 1)
				displayRW(3, RW.scene, RW.location)		
				resetRW()			
			elseif RW.event == 104 then
				nEvent[RW.event]()
				setRW(RW.event - 100, 1)
				displayRW(3, RW.scene, RW.location)		
				resetRW()			
			elseif RW.event == 105 then
				nEvent[RW.event]()
			elseif RW.event == 106 then
				nEvent[RW.event]()
				setRW(RW.event - 100, 1)
				displayRW(3, RW.scene, RW.location)		
				resetRW()		
			else
				nEvent[RW.event]()
				setRW(RW.event - 100, 1)
				displayRW(3, RW.scene, RW.location)		
				resetRW()				
			end			
		end
	end
end

function RWpoint()
	local x, y = -1, -1
	if JY.Base["人方向"] == 0 then
		x = JY.Base["人X1"]
		y = JY.Base["人Y1"] - 1
	elseif JY.Base["人方向"] == 1 then
		x = JY.Base["人X1"] + 1
		y = JY.Base["人Y1"]  
	elseif JY.Base["人方向"] == 2 then
		x = JY.Base["人X1"] - 1
		y = JY.Base["人Y1"]
	elseif JY.Base["人方向"] == 3 then
		x = JY.Base["人X1"]
		y = JY.Base["人Y1"] + 1
	end
	return x, y
end

function RWPD()
	local x, y = RWpoint()
	if GetS(JY.SubScene, x, y, 2) == 4683 * 2 then
		return 1
	elseif GetS(JY.SubScene, x, y, 2) == 4684 * 2 then
		return 2
	end
	return 0
end

function displayRW(a, s, l) --1? 2! 3cls
	local x, y = rwlocation(a, s, l)
	if s == nil or l == nil then
		s = RW.scene
		l = RW.location	
	end
	if a == 1 then
		SetS(s, x, y, 2, 4683*2)
		SetS(s, x, y, 5, 80)	
	elseif a == 2 then
		SetS(s, x, y, 2, 4684*2)
		SetS(s, x, y, 5, 80)		
	else
		SetS(s, x, y, 2, 9999*2)
		SetS(s, x, y, 5, 80)			
	end
end

function drawRW()
	if RW.list[JY.SubScene] ~= nil then
		for i = 1, #RW.list[JY.SubScene] do
			if JY.SubScene == RW.scene and RW.list[JY.SubScene][i] == RW.location then
				if RW.current == 0 then
					displayRW(1, JY.SubScene, RW.list[JY.SubScene][i])		
				elseif RW.current == 1 then
					displayRW(2, JY.SubScene, RW.list[JY.SubScene][i])		
				end
				if RW.event == 105 then
					displayRW(2, JY.SubScene, RW.list[JY.SubScene][i])	
				end
			elseif JY.SubScene == RW.targetscene and RW.list[JY.SubScene][i] == RW.target then
				--displayRW(2, JY.SubScene, RW.list[JY.SubScene][i])
			else
				displayRW(3, JY.SubScene, RW.list[JY.SubScene][i])	
				if math.random(10) == 1 then
					displayRW(1, JY.SubScene, RW.list[JY.SubScene][i])				
				end
			end
		end
	end
end

function checkRW()
	if RW.event == 1 then
		if hasthing(RW.target) then
			RW.current = 1
			displayRW(2, RW.scene, RW.location)		
		end
	end
end

function randomplace()
	local a = 70
	while true do
		a = math.random(0, 105)
		if a == 5 or a == 7 or a == 10 or a == 13 or a == 14 or a == 15 or a == 25 or 
			a == 41 or a == 65 or a == 67 or a == 70 or a == 79 or a == 82 or a == 83 
			or a == 84 or a == 85 or (a >= 86 and a <= 91) or a == 104 then
		
		else
			break
		end
	end
	return a
end

function randomstats(pid, flag, name)
	local r = math.random(1, 654)
	while animal(r) or JY.Person[r]["排行"] < 1 do
		r = math.random(1, 654)
	end
	if flag ~= nil then
		r = flag
	end
	if name ~= nil then
		JY.Person[pid]["姓名"] = name
	end
	JY.Person[pid]["等级"] = 30
	JY.Person[pid]["经验"] = 0
	JY.Person[pid]["内力性质"] = math.random(0, 2)
	JY.Person[pid]["性别"] = JY.Person[r]["性别"]
	JY.Person[pid]["头像代号"] = JY.Person[r]["头像代号"]
	JY.Person[pid]["半身像"] = JY.Person[r]["半身像"]
	JY.Person[pid]["生命增长"] = JY.Person[r]["生命增长"]	
	JY.Person[pid]["攻击力"] = math.random(100, 400) 
	JY.Person[pid]["防御力"] = math.random(100, 400) 
	JY.Person[pid]["轻功"] = math.random(100, 300) 
	JY.Person[pid]["攻击带毒"] = math.random(0, 240)
	JY.Person[pid]["武学常识"] = math.random(0, 50)
	JY.Person[pid]["医疗能力"] = 0
	JY.Person[pid]["解毒能力"] = 0
	JY.Person[pid]["用毒能力"] = 0
	JY.Person[pid]["抗毒能力"] = math.random(0, 240)
	JY.Person[pid]["拳掌功夫"] = math.random(0, 150)
	JY.Person[pid]["御剑能力"] = math.random(0, 150) 
	JY.Person[pid]["耍刀技巧"] = math.random(0, 150)
	JY.Person[pid]["特殊兵器"] = math.random(0, 150)
	JY.Person[pid]["暗器技巧"] = math.random(0, 150)
	for i = 1, 5 do
		JY.Person[pid]["出招动画帧数" .. i] = JY.Person[r]["出招动画帧数" .. i]
		JY.Person[pid]["出招动画延迟" .. i] = JY.Person[r]["出招动画延迟" .. i]
		JY.Person[pid]["武功音效延迟" .. i] = JY.Person[r]["武功音效延迟" .. i]
	end		
	JY.Person[pid]["资质"] = math.random(1, 100)
	JY.Person[pid]["左右互搏"] = 0
	if JY.Person[pid]["资质"] <= 70 and math.random(5) == 1 then
		JY.Person[pid]["左右互搏"] = 1
	end
	JY.Person[pid]["声望"] = 0
	JoinMP(pid, 0, 0)
	local nglist = {6,89,90,92,93,94,95,96,97,98,99,121,124,150,151,152,153,178}
	local nglist2 = {100,101,102,103,104,105,106,107,108,180}
	if math.random(10) == 1 then
		JY.Person[pid]["声望"] = nglist2[math.random(#nglist2)]
		JY.Person[pid]["武功2"] = JY.Person[pid]["声望"]
		JY.Person[pid]["武功等级2"] = 999	
	else
		JY.Person[pid]["声望"] = nglist[math.random(#nglist)]
		JY.Person[pid]["武功2"] = JY.Person[pid]["声望"]
		JY.Person[pid]["武功等级2"] = 999		
	end
	if math.random(5) == 1 then
		JoinMP(pid, math.random(#CC.MP), 1)
	end	
	local thing = randomwugong2(5, 15, 1)
	JY.Person[pid]["武功1"] = JY.Thing[thing]["练出武功"]	
	JY.Person[pid]["武功等级1"] = 999
	JY.Person[pid]["实战"] = math.random(300)
	local m = limitX(2 + math.modf(JY.Person[pid]["实战"] / 250), 2, 4)
	--local m = m + math.modf(JY.Person[pid]["实战"] / 250)
	if MPPD(pid) ~= 0 then
		m = 1
	end		
	for i = 1, m do
		JY.Person[pid]["HZ"..i] = 0
		if math.random(3) == 1 then
			JY.Person[pid]["HZ"..i] = CC.HZ[math.random(#CC.HZ)][1]
		end
	end
	JY.Person[pid]["生命最大值"] = math.random(1000, 1500)
	JY.Person[pid]["生命"] = JY.Person[pid]["生命最大值"]
	JY.Person[pid]["内力最大值"] = math.random(2000, 5000)
	JY.Person[pid]["内力"] = JY.Person[pid]["内力最大值"]	
end

function addfame(n)
	RW.fame = limitX(RW.fame + n, -999, 999)
	local str = "声望提升"..n.."点！"
	if n < 0 then str = "声望减少"..-n.."点！" end
	return str
end

function rewardRW(n)
	local list = {0, 1, 3, 4, 5, 9, 10, 12} --低级药
	local list2 = {2, 6, 7, 8, 11, 13} --高级药
	local list3 = {14, 15, 16, 17, 26, 27} --灵药
	local list4 = {18, 19, 20, 21} --菜
	local list5 = {22, 23, 24, 25} --酒
	local list6 = {28, 29, 30, 31, 32, 33, 34, 35} --暗器
	if n == 1 then
		addthing(174, math.random(36, 45) * 100)
	elseif n == 2 then
		addthing(174, math.random(5) * 100)
		addthing(list[math.random(#list)], math.random(2,3))
		addthing(list[math.random(#list)], math.random(2,3))
	elseif n == 3 then
		addthing(174, math.random(5) * 100)
		addthing(list2[math.random(#list2)], math.random(2,3))
		addthing(list2[math.random(#list2)], math.random(2,3))		
	elseif n == 4 then
		for i = 1, CC.TeamNum do
			if JY.Base["队伍"..i] >= 0 then
				AddPersonAttrib(JY.Base["队伍"..i], "实战", 15)
			end
		end	
		tb("全体队友实战增加15点")
		addthing(174, math.random(5) * 100)	
	elseif n == 5 then
		for i = 1, CC.TeamNum do
			if JY.Base["队伍"..i] >= 0 then
				local tmp = {"攻击力", "轻功", "防御力"}
				local r = math.random(#tmp)
				local r2 = math.random(5)
				JY.Person[JY.Base["队伍"..i]][tmp[r]] = JY.Person[JY.Base["队伍"..i]][tmp[r]] + r2
				tb(JY.Person[JY.Base["队伍"..i]]["姓名"].."的"..tmp[r].."上升"..r.."点！")
			end
		end		
	elseif n == 6 then
		for i = 1, CC.TeamNum do
			if JY.Base["队伍"..i] >= 0 then
				local tmp = {"拳掌功夫", "御剑能力", "耍刀技巧", "特殊兵器"}
				local r2 = math.random(3)
				JY.Person[JY.Base["队伍"..i]][tmp[r]] = JY.Person[JY.Base["队伍"..i]][tmp[r]] + r2
				tb(JY.Person[JY.Base["队伍"..i]]["姓名"].."的"..tmp[r].."上升"..r.."点！")
			end
		end		
	elseif n == 7 then
		addthing(174, math.random(5) * 100)
		local list = {}
		local x1 = CC.MainSubMenuX
		local y1 = CC.MainSubMenuY		
		for i = 1, #CC.HZ do
			list[i] = i
		end
		local menu = {}
		for i = 1, #list do
			menu[i] = {string.format("%-12s",CC.HZ[list[i]][2]), nil, 1}
			if hasHZ(i) then
				menu[i][3] = 0
			end
		end
		local r = ShowMenu(menu,#menu,15,x1,y1+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);
		if r <= 0 then do return end end
		addHZ(r)		
		do return end
	end
	tb(jiadian(n * 20))
end

function RWstatus()

	local size = CC.DefaultFont
	local width = 13 * size 
	local h = size + CC.PersonStateRowPixel
	local height = 6 * h 
	local dx = (CC.ScreenW - width) / 2
	local dy = (CC.ScreenH - height) / 2
	local i = 1  
	Cls()
	--lib.LoadPicture(CC.STA, -1, -1)
	DrawBox(dx, dy, CC.ScreenW - dx, CC.ScreenH - dy, C_WHITE)
	DrawString(math.modf((CC.ScreenW - dx)/2) + size, dy, "任务状态", C_ORANGE, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "声望：", C_RED, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) + 4 * size, dy + h * i, ""..RW.fame, C_GOLD, size)
	i = i + 1
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "任务：", C_ORANGE, size)
	local a = "无"
	local b = "无"
	local c = "无"
	local d = "无"
	
	if RW.event == -1 then
		
	else
		if RW.event >= 101 and RW.event <= 111 then		
			for i = 1, #RW.s do
				if RW.s[i][1] == RW.event then
					a = RW.s[i][2]
					b = RW.s[i][3]
					d = RW.s[i][5]
					if RW.s[i][4] ~= nil then
						c = RW.s[i][4]
					else
						c = JY.Scene[RW.scene]["名称"]
					end
				end
			end
		else
			if RW.event == 1 then
				a = "寻找物品"
				b = JY.Thing[RW.target]["名称"]
			elseif RW.event == 2 then
				a = "送信"
				b = JY.Scene[RW.targetscene]["名称"]
			elseif RW.event == 3 then
				a = "送货"
				b = JY.Scene[RW.targetscene]["名称"]
			elseif RW.event == 4 then
				a = "驱逐野兽"
				d = JY.Scene[RW.scene]["名称"].."附近"
			elseif RW.event == 5 then
				a = "驱逐山贼"
				d = JY.Scene[RW.scene]["名称"].."附近"
			elseif RW.event == 6 then
				a = "门派巡逻"
				b = RW.mp[RW.target][1]
				d = JY.Scene[RW.scene]["名称"].."附近"	
			end		
			c = JY.Scene[RW.scene]["名称"]
		end	
	end
		

	DrawString(math.modf((CC.ScreenW - dx)/2) + 4 * size, dy + h * i, ""..a, M_Wheat, size)
	i = i + 1
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "目标：", C_ORANGE, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) + 4 * size, dy + h * i, ""..b, C_GOLD, size)
	i = i + 1
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "出发地：", C_ORANGE, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) + 4 * size, dy + h * i, ""..c, M_Wheat, size)
	i = i + 1
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "目的地：", C_ORANGE, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) + 4 * size, dy + h * i, ""..d, M_Wheat, size)	
	ShowScreen()
	lib.Delay(500)
	WaitKey()
end

OEVENTLUA[30011] = function() --大地图任务
	local yes = 0
	if math.random(10) == 5 then
		yes = 1
	end
	if yes == 0 then
		do return end
	end
	if yes == 1 then
		if GetS(106, 63, 3, 0) == 1 then
			Cls()	
			say("此路是我开，此树是我栽，要想从此过，留下买路财！", math.random(100, 200), 0, "山贼")		
			if WarMain(287) == false then
				instruct_15(0);   
				instruct_0();  
				do return; end			
			end			
			light()
			do return end
		elseif RW.event == 5 and RW.current == 0 then	
			say("谁敢闯山！", math.random(100, 200), 0, "山贼甲")		
			say("大胆山贼！速速放下武器投降！")				
			say("哈哈哈，又来了个送死的。", math.random(100, 200), 0, "山贼乙")	
			say("兄弟们上！", math.random(100, 200), 0, "山贼丙")				
			if WarMain(286) == false then
				instruct_15(0);   
				instruct_0();  
				do return; end			
			end		
			RW.current = 1
			displayRW(2, RW.scene, RW.location)		
			light()
			say("终于解决掉了。回去交差吧。")	
			do return end	
		elseif GetS(106, 63, 3, 0) == 3 and GetS(106, 63, 4, 0) ~= 1 then
			Cls()	
			say("看到了！应该就是那个人。虽然有点对不起他....但是没办法了....")				
			if WarMain(290) == false then
				instruct_15(0);   
				instruct_0();  
				do return; end			
			end		
			SetS(106, 63, 4, 0, 1)	
			light()
			say("终于抢回来了，回去交差吧。")	
			do return end				
		elseif RW.event == 4 and RW.current == 0 then
			say("是这里了！果然很多野兽横行！")							
			if WarMain(286) == false then
				instruct_15(0);   
				instruct_0();  
				do return; end			
			end		
			RW.current = 1
			displayRW(2, RW.scene, RW.location)		
			light()
			say("终于解决掉了。回去交差吧。")	
			do return end			
		elseif RW.event == 6 and RW.current == 0 then
			say("前面那些人行迹鬼祟，难道就是敌对门派的间谍？")		
			say("啊！被发现了！扯呼！", math.random(100, 200), 0, "间谍")	
			say("别跑！")					
			if WarMain(286) == false then
				instruct_15(0);   
				instruct_0();  
				do return; end			
			end		
			RW.current = 1
			displayRW(2, RW.scene, RW.location)		
			light()
			say("终于解决掉了。回去交差吧。")	
			do return end			
		end				
	end		
end

function petAttrib(str, n)
	local pid = 606
	local n2, s = AddPersonAttrib(pid, str, n)
	if n2 ~= 0 then
		tb(JY.Person[pid]["姓名"].."的"..s)
	end
end

function feedPet()
	local thing = {}
	local thingnum = {}
	for i = 0, CC.MyThingNum - 1 do
		thing[i] = -1
		thingnum[i] = 0
	end
	local num = 0
	for i = 0, CC.MyThingNum - 1 do
		local id = JY.Base["物品" .. i + 1]
		if id >= 0 then
			if JY.Thing[id]["类型"] == 1 or JY.Thing[id]["类型"] == 3 or JY.Thing[id]["类型"] == 4 then
				thing[num] = id
				thingnum[num] = JY.Base["物品数量" .. i + 1]
				num = num + 1
			end
		end 
	end
	local r = SelectThing(thing, thingnum)
	if r >= 0 then
		local pid = 606
		local jl = 15
		local pet = JY.Base["宠物"]
		local love = math.random(2)
		local others = math.modf(JY.Person[pid]["资质"] / 10)
		local list = {
			{1, 14, 15, 16, 17, 18, 19, 20, 21}, --灵药+食物
			{2, 10, 11, 12, 13}, --体力解毒药
			{3, 18, 19, 20, 21}, --食物
			{4, 2, 6, 7, 8, 18, 19, 20, 21}, --高级药+食物
			{5, 20, 21, 24, 25}, --暗器
			{6, 22, 23, 24, 25}, --酒			
		}
		local bonus = false
		for i = 2, #list[pet] do
			if r == list[pet][i] then
				bonus = true
				jl = jl + limitX(JY.Person[pid]["资质"], 40, 70)
				others = others + 5
				love = love + 2
				break
			end
		end		
		--雕爱灵药，蟾爱解毒，蟒爱食物，鳄爱药，蛛爱暗器，猿爱酒，
		
		if JLSD(10, 10 + jl, pid) then
			petAttrib("攻击力", math.random(others))
			petAttrib("防御力", math.random(others))
			petAttrib("轻功", math.random(others))
			petAttrib("生命最大值", math.random(others) * 10)
			petAttrib("内力最大值", math.random(others) * 20)
		else
			tb(JY.Person[pid]["姓名"].."好像不是很满意的样子")
		end
		petAttrib("友好度", love)
		instruct_32(r, -1)
	end
end

function readPet()
	local thing = {}
	local thingnum = {}
	for i = 0, CC.MyThingNum - 1 do
		thing[i] = -1
		thingnum[i] = 0
	end
	local num = 0
	for i = 0, CC.MyThingNum - 1 do
		local id = JY.Base["物品" .. i + 1]
		if id >= 0 then
			if JY.Thing[id]["类型"] == 2 then
				thing[num] = id
				thingnum[num] = JY.Base["物品数量" .. i + 1]
				num = num + 1
			end
		end 
	end
	local r = SelectThing(thing, thingnum)
	if r >= 0 then
		local pid = 606
		local jl = JY.Person[pid]["资质"]
		local pet = JY.Base["宠物"]
		local love = math.random(2)
		local others = math.modf(JY.Person[pid]["资质"] / 10)
		local list = {"拳掌功夫", "御剑能力", "耍刀技巧", "特殊兵器"}
		
		if JLSD(10, 15 + jl, pid) then
			for i = 1, #list do
				if JY.Thing[r]["加"..list[i]] > 0 then
					petAttrib(list[i], JY.Thing[r]["加"..list[i]])
				end
			end
			petAttrib("生命最大值", math.random(others) * 10)
			petAttrib("内力最大值", math.random(others) * 20)			
			JY.Person[pid]["武功等级1"] = JY.Person[pid]["武功等级1"] + others + math.random(50)
			JY.Person[pid]["武功等级2"] = JY.Person[pid]["武功等级2"] + others + math.random(50)
			if JY.Person[pid]["武功等级1"] > 999 then JY.Person[pid]["武功等级1"] = 999 end
			if JY.Person[pid]["武功等级2"] > 999 then JY.Person[pid]["武功等级2"] = 999 end
			tb(JY.Person[pid]["姓名"].."的武学等级稍微提升了！")
		else
			tb(JY.Person[pid]["姓名"].."一脸迷糊的样子")
		end	
		petAttrib("友好度", love)
	end
end

function playPet(tmp)
	local pid = 606
	local love = math.random(2)	
	local jl = 10 + math.modf(JY.Person[pid]["友好度"] / 5)
	local name = JY.Person[pid]["姓名"]
	if JLSD(10, jl, zj()) then
		say("（突然停在了一处，只是跳个不停。）", 606)	
		say("这块地看起来有些古怪....")	
		if yesno("要挖挖看吗？") == false then
		
		else			
			if math.random(10) <= 5 then	
				JY.Status = tmp
				say("有危险！小心！")	
				if WarMain(295) then
					say("原来这里是野兽的巢穴啊。下次不要到处乱跑了。")
					say("呜~~（一幅心虚低头的样子）", 606)		
				else
					say("呜~~（浑身是伤，打不起精神的样子）", 606)	
					say("下次要小心一点啊。")
				end						
				return 1
			else
				--JY.Status = tmp
				local win = false
				win = mining()
				--JY.Status = GAME_PET
			end
		end
	end
	petAttrib("友好度", love)
	return 0
end


function petMenu()
	if JY.Base["宠物"] <= 0 then
		tb("现在没有宠物")
		do return end
	end

	local menu = {
		{"喂养", "食为天！增加三围和亲密度"},
		{"读书", "它能看懂么？增加四系和亲密度"},
		{"玩耍", "寓教于乐。增加亲密度，还有？？？"},
		{"狩猎", "让它自生自灭，啊，不，自力更生！"},
		{"休息", "夏日炎炎，正好冬眠。"},
		{"状态", "把它看个透。"},
		{"放生", "爱它就是放走它？"},
	}
	local size = CC.DefaultFont
	local start = 1
	local stop = 7
	local stop2 = 7
	if #menu < stop2 then stop2 = #menu end
	local current = 1	
	local size1 = size - 5
	local h = size + CC.PersonStateRowPixel
	local height = h * stop2 + 10
	local width = 2 * size + 10
	local x0 = 20
	local y0 = 5
	local i = 0
	local p
	local pid = 606
	local tmp = JY.Status --记录现在状态
	while true do
		local name = JY.Person[pid]["姓名"]
		local hp = JY.Person[pid]["生命"]
		local mhp = JY.Person[pid]["生命最大值"]
		local mp = JY.Person[pid]["内力"]
		local mmp = JY.Person[pid]["内力最大值"]	
		local atk = JY.Person[pid]["攻击力"]	
		local def = JY.Person[pid]["防御力"]	
		local spd = JY.Person[pid]["轻功"]	
		local love = JY.Person[pid]["友好度"]		
		JY.Status = GAME_PET
		i = 0
		Cls()
		--lib.LoadPicture(CONFIG.PicturePath .. "p1.png", -1, -1)
		DrawBox(x0, y0, x0 + width, y0 + height, C_WHITE)
		
		for j = start, stop do
			if menu[j] ~= nil and menu[j][1] ~= nil then
				if current == j then
					DrawString(x0 + 5, y0 + h * (i) + 5, menu[j][1], C_WHITE, size)
				else
					
					DrawString(x0 + 5, y0 + h * (i) + 5, menu[j][1], C_GOLD, size)
				end
				i = i + 1
			end
		end
		
		DrawBox(x0 + x0 + width, y0, CC.ScreenW - 10,  #menu[current] * h + y0 + 10, C_WHITE)
		for j = 1, #menu[current] do
			if menu[current][j] ~= nil then
				if j == 1 then
					DrawString(x0 + 25 + width, y0 + h * (j - 1) + 5, menu[current][j], C_RED, size)
				else
					DrawString(x0 + 25 + width, y0 + h * (j - 1) + 5, menu[current][j], M_Wheat, size)
				end
			end
		end
		
		DrawBox(x0, y0 + h * 10, math.modf(CC.ScreenW / 2),  CC.ScreenH - 10, C_WHITE)
		i = 10
		DrawString(x0 + 5, y0 + h * i + 5, "姓名    "..name, C_ORANGE, size)
		i = i + 1
		DrawString(x0 + 5, y0 + h * i + 5, "生命    "..hp.."／"..mhp, C_GOLD, size)
		i = i + 1
		DrawString(x0 + 5, y0 + h * i + 5, "内力    "..mp.."／"..mmp, C_GOLD, size)
		i = i + 1
		DrawString(x0 + 5, y0 + h * i + 5, "攻击力  "..atk, C_GOLD, size)
		i = i + 1
		DrawString(x0 + 5, y0 + h * i + 5, "防御力  "..def, C_GOLD, size)
		i = i + 1
		DrawString(x0 + 5, y0 + h * i + 5, "轻功    "..spd, C_GOLD, size)
		i = i + 1
		local ll
		if love < 80 then
			ll = "不想参战"
		else
			ll = "可以参战"
		end
		DrawString(x0 + 5, y0 + h * i + 5, "亲密度  "..love.."  "..ll, C_RED, size)
		ShowScreen()
		p = WaitKey()
		if p == VK_ESCAPE then
			JY.Status = tmp
			break
		elseif p == VK_DOWN then
			current = current + 1
			if current > #menu then
				current = 1
			end
		elseif p == VK_UP then
			current = current - 1
			if current == 0 then
				current = #menu
			end
		elseif p == VK_RETURN or VK_SPACE then
			if current >= 1 and current <= 4 then
				if YC.PET[current] > 0 then
					YC.PET[current] = YC.PET[current] - 1
					if current == 1 then
						feedPet()
					elseif current == 2 then
						if love < 20 then
							say("（抬头看了你一眼，没理你，又睡过去了。）", 606)	
						else
							readPet()
						end
					elseif current == 3 then
						if love < 50 then
							say("（抬头看了你一眼，没理你，又睡过去了。）", 606)	
						else
							say("（围着你跳个不停，欢欣雀跃的样子。）", 606)	
							if playPet(tmp) == 1 then
								break
							end
						end
					elseif current == 4 then
						--JY.Status = tmp
						say("上吧！今天是看你训练成果的日子！")
						say("（全身戒备，似乎回到了野性的状态。）", 606)		
						if WarMain(295) then
							say("做得好！回头给你做好吃的！")
							say("（眼睛一亮，凑到你跟前跳个不停，一副讨好的样子。）", 606)	
							petAttrib("友好度", 5)
						else
							say("呜~~（浑身是伤，打不起精神的样子）", 606)	
							say("唉，还是应该再好好训练一番啊。")
							petAttrib("友好度", -10)
						end
						--JY.Status = GAME_PET
						--break
					end				
				else
					tb(name.."好像提不起兴趣的样子")
				end
			end
			if current == 5 then
				dark()
				JY.Person[pid]["受伤程度"] = 0
				JY.Person[pid]["中毒程度"] = 0
				AddPersonAttrib(pid, "体力", math.huge)
				AddPersonAttrib(pid, "生命", math.huge)
				AddPersonAttrib(pid, "内力", math.huge)
				light()				
			elseif current == 6 then
				Cls()
				ShowPersonStatus_sub(pid, 1)
				ShowScreen()
				local q = WaitKey()
				while q ~= VK_ESCAPE and q ~= VK_SPACE and q ~= VK_RETURN do
					q = WaitKey()
				end
			elseif current == 7 then
				if yesno("确定要放它走吗？") then
					say("是时候让你回到你生长的地方了，多保重啊。")	
					say("呜~~（回头看了一眼，依依不舍地离开了。）", 606)		
					JY.Base["宠物"] = 0
					JY.Status = tmp
					break
				end
			end
		end
	end	
	
end

function joinPet()
	if JY.Base["宠物"] <= 0 or JY.Person[606]["友好度"] < 80 then
		return
	end
	local x0, y0
	local p = false
	local p2 = false
	for k = 0, WAR.PersonNum - 1 do
		if WAR.Person[k]["人物编号"] == zj() then
			x0 = WAR.Person[k]["坐标X"]
			y0 = WAR.Person[k]["坐标Y"]
			p = true
			break
		end
	end

	if WAR.Data["自动选择参战人1"] ~= 0 then
		p2 = true
	elseif WAR.Data["自动选择参战人1"] == 0 and WAR.Data["自动选择参战人2"] ~= -1 then
		p2 = true
	end
	if p and p2 and yesno("要让宠物参战吗？") then
		local x, y = WE_xy(x0, y0)	
		NewWARPersonZJ(606, true, x, y, false, 2)
		petAttrib("友好度", -10)
		--AddPersonAttrib(zj(), "体力", -20)	
		--tb(JY.Person[zj()]["姓名"].."体力减少20点")
	end
end

function hasPet()
	if JY.Base["宠物"] <= 0 then
		return false
	else
		return true
	end
end

function setPet(n, flag)
	if n == 0 then
		JY.Base["宠物"] = 0
		return
	end
	local start = 607
	local pid = 606
	for i = 1, #PSX - 8 do
		JY.Person[pid][PSX[i]] = JY.Person[start + n][PSX[i]]
	end
	--local t = math.modf(JY.Person[pid]["资质"] * 0.5)
	--JY.Person[pid]["生命最大值"] = 200
	--JY.Person[pid]["生命"] = 200
	--JY.Person[pid]["内力最大值"] = 500
	--JY.Person[pid]["内力"] = 500
	--JY.Person[pid]["攻击力"] = t + math.random(t)
	--JY.Person[pid]["防御力"] = t + math.random(t)
	--JY.Person[pid]["轻功"] = t + math.random(t)
	--JY.Person[pid]["武功等级1"] = 10
	--JY.Person[pid]["武功等级2"] = 10
	--JY.Person[pid]["拳掌功夫"] = 10
	--JY.Person[pid]["御剑能力"] = 10
	--JY.Person[pid]["耍刀技巧"] = 10
	--JY.Person[pid]["特殊兵器"] = 10
	JY.Base["宠物"] = n
	local str = "收服"..JY.Person[start + n]["姓名"].."为宠物！"
	if flag == nil then
		tb(str)
		tb("请给宠物起一个名字")
		JY.Person[pid]["姓名"] = "";
		while JY.Person[pid]["姓名"] == "" do
			JY.Person[pid]["姓名"] = Shurufa(32, CC.ScreenH - 6 * CC.Fontbig)
			if JY.Person[pid]["姓名"] == "" then
				tb("请给宠物起一个名字")
			end
		end	
	else
		return str
	end	
end

nEvent = {}
nEvent[101] = function()
	TalkEx("一进洞内，只觉得奇寒彻骨，四周洞壁冰凌横挂，与外面酷热暑天对比之下甚是奇异。",0,2)	
	say("这里怎么这般冷法。咦，前面那个是？")
	TalkEx("只见前方有一条青玉色的蚕儿，正在吮吸身旁冻僵的各种毒虫的毒液。",0,2)	
	if not hasppl(47) or not hasppl(48) then
		say("好厉害的蚕儿，这四周的寒气，难道就是它身上放出来的？待我上前看一下。")
		TalkEx("那只蚕机警异常，见到有人上前，猛然一纵，喷出一阵寒气，逃遁而去。",0,2)
		dark()
		addevent(RW.targetscene, RW.target, 0, -2, -2, 0)
		displayRW(3, RW.targetscene, RW.target)
		light()
		say("啊！好厉害的虫子！寒气逼人，恐怕对身体有害，必须立刻运功逼出才行。")
		dark()
		AddPersonAttrib(zj(), "内力最大值", 500)
		light()
		say("这一阵运功抵抗寒气，竟然让我功力大增，那蚕儿果真是异宝。可惜啊可惜。")
		tb(JY.Person[zj()]["姓名"].."内力上升！")
	else
		say("这条蚕儿好厉害，看来是毒物中的大王了。铁头，快点把它捉住！", 47)	
		say("是！", 48)	
		local pid = 583
		randomstats(pid, 496)
		JY.Person[pid]["姓名"] = "慧净"
		say("住手！别动老子的蚕儿！", 583)	
		if WarMain(296) == false then
			instruct_15()
			return
		end
		addevent(RW.targetscene, RW.target, 0, -2, -2, 0)
		displayRW(3, RW.targetscene, RW.target)
		say("死秃子逃得真快。不管他了，捉这条蚕儿要紧。", 47)	
		say("阿紫姑娘....这蚕儿....刚才打斗的时候趁机咬了我一口，然后就一动不动了....", 48)	
		say("什么？？你！你这败事的家伙！看我不打死你！", 47)	
		say("姑娘请等一下。这条蚕儿虽然已死，但是寒气犹在，我看至少也能炼出些药丸帮你增进修为。铁头兄也是无心之过，还请你不要过于责怪他。")	
		say("哼！我不管了！反正你要把它给我炼成灵药！", 47)	
		say("好，姑娘稍候。")	
		dark()
		light()
		instruct_2(257, 1)
		say("这还差不多，这次就放过你吧。", 47)	
		say("是是，谢谢阿紫姑娘，谢谢少侠。", 48)	
		say("（刚刚被咬了一口，这蚕儿的寒气一直在我体内无法消解。这该怎么办才好......）", 48)
		if hasppl(2) and PersonKF(2,87) and PersonKF(2,21) and JX(2) then --
			say("（这是千年冰蚕没错了，铁头被这么一咬，得想办法处理...）", 2)
			tb("程灵素看著游坦之瑟瑟发抖，却又强撑著不倒下的身影，拼命思索著！")
			say("（等等，如果先以化功大法的法门做引导，再用玄冥掌运使寒毒的方式...）", 2)
			say("（有门儿！！事不宜迟！！）", 2)
			say("铁头！！专心听我说！！", 2)
			tb("程灵素简洁快速的讲解著役使寒毒的法门。而得益于神足经的帮助，铁头勉强跟上了程灵素，拼命用神足经的内力捕捉著体内虚实不定的寒毒劲力。")
			dark()
			light()
			say("呼...呼...", 48)
			say("铁头，感觉如何？")
			say("多谢程姑娘的帮助，我...我想我是挺过来了，好像还功力进步不少的样子", 48)
			tb("游坦之觉醒摩呼罗迦奥义！")
			setJX(48)
			say("不谢，我也算有所收获，至少如何发挥玄冥掌的威力，我有更深的体会了。", 2)
			say("恭喜程妹了")
			if JY.Person[0]["性别"] == 0 then
				say("要不是有大哥带我出还看看这江湖，我也想不到这个办法。", 2)
				say("要不大哥也详细听听我对玄冥掌的体会？", 2)
			else
				say("要不是有姐姐带我出还看看这江湖，我也想不到这个办法。", 2)
				say("要不姐姐也详细听听我对玄冥掌的体会？", 2)
			end	
			if DrawStrBoxYesNo(-1, -1, "要听听看么？", C_WHITE, 30) == true then
				say("那我就恭敬不如从命了，哈哈")
				QZXS("领悟玄冥神掌寒毒奥义！")
				setLW1(21)
				say("多谢程妹")
				say("（明媚一笑）", 2)
			else
				say("多谢程妹好意了，但这与我的武功路子不合呀...")
				say("阿...是我唐突了...", 2)
				say("没事没事，程妹的心意我已经郑重的收下了！")
				say("（明媚一笑）", 2)
			end
		else	
			tb("寒冷无比的游坦之又急又慌，无意识的运起了神足经的内力去捕捉那股寒毒劲力")
			say("（咦？这寒毒怎么突然像小玩具似的，这么驯服？）", 48)
			say("（...算了，想不通就不想了，总之没事就好。）" , 48)
			say("（这可不能被阿紫姑娘知道，不然我会被骂死的....）", 48)
			tb("游坦之觉醒摩呼罗迦奥义！")
			setJX(48)
		end	
	end
	tb("任务结束！")	
end

nEvent[102] = function()
	say("好大的一条蛇！一定就是它了。可是要怎样才能捉到它呢....")
	if hasppl(61) then
		local t = 1
		say("捕蛇并非难事，难只难在于是否要把它驯服。如果只是需要取胆的话，直接以雄黄薰之再以网捕获。如果要驯服的话倒是要多费点心思。", 61)
		if hasthing(18) and not hasPet() then
			if yesno("要进行捕获吗？") then
				t = 2
			end
		end
		if t == 1 then
			say("救人要紧，直接取胆吧。")
			if WarMain(298) == false then 
				instruct_15()
				return
			end
			addevent(46, 110, 0, nil, nil, 0)
			instruct_2(259, 1)
			say("蛇胆到手了，回去吧。")

		else
			say("这蛇看上去是异种灵物，长到如此巨大实属不易，我们还是把它驯服了再作打算吧。")
			say("蛇性贪吃，只需要用食物诱之即可。", 61)
			say("好，我恰好带了只叫花鸡，且用它来试试。")
			instruct_2(18, -1)
			TalkEx("当下肉香四溢，那巨蟒闻之心喜，渐渐靠了近来。", 0, 2)
			say("就是现在！", 61)
			if WarMain(298) == false then 
				instruct_15()
				return
			end
			addevent(46, 110, 0, nil, nil, 0)
			say("费了好大劲，终于把它驯服了。只是那解毒药又怎么办？")	
			say("蛇涎也可解毒，只是需要内力蒸腾取其精华，既然兄弟不想杀之取胆，少不了要辛苦一番了。", 61)		
			say("也罢，帮人帮到底，不需伤了这家伙的性命也算一桩造化。")	
			dark()
			light()
			AddPersonAttrib(zj(), "内力最大值", -500)
			tb(JY.Person[zj()]["姓名"].."内力最大值减少！")
			say("成了，回去救人吧。")		
			setPet(3)
			tb(addfame(3))
			RW.type = 1
		end
	else
		TalkEx("思索之间，只见那巨蟒慢慢游向洞穴深处。", 0, 2)
		say("再不动手它就要跑了，直接上吧！")	
		TalkEx("那巨蟒受了惊，仰长了脖颈，发出了一阵嘶声。", 0, 2)
		say("不好！那家伙在呼唤同类！")	
		if WarMain(297) == false then 
			instruct_15()
			return
		end
		addevent(46, 110, 0, nil, nil, 0)
		instruct_2(259, 1)
		say("终于把蛇胆弄到手了，回去吧。")	
			if MPPD(0) == 0 then 
	       say("好小子，有一套嘛",60)
           say("我看了多时了，不错不错，不妨来我这做一个蛇奴吧。",60)
		    say("有我罩着你，你可以横着走了。",60)
	      if DrawStrBoxYesNo(-1, -1, "要加入白驼山庄么？", C_WHITE, 30) == true then 
	       say("多谢庄主收留。",0)
	       say("哈哈，这是我们白驼山的心法典籍，拿去看看吧",60)
	       instruct_2(73,1) 
	       say("多谢老爷",0)
	        say("哈哈，不错不错，很对我胃口",60)
	       JoinMP(0, 8, 1)
		   else
		   	        say("哼，不识抬举的东西",60)
	     end
		 end		
	end
end

nEvent[103] = function()
	say("来来来，小店今天举行射击比赛，奖品丰富，人人有份，走过路过不要错过啊！", 220, 0, "小二") 	
	say("请问这是怎么个比法？")
	say("此地盛产雪雕，羽坚体捷，常人难以猎之。今天的比赛就是以此物为目标，但需求伤其翼却不伤其性命，否则倒是不美。", 220, 0, "小二") 	
	say("客官看起来也是个武学行家，有没有兴趣来试下身手？报名费只需两百五十两。", 220, 0, "小二") 
	local t = false
	if JY.Person[zj()]["轻功"] >= 350 and hasppl(55) and JY.GOLD >= 500 and yesno("要参加吗？") then
		t = true
	end
	if not t then
		say("在下功夫不济，如何敢献丑，还是在旁观战好了。")
		dark()
		light()
		say("常听北人能骑善射，近日一见果然名下不虚。这雕儿腾挪的身法轻灵无比，似乎与我所学相应，天公造物之道果然神妙。")
		AddPersonAttrib(zj(), "轻功", 10)
		tb(JY.Person[zj()]["姓名"].."轻功提升！")
	else		
		say("看郭兄弟这个样子，倒是跃跃欲试了？")
		say("哈哈，别的不敢说，我自小在草原长大，箭术乃生平最自豪的事之一。怎么样，咱两个一起去试试？", 55)
		say("好，我就陪兄弟比这一趟。")
		instruct_2(174, -500)
		say("好咧，客官请稍待，比赛马上开始。", 220, 0, "小二") 			
		dark()
		light()
		say("比赛正式开始，一共是四位选手，谁先把那雪雕射下则获胜！", 220, 0, "小二") 	
		local tt = false
		local pid = 583
		local pid2 = 584
		randomstats(pid, nil, "猎手")
		randomstats(pid2, nil, "猎手")
		
		instruct_21(55)
		if WarMain(299) == false then --xxx
			tt = false
		else
			tt = true
		end
		instruct_10(55)
		if not tt then
			say("啊呀，这次的雪雕不同往常，竟然毫发无伤。比赛结束，可惜无人获胜！", 220, 0, "小二") 	
			say("那雪雕竟然如此灵敏，我于箭术一道钻研半生，这次可真是大开眼界。", 55)
			say("哈哈，且让它去，咱们回去再努力修炼一番，下次一定能把它打下来。走，我们喝酒去！")
		else
			if RW.type == 1 then --xxx
				say("哈哈，兄弟好本事！", 55)
				say("这也是多亏了郭兄弟平常的指教。")
				say("恭喜这位大爷，这是您的奖品。", 220, 0, "小二") 		
				rewardRW(5)
				tb(addfame(5))
				addHZ(26)
				if not hasPet() then
					say("看这雕儿伤势，只需几天就能复原，兄弟如能把它收服，以后大有用处。", 55)
					setPet(1)
				end
			elseif RW.type == 2 then
				say("郭兄弟果然好本事，竟然仅以箭风就把那雕儿震了下来！")
				say("哈哈，这雕儿也是不凡，竟然毫发无伤，落地后竟能立刻振翼急遁。可惜啊，若是能擒来送给蓉儿，她一定开心。", 55)	
				say("恭喜这位大爷，这是您的奖品。", 220, 0, "小二") 		
				rewardRW(2)
				tb(addfame(2))
			JY.Person[55]["武功4"] = 148
	        JY.Person[55]["武功等级4"] = 999
			setJX(55,1)
			say("弓箭之道，我也有了新的领悟，我才是真正的射雕英雄。", 55)
			say("可以用降龙的气劲，桃花岛的功夫以及我大哥的拳理发动弓箭。", 55)				
			QZXS("郭靖称号觉醒,可使用白羽箭发动战意技【翔龙飞箭】")
			say("哈哈，我才是真正的射雕英雄。", 55)	
			say("哈哈，见识了郭兄如此箭术，也是不虚此行啊。走，喝酒去！")
			say("好，兄弟请！", 55)	
			else
				say("今日才知道天外有天，往后还需要加紧修行才是啊。", 55)
				say("哈哈，咱们虽然不胜，但见识了如此箭术，也是不虚此行啊。走，喝酒去！")
				say("好，兄弟请！", 55)				
			end
		end		
	end
	tb("任务结束！")
end

nEvent[104] = function()	
	local t = false
	say("赤练仙子，我们丐帮与你素无仇怨，为何为难我等二人！", 207, 0, "丐帮弟子") 	
	say("两位中了赤练神掌，那不用担心，只要将夺去的书赐还，贫道自会给两位医治。", 161)
	say("什么书？", 207, 0, "丐帮弟子") 	
	say("这本破书，说来嘛也不值几个大钱，贵帮倘若定然不还，原也算不了什么。贫道只向贵帮取一千条叫化的命儿作抵便了。", 161)
	say("（李莫愁出手狠辣，我应该去帮那二人一臂之力吗？）")
	if yesno("要出手吗？") then
		t = true
	end
	local pid = 161
	if not t then
		say("（丐帮人多势众，这附近就是洛阳分舵，我还是静观其变的好。）")
		dark()
		addevent(-2, 111, 0, -2, -2, 3530 * 2)
		light()
		say("在下耶律齐，全真派门下。仙姑下手过于狠毒，在下倒要讨教几招。", 619)
		say("嘿嘿，原来是全真教那帮贼道士的徒孙，看招！", 161)
		TalkEx("那少年虽然功夫不弱，但接战经历甚少，功力受年岁所限，四十余招后便落了下风", 0, 2)
		say("（好一个少年英侠，倒应该结交一下）耶律兄莫慌，我来助你！")
		say("哼，多管闲事，找死！", 161)
		if WarMain(300) == false then
			instruct_15()
			return
		end
		addevent(RW.targetscene, 110, 0, nil, nil, 0)
		say("好快的轻功，看来是拦不下她了。")
		say("多谢二位出手相助。", 207, 0, "丐帮弟子") 
		say("两位不必客气，我身上有解毒药，请立即服下。")
		dark()
		light()
		say("多谢少侠的解药，我两人要立刻赶往洛阳分舵把这件事告知帮中首脑，这就告辞了。这些礼物请笑纳。", 207, 0, "丐帮弟子") 
		addthing(18, 2)
		dark()
		light()
		say("这位兄台高姓大名？", 619)
		say("在下"..JY.Person[zj()]["姓名"].."，兄台刚才义举让小弟佩服，如不嫌弃，小弟做东请兄台喝酒如何。")
		say("好！那在下就却之不恭了。", 619)
		TalkEx("二人刚才经过刚刚一番并肩作战，早已惺惺相惜，一番交心后彼此引为知己。", 0, 2)
		if MPPD(0) == 0 then
	          say("不瞒兄台，我也算全真教一门的弟子，兄台与我一见如故。",619) 
	          say("不妨和兄台相互交流一下武学，相互印证一下。",619) 
			  say("如此甚好，但这涉及到兄台门下的武学机要，恐怕有窃师之嫌。",0) 
			  say("这有何妨，我师父素来游戏人间，也不拘泥于此。",619) 
			  say("不过兄台如此风趣豪迈，师父也会喜欢的，我看兄台也没加入什么门派，要不加入咱们全真教。",619) 
			  say("大家是为同门，也就不拘束了吧。",619) 
	    if DrawStrBoxYesNo(-1, -1, "要加入全真教么？", C_WHITE, 30) == true then 
	       say("耶律兄既然如此盛情，那小弟我也就却之不恭了",0) 
           say("哈哈，痛快，如此咱们就可以畅所欲言了",619) 
		   JoinMP(0,16,3)
			QZXS(JY.Person[0]["姓名"].."成为全真教弟子！")		   
	     end
	    end
		if JY.Person[zj()]["品德"] >= 70 then
			say("耶律兄既然尚未找到住处，来我小村暂住如何？")	
			say("好，那就麻烦兄弟了。", 619)
			dark()
			addevent(RW.targetscene, 111, 0, nil, nil, 0)
			setteam(619, 1)
			addthing(353)
			light()
		else
			say("耶律兄既然尚未找到住处，来我小村暂住如何？")	
			say("可惜愚兄俗事缠身，当我有空，一定再来找兄弟喝几杯！", 619)
			say("好，那就后会有期！")
			say("后会有期！", 619)	
			dark()
			addevent(RW.targetscene, 111, 0, nil, nil, 0)
			light()			
		end
	else
		say("住手！")
		say("臭小子，多管闲事！", 161)	
		if WarMain(301) == false then
			instruct_15()
			return
		end
		addevent(RW.targetscene, 110, 0, nil, nil, 0)				
		tb(addfame(3))
		say("我身上有解毒药，请两位立即服下。")		
		dark()
		light()
		say("多谢少侠出手相助，我两人要立刻赶往洛阳分舵把这件事告知帮中首脑，这就告辞了。这些礼物请笑纳。", 207, 0, "丐帮弟子") 
		addthing(18, 2)
		addthing(111, 1)
		dark()
		light()		
	end
	tb("任务结束！")
end

nEvent[105] = function()	
	say("找到了吗？", 589, 0, "唐萌浅")
	displayRW(2, RW.targetscene, RW.target)
	local t = true
	for i = 0, 13 do --28, 35 武骧金星：唐萌浅的任务改成找药
		if not hasthing(i) or thingnum(i) < 5 then
			t = false
			break
		end
	end
	if not t then
		do return end
	end
	for i = 0, 13 do --28, 35 武骧金星：唐萌浅的任务改成找药
		instruct_32(i, -5)
	end	
	say("做得不错，谢了~~这是你的奖励。", 589, 0, "唐萌浅")
	setRW(RW.event - 100, 1)
	rewardRW(2)
	displayRW(3, RW.scene, RW.location)		
	resetRW()
	addthing(352)
	if string.sub(JY.Person[0]["姓名"], 0, 2) == "唐" and MPPD(0) == 0 then 
		say("嗯？原来你也姓唐？看你的武功也算不错，我们唐门现在正在招收弟子，你有没有兴趣？", 589, 0, "唐萌浅") 
		if yesno("要加入唐门吗？") == false then
			say("不要就算了，这可是你的损失哦。", 589, 0, "唐萌浅")
		else
			say("好，从今天起你就是我们唐门的打杂，啊不，新弟子了。这里有些暗器心法，你慢慢钻研吧。", 589, 0, "唐萌浅")
			JoinMP(0, 9, 2)
			QZXS(JY.Person[0]["姓名"].."成为唐门弟子！")	
		end
	end
	if JY.Person[0]["轻功"] >= 600 and sixi(0,5) >= 200 then
		say("是说看你身手真的挺不错的，本小姐今天就好人做到底吧！",589,0,"唐萌浅")
		say("这里有我练「追魂无影」的一些心得，就给你吧",589,0,"唐萌浅")
		if DrawStrBoxYesNo(-1, -1, "要收下吗？", C_WHITE, 30) == true then
			QZXS("领悟追魂无影身法！")
			instruct_0();
			setLW2(191)
			say("哈哈，难得当个好人的感觉挺不错的",589,0,"唐萌浅")
		else
			say("哼，给脸不要脸！！",589,0,"唐萌浅")
			say("呜！！",0)
			JY.Person[0]["生命"] = 100
			JY.Person[0]["受伤程度"] = 100
			JY.Person[0]["中毒程度"] = 100
		end
	end	
	if JY.GOLD >= 30000 then
		if instruct_9() then
			say("(这家伙看起来呆头呆脑，不过好像很有钱。)",93)
			say("想请本小姐帮你的忙？唐家收费可是很贵的哟。",93)
			instruct_2(174, -30000)
			instruct_10(93)
			tb(JY.Person[93]["姓名"].."加入队伍")
			setteam(93, 0)			
			if MPPD(0) == 0 then
				say("这样吧，看你那么有诚意，本小姐就破例收你做跟班。", 93)
				if DrawStrBoxYesNo(-1, -1, "要做唐大小姐的跟班么？", C_WHITE, 30) == true then JoinMP(0, 9, 1) end
			end
		end
	end
	dark()
	light()		
end

nEvent[106] = function()	
	say("风天南，你作恶多端，害了钟阿四一门老小，你有何话可说！")
	say("哼，小子找死！", 637) 	
	if WarMain(316) == false then
		instruct_15()
		return
	end		
	light()
	bgtalk("突然数件暗器从门外飞来，护住了风天南，风天南见机得快，转身逃了。")
	dark()
	null(-2, 110)
	light()	
	say("......", 636) 	
	bgtalk("只见西南角上人影一闪，倏忽间失了踪迹。背影小巧苗条，似是女子模样")
	say("那女子是谁....好俊的功夫。只是为何她要救那恶人....")
	say("也罢，这次就暂时放过风天南，下次遇到他一定要他好看。")
	tb(addfame(3))
	tb("任务结束！")
	JY.Person[637]["攻击力"] = JY.Person[637]["攻击力"] + 50
	JY.Person[637]["防御力"] = JY.Person[637]["防御力"] + 50
	JY.Person[637]["轻功"] = JY.Person[637]["轻功"] + 50
	addevent(107, 21, 1, 1322, 1, 5926)
end

nEvent[107] = function()	
	say("这位姑娘，你为何一个人待在这阴暗的山洞里，这里到处都是蜘蛛，很危险的。")
	say("....", 631) 
	say("（为什么她看起来这么阴森森的感觉....不会吧难道她就是蜘蛛精？）")		
	dark()
	addevent(-2, 111, 0, 0, 0, 5304)
	light()
	say("终于找到你了！快点跟我们回去吧！", 301, nil, nil, 1)	
	say("（明教的人？这么说她不是妖怪了）等等，这样逼迫一个小姑娘，算什么好汉！")
	say("小子，这里没你说话的份，滚！", 301, nil, nil, 1)	
	if WarMain(319) == false then
		instruct_15()
		return
	end		
	null(-2, 111)
	light()
	say("姑娘你没事吧。")
	say("....我的蛛儿....我的蛛儿不见了....", 631) 	
	say("蛛儿？难道她养了只蜘蛛当宠物....")
	if hasthing(66) then
		say("（我记得从星宿派拿来的神木王鼎可以吸引诸般毒虫，姑且试试吧）小姑娘别急，我帮你找。")
		dark()
		light()
		say("啊，好多蜘蛛！")
		if WarMain(63) == false then
			instruct_15()
			return
		end				
		say("呼，是这只吧，小姑娘，给，你的蛛儿。")
		say("....谢谢。", 631)
		if not hasPet() and not instruct_20() then			
			say("小姑娘你一个人在这儿待着还是太危险了，那些人迟早会再找上门来的，你还是跟我们一起有个照应。")
			say("....好。", 631)
			dark()
			null(-2, 110)
			light()			
			instruct_10(631)
			setPet(5)
		else
			dark()
			null(-2, 110)
			light()
			say("咦，怎么就跑了....还留下一颗药丸....")
			addthing(256, 1)
		end
	else
		say("多一事不如少一事....我最怕就是蜘蛛了，先走为妙....")
		say("....我要去找我的蛛儿了。", 631)
		dark()
		null(-2, 110)
		light()
	end
	tb(addfame(3))
	tb("任务结束！")
end

nEvent[108] = function()	
	say("嗷嗷～", 613)
	say("这就是那只白猿吧，如果有什么东西可以吸引它的注意力就好了....")
	if hasthing(24) then
		say("我记得有人说过猴儿嗜酒，我就拿这即墨老酒试试....")
		addthing(24, -1)
		dark()
		light()
		say("....", 613)
		say("成功了！它好像醉倒了，要现在去捉拿它吗？")
		local t = true
		if hasPet() then
			t = false
		end
		if t then
			if not yesno("要捉它吗？") then
				t = false
			end
		end
		if t then
			say("！！！！！", 613)
			say("啊，它攻过来了！")
			if WarMain(320) == false then
				instruct_15()
				return
			end	
			null(-2, 110)
			light()
			say("呼，总算把它捉住了....")
			setPet(6)
	    else
			dark()
			addevent(-2, 111, 0, 0, 0, 9168)
			light()
			say("白公公，你怎么又来捣乱了。", 614)
			say("这位小姑娘，这只白猿原来是你的？")
			say("才不是呢，白公公总是来骑羊儿玩，把我的羊儿都吓跑了，我正在找老白呢。", 614)
			say("（老白又是谁....难道是羊的名字？这姑娘天真烂漫，似乎不通世事）别找了，我送你几只羊吧。")
			say("那就说好了哦，这样我们就有钱买米了～", 614)
			say("！！！！！", 613)
			say("白公公不要！", 614)
			JY.Person[613]["攻击力"] = JY.Person[613]["攻击力"] + 200
			JY.Person[613]["防御力"] = JY.Person[613]["防御力"] + 150
			JY.Person[613]["轻功"] = JY.Person[613]["轻功"] + 150				
			if WarMain(321) == false then
				instruct_15()
				return
			end	
			null(-2, 110)
			JY.Person[613]["攻击力"] = JY.Person[613]["攻击力"] - 200
			JY.Person[613]["防御力"] = JY.Person[613]["防御力"] - 150
			JY.Person[613]["轻功"] = JY.Person[613]["轻功"] - 150			
			light()		
			if hasthing(8) and hasthing(16) then
			   if JY.Person[zj()]["品德"] <= 99 then
			    say("啊！白公公受伤了，你这坏人。", 614)
				say("（！！！？？）")
			JY.Person[614]["攻击力"] = JY.Person[614]["攻击力"] + 250
			JY.Person[614]["防御力"] = JY.Person[614]["防御力"] + 250
			JY.Person[614]["轻功"] = JY.Person[614]["轻功"] + 250
			JY.Person[614]["武功2"] = 106
			JY.Person[614]["武功3"] = 107
			JY.Person[614]["武功4"] = 108
			JY.Person[614]["武功等级2"] = 999
			JY.Person[614]["武功等级3"] = 999
			JY.Person[614]["武功等级4"] = 999
				SetS(106, 63, 1, 0, 0)
				SetS(106, 63, 2, 0, 614)
				if WarMain(288) == false then
                  say("让你欺负白公公。", 614)
				  dark()
				  null(-2, 111)
				  light()
	            else
			JY.Person[614]["攻击力"] = JY.Person[614]["攻击力"] - 250
			JY.Person[614]["防御力"] = JY.Person[614]["防御力"] - 250
			JY.Person[614]["轻功"] = JY.Person[614]["轻功"] - 250
			JY.Person[614]["武功2"] = 0
			JY.Person[614]["武功3"] = 0
			JY.Person[614]["武功4"] = 0
			JY.Person[614]["武功等级2"] = 0
			JY.Person[614]["武功等级3"] = 0
			JY.Person[614]["武功等级4"] = 0
			      say("呼，打不过你。", 614)
			      say("（这姑娘武功当真奇高无比！）")
			      say("喂，别发呆啊，我们去买羊吧。", 614)
			      say("啊？")
			      if not instruct_20() then		
				      instruct_10(614)
				      dark()
				      null(-2, 111)
				      light()
			      else
				      say("你的队伍已满，我就回小村等你吧。", 614)
				      dark()
				      null(-2, 111)
				      setteam(614)
				      light()
			      end
				end
			   elseif JY.Person[zj()]["品德"] >= 100 then
			      say("呼，白公公今天好凶。", 614)
			      say("（这猿猴竟然似乎还身怀高深武功，世界之大真是无奇不有）")
				  say("这个灵药送于姑娘了。")
			      say("谢谢你这个给你。", 614)
			      say("啊？")
				  dark()
				  null(-2, 111)
				  light()
				  addHZ(142)
			   end
			else
			    say("啊！白公公受伤了，你这坏人。", 614)
				say("（！！！？？）")
                say("哼！不理你了。", 614)
				  dark()
				  null(-2, 111)
				  light()
			end
		end
	else
		say("！！！！！", 613)
		say("啊，它攻过来了！")
		if WarMain(320) == false then
			instruct_15()
			return
		end	
		null(-2, 110)
		light()
		say("呼，总算把它赶跑了....")
		addthing(15, 3)
		addthing(14, 3)
		addthing(24, 5)
	end
	tb(addfame(3))
	tb("任务结束！")	
end
nEvent[109] = function()	
	dark()
	addevent(-2, 111, 0, 0, 0, 9398)
	light()
	say3("各位朋友，在下姓穆名易，山东人氏。因小女年已及笄，尚未许得婆家，她曾许下一愿，不望夫婿富贵，但愿是个武艺超群的好汉，因此上斗胆比武招亲。凡年在二十岁上下，尚未娶亲，能胜得小女一拳一脚的，在下即将小女许配于他。襄阳是卧虎藏龙之地，高人好汉必多，在下行事荒唐，请各位多多包涵。”", 64, "穆易")
	if JY.Person[zj()]["性别"] == 0 and yesno("要打擂台吗？") then
		say("我来试试！")
		say("少侠请。", 635)
		JY.Person[635]["攻击力"] = JY.Person[635]["攻击力"] + 200
		JY.Person[635]["防御力"] = JY.Person[635]["防御力"] + 100
		JY.Person[635]["轻功"] = JY.Person[635]["轻功"] + 200
		if WarMain(337) == false then
			say3("这位小兄弟虽然功夫不弱，但可惜还不是小女的良配，真是对不住了。", 64, "穆易")
			say("唉，只怪我学艺不精....")
			dark()
			null(-2, 110)
			null(-2, 111)
			light()			
		else
			say("（满面红晕，低了头，双眼却悄悄来望）", 635)
			say("（也是红了脸）穆姑娘....")
			say3("好好，这位小兄弟武功精湛，我就把念慈托付给你了。", 64, "穆易")
			say("穆老请放心，我一定会照顾好穆姑娘的。")
			say3("哈哈，念慈现在有了依靠，老夫也可以放心去寻故友了。", 64, "穆易")
			dark()
			null(-2, 110)
			light()
			say("穆姑娘，我们走吧。")
			say("好....", 635)
			teammate(635)
			null(-2, 111)
			tb(addfame(2))
		end	
		JY.Person[635]["攻击力"] = JY.Person[635]["攻击力"] - 200
		JY.Person[635]["防御力"] = JY.Person[635]["防御力"] - 100
		JY.Person[635]["轻功"] = JY.Person[635]["轻功"] - 200			
		tb("任务结束！")	
	else
		dark()
		addevent(-2, 112, 0, 0, 0, 9400)
		light()
		say("让我来试试。", 616)
		say("公子请。", 635)
		bgtalk("两人武功都不弱，斗到急处，只见那公子满场游走，身上锦袍灿然生光；那少女进退趋避，红衫绛裙，似乎化作了一团红云。")
		say("姑娘小心啦。", 616)
		bgtalk("那公子久斗不下，突然哈哈一笑，再不相让，掌风呼呼，打得兴发，那少女再也欺不到他身旁三尺以内。")
		say("哎呀！", 635)
		bgtalk("少女不敌，眼见要跌下擂台，那公子右臂抄去，已将她抱在怀里。旁观众人又喝彩，又喧闹，乱成一片。")
		say("（羞得满脸通红）放开我！", 635)
		say("你叫我一声亲哥哥，我就放你。", 616)
		bgtalk("那少女急了，飞脚向他太阳穴踢去，要叫他不能不放开了手。那公子右臂松脱，举手挡架，反腕钩出，又已拿住了她踢过来的右脚。他这擒拿功夫竟得心应手，擒腕得腕，拿足得足。那少女更急，奋力抽足，脚上绣着红花的绣鞋竟离足而去，但总算挣脱了他怀抱，坐在地下，含羞低头，摸着白布袜子。那公子嘻嘻而笑，把绣鞋放在鼻边作势一闻。旁观的无赖子哪有不乘机凑趣之理，大声起哄。")
		say3("公子胜啦，请教尊姓大名？", 64, "穆易")
		say("不必说了吧，我赶着回家。", 616)
		say3("你既胜了小女，我有言在先，自然将女儿许配给你。终身大事，岂能马虎？", 64, "穆易")
		say("我们在拳脚上玩玩，倒也有趣。招亲嘛，哈哈，可多谢了！", 616)
		say3("你....你这....！", 64, "穆易")
		say("喂！你这样干不对啊！")
		say("关你屁事？走开！", 616)	
		JY.Person[616]["攻击力"] = JY.Person[616]["攻击力"] + 200
		JY.Person[616]["防御力"] = JY.Person[616]["防御力"] + 150
		JY.Person[616]["轻功"] = JY.Person[616]["轻功"] + 150			
		if WarMain(338) == false then
			instruct_15(0);   
			instruct_0();  
			do return; end		
		end
		JY.Person[616]["武功等级1"] = 400
		JY.Person[616]["攻击力"] = JY.Person[616]["攻击力"] - 200
		JY.Person[616]["防御力"] = JY.Person[616]["防御力"] - 150
		JY.Person[616]["轻功"] = JY.Person[616]["轻功"] - 150			
		say("哼，臭小子，小爷有事，今天算你走运！", 616)
		dark()
		null(-2, 112)
		light()
		say3("谢谢这位小兄弟替我父女俩出头，唉，念慈，我们走吧。", 64, "穆易")
		if (GetS(113,0,0,0) == 0 and PersonKF(zj(),68)) and sixi(zj(),4) >= 300 then
			say3("稍等，小老儿突然想起一事想请教少侠", 64, "穆易")
			say3("话说方才少侠用的是杨家枪法？", 64, "穆易")
			say("正是，老先生为何有此一问？")
			say3("没什么，只是觉得少侠年纪轻轻，这枪上功夫，却是老练的令人吃惊", 64, "穆易")
			say("老先生谬赞了，嘿嘿")
			say3("呵呵，小老儿练了一辈子的杨家枪法，可能都在少侠手下走不了三招", 64, "穆易")
			say3("何来谬赞一说", 64, "穆易")
			say3("方才承蒙少侠帮助。小老儿没什么好回报的", 64, "穆易")
			say3("这有一本意外得到的枪谱，小老儿武功太次，是看不懂也练不成了", 64, "穆易")
			say3("就给少侠参考看看？", 64, "穆易")
			if DrawStrBoxYesNo(-1, -1, "要收下吗？", C_WHITE, 30) == true then
				QZXS("杨家枪法融入了燎原枪意！！")
				setLW1(68)
				say("哈哈哈，我有望窥见枪之大道了！！")
				say("小子对老先生之大恩实在难以言谢。")
				say("若日后老先生有需要，就来小村寻我，小子必定帮忙！")
				say3("哈哈，好说好说", 64, "穆易")
			else
				say("（...实在很难相信那会是什么好东西）")
				say("（若反而误我武道就不好了）")
				say3("（注意到你脸色难看）少侠无须苦恼，小老儿不过随口一提", 64, "穆易")
				say3("之后若江湖上有缘，小老儿再行报答", 64, "穆易")
				say("...老先生保重")
			end
		end	
		dark()
		null(-2, 110)
		null(-2, 111)
		for i = 4, 7 do
			addevent(108, i, 1, 1351, 1, -2)
		end
		light()
		daode(2)
		tb(addfame(2))
		tb("任务结束！")	
	end
end
nEvent[110] = function()	

end
nEvent[111] = function()	

end
nEvent[112] = function()	

end