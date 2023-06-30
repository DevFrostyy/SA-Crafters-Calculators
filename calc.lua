print"Checking for updates on pastebin..."
shell.run("pastebin get C6uEq4bp /temp.lua")
term.clear()
term.setCursorPos(1,1)

temp = fs.open("/temp.lua","r")
curp = fs.open("/calculator.lua","r")
local pbversion = temp.readLine()
local version = curp.readLine()
local changelog = temp.readLine()
local tmp = {}
temp.close()
curp.close()

for i = 1, string.len(changelog) do
	tmp[#tmp + 1] = string.sub(changelog, i, i)
end


if pbversion ~= version then
    print"Version Outdated. Updating..."
    if fs.exists("/calculatorOLD.lua") then
		fs.delete("/calculatorOLD.lua")
	end
	fs.copy("/calculator.lua","/calculatorOLD.lua")
	fs.delete("/calculator.lua")
	fs.copy("/temp.lua","/calculator.lua")
	print"Update complete. Changelog:"
	term.setTextColor(colors.magenta)
	for i = 3,#tmp do
		if tmp[i] == "." then
			write(tmp[i])
			print" "
		else
			write(tmp[i])
		end
	end
	term.setTextColor(colors.white)
	print" "
	write"Please read the "
	term.setTextColor(colors.magenta)
	write"Changelog "
	term.setTextColor(colors.white)
	write"and press any key to start the program."
	os.pullEvent("char")
else
    print"Version up to date. Starting..."
    sleep(2)
end

fs.delete("temp.lua")
shell.run("calculator.lua")