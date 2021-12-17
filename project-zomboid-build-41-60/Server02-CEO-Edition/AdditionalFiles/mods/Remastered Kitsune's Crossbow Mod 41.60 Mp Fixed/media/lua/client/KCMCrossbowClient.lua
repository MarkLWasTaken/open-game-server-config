require "LactoseCrossbowClient"

KCMweaponsClient = KCMweaponsClient or {};

function KCMweaponsClient.BoltDestroyed(zombie, boltTable)
	local boltFullType = boltTable[1];
	local brokenFullType = nil;
	if boltFullType == "KCMweapons.CrossbowBolt" then
		brokenFullType = "KCMweapons.ShortBrokenBolt";
	elseif boltFullType == "KCMweapons.CrossbowBoltLarge" then
		brokenFullType = "KCMweapons.LongBrokenBolt";
	elseif boltFullType == "KCMweapons.WoodenBolt" then
		brokenFullType = "KCMweapons.WoodenBrokenBolt";
	end
	local brokenBolt = InventoryItemFactory.CreateItem(brokenFullType)
	zombie:getInventory():AddItem(brokenBolt);
	local boltModData = brokenBolt:getModData();
	for i, v in pairs(boltTable[3]) do
		boltModData[v[1]] = v[2];
	end
end

LactoseCrossbow.CrossbowTypes["KCMweapons.HandCrossbow"] = "Short";
LactoseCrossbow.CrossbowTypes["KCMweapons.LargeCrossbow"] = "ShortAndLong";
LactoseCrossbow.CrossbowTypes["KCMweapons.KCM_Compound"] = "ShortAndLong";
LactoseCrossbow.CrossbowTypes["KCMweapons.KCM_Compound02"] = "ShortAndLong";
LactoseCrossbow.CrossbowTypes["KCMweapons.KCM_Handmade"] = "ShortAndLong";
LactoseCrossbow.CrossbowTypes["KCMweapons.KCM_Handmade02"] = "ShortAndLong";
LactoseCrossbow.AmmoTypes["KCMweapons.CrossbowBolt"] = {"Short",4};
LactoseCrossbow.AmmoTypes["KCMweapons.CrossbowBoltLarge"] = {"Long",6};
LactoseCrossbow.AmmoTypes["KCMweapons.WoodenBolt"] = {"Long",5};
LactoseCrossbow.AmmoStats["KCMweapons.CrossbowBolt"] = {1,91,KCMweaponsClient.BoltDestroyed};
LactoseCrossbow.AmmoStats["KCMweapons.CrossbowBoltLarge"] = {1,91,KCMweaponsClient.BoltDestroyed};
LactoseCrossbow.AmmoStats["KCMweapons.WoodenBolt"] = {1,76,KCMweaponsClient.BoltDestroyed};
table.insert(LactoseCrossbow.AmmoTypeList, "KCMweapons.CrossbowBolt");
table.insert(LactoseCrossbow.AmmoTypeList, "KCMweapons.CrossbowBoltLarge");
table.insert(LactoseCrossbow.AmmoTypeList, "KCMweapons.WoodenBolt");
LactoseCrossbow.NoLactoseCustomTooltip["KCMweapons.CrossbowBolt"] = true;
LactoseCrossbow.NoLactoseCustomTooltip["KCMweapons.CrossbowBoltLarge"] = true;
LactoseCrossbow.NoLactoseCustomTooltip["KCMweapons.WoodenBolt"] = true;
LactoseCrossbow.NoLactoseCustomTooltip["KCMweapons.HandCrossbow"] = true;
LactoseCrossbow.NoLactoseCustomTooltip["KCMweapons.LargeCrossbow"] = true;
LactoseCrossbow.NoLactoseCustomTooltip["KCMweapons.KCM_Compound"] = true;
LactoseCrossbow.NoLactoseCustomTooltip["KCMweapons.KCM_Compound02"] = true;
LactoseCrossbow.NoLactoseCustomTooltip["KCMweapons.KCM_Handmade"] = true;
LactoseCrossbow.NoLactoseCustomTooltip["KCMweapons.KCM_Handmade02"] = true;

function KCMweaponsClient.isKitsuneCrossbow(itemFullType,number)
	if itemFullType == "KCMweapons.HandCrossbow"
	or itemFullType == "KCMweapons.LargeCrossbow"
	or itemFullType == "KCMweapons.KCM_Compound"
	or itemFullType == "KCMweapons.KCM_Compound02"
	or itemFullType == "KCMweapons.KCM_Handmade"
	or itemFullType == "KCMweapons.KCM_Handmade02"
	then return true;
	else return false; end
end

local original_SetCrossbowSprite = LactoseCrossbow.SetCrossbowSprite
LactoseCrossbow.SetCrossbowSprite = function (player,item,number)
	local itemFullType = item:getFullType();
	if KCMweaponsClient.isKitsuneCrossbow(itemFullType,0) then
		if number == 1 or number == 3 then
			if itemFullType == "KCMweapons.LargeCrossbow" then item:setWeaponSprite("KCMweapons.LargeCrossbow"); end
			if itemFullType == "KCMweapons.HandCrossbow" then item:setWeaponSprite("KCMweapons.HandCrossbow"); end
			if itemFullType == "KCMweapons.KCM_Compound" then item:setWeaponSprite("KCMweapons.KCM_Compound"); end
			if itemFullType == "KCMweapons.KCM_Compound02" then item:setWeaponSprite("KCMweapons.KCM_Compound02"); end
			if itemFullType == "KCMweapons.KCM_Handmade" then item:setWeaponSprite("KCMweapons.KCM_Handmade"); end
			if itemFullType == "KCMweapons.KCM_Handmade02" then item:setWeaponSprite("KCMweapons.KCM_Handmade02"); end
		elseif number == 2 then
			if itemFullType == "KCMweapons.LargeCrossbow" then item:setWeaponSprite("KCMweapons.LargeCrossbowDrawn"); end
			if itemFullType == "KCMweapons.HandCrossbow" then item:setWeaponSprite("KCMweapons.HandCrossbowDrawn"); end
			if itemFullType == "KCMweapons.KCM_Compound" then item:setWeaponSprite("KCMweapons.KCM_CompoundDrawn"); end
			if itemFullType == "KCMweapons.KCM_Compound02" then item:setWeaponSprite("KCMweapons.KCM_CompoundDrawn02"); end
			if itemFullType == "KCMweapons.KCM_Handmade" then item:setWeaponSprite("KCMweapons.KCM_HandmadeDrawn"); end
			if itemFullType == "KCMweapons.KCM_Handmade02" then item:setWeaponSprite("KCMweapons.KCM_HandmadeDrawn02"); end
		end
		player:resetEquippedHandsModels();
	else
		original_SetCrossbowSprite(player,item,number);
	end
end

local original_hitCrossbow = LactoseCrossbow.hitCrossbow
function LactoseCrossbow.hitCrossbow(attacker,target,weapon,damage)
	if weapon:getModData().LCBoltCondition[1] ~= nil then weapon:getModData().LCBoltCondition = 1; end
	original_hitCrossbow(attacker,target,weapon,damage)
end