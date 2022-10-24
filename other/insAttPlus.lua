local BASE_URL = "https://raw.githubusercontent.com/theld21/LuaResource/main/public/"

function get(name)
  local pth = string.format('%s/%s', rootDir(), name):gsub('/+', '/')
  io.popen("if test -f "..pth.." ; then rm "..pth.."; fi;"):close()
  io.popen(table.concat({"curl", "-sk", "-o", pth, BASE_URL..name}, " ")):close()
end

local failed = false
for _, name in pairs{"vl-iron-5s.lua"} do
  local s, r = pcall(get, name)
  if not s then 
    failed = true
    alert(r)
  end
end


if not failed then alert("Updated") end