global function Sh_GamemodeShowdown_Init

global const string GAMEMODE_SHOWDOWN = "showdown"

void function Sh_GamemodeShowdown_Init()
{
	// create custom gamemode
	AddCallback_OnCustomGamemodesInit( CreateGamemodeShowdown )
}

void function CreateGamemodeShowdown()
{
	GameMode_Create( GAMEMODE_SHOWDOWN )
	GameMode_SetName( GAMEMODE_SHOWDOWN, "#GAMEMODE_SHOWDOWN" )
	GameMode_SetDesc( GAMEMODE_SHOWDOWN, "#PL_showdown_desc" )
	GameMode_SetGameModeAnnouncement( GAMEMODE_SHOWDOWN, "gnrc_modeDesc" )
	GameMode_SetDefaultTimeLimits( GAMEMODE_SHOWDOWN, 0, 5)
	GameMode_SetDefaultScoreLimits( GAMEMODE_SHOWDOWN, 0, 5 )
	GameMode_AddScoreboardColumnData( GAMEMODE_SHOWDOWN, "#SCOREBOARD_SCORE", PGS_ASSAULT_SCORE, 2 )
	GameMode_AddScoreboardColumnData( GAMEMODE_SHOWDOWN, "#SCOREBOARD_PILOT_KILLS", PGS_PILOT_KILLS, 2 )
	GameMode_SetColor( GAMEMODE_SHOWDOWN, [147, 204, 57, 255] )

	AddPrivateMatchMode( GAMEMODE_SHOWDOWN ) // add to private lobby modes

	#if SERVER
		GameMode_AddServerInit( GAMEMODE_SHOWDOWN, GamemodeShowdown_Init )
		GameMode_SetPilotSpawnpointsRatingFunc( GAMEMODE_SHOWDOWN, RateSpawnpoints_Generic )
		GameMode_SetTitanSpawnpointsRatingFunc( GAMEMODE_SHOWDOWN, RateSpawnpoints_Generic )
	#elseif CLIENT
		GameMode_AddClientInit( GAMEMODE_SHOWDOWN, ClGamemodeShowdown_Init )
	#endif
	#if !UI
		GameMode_SetScoreCompareFunc( GAMEMODE_SHOWDOWN, CompareAssaultScore )
	#endif
}
