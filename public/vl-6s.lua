--6s alv-vl-uni
maxSwipeVPN = 4
dayDeleteRrs = 7

bundleUnity = ""
bundleVungle = "com.puztheconty.vlgame01"
bundleAlv= ""
listBundle = {bundleAlv, bundleVungle, bundleUnity}

function killApp() for i, a in pairs(listBundle) do appKill(a) end end

function openApp(bundle)
    repeat
        toast(bundle.." - chờ 7s", 6)
        appRun(bundle)
        usleep(6000000)
    until frontMostAppId() == bundle
    return 1
end

-----------
--INFO ✓✓✓
-----------
file = "/var/mobile/Library/AutoTouch/Scripts/rrs_data.txt"
fileStt = "/var/mobile/Library/AutoTouch/Scripts/rrs_status.txt"
listRrs = {}
isRunningRrs = 0

function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() else f=io.open(file, "w+") f:close() end
    return f ~= nil
end

function lines_from(file)
    if not file_exists(file) then return {} end
    local lines = {}
    for line in io.lines(file) do 
      lines[#lines + 1] = line
    end
    return lines
end

function changeSttRrs(type)
    isRunningRrs = type
    f = io.open(fileStt, "w+")
    f:write(type, "\n")
    io.close(f)
end

function getSttRrs()
    temp = lines_from(fileStt)
    if temp[1]~=nil then
        isRunningRrs = temp[1]
    else
        changeSttRrs(0)
    end
end
getSttRrs()

function getListRrs()
    local lines = lines_from(file)
    for i,v in pairs(lines) do
        local temp = {}
        for z in string.gmatch(v, "%S+") do
            table.insert(temp, z)
        end
        table.insert(listRrs, temp)
    end
end
getListRrs()

--remove path
local lfs = require("lfs")
local deletedir
deletedir = function(dir)
    for file in lfs.dir(dir) do
        local file_path = dir.."/"..file
        if file ~= "." and file ~= ".." then
            if lfs.attributes(file_path, "mode") == "file" then
                os.remove(file_path)
            elseif lfs.attributes(file_path, "mode") == "directory" then
                deletedir(file_path)
            end
        end
    end
    lfs.rmdir(dir)
end

-- check exists path
function exists(path)
    local ok, err, code = os.rename(path, path)
    if not ok then
       if code == 13 then
          deletedir(path)
          return true
       end
    end
    return ok, err
end

function resetData()
    toast("Reset Data",10)
    repeat
        openURL("XoaInfo://Reset")
        for a = 0, 40 do
            usleep(1000000)
            if frontMostAppId() == nil then return end
        end
    until frontMostAppId() == nil
end

function saveNewRrs()
    toast("Save New RRS",10)
    url = "XoaInfo://Config?ListAppRetention="
    for i,v in pairs(listBundle) do
        if v ~= "" then
            if i~=1 then url = url.."," end
            url = url..v 
        end
    end
    
    openURL(url.."com.apple.mobilesafari")
    repeat usleep(1000000) until getColor(690,70) == 31487
    usleep(2000000)
    
    --remove old rrs
    local listDel = {}
    for i=#listRrs,1,-1 do
        if os.time() - 1640000000 - listRrs[i][1]:gsub("v", "") > 86400*dayDeleteRrs then
			toast("Del RRS: "..v[1])
            path = "/var/mobile/Media/XoaInfo/"..listRrs[i][1].."/"
            if exists(path) then deletedir(path) end
            table.remove(listRrs,i)
        end
    end

    ok=0
    repeat
        name = os.time()-1640000000

        openURL("XoaInfo://Reset?RRS&name=v"..name)

        for a = 0, 40 do
            usleep(1000000)
            if frontMostAppId() == nil then ok=1 break end
        end
    until ok==1

    usleep(500000)

    --generete date
    d = os.date()
    temp={}
    for i in string.gmatch(d, "%S+") do table.insert(temp, i) end
    d=temp[3].."_"..temp[2].."_"..temp[5]
    --append new name rrs
    f = io.open(file, "w+")
    for i,v in pairs(listRrs) do
        f:write(v[1].." "..math.ceil(v[2]+1).." "..d, "\n")
    end
    f:write("v"..name.." 0 "..d, "\n")
    io.close(f)
    getListRrs()
end

function restoreRrs()
    if listRrs[1]==nil then return resetData() end

    toast("Restore RRS",10)
    ok=0

    repeat
        indexRrs = 1
        if math.random(0,1)==0 then
            local vMin = 100
            for i=#listRrs,1,-1 do
                if listRrs[i][2]*1<vMin then vMin=listRrs[i][2]*1  indexRrs=i end
            end
        else
            indexRrs = math.random(1,#listRrs)
        end

        openURL("XoaInfo://Restore?"..listRrs[indexRrs][1])
        for a = 0, 40 do
            usleep(1000000)
            if frontMostAppId() == nil then ok=1 break end
        end
    until ok==1  

    listRrs[indexRrs][2] = listRrs[indexRrs][2]+1

    f = io.open(file, "w+")
	for i,v in pairs(listRrs) do
		f:write(v[1].." "..math.ceil(v[2]+1), "\n")
	end
	io.close(f)
    changeSttRrs(1)
    getListRrs()
end

function reSaveRrs()
	toast("reSave RRS",10)
    changeSttRrs(0)
    openURL("XoaInfo://Reset?RRS")
    for a = 0, 40 do
        usleep(1000000)
        if frontMostAppId() == nil then return end
    end
end

-----------
--VPN ✓✓✓
-----------

function swipe()for a=1,math.random(0,maxSwipeVPN)do touchDown(2,192.96,1231.37)usleep(67943.17)touchMove(2,205.27,1195.73)usleep(16728.54)touchMove(2,214.51,1152.98)usleep(16624.33)touchMove(2,223.75,1099.02)usleep(16528.46)touchMove(2,228.88,1026.72)usleep(16524.62)touchMove(2,229.91,951.38)usleep(16750.00)touchMove(2,229.91,860.76)usleep(16596.88)touchMove(2,229.91,767.11)usleep(16772.29)touchMove(2,224.77,672.41)usleep(16671.21)touchMove(2,214.51,585.86)usleep(16552.29)touchMove(2,206.30,509.51)usleep(16690.33)touchMove(2,196.04,440.28)usleep(16743.04)touchMove(2,186.80,387.34)usleep(16664.17)touchMove(2,179.62,349.66)usleep(16595.83)touchMove(2,176.54,331.34)usleep(16719.67)touchMove(2,175.51,324.22)usleep(16579.92)touchMove(2,175.51,322.18)usleep(50126.92)touchMove(2,175.51,324.22)usleep(16703.92)touchMove(2,175.51,327.27)usleep(16675.54)touchMove(2,175.51,330.32)usleep(15262.04)touchUp(2,175.51,334.40)usleep(60000)end end


function vpn()
    toast("Kill all", 1)
    appRun("com.privax.hmaprovpn")
    usleep(4000000)
    while true do
        toast("Check", 1)
        if frontMostAppId() ~= "com.privax.hmaprovpn" then
            appRun("com.privax.hmaprovpn")
        end
        if getColor(539, 923) == 16777215 then
            ok = 1
            break
        else
            usleep(600000)
            tap(373, 827)
            usleep(600000)
            tap(370, 780)
            usleep(600000)
            tap(319, 740)
            usleep(600000)
        end
    end
    usleep(1700000)
    tap(627, 923)
    usleep(1500000)
    tap(620, 268)
    usleep(1300000)
    swipe()
    for a, b in pairs(findColor(0xA1B0BA, 1, {682, 1323, 1, -1000}, nil, true, false)) do
        y1 = b[2] - 10
    end
    for a, b in pairs(findColor(0xA1B0BA, 1, {570, 1323, 1, -1000}, nil, true, true)) do
        y2 = b[2] + 10
    end
    usleep(1000000)
    tap(450, math.random(y1, y2))
    usleep(1000000)
    ok = 0
    while true do
        if getColor(349, 530) == 16632367 then
            break
        else
            ok = ok + 1
            if ok == 9 then
                ok = 0
                tap(366, 656)
                usleep(600000)
            end
            tap(373, 827)
            usleep(600000)
            tap(319, 740)
            usleep(600000)
        end
    end
end

-----------
--APPLOVIN ✓✓✓
-----------
function impressionAlv() return math.random(3,5) end -- số impr chạy
function timeshowAlv() return math.random(10,45) end -- tgian bấm show sau khi tắt quảng cáo

function clickShowAlv(count,max)
    if getColor(515,976)==0 and getColor(548,839)==65793 then --check màn hình chính của app
		time=timeshowAlv()
		for i=time,0,-1 do
            toast(count.."/"..max.." Show: "..i,1)
            usleep(1000000)
            if frontMostAppId()=="com.privax.hmaprovpn" then return -1 end
        end 
        usleep(math.random(0,1000000))
        tap(515,976)
		for i=45,0,-1 do
            toast("Check: "..i,1)
            usleep(1000000) 
            if getColor(515,976)~=8421504 then
                if getColor(515,976)==16711680 then
                    return -1
                else
                    return 1
                end
                break
            end
        end 
	end
	return 0
end

function closeAdAlv()
    usleep(5000000)
    for i=math.random(36,42),1,-1 do
        toast("close "..i,1)
        usleep(1000000)
        if frontMostAppId()~=bundleAlv then
            openApp(bundleAlv)
        end
    end
    --close
    usleep(5500000)
    tap(706,45)
    usleep(6000000)
    tap(706,45)
    usleep(1500000)
end

-----------
-- VUNGLE ✓✓✓
-----------
function impression() return math.random(2, 5) end -- số impr chạy
function timeshow() return math.random(25, 65) end -- tgian bấm show sau khi tắt quảng cáo

function checkHomeVl()
    if getColor(447,667)==3458905 and getColor(500,676)==16777215 then
        return 1
    else
        return -1
    end
end

function clickShowVl(count, max)
    time = timeshow()
    for i = time, 0, -1 do
        toast(count .. "/" .. max .. " Show: " .. i, 1)
        usleep(1000000)
        if frontMostAppId() == "com.privax.hmaprovpn" then return -1 end
    end
    usleep(math.random(0, 1000000))
    for i = 1, 5 do
        tap(447,667)
        toast("tap " .. i)
        usleep(2000000)
        if checkHomeVl() == -1 then return 1 end
        if i == 5 then return -1 end
    end
end

function closeAdVL()
    for i = math.random(23, 33), 1, -1 do
        toast("close " .. i, 1)
        usleep(1000000)
    end
    tap(704,49)
    usleep(5500000)
    tap(704,49)
    usleep(1000000)
    if frontMostAppId() ~= bundleVungle then
        openApp(bundleVungle)
    end
    if checkHomeVl() == -1 then
        toast("Close appstore")
        tap(74,136)
        usleep(1000000)
        if frontMostAppId() ~= bundleVungle then
            openApp(bundleVungle)
        end
        if checkHomeVl() == -1 then
            usleep(5500000)
            tap(704,49)
        end
        usleep(1000000)
    end
    if frontMostAppId() ~= bundleVungle then
        openApp(bundleVungle)
    end
    return checkHomeVl()
end

-----------
-- UNITY ✓✓✓
-----------
function impressionUnity() return math.random(2,5) end -- số impr chạy
function timeCloseUnity() return math.random(40,50) end -- tgian giữa 2 lần bấm close

-----------
--MAIN ✓✓✓
-----------
while true do
    ::xoainfo::
    killApp()
    vpn()
    if isRunningRrs=="1" then
        reSaveRrs()
    else
        if math.random(1,2)==2 then
            while true do
                restoreRrs()
                for a = 0, 40 do
                    usleep(1000000)
                    if frontMostAppId() == nil then goto unity end
                end
            end
        else
            if math.random(1,4)==11 then saveNewRrs()
            else resetData()
            end
        end
    end

    ::unity::
    if bundleUnity=="" then goto vungle end
    bundle = bundleUnity
    if openApp(bundle)==-1 then goto xoainfo end

    for i=50,0,-1 do
        toast("check unity"..i, 1)
        usleep(1000000)
        if getColor(203, 1131) ~= 16777215 then break end
        if i==1 then goto vungle end
    end

    toast("chờ tí")
    for i=7,1,-1 do
        toast("chờ tí "..i,1)
        usleep(1000000)
        if getColor(203, 1131)==1474043 then
            usleep(3000000) tap(358, 1131) break
        end
    end

    impr = impressionUnity()
    for i=0, impr do
        for j=timeCloseUnity(),0,-1 do
            toast("close uni "..i.."/"..impr..": "..j)
            usleep(1000000)
        end
        tap(711,39)
        usleep(2000000)

        if i>3 and math.random(0,5)==2 and i<impr then
            appKill(bundle)
            for i=math.random(20,60),1,-1 do
                toast("Fake thoát app: "..i,1)
                usleep(1000000)
            end
            openApp(bundle)
        else
            toast("Không văng")
        end
    end

    ::vungle::
    if bundleVungle=="" then goto applovin end
    bundle = bundleVungle
    impr = impression()
    for i = 0, impr do
        if checkHomeVl() == 1 then
            if clickShowVl(i, impr) == 1 then
                if closeAdVL() == -1 then
                    killApp()
                    if openApp(bundle)==-1 then goto applovin end
                else
                    if i>3 and math.random(0,5)==2 and i<impr then
                        appKill(bundle)
                        for i=math.random(20,60),1,-1 do
                            toast("Fake thoát app: "..i,1)
                            usleep(1000000)
                        end
                        openApp(bundle)
                    else
                        toast("Không văng")
                    end
                end
            else
                goto applovin
            end
        else
            killApp()
            if openApp(bundle)==-1 then goto applovin end
        end
    end

    ::applovin::
    if bundleAlv=="" then goto xoainfo end
    if modeAlv == "old" then
        for i=timeAlv_OLD(),0,-1 do
            if frontMostAppId()~=bundleAlv then
                if openApp(bundleAlv)==-1 then goto xoainfo end
            end
            toast("alv old: "..i, 1)
            usleep(1000000)
        end
    else 
        if openApp(bundleAlv)==-1 then goto xoainfo end
        impr=impressionAlv()
        countGame=0
        for i=0, impr do
            stt=clickShowAlv(0, impr)
            if stt==1 then
                if closeAdAlv()==-1 then goto xoainfo end
            else
                if stt==0 then
                    killApp()
                    if openApp(bundleAlv)==-1 then goto xoainfo end
                else
                    goto xoainfo
                end
            end
        end
    end
end 