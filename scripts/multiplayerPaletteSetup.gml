///multiplayerPaletteSetup()

//setups multiplayer only palettes.
//var steRandom = random_get_seed();
//random_set_seed_safe(1234567);

var i, p;

//in case any are missed some random colors are set - more random colors are set, just in case
for (var j = 0; j < global.totalWeapons * 2; j++)
{
    global.multiplayerPalette[0,j] = make_color_rgb(irandom_range(72,255),irandom_range(0,64),irandom_range(0,64));
    global.multiplayerPalette[1,j] = make_color_rgb(irandom_range(0,64),irandom_range(0,64),irandom_range(72,255));
    global.multiplayerPalette[2,j] = make_color_rgb(irandom_range(0,64),irandom_range(72,255),irandom_range(0,64));
    global.multiplayerPalette[3,j] = make_color_rgb(irandom_range(72,255),irandom_range(72,255),irandom_range(0,64));
}

//player 1 = red
i = 0; p = 0;
global.multiplayerPalette[p,i] = make_color_rgb(248, 56, 0); i++; //default
global.multiplayerPalette[p,i] = make_color_rgb(237, 10, 101); i++; //spark chaser/treasure tracker
global.multiplayerPalette[p,i] = make_color_rgb(255, 0, 49); i++; //laser trident/hero guitar
global.multiplayerPalette[p,i] = make_color_rgb(248, 120, 248); i++; //water shield /glitz ageis
global.multiplayerPalette[p,i] = make_color_rgb(255, 0, 129); i++; //tornado blow /propeller crown
global.multiplayerPalette[p,i] = make_color_rgb(248, 0, 0); i++; //thunder beam/thermal blast
global.multiplayerPalette[p,i] = make_color_rgb(136, 20, 0); i++; //mag shock/last judgement
global.multiplayerPalette[p,i] = make_color_rgb(193, 59, 36); i++;//ice wall / mafia goon
global.multiplayerPalette[p,i] = make_color_rgb(167, 86, 72); i++; //break dash / castle rush
global.multiplayerPalette[p,i] = make_color_rgb(248, 56, 0); i++; //rush coil
global.multiplayerPalette[p,i] = make_color_rgb(248, 56, 0); i++; //rush jet
global.multiplayerPalette[p,i] = make_color_rgb(248, 56, 0); i++; //treble boost
global.multiplayerPalette[p,i] = make_color_rgb(248, 56, 0); i++; //rush bike
global.multiplayerPalette[p,i] = make_color_rgb(119, 27, 11); i++; //magnet beam / divine beam
global.multiplayerPalette[p,i] = make_color_rgb(80, 48, 0); i++;//inked - 26


//player 2 = blue
i = 0; p = 1;
global.multiplayerPalette[p,i] = make_color_rgb(0, 120, 248); i++; //default
global.multiplayerPalette[p,i] = make_color_rgb(1, 66, 185); i++; //schaser
global.multiplayerPalette[p,i] = make_color_rgb(96, 129, 189); i++; //ltrident
global.multiplayerPalette[p,i] = make_color_rgb(86, 146, 255); i++; //wshield
global.multiplayerPalette[p,i] = make_color_rgb(8, 58, 150); i++; //tblow
global.multiplayerPalette[p,i] = make_color_rgb(0, 133, 192); i++; //tbeam
global.multiplayerPalette[p,i] = make_color_rgb(85, 13, 171); i++; //mshock
global.multiplayerPalette[p,i] = make_color_rgb(80, 55, 142); i++; //iwall
global.multiplayerPalette[p,i] = make_color_rgb(65, 101, 142); i++; //bdash
global.multiplayerPalette[p,i] = make_color_rgb(0, 120, 248); i++; //rush coil
global.multiplayerPalette[p,i] = make_color_rgb(0, 120, 248); i++; //rush jet
global.multiplayerPalette[p,i] = make_color_rgb(0, 120, 248); i++; //treble boost
global.multiplayerPalette[p,i] = make_color_rgb(0, 120, 248); i++; //rush bike
global.multiplayerPalette[p,i] = make_color_rgb(85, 13, 171); i++; //mbeam
global.multiplayerPalette[p,i] = make_color_rgb(34, 18, 59); i++;//inked - 26

//player 3 = yellow
i = 0; p = 2;
global.multiplayerPalette[p,i] = make_color_rgb(252, 160, 68); i++; //def
global.multiplayerPalette[p,i] = make_color_rgb(175, 99, 26); i++; //schaser
global.multiplayerPalette[p,i] = make_color_rgb(92, 90, 77); i++; //ltrident
global.multiplayerPalette[p,i] = make_color_rgb(171, 145, 77); i++; //wshield
global.multiplayerPalette[p,i] = make_color_rgb(142, 118, 82); i++; //tblow
global.multiplayerPalette[p,i] = make_color_rgb(171, 145, 77); i++; //tbeam
global.multiplayerPalette[p,i] = make_color_rgb(54, 50, 41); i++; //mshock
global.multiplayerPalette[p,i] = make_color_rgb(192, 192, 64); i++; //iwall
global.multiplayerPalette[p,i] = make_color_rgb(163, 163, 113); i++; //bdash
global.multiplayerPalette[p,i] = make_color_rgb(252, 160, 68); i++; //rush coil
global.multiplayerPalette[p,i] = make_color_rgb(252, 160, 68); i++; //rush jet
global.multiplayerPalette[p,i] = make_color_rgb(252, 160, 68); i++; //treble boost
global.multiplayerPalette[p,i] = make_color_rgb(252, 160, 68); i++; //rush bike
global.multiplayerPalette[p,i] = make_color_rgb(130, 130, 11); i++; //mbeam
global.multiplayerPalette[p,i] = make_color_rgb(0, 184, 0); i++; //inked - 26

//player 4 = green
i = 0; p = 3;
global.multiplayerPalette[p,i] = make_color_rgb(0, 184, 0); i++; //def
global.multiplayerPalette[p,i] = make_color_rgb(67, 121, 89); i++; //schaser
global.multiplayerPalette[p,i] = make_color_rgb(0, 168, 68); i++; //ltrident
global.multiplayerPalette[p,i] = make_color_rgb(0, 192, 82); i++; //wshield
global.multiplayerPalette[p,i] = make_color_rgb(5, 146, 47); i++; //tblow
global.multiplayerPalette[p,i] = make_color_rgb(0, 184, 0); i++; //tbeam
global.multiplayerPalette[p,i] = make_color_rgb(0, 104, 0); i++; //mshock
global.multiplayerPalette[p,i] = make_color_rgb(0, 104, 0); i++; //iwall
global.multiplayerPalette[p,i] = make_color_rgb(0, 136, 136); i++; //bdash
global.multiplayerPalette[p,i] = make_color_rgb(0, 184, 0); i++; //rush coil
global.multiplayerPalette[p,i] = make_color_rgb(0, 184, 0); i++; //rush jet
global.multiplayerPalette[p,i] = make_color_rgb(0, 184, 0); i++; //treble boost
global.multiplayerPalette[p,i] = make_color_rgb(0, 184, 0); i++; //rush bike
global.multiplayerPalette[p,i] = make_color_rgb(9, 75, 52); i++; //mbeam
global.multiplayerPalette[p,i] = make_color_rgb(0, 88, 0); i++; //inked - 26


//original red palettes
/*
global.multiplayerPalette[p,i] = $0038f8; i++; //
global.multiplayerPalette[p,i] = $0080FF; i++; //(255, 128, 0)
global.multiplayerPalette[p,i] = $0040C0; i++; //(192, 64, 0)
global.multiplayerPalette[p,i] = $f777ff; i++; //(128, 32, 0)
global.multiplayerPalette[p,i] = $2060FF; i++; //(255, 96, 32)
global.multiplayerPalette[p,i] = $0000FF; i++; //(255, 0, 0)
global.multiplayerPalette[p,i] = $0060C0; i++; //(192, 96, 0)
global.multiplayerPalette[p,i] = $4080C0; i++; //(192, 128, 64)
global.multiplayerPalette[p,i] = $00A0FF; i++; //(255, 160, 0)
global.multiplayerPalette[p,i] = $0020A0; i++; //(160, 32, 0)
global.multiplayerPalette[p,i] = $0040FF; i++; //(255, 64, 0)
global.multiplayerPalette[p,i] = $204080; i++; //(128, 64, 32)
global.multiplayerPalette[p,i] = $2060C0; i++; //(192, 96, 32)
global.multiplayerPalette[p,i] = $000080; i++; //(128, 0, 0)
global.multiplayerPalette[p,i] = $4080A0; i++; //(160, 128, 64)
global.multiplayerPalette[p,i] = $00C0FF; i++; //(255, 192, 0)
global.multiplayerPalette[p,i] = $0020FF; i++; //(255, 32, 0)
*/
/*original blues
global.multiplayerPalette[p,i] = $f87800; i++; //
global.multiplayerPalette[p,i] = $800000; i++; //(0, 0, 128)
global.multiplayerPalette[p,i] = $C00000; i++; //(0, 0, 192)
global.multiplayerPalette[p,i] = $fc8b4c; i++; //(0, 0, 64)
global.multiplayerPalette[p,i] = $ecec01; i++; //(0, 0, 160)
global.multiplayerPalette[p,i] = $FF0000; i++; //(0, 0, 255)
global.multiplayerPalette[p,i] = $bc2844; i++; //(0, 0, 96)
global.multiplayerPalette[p,i] = $C04040; i++; //(64, 64, 192)
global.multiplayerPalette[p,i] = $E00000; i++; //(0, 0, 224)
global.multiplayerPalette[p,i] = $200000; i++; //(0, 0, 32)
global.multiplayerPalette[p,i] = $F04040; i++; //(64, 64, 240)
global.multiplayerPalette[p,i] = $804040; i++; //(64, 64, 128)
global.multiplayerPalette[p,i] = $A06060; i++; //(96, 96, 160)
global.multiplayerPalette[p,i] = $602020; i++; //(32, 0, 64)
global.multiplayerPalette[p,i] = $C08080; i++; //(128, 128, 192)
global.multiplayerPalette[p,i] = $FF8080; i++; //(128, 128, 255)
global.multiplayerPalette[p,i] = $A02020; i++; //(32, 32, 160)
*/
/* original yellows

global.multiplayerPalette[p,i] = $44a0fc; i++; //
global.multiplayerPalette[p,i] = $008080; i++; //(128, 128, 0)
global.multiplayerPalette[p,i] = $00C0C0; i++; //(192, 192, 0)
global.multiplayerPalette[p,i] = $007cac; i++; //(64, 64, 64)
global.multiplayerPalette[p,i] = $00A0A0; i++; //(160, 160, 0)
global.multiplayerPalette[p,i] = $FF00FF; i++; //(255, 0, 255)
global.multiplayerPalette[p,i] = $006060; i++; //(96, 96, 0)
global.multiplayerPalette[p,i] = $40C0C0; i++; //(192, 192, 64)
global.multiplayerPalette[p,i] = $FFC0CB; i++; //(203, 192, 255)
global.multiplayerPalette[p,i] = $202020; i++; //(32, 32, 32)
global.multiplayerPalette[p,i] = $FF69B4; i++; //(180, 105, 255)
global.multiplayerPalette[p,i] = $40F0F0; i++; //(240, 240, 64)
global.multiplayerPalette[p,i] = $408080; i++; //(128, 128, 64)
global.multiplayerPalette[p,i] = $60A0A0; i++; //(160, 160, 96)
global.multiplayerPalette[p,i] = $248493; i++; //(147, 20, 255)
global.multiplayerPalette[p,i] = $80C0C0; i++; //(192, 192, 128)
global.multiplayerPalette[p,i] = $20A0A0; i++; //(160, 160, 32)
*/
/* original greens
global.multiplayerPalette[p,i] = $00b800; i++; //
global.multiplayerPalette[p,i] = $008000; i++; //(128, 0, 0)
global.multiplayerPalette[p,i] = $00C000; i++; //(192, 0, 0)
global.multiplayerPalette[p,i] = $88a800; i++; //(64, 0, 0)
global.multiplayerPalette[p,i] = $00A000; i++; //(160, 0, 0)
global.multiplayerPalette[p,i] = $538967; i++; //(255, 0, 0)
global.multiplayerPalette[p,i] = $006000; i++; //(96, 0, 0)
global.multiplayerPalette[p,i] = $40C040; i++; //(192, 64, 64)
global.multiplayerPalette[p,i] = $00E000; i++; //(224, 0, 0)
global.multiplayerPalette[p,i] = $002000; i++; //(32, 0, 0)
global.multiplayerPalette[p,i] = $40F040; i++; //(240, 64, 64)
global.multiplayerPalette[p,i] = $408040; i++; //(128, 64, 64)
global.multiplayerPalette[p,i] = $60A060; i++; //(160, 96, 96)
global.multiplayerPalette[p,i] = $206020; i++; //(64, 32, 32)
global.multiplayerPalette[p,i] = $80C080; i++; //(192, 128, 128)
global.multiplayerPalette[p,i] = $80FF80; i++; //(255, 128, 128)
global.multiplayerPalette[p,i] = $005030; i++; //(160, 32, 32)
*/
//random_set_seed_safe(steRandom);
