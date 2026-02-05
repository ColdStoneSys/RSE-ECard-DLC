INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommands_eevee.asm"

	Mystery_Event

	db CHECKSUM_CRC
	dd 0 ; checksum placeholder
	GBAPTR DataStart
	GBAPTR DataEnd

DataStart:
	db IN_GAME_SCRIPT
	db 0,10 ; Oldale Town
	db 1     ; Marshal Arts Girl
	GBAPTR NormanScriptStart
	GBAPTR NormanScriptEnd

	db PRELOAD_SCRIPT
	GBAPTR PreloadScriptStart

	db END_OF_CHUNKS


GoSeeYourFather:
	Text_EN "There is a gift waiting in OLDALE\n"
	Text_EN "TOWN.@"



NormanScriptStart:
	setvirtualaddress NormanScriptStart

	           db $43                  ;This checks if your party is bigger than 0

		   compare LASTRESULT, 0   ;It's so I can store thumb code in static spot. 

		   virtualgotoif 2, Start  ;It should never fail.

			;db $00
			;dw $0000 ; fix address offsets - not needed?



		      
Start:
		   db $43 ;check party size

		   compare LASTRESULT, 5

		   virtualgotoif 2, NoRoom

		   sound $15	

 		   pause $10

		   lock
       
   		   faceplayer

		   virtualmsgbox Hello           

		   waitmsg
		
		   waitkeypress

		   giveegg $85

		   sound $172

		   virtualmsgbox GotEgg

		   waitmsg

		   waitkeypress

		   release

		   killscript

NoRoomTXT:
			Text_EN "-No room in party-@"


NoRoom:
		   virtualmsgbox NoRoomTXT

		   waitmsg

		   waitkeypress

		   release

 	   	   end


		

Hello:
	Text_EN "Hey!\p"
	Text_EN "Looks like you’re out on a grand\n"
	Text_EN "journey!\p"
	Text_EN "You might make good use of this.@"

GotEgg:
	Text_EN "\v1 got the egg!@"


NormanScriptEnd:


PreloadScriptStart:
	setvirtualaddress PreloadScriptStart

		   virtualloadpointer GoSeeYourFather

		   setbyte 2
		   end




DataEnd:
	EOF
  	