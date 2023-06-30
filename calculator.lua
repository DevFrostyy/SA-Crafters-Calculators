--b1.05
--Added Melons and Pumpkins
--Variables

local w,h = term.getSize()
local input
local input2
local input3
local input4
local price = 0
local itemcount = 0
local furnacecount = 0
local smelttime = 10
local stacksize = 0
local menu = 1

--Calculated Item Stack Sizes

local itemamount = 0
local doublechests = 0
local stackamnt = 0

--Calculated Prices

local chest = 0
local wand1 = 0
local wand2 = 0
local wand3 = 0
local wand4 = 0
local wand5 = 0
local shulker = 0
local swand1 = 0
local swand2 = 0
local swand3 = 0
local swand4 = 0
local swand5 = 0

--Calculated Time

local stime = 0
local mtime = 0
local htime = 0

--Calculated Fuel Consumption

local tempitems = 0
local coal = 0
local cblocks = 0
local rodstacks = 0
local rods = 0

--Credits

local credits = {"CSkyborne"}
local reason = {"Getting Shop Item Prices"}

--Tables for Value Calculator

local resources = {"Coal","Lapis","Redstone Dust","Quartz","Iron Ingot","Copper Ingot","Gold Ingot","Diamond","Emerald","Netherite Ingot","Glowstone Dust","Flint","Amethyst","Iron Block","Copper Block","Gold Block","Diamond Block","Emerald Block","Netherite Block","Glowstone","Coal Block"}
local resourcePrice = {2,31,23.35,21.4,14.5,24,8.5,65,25,210,13,7,1.5,130.5,216,76.5,585,225,1890,52,18}
local building = {"Stone","Granite","Andesite","Cobblestone","Cobbled Deepslate","Dirt","Stone Bricks","Mossy Stone Bricks","Cracked Stone Bricks","Chiseled Stone Bricks","Deepslate Bricks","Deepslate Tiles","Cracked Deepslate Tiles","Chiseled Deepslate Tiles","Deepslate","Tuff","Grass Block","Coarse Dirt","Podzol","Mycelium","Gravel","Sand","Red Sand","Sandstone","Glass","Terracotta","Diorite","End Stone","Obisidan","Snow Block","Netherack","Soul Sand","Prismarine","Ice","Nylium","Blackstone","Basalt","Crying Obisidan","Dried Kelp Block","Mushroom Block","Dripstone Block","Logs","Stem","Mangrove Log"}
local buildingPrices = {3,4.5,4.5,2.1,3.6,1.5,3.5,3.5,3.5,3.5,3.5,3.5,3.5,3.5,3,4,3,5.5,6,6.5,2.25,2.3,2.3,9.2,4.6,3.1,4.5,7,37,5.1,1.1,5.3,9.8,2,11,4.4,3.5,97,21,24,5.5,3,3.25,3.5}
local foods = {"Carrot","Steak","Apple","Poisonous Potato","Cake","Baked Potato","Cookie", "Melon", "Pumpkin"}
local foodPrices = {4.5,13,26,149,108,17.3,13, 0.8, 6}
local farming = {"Moss Block","Cactus","Rabbit Hide","Saplings","Dripleaf","Pointed Dripstone"}
local farmingPrices = {4,3.1,12,2,8.5,21}
local misc = {"Clock","Compass","String","Blaze Rod","Bone"}
local miscPrices = {210,130,2.2,15,3.1}

--Booleans

local running = true
local debugging = true
local stacks = false
local blast = false

--Functions

function clear()
	term.clear()
	term.setCursorPos(1,1)
end

function set(x,y,str)
	term.setCursorPos(x,y)
	write(str)
end

function getPrice(item)
	for i = 1, #resources do
		if item == resources[i] then
			return resourcePrice[i]
		end
		if item == building[i] then
			return buildingPrices[i]
		end
		if item == foods[i] then
			return foodPrices[i]
		end
		if item == farming[i] then
			return farmingPrices[i]
		end
		if item == misc[i] then
			return miscPrices[i]
		end
	end
	return "Does not Exist"
end

function formatNum(number)

  local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')

  -- reverse the int-string and append a comma to all blocks of 3 digits
  int = int:reverse():gsub("(%d%d%d)", "%1,")

  -- reverse the int-string back remove an optional comma and put the 
  -- optional minus and fractional part back
  return minus .. int:reverse():gsub("^,", "") .. fraction
end

function setPalette(ptype)
	if ptype == "normal" then
		term.setPaletteColor(2^0,0xEDEDED) --White
		term.setPaletteColor(2^1,0xFF6300) --Orange
		term.setPaletteColor(2^2,0xE319C9) --Magenta
		term.setPaletteColor(2^3,0x00C3FF) --Light Blue
		term.setPaletteColor(2^4,0xEDD21F) --Yellow
		term.setPaletteColor(2^5,0x92F21D) --Lime
		term.setPaletteColor(2^6,0xFF6DA8) --Pink
		term.setPaletteColor(2^7,0x383737) --Dark Gray
		term.setPaletteColor(2^8,0xA9A9A9) --Light Gray
		term.setPaletteColor(2^9,0x0EF0CA) --Cyan
		term.setPaletteColor(2^10,0x7319FA) --Purple
		term.setPaletteColor(2^11,0x1526E6) --Dark Blue
		term.setPaletteColor(2^12,0x472909) --Brown
		term.setPaletteColor(2^13,0x0F730B) --Dark Green
		term.setPaletteColor(2^14,0xCC0A0A) --Red
		term.setPaletteColor(2^15,0x030303) --Black
	elseif ptype == "darkmode" then
		term.setPaletteColor(2^0,0x030303)
		term.setPaletteColor(2^1,0xFF6300)
		term.setPaletteColor(2^2,0xE319C9)
		term.setPaletteColor(2^3,0x00C3FF)
		term.setPaletteColor(2^4,0x383737)
		term.setPaletteColor(2^5,0xA9A9A9)
		term.setPaletteColor(2^6,0xFF6DA8)
		term.setPaletteColor(2^7,0xA9A9A9)
		term.setPaletteColor(2^8,0x383737)
		term.setPaletteColor(2^9,0x0EF0CA)
		term.setPaletteColor(2^10,0x7319FA)
		term.setPaletteColor(2^11,0x383737)
		term.setPaletteColor(2^12,0x472909)
		term.setPaletteColor(2^13,0x383737)
		term.setPaletteColor(2^14,0xCC0A0A)
		term.setPaletteColor(2^15,0xEDEDED)
	end
end

function drawWindow(mnuint)
	if mnuint == 1 then --Main Menu
		term.setBackgroundColor(colors.white)
		clear()
		term.setBackgroundColor(colors.blue)
		term.clearLine()
		term.setCursorPos(w,1)
		term.setBackgroundColor(colors.red)
		term.setTextColor(colors.black)
		write"X"
		term.setBackgroundColor(colors.blue)
		term.setTextColor(colors.black)
		set(1,1,"Calculators for SA Crafters")
		term.setTextColor(colors.black)
		term.setBackgroundColor(colors.green)
		set(2,3," Item Value and Smelt Time ")
		set(2,5," Stack Size Calculator ")
	elseif mnuint == 2 then --Smelt time and Item Value Calculator
		term.setBackgroundColor(colors.white)
		clear()
		term.setBackgroundColor(colors.blue)
		term.clearLine()
		term.setCursorPos(w,1)
		term.setBackgroundColor(colors.lightBlue)
		set(w,1,"<")
		term.setBackgroundColor(colors.blue)
		term.setTextColor(colors.black)
		set(1,1,"Value Calculator")
		set(math.floor(w / 2 + 1),1,"Smelt Time Calculator")
		term.setBackgroundColor(colors.lightBlue)
		paintutils.drawLine(math.floor(w / 2),1,math.floor(w / 2),h,colors.lightGray)
		paintutils.drawLine(2,4,math.floor(w / 2 - 2),4,colors.gray)
		term.setBackgroundColor(colors.white)
		term.setCursorPos(2,3)
		write"Enter Item Here (Ex. Copper Block):"
		term.setBackgroundColor(colors.gray)
		term.setTextColor(colors.lightGray)
		if input == nil or input == "" then
			set(2,4,"NOTE: Item names are Case Sensitive")
		else
			set(2,4,input)
		end
		term.setBackgroundColor(colors.green)
		term.setTextColor(colors.black)
		set(math.floor(w / 2 - 12),6," Calculate ")
		term.setBackgroundColor(colors.white)
		set(2,6,"Chest Values")
		set(2,7,"Normal $"..formatNum(chest))
		set(2,8,"1.25x  $"..formatNum(wand1))
		set(2,9,"1.5x   $"..formatNum(wand2))
		set(2,10,"2x     $"..formatNum(wand3))
		set(2,11,"2.5x   $"..formatNum(wand4))
		set(2,12,"4x     $"..formatNum(wand5))
		set(2,14,"Chests w/Shulkers")
		set(2,15,"Normal $"..formatNum(shulker))
		set(2,16,"1.25x  $"..formatNum(swand1))
		set(2,17,"1.5x   $"..formatNum(swand2))
		set(2,18,"2x     $"..formatNum(swand3))
		set(2,19,"2.5x   $"..formatNum(swand4))
		set(2,20,"4x     $"..formatNum(swand5))
		set(2,22,"MVP++ (And Up) Bonus:")
		set(2,24,"Chest Values")
		set(2,25,"Normal $"..formatNum(chest * 1.1))
		set(2,26,"1.25x  $"..formatNum(wand1 * 1.1))
		set(2,27,"1.5x   $"..formatNum(wand2 * 1.1))
		set(2,28,"2x     $"..formatNum(wand3 * 1.1))
		set(2,29,"2.5x   $"..formatNum(wand4 * 1.1))
		set(2,30,"4x     $"..formatNum(wand5 * 1.1))
		set(2,32,"Chests w/Shulkers")
		set(2,33,"Normal $"..formatNum(shulker * 1.1))
		set(2,34,"1.25x  $"..formatNum(swand1 * 1.1))
		set(2,35,"1.5x   $"..formatNum(swand2 * 1.1))
		set(2,36,"2x     $"..formatNum(swand3 * 1.1))
		set(2,37,"2.5x   $"..formatNum(swand4 * 1.1))
		set(2,38,"4x     $"..formatNum(swand5 * 1.1))
		term.setBackgroundColor(colors.gray)
		term.setTextColor(colors.lightGray)
		term.setCursorPos(math.floor(w / 2 + 2),4)
		for i = 1, math.floor(w / 2 / 2 - 2) do
			write" "
		end
		if input2 == nil or input2 == "" then
			--Code
		else
			set(math.floor(w / 2 + 2),4,tostring(input2))
		end
		term.setCursorPos(math.floor(w / 2 + 2 + (math.floor(w / 2 / 2 - 2)) + 2),4)
		for i = 1, math.floor(w / 2 / 2 - 2) do
			write" "
		end
		if input3 == nil or input3 == "" then
			--Code
		else
			set(math.floor(w / 2 + 2 + (math.floor(w / 2 / 2 - 2)) + 2),4,tostring(input3))
		end
		term.setBackgroundColor(colors.white)
		term.setTextColor(colors.black)
		set(math.floor(w / 2 + 2),3,"Item Count:")
		set(math.floor(w / 2 + 2 + (math.floor(w / 2 / 2 - 2)) + 2),3,"Furnace Count:")
		set(math.floor(w / 2 + 2),6,"Stacks")
		term.setCursorPos(math.floor(w / 2 + 2) + 7,6)
		term.setBackgroundColor(colors.gray)
		write" "
		term.setCursorPos(math.floor(w / 2 + 2 + (math.floor(w / 2 / 2 - 2)) + 2),6)
		term.setBackgroundColor(colors.white)
		write"Blast Furnace/Smoker"
		term.setCursorPos(math.floor(w / 2 + 2 + (math.floor(w / 2 / 2 - 2)) + 2) + 22,6)
		term.setBackgroundColor(colors.gray)
		write" "
		term.setBackgroundColor(colors.gray)
		term.setTextColor(colors.lightGray)
		if stacks then
			set(math.floor(w / 2 + 2) + 7,6,"X")
		end
		if blast then
			set(math.floor(w / 2 + 2 + (math.floor(w / 2 / 2 - 2)) + 2) + 22,6,"X")
		end
		term.setBackgroundColor(colors.white)
		term.setTextColor(colors.black)
		set(math.floor(w / 2 + 2),10,"Smelt Time:")
		term.setBackgroundColor(colors.lightGray)
		term.setTextColor(colors.black)
		set(math.floor(w / 2 + 2) + 12,10,"00:00:00")
		if htime > 9 then
			set(math.floor(w / 2 + 2) + 12,10,htime)
		else
			set(math.floor(w / 2 + 2) + 13,10,htime)
		end
		if mtime > 9 then
			set(math.floor(w / 2 + 2) + 15,10,mtime)
		else
			set(math.floor(w / 2 + 2) + 16,10,mtime)
		end
		if stime > 9 then
			set(math.floor(w / 2 + 2) + 18,10,stime)
		else
			set(math.floor(w / 2 + 2) + 19,10,stime)
		end
		term.setTextColor(colors.black)
		term.setBackgroundColor(colors.white)
		set(math.floor(w / 2 + 2),12,"Coal Usage(Blocks)       : "..cblocks)
		set(math.floor(w / 2 + 2),13,"Leftover Coal from Blocks: "..coal)
		set(math.floor(w / 2 + 2),14,"Blaze Rod Usage (Stacks) : "..rodstacks)
		set(math.floor(w / 2 + 2),15,"Leftover Rods from Stacks: "..rods)
		set(math.floor(w / 2 + 2),17,"NOTE: This calculates FURNACE TIME. Time taken")
		set(math.floor(w / 2 + 2),18,"to filter items into chests WILL VARY depending")
		set(math.floor(w / 2 + 2),19,"on how your smelter is built!")
		term.setBackgroundColor(colors.green)
		set(math.floor(w / 2 + 2),8," Calculate ")
		term.setBackgroundColor(colors.yellow)
		set(math.floor(w / 2 - 13),h - 1," Item Types ")
	elseif mnuint == 3 then
		term.setBackgroundColor(colors.white)
		term.setTextColor(colors.black)
		clear()
		set(2,2,"Sellable item types:")
		set(2,3,"ALL Natural Resources")
		set(2,4,'ALL Building Block Types. (Wood under "Wood")')
		set(2,6,'Farming Items include:')
		set(2,7,'Moss Block, Cactus, Rabbit Hide, Dripleaf and Pointed Dripstone. (Saplings under "Saplings")')
		set(2,9,"Food Items include:")
		set(2,10,"Carrot, Steak, Apple, Poisonous Potato, Cake, Baked Potato and Cookie")
		set(2,12,"Misc Items include:")
		set(2,13,"Clock, Compass, String, Blaze Rod and Bone")
		set(2,15,"If you would like an item to be added, Please ask me at Cannon#0572 on Discord.")
		term.setBackgroundColor(colors.yellow)
		set(2,h - 1," Back ")
	elseif mnuint == 4 then --Stack Size Calculator
		term.setBackgroundColor(colors.white)
		term.clear()
		term.setBackgroundColor(colors.blue)
		term.setCursorPos(1,1)
		term.clearLine()
		term.setTextColor(colors.black)
		set(1,1,"Stack Calculator")
		term.setBackgroundColor(colors.lightBlue)
		set(w,1,"<")
		paintutils.drawLine(2,3,33,3,colors.gray)
		term.setTextColor(colors.lightGray)
		if input4 == nil then
			set(2,3,"Enter amount of items")
		else
			set(2,3,input4)
		end
		term.setBackgroundColor(colors.green)
		term.setTextColor(colors.black)
		set(35,3," Calculate ")
		term.setBackgroundColor(colors.white)
		set(2,5,"Double Chests : "..doublechests)
		set(2,6,"Stacks        : "..stackamnt)
		set(2,7,"Leftover Items: "..itemamount)
	end
end

--Main Code

setPalette("normal")

if not fs.exists("/configCalc.txt") then
	mkconfig = fs.open("/configCalc.txt","w")
	mkconfig.writeLine("DontShowMessage: false")
	mkconfig.writeLine("DarkMode: false")
	mkconfig.close()
end
local cfg = fs.open("/configCalc.txt","r")
local showmessage = cfg.readLine()
local dmenabled = cfg.readLine()
if showmessage == "DontShowMessage: true" then
	print"Starting Program"
else
	print"This is your first time starting this program."
	term.setTextColor(colors.lightBlue)
	print'PLEASE NOTE: MOST sellable items are in this calculator and some item formats have changed.'
	print'Items are formatted as "Copper Ingot". The first character of each word is Capitalized.'
	print'All log types fall under "Logs", And all sapling types fall under "Saplings"'
	print'Blocks are not formatted like "Block of Iron", They are formatted like "Iron Block" for ease of use'
	print" "
	print"How to use:"
	print"Click on a field to input something into it. When you are done putting something in the field you must press ENTER to confirm. Then click calculate to get your results!"
	term.setTextColor(colors.white)
end
cfg.close()
if showmessage ~= "DontShowMessage: true" then
	local config = fs.open("/configCalc.txt","w")
	config.writeLine("DontShowMessage: true")
	write"Do you want dark mode? (y/n):"
	while true do
		local dmenable = read()
		if dmenable == "y" or dmenable == "Y" then
			print"Enabling dark mode..."
			config.writeLine("DarkMode: true")
			dmenabled = "DarkMode: true"
			break
		elseif dmenable == "n" or dmenable == "N" then
			print"Dark mode disabled..."
			config.writeLine("DarkMode: false")
			break
		else
			term.setCursorPos(1,9)
			term.clearLine()
			write"Do you want dark mode? (y/n):"
		end
	end
	config.close()
end

if dmenabled == "DarkMode: true" then
	setPalette("darkmode")
else
	setPalette("normal")
end

drawWindow(1)
while running do --Runtime loop
	local events = {os.pullEventRaw()}
	if menu == 1 then --Main menu
		if events[1] == "mouse_click" and events[3] == w and events[4] == 1 then --Exit Button
			running = false
		elseif events[1] == "mouse_click" and events[3] >= 2 and events[3] <= 28 and events[4] == 3 then
			term.setTextColor(colors.black)
			term.setBackgroundColor(colors.lime)
			set(2,3," Item Value and Smelt Time ")
			sleep(0.25)
			term.setTextColor(colors.black)
			term.setBackgroundColor(colors.green)
			drawWindow(2)
			menu = 2
		elseif events[1] == "mouse_click" and events[3] >= 2 and events[3] <= 24 and events[4] == 5 then
			term.setTextColor(colors.black)
			term.setBackgroundColor(colors.lime)
			set(2,5," Stack Size Calculator ")
			sleep(0.25)
			term.setTextColor(colors.black)
			term.setBackgroundColor(colors.green)
			drawWindow(4)
			menu = 4
		end
	elseif menu == 2 then
	if events[1] == "mouse_click" and events[3] >= 4 and events[3] <= math.floor(w / 2 - 2) and events[4] == 4 then --Item Name Field
		term.setBackgroundColor(colors.gray)
		paintutils.drawLine(2,4,math.floor(w / 2 - 2),4,colors.gray)
		term.setTextColor(colors.lightGray)
		term.setCursorPos(2,4)
		input = read()
		term.setCursorPos(2,4)
		if input == nil or input == "" then
			price = 0
		end
		if getPrice(input) == "Does not Exist" then
			paintutils.drawLine(2,4,math.floor(w / 2 - 2),4,colors.gray)
			term.setTextColor(colors.lightGray)
			set(2,4,"Not an Item (Remember, Names are Case Sensitive)")
			term.setTextColor(colors.black)
		else
			price = getPrice(input)
		end
		term.setBackgroundColor(colors.white)
		term.setTextColor(colors.black)
	elseif events[1] == "mouse_click" and events[3] >= math.floor(w / 2 - 12) and events[3] <= math.floor(w / 2 - 2) and events[4] == 6 then --Calculate Button 1
		if price > 0 then
			term.setBackgroundColor(colors.lime)
			term.setTextColor(colors.black)
			set(math.floor(w / 2 - 12),6," Calculate ")
			sleep(0.25)
			term.setBackgroundColor(colors.green)
			term.setTextColor(colors.black)
			set(math.floor(w / 2 - 12),6," Calculate ")
			paintutils.drawFilledBox(2,7,math.floor(w / 2 - 1),h - 2,colors.white)
			set(2,6,"Chest Values")
			set(2,7,"Normal $0")
			set(2,8,"1.25x  $0")
			set(2,9,"1.5x   $0")
			set(2,10,"2x     $0")
			set(2,11,"2.5x   $0")
			set(2,12,"4x     $0")
			set(2,14,"Chests w/Shulkers")
			set(2,15,"Normal $0")
			set(2,16,"1.25x  $0")
			set(2,17,"1.5x   $0")
			set(2,18,"2x     $0")
			set(2,19,"2.5x   $0")
			set(2,20,"4x     $0")
			set(2,22,"MVP++ (And Up) Bonus:")
			set(2,24,"Chest Values")
			set(2,25,"Normal $0")
			set(2,26,"1.25x  $0")
			set(2,27,"1.5x   $0")
			set(2,28,"2x     $0")
			set(2,29,"2.5x   $0")
			set(2,30,"4x     $0")
			set(2,32,"Chests w/Shulkers")
			set(2,33,"Normal $0")
			set(2,34,"1.25x  $0")
			set(2,35,"1.5x   $0")
			set(2,36,"2x     $0")
			set(2,37,"2.5x   $0")
			set(2,38,"4x     $0")
			chest = 3456 * price
			wand1 = 3456 * price * 1.25
			wand2 = 3456 * price * 1.5
			wand3 = 3456 * price * 2
			wand4 = 3456 * price * 2.5
			wand5 = 3456 * price * 4
			shulker = 93312 * price
			swand1 = 93312 * price * 1.25
			swand2 = 93312 * price * 1.5
			swand3 = 93312 * price * 2
			swand4 = 93312 * price * 2.5
			swand5 = 93312 * price * 4
			set(10,7,formatNum(chest))
			set(10,8,formatNum(wand1))
			set(10,9,formatNum(wand2))
			set(10,10,formatNum(wand3))
			set(10,11,formatNum(wand4))
			set(10,12,formatNum(wand5))
			set(10,15,formatNum(shulker))
			set(10,16,formatNum(swand1))
			set(10,17,formatNum(swand2))
			set(10,18,formatNum(swand3))
			set(10,19,formatNum(swand4))
			set(10,20,formatNum(swand5))
			--MVP Bonuses
			set(10,25,formatNum(chest * 1.1))
			set(10,26,formatNum(wand1 * 1.1))
			set(10,27,formatNum(wand2 * 1.1))
			set(10,28,formatNum(wand3 * 1.1))
			set(10,29,formatNum(wand4 * 1.1))
			set(10,30,formatNum(wand5 * 1.1))
			set(10,33,formatNum(shulker * 1.1))
			set(10,34,formatNum(swand1 * 1.1))
			set(10,35,formatNum(swand2 * 1.1))
			set(10,36,formatNum(swand3 * 1.1))
			set(10,37,formatNum(swand4 * 1.1))
			set(10,38,formatNum(swand5 * 1.1))
		else
			term.setBackgroundColor(colors.red)
			term.setTextColor(colors.pink)
			set(math.floor(w / 2 - 12),6," Calculate ")
			sleep(0.25)
			term.setBackgroundColor(colors.green)
			term.setTextColor(colors.black)
			set(math.floor(w / 2 - 12),6," Calculate ")
		end
	elseif events[1] == "mouse_click" and events[3] >= math.floor(w / 2) + 2 and events[3] <= math.floor(w / 2) + 24 and events[4] == 4 then --Item Count Field
		term.setBackgroundColor(colors.gray)
		term.setTextColor(colors.lightGray)
		paintutils.drawLine(math.floor(w / 2 + 2),4,math.floor(w / 2) + 24,4,colors.gray)
		term.setCursorPos(math.floor(w / 2 + 2),4)
		input2 = read()
		term.setCursorPos(math.floor(w / 2 + 2),4)
		if input2 == nil or input2 == "" then
			itemcount = 0
		end
		input2 = tonumber(input2)
		if input2 == nil then
			paintutils.drawLine(math.floor(w / 2 + 2),4,math.floor(w / 2) + 24,4,colors.gray)
		else
			itemcount = input2
			stacksize = itemcount * 64
			if stacks then
				if itemcount ~= stacksize then
					itemcount = itemcount * 64
				end
			end
		end
	elseif events[1] == "mouse_click" and events[3] >= math.floor(w / 2) + 27 and events[3] <= math.floor(w / 2) + 49 and events[4] == 4 then --Furnace Count Field
		term.setBackgroundColor(colors.gray)
		term.setTextColor(colors.lightGray)
		paintutils.drawLine(math.floor(w / 2 + 27),4,math.floor(w / 2) + 49,4,colors.gray)
		term.setCursorPos(math.floor(w / 2 + 27),4)
		input3 = read()
		term.setCursorPos(math.floor(w / 2 + 27),4)
		if input3 == nil or input3 == "" then
			furnacecount = 0
		end
		input3 = tonumber(input3)
		if input3 == nil then
			paintutils.drawLine(math.floor(w / 2 + 27),4,math.floor(w / 2) + 49,4,colors.gray)
		else
			furnacecount = input3
		end
	elseif events[1] == "mouse_click" and events[3] == math.floor(w / 2) + 9 and events[4] == 6 then --Item Stack Radio Button
		if not stacks then
			term.setBackgroundColor(colors.gray)
			term.setTextColor(colors.lightGray)
			term.setCursorPos(math.floor(w / 2) + 9,6)
			write"X"
			stacks = true
			if itemcount ~= stacksize then
				itemcount = itemcount * 64
			end
			term.setBackgroundColor(colors.white)
			term.setTextColor(colors.black)
		else
			term.setBackgroundColor(colors.gray)
			term.setTextColor(colors.lightGray)
			term.setCursorPos(math.floor(w / 2) + 9,6)
			if itemcount == stacksize then
				itemcount = itemcount / 64
			end
			write" "
			stacks = false
			term.setBackgroundColor(colors.white)
			term.setTextColor(colors.black)
		end
	elseif events[1] == "mouse_click" and events[3] == w - 2 and events[4] == 6 then --Blast furnace/cooker radio button
		if not blast then
			term.setBackgroundColor(colors.gray)
			term.setTextColor(colors.lightGray)
			term.setCursorPos(w - 2,6)
			write"X"
			smelttime = 5
			blast = true
			term.setBackgroundColor(colors.white)
			term.setTextColor(colors.black)
		else
			term.setBackgroundColor(colors.gray)
			term.setTextColor(colors.lightGray)
			term.setCursorPos(w - 2,6)
			write" "
			smelttime = 10
			blast = false
			term.setBackgroundColor(colors.white)
			term.setTextColor(colors.black)
		end
	elseif events[1] == "mouse_click" and events[3] >= math.floor(w / 2) + 2 and events[3] <= math.floor(w / 2) + 12 and events[4] == 8 then --Calculate Button 2
		if itemcount == 0 or furnacecount == 0 then
			term.setTextColor(colors.pink)
			term.setBackgroundColor(colors.red)
			set(math.floor(w / 2 + 2),8," Calculate ")
			sleep(0.25)
			term.setBackgroundColor(colors.green)
			term.setTextColor(colors.black)
			set(math.floor(w / 2 + 2),8," Calculate ")
		else
			term.setTextColor(colors.black)
			term.setBackgroundColor(colors.lime)
			set(math.floor(w / 2 + 2),8," Calculate ")
			sleep(0.25)
			term.setBackgroundColor(colors.green)
			set(math.floor(w / 2 + 2),8," Calculate ")
			term.setBackgroundColor(colors.lightGray)
			set(math.floor(w / 2 + 2) + 12,10,"00:00:00")
			stime = smelttime * (itemcount/furnacecount)
			cblocks = 0
			coal = 0
			rodstacks = 0
			rods = 0
			mtime = 0
			htime = 0
			while stime > 60 do
				mtime = mtime + 1
				stime = stime - 60
			end
			while mtime > 60 do
				htime = htime + 1
				mtime = mtime - 60
			end
			stime = math.floor(stime)
			mtime = math.floor(mtime)
			htime = math.floor(htime)
			if htime > 9 then
				set(math.floor(w / 2 + 2) + 12,10,htime)
			else
				set(math.floor(w / 2 + 2) + 13,10,htime)
			end
			if mtime > 9 then
				set(math.floor(w / 2 + 2) + 15,10,mtime)
			else
				set(math.floor(w / 2 + 2) + 16,10,mtime)
			end
			if stime > 9 then
				set(math.floor(w / 2 + 2) + 18,10,stime)
			else
				set(math.floor(w / 2 + 2) + 19,10,stime)
			end
			tempitems = itemcount
			while tempitems > furnacecount * 8 do
				tempitems = tempitems -(furnacecount * 8)
				coal = coal + 1
			end
			if tempitems > 1 then
				tempitems = 0
				coal = coal + furnacecount
			end
			while coal > 9 do
				coal = coal - 9
				cblocks = cblocks + 1
			end
			tempitems = itemcount
			while tempitems > furnacecount * 12 do
				tempitems = tempitems - (furnacecount * 12)
				rods = rods + 1
			end
			if tempitems > 1 then
				tempitems = 0
				rods = rods + furnacecount
			end
			while rods > 64 do
				rodstacks = rodstacks + 1
				rods = rods - 64
			end
			term.setBackgroundColor(colors.white)
			set(math.floor(w / 2 + 2),12,"Coal Usage(Blocks)       : "..cblocks)
			set(math.floor(w / 2 + 2),13,"Leftover Coal from Blocks: "..coal)
			set(math.floor(w / 2 + 2),14,"Blaze Rod Usage (Stacks) : "..rodstacks)
			set(math.floor(w / 2 + 2),15,"Leftover Rods from Stacks: "..rods)
		end
	elseif events[1] == "mouse_click" and events[3] >= math.floor(w / 2) - 13 and events[3] <= math.floor(w / 2) - 2 and events[4] == h - 1 then
		drawWindow(3)
		menu = 3
	elseif events[1] == "mouse_click" and events[3] == w and events[4] == 1 then --Exit Button
		drawWindow(1)
		menu = 1
	end
	elseif menu == 3 then
		if events[1] == "mouse_click" and events[3] >= 2 and events[3] <= 7 and events[4] == h - 1 then
			drawWindow(2)
			menu = 2
		end
	elseif menu == 4 then
		if events[1] == "mouse_click" and events[3] >= 2 and events[3] <= 33 and events[4] == 3 then
			paintutils.drawLine(2,3,33,3,colors.gray)
			term.setTextColor(colors.lightGray)
			term.setCursorPos(2,3)
			input4 = read()
			input4 = tonumber(input4)
			if input4 == nil then
				term.setBackgroundColor(colors.gray)
				term.setTextColor(colors.lightGray)
				set(2,3,"Not a Number")
			end
		elseif events[1] == "mouse_click" and events[3] >= 35 and events[3] <= 45 and events[4] == 3 then
			if input4 == nil then
				term.setTextColor(colors.pink)
				term.setBackgroundColor(colors.red)
				set(35,3," Calculate ")
				sleep(0.25)
				term.setTextColor(colors.black)
				term.setBackgroundColor(colors.green)
				set(35,3," Calculate ")
			else
				term.setTextColor(colors.black)
				term.setBackgroundColor(colors.lime)
					set(35,3," Calculate ")
				sleep(0.25)
				term.setTextColor(colors.black)
				term.setBackgroundColor(colors.green)
				set(35,3," Calculate ")
				itemamount = 0
				stackamnt = 0
				doublechests = 0
				itemamount = input4
				while itemamount > 63 do
					stackamnt = stackamnt + 1
					itemamount = itemamount - 64
				end
				while stackamnt > 54 do
					stackamnt = stackamnt - 54
					doublechests = doublechests + 1
				end
				drawWindow(4)
			end
		elseif events[1] == "mouse_click" and events[3] == w and events[4] == 1 then --Exit Button
			drawWindow(1)
			menu = 1
		end
	end
end

term.setBackgroundColor(colors.black)
term.setTextColor(colors.white)
setPalette("normal")
clear()
print"Thank you for using Cannon's advanced calculator!"
print"Credit to CSkyborne for helping getting the item names and values"
print"Credit to beta testers CSkyborne, Illvinia, WoesGeroes, Slaai, PupRhogar, J0BY and RossMaster11"