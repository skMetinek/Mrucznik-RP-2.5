//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  uleczall                                                 //
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
// Autor: Sandal
// Data utworzenia: 23.01.2024


//

//------------------<[ Implementacja: ]>-------------------
command_aulecz_Impl(playerid, giveplayerid)
{
    if(PlayerInfo[playerid][pAdmin] < 1 && !IsAScripter(playerid))
    {
        noAccessMessage(playerid);
        return 1;
    }

    CureFromAllDiseases(giveplayerid);

    Log(adminLog, INFO, "Admin %s wyleczy� gracza %s z wszystkich chor�b.", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid));
    SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "Zosta�e� uleczony z wszystkich chor�b przez admina.");
    SendClientMessage(playerid, COLOR_WHITE, sprintf("Uleczy�e� %s z wszystkich chor�b.", GetNick(giveplayerid)));
    return 1;
}

//end