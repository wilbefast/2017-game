return {
  title = love.graphics.newImage("assets/image/Mediajam_titre-03.png"),
  ingame = love.graphics.newImage("assets/image/ingame.jpg"),
  triangle = love.graphics.newImage("assets/image/combination/triangle.png"),
  square = love.graphics.newImage("assets/image/combination/square.png"),
  circle = love.graphics.newImage("assets/image/combination/circle.png"),
  trapeze = love.graphics.newImage("assets/image/combination/trapeze.png"),

  -- tooltip newspaper
   mediapart = love.graphics.newImage("assets/image/tooltip/mediapart.png"),
   -- tooltip journalists
   journalist_financial = love.graphics.newImage("assets/image/tooltip/journalist_financial.png"),
   journalist_world = love.graphics.newImage("assets/image/tooltip/journalist_world.png"),
   journalist_state = love.graphics.newImage("assets/image/tooltip/journalist_state.png"),
   journalist_sexual = love.graphics.newImage("assets/image/tooltip/journalist_sexual.png"),
   journalist_joker = love.graphics.newImage("assets/image/tooltip/journalist_joker.png"),
   -- tooltip candidate
   reac_f = love.graphics.newImage("assets/image/tooltip/reac_f.png"),
   reac_h= love.graphics.newImage("assets/image/tooltip/reac_m.png"),
   socialo_f = love.graphics.newImage("assets/image/tooltip/socialo_f.png"),
   socialo_h= love.graphics.newImage("assets/image/tooltip/socialo_m.png"),
   facho_f = love.graphics.newImage("assets/image/tooltip/facho_f.png"),
   facho_h= love.graphics.newImage("assets/image/tooltip/facho_m.png"),
   gaucho_f = love.graphics.newImage("assets/image/tooltip/gaucho_f.png"),
   gaucho_h= love.graphics.newImage("assets/image/tooltip/gaucho_m.png"),
   centre_f = love.graphics.newImage("assets/image/tooltip/centre_f.png"),
   centre_h= love.graphics.newImage("assets/image/tooltip/centre_m.png"),
   ecolo_f = love.graphics.newImage("assets/image/tooltip/ecolo_f.png"),
   ecolo_h= love.graphics.newImage("assets/image/tooltip/ecolo_m.png"),
   ailleurs_f = love.graphics.newImage("assets/image/tooltip/ailleurs_f.png"),
   ailleurs_h= love.graphics.newImage("assets/image/tooltip/ailleurs_m.png"),
   -- tooltip source
   source_secret1 = love.graphics.newImage("assets/image/tooltip/source_secret1.png"),
   source_secret2 = love.graphics.newImage("assets/image/tooltip/source_secret2.png"),
   source_secret3 = love.graphics.newImage("assets/image/tooltip/source_secret3.png"),
   source_public1 = love.graphics.newImage("assets/image/tooltip/source_public1.png"),
   source_public2 = love.graphics.newImage("assets/image/tooltip/source_public2.png"),
   source_public3 = love.graphics.newImage("assets/image/tooltip/source_public3.png"),
   -- tooltip ally
   ally_whistleblower1 = love.graphics.newImage("assets/image/tooltip/ally_whistleblower1.png"),
   ally_whistleblower2 = love.graphics.newImage("assets/image/tooltip/ally_whistleblower2.png"),
   ally_whistleblower3 = love.graphics.newImage("assets/image/tooltip/ally_whistleblower3.png"),
   ally_judge1 = love.graphics.newImage("assets/image/tooltip/ally_judge1.png"),
   ally_diffamation1 = love.graphics.newImage("assets/image/tooltip/ally_diffamation1.png"),
   ally_publicopinion1 = love.graphics.newImage("assets/image/tooltip/ally_publicopinion1.png"),
   -- tooltip adversary
   adversary_spindoctor1 = love.graphics.newImage("assets/image/tooltip/adversary_spindoctor1.png"),
   adversary_spindoctor2 = love.graphics.newImage("assets/image/tooltip/adversary_spindoctor2.png"),
   adversary_spindoctor3 = love.graphics.newImage("assets/image/tooltip/adversary_spindoctor3.png"),
   adversary_secretservice1 = love.graphics.newImage("assets/image/tooltip/adversary_secretservice1.png"),
   adversary_secretservice2 = love.graphics.newImage("assets/image/tooltip/adversary_secretservice2.png"),
   adversary_secretservice3 = love.graphics.newImage("assets/image/tooltip/adversary_secretservice3.png"),
   adversary_trial1 = love.graphics.newImage("assets/image/tooltip/adversary_trial1.png"),
   adversary_trial2 = love.graphics.newImage("assets/image/tooltip/adversary_trial2.png"),
   adversary_trial3 = love.graphics.newImage("assets/image/tooltip/adversary_trial3.png"),
   adversary_randomevent1 = love.graphics.newImage("assets/image/tooltip/adversary_randomevent1.png"),
   adversary_randomevent2 = love.graphics.newImage("assets/image/tooltip/adversary_randomevent2.png"),
   adversary_randomevent3 = love.graphics.newImage("assets/image/tooltip/adversary_randomevent3.png"),
   adversary_randomevent4 = love.graphics.newImage("assets/image/tooltip/adversary_randomevent4.png"),
   -- tooltip evidence
   evidence_document1 = love.graphics.newImage("assets/image/tooltip/evidence_document1.png"),
   evidence_document2 = love.graphics.newImage("assets/image/tooltip/evidence_document2.png"),
   evidence_document3 = love.graphics.newImage("assets/image/tooltip/evidence_document3.png"),

   evidence_tape1 = love.graphics.newImage("assets/image/tooltip/evidence_tape1.png"),
   evidence_tape2 = love.graphics.newImage("assets/image/tooltip/evidence_tape2.png"),
   evidence_tape3 = love.graphics.newImage("assets/image/tooltip/evidence_tape3.png"),

   evidence_video1 = love.graphics.newImage("assets/image/tooltip/evidence_video1.png"),
   evidence_video2 = love.graphics.newImage("assets/image/tooltip/evidence_video2.png"),
   evidence_video3 = love.graphics.newImage("assets/image/tooltip/evidence_video3.png"),

   evidence_photo1 = love.graphics.newImage("assets/image/tooltip/evidence_photo1.png"),
   evidence_photo2 = love.graphics.newImage("assets/image/tooltip/evidence_photo2.png"),
   evidence_photo3 = love.graphics.newImage("assets/image/tooltip/evidence_photo3.png"),

   evidence_secretsource1 = love.graphics.newImage("assets/image/tooltip/evidence_secretsource1.png"),
   evidence_secretsource2 = love.graphics.newImage("assets/image/tooltip/evidence_secretsource2.png"),
   evidence_secretsource3 = love.graphics.newImage("assets/image/tooltip/evidence_secretsource3.png"),

   evidence_publicsource1 = love.graphics.newImage("assets/image/tooltip/evidence_publicsource1.png"),
   evidence_publicsource2 = love.graphics.newImage("assets/image/tooltip/evidence_publicsource2.png"),
   evidence_publicsource3 = love.graphics.newImage("assets/image/tooltip/evidence_publicsource3.png"),

   pieceNewspaper = love.graphics.newImage("assets/pieces/journal.png"),
   pieceSource = love.graphics.newImage("assets/pieces/source.png"),
   pieceEvidence = love.graphics.newImage("assets/pieces/evidence.png"),
   pieceEnemy = love.graphics.newImage("assets/pieces/adversaire.png"),
   pieceAlly = love.graphics.newImage("assets/pieces/allies.png"),
   pieceCandidate = love.graphics.newImage("assets/pieces/candidat.png"),
   pieceJournalist = love.graphics.newImage("assets/pieces/journaliste.png"),

  timelineCursor = love.graphics.newImage("assets/image/curseur.png"),
  poof = love.graphics.newImage("assets/image/poof.png"),

  intro = love.graphics.newImage("assets/image/intro.jpg"),
  tuto = love.graphics.newImage("assets/image/tuto.jpg"),

  icon = love.image.newImageData("assets/image/icone.png"),
  mouseCursor = love.graphics.newImage("assets/image/MousePointer.png"),

  gameover = {
    win = love.graphics.newImage("assets/image/end_01.jpg"),
    standard = love.graphics.newImage("assets/image/end_02.jpg"),
    extremist = love.graphics.newImage("assets/image/end_03.jpg"),
    killed = love.graphics.newImage("assets/image/end_04.jpg")
  },

  combinations = {
	  financial = {
	  	IN = love.graphics.newImage("assets/pieces/combination1IN.png"),
	  	OUT = love.graphics.newImage("assets/pieces/combination1OUT.png")
	  },
	  world = {
	  	IN = love.graphics.newImage("assets/pieces/combination2IN.png"),
	  	OUT = love.graphics.newImage("assets/pieces/combination2OUT.png")
	  },
	  state = {
	  	IN = love.graphics.newImage("assets/pieces/combination3IN.png"),
	  	OUT = love.graphics.newImage("assets/pieces/combination3OUT.png")
	  },
	  sexual = {
	  	IN = love.graphics.newImage("assets/pieces/combination4IN.png"),
	  	OUT = love.graphics.newImage("assets/pieces/combination4OUT.png")
	  }
	},

  erase = love.graphics.newShader("assets/shaders/erase.glsl")
}
