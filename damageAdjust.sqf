_character = (_this select 0);
_config = (_this select 1);

_character removeAllEventHandlers "HandleDamage";
_character setVariable ["config_section", _config];

// Handledamage
_character addEventHandler [
    "HandleDamage", 
    {
        _unit = _this select 0;
        _config_section = _unit getVariable ["config_section", ""];
        _selections = _unit getVariable ["selections", []];
        _gethit = _unit getVariable ["gethit", []];
        _selection = _this select 1;
        _selection = if (_selection isEqualTo "") then [{"overall"}, {_selection}];
        _modifier = ([missionConfigFile >> "DamageAdjustConfig" >> _config_section, _selection, 1] call BIS_fnc_returnConfigEntry);
        if !(_selection in _selections) then
        {
            _selections set [count _selections, _selection];
            _gethit set [count _gethit, 0];
        };
        _i = _selections find _selection;
        _olddamage = _gethit select _i;
        _damage = _olddamage + ((_this select 2) - _olddamage) * _modifier;
        _gethit set [_i, _damage];
        _damage;
    }
];