#define __filename "initPlayerLocal.sqf"

if (isServer && !hasInterface) exitWith {};

// Did the init run already?
if (!isNil "init_ran") exitWith {};
init_ran = true;

[(_this select 0), "Player"] execVM "damageAdjust.sqf";