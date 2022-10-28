pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- baby search

--menu qui gere les niveaux

function _init()
	create_player()
	scene="intro"
	last=flr(time())
	music(0)
end

function _update()
	if scene=="intro" then
		update_intro()
	elseif scene=="lvl1" then
		update_lvl1()
 end
end
 
function _draw()
	if scene=="intro" then
		draw_intro()
	elseif scene=="lvl1" then
		draw_lvl1()
	end
end
-->8
-- intro

function draw_intro()
	cls()
	map(0,33,0,0)
	print("ouiiiin ! \n j'ai perdu \n mon doudou...",60,20,0)
	print("aide-moi a le retrouver !",20,53,0)
	print("tu as xx secondes \n pour finir le jeu",10,73,2)
	print("press sur ❎ to start",10,100,1)
end

function update_intro()
	if btnp(❎) then
	scene="lvl1"
	test=flr(time())
	end
end
-->8
-- lvl1

-- fonctions principales
function draw_lvl1()
	map_lvl1()
	draw_player()
	draw_ui()
	draw_time()
	stage_clear()
	lose()
end

function update_lvl1()
	player_movement()
	update_camera()
end


--fonction qui cree la map
function map_lvl1()
 cls()
 map(0,0,0,0)
 timer()
end

--fonctions qui creent et
--affichent le joueur
function create_player()
	p={
		x=5,
		y=5,
		sprite=1,
		keys=0,
		speed=1
		}
end

function draw_player()
	spr(p.sprite, p.x*8, p.y*8, 1, 1, p.flip)
end

-- gestion de la camera
function update_camera()
	local camx=flr(p.x/16)*16
	local camy=flr(p.y/16)*16
	camera(camx*8,camy*8)
end

-- gestion des deplacements
function player_movement()
	newx=p.x
	newy=p.y
	
 if (btnp(⬅️)) newx-=p.speed p.flip=true 
 if (btnp(➡️)) newx+=p.speed p.flip=false
	if (btnp(⬆️)) newy-=p.speed
	if (btnp(⬇️)) newy+=p.speed
	
	--gestion des collisions
if not check_flag(0,newx,newy) then
	p.x=newx
	p.y=newy
	end
	--si flag 0 pas de deplacement
	
	--interdiction sortie de la map
	if not check_flag(0,newx, newy) then
		p.x=mid(0,newx,127)
		p.y=mid(0,newy,63)
	else
		sfx(0)
	end

	--player mvt appelle la 
	--fonction interact pour
	--recupere la cle
	interact(newx, newy)
	
end


--recuperation des objets

	--verifie un flag
function check_flag(flag,x,y)
	local sprite=mget(x,y)
	return fget(sprite,flag)
end

 --verifie si la tile a 
 --le flag 1
function interact(x,y)
	if check_flag(1,x,y) then
		pick_up_key(x,y)
	end
end

	--recupere la cle et keys +1
function pick_up_key(x,y)
	next_tile(x,y)
	p.keys+=1
	sfx(1)
end

	--remplace la tuile objet
	--par une tuile vide
function next_tile(x,y)
	local sprite=mget(x,y)
	mset(x,y,sprite+1)
end



-->8
-- fins de niveau

-- niveaux

--fin de niveau
--game over par fin du chrono
function lose()
 if(time() - last - test) > 5  then
 cls()
 print("time's up! appuyez sur ❎\n  pour recommencer",
 5, 60, 7)
 music(8)
 	if (btn(❎)) then
		_init()
		end	 
 end
end

--niveau gagne
function stage_clear()
 if (p.keys == 1) then
 cls()
 print("niveau 1 complete", 5, 50, 7)
 print("appuyez sur ❎", 5, 60, 7)
 print("pour continuer", 5, 70, 7)
 end
 	if (btn(❎)) then
 	--start niveau 2
 end
end




-->8
-- user interface
function draw_ui()
 camera()
	spr(70,2,2)
	print("x"..p.keys,10,2,7)
end

function timer()
 check = flr(time())
end

function draw_time()
 camera()
 print(check - test, 120, 2, 0)
end
-->8
--lvl2

--[[function global_lvl2()
 create_player2()
 update_lvl2()
 draw_lvl2()
end

function update_lvl2()
 player_movement()
 update_camera()
end

function draw_lvl2()
 draw_player()
 map_lvl2()
end

function map_lvl2()
 cls(0)
 map(33,0,0,0)
end

function create_player2()
p={
		x=50,
		y=30,
		sprite=1,
		keys=0,
		speed=1,
		}
end--]]
__gfx__
00044400000444003331333333313333333433333333b33333333333b333333333bbbb3333337333333333333333ccdc37cdc7333333333333b3333333333333
0044440000ffff00331213333318133333414333333b4b33343433333333bb333bbaabb33337a7333b3333333b3cc76ccccc6c3b3b333b33333333b333333333
0ffffff00ffcfcf031222133318881333411143333bb44333474333333333b333bbbab133333733333333b33333c6ccc6cdccc333333333c3333333333333333
0ffffff00ffffff01222221318888813411111433b444bb345754337333333333bbbb313b33333333333333333cccdccccccc33333b333c6333b333c33333333
00ffff0000ff4f0032020233380808333101013333bb4bb377577444333b3333313b3313333333b33333333333ccc7c3dccc33b3333333cc333333cc33333333
0f6666f00f6666f0322222333888883331111133333b444b37e74444333b3333331111333333333333a333333ccdccc3cc733333333337cd3b3333cc33333333
0f7777f00f7777f0324422333822883331221133333b4b333474477433b333b333322333333333333a9a33b33c7c6c33cdc3333333333cc733333ccc33333333
00f77f0000f77f00324422333822883331221133333343333434343433333b333314423333b3333333a333333c6ccc3b6c33b3333b33cc6c3333cccc33333333
55555555554444555555555555555555554444555544445555444455555555555544445555444455555555555555555555555555554444550000000000000000
55555555554444555555555555555555554444555544445555444455555555555544445555444455555555555555555555555555554444550000000000000000
44444444554444555544444444444455554444444444445544444444444444444444445555444444554444444444445555444455554444550000000000000000
44444444554444555544444444444455554444444444445544444444444444444444445555444444554444444444445555444455554444550000000000000000
44444444554444555544444444444455554444444444445544444444444444444444445555444444554444444444445555444455554444550000000000000000
44444444554444555544444444444455554444444444445544444444444444444444445555444444554444444444445555444455554444550000000000000000
55555555554444555544445555444455555555555555555555555555554444555544445555444455555555555555555555444455555555550000000000000000
55555555554444555544445555444455555555555555555555555555554444555544445555444455555555555555555555444455555555550000000000000000
33333333333333333333333883333333333333355333333333333335533333333333333dd333333333333366666333333333330b0333333333333330b0333333
3b3333000003333b3333338888388333333b33555533553333b3335555355b333333b3dddd3663333333666ffff663333b3330bbb033b3333b33330bb033b333
33330033bbb0033333b3388ff88ff333333335522553223333333559955993333b333dd11dd1133b33666ffffffcccc333330bb3bb03333b333330bbbb03333b
33303333333bb033333388ffff88f33b3b3355222255223333335599995593333333dd1111dd1333366fffcccccccccc3b303b33b33003333333303bbb033333
3b303333bb33b03333388ffffff8833333355222222552333335599669955333333dd116611dd33336cccccccccccccc330333333b3303333b330b33b3303333
330333333bb33b033388ffffffff88333355222222225533335599966999553333dd11166111dd336cccccc66ccc3ccc3330bbbbbbb033333330bbb333303333
3303333333bb3b03388ffffffffff883355222222222255333599999999995333dd1111111111dd36ccccc655cc383cc330bb33bb3bb03333330bbbbbb303333
33033303330b3b0338ffffffffffff83552222222222225533399999999993333d111111111111d3ccccccccccc333cc30bbb333333b30333330bbb3bbb03333
333030503050303333f66ff66ff66f33532662266226623533396669966693333316611661166133cccccccccccccccc0333333bbbb33303330bbbbb3bbb0333
333033050503303333f66ff66ff66f33332662266226623333396669966693333316611661166133cccc3ccccccccccc0333b3bb33330033330bbbbbb3333033
333300305030033333ffffffffffff3333222222222222333b399999999993333311111111111133ccc3e3ccccc66ccc30bbbbbbbb3b033b330bbbbbbb333033
3b33330040033333b3ffff8888ffff333322222222222233333999999999933333111111111111333cc33ccccc655ccc0bbb3bb3bbbbb0333b0bbbbb3bb33033
333a33304033333333f66f2888f66f33332662444226623333396955596693333b166144411661333cccccccccccccc6bbbbbb3333bbbb033330bbbbbb33033b
33a9a330403333b333f66f2888f66f333b2662544226623b333969455966933b331661544116613333ccccccccccccc63b3333344333b33038330b3333303333
333a33304033b33333f66f8888f66f3333222254422222333339994559999333331111544111113b3333ccccccccc66333300044540333338e83300450033b33
333333045503333333ffff8888ffff3b332222444222223333399955599993333311114441111133333333ccccc6663300000444455000003833304455003333
33344443330044033333333333b3333b666666666666666600000000000000000566666666666650000000006666666605666666666666500000000000000000
3444773330044003b33773b3b3377333966669666666666690000900055555550566666666666650555555506666666605666666666666500000000000000000
40443333099999903397733333377933969694966666666690909490056666660566666666666650666666506666666605666666666666500000000000000000
444444439909909933337337733733b3499946946666666649994094056666660566666666666650666666506666666605666666666666500000000000000000
344444449999999933b3777777773333644496946666666604449094056666660566666666666650666666506666666605666666666666500000000000000000
33347444909999093333777777773333666649466666666600004940056666660566666666666650666666506666666605666666666666500000000000000000
33443344990000993333393993933b33666664666666666600000400056666660555555555555550666666505555555505666666666666500000000000000000
34434443099999903b3333333333333b666666666666666600000000056666660000000000000000666666500000000005666666666666500000000000000000
00888800333cccc3b3333333000444005ffff55533004403b3333333000000000000000000000000000000000000000000000000000000000000000000000000
088888802333dddc3333bb3350ffffdcff5f5f55300440033333bb33000000000000000000000000000000000000000000000000000000000000000000000000
8888888832333ddc33333b335ffcfcfcfffff6440999999033333b33000000000000000000000000000000000000000000000000000000000000000000000000
88777788323333dc333333335ffffffc466666149909909933333333000000000000000000000000000000000000000000000000000000000000000000000000
887777883cccccc3333b33330cff4fc64666611f99999999333b3333000000000000000000000000000000000000000000000000000000000000000000000000
8888888832cccc23333b333302cccc26f111111f90999909333b3333000000000000000000000000000000000000000000000000000000000000000000000000
08888880252cc25233b333b3252cc252ff11115f9900009933b333b3000000000000000000000000000000000000000000000000000000000000000000000000
008888003233332333333b330266002655dd5dd50999999033333b33000000000000000000000000000000000000000000000000000000000000000000000000
3300000330000033c6c666ee6666c6c6666226666666226600000000000000000000000000000000000000000000000000000000000000000000000000000000
300bbb0330b3bb00666c6fffff6c6666662442222222442600000000000000000000000000000000000000000000000000000000000000000000000000000000
00bb3bb00bbb333066c6f87878f6c666662442444442442600000000000000000000000000000000000000000000000000000000000000000000000000000000
0bbb3bb003bbbbbb6c6f8888888f66c6666224574574226600000000000000000000000000000000000000000000000000000000000000000000000000000000
0b3bbb330333b33066ef8228228fe666666624554554266600000000000000000000000000000000000000000000000000000000000000000000000000000000
00333b30000333006ef822222228fe66666624444444266600000000000000000000000000000000000000000000000000000000000000000000000000000000
30033330330450036ef882222288fe66666624445444266600000000000000000000000000000000000000000000000000000000000000000000000000000000
3000040033045033666f822f228f6666666662444442666600000000000000000000000000000000000000000000000000000000000000000000000000000000
00b00440304500336666f8fff8f66666666662222222666600000000000000000000000000000000000000000000000000000000000000000000000000000000
0bbb00400450bb006ff66fffff666ff6666622444442266600000000000000000000000000000000000000000000000000000000000000000000000000000000
00bbb004450bbb336ff6eeeeeeee6ff6666244444444426600000000000000000000000000000000000000000000000000000000000000000000000000000000
003340044533bb3066eeeeeeeeeeee66662444244424442600000000000000000000000000000000000000000000000000000000000000000000000000000000
300004044445330366ffeeeeeeeeff66662442444442442600000000000000000000000000000000000000000000000000000000000000000000000000000000
333330444500003366ff77777777ff66662224444444222600000000000000000000000000000000000000000000000000000000000000000000000000000000
3b333304450333336ffff777777ffff6666644422244466600000000000000000000000000000000000000000000000000000000000000000000000000000000
33333044455033b36ffff777777ffff6666644466644466600000000000000000000000000000000000000000000000000000000000000000000000000000000
05050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
05058500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5454545454545454545454545454545400000000000000000000e4e4e4e40000e400000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
54545454545454545454545454545454000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
54545454545454545454545454545454000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
54542636545454545454545454545454000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
54542737545454545454545454545454000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
54545454545454545454545454545454000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
54545454545454545454545454545454000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
54545454545454545454545454545454000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
54545454545454545454545454545454000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
54545454545454545454545454545454000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
54545454545454545454545454545454000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
54545454545454545454545454465654000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
54545454545454545454545454475754000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
54545454545454545454545454545454000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
54545454545454545454545454545454000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000010101010101010101010101010000000000000000000000000000000000010101010101010101010101010101010101010101010101010101010101010101000101020000000000000000000000010001000000010000000000000000000101000000000000000000000000000001010000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
070709070e0c070707071107070707070707070704020307432a2b4207072021502c2d2c2d07070707070707070707070760610707070707070707070707070707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0708070a0b07080728291107070707202107070707110707073a3b4207073031503c3d3c3d07070707070707070707070770710707070707070707070707070707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070e0c0707073839110707070930310707080714101013074222232021075020212c2d0707202160612e2f2c2d07072e2f070720212e2f606160612c2d0707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2425070b072627121010150707080707070707070707070811070732330431075030313c3d0707303170713e3f3c3d07073e3f070730313e3f707170713c3d0707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
34350d0c07363711070707090707070707070712101010101508070711070707500707070707072c2d0707070707070707070707072e2f0707070707072c2d0707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
070a0b42071a10180604030207080a0703070711080807070707070811070707505152520707073c3d0707070707070707070707073e3f0707070707073c3d0707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
070e0c0707070819101010171010101010171018070707121010101015070808502e2f60612021606120212e2f606152522c2d0707606107072e2f07072c2d0707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
430b071a10101018080808110907080707110711400707110407070707070708503e3f70713031707130313e3f707152523c3d0707707107073e3f07073c3d0707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e0c070709070711070608110707070704110711030808110708202107121017502e2f10541007070707525207202152522c2d07072e2f07072e2f20212c2d0707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b070a0722230711070708141010101010150714101010180707303107110911503e3f07070707525207070752303152523c3d07073e3f07073e3f30313c3d0707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0c0707073233061109070707202107070707072627070811242507070a110a11502e2f202160612c2d2c2d0752202152522e2f0707202107070707070707070707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101018070707073031070907070736370708113435071210150711503e3f303170713c3d3c3d0707303152523e3f0707303107070707070707070707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
070707080203041108070807070a12101010101013070711070707110807071150525252070707070752520707070752522e2f07072c2d2c2d2c2d60612c2d2e2f500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
070807070808091410101307074211222307070411030711060704110709121550070707070707070707070707070707073e3f07073c3d3c3d3c3d70713c3d3e3f500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070a07070803070711072a2b11323320210719101016101010154207110a502c2d0707202160612c2d2c2d202160612c2d0707070707070707070707070707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707121010130712101016133a3b11060730310a112627072223070707071410503c3d0707303170713c3d3c3d303170713c3d0707070707070707070707070707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
20211128291410150707071410101507070907071136370832330a070420210750070707070707070707070707070707072e2f2c2d2021202107072e2f2c2d6061500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
30311138390a0907072627070707040a070a090711080712101010101330310750070707070707070707070707070707073e3f3c3d3031303107073e3f3c3d7071500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07071910101010130736370707071210101013081107071108072a2b11070a0750070760612e2f20212021070760612e2f070707522c2d07070707070707070707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07041122230808191010101303071140070711081107041107073a3b1107070950070770713e3f30313031070770713e3f070707523c3d07070707070707070707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
070711323306081109070a19101015070707141016101016101307081106070350070707070707070707072e2f07070707070707522c2d07072e2f2e2f2e2f0707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09071410101010180a0a09110720210707070708090702020a1910101610101050070707070707070707073e3f07070707070707523c3d07073e3f3e3f3e3f0707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
070a090707070711072021110730020709070607090709090711020709080707502c2d2e2f2021070760612c2d2c2d0707202107522c2d07072e2f52522e2f0707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a09070808121018033031141710101010101307070809090711070707070907503c3d3e3f3031070770713c3d3c3d0707303107523c3d07073e3f52523e3f0707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a0908080311091410101307110607090708110407070a09081108030607070750070707072c2d070707070707606107072c2d52522c2d07072e2f070707070707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
070408121015070807071107110722230a07110709090904031910101013070850070707073c3d070707070707707107073c3d52523c3d07073e3f070707070707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
070804141307041417101610150732330707141010101010101526270811070a5007072c2d2e2f07072e2f070720210707202152522c2d07072e2f2e2f2e2f2e2f500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101015070a0711040a070809070703070a4009070702080736370a1107075007073c3d3e3f07073e3f070730310707303152073c3d07073e3f3e3f3e3f3e3f500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
282907070a0926271107070707121010171013072021090a09070707071109075007070707070707072e2f07072c2d2c2d2e2f5252606107070707070707070707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
383920210909363711072a2b4211202111080207303107070a08070a47114a095007070707070707073e3f07073c3d3c3d3e3f0752707107070707070707070707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707303124250a0811073a3b421130311108080803070804032627074c444d0a5020212c2d606160612e2f07070707070707070707070707072e2f606120210707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070734350808141010101015090a14101010101010101b363707484b49075030313c3d707170713e3f07070707070707070707070707073e3f707130310707500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000215004050071400d150141501a1502715030150051500115002100120000010000100001001600000100150000c60015000150001400010600130000f600120001c0001100006600100000960005600
00070000081100a1300f140141501a150201402c160361703f17000000000000000000000011100212006130091300d13011140181401f150271503016036160381703c100000000000000000000000000000000
000e000007052070520705207052220022700229002270020c0320c0520c0520c0520f0020a0020c0021100207022070520705207052180021b0020000210002100221005210052100520c0520c0520c0520c052
000e0000245302453018530185301f5301f5301853018530215302153017530175301c5301c5301353013530245302453018530185301f5301f53018530185302253024530135301353028530285302453024530
010e000028552285522855228552285522855228552285522b5522b5522b5522b5522d5522d5522d5522d5522b5522b5522b5522b55221552215522455224552285522855228552285521f5501f5501f5501f550
010e000028552285522855228552285522855228552285522b5522b5522b5522b5522d5522d5522d5522d5522b5522b5522b5522b552215522155224552245522655226552265522655226552265521f5021f502
010e000029550295502855028550265502655026550265502b5522b5522b5522b5521f5521f5521f5521f55228550285502655026550245502455024550245502b5522b5522b5522b5522b5522b5521f7021f702
010e00002d5522d5522d5522d5522d5522d5521a5501a550295502955028550285502655026550285502855024552245522455224552245522455224552245522455224552245522455224700000000000000000
01100000305503055030550305522a5502a5502a5502a5521b5501b5501b5501b5521855018550185501855217557175571755717557175571755717557175571755717507005000050000000000000000000000
__music__
00 02434544
00 02034444
01 02034444
00 02030444
00 02030544
00 02030644
02 02030744
00 08424344

