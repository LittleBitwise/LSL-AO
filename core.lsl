#define llGLL llGetListLength
#define llL2S llList2String
#define llSAO llSetAnimationOverride
#define llGSS llGetSubString
#define llStrlen llStringLength

#define CYCLE_ANIM(string,list,integer) {  if (m == string) { if (list != []) { if (++integer >= llGLL(list)) integer = 0; llSAO(m, llL2S(list, integer)); llOwnerSay(llL2S(list, integer)); } }  }
#define BEGIN_ANIM(string,list,integer) {  if (list != []) { llSAO(string, llL2S(list, integer)); }  }
#define PARSE_ANIM(string,list,integer) {  if (!llSubStringIndex(data, string) && llStrlen(data) > integer) { list += llGSS(data, integer, -1); }  }

list crouching;         integer crouching_index;
list crouchwalking;     integer crouchwalking_index;
list falling_down;      integer falling_down_index;
list flying;            integer flying_index;
list flyingslow;        integer flyingslow_index;
list hovering;          integer hovering_index;
list hovering_down;     integer hovering_down_index;
list hovering_up;       integer hovering_up_index;
list jumping;           integer jumping_index;
list landing;           integer landing_index;
list prejumping;        integer prejumping_index;
list running;           integer running_index;
list sitting;           integer sitting_index;
list sitting_on_ground; integer sitting_on_ground_index;
list standing;          integer standing_index;
list standing_up;       integer standing_up_index;
list striding;          integer striding_index;
list soft_landing;      integer soft_landing_index;
list taking_off;        integer taking_off_index;
list turning_left;      integer turning_left_index;
list turning_right;     integer turning_right_index;
list walking;           integer walking_index;

#define NOTECARD "! ao.note"
integer read = -1;
integer channel = -432111000;

set_anims()
{
    BEGIN_ANIM("Crouching",         crouching,         crouching_index);
    BEGIN_ANIM("CrouchWalking",     crouchwalking,     crouchwalking_index);
    BEGIN_ANIM("Falling Down",      falling_down,      falling_down_index);
    BEGIN_ANIM("Flying",            flying,            flying_index);
    BEGIN_ANIM("FlyingSlow",        flyingslow,        flyingslow_index);
    BEGIN_ANIM("Hovering",          hovering,          hovering_index);
    BEGIN_ANIM("Hovering Down",     hovering_down,     hovering_down_index);
    BEGIN_ANIM("Hovering Up",       hovering_up,       hovering_up_index);
    BEGIN_ANIM("Jumping",           jumping,           jumping_index);
    BEGIN_ANIM("Landing",           landing,           landing_index);
    BEGIN_ANIM("PreJumping",        prejumping,        prejumping_index);
    BEGIN_ANIM("Running",           running,           running_index);
    BEGIN_ANIM("Sitting",           sitting,           sitting_index);
    BEGIN_ANIM("Sitting on Ground", sitting_on_ground, sitting_on_ground_index);
    BEGIN_ANIM("Standing",          standing,          standing_index);
    BEGIN_ANIM("Standing Up",       standing_up,       standing_up_index);
    BEGIN_ANIM("Striding",          striding,          striding_index);
    BEGIN_ANIM("Soft Landing",      soft_landing,      soft_landing_index);
    BEGIN_ANIM("Taking Off",        taking_off,        taking_off_index);
    BEGIN_ANIM("Turning Left",      turning_left,      turning_left_index);
    BEGIN_ANIM("Turning Right",     turning_right,     turning_right_index);
    BEGIN_ANIM("Walking",           walking,           walking_index);
}

default
{
    touch_start(integer n)
    {
        if (llGetPermissions())
        {
            llOwnerSay((string)llGetUsedMemory());
            llDialog(llGetOwner(), "Cycle animations:", [
                "Standing",
                "Walking",
                "Running",
                "Jumping",
                "Crouching",
                "CrouchWalking",
                "Sitting",
                "Sitting on Ground",
                "[Stop]"], channel);
        }
    }

    listen(integer c, string n, key id, string m)
    {
        if (m == "[Stop]")
        {
            llResetAnimationOverride("ALL");
            return;
        }
        CYCLE_ANIM("Crouching",         crouching,         crouching_index);
        CYCLE_ANIM("CrouchWalking",     crouchwalking,     crouchwalking_index);
        CYCLE_ANIM("Falling Down",      falling_down,      falling_down_index);
        CYCLE_ANIM("Flying",            flying,            flying_index);
        CYCLE_ANIM("FlyingSlow",        flyingslow,        flyingslow_index);
        CYCLE_ANIM("Hovering",          hovering,          hovering_index);
        CYCLE_ANIM("Hovering Down",     hovering_down,     hovering_down_index);
        CYCLE_ANIM("Hovering Up",       hovering_up,       hovering_up_index);
        CYCLE_ANIM("Jumping",           jumping,           jumping_index);
        CYCLE_ANIM("Landing",           landing,           landing_index);
        CYCLE_ANIM("PreJumping",        prejumping,        prejumping_index);
        CYCLE_ANIM("Running",           running,           running_index);
        CYCLE_ANIM("Sitting",           sitting,           sitting_index);
        CYCLE_ANIM("Sitting on Ground", sitting_on_ground, sitting_on_ground_index);
        CYCLE_ANIM("Standing",          standing,          standing_index);
        CYCLE_ANIM("Standing Up",       standing_up,       standing_up_index);
        CYCLE_ANIM("Striding",          striding,          striding_index);
        CYCLE_ANIM("Soft Landing",      soft_landing,      soft_landing_index);
        CYCLE_ANIM("Taking Off",        taking_off,        taking_off_index);
        CYCLE_ANIM("Turning Left",      turning_left,      turning_left_index);
        CYCLE_ANIM("Turning Right",     turning_right,     turning_right_index);
        CYCLE_ANIM("Walking",           walking,           walking_index);
        llDialog(llGetOwner(), "Cycle animations:", [
            "Standing",
            "Walking",
            "Running",
            "Jumping",
            "Crouching",
            "CrouchWalking",
            "Sitting",
            "Sitting on Ground",
            "[Stop]"], channel);
    }

    dataserver(key id, string data)
    {
        llOwnerSay("Loading notecard synchronously...");
        llSetColor(<0.957, 0.686, 0.145>, -1);

        integer line;
        string text;

        for (
            text = llGetNotecardLineSync(NOTECARD, line);
            text != EOF && text != NAK;
            text = llGetNotecardLineSync(NOTECARD, ++line)
        ) {
            PARSE_ANIM("Crouching=",         crouching,         10);
            PARSE_ANIM("CrouchWalking=",     crouchwalking,     14);
            PARSE_ANIM("Falling Down=",      falling_down,      13);
            PARSE_ANIM("Flying=",            flying,             7);
            PARSE_ANIM("FlyingSlow=",        flyingslow,        11);
            PARSE_ANIM("Hovering=",          hovering,           9);
            PARSE_ANIM("Hovering Down=",     hovering_down,     14);
            PARSE_ANIM("Hovering Up=",       hovering_up,       12);
            PARSE_ANIM("Jumping=",           jumping,            8);
            PARSE_ANIM("Landing=",           landing,            8);
            PARSE_ANIM("PreJumping=",        prejumping,        11);
            PARSE_ANIM("Running=",           running,            8);
            PARSE_ANIM("Sitting=",           sitting,            8);
            PARSE_ANIM("Sitting on Ground=", sitting_on_ground, 18);
            PARSE_ANIM("Standing=",          standing,           9);
            PARSE_ANIM("Standing Up=",       standing_up,       12);
            PARSE_ANIM("Striding=",          striding,           9);
            PARSE_ANIM("Soft Landing=",      soft_landing,      13);
            PARSE_ANIM("Taking Off=",        taking_off,        11);
            PARSE_ANIM("Turning Left=",      turning_left,      13);
            PARSE_ANIM("Turning Right=",     turning_right,     14);
            PARSE_ANIM("Walking=",           walking,            8);
        }

        if (text == NAK) {
            llOwnerSay("Cache interrupted, didn't read full notecard!");
        } else {
            llOwnerSay("Done!");
        }

        set_anims();
        llSetColor(<0.251, 0.753, 0.125>, -1);
    }

    state_entry()
    {
        llRequestPermissions(llGetOwner(), PERMISSION_OVERRIDE_ANIMATIONS);
    }

    run_time_permissions(integer p)
    {
        if (p)
        {
            llGetNumberOfNotecardLines(NOTECARD);
            llListen(channel, "", llGetOwner(), "");
        }
    }

    attach(key id)
    {
        if (id) if (llGetPermissions()) set_anims();
    }

    changed(integer change)
    {
        if (change & CHANGED_OWNER) llResetScript();
    }
}
