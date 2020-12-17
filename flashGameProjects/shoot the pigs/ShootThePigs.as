package  {
	/*Copyright 2012 Cody Arnholt, all rights reserved*/
	import flash.display.MovieClip
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.Dictionary;
	import AchievementEvent;
	import ControlEvent;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.display.StageQuality;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	
	public class ShootThePigs extends MovieClip {
		//for debugging/sponsers
		private var invulnerable:Boolean = false;
		
		//objects involved with player
		private var player:PlayerShip;
		private var shotArray:Array = [];
		private var shotIterator:uint = 0;
		private var shootSpeed:uint = 15;//the smaller this number is the faster the fire rate
		private var shootIterator:uint = 15;
		private var refreshIterator:Boolean = false;
		private var playerExplosions:MovieClip = new MovieClip();//container for player explosions
		private var isMouseDown:Boolean = false;//for shooting
		
		//objects involved with pigs
		private var pigDelay:uint = 500;
		private var pigTimer:Timer = new Timer(pigDelay); 
		private var pigsOnScreen:uint = 0;
		private var pigArray:Array = [];
		private var pigIterator:uint = 0;
		private var explosions:Array = [];//container for pig explosions
		private var ironPigArray:Array = [];
		private var ironPigIterator:uint = 0;
		private var ironPigDelay:uint = 5000;
		private var ironPigTimer:Timer = new Timer(ironPigDelay);
		private var ironPigsOnScreen:uint = 0;
		private var basePigDamage:Number = 0;
		
		//objects involved with backgrounds
		private var bg1:Background;
		private var bg2:Background;
		
		//objects involved with game over screen
		private var gameOverObj:GameOverScreen;
		private var highScoreButton:MenuButton = new MenuButton();
		private var tryAgain:TryAgainButton;
		private var mainMenuButton:MenuButton = new MenuButton();
		private var score:FinalScore;
		private var gameOverContainer:MovieClip = new MovieClip();
		private var backDrop:GameOverBackDrop;
		private var gameOverTween:Tween;
		
		//objects involved with scoring
		private var pigsKilled:uint = 0;
		private var shotsFired:uint = 0;
		private var levelPigsKilled:uint = 0;
		private var levelShotsFired:uint = 0;
		private var pigsTillLevel:uint = 15;
		private var pigsLeft:uint = pigsTillLevel;
		private var comboMultiplier:uint = 1;
		private var scoreBubbles:MovieClip = new MovieClip();//container for score bubbles
		private var comboBubbles:MovieClip = new MovieClip();//container for combo bubbles
		private var comboTimer:Timer = new Timer(5000);
		private var totalScore:uint = 0;
		private var hasBeenHit:Boolean = false;
		
		//objects involved with achievements
		private var pigsKilledTimer:Timer = new Timer(30000);
		private var lastPigsKilled:uint = 0;
		
		//objects involved with instruction screen
		private var instructionBackdrop:InstructionBackdrop = new InstructionBackdrop();
		private var instructionText:InstructionScreen = new InstructionScreen();
		private var instructionScreenMenuButton:MenuButton = new MenuButton();
		private var instructionScreen:MovieClip = new MovieClip();//container for instruction screen
		
		//objects involved with credits screen
		private var creditBackdrop:CreditBackdrop = new CreditBackdrop();
		private var creditsText:CreditsText = new CreditsText();
		private var creditsMenuButton:MenuButton = new MenuButton();
		private var creditsScreen:MovieClip = new MovieClip();
		
		//objects involved with bacon screen
		private var baconBackdrop:BaconBackdrop = new BaconBackdrop();
		private var baconText:BaconText = new BaconText();
		private var baconMenuButton:MenuButton = new MenuButton();
		private var trophies:Array = [];//array for holding trophies
		private var baconScreen:MovieClip = new MovieClip();
		
		//objects involved with hud
		private var levelTextObj:LevelText = new LevelText();
		private var levelTextNumObj:LevelNumber = new LevelNumber();
		private var levelNum:uint = 1;
		private var hud:MovieClip = new MovieClip();
		private var healthMeter:HealthMeter = new HealthMeter();
		private var shieldMeter:ShieldMeter = new ShieldMeter();
		private const origHealthIncrement:Number = .01;
		private const origShieldIncrement:Number = .05
		private var healthIncrement:Number;
		private var shieldIncrement:Number;
		private var shieldRegenTimer:Timer;
		private var shieldRegenDelay:uint = 1000;
		private var shieldRegenIncrement:Number;
		private const origShieldRegenIncrement:Number = .01;
		private var healthRegenTimer:Timer;
		private var healthRegenDelay:uint = 1000;
		private var healthRegenIncrement:Number;
		private const origHealthRegenIncrement:Number = 0;
		
		//objects involved with upgrade screen
		private var upgradeBackdrop:UpgradeBackdrop = new UpgradeBackdrop();
		private var upgradeText:UpgradeText = new UpgradeText();
		private var belliesText:BelliesText = new BelliesText();
		private var beamLevelText:BeamLevelText = new BeamLevelText();
		private var beamUpgradeButton:UpgradeButton = new UpgradeButton();
		private var nextLevelButton:NextLevelButton = new NextLevelButton();
		private var upgradeContainer:MovieClip = new MovieClip();
		private var upgradeTween:Tween;
		private var beamLevelNum:uint = 1;
		private var numBellies:uint = 0;
		private var beamUpgradeCost:uint = 25;
		private var shieldLevelNum:uint = 1;
		private var shieldRegenLevelNum:uint = 1;
		private var armorLevelNum:uint = 1;
		private var healthRegenLevelNum:uint = 1;
		private var shieldCost:uint = 25;
		private var shieldRegenCost:uint = 25;
		private var armorCost:uint = 25;
		private var healthRegenCost:uint = 25;
		private var shieldUpgradeButton:UpgradeButton = new UpgradeButton();
		private var shieldRegenUpgradeButton:UpgradeButton = new UpgradeButton();
		private var armorUpgradeButton:UpgradeButton = new UpgradeButton();
		private var healthRegenUpgradeButton:UpgradeButton = new UpgradeButton();
		private var beamSpeedUpgradeButton:UpgradeButton = new UpgradeButton();
		private var beamSizeUpgradeButton:UpgradeButton = new UpgradeButton();
		private var beamSizeLevelNum:uint = 1;
		private var beamSizeCost:uint = 25;
		private var beamSpeedLevelNum:uint = 1;
		private var beamSpeedCost:uint = 25;
		private var beamBubble:InfoBubble = new InfoBubble();
		private var beamSpeedBubble:InfoBubble = new InfoBubble();
		private var beamSizeBubble:InfoBubble = new InfoBubble();
		private var healthRegenBubble:InfoBubble = new InfoBubble();
		private var shieldRegenBubble:InfoBubble = new InfoBubble();
		private var armorBubble:InfoBubble = new InfoBubble();
		private var shieldBubble:InfoBubble = new InfoBubble();
		private var bellyTimer:Timer = new Timer(10);//for animating pork belly tallying
		private var bellyCount:uint = 0;
		private var levelCompleteBubble:LevelCompleteBubble = new LevelCompleteBubble();
		private var levelBubbleTimer:Timer = new Timer(1000);
		
		//objects involved with main menu
		private var mainMenuText:MainMenuText = new MainMenuText();
		private var playGameButton:MenuButton = new MenuButton();
		private var howToButton:MenuButton = new MenuButton();
		private var baconButton:MenuButton = new MenuButton();
		private var creditsButton:MenuButton = new MenuButton();
		private var optionsButton:MenuButton = new MenuButton();
		private var invulnerableButton:InvulnerableButton = new InvulnerableButton();
		private var moreGamesButton:MoreGamesButton = new MoreGamesButton();
		private var mainMenu:MovieClip = new MovieClip;//container for main menu
		
		//objects involved with options screen
		private var lowButton:MenuButton = new MenuButton();
		private var medButton:MenuButton = new MenuButton();
		private var highButton:MenuButton = new MenuButton();
		private var optionReturnButton:MenuButton = new MenuButton();
		private var optionText:OptionText = new OptionText();
		private var optionBackdrop:OptionScreenBackdrop = new OptionScreenBackdrop();
		private var muteFx:Boolean = false;
		private var muteMusic:Boolean = false;
		private var optionScreen:MovieClip = new MovieClip();
		
		//objects involved with pause screen
		private var continueButton:MenuButton = new MenuButton();
		private var pauseOptionsButton:MenuButton = new MenuButton();
		private var pauseScreen:MovieClip = new MovieClip();
		
		//objects involeved with best game screen
		private var bestGames:BestGameScreen = new BestGameScreen();
		private var highscoreReturnButton:MenuButton = new MenuButton();
		private var bestGameList:Array = [" "," "," "," "," "];
		private var bestScoreList:Array = [0,0,0,0,0];
		private var bestGameScreen:MovieClip = new MovieClip();//Container for best game screen
		
		//objects involved with achievments
		private var hasOinker:Boolean = false;
		private var hasSlaughterHouse:Boolean = false;
		private var hasMakinBacon:Boolean = false;
		private var hasSpeedyBacon:Boolean = false;
		private var hasSuperSonicBacon:Boolean = false;
		private var hasLightSpeedBacon:Boolean = false;
		private var hasSurvivalist:Boolean = false;
		private var hasBigBadWolf:Boolean = false;
		private var hasPigocolypse:Boolean = false;
		
		//objects involved with keyboard controls
		private var isPaused:Boolean = false;
		private var mute:Boolean = false;
		
		
		//CONSTRUCTOR
		public function ShootThePigs() {
			addEventListener(Event.ADDED_TO_STAGE,gameStart);
		}
		
		private function gameStart(e:Event):void {
			if (stage != null) {
				//preloader
				var backdrop:PreloaderBackdrop = new PreloaderBackdrop();
				var preloader:PreloaderPig = new PreloaderPig(this.stage);
				stage.addChild(backdrop);
				stage.addChild(preloader);
				removeEventListener(Event.ADDED_TO_STAGE,gameStart);
				var sponsorSplash = new SponsorSplash();
				
				//set up player
				player = new PlayerShip();
				player.visible = false;
				
				//set up achievements
				this.pigsKilledTimer.addEventListener(TimerEvent.TIMER,onPigsKilledTimer);
				this.pigsKilledTimer.start();
				
				// Set up backgrounds
				bg1 = new Background();
				bg2 = new Background();
				bg1.x = 0;
				bg1.y = 0;
				bg2.x = 2000;
				bg2.y = 0;
				bg2.flip();
				
				//setup main menu
				this.playGameButton.buttonText.text = "PLAY";
				this.playGameButton.x = 150;
				this.playGameButton.y = 310;
				this.howToButton.buttonText.text = "HOW-TO";
				this.howToButton.x = 350;
				this.howToButton.y = 310;
				this.baconButton.buttonText.text = "BACON";
				this.baconButton.x = 550;
				this.baconButton.y = 310;
				this.creditsButton.buttonText.text = "CREDITS"
				this.creditsButton.x = 550;
				this.creditsButton.y = 365;
				this.optionsButton.buttonText.text = "OPTIONS";
				this.optionsButton.x = 150;
				this.optionsButton.y = 365;
				this.mainMenu.addChild(this.mainMenuText);
				this.mainMenu.addChild(this.howToButton);
				this.mainMenu.addChild(this.baconButton);
				this.mainMenu.addChild(this.playGameButton);
				this.mainMenu.addChild(this.creditsButton);
				this.mainMenu.addChild(this.optionsButton);
				this.mainMenu.addChild(this.moreGamesButton);
				this.mainMenu.addChild(this.invulnerableButton);
				this.optionsButton.addEventListener(MouseEvent.CLICK,options);
				this.moreGamesButton.addEventListener(MouseEvent.CLICK,moreGames);
				this.howToButton.addEventListener(MouseEvent.CLICK, howTo);
				this.playGameButton.addEventListener(MouseEvent.CLICK, playGame);
				this.creditsButton.addEventListener(MouseEvent.CLICK, credits);
				this.baconButton.addEventListener(MouseEvent.CLICK, bacon);
				this.invulnerableButton.addEventListener(MouseEvent.CLICK,onInvulnerable);
				
				//setup instruction screen
				this.instructionScreenMenuButton.buttonText.text = "RETURN";
				this.instructionScreenMenuButton.x = 350;
				this.instructionScreenMenuButton.y = 365;
				this.instructionScreenMenuButton.width *= .75;
				this.instructionScreenMenuButton.height *= .75;
				this.instructionScreen.addChild(this.instructionBackdrop);
				this.instructionScreen.addChild(this.instructionText);
				this.instructionScreen.addChild(this.instructionScreenMenuButton);
				
				//setup credits screen
				this.creditsMenuButton.buttonText.text = "RETURN";
				this.creditsMenuButton.x = 350;
				this.creditsMenuButton.y = 365;
				this.creditsMenuButton.width *= .75;
				this.creditsMenuButton.height *= .75;
				this.creditsScreen.addChild(this.creditBackdrop);
				this.creditsScreen.addChild(this.creditsText);
				this.creditsScreen.addChild(this.creditsMenuButton);
				
				//setup bacon screen
				this.baconMenuButton.buttonText.text = "RETURN";
				this.baconMenuButton.x = 350;
				this.baconMenuButton.y = 265;
				this.baconMenuButton.width *= .75;
				this.baconMenuButton.height *= .75;
				for (var iterator=0;iterator<9;iterator++) {
					this.trophies[iterator] = new Trophy();
					this.trophies[iterator].visible = false;
				}
				this.trophies[0].x = 200;
				this.trophies[0].y = 70;
				this.trophies[1].x = 425;
				this.trophies[1].y = 70;
				this.trophies[2].x = 650;
				this.trophies[2].y = 70;
				this.trophies[3].x = 200;
				this.trophies[3].y = 200;
				this.trophies[4].x = 425;
				this.trophies[4].y = 200;
				this.trophies[5].x = 650;
				this.trophies[5].y = 200;
				this.trophies[6].x = 200;
				this.trophies[6].y = 330;
				this.trophies[7].x = 425;
				this.trophies[7].y = 330;
				this.trophies[8].x = 650;
				this.trophies[8].y = 330;
				this.baconScreen.addChild(this.baconBackdrop);
				this.baconScreen.addChild(this.baconText);
				for (var trophy in trophies) {
					this.baconScreen.addChild(trophies[trophy]);
				}
				this.baconScreen.addChild(this.baconMenuButton);
				
				//setup game over screen
				gameOverObj = new GameOverScreen();
				tryAgain = new TryAgainButton();
				this.mainMenuButton.buttonText.text = "MENU";
				this.highScoreButton.buttonText.text = "SCORES";
				this.highScoreButton.x = 405;
				this.highScoreButton.y = 300;
				this.mainMenuButton.x = 405;
				this.mainMenuButton.y = 350;
				this.mainMenuButton.addEventListener(MouseEvent.CLICK, returnToMainMenu);
				score = new FinalScore("");
				backDrop = new GameOverBackDrop();
				tryAgain.addEventListener(MouseEvent.CLICK, newGame);
				gameOverContainer.addChild(backDrop);
				gameOverContainer.addChild(score);
				gameOverContainer.addChild(gameOverObj);
				gameOverContainer.addChild(tryAgain);
				gameOverContainer.addChild(this.highScoreButton);
				highScoreButton.addEventListener(MouseEvent.CLICK,highScores);
				gameOverContainer.addChild(this.mainMenuButton);
				gameOverContainer.width -= 100;
				
				//setup options screen
				this.optionReturnButton.buttonText.text = "RETURN";
				this.optionReturnButton.x = 350;
				this.optionReturnButton.y = 344;
				this.lowButton.buttonText.text = "LOW";
				this.lowButton.x = 208;
				this.lowButton.y = 101.35;
				this.medButton.buttonText.text = "MEDIUM";
				this.medButton.x = 350;
				this.medButton.y = 101.35;
				this.highButton.buttonText.text = "HIGH";
				this.highButton.x = 491.95;
				this.highButton.y = 101.35;
				this.optionText.soundOn.text = "X";
				this.optionText.musicOn.text = "X";
				this.optionScreen.addChild(optionBackdrop);
				this.optionScreen.addChild(optionText);
				this.optionScreen.addChild(optionReturnButton);
				this.optionScreen.addChild(lowButton);
				this.optionScreen.addChild(medButton);
				this.optionScreen.addChild(highButton); 
				
				//setup upgrade screen
				beamUpgradeButton.x = 60;
				beamUpgradeButton.y = 192;
				beamLevelText.beamLevel.text = this.beamLevelNum.toString();
				belliesText.numBellies.text = this.numBellies.toString();
				upgradeText.beamCost.text = this.beamUpgradeCost.toString();
				upgradeText.shieldLevel.text = this.shieldLevelNum.toString();
				upgradeText.shieldRegenLevel.text = this.shieldRegenLevelNum.toString();
				upgradeText.armorLevel.text = this.armorLevelNum.toString();
				upgradeText.healthRegenLevel.text = this.healthRegenLevelNum.toString();
				upgradeText.shieldCost.text = this.shieldCost.toString();
				upgradeText.shieldRegenCost.text = this.shieldRegenCost.toString();
				upgradeText.armorCost.text = this.armorCost.toString();
				upgradeText.healthRegenCost.text = this.healthRegenCost.toString();
				upgradeText.beamSizeLevel.text = this.beamSizeLevelNum.toString();
				upgradeText.beamSizeCost.text = this.beamSizeCost.toString();
				upgradeText.beamSpeedLevel.text = this.beamSpeedLevelNum.toString();
				upgradeText.beamSpeedCost.text = this.beamSpeedCost.toString();
				this.beamSizeUpgradeButton.x = 525;
				this.beamSizeUpgradeButton.y = 304.25;
				this.beamSpeedUpgradeButton.x = 60;
				this.beamSpeedUpgradeButton.y = 304.25;
				this.shieldUpgradeButton.x = 300;
				this.shieldUpgradeButton.y = 65;
				this.shieldRegenUpgradeButton.x = 525;
				this.shieldRegenUpgradeButton.y = 65;
				this.armorUpgradeButton.x = 300;
				this.armorUpgradeButton.y = 192;
				this.healthRegenUpgradeButton.x = 525;
				this.healthRegenUpgradeButton.y = 192;
				this.beamBubble.bubbleText.text = "INCREASES HOW OFTEN YOU SHOOT";
				this.beamSizeBubble.bubbleText.text = "INCREASES THE SIZE OF THE BEAM";
				this.beamSpeedBubble.bubbleText.text = "MAKES EACH BEAM MOVE FASTER ACROSS THE SCREEN";
				this.healthRegenBubble.bubbleText.text = "INCREASES HEALTH POINTS RECEIVED ON REGEN";
				this.armorBubble.bubbleText.text = "LOWERS DAMAGE TAKEN TO HEALTH FROM PIGS";
				this.shieldBubble.bubbleText.text = "LOWERS DAMAGE TAKEN TO SHIELDS FROM PIGS";
				this.shieldRegenBubble.bubbleText.text = "INCREASES SHIELD POINTS RECIEVED ON REGEN";
				this.shieldBubble.visible = false;
				this.shieldRegenBubble.visible = false;
				this.armorBubble.visible = false;
				this.healthRegenBubble.visible = false;
				this.beamBubble.visible = false;
				this.beamSpeedBubble.visible = false;
				this.beamSizeBubble.visible = false;
				this.levelCompleteBubble.visible = false;
				upgradeContainer.addChild(upgradeBackdrop);
				upgradeContainer.addChild(shieldRegenBubble);
				upgradeContainer.addChild(shieldBubble);
				upgradeContainer.addChild(armorBubble);
				upgradeContainer.addChild(healthRegenBubble);
				upgradeContainer.addChild(beamSpeedBubble);
				upgradeContainer.addChild(beamSizeBubble);
				upgradeContainer.addChild(beamBubble);
				upgradeContainer.addChild(upgradeText);
				upgradeContainer.addChild(beamLevelText);
				upgradeContainer.addChild(belliesText);
				upgradeContainer.addChild(beamUpgradeButton);
				upgradeContainer.addChild(this.shieldUpgradeButton);
				upgradeContainer.addChild(this.shieldRegenUpgradeButton);
				upgradeContainer.addChild(this.armorUpgradeButton);
				upgradeContainer.addChild(this.healthRegenUpgradeButton);
				upgradeContainer.addChild(this.beamSizeUpgradeButton);
				upgradeContainer.addChild(this.beamSpeedUpgradeButton);
				upgradeContainer.addChild(nextLevelButton);
				
				//setup pigs
				for (var k=0;k<30;k++) {
					var pig = new Pig(this.stage);
					pigArray.push(pig);
				}
				stage.dispatchEvent(new ControlEvent("invisPig"));
				pigTimer.addEventListener(TimerEvent.TIMER, addPig);//listener to add new pigs
				for (var i=0;i<5;i++) {
					var ironPig = new IronPig(this.player,this.stage);
					ironPigArray.push(ironPig);
				}
				stage.dispatchEvent(new ControlEvent("invisIronPig"));
				ironPigTimer.addEventListener(TimerEvent.TIMER, addIronPig);//same, for iron pigs
				
				//setup beams
				for (var j=0;j<15;j++) {
					var beam = new PlayerBeam1(0,0,this.stage);
					shotArray.push(beam);
				}
				stage.dispatchEvent(new ControlEvent("invisBeam"));
				
				//set up hud
				this.levelTextNumObj.levelText.text = this.levelNum.toString();
				this.levelTextObj.pigsLeftText.text = this.pigsLeft.toString();
				this.levelTextObj.scoreText.text = this.totalScore.toString();
				hud.addChild(this.levelTextObj);
				hud.addChild(this.levelTextNumObj);
				hud.addChild(this.healthMeter);
				hud.addChild(this.shieldMeter);
				hud.visible = false;
				
				this.shieldIncrement = this.origShieldIncrement;
				this.healthIncrement = this.origHealthIncrement;
				this.shieldRegenIncrement = this.origShieldRegenIncrement;
				this.healthRegenIncrement = this.origHealthRegenIncrement;
				this.shieldRegenTimer = new Timer(this.shieldRegenDelay);
				this.shieldRegenTimer.addEventListener(TimerEvent.TIMER, regenShield);
				this.healthRegenTimer = new Timer(this.healthRegenDelay);
				this.healthRegenTimer.addEventListener(TimerEvent.TIMER, regenHealth);
				
				//setup pause screen
				this.continueButton.buttonText.text = "UNPAUSE";
				this.continueButton.x = 350;
				this.continueButton.y = 200;
				this.pauseOptionsButton.buttonText.text = "OPTIONS";
				this.pauseOptionsButton.x = 350;
				this.pauseOptionsButton.y = 250;
				this.pauseScreen.addChild(this.continueButton);
				this.pauseScreen.addChild(this.pauseOptionsButton);
				this.pauseScreen.visible = false;
				
				//setup best game screen
				this.highscoreReturnButton.buttonText.text = "RETURN";
				this.highscoreReturnButton.x = 350;
				this.highscoreReturnButton.y = 330;
				this.bestGameScreen.addChild(this.bestGames);
				this.bestGameScreen.addChild(this.highscoreReturnButton);
				this.bestGameScreen.visible = false;
				
				//for contolling menu visibility
				stage.addEventListener(ControlEvent.invisMenus,onInvisMenus);
				dispatchEvent(new ControlEvent("invisMenus"));
				this.mainMenu.visible = true;
				
				//setup scoring
				this.comboTimer.addEventListener(TimerEvent.TIMER,onComboTimer);
				
				//setup stage, layer elements in display order
				stage.addChild(bg1);
				stage.addChild(bg2);
				stage.addChild(mainMenu);
				stage.addChild(this.creditsScreen);
				stage.addChild(this.instructionScreen);
				stage.addChild(this.baconScreen);
				for (var n in pigArray) {
					stage.addChild(pigArray[n]);
				}
				for (var m in shotArray) {
					stage.addChild(shotArray[m]);
				}
				for (var o in ironPigArray) {
					stage.addChild(ironPigArray[o]);
				}
				stage.addChild(player);
				stage.addChild(this.comboBubbles);
				stage.addChild(this.scoreBubbles);
				stage.addChild(hud);
				stage.addChild(this.playerExplosions);
				stage.addChild(gameOverContainer);
				stage.addChild(upgradeContainer);
				stage.addChild(this.levelCompleteBubble);
				stage.addChild(pauseScreen);
				stage.addChild(this.bestGameScreen);
				stage.addChild(this.optionScreen);
				stage.addChild(sponsorSplash);
				//stage listeners
				stage.addEventListener(Event.ENTER_FRAME, eFrame);//listener to increment game
				stage.addEventListener(MouseEvent.MOUSE_DOWN, setMouseDown);//listener to fire bullets
				stage.addEventListener(MouseEvent.MOUSE_UP, setMouseUp);
				stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
				//achievement listeners
				stage.addEventListener(AchievementEvent.bigBadWolf, bigBadWolf);
				stage.addEventListener(AchievementEvent.lightSpeedBacon, lightSpeedBacon);
				stage.addEventListener(AchievementEvent.makinBacon, makinBacon);
				stage.addEventListener(AchievementEvent.oinker, oinker);
				stage.addEventListener(AchievementEvent.pigocolypse, pigocolypse);
				stage.addEventListener(AchievementEvent.slaughterHouse, slaughterHouse);
				stage.addEventListener(AchievementEvent.speedyBacon, speedyBacon);
				stage.addEventListener(AchievementEvent.superSonicBacon, superSonicBacon);
				stage.addEventListener(AchievementEvent.survivalist, survivalist);
			}
		}
		
		private function onComboTimer(e:TimerEvent):void {
			if (this.hasBeenHit == false) {
				this.comboMultiplier++;
				this.comboBubbles.addChild(new ComboBubble(player.x, player.y - 30, comboMultiplier.toString()));
			} else {
				this.comboMultiplier = 1;
			}
			this.hasBeenHit = false;
		}
		
		private function onKeyPress(e:KeyboardEvent):void {
			var keyPressed = e.keyCode.toString();
			switch (keyPressed) {
				//restart hotkey "r"
				case "82":
					newGame(null);
					break;
				
				//menu hotkey "m"
				case "77":
				//menu hotkey "m"
					returnToMainMenu(null);
					break;
					
				//pause hotkey "p"
				case "80":
					if (this.gameOverContainer.visible == false && this.upgradeContainer.visible == false && this.mainMenu.visible == false) {
						if (this.isPaused == false) {
							this.isPaused = true;
							this.pauseScreen.visible = true;
							this.continueButton.addEventListener(MouseEvent.CLICK,onContinue);
							this.pauseOptionsButton.addEventListener(MouseEvent.CLICK,onPauseOptions);
							Mouse.show();
						} else {
							this.isPaused = false;
							this.pauseScreen.visible = false;
							this.continueButton.removeEventListener(MouseEvent.CLICK,onContinue);
							this.pauseOptionsButton.removeEventListener(MouseEvent.CLICK,onPauseOptions);
							Mouse.hide();
						}
						stage.dispatchEvent(new ControlEvent("onPause"));
						toggleTimers();
					}
					break;
					
				//mute hotkey "s"
				case "83":
					if (this.mute == false) {
						this.mute = true;
					} else {
						this.mute = false;
					}
					stage.dispatchEvent(new ControlEvent("toggleMute"));
					break;
			}
		}
		
		private function playGame(e:MouseEvent):void {
			Mouse.hide();
			this.hud.visible = true;
			this.mainMenu.visible = false;
			this.playGameButton.removeEventListener(MouseEvent.CLICK,playGame);
			this.howToButton.removeEventListener(MouseEvent.CLICK,howTo);
			this.creditsButton.removeEventListener(MouseEvent.CLICK,credits);
			this.baconButton.removeEventListener(MouseEvent.CLICK,bacon);
			this.invulnerableButton.removeEventListener(MouseEvent.CLICK,onInvulnerable);
			this.optionsButton.removeEventListener(MouseEvent.CLICK,options);
			this.moreGamesButton.removeEventListener(MouseEvent.CLICK,moreGames);
			newGame(null);
		}
		
		private function credits(e:MouseEvent):void {
			this.creditsScreen.visible = true;
			this.creditsMenuButton.addEventListener(MouseEvent.CLICK,returnToMainMenu);
		}
		
		private function bacon(e:MouseEvent):void {
			this.baconScreen.visible = true;
			this.baconMenuButton.addEventListener(MouseEvent.CLICK,returnToMainMenu);
		}
		
		private function howTo(e:MouseEvent):void {
			this.instructionScreen.visible = true;
			this.instructionScreenMenuButton.addEventListener(MouseEvent.CLICK,returnToMainMenu)
		}
		
		private function options(e:MouseEvent):void {
			this.optionScreen.visible = true;
			this.optionReturnButton.addEventListener(MouseEvent.CLICK,returnToMainMenu);
			this.lowButton.addEventListener(MouseEvent.CLICK,onLow);
			this.medButton.addEventListener(MouseEvent.CLICK,onMed);
			this.highButton.addEventListener(MouseEvent.CLICK,onHigh);
			this.optionText.soundOn.addEventListener(MouseEvent.CLICK,soundOn);
			this.optionText.soundOn.addEventListener(MouseEvent.MOUSE_OVER,onMuteControlOver);
			this.optionText.soundOn.addEventListener(MouseEvent.MOUSE_OUT,onMuteControlOut);
			this.optionText.soundOff.addEventListener(MouseEvent.CLICK,soundOff);
			this.optionText.soundOff.addEventListener(MouseEvent.MOUSE_OVER,onMuteControlOver);
			this.optionText.soundOff.addEventListener(MouseEvent.MOUSE_OUT,onMuteControlOut);
			this.optionText.musicOn.addEventListener(MouseEvent.CLICK,musicOn);
			this.optionText.musicOn.addEventListener(MouseEvent.MOUSE_OVER,onMuteControlOver);
			this.optionText.musicOn.addEventListener(MouseEvent.MOUSE_OUT,onMuteControlOut);
			this.optionText.musicOff.addEventListener(MouseEvent.CLICK,musicOff);
			this.optionText.musicOff.addEventListener(MouseEvent.MOUSE_OVER,onMuteControlOver);
			this.optionText.musicOff.addEventListener(MouseEvent.MOUSE_OUT,onMuteControlOut);
		}
		
		private function onPauseOptions(e:MouseEvent):void {
			this.optionScreen.visible = true;
			this.pauseOptionsButton.removeEventListener(MouseEvent.CLICK,onPauseOptions);
			this.optionReturnButton.addEventListener(MouseEvent.CLICK,returnToGame);
			this.lowButton.addEventListener(MouseEvent.CLICK,onLow);
			this.medButton.addEventListener(MouseEvent.CLICK,onMed);
			this.highButton.addEventListener(MouseEvent.CLICK,onHigh);
			this.optionText.soundOn.addEventListener(MouseEvent.CLICK,soundOn);
			this.optionText.soundOn.addEventListener(MouseEvent.MOUSE_OVER,onMuteControlOver);
			this.optionText.soundOn.addEventListener(MouseEvent.MOUSE_OUT,onMuteControlOut);
			this.optionText.soundOff.addEventListener(MouseEvent.CLICK,soundOff);
			this.optionText.soundOff.addEventListener(MouseEvent.MOUSE_OVER,onMuteControlOver);
			this.optionText.soundOff.addEventListener(MouseEvent.MOUSE_OUT,onMuteControlOut);
			this.optionText.musicOn.addEventListener(MouseEvent.CLICK,musicOn);
			this.optionText.musicOn.addEventListener(MouseEvent.MOUSE_OVER,onMuteControlOver);
			this.optionText.musicOn.addEventListener(MouseEvent.MOUSE_OUT,onMuteControlOut);
			this.optionText.musicOff.addEventListener(MouseEvent.CLICK,musicOff);
			this.optionText.musicOff.addEventListener(MouseEvent.MOUSE_OVER,onMuteControlOver);
			this.optionText.musicOff.addEventListener(MouseEvent.MOUSE_OUT,onMuteControlOut);
		}
		
		private function returnToGame(e:MouseEvent):void {
			this.optionScreen.visible = false;
			this.pauseOptionsButton.addEventListener(MouseEvent.CLICK,onPauseOptions);
			this.optionReturnButton.removeEventListener(MouseEvent.CLICK,returnToGame);
			this.lowButton.removeEventListener(MouseEvent.CLICK,onLow);
			this.medButton.removeEventListener(MouseEvent.CLICK,onMed);
			this.highButton.removeEventListener(MouseEvent.CLICK,onHigh);
			this.optionText.soundOn.removeEventListener(MouseEvent.CLICK,soundOn);
			this.optionText.soundOn.removeEventListener(MouseEvent.MOUSE_OVER,onMuteControlOver);
			this.optionText.soundOn.removeEventListener(MouseEvent.MOUSE_OUT,onMuteControlOut);
			this.optionText.soundOff.removeEventListener(MouseEvent.CLICK,soundOff);
			this.optionText.soundOff.removeEventListener(MouseEvent.MOUSE_OVER,onMuteControlOver);
			this.optionText.soundOff.removeEventListener(MouseEvent.MOUSE_OUT,onMuteControlOut);
			this.optionText.musicOn.removeEventListener(MouseEvent.CLICK,musicOn);
			this.optionText.musicOn.removeEventListener(MouseEvent.MOUSE_OVER,onMuteControlOver);
			this.optionText.musicOn.removeEventListener(MouseEvent.MOUSE_OUT,onMuteControlOut);
			this.optionText.musicOff.removeEventListener(MouseEvent.CLICK,musicOff);
			this.optionText.musicOff.removeEventListener(MouseEvent.MOUSE_OVER,onMuteControlOver);
			this.optionText.musicOff.removeEventListener(MouseEvent.MOUSE_OUT,onMuteControlOut);
		}
		
		private function onMuteControlOut(e:MouseEvent):void {
			Mouse.cursor = "auto";
		}
		
		private function onMuteControlOver(e:MouseEvent):void {
			Mouse.cursor = "button";
		}
				
		private function onLow(e:MouseEvent):void {
			stage.quality = StageQuality.LOW;
		}
		
		private function onMed(e:MouseEvent):void {
			stage.quality = StageQuality.MEDIUM;
		}
		
		private function onHigh(e:MouseEvent):void {
			stage.quality = StageQuality.BEST;
		}
		
		private function soundOn(e:MouseEvent):void {
			this.optionText.soundOn.text = "X";
			this.optionText.soundOff.text = "";
			this.muteFx = false;
		}
		
		private function soundOff(e:MouseEvent):void {
			this.optionText.soundOn.text = "";
			this.optionText.soundOff.text = "X";
			this.muteFx = true;
		}
		
		private function musicOn(e:MouseEvent):void {
			this.optionText.musicOn.text = "X";
			this.optionText.musicOff.text = "";
			this.muteMusic = false;
		}
		
		private function musicOff(e:MouseEvent):void {
			this.optionText.musicOn.text = "";
			this.optionText.musicOff.text = "X";
			this.muteMusic = true;
		}
		
		private function moreGames(e:MouseEvent):void {
			
		}
		
		private function returnToMainMenu(e:MouseEvent):void {
			if (this.isPaused == true) {
				this.isPaused = false;
				stage.dispatchEvent(new ControlEvent("onPause"));
			}
			this.player.visible = false
			stage.dispatchEvent(new ControlEvent("invisPig"));
			stage.dispatchEvent(new ControlEvent("invisIronPig"));
			stage.dispatchEvent(new ControlEvent("invisExplosions"));
			stage.dispatchEvent(new ControlEvent("invisBeam"));
			this.howToButton.addEventListener(MouseEvent.CLICK, howTo);
			this.playGameButton.addEventListener(MouseEvent.CLICK, playGame);
			this.creditsButton.addEventListener(MouseEvent.CLICK, credits);
			this.baconButton.addEventListener(MouseEvent.CLICK, bacon);
			this.optionsButton.addEventListener(MouseEvent.CLICK,options);
			this.moreGamesButton.addEventListener(MouseEvent.CLICK,moreGames);
			this.invulnerableButton.addEventListener(MouseEvent.CLICK,onInvulnerable);
			this.hud.visible = false;
			if (this.instructionScreenMenuButton.hasEventListener(MouseEvent.CLICK)) {
				this.instructionScreenMenuButton.removeEventListener(MouseEvent.CLICK,returnToMainMenu);
			}
			if (this.creditsMenuButton.hasEventListener(MouseEvent.CLICK)) {
				this.creditsMenuButton.removeEventListener(MouseEvent.CLICK,returnToMainMenu);
			}
			if (this.baconMenuButton.hasEventListener(MouseEvent.CLICK)) {
				this.baconMenuButton.removeEventListener(MouseEvent.CLICK,returnToMainMenu);
			}
			if (this.pigTimer.running == true) {
				toggleTimers();
			}
			if (this.optionReturnButton.hasEventListener(MouseEvent.CLICK)) {
				this.optionReturnButton.removeEventListener(MouseEvent.CLICK,returnToMainMenu);
			}
			if (this.lowButton.hasEventListener(MouseEvent.CLICK)) {
				this.lowButton.removeEventListener(MouseEvent.CLICK,onLow);
			}
			if (this.medButton.hasEventListener(MouseEvent.CLICK)) {
				this.medButton.removeEventListener(MouseEvent.CLICK,onMed);
			}
			if (this.highButton.hasEventListener(MouseEvent.CLICK)) {
				this.highButton.removeEventListener(MouseEvent.CLICK,onHigh);
			}
			if (this.optionText.soundOn.hasEventListener(MouseEvent.CLICK)) {
				this.optionText.soundOn.removeEventListener(MouseEvent.CLICK,soundOn);
			}
			if (this.optionText.soundOn.hasEventListener(MouseEvent.MOUSE_OVER)) {
				this.optionText.soundOn.removeEventListener(MouseEvent.MOUSE_OVER,onMuteControlOver);
			}
			if (this.optionText.soundOn.hasEventListener(MouseEvent.MOUSE_OUT)) {
				this.optionText.soundOn.removeEventListener(MouseEvent.MOUSE_OUT,onMuteControlOut);
			}
			if (this.optionText.soundOff.hasEventListener(MouseEvent.CLICK)) {
				this.optionText.soundOff.removeEventListener(MouseEvent.CLICK,soundOff);
			}
			if (this.optionText.soundOff.hasEventListener(MouseEvent.MOUSE_OVER)) {
				this.optionText.soundOff.removeEventListener(MouseEvent.MOUSE_OVER,onMuteControlOver);
			}
			if (this.optionText.soundOff.hasEventListener(MouseEvent.MOUSE_OUT)) {
				this.optionText.soundOff.removeEventListener(MouseEvent.MOUSE_OUT,onMuteControlOut);
			}
			if (this.optionText.musicOn.hasEventListener(MouseEvent.CLICK)) {
				this.optionText.musicOn.removeEventListener(MouseEvent.CLICK,musicOn);
			}
			if (this.optionText.musicOn.hasEventListener(MouseEvent.MOUSE_OVER)) {
				this.optionText.musicOn.removeEventListener(MouseEvent.MOUSE_OVER,onMuteControlOver);
			}
			if (this.optionText.musicOn.hasEventListener(MouseEvent.MOUSE_OUT)) {
				this.optionText.musicOn.removeEventListener(MouseEvent.MOUSE_OUT,onMuteControlOut);
			}
			if (this.optionText.musicOff.hasEventListener(MouseEvent.CLICK)) {
				this.optionText.musicOff.removeEventListener(MouseEvent.CLICK,musicOff);
			}
			if (this.optionText.musicOff.hasEventListener(MouseEvent.MOUSE_OVER)) {
				this.optionText.musicOff.removeEventListener(MouseEvent.MOUSE_OVER,onMuteControlOver);
			}
			if (this.optionText.musicOff.hasEventListener(MouseEvent.MOUSE_OUT)) {
				this.optionText.musicOff.removeEventListener(MouseEvent.MOUSE_OUT,onMuteControlOut);
			}
			
			dispatchEvent(new ControlEvent("invisMenus"));
			this.mainMenu.visible = true;
			Mouse.show();
		}
		
		private function bigBadWolf(e:AchievementEvent):void {
			var rewardBubble = new RewardBubble();
			rewardBubble.rewardText.text = "BIGBADWOLF";
			stage.removeEventListener(AchievementEvent.bigBadWolf,bigBadWolf);
			trophies[7].visible = true;
			stage.addChild(rewardBubble);
		}
		
		private function lightSpeedBacon(e:AchievementEvent):void {
			var rewardBubble = new RewardBubble();
			rewardBubble.rewardText.text = "LIGHTSPEEDBACON";
			stage.removeEventListener(AchievementEvent.lightSpeedBacon,lightSpeedBacon);
			trophies[5].visible = true;
			stage.addChild(rewardBubble);
		}
		
		private function makinBacon(e:AchievementEvent):void {
			var rewardBubble = new RewardBubble();
			rewardBubble.rewardText.text = "MAKIN BACON";
			stage.removeEventListener(AchievementEvent.makinBacon,makinBacon);
			trophies[2].visible = true;
			stage.addChild(rewardBubble);
		}
		
		private function oinker(e:AchievementEvent):void {
			var rewardBubble = new RewardBubble();
			rewardBubble.rewardText.text = "OINKER";
			stage.removeEventListener(AchievementEvent.oinker,oinker);
			trophies[0].visible = true;
			stage.addChild(rewardBubble);
		}
		
		private function pigocolypse(e:AchievementEvent):void {
			var rewardBubble = new RewardBubble();
			rewardBubble.rewardText.text = "PIGOCOLYPSE";
			stage.removeEventListener(AchievementEvent.pigocolypse,pigocolypse);
			trophies[8].visible = true;
			stage.addChild(rewardBubble);
		}
		
		private function slaughterHouse(e:AchievementEvent):void {
			var rewardBubble = new RewardBubble();
			rewardBubble.rewardText.text = "SLAUGHTERHOUSE";
			stage.removeEventListener(AchievementEvent.slaughterHouse,slaughterHouse);
			trophies[1].visible = true;
			stage.addChild(rewardBubble);
		}
		
		private function speedyBacon(e:AchievementEvent):void {
			var rewardBubble = new RewardBubble();
			rewardBubble.rewardText.text = "SPEEDYBACON";
			stage.removeEventListener(AchievementEvent.speedyBacon,speedyBacon);
			trophies[3].visible = true;
			stage.addChild(rewardBubble);
		}
		
		private function superSonicBacon(e:AchievementEvent):void {
			var rewardBubble = new RewardBubble();
			rewardBubble.rewardText.text = "SUPERSONICBACON";
			stage.removeEventListener(AchievementEvent.superSonicBacon,superSonicBacon);
			trophies[4].visible = true;
			stage.addChild(rewardBubble);
		}
		
		private function survivalist(e:AchievementEvent):void {
			var rewardBubble = new RewardBubble();
			rewardBubble.rewardText.text = "SURVIVALIST";
			stage.removeEventListener(AchievementEvent.survivalist,survivalist);
			trophies[6].visible = true;
			stage.addChild(rewardBubble);
		}
		
		private function setMouseDown (e:MouseEvent):void {
			this.isMouseDown = true;
			this.refreshIterator = true;
		}
		
		private function setMouseUp (e:MouseEvent):void {
			//this.shootIterator = this.shootSpeed;
			this.isMouseDown = false;
		}
		
		private function addPig (e:TimerEvent):void {
			if (pigsOnScreen < 30) {
				for (var i=0;i<30;i++) {
					if (pigArray[pigIterator].visible == true) {
						if (pigIterator == 29) {
							pigIterator = 0;
						} else {
							pigIterator++;
						}
					} else if (pigArray[pigIterator].visible == false) {
						break;
					}
				}
				pigArray[pigIterator].x = 730;
				pigArray[pigIterator].y = Math.random()*350 + 25;
				if (pigArray[pigIterator].xspeed > 0) {
					pigArray[pigIterator].xspeed *= -1;
				}
				pigArray[pigIterator].visible = true;
				if (pigIterator == 29) {
					pigIterator = 0;
				} else {
					pigIterator++;
				}
				pigsOnScreen++;
			}
		}
		private function addIronPig (e:TimerEvent):void {
			if (ironPigsOnScreen < 5) {
				for (var i=0;i<5;i++) {
					if (ironPigArray[ironPigIterator].visible == true) {
						if (ironPigIterator == 4) {
							ironPigIterator = 0;
						} else {
							ironPigIterator++;
						}
					} else if (ironPigArray[ironPigIterator].visible == false) {
						break;
					}
				}
				ironPigArray[ironPigIterator].x = 730;
				ironPigArray[ironPigIterator].y = Math.random()*350 + 25;
				ironPigArray[ironPigIterator].visible = true;
				if (ironPigIterator == 4) {
					ironPigIterator = 0;
				} else {
					ironPigIterator++;
				}
				ironPigsOnScreen++;
			}
		}
		
		private function eFrame (e:Event):void {
			if (isPaused == false) {
				//scroll backgrounds
				bg1.x -= 4;
				bg2.x -= 4;
				//reset bg if it goes offscreen
				if (bg1.x < -1000) {
					bg1.x = bg2.x;
				}
				if (bg2.x < 0) {
					bg2.x = 2000 + bg1.x;
				}
				
				//move player
				if (mouseX < 700 && mouseX > 0 && mouseY > 0 && mouseY < 400) {
					player.x = mouseX;
					player.y = mouseY;
				}
				checkHit();
				//shoot
				if (this.isMouseDown == true) {
					if (this.shootIterator == this.shootSpeed) {
						this.shootIterator = 0;
						shoot();
					} else {
						this.shootIterator++;
					}
				}
				//iterate shootiterator to fix upgrade cheat bug
				if (this.refreshIterator == true && this.isMouseDown == false) {
					if (this.shootIterator == this.shootSpeed) {
						this.refreshIterator = false;
					} else {
						this.shootIterator++;
					}
				}
			}
		}
		
		private function shoot():void {
			if (player.visible == true) {
				for (var i=0;i<15;i++) {
					if (shotArray[shotIterator].visible == true) {
						if (shotIterator >= 14) {
							shotIterator = 0;
						} else {
							shotIterator++;
						}
					}  else if (shotArray[shotIterator].visible == false) {
						break;
					}
				}
				shotArray[shotIterator].x = player.x + 15;
				shotArray[shotIterator].y = player.y;
				shotArray[shotIterator].visible = true;
				this.shotsFired++;
				this.levelShotsFired++;
				if (this.mute == false && this.muteFx == false) {
					shotArray[shotIterator].makeSound();
				}
				if (shotIterator >= 14) {
					shotIterator = 0;
				} else {
					shotIterator++;
				}
			}
		}
				
		private function gameOver(pigsKilled:String, totalScore:String):void {
			this.healthMeter.scaleX = 0;
			this.shieldMeter.scaleX = 0;
			player.visible = false;
			for (var i in this.bestScoreList) {
				if (this.totalScore > this.bestScoreList[i]) {
					var temp1 = [];
					var temp2 = [];
					for (var j=0;j<5;j++) {
						temp1[j] = this.bestScoreList[j];
						temp2[j] = this.bestGameList[j];
					}
					this.bestScoreList[i] = this.totalScore;
					this.bestGameList[i] = "TOTALSCORE:" + this.totalScore.toString() + "      LVL:" + this.levelNum.toString() + "      PIGSKILLED:" + this.pigsKilled.toString();
					for (var k=i+1;k<5;k++) {
						this.bestScoreList[k] = temp1[k-1];
						this.bestGameList[k] = temp2[k-1];
					}
					break;
				}
			}
			this.bestGames.score1.text = this.bestGameList[0];
			this.bestGames.score2.text = this.bestGameList[1];
			this.bestGames.score3.text = this.bestGameList[2];
			this.bestGames.score4.text = this.bestGameList[3];
			this.bestGames.score5.text = this.bestGameList[4];
			score.finalScore.text = pigsKilled;
			this.gameOverObj.scoreText.text = totalScore;
			Mouse.show();
			if (this.pigTimer.running == true) {
				toggleTimers();
			}
			gameOverContainer.visible = true;
			this.gameOverTween = new Tween(gameOverContainer,"alpha",None.easeNone,0,1,.25,true);
		}
		
		private function newLevel(e:MouseEvent):void {
			beamUpgradeButton.removeEventListener(MouseEvent.CLICK, upgradeBeam);
			shieldUpgradeButton.removeEventListener(MouseEvent.CLICK, upgradeShield);
			armorUpgradeButton.removeEventListener(MouseEvent.CLICK, upgradeArmor);
			shieldRegenUpgradeButton.removeEventListener(MouseEvent.CLICK, upgradeShieldRegen);
			healthRegenUpgradeButton.removeEventListener(MouseEvent.CLICK, upgradeHealthRegen);
			beamSizeUpgradeButton.removeEventListener(MouseEvent.CLICK, upgradeBeamSize);
			beamSpeedUpgradeButton.removeEventListener(MouseEvent.CLICK, upgradeBeamSpeed);
			beamUpgradeButton.removeEventListener(MouseEvent.MOUSE_OVER, onBeamOver);
			shieldUpgradeButton.removeEventListener(MouseEvent.MOUSE_OVER, onShieldOver);
			armorUpgradeButton.removeEventListener(MouseEvent.MOUSE_OVER, onArmorOver);
			shieldRegenUpgradeButton.removeEventListener(MouseEvent.MOUSE_OVER, onShieldRegenOver);
			healthRegenUpgradeButton.removeEventListener(MouseEvent.MOUSE_OVER, onHealthOver);
			beamSizeUpgradeButton.removeEventListener(MouseEvent.MOUSE_OVER, onBeamSizeOver);
			beamSpeedUpgradeButton.removeEventListener(MouseEvent.MOUSE_OVER, onBeamSpeedOver);
			beamUpgradeButton.removeEventListener(MouseEvent.MOUSE_OUT, onBeamOut);
			shieldUpgradeButton.removeEventListener(MouseEvent.MOUSE_OUT, onShieldOut);
			armorUpgradeButton.removeEventListener(MouseEvent.MOUSE_OUT, onArmorOut);
			shieldRegenUpgradeButton.removeEventListener(MouseEvent.MOUSE_OUT, onShieldRegenOut);
			healthRegenUpgradeButton.removeEventListener(MouseEvent.MOUSE_OUT, onHealthOut);
			beamSizeUpgradeButton.removeEventListener(MouseEvent.MOUSE_OUT, onBeamSizeOut);
			beamSpeedUpgradeButton.removeEventListener(MouseEvent.MOUSE_OUT, onBeamSpeedOut);
			nextLevelButton.removeEventListener(MouseEvent.CLICK, newLevel);
			upgradeContainer.visible = false;
			player.visible = true;
			Mouse.hide();
			if (this.pigTimer.running == false) {
				toggleTimers();
			}
			if (this.levelNum < 15) {
				stage.dispatchEvent(new ControlEvent("pigSpeedUp"));
				stage.dispatchEvent(new ControlEvent("ironPigSpeedUp"));
			} else {
				this.basePigDamage += .02;
			}
			stage.dispatchEvent(new ControlEvent("invisPig"));
			stage.dispatchEvent(new ControlEvent("invisIronPig"));
			this.pigsOnScreen = 0;
			this.ironPigsOnScreen = 0;
			this.levelPigsKilled = 0;
			this.levelShotsFired = 0;
			if (pigDelay > 100) {
				pigDelay -= 10;
				this.pigTimer.delay = pigDelay;
			}
			if (ironPigDelay > 1000) {
				ironPigDelay -= 10;
				this.ironPigTimer.delay = ironPigDelay;
			}
			this.pigsTillLevel += 2;
			this.pigsLeft = pigsTillLevel;
			this.levelNum += 1;
			switch (this.levelNum) {
				case 20:
					stage.dispatchEvent(new AchievementEvent(AchievementEvent.survivalist));
					break;
				case 30:
					stage.dispatchEvent(new AchievementEvent(AchievementEvent.bigBadWolf));
					break;
				case 50:
					stage.dispatchEvent(new AchievementEvent(AchievementEvent.pigocolypse));
					break;
			}
			this.levelTextObj.pigsLeftText.text = this.pigsLeft.toString();
			this.levelTextNumObj.levelText.text = this.levelNum.toString();
		}
		
		private function newGame(e:MouseEvent):void {
			if (this.isPaused == true) {
				this.isPaused = false;
				stage.dispatchEvent(new ControlEvent("onPause"));
			}
			Mouse.hide();
			this.levelTextObj.scoreText.text = "0";
			this.hasBeenHit = false;
			this.ironPigDelay = 5000;
			this.basePigDamage = 0;
			this.ironPigTimer.delay = this.ironPigDelay;
			this.numBellies = 0;
			this.shieldRegenDelay = 500;
			this.shieldRegenTimer.delay = this.shieldRegenDelay;
			this.healthRegenDelay = 500;
			this.healthRegenTimer.delay = this.healthRegenDelay;
			this.shieldMeter.scaleX = 1;
			this.healthMeter.scaleX = 1;
			this.shieldIncrement = this.origShieldIncrement;
			this.healthIncrement = this.origHealthIncrement;
			this.shieldRegenIncrement = this.origShieldRegenIncrement;
			this.healthRegenIncrement = this.origHealthRegenIncrement;
			this.beamLevelNum = 1;
			this.beamUpgradeCost = 25;
			this.beamSizeCost = 25;
			this.beamSizeLevelNum = 1;
			this.beamSpeedCost = 25;
			this.beamSpeedLevelNum = 1;
			this.shieldLevelNum = 1;
			this.shieldRegenLevelNum = 1;
			this.armorLevelNum = 1;
			this.healthRegenLevelNum =1;
			this.shieldCost = 25;
			this.shieldRegenCost = 25;
			this.armorCost = 25;
			this.healthRegenCost = 25;
			this.shootSpeed = 15;
			pigDelay = 500;
			this.pigTimer.delay = pigDelay;
			this.levelNum = 1;
			this.levelTextNumObj.levelText.text = levelNum.toString();
			this.pigsTillLevel = 15;
			this.pigsLeft = pigsTillLevel;
			this.levelTextObj.pigsLeftText.text = this.pigsLeft.toString();
			stage.dispatchEvent(new ControlEvent(ControlEvent.resetSpeed));
			stage.dispatchEvent(new ControlEvent("invisPig"));
			stage.dispatchEvent(new ControlEvent("invisIronPig"));
			stage.dispatchEvent(new ControlEvent("resetBeamSize"));
			stage.dispatchEvent(new ControlEvent("invisBeam"));
			stage.dispatchEvent(new ControlEvent("invisExplosions"));
			pigsOnScreen = 0;
			ironPigsOnScreen = 0;
			pigsKilled = 0;
			this.levelPigsKilled = 0;
			this.hasBeenHit = false;
			this.comboMultiplier = 1;
			this.totalScore = 0;
			dispatchEvent(new ControlEvent("invisMenus"));
			if (this.pigTimer.running == false) {
				toggleTimers();
			}
			this.comboTimer.reset();
			this.comboTimer.start();
			this.hud.visible = true;
			player.visible = true;
		}
		
		private function upgrade():void {
			this.player.visible = false;
			this.levelCompleteBubble.visible = true;
			var tween = new Tween(this.levelCompleteBubble,"alpha",Strong.easeIn,1,0,1,true);
			this.levelBubbleTimer.addEventListener(TimerEvent.TIMER,onUpgrade,false,0,true);
			this.levelBubbleTimer.start();
		}
		
		private function onUpgrade(e:TimerEvent):void {
			this.levelBubbleTimer.stop();
			this.levelCompleteBubble.visible = false;
			beamUpgradeButton.addEventListener(MouseEvent.CLICK, upgradeBeam);
			shieldUpgradeButton.addEventListener(MouseEvent.CLICK, upgradeShield);
			armorUpgradeButton.addEventListener(MouseEvent.CLICK, upgradeArmor);
			shieldRegenUpgradeButton.addEventListener(MouseEvent.CLICK, upgradeShieldRegen);
			healthRegenUpgradeButton.addEventListener(MouseEvent.CLICK, upgradeHealthRegen);
			beamSizeUpgradeButton.addEventListener(MouseEvent.CLICK, upgradeBeamSize);
			beamSpeedUpgradeButton.addEventListener(MouseEvent.CLICK, upgradeBeamSpeed);
			beamUpgradeButton.addEventListener(MouseEvent.MOUSE_OVER, onBeamOver);
			shieldUpgradeButton.addEventListener(MouseEvent.MOUSE_OVER, onShieldOver);
			armorUpgradeButton.addEventListener(MouseEvent.MOUSE_OVER, onArmorOver);
			shieldRegenUpgradeButton.addEventListener(MouseEvent.MOUSE_OVER, onShieldRegenOver);
			healthRegenUpgradeButton.addEventListener(MouseEvent.MOUSE_OVER, onHealthOver);
			beamSizeUpgradeButton.addEventListener(MouseEvent.MOUSE_OVER, onBeamSizeOver);
			beamSpeedUpgradeButton.addEventListener(MouseEvent.MOUSE_OVER, onBeamSpeedOver);
			beamUpgradeButton.addEventListener(MouseEvent.MOUSE_OUT, onBeamOut);
			shieldUpgradeButton.addEventListener(MouseEvent.MOUSE_OUT, onShieldOut);
			armorUpgradeButton.addEventListener(MouseEvent.MOUSE_OUT, onArmorOut);
			shieldRegenUpgradeButton.addEventListener(MouseEvent.MOUSE_OUT, onShieldRegenOut);
			healthRegenUpgradeButton.addEventListener(MouseEvent.MOUSE_OUT, onHealthOut);
			beamSizeUpgradeButton.addEventListener(MouseEvent.MOUSE_OUT, onBeamSizeOut);
			beamSpeedUpgradeButton.addEventListener(MouseEvent.MOUSE_OUT, onBeamSpeedOut);
			nextLevelButton.addEventListener(MouseEvent.CLICK, newLevel);
			this.upgradeContainer.visible = true;
			this.upgradeTween = new Tween(this.upgradeContainer,"alpha",None.easeNone,0,1,.25,true);
			this.player.visible = false;
			if (this.pigTimer.running == true) {
				toggleTimers();
			}
			onPigsKilledTimer(null);
			this.levelTextObj.pigsLeftText.text = "0";
			stage.dispatchEvent(new ControlEvent("invisExplosions"));
			stage.dispatchEvent(new ControlEvent("invisBeam"));
			Mouse.show();
			numBellies += levelPigsKilled;
			if (this.beamSpeedLevelNum < 10) {
				upgradeText.beamSpeedLevel.text = this.beamSpeedLevelNum.toString();
				upgradeText.beamSpeedCost.text = this.beamSpeedCost.toString();
			} else {
				upgradeText.beamSpeedLevel.text = "MAX";
				upgradeText.beamSpeedCost.text = "";
			}
			if (this.beamSizeLevelNum < 10) {
				upgradeText.beamSizeLevel.text = this.beamSizeLevelNum.toString();
				upgradeText.beamSizeCost.text = this.beamSizeCost.toString();
			} else {
				upgradeText.beamSizeLevel.text = "MAX";
				upgradeText.beamSizeCost.text = "";
			}
			if (this.beamLevelNum < 10) {
				upgradeText.beamCost.text = this.beamUpgradeCost.toString();
				beamLevelText.beamLevel.text = this.beamLevelNum.toString();
			} else {
				upgradeText.beamCost.text = "";
				beamLevelText.beamLevel.text = "MAX";
			}
			if (this.shieldLevelNum < 10) {
				upgradeText.shieldLevel.text = this.shieldLevelNum.toString();
				upgradeText.shieldCost.text = this.shieldCost.toString();
			} else {
				upgradeText.shieldLevel.text = "MAX";
				upgradeText.shieldCost.text = "";
			}
			if (this.shieldRegenLevelNum < 10) {
				upgradeText.shieldRegenLevel.text = this.shieldRegenLevelNum.toString();
				upgradeText.shieldRegenCost.text = this.shieldRegenCost.toString();
			} else {
				upgradeText.shieldRegenLevel.text = "MAX";
				upgradeText.shieldRegenCost.text = "";
			}
			if (this.armorLevelNum < 10) {
				upgradeText.armorLevel.text = this.armorLevelNum.toString();
				upgradeText.armorCost.text = this.armorCost.toString();
			} else {
				upgradeText.armorLevel.text = "MAX";
				upgradeText.armorCost.text = "";
			}
			if (this.healthRegenLevelNum < 10) {
				upgradeText.healthRegenLevel.text = this.healthRegenLevelNum.toString();
				upgradeText.healthRegenCost.text = this.healthRegenCost.toString();
			} else {
				upgradeText.healthRegenLevel.text = "MAX";
				upgradeText.healthRegenCost.text = "";
			}
			this.bellyTimer.addEventListener(TimerEvent.TIMER,onBellyTimer);
			this.bellyTimer.start();
		}
		
		private function onBellyTimer(e:TimerEvent):void {
			belliesText.numBellies.text = this.bellyCount.toString();
			this.bellyCount++;
			if (this.bellyCount > this.numBellies) {
				this.bellyTimer.removeEventListener(TimerEvent.TIMER,onBellyTimer);
				belliesText.numBellies.text = this.numBellies.toString();
				this.bellyTimer.stop();
				this.bellyCount = 0;
			}
		}
		
		private function upgradeBeamSize(e:MouseEvent):void {
			if (this.numBellies >= this.beamSizeCost && this.beamSizeLevelNum < 10) {
				for (var i in shotArray) {
					shotArray[i].width *= 1.15;
					shotArray[i].height *= 1.15;
				}
				this.numBellies -= this.beamSizeCost;
				this.beamSizeCost += 20;
				this.beamSizeLevelNum += 1;
				if (this.beamSizeLevelNum < 10) {
					upgradeText.beamSizeLevel.text = this.beamSizeLevelNum.toString();
					upgradeText.beamSizeCost.text = this.beamSizeCost.toString();
				} else {
					upgradeText.beamSizeCost.text = "";
					upgradeText.beamSizeLevel.text = "MAX";
				}
				belliesText.numBellies.text = this.numBellies.toString();
			}
		}
		
		private function upgradeBeamSpeed(e:MouseEvent):void {
			if (this.numBellies >= this.beamSpeedCost && this.beamSpeedLevelNum < 10) {
				stage.dispatchEvent(new ControlEvent("beamSpeedUp"));
				this.numBellies -= this.beamSpeedCost;
				this.beamSpeedCost += 20;
				this.beamSpeedLevelNum += 1;
				if (this.beamSpeedLevelNum < 10) {
					upgradeText.beamSpeedLevel.text = this.beamSpeedLevelNum.toString();
					upgradeText.beamSpeedCost.text = this.beamSpeedCost.toString();
				} else {
					upgradeText.beamSpeedCost.text = "";
					upgradeText.beamSpeedLevel.text = "MAX";
				}
				belliesText.numBellies.text = this.numBellies.toString();
			}
		}
		
		private function upgradeBeam(e:MouseEvent):void {
			if (this.numBellies >= this.beamUpgradeCost && this.beamLevelNum < 10) {
				this.shootSpeed -= 1;//makes beam faster
				this.numBellies -= this.beamUpgradeCost;
				this.beamUpgradeCost += 20;
				this.beamLevelNum += 1;
				if (this.beamLevelNum < 10) {
					upgradeText.beamCost.text = this.beamUpgradeCost.toString();
					beamLevelText.beamLevel.text = this.beamLevelNum.toString();
				} else {
					upgradeText.beamCost.text = "";
					beamLevelText.beamLevel.text = "MAX";
				}
				belliesText.numBellies.text = this.numBellies.toString();
			}
		}
		
		private function upgradeShield(e:MouseEvent):void {
			if (this.numBellies >= this.shieldCost && this.shieldLevelNum < 10) {
				this.shieldIncrement *= .75;
				this.numBellies -= this.shieldCost;
				this.shieldCost += 20;
				this.shieldLevelNum += 1;
				if (this.shieldLevelNum < 10) {
					upgradeText.shieldCost.text = this.shieldCost.toString();
					upgradeText.shieldLevel.text = this.shieldLevelNum.toString();
				} else {
					upgradeText.shieldLevel.text = "MAX";
					upgradeText.shieldCost.text = "";
				}
				belliesText.numBellies.text = this.numBellies.toString();
			}
		}
		
		private function upgradeShieldRegen(e:MouseEvent):void {
			if (this.numBellies >= this.shieldRegenCost && this.shieldRegenLevelNum < 10) {
				this.shieldRegenIncrement *= 1.15;
				this.numBellies -= this.shieldRegenCost;
				this.shieldRegenCost += 20;
				this.shieldRegenLevelNum += 1;
				if (this.shieldRegenLevelNum < 10) {
					upgradeText.shieldRegenCost.text = this.shieldRegenCost.toString();
					upgradeText.shieldRegenLevel.text = this.shieldRegenLevelNum.toString();
				} else {
					upgradeText.shieldRegenLevel.text = "MAX";
					upgradeText.shieldRegenCost.text = "";
				}
				belliesText.numBellies.text = this.numBellies.toString();
			}
		}
		
		private function upgradeArmor(e:MouseEvent):void {
			if (this.numBellies >= this.armorCost && this.armorLevelNum < 10) {
				this.healthIncrement *= .75;
				this.numBellies -= this.armorCost;
				this.armorCost += 20;
				this.armorLevelNum += 1;
				if (this.armorLevelNum < 10) {
					upgradeText.armorCost.text = this.armorCost.toString();
					upgradeText.armorLevel.text = this.armorLevelNum.toString();
				} else {
					upgradeText.armorLevel.text = "MAX";
					upgradeText.armorCost.text = "";
				}
				belliesText.numBellies.text = this.numBellies.toString();
			}
		}
		
		private function upgradeHealthRegen(e:MouseEvent):void {
			if (this.numBellies >= this.healthRegenCost && this.healthRegenLevelNum < 10) {
				this.healthRegenIncrement *= 1.15;
				if (this.healthRegenIncrement == 0) {
					this.healthRegenIncrement = .01;
				}
				this.numBellies -= this.healthRegenCost;
				this.healthRegenCost += 20;
				this.healthRegenLevelNum += 1;
				if (this.healthRegenLevelNum < 10) {
					upgradeText.healthRegenCost.text = this.healthRegenCost.toString();
					upgradeText.healthRegenLevel.text = this.healthRegenLevelNum.toString();
				} else {
					upgradeText.healthRegenLevel.text = "MAX";
					upgradeText.healthRegenCost.text = "";
				}
				belliesText.numBellies.text = this.numBellies.toString();
			}
		}
		
		private function regenShield(e:TimerEvent):void {
			if (this.player.visible == true && this.isPaused == false) {
				this.shieldMeter.scaleX += this.shieldRegenIncrement;
				if (this.shieldMeter.scaleX >= 1) {
					this.shieldMeter.scaleX = 1;
				}
			}
		}
		
		private function regenHealth(e:TimerEvent):void {
				if (this.player.visible == true && this.isPaused == false) {
				this.healthMeter.scaleX += this.healthRegenIncrement;
				if (this.healthMeter.scaleX >= 1) {
					this.healthMeter.scaleX = 1;
				}
			}
		}
		
		private function checkHit():void {
			for(var i in shotArray) {
				if (shotArray[i].visible == true) {
					for (var l in pigArray) {
						if (pigArray[l].visible ==true) {
							if (distance(shotArray[i],pigArray[l]) <= 25 && shotArray[i].x < 700) {
								var pig = pigArray[l];
								shotArray[i].visible = false;
								var explosion = new Explosion(this.stage);
								explosion.x = pig.x;
								explosion.y = pig.y;
								this.scoreBubbles.addChild(new ScoreBubble(pig.x,pig.y,(10*comboMultiplier).toString()));
								this.totalScore += 10*this.comboMultiplier;
								this.levelTextObj.scoreText.text = this.totalScore.toString();
								stage.addChild(explosion);
								explosions.push(explosion);
								pig.visible = false;
								pigsOnScreen -= 1;
								if (gameOverContainer.visible == false) {
									pigsKilled += 1;
									this.lastPigsKilled += 1;
									if (this.pigsKilled >= 500 && this.hasOinker == false) {
										this.hasOinker = true;
										this.dispatchEvent(new AchievementEvent("oinker"));
									}
									if (this.pigsKilled >= 1000 && this.hasSlaughterHouse == false) {
										this.hasSlaughterHouse = true;
										this.dispatchEvent(new AchievementEvent(AchievementEvent.slaughterHouse));
									}
									if (this.pigsKilled >= 2000 && this.hasMakinBacon == false) {
										this.hasMakinBacon = true;
										this.dispatchEvent(new AchievementEvent("makinBacon"));
									}
									this.levelPigsKilled++;
									if (this.pigsLeft > 0) {
										this.pigsLeft -= 1;
									}
									this.levelTextObj.pigsLeftText.text = this.pigsLeft.toString();
									if (this.levelPigsKilled == this.pigsTillLevel) {
										this.levelTextObj.pigsLeftText.text = "0";
										upgrade();
									}
								}
							}
						}
					}
				}
			}
			for (var j in pigArray) {
				if (pigArray[j].visible == true && player.visible == true) {
					if (distance(pigArray[j],player) < 25 && this.invulnerable == false) {
						if (this.healthMeter.scaleX > this.healthIncrement && this.shieldMeter.scaleX <= this.shieldIncrement) {
							this.shieldMeter.scaleX = 0;
							this.healthMeter.scaleX -= (this.healthIncrement + this.basePigDamage);
							this.hasBeenHit = true;
							this.onComboTimer(null);
							
						} else if (this.shieldMeter.scaleX > this.shieldIncrement){
							this.shieldMeter.scaleX -= (this.shieldIncrement + this.basePigDamage);
							this.hasBeenHit = true;
							this.onComboTimer(null);
						} else {
							this.healthMeter.scaleX = 0;
							this.hasBeenHit = true;
							this.onComboTimer(null);
							if (this.pigTimer.running == true) {
								toggleTimers();
							}
							var pExplosion = new PlayerExplosion(this.stage);
							pExplosion.x = player.x;
							pExplosion.y = player.y;
							playerExplosions.addChild(pExplosion);
							gameOver(pigsKilled.toString(),this.totalScore.toString());
						}
					}
				}
			}
			for (var k in ironPigArray) {
				if (ironPigArray[k].visible == true && player.visible == true) {
					if (distance(ironPigArray[k],player) < 25 && this.invulnerable == false) {
						if (this.healthMeter.scaleX > this.healthIncrement && this.shieldMeter.scaleX <= this.shieldIncrement) {
							this.shieldMeter.scaleX = 0;
							this.healthMeter.scaleX -= (this.healthIncrement + this.basePigDamage);
							this.hasBeenHit = true;
							this.onComboTimer(null);
						} else if (this.shieldMeter.scaleX > this.shieldIncrement){
							this.shieldMeter.scaleX -= (this.shieldIncrement + this.basePigDamage);
							this.hasBeenHit = true;
							this.onComboTimer(null);
						} else {
							this.healthMeter.scaleX = 0;
							var PExplosion = new PlayerExplosion(this.stage);
							PExplosion.x = player.x;
							PExplosion.y = player.y;
							playerExplosions.addChild(PExplosion);
							gameOver(this.pigsKilled.toString(),this.totalScore.toString());
							this.hasBeenHit = true;
							this.onComboTimer(null);
						}
					}
				}
			}
		}
		
		private function distance(Obj1,Obj2) {
			var dx=Obj1.x-Obj2.x;
			var dy=Obj1.y-Obj2.y;
			return Math.sqrt(dx*dx+dy*dy);
		}
		
		private function onInvisMenus(e:ControlEvent):void {
			this.instructionScreen.visible = false;
			this.upgradeContainer.visible = false;
			this.mainMenu.visible = false;
			this.baconScreen.visible = false;
			this.gameOverContainer.visible = false;
			this.creditsScreen.visible = false;
			this.pauseScreen.visible = false;
			this.optionScreen.visible = false;
		}
		
		private function onPigsKilledTimer(e:TimerEvent):void {
			if (this.lastPigsKilled >= 40 && this.lastPigsKilled < 65 && this.hasSpeedyBacon == false) {
				stage.dispatchEvent(new AchievementEvent(AchievementEvent.speedyBacon));
				this.hasSpeedyBacon = true;
				return;
			}
			if (this.lastPigsKilled >= 65 && this.lastPigsKilled < 90 && this.hasSuperSonicBacon == false) {
				stage.dispatchEvent(new AchievementEvent(AchievementEvent.superSonicBacon));
				this.hasSuperSonicBacon = true;
				return;
			}
			if (this.lastPigsKilled >= 90 && this.hasLightSpeedBacon == false) {
				stage.dispatchEvent(new AchievementEvent(AchievementEvent.lightSpeedBacon));
				this.hasLightSpeedBacon = true;
				return;
			}
			this.lastPigsKilled = 0;
		}
		
		private function toggleTimers():void {
			var isOn = this.pigTimer.running;
			switch (isOn) {
				case false:
					this.pigTimer.start();
					this.ironPigTimer.start();
					this.pigsKilledTimer.start();
					this.healthRegenTimer.start();
					this.shieldRegenTimer.start();
					this.comboTimer.start();
					break;
				case true:
					this.pigTimer.stop();
					this.ironPigTimer.stop();
					this.pigsKilledTimer.stop();
					this.healthRegenTimer.stop();
					this.shieldRegenTimer.stop();
					this.comboTimer.stop();
			}
		}
		
		private function onInvulnerable(e:MouseEvent):void {
			var bubble = new InvulnerableBubble();
			if (this.invulnerable == false) {
				this.invulnerable = true;
				bubble.bubbleText.text = "ON";
				stage.addChild(bubble);
			} else {
				this.invulnerable = false;
				bubble.bubbleText.text = "OFF";
				stage.addChild(bubble);
			}
		}
		
		private function onBeamOver(e:MouseEvent):void {
			this.beamBubble.visible = true;
		}
		
		private function onBeamOut(e:MouseEvent):void {
			this.beamBubble.visible = false;
		}
		
		private function onShieldOver(e:MouseEvent):void {
			this.shieldBubble.visible = true;
		}
		
		private function onShieldOut(e:MouseEvent):void {
			this.shieldBubble.visible = false;
		}
		
		private function onArmorOver(e:MouseEvent):void {
			this.armorBubble.visible = true;
		}
		
		private function onArmorOut(e:MouseEvent):void {
			this.armorBubble.visible = false;
		}
		
		private function onShieldRegenOver(e:MouseEvent):void {
			this.shieldRegenBubble.visible = true;
		}
		
		private function onShieldRegenOut(e:MouseEvent):void {
			this.shieldRegenBubble.visible = false;
		}
		
		private function onHealthOver(e:MouseEvent):void {
			this.healthRegenBubble.visible = true;
		}
		
		private function onHealthOut(e:MouseEvent):void {
			this.healthRegenBubble.visible = false;
		}
		
		private function onBeamSizeOver(e:MouseEvent):void {
			this.beamSizeBubble.visible = true;
		}
		
		private function onBeamSizeOut(e:MouseEvent):void {
			this.beamSizeBubble.visible = false;
		}
		
		private function onBeamSpeedOver(e:MouseEvent):void {
			this.beamSpeedBubble.visible = true;
		}
		
		private function onBeamSpeedOut(e:MouseEvent):void {
			this.beamSpeedBubble.visible = false;
		}
		
		private function onContinue(e:MouseEvent):void {
			stage.dispatchEvent(new ControlEvent("onPause"));
			toggleTimers();
			this.isPaused = false;
			this.continueButton.removeEventListener(MouseEvent.CLICK,onContinue);
			this.pauseScreen.visible = false;
		}
		
		private function highScores(e:MouseEvent):void {
			this.bestGameScreen.visible = true;
			this.highscoreReturnButton.addEventListener(MouseEvent.CLICK,onHighScoreReturn);
		}
		
		private function onHighScoreReturn(e:MouseEvent):void {
			this.bestGameScreen.visible = false;
			this.highscoreReturnButton.removeEventListener(MouseEvent.CLICK,onHighScoreReturn);
		}
	
	}
	
}
