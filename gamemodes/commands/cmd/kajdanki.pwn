//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ kajdanki ]-----------------------------------------------//
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

// Opis:
/*

 */


// Notatki skryptera:
/*

 */

YCMD:kajdanki(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if(IsAPolicja(playerid) || (IsABOR(playerid) && PlayerInfo[playerid][pRank] >= 2))
        {
            new giveplayerid;
            if(sscanf(params, "k<fix>", giveplayerid))
            {
                sendTipMessage(playerid, "U�yj /kajdanki [ID_GRACZA]");
                return 1;
            }

            if(!IsPlayerConnected(giveplayerid))
            {
                sendTipMessage(playerid, "Nie ma takiego gracza");
                return 1;
            }

            if(Kajdanki_Uzyte[playerid] != 1)
            {
                if(IsAPolicja(playerid))
                {
                    if(OnDuty[playerid] == 0)
                    {
                        sendErrorMessage(playerid, "Nie jeste� na s�u�bie!");
                        return 1;
                    }
                }

                if(Spectate[giveplayerid] != INVALID_PLAYER_ID)
                {
                    sendTipMessage(playerid, "Jeste� zbyt daleko od gracza");
                    return 1;
                }
                if(GetPlayerAdminDutyStatus(giveplayerid) == 1)
                {
                    sendTipMessage(playerid, "Nie mo�esz sku� administratora!");
                    return 1;
                }
                if(GetDistanceBetweenPlayers(playerid,giveplayerid) < 5)
                {
                    if(GetPlayerState(playerid) == 1 && GetPlayerState(giveplayerid) == 1)
                    {
                        if(Kajdanki_JestemSkuty[giveplayerid] == 0)
                        {
                            if(AntySpam[playerid] == 1)
                            {
                                sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 10 sekund");
                                return 1;
                            }

                            if(IsAPolicja(giveplayerid)){
                                sendTipMessage(playerid, "Nie mozesz skuc policjanta!");
                                return 1;
                            }

                            new string[128];
                            if(PlayerInfo[giveplayerid][pBW] >= 1 || PlayerInfo[giveplayerid][pInjury] >= 1)
                            {
                                //Wiadomo�ci
                                format(string, sizeof(string), "* %s docisn�� do ziemi nieprzytomnego %s i sku� go.", GetNick(playerid), GetNick(giveplayerid));
                                ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                format(string, sizeof(string), "Dzi�ki szybkiej interwencji uda�o Ci si� sku� %s.", GetNick(giveplayerid));
                                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                sendTipMessageEx(giveplayerid, COLOR_BLUE, "Jeste� nieprzytomny - policjant sku� ci� bez wi�kszego wysi�ku.");

                                //czynno�ci
                                CuffedAction(playerid, giveplayerid);
                                ZdejmijBW(giveplayerid, 2000);
                                TogglePlayerControllable(giveplayerid, 1);
                            }
                            else if(GetPlayerSpecialAction(giveplayerid) == SPECIAL_ACTION_DUCK)
                            {
                                //Wiadomo�ci
                                format(string, sizeof(string), "* %s dociska do ziemi %s, a nast�pnie zakuwa go w kajdanki.", GetNick(playerid), GetNick(giveplayerid));
                                ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                format(string, sizeof(string), "Sku�e� %s.", GetNick(giveplayerid));
                                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                sendTipMessageEx(giveplayerid, COLOR_BLUE, "Le�a�e� na ziemi - policjant sku� ci� bez wi�kszego wysi�ku.");

                                //czynno�ci
                                CuffedAction(playerid, giveplayerid);
                                TogglePlayerControllable(giveplayerid, 1);
                            }
                            else
                            {
                                format(string, sizeof(string), "* %s wyci�ga kajdanki i pr�buje je za�o�y� %s.", GetNick(playerid),GetNick(giveplayerid));
                                ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                ShowPlayerDialogEx(giveplayerid, 98, DIALOG_STYLE_MSGBOX, "Aresztowanie", "Policjant chce za�o�y� ci kajdanki, je�li osacza ci� niedu�a liczba policjant�w mo�esz spr�bowa� si� wyrwa�\nJednak pami�taj je�li si� wyrwiesz i jeste� uzbrojony policjant ma prawo ci� zabi�. \nMo�esz tak�e dobrowolnie podda� si� policjantom.", "Poddaj si�", "Wyrwij si�");
                                Kajdanki_PDkuje[giveplayerid] = playerid;
                                //Kajdanki_Uzyte[giveplayerid] = 1;
                                SetTimerEx("UzyteKajdany",30000,0,"d",giveplayerid);
                            }
                            SetTimerEx("AntySpamTimer",10000,0,"d",playerid);
					        AntySpam[playerid] = 1;
                        }
                        else
                        {
                            new str[32];
                            valstr(str, giveplayerid);
                            RunCommand(playerid, "/rozkuj",  str);
                        }
                    } else
                    {
                        sendErrorMessage(playerid, "�aden z was nie mo�e by� w wozie!");
                    }
                } else
                {
                    sendTipMessage(playerid, "Jeste� zbyt daleko od gracza");
                }
            } 
            else
            {
                new str[32];
                valstr(str, giveplayerid);
                RunCommand(playerid, "/rozkuj",  str);
            }
        } else
        {
            sendTipMessage(playerid, "Nie posiadasz kajdanek");
        }
    }
    return 1;
}
