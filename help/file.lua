--/////////////////////////////
--	file 一些文件处理相关函数
--/////////////////////////////

local function is_file_exists(path)
	local rtn = false
  local file = io.open(path, "rb")
  if file then
  	rtn = (file ~= nil)
  	file:close()
  end

  file = nil
  return rtn
end

local function filesize(path)
  local size = false
  local file = io.open(path, "r")
  if file then
    local current = file:seek()
    size = file:seek("end")
    file:seek("set", current)
    io.close(file)
  end
  return size
end

-- 读取文件所有内容
local function readfile_allcontent(path)
  local file = io.open(path, "r")
  if file then
    local content = file:read("*a")
    io.close(file)
    return content
  end
  return nil
end

-- 写入内容到文件
local function writefile(path, content, mode)
  mode = mode or "w+b"
  local file = io.open(path, mode)
  if file then
    if file:write(content) == nil then return false end
    io.close(file)
    return true
  else
    return false
  end
end

local function get_filecontent_as_stringlist(filePath)
	listContent = {}
	file = io.open(filePath ,"r");  
	for line in file:lines() do  
	    listContent[#listContent +1] = line  
	end  
	file:close()
	return listContent
end

local function store_filecontent_as_stringlist(filePath, stringlist)
	listContent = {}
	file = io.open(filePath ,"w");  
	for i = 1, #stringlist do  
	    file:write(stringlist[i])
	end  
	file:close()
end

local function copyFile(srcFile, destFile)
	local inpFile = io.open(srcFile, "rb")
	local outFile = io.open(destFile, "wb")
	 
	if inpFile ~= nil then
	    -- 最大8KB的内存
	    local buffSize = 2^13
	    while true do 
	        local bytes = inpFile:read(buffSize)
	        if not bytes then
	            break
	        end
	
	        outFile:write(bytes)
	    end
	
	    inpFile:close()
	end
	if outFile ~= nil then
	    local current = outFile:seek()
	    local fileSize = outFile:seek("end")
	    outFile:seek("set", current)
	
	    outFile:close()
	
	    if fileSize < 300 then
	        
	    end
	end
end

-- 判断资源是否为jpg
local function check_is_jpeg(filePath)
    local isJpeg = false

    if is_file_exists(filePath) then
        local inpFile = io.open(filePath, "rb")
        -- 读取前三位
        local bytes = inpFile:read(3)
        if bytes then
            local fileHeadIden = ""
            for _, b in ipairs{string.byte(bytes, 1, -1)} do
                local val = string.format("%02X", b)
                fileHeadIden = fileHeadIden..val
            end

            if string.upper(fileHeadIden) == "FFD8FF" then
                isJpeg = true
            else
                help.util.debug("==> filePath : "..tostring(filePath)..", fileHeadIden : "..tostring(fileHeadIden))
            end
        end

        inpFile:close()
    end

    return isJpeg
end

help.file = {
	is_file_exists					= is_file_exists,
	filesize						= filesize,
	readfile_allcontent				= readfile_allcontent,
	writefile						=	writefile,
	get_filecontent_as_stringlist	=	get_filecontent_as_stringlist,
	store_filecontent_as_stringlist	=	store_filecontent_as_stringlist,
	copyFile						=	copyFile,
	check_is_jpeg					=	check_is_jpeg
}

return help.file