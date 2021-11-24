/// @description Set variables
tooltip = false;
offsetY = 20;
itemID = -1;
prevID = itemID;
slotID = -1;
background = 48;
width = 32;
height = 32;
depth = -y;

/*     --- Item stats ---
	+ Each item has 1-4 stats and 1 core stat (2 to 5 total)
	+ Each 
*/
name = "";         //Name of the item
//     --- Modifiers ---
strength = 0;      //Physical Damage
dexterity = 0;     //Attack Speed
movementSpeed = 0; //Movement speed
//     --- Regeneration ---
stamina = 0;       //Stamina regen
vitality = 0;      //Heatlh regen
energy = 0;        //Energy Regen
//     --- Resistances ---
fireRes = 0;       //Fire resistance
coldRes = 0;       //Cold resistance
lightRes = 0;      //Lightning resistance
//     --- Base stats ---
armor = 0;          //Armor points
damage = 0;         //Damage points
range = 0;          //Attack range points
//     --- Core stats ---
hp = 0;             //Health points
mp = 0;             //Mana points
sp = 0;             //Stamina points

image_index = 0;
image_speed = 0;

active = false;