-- 本文件为别人开发的一些库功能

--根据首字节获取UTF8需要的字节数
local function GetUTF8CharLength(ch)
    local utf8_look_for_table = {
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
        2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 1, 1,
    }
    return utf8_look_for_table[ch]
end

--根据UTF8流获取字符串长度
--GetUTF8Length("一二三四五六七") 返回7
local function GetUTF8Length(str)
    local len = 0
    local ptr = 1
    repeat
        local char = string.byte(str, ptr)
        local char_len = GetUTF8CharLength(char)
        len = len + 1
        ptr = ptr + char_len
    until(ptr>#str)
    return len
end

--截取UTF8字符串
--SubUTF8String("一二三四五六七",1,3) 返回一二三
local function SubUTF8String(str, begin, length)
    begin = begin or 1
    length = length or -1 --length为-1时代表不限制长度
    local ret = ""
    local len = 0
    local ptr = 1
    repeat
        local char = string.byte(str, ptr)
        local char_len = GetUTF8CharLength(char)
        len = len + 1

        if len>=begin and (length==-1 or len<begin+length) then
            for i=0,char_len-1 do
                ret = ret .. string.char( string.byte(str, ptr + i) )
            end
        end

        ptr = ptr + char_len
    until(ptr>#str)
    return ret
end

--[[
local function test(str, len)
  local ret = {}
  for i=1,math.ceil(GetUTF8Length(str)/len) do
      ret[i] = SubUTF8String(str, (i-1)*len + 1, len)
  end
  return ret
end

local str = "游戏程序员们是一群对技术最精益求精、心理素质最好、工作最勤奋的人!"
	for k,v in pairs(test(str, 1))do
	print(k,v)
end
]]--

local function string_ltrim(str)
    return string.gsub(str, "^[ \t\n\r]+", "")
end

local function string_rtrim(str)
    return string.gsub(str, "[ \t\n\r]+$", "")
end

local function string_trim(str)
    str = string.gsub(str, "^[ \t\n\r]+", "")
    return string.gsub(str, "[ \t\n\r]+$", "")
end

--功能：分割字符串
--参数：带分割字符串，分隔符
--返回：字符串表
local function string_split(str, delimiter)
    str = tostring(str)
    delimiter = tostring(delimiter)
    if (delimiter=='') then return false end
    local pos,arr = 0, {}
    -- for each divider found
    for st,sp in function() return string.find(str, delimiter, pos, true) end do
        table.insert(arr, string.sub(str, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(str, pos))
    return arr
end

--功能：统计字符串中字符的个数
--返回：总字符个数、英文字符数、中文字符数
local function string_count(str)
  local tmpStr=str
  local _,sum=string.gsub(str,"[^\128-\193]","")
  local _,countEn=string.gsub(tmpStr,"[%z\1-\127]","")
  return sum,countEn,sum-countEn
end

--功能：计算字符串的宽度，这里一个中文等于两个英文
local function string_width(str)

  local _,en,cn=string_count(str)
  return cn*2+en

  --return GetUTF8Length(str)
end

-- 功能: 把字符串扩展为长度为len,居中对齐, 其他地方以filledChar补齐
-- 参数: str 需要被扩展的字符、数字、字符串表，len 被扩展成的长度，
--       filledChar填充字符，可以为空
local function string_tocenter(str, len, filledChar)
  local function tocenter(str,len,filledChar)
      str = tostring(str);
      filledChar = filledChar or " ";
      local nRestLen = len - string_width(str); -- 剩余长度
      local nNeedCharNum = math.floor(nRestLen / string_width(filledChar)); -- 需要的填充字符的数量
      local nLeftCharNum = math.floor(nNeedCharNum / 2); -- 左边需要的填充字符的数量
      local nRightCharNum = nNeedCharNum - nLeftCharNum; -- 右边需要的填充字符的数量
       
      str = string.rep(filledChar, nLeftCharNum)..str..string.rep(filledChar, nRightCharNum); -- 补齐
      return str
  end
  if type(str)=="number" or type(str)=="string" then
      if not string.find(tostring(str),"\n") then
        return tocenter(str,len,filledChar)
      else
        str=string_split(str,"\n")
      end
  end
  if type(str)=="table" then
    local tmpStr=tocenter(str[1],len,filledChar)
    for i=2,#str do
      tmpStr=tmpStr.."\n"..tocenter(str[i],len,filledChar)
    end
    return tmpStr
  end

end

local function string_2side(strLeft, strRight, len, filledChar)
  local function twoside(strLeft, strRight, len, filledChar)
	strLeft					= tostring(strLeft);
    strRight				= tostring(strRight);
    filledChar  			= filledChar or " ";
    local nRestLen  		= len - string_width(strLeft) - string_width(strRight); -- 剩余长度
    local nNeedCharNum		= math.floor(nRestLen / string_width(filledChar));					-- 需要的填充字符的数量
    local strMiddle			= ""
    if nRestLen > 0 then
    	strMiddle			= string.rep(filledChar, nNeedCharNum)
    end
    local str = strLeft..strMiddle..strRight;     							-- 补齐
    return str;
  end
  if (type(strLeft)=="number" or type(strLeft)=="string") and (type(strRight)=="number" or type(strRight)=="string") then
    return twoside(strLeft, strRight, len, filledChar)
  end
end

local function startswith(str, substr)
    if str == nil or substr == nil then
        return false, "the string or the sub-stirng parameter is nil"
    end
    if string.find(str, substr, nil, true) ~= 1 then
    		--help.util.debug("[startswith] find ["..substr.." in "..str.." result=false")
        return false
    else
    		--help.util.debug("[startswith] find ["..substr.." in "..str.." result=true")
        return true
    end
end
local function endswith(str, substr)
    if str == nil or substr == nil then
        return false, "the string or the sub-string parameter is nil"
    end
    local str_tmp = string.reverse(str)
    local substr_tmp = string.reverse(substr)
    if string.find(str_tmp, substr_tmp, nil, true) ~= 1 then
        return false
    else
        return true
    end
end

local function split2Number(str, splitter)
	local first 			= nil
	local second			= nil
	local arrayResult	= string_split(str, splitter)
	--help.util.debug("[split2Number] 0.1 str="..str..", splitter="..splitter..", arrayResult="..type(arrayResult)..", #arrayResult="..#arrayResult)
	if arrayResult ~= nil and arrayResult ~= false and type(arrayResult) == "table" and #arrayResult >= 2 then
		--help.util.debug("[split2Number] 0.2 str="..str..", splitter="..splitter..", arrayResult="..type(arrayResult))
		if arrayResult[1] ~= nil and arrayResult[2] ~= nil then
			--help.util.debug("[split2Number] 0.3 str="..str..", splitter="..splitter..", arrayResult="..type(arrayResult))
			local v1= string_trim(arrayResult[1])
			local v2= string_trim(arrayResult[2])
			first 	= tonumber(v1)
			second	= tonumber(v2)
			
			--help.util.debug("[split2Number] 0.5 str="..str..", splitter="..splitter..", first="..first..", second="..second)
		end
	end
	return first, second
end

local function string_widthSingle(inputstr)
    -- 计算字符串宽度
    -- 可以计算出字符宽度，用于显示使用
		local lenInByte = #inputstr
		local width = 0
		local i = 1
    while (i<=lenInByte) do
        local curByte = string.byte(inputstr, i)
        local byteCount = 1;
        if curByte>0 and curByte<=127 then
            byteCount = 1                                               --1字节字符
        elseif curByte>=192 and curByte<223 then
            byteCount = 2                                               --双字节字符
        elseif curByte>=224 and curByte<239 then
            byteCount = 3                                               --汉字
        elseif curByte>=240 and curByte<=247 then
            byteCount = 4                                               --4字节字符
        end
        byteCount = 2																										--utf16?
        local char = string.sub(inputstr, i, i+byteCount-1)
				--help.util.debug("["..width.."] ["..byteCount.."] "..char)                                                   --看看这个字是什么
        i = i + byteCount                                    						-- 重置下一字节的索引
        width = width + 1                                    						-- 字符的个数（长度）
		end
		--help.util.debug("[string_widthSingle] ["..inputstr.."] [width="..width.."]")
    return width
end
local function pad_string(str, pos, len, pad_char, nil_pad_char, is_nil_repeat, notHasChinese)
	
	pad_char							= pad_char or " "
	nil_pad_char					= nil_pad_char or pad_char
	is_nil_repeat					= is_nil_repeat or false
	
	local isStrNull				= false
	local acture_pad_char	= pad_char
	if str == nil or str == "" then
		isStrNull						= true
		if is_nil_repeat then
			str									= ""
		else
			return nil_pad_char
		end
		acture_pad_char			= nil_pad_char
	else
		str									= tostring(str)
		acture_pad_char			= pad_char
	end
	
	local strLen					= string_widthSingle(str)
	local pad_unit_count	= 2
	if notHasChinese ~= nil and notHasChinese == true then
		strLen							= string.len(str)
		pad_unit_count			= 1
	end
	local needPadCnt	= len - strLen
	if needPadCnt < 0 then needPadCnt = 0 end
	if pos == "left" then
		str = str..string.rep(acture_pad_char, needPadCnt * pad_unit_count)		-- 1汉字等于2空格
	elseif pos == "right" then
		str = string.rep(acture_pad_char, needPadCnt * pad_unit_count)..str
	end
	return str
end

-- 功能: 把字符串扩展为长度为len,左对齐, 其他地方用filledChar补齐
local function string_toleft(str, len, filledChar)
  local function toleft(str, len, filledChar)
    str    = tostring(str);
    filledChar  = filledChar or " ";
    local nRestLen  = len - string_width(str);        -- 剩余长度
    local nNeedCharNum = math.floor(nRestLen / string_width(filledChar)); -- 需要的填充字符的数量
     
    str = str..string.rep(filledChar, nNeedCharNum);     -- 补齐
    return str;
  end
  if type(str)=="number" or type(str)=="string" then
      if not string.find(tostring(str),"\n") then
        return toleft(str,len,filledChar)
      else
        str=string_split(str,"\n")
      end
  end
  if type(str)=="table" then
    local tmpStr=toleft(str[1],len,filledChar)
    for i=2,#str do
      tmpStr=tmpStr.."\n"..toleft(str[i],len,filledChar)
    end
    return tmpStr
  end
end
-- 功能: 把字符串扩展为长度为len,右对齐, 其他地方用filledChar补齐
local function string_toright(str, len, filledChar)
  local function toright(str, len, filledChar)
    str    = tostring(str);
    filledChar  = filledChar or " ";
    local nRestLen  = len - string_width(str);        -- 剩余长度
    local nNeedCharNum = math.floor(nRestLen / string_width(filledChar)); -- 需要的填充字符的数量
     
    str = string.rep(filledChar, nNeedCharNum).. str;     -- 补齐
    return str;
  end
  if type(str)=="number" or type(str)=="string" then
      if not string.find(tostring(str),"\n") then
        return toright(str,len,filledChar)
      else
        str=string_split(str,"\n")
      end
  end
  if type(str)=="table" then
    local tmpStr=toright(str[1],len,filledChar)
    for i=2,#str do
      tmpStr=tmpStr.."\n"..toright(str[i],len,filledChar)
    end
    return tmpStr
  end
end

local function trim(strIn)
	local strRtn = strIn
	if strIn ~= nil then
		local ltrim = string.match(strIn, "%s.*")
		if ltrim ~= nil then
			strRtn = ltrim
			local rltrim = string.match(ltrim, ".*%s")
			if rltrim ~= nil then
				strRtn = rltrim
			end
		end
	end
	return strRtn
end

local function is_in_array(str, strArray)
	local rtn = false
	if str ~= nil and strArray ~= nil and type(strArray) == "table" then
		str = tostring(str)
		for i = 1, #strArray do
			if str == strArray[i] then
				--help.util.debug("[is_in_array] is_same  str="..str..", strArray["..i.."]="..strArray[i])
				rtn = true
				break
			--else
			--	help.util.debug("[is_in_array] not_same str="..str..", strArray["..i.."]="..strArray[i])
			end
		end
	end
	return rtn
end

StringBuffer = {}
StringBuffer.append = function(t, str)
	if t and str then
		table.insert(t, str)
	end
end
StringBuffer.tostr = function(t)
	if t then
		return table.concat(t)
	end
end
StringBuffer.new = function() return {} end

local function dumpArray(arr)
	local result = nil
	if arr ~= nil and type(arr) == "table" then
		local log = StringBuffer.new()
		for i = 1, #arr do
			StringBuffer.append(log, arr[i])
    	StringBuffer.append(log, ', ')
		end
		result = StringBuffer.tostr(log)
	end
	return result
end

local function repeat_str(s, times)
	local result		= nil
	if times == nil or type(times) ~= "number" and times <= 0 then
	
	else
		local tmp_array	= {}
		for i = 1, times do
			table.insert(tmp_array, s)
		end
		
		result = table.concat(tmp_array)
	end
	return result
end

local function get_display_count(s)
	local aggres = 0
	while string.len(s) > 0 do
		local str
		str = string.sub(s, 1, 1)
		if string.byte(str, 1) > 127 then
			str		= string.sub(s, 1, 2)		-- 全角 都是2字节的
			s			= string.sub(s, 3, -1)
			aggres= aggres + 2
		else
			s			= string.sub(s, 2, -1)
			aggres= aggres + 1
		end
	end
	return aggres
end

local function breakdown(s, length)
	local rtn = s
	if string.len(s) > length then
		rtn = ""
		local tmp_array	= {}
		local aggres = 0
		while string.len(s) > 0 do
			local str
			str = string.sub(s, 1, 1)
			if string.byte(str, 1) > 127 then
				str		= string.sub(s, 1, 2)		-- 全角 都是2字节的
				s			= string.sub(s, 3, -1)
				aggres= aggres + 2
			else
				s			= string.sub(s, 2, -1)
				aggres= aggres + 1
			end
			if aggres <= length then
				table.insert(tmp_array, str)
			else
				table.insert(tmp_array, "...")
				break
			end
		end
		
		result = table.concat(tmp_array)
	end
	return rtn
end

help.string = {
	GetUTF8CharLength	=	GetUTF8CharLength,
	GetUTF8Length			=	GetUTF8Length,
	SubUTF8String			=	SubUTF8String,
	string_ltrim			=	string_ltrim,
	string_rtrim			=	string_rtrim,
	string_trim				=	string_trim,
	string_split			=	string_split,
	string_count			=	string_count,
	string_width			=	string_width,
	string_tocenter		=	string_tocenter,
	string_2side			=	string_2side,
	string_toleft			=	string_toleft,
	string_toright		=	string_toright,
	trim							= trim,
	pad_string				= pad_string,
	startswith				= startswith,
	endswith					= endswith,
	split2Number			= split2Number,
	is_in_array				= is_in_array,
	dumpArray					= dumpArray,
	repeat_str				= repeat_str,
	get_display_count	= get_display_count,
	breakdown					= breakdown
}

return help.string