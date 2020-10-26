# Arma 3 Damage Adjust
Damage adjust is an Arma 3 mission script to allow for fine tuned control over 
recieved unit damage.

## Setup
To install just add the script to your mission directory and call it from a unit's 
`init` field, as a part of the `initPlayerLocal.sqf` script, or however
you are spawning the unit. It is ill-advised to add this script to *all* AI 
units as the performance implications have yet to be 
verified. Specific groups of AI units are likely to be fine though. 

The script will hijack the unit's `HandleDamage` event handler and will likely
overwrite any other `HandleDamage` functions that may be added by other scripts.

The function signature of the script is `[<unit-to-apply-to>, <adjustment-class>] execVM "damageAdjust.sqf";`. The adjustment class is a subclass of `DamageAdjustConfig` defined in your mission's
`description.ext`. Any number of adjustment classes can be defined in DamageAdjust, just pass the 
class's name when you call the script. Each entry in the adjustment class is 
a section on the unit that recieves damage, for infantry the sections are
`["" "face_hub" "neck" "head" "pelvis" "spine1" "spine2" "spine3" "body" "arms" "hands" "legs"]`. 
`""` represents *overall* damage applied to the unit and is represented in the adjustment
class with the key `overall`. A value of for each key is a float where `1` represents
`100%` damage, or no change. An example of a config could look like:

```cpp
class DamageAdjustConfig {
  class Player {
    overall = 0.8;
    face_hub = 1.2;
    neck = 1;
    head = 1;
    pelvis = 0.8;
    spine1 = 0.8;
    spine2 = 0.8;
    spine3 = 0.8;
    body = 0.6;
    arms = 1;
    hands = 1;
    legs = 1;
  }

  class AnotherUnitType {
      ...
  }
}
```

`HandleDamage` events can be fired multiple times for a single damage source to account
for penetation and units can die if any one of the sections goes over the limit. Therefor 
it is advisable to adjust coherent groups together to get consistent behavior.

Examples of an `initPlayerLocal.sqf` and an `description.ext` can be found under the `examples`
folder in this repo.
