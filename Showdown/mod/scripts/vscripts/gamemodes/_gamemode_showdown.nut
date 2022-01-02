global function GamemodeShowdown_Init


struct {
	string weapon
	string weapon2
        string ability
	string grenade
} file

void function GamemodeShowdown_Init()
{
    	SetSpawnpointGamemodeOverride( FFA )
	SetRoundBased(true)
        SetRespawnsEnabled(false)
	SetShouldUseRoundWinningKillReplay( true )
	SetLoadoutGracePeriodEnabled( false )
	SetWeaponDropsEnabled( false )
	Riff_ForceTitanAvailability( eTitanAvailability.Never )
	Riff_ForceBoostAvailability( eBoostAvailability.Disabled )
        Riff_ForceSetEliminationMode(eEliminationMode.Pilots)
	ClassicMP_ForceDisableEpilogue( true )
        ClassicMP_SetCustomIntro( ClassicMP_DefaultNoIntro_Setup, ClassicMP_DefaultNoIntro_GetLength() )
	AddCallback_OnClientConnected( ShowdownInitPlayer )
	AddCallback_GameStateEnter( eGameState.Prematch, ShuffleWeapons )
	AddCallback_OnPlayerRespawned( UpdateLoadout )
}

void function ShowdownInitPlayer( entity player )
{
	UpdateLoadout(player)
}

void function ShuffleWeapons()
{
     array<string> weapons = ["mp_weapon_r97","mp_weapon_alternator_smg","mp_weapon_car","mp_weapon_hemlok_smg","mp_weapon_lmg","mp_weapon_lstar","mp_weapon_esaw","mp_weapon_rspn101","mp_weapon_vinson","mp_weapon_hemlok","mp_weapon_g2","mp_weapon_shotgun","mp_weapon_mastiff","mp_weapon_dmr","mp_weapon_doubletake","mp_weapon_epg","mp_weapon_smr","mp_weapon_pulse_lmg","mp_weapon_softball","mp_weapon_autopistol","mp_weapon_semipistol","mp_weapon_wingman","mp_weapon_shotgun_pistol","mp_weapon_wingman_n","mp_weapon_sniper"]

    array<string> abilities = ["mp_ability_cloak", "mp_ability_grapple", "mp_ability_heal", "mp_ability_holopilot", "mp_ability_shifter", "mp_weapon_deployable_cover"]

    array<string> grenades = ["mp_weapon_frag_drone", "mp_weapon_frag_grenade", "mp_weapon_grenade_electric_smoke", "mp_weapon_grenade_emp", "mp_weapon_grenade_gravity", "mp_weapon_grenade_sonar", "mp_weapon_satchel", "mp_weapon_thermite_grenade"]
    int len1 = RandomInt(weapons.len())
    file.weapon = weapons[len1]
    weapons.remove(len1)
    file.weapon2 = weapons[RandomInt(weapons.len())]
    file.ability = abilities[RandomInt(abilities.len())]
    file.grenade = grenades[RandomInt(grenades.len())]
}

void function UpdateLoadout( entity player )
{
    if (IsAlive(player) && player != null) {
	foreach ( entity weapon in player.GetMainWeapons() )
		player.TakeWeaponNow( weapon.GetWeaponClassName() )

	foreach ( entity weapon in player.GetOffhandWeapons() )
		player.TakeWeaponNow( weapon.GetWeaponClassName() )

	player.GiveWeapon(file.weapon)
	player.GiveWeapon(file.weapon2)
        player.GiveOffhandWeapon(file.ability, OFFHAND_LEFT)
	player.GiveOffhandWeapon(file.grenade, OFFHAND_RIGHT)
        player.GiveOffhandWeapon( "melee_pilot_emptyhanded", OFFHAND_MELEE )
    }
}