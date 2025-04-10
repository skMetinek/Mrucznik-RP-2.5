//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
//----------------------------------------------------*------------------------------------------------------//
//----[                                                                                                 ]----//
//----[         |||||             |||||                       ||||||||||       ||||||||||               ]----//
//----[        ||| |||           ||| |||                      |||     ||||     |||     ||||             ]----//
//----[       |||   |||         |||   |||                     |||       |||    |||       |||            ]----//
//----[       ||     ||         ||     ||                     |||       |||    |||       |||            ]----//
//----[      |||     |||       |||     |||                    |||     ||||     |||     ||||             ]----//
//----[      ||       ||       ||       ||     __________     ||||||||||       ||||||||||               ]----//
//----[     |||       |||     |||       |||                   |||    |||       |||                      ]----//
//----[     ||         ||     ||         ||                   |||     ||       |||                      ]----//
//----[    |||         |||   |||         |||                  |||     |||      |||                      ]----//
//----[    ||           ||   ||           ||                  |||      ||      |||                      ]----//
//----[   |||           ||| |||           |||                 |||      |||     |||                      ]----//
//----[  |||             |||||             |||                |||       |||    |||                      ]----//
//----[                                                                                                 ]----//
//----------------------------------------------------*------------------------------------------------------//
// Autor: mrucznik
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_wyprowadz_Impl(playerid, params[256])
{
    if(PlayerInfo[playerid][pRank] >= 2 && IsAClubBusinessOwner(playerid)) //RANGA
	{
		new id;
		if(sscanf(params, "d", id)) return sendTipMessage(playerid, "U�yj /wyprowadz [id]");
		if(!IsPlayerConnected(id)) return sendTipMessageEx(playerid, 0xB52E2BFF, "Tego gracza nie ma na serwerze");
		if(GetPVarInt(playerid, "IbizaWejdz") != 1 || GetPVarInt(id, "IbizaWejdz") != 1) return sendTipMessageEx(playerid, 0xB52E2BFF, "Nie mo�esz interweniowa� poza klubem / podany gracz nie znajduje si� w klubue");
		new Float:x, Float:y, Float:z;
		GetPlayerPos(id, x, y, z);
		if(!IsPlayerInRangeOfPoint(playerid, 4.0, x, y, z) || GetPlayerVirtualWorld(id) != 1) return sendTipMessageEx(playerid, 0xB52E2BFF, "Ten gracz jest za daleko od ciebie");
		if(IsAClubBusinessOwner(playerid)) return sendTipMessageEx(playerid, 0xB52E2BFF, "Nie mo�esz wyprowadzi� cz�onka klubu Ibiza");
		SetPVarInt(id, "IbizaWejdz", 0);
		SetPVarInt(id, "IbizaBilet", 0);
		SetPlayerPos(id, 394.2784,-1805.9104,7.8302);
		SetPlayerFacingAngle(id, 178.8095);
		SetPlayerVirtualWorld(id, 0);
		StopAudioStreamForPlayer(id);
		IbizaWyjscie(id);
		new string[128];
		format(string, sizeof string, "Wyprowadzi�e� gracza %s z klubu.", PlayerName(id));
		SendClientMessage(playerid, 0x00C000FF, string);
		format(string, sizeof string, "Zosta�e� wyprowadzony z klubu Ibiza przez ochron�.");
		SendClientMessage(id, 0xFF2040FF, string);
	}
	return 1;
}

//end
