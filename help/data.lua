--/////////////////////////////
--	data 一些数据处理相关函数		主要因为字段扩充导致的
--/////////////////////////////

-- 下面这部分是旧的实现方式所用的，目前不用了、可以注释了
-- 扩充的字段名 放在这个table里
Expand_Person_Padded_keys				= {}
local function Expand_Person_Padded_keys_init()
	Expand_Person_Padded_keys["经验2"]	= 1
	local no_use_counter	= 100
	for i = 1, HHH_GAME_SETTING["PADDED_NOUSE_2B_FIELD_COUNT"]	 do				-- 提供60个 uint16 字段，供将来扩充用
		no_use_counter	= no_use_counter + 1
		local key				= "无用" .. (no_use_counter)
    Expand_Person_Padded_keys[key]	= 1
    
    --help.util.debug("[Expand_Person_Padded_keys_init] [Expand_Person_Padded_keys]["..key.."]="..Expand_Person_Padded_keys[key])
  end
  for i = 1, HHH_GAME_SETTING["PADDED_NOUSE_4B_FIELD_COUNT"]		 do			-- 提供20个 uint16 字段，供将来扩充用
  	no_use_counter	= no_use_counter + 1
  	local key				= "无用" .. (no_use_counter)
    Expand_Person_Padded_keys[key]	= 1
    
    --help.util.debug("[Expand_Person_Padded_keys_init] [Expand_Person_Padded_keys]["..key.."]="..Expand_Person_Padded_keys[key])
  end
  
	for i = 10 + 1, HHH_GAME_SETTING["WG_COUNT_MAX_LIMIT"] do
		Expand_Person_Padded_keys["武功" .. i]		= 1
		Expand_Person_Padded_keys["武功等级" .. i]	= 1
		
		--help.util.debug("[Expand_Person_Padded_keys_init] [Expand_Person_Padded_keys][武功		" .. i.."]="..Expand_Person_Padded_keys["武功" .. i])
		--help.util.debug("[Expand_Person_Padded_keys_init] [Expand_Person_Padded_keys][武功等级" .. i.."]="..Expand_Person_Padded_keys["武功等级" .. i])
	end
	
	--help.util.debug("[Expand_Person_Padded_keys_init] size="..#Expand_Person_Padded_keys)
end
local function Expand_isPersonPaddedKeys(key)
	if key~= nil and Expand_Person_Padded_keys[key] ~= nil then
		return true
	end
	return false
end

local function Expand_getPersonPaddedDataLength()
	local wugongNumber_added	= HHH_GAME_SETTING["WG_COUNT_MAX_LIMIT"] - 10
	local size	=  4																					-- 因新经验字段而导致的变化, 原有的经验只有2个字节，上限65535，因为要将等级上升到99，所以经验值要扩充
	size 				= size + 2 * HHH_GAME_SETTING["PADDED_NOUSE_2B_FIELD_COUNT"]	-- 每个人再预留一些字段，以备将来扩充, key 为 无用101--无用160，都是uint16类型的，其中前6个已经用于人物的天赋内功外功轻功，107,108用于设置轻功运功
	size 				= size + 4 * HHH_GAME_SETTING["PADDED_NOUSE_4B_FIELD_COUNT"]	-- 每个人再预留一些字段，以备将来扩充, key 为 无用161--无用180，都是 int32类型的
	size				= size + wugongNumber_added * (2 + 2)			-- 因单人武功数量扩充而导致的位移变化，每个武功4字节，前2字节是武功number，后2字节是该武功的修炼等级
  
  return			size
end

--/////////////////////////////
--		打印二进制字节数组 内容，以便进行读档存档的比较
--/////////////////////////////
local function dumpBytes(bytes, startOffset, length)
	local listContents = {}
	if bytes then
    local row_number	= 16	-- 16 bytes per line
    local line_max		= math.modf(length/row_number)
    if row_number * line_max < length then
    	line_max = line_max + 1
    end
    
    for line = 1, line_max do
    	local loop_start	= startOffset + (line - 1) * row_number
    	local loop_length	=	row_number
    	if line * row_number > length then
    		loop_length			=	length - (line - 1) * row_number
    	end
    	local loop_v			= ""
    	--local loop_byteget= ""
    	
    	for row = 1, loop_length/2 do
    		local r = Byte.getu16(bytes, loop_start + (row - 1) * 2)
    		local t = {string.byte(r)}
    		
	      for _, b in ipairs(t) do
	        local val = string.format("%02X", b)
	        
	        loop_v = loop_v..val
	        --loop_byteget = loop_byteget..","..tostring(b)
	      end
      end
      listContents[ line ]	= loop_v
      --help.util.debug("[dumpBytes] [1]"..loop_byteget)
      --help.util.debug("[dumpBytes] [2]"..loop_v)
		end
  end
  return listContents
end
local function dumpPersonBytes(pid, tag, compare)
	if pid >= 0 then
		--help.util.debug(tag.."[start_offset="..tostring(CC.PersonSize * pid).."][length="..tostring(CC.PersonSize).."] ************************************")
		local listContents1	= dumpBytes(JY.Data_Person,		CC.PersonSize * pid, CC.PersonSize)
		--[[
		if compare ~= nil and compare == true and JY.Data_Person2 ~= nil then
			local listContents2	= dumpBytes(JY.Data_Person2,	CC.PersonSize * pid, CC.PersonSize)
			help.util.debug(tag.."["..pid.."] #listContents1="..#listContents1..",#listContents2="..#listContents2)
			if #listContents1 ~= #listContents2 then
				help.util.debug(tag.."["..pid.."] [ERROR 1]")
			else
				for i = 1, #listContents1 do
					local l1	= listContents1[i]
					local l2	= listContents2[i]
					if l1 == nil or l2 == nil then
						help.util.debug(tag.."["..i.."] [ERROR 2] l1==nil or l2==nil")
					else
						if l1 ~= l2 then
							help.util.debug(tag.."["..i.."] [ERROR 3] l1="..l1.." , l2="..l2)
						end
					end
				end
			end
		end
		]]--
	end
end

local function dumpPersons(tag, compare)
	--help.util.debug(tag.." ************************************")
	for i = 0, 10 do	--	JY.PersonNum - 1
		dumpPersonBytes(i, "Person["..tostring(i).."]", compare)
	end
end

--/////////////////////////////
--			确保 新的补充存档文件是一定存在的，因为 提供的C写文件帮助方法是以append方式来打开文件的，所以不确保该文件存在的话，无法保存
--/////////////////////////////
local function assert_store_file_exist()
	local filePathArray = {}
	filePathArray	=	CC.R_PADFilename
	
	for i = 1, #filePathArray do
		if not help.file.is_file_exists(filePathArray[i]) then
			help.file.writefile(filePathArray[i], "", nil)
		end
	end
end

--/////////////////////////////
--	创建一个二进制byte数组，从 数据文件加载数据到这个字节数组
--	    对于新建游戏情形, 这个数据文件是初始化数据文件（实际这个文件是不存在的，我也不准备生成）
--			或  对于读档情形, 这个数据文件是附加的存档文件（读对应存档的附加文件）
--/////////////////////////////
local function Expand_load_PaddedPersonData_1step(id)
	--help.util.debug("[Expand_load_PaddedPersonData_1step] [1.1] [JY.PersonNum="..JY.PersonNum.."] [CC.PaddedPersonSize="..CC.PaddedPersonSize.."] [size="..CC.PaddedPersonSize * JY.PersonNum.."]")
	--help.util.memory_monitor()

	JY.Data_Person_Padded	= Byte.create(CC.PaddedPersonSize * JY.PersonNum)
	local fileExist			= help.file.is_file_exists(CC.R_PADFilename[id])
	if fileExist then
		--help.util.debug("[HH_load_PaddedPersonData_1step] [1.2] [fileExist="..tostring(fileExist).."]")
  		Byte.loadfile(JY.Data_Person_Padded, CC.R_PADFilename[id], 0, CC.PaddedPersonSize * JY.PersonNum)
  		help.util.debug("[HH_load_PaddedPersonData_1step] [1.3] [fileExist="..tostring(fileExist).."]")
	end
  
	--dumpPersons("[LOAD_FROM_FILE]", false)
  
	help.util.memory_monitor()
	--help.util.debug("[Expand_load_PaddedPersonData_1step] [1.5]")
	return fileExist
end
local function Expand_load_PaddedPersonData_2step(fileExist)
	--help.util.debug("[Expand_load_PaddedPersonData_2step] [1.1] [fileExist="..tostring(fileExist).."]")
	--help.util.memory_monitor()
	
	if not fileExist then
		help.util.debug("[Expand_load_PaddedPersonData_2step] [1.2] [fileExist="..tostring(fileExist).."]")
  	
		for i = 0, JY.PersonNum - 1 do
			JY.Person[i]["经验2"] = 0
			JY.Person[i]["经验2"] = JY.Person[i]["经验"]

			local no_use_counter = 100
			for h1 = 1, HHH_GAME_SETTING["PADDED_NOUSE_2B_FIELD_COUNT"] do
				no_use_counter = no_use_counter + 1
				JY.Person[i]["无用" ..(no_use_counter)] = 0
			end
			for h1 = 1, HHH_GAME_SETTING["PADDED_NOUSE_4B_FIELD_COUNT"] do
				no_use_counter = no_use_counter + 1
				JY.Person[i]["无用" ..(no_use_counter)] = 0
			end
			for h2 = 11, HHH_GAME_SETTING["WG_COUNT_MAX_LIMIT"] do
				JY.Person[i]["武功" .. h2] = -1
				JY.Person[i]["武功等级" .. h2] = -1
			end

			--local name = JY.Person[i]["姓名"]
			--local level = JY.Person[i]["等级"]
			--help.util.debug("[2step] [JY.Person[" .. i .. "][" .. name .. "][等级]=" .. level .. "]")
		end
	end
  
	--help.util.memory_monitor()
	--help.util.debug("[Expand_load_PaddedPersonData_2step] [1.5] [fileExist="..tostring(fileExist).."]")
end

--/////////////////////////////
--		涉及 从刚从文件读出的二进制字节数组 的指定位置 第一次取出的值 , 是对字节数组的操作
--/////////////////////////////
--从数据的结构中翻译数据
--data 二进制数组
--offset data中的偏移
--t_struct 数据的结构，在jyconst中有很多定义
--key  访问的key
local function b_GetDataFromStruct_new(data, offset, t_struct, key)
	local t = t_struct[key]
  local r = nil
  
  if t[2] == 0 then
    r = Byte.get16(data, t[1] + offset)
    --if offset == 228 * 7 then
    --	help.util.debug("[b_GetDataFromStruct_sub][0][offset="..offset.."][t_1="..t[1].."][key="..key.."][val="..r.."]")
    --end
  elseif t[2] == 1 then
    r = Byte.getu16(data, t[1] + offset)
    --help.util.debug("[b_GetDataFromStruct_sub][1][offset="..offset.."][t_1="..t[1].."][key="..key.."][val="..r.."]")
  elseif t[2] == 2 then
    if CC.SrcCharSet == 0 then
      r = lib.CharSet(Byte.getstr(data, t[1] + offset, t[3]), 0)
      --help.util.debug("[b_GetDataFromStruct_sub][2][offset="..offset.."][t_1="..t[1].."][key="..key.."][val="..r.."]")
    end
  elseif t[2] == 5 then
  	r = Byte.get32(data, t[1] + offset)
  else
    r = Byte.getstr(data, t[1] + offset, t[3])
  end

  return r, t
end
local function b_SetDataFromStruct_new(data, offset, t_struct, key, v)
	local t = t_struct[key]
	if t[2] == 0 then
    Byte.set16(data, t[1] + offset, v)
    --if offset == 228 * 7 then
    --	help.util.debug("[b_SetDataFromStruct2_sub] [0] [offset="..offset.."][t_1="..t[1].."][key="..key.."][v="..tostring(v))
    --end
  elseif t[2] == 1 then
    Byte.setu16(data, t[1] + offset, v)
  elseif t[2] == 2 then
    local s = nil
    if CC.SrcCharSet == 0 then
      s = lib.CharSet(v, 1)
    else
      s = v
    end
    Byte.setstr(data, t[1] + offset, t[3], s)
  elseif t[2] == 5 then
    Byte.set32(data, t[1] + offset, v)
  else
  	Byte.setstr(data, t[1] + offset, t[3], v)
  end
end


--///////////////////////////////////////////////
--		从 二进制文件对应的字节数组  读入数据，进行转化，再存入 Person数组中
--///////////////////////////////////////////////
local function Expand_copyPersonData_b2m(personTable, i, typeIn, isNewGame)
	if typeIn == 1 then
		-- 不作任何转码，好像是对的呀
		for ii,vv in pairs(CC.Person_S) do
			local v0, t			= b_GetDataFromStruct_new(JY.Data_Person, i * CC.PersonSize, CC.Person_S, ii)
			personTable[ii]	= v0
	    
			--if i <= 10 and ii ~= nil and type(ii) == "string" 
			--	and (ii == "姓名" or ii == "外号" or ii == "经验" or ii == "资质" or ii == "性别" or ii == "等级" 
			--		or ii == "武功1" or ii == "武功等级1" or ii == "武功2" or ii == "武功等级2" or ii == "武功3" or ii == "武功等级3" ) then
			--	help.util.debug("[copy] 2 Person["..i.."]["..ii.."]=["..tostring(personTable[ii]).."]")
			--end
		end

	elseif typeIn == 2 then
		for ii,vv in pairs(CC.PaddedPerson_S) do
			personTable[ii] = b_GetDataFromStruct_new(JY.Data_Person_Padded, i * CC.PaddedPersonSize, CC.PaddedPerson_S, ii)
		end
	end
end
--///////////////////////////////////////////////
--		从 Person数组  读入数据，进行转化，再存入 二进制文件对应的字节数组中
--///////////////////////////////////////////////
local function Expand_copyPersonData_m2b(personTable, i, typeIn)
	if typeIn == 1 then
		for ii,vv in pairs(CC.Person_S) do
			local v0	= personTable[ii]
			b_SetDataFromStruct_new(JY.Data_Person, i * CC.PersonSize, CC.Person_S, ii, v0)
			
			--if i <= 10 and ii ~= nil and type(ii) == "string" 
			--	and (ii == "姓名" or ii == "外号" or ii == "经验" or ii == "资质" or ii == "性别" or ii == "等级" 
			--		or ii == "武功1" or ii == "武功等级1" or ii == "武功2" or ii == "武功等级2" or ii == "武功3" or ii == "武功等级3" ) then
			--	help.util.debug("[paste] 2 Person["..i.."]["..ii.."]=["..tostring(personTable[ii]).."][v0="..tostring(v0).."]")
			--end
		end
	elseif typeIn == 2 then
		for ii,vv in pairs(CC.PaddedPerson_S) do
			b_SetDataFromStruct_new(JY.Data_Person_Padded, i * CC.PaddedPersonSize, CC.PaddedPerson_S, ii, personTable[ii])
		end
	end
end

--///////////////////////////////////////////////
--		下面是调用上面函数的 高级函数
--///////////////////////////////////////////////
local function Expand_copy_from_bytes_to_PersonDataArray(personsTable, isNewGame)
	for i = 0, JY.PersonNum - 1 do
    personsTable[i] = {}
    Expand_copyPersonData_b2m(personsTable[i], i, 1, isNewGame)
    Expand_copyPersonData_b2m(personsTable[i], i, 2, isNewGame)
  end
end
local function Expand_copy_from_PersonDataArray_to_bytes(id)
	for i = 0, JY.PersonNum - 1 do
    Expand_copyPersonData_m2b(JY.Person[i], i, 1)
    Expand_copyPersonData_m2b(JY.Person[i], i, 2)
    --help.util.debug("[Expand_copy_from_PersonDataArray_to_bytes] ["..i.."]")
  end
end

-- 纯新方法
local function load_person_data_new(id)
	local fileExist	= Expand_load_PaddedPersonData_1step(id)
	Expand_copy_from_bytes_to_PersonDataArray(JY.Person, id == 0)
	Expand_load_PaddedPersonData_2step(fileExist)

	JY.Data_Person			= nil		--release the memory
	JY.Data_Person_Padded	= nil
	help.util.memory_monitor()
end

-- 可新旧对比，别用了，后来又改了不少
local function load_person_data(id)
	local file_exist	= Expand_load_PaddedPersonData_1step(id)		--需要先获得JY.PersonNum，再执行附加人物数据的加载
	Expand_copy_from_bytes_to_PersonDataArray(JY.Person)				--开始也是改meta，但不知是闭包太多还是什么原因，经常未知原因闪退，所以改成直接转化成lua的table了，不再二进制访问
	--local testMap = {}
	--Expand_copy_from_bytes_to_PersonDataArray(testMap)
	--[[
  for i = 0, JY.PersonNum - 1 do
    --testMap[i]={}
    JY.Person[i] = {}

    local meta_t = {
    		__index			= function(t, k)
    										if Expand_isPersonPaddedKeys(k) then
    											return help.data.b_GetDataFromStruct(JY.Data_Person_Padded, i * CC.PaddedPersonSize, CC.PaddedPerson_S, k)
    										else
    											return GetDataFromStruct(JY.Data_Person, i * CC.PersonSize, CC.Person_S, k)
      									end
    									end, 
    		__newindex	= function(t, k, v)
    										if Expand_isPersonPaddedKeys(k) then
    											help.data.b_SetDataFromStruct(JY.Data_Person_Padded, i * CC.PaddedPersonSize, CC.PaddedPerson_S, k, v)
    										else
    											SetDataFromStruct(JY.Data_Person, i * CC.PersonSize, CC.Person_S, k, v)
      									end
    									end}
    setmetatable(JY.Person[i], meta_t)
	  --setmetatable(testMap[i], meta_t)
  end
  ]]--
  
  Expand_load_PaddedPersonData_2step(file_exist)						--对于新建游戏或旧格式的存档，需要进行人物经验数据的复制 和增加武功数据的初始化
  --help.util.debug("[data] [load_person_data] [end]")
end

local function store_person_data(id, origindata_fileOffset)
	JY.Data_Person			= Byte.create(CC.PersonSize			* JY.PersonNum)
	JY.Data_Person_Padded	= Byte.create(CC.PaddedPersonSize	* JY.PersonNum)

	Expand_copy_from_PersonDataArray_to_bytes(id)
	--dumpPersons("[SAVE_TO_FILE  ]", true)
	Byte.savefile(JY.Data_Person,			CC.R_GRPFilename[id], origindata_fileOffset,	CC.PersonSize 		* JY.PersonNum)
	Byte.savefile(JY.Data_Person_Padded,	CC.R_PADFilename[id], 0,						CC.PaddedPersonSize	* JY.PersonNum)

	JY.Data_Person			= nil		--release the memory
	JY.Data_Person_Padded	= nil
	help.util.memory_monitor()
end

help.data = {
	Expand_Person_Padded_keys_init		= Expand_Person_Padded_keys_init,
	Expand_getPersonPaddedDataLength	=	Expand_getPersonPaddedDataLength,
	assert_store_file_exist						=	assert_store_file_exist,
	load_person_data									= load_person_data,
	load_person_data_new							=	load_person_data_new,
	store_person_data									= store_person_data
}

return help.data