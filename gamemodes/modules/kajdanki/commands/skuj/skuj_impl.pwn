//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  kajdanki                                                 //
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
// Autor: NikodemBanan
// Data utworzenia: 01.03.2024


//

//------------------<[ Implementacja: ]>-------------------
command_skuj_Impl(playerid, cuffedplayerid)
{
    if(IsKajdankiInvalid(playerid, cuffedplayerid))
    {
        return 1;
    }

    if(isPlayerUsingCuffs[playerid] && isPlayerCuffed[cuffedplayerid] && whoIsCuffing[cuffedplayerid] == playerid)
    {
        new str[32];
        valstr(str, cuffedplayerid);
        RunCommand(playerid, "/rozkuj",  str);
        return 1;
    }
    
    if(!isPlayerUsingCuffs[playerid] && isPlayerCuffed[cuffedplayerid] && whoIsCuffing[cuffedplayerid] != playerid)
    {
        TransferCuffs(cuffedplayerid, playerid);
        return 1;
    }

    new string[128];

    SetTimerEx("AntySpamTimer",10000,0,"d",playerid);
    AntySpam[playerid] = 1;

    // Automatyczny sukces
    if(PlayerInfo[cuffedplayerid][pBW] >= 1 || PlayerInfo[cuffedplayerid][pInjury] >= 1 || GetPlayerSpecialAction(cuffedplayerid) == SPECIAL_ACTION_DUCK)
    {
        CuffAutoSuccess(playerid, cuffedplayerid);
        return 1;
    }

    format(string, sizeof(string), "* %s wyci�ga kajdanki i pr�buje je za�o�y� %s.", GetNick(playerid),GetNick(cuffedplayerid));
    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

    whoIsCuffing[cuffedplayerid] = playerid;
    ShowPlayerDialogEx(cuffedplayerid, CUFFING_DIALOG_ID, DIALOG_STYLE_MSGBOX, "Aresztowanie", "Policjant chce za�o�y� ci kajdanki, je�li osacza ci� niedu�a liczba policjant�w mo�esz spr�bowa� si� wyrwa�\nJednak pami�taj je�li si� wyrwiesz i jeste� uzbrojony policjant ma prawo ci� zabi�. \nMo�esz tak�e dobrowolnie podda� si� policjantom.", "Poddaj si�", "Wyrwij si�");
    
    return 1;
}

//end