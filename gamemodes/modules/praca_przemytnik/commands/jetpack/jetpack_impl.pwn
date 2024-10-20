//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  jetpack                                                  //
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
// Data utworzenia: 18.08.2024


//

//------------------<[ Implementacja: ]>-------------------
command_jetpack_Impl(playerid)
{
    if(GetPlayerSmugglingItem(playerid, SMUGGLING_ITEM_JETPACK) == 0)
    {
        MruMessageFail(playerid, "Nie posiadasz plecaka odrzutowego, musisz kupi� go od przemytnika!");
        return 1;
    }

    if(GetPlayerSmugglingItem(playerid, SMUGGLING_ITEM_JETPACK_GAS) == 0)
    {
        MruMessageFail(playerid, "Sko�czy�o Ci si� paliwo do plecaka odrzutowego, kup wi�cej od przemytnika.");
        return 1;
    }

    if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
    {
        DisableJetpack(playerid);
        ChatMe(playerid, "gasi plecak odrzutowy po czym go zdjemuje.");
    }
    else
    {
        UseJetpack(playerid);
        ChatMe(playerid, "zak�ada plecak odrzutowy i odpala go.");
    }
    return 1;
}

//end