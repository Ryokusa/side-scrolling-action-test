package 
{
	import adobe.utils.ProductManager;
	import flash.display.*;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author mhtsu
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var HAP:Shape = new Shape
			var HAPg:Graphics = HAP.graphics
			HAPg.lineStyle(1, 0x000000, 1)
			HAPg.beginFill(0xFF0000);
			HAPg.drawRect(30, 30, 340, 240);
			HAP.x = 400
			var HAPT:TextField = new TextField
			HAPT.width = 340
			HAPT.height = 240
			HAPT.text = "バーミを操作してゴールへ進もう！！\n\n操作方法\n↑　＝　ジャンプ\n→　＝　右へ移動\n←　＝　左へ移動\n\nコインを拾いながら高スコアを目指そう\n\n下の方をクリック"
			HAPT.y = 60
			HAPT.x = 460
			HAPT.selectable = false;
			var HAPF:Boolean = new Boolean(false);
			var d:Boolean = false;
			var mTxt1:TextField = new TextField;
			var mTxt2:TextField = new TextField;
			var titleM:TextField = new TextField
			var txt:TextField = new TextField;
			txt.width = 100;
			txt.height = 100;
			txt.selectable = false;
			stage.addChild(txt);
			var gameF:Boolean = new Boolean(false);
			var mouseF:Boolean = new Boolean(false);
			var p1:player = new player;
			p1.visible = false;
			stage.addChild(p1);
			var p1x:int = new int;
			var p1y:Number = new int;
			var p1x_s:int = new int;	//xスピード
			var p1y_s:Number = new Number;	//yスピード
			var gF:Boolean = new Boolean(false);	//地面フラグ
			var gravity:Number = new Number(0.3);//重力
			var maxX:int = new int(3);	//最大Xスピード
			var maxY:int = new int(6);	//最大Yスピード
			var key:Array = new Array;
			var stages:Array = new Array
			var enemys:Array = new Array
			for (i = 0; i < 15; i++) {
				stages[i] = new Array;
			}
			var stageNum:int = new int(1)
			var Sstage:Array = new Array
			var stageD:Array = new Array
			stageD[1]=[
			[0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,1,0,0,1,0,0,1,0,0,1,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,2,2,0,3,0,1,1,1,1,0,0,0,0,0,0,1,0,0,1,0,0,1,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,1,1,0,0,0,0,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,0,1,0,0,0,0,0,0,1,0,0,0,1,0,1,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,1,0,0,0,1,1,1,1,1,0,1,0,1,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,2,2,0,0,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,1,0,0,0,1,0,0,0,0,0,1,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,2,0,0,2,0,0,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,3,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,1,0,1,0,0,0,0,0,1,0,0,0,0,0,0,1,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,1],
			[1,1,1,1,1,1,0,0,0,0,0,1,1,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,1,0,0,0,0,0,0,0,1],
			[1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1],
			[1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,0,0,0,0,1,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0 ,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1],
			[1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
			]
			var stage0:Array = new Array;//タイトル用
			stage0 = [
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
			]
			var sc:int = new int(0)
			var sc2:int = new int(0)	//次のスクロールまでの微調整
			var i:int = new int(0)
			var ii:int = new int(0)
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN , function(e:KeyboardEvent) :void{
				key[e.keyCode] = true;
			});
			stage.addEventListener(KeyboardEvent.KEY_UP , function(e:KeyboardEvent) :void{
				key[e.keyCode] = false;
			});
			stage.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void {
				mouseF = true;
			});
			stage.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent):void {
				mouseF = false
			});
			menuSet();
			function onEnterFrame():void
			{
				if (gameF) {
					idou();
					atari();
					scroll();
					debug();
					if (key[82]) {
						reset();
					};
					
					p1.x = p1x;
					p1.y = p1y;
				}else {
					menu();
				}
			}
			
			function idou():void
			{
				if (key[37]) {	//左
					p1x_s -= 1;
					p1.LEFT();
				}else if (key[39]) {	//右
					p1x_s += 1;
					p1.RIGHT();
				}else {	//何も押されてないとき
					p1.NORMAL();
					if (p1x_s < 0) {
						p1x_s += 1;
						if (p1x_s > 0) {
							p1x_s = 0;
						}
					}else if (p1x_s > 0) {
						p1x_s -= 1;
						if (p1x_s < 0) {
							p1x_s = 0;
						};
					};
				};
				
				if (key[38]) {	//ジャンプ
					if (gF) {
						gF = false;
						p1y_s = -8;
					}
				}else {
					if (p1y_s < 0) {
						p1y_s += 1;
					}
				}
				if (p1x_s > maxX) {	//スピード制御
					p1x_s = maxX;
				}else if (p1x_s < -maxX) {
					p1x_s = -maxX
				};
				if (!gF) {
					p1y_s += gravity	//重力追加
					if (p1y_s > maxY) {	//スピード制御
						p1y_s = maxY;
					}
					p1y += p1y_s;
				}
				p1x += p1x_s;
				
			}
			
			function atari():void	//当たり判定
			{
				if (p1y > 300) {
					reset();
				}
				var flug:Boolean = new Boolean;
				for (i = 0; i < 15; i++ ) {
					for (ii = sc; ii < 20 + sc; ii++ ) {
						if (Sstage[i][ii] == 1) {
							if (rectA(p1x + 1, p1y, 18, 20, stages[i][ii].x, stages[i][ii].y + 1, 20, 18)) {
								if (p1x + 20 - stages[i][ii].x <= 5) {	//左
									if (p1x_s > 0) {
										p1x_s = 0;
										p1x = stages[i][ii].x - 20
									}
								}
								if (stages[i][ii].x + 20 - p1x <= 5) {	//右
									if (p1x_s < 0) {
										p1x_s = 0;
										p1x = stages[i][ii].x + 20;
									}
								}
							}
							if (rectA(p1x+1, p1y, 18, 20, stages[i][ii].x, stages[i][ii].y, 20, 20)) {
								if (p1y + 20 - stages[i][ii].y <= 8) {	//上
									flug = true;
									if (p1y_s > 0) {
										gF = true;
										p1y_s = 0;
										p1y = stages[i][ii].y - 20;
									}
								}
								if (stages[i][ii].y + 20 - p1y <= 8) {	//下
									if (p1y_s < 0) {
										p1y_s = 0;
										p1y = stages[i][ii].y + 20;
									}
								}
							}
						}else if (Sstage[i][ii] == 2) {
							if (rectA(p1x, p1y, 20, 20, stages[i][ii].x, stages[i][ii].y, 20, 20)) {
								stages[i][ii].visible = false;
								Sstage[i][ii] = 0;
								stages[i][ii].sounds();
							}
						}else if (Sstage[i][ii] == 3) {
							Sstage[i][ii] = 0;
						}
					}
				}
				for (var i:uint = 0; i < enemys.length; i++ ) {
					if (enemys[i] != null){
						enemys[i].ex = enemys[i].x
						enemys[i].ey = enemys[i].y
						enemys[i].ex += enemys[i].exs
						for (var i2:int = 0; i2 < 15; i2++ ) {
							for (var ii2:int = sc; ii2 < 20 + sc; ii2++ ) {
								if (Sstage[i2][ii2] == 1){
									if (rectA(enemys[i].ex , enemys[i].ey+2, 20, 16, stages[i2][ii2].x, stages[i2][ii2].y, 20,20)) {
										enemys[i].exs *= -1
										if (enemys[i].exs > 0) {
											enemys[i].RIGHT();
											enemys[i].ex = stages[i2][ii2].x + 21
										}else if (enemys[i].exs < 0) {
											enemys[i].LEFT();
											enemys[i].ex = stages[i2][ii2].x - 21
										}
									}
								}
							}
						}
						enemys[i].x = enemys[i].ex
					}
				}
				if (!flug) {
					gF = false;
				}
				
				if (p1x < 0) p1x = 0
				
			}
			
			function scroll():void {
				if (p1x > 200) {
					p1x = 200
					sc2 += p1x_s
					for (i = 0; i < 15;i++ ) {
						for (ii = sc; ii < 21 + sc; ii++) {
							if (Sstage[i][ii] > 0 && Sstage[i][ii] < 3) {
								stages[i][ii].x -= p1x_s;
							}
						}
					}
					for (i = 0; i < enemys.length; i++) {
						if (enemys[i] != null ) {
							enemys[i].x -= p1x_s;
						}
					}
					if (sc2 >= 20) {
						sc2 = 0;
						unloadStage(Sstage, sc);
						sc += 1
						loadStage(Sstage, sc);
					}
				}
			}
			
			function debug():void {
			}
			
			function reset():void {
				//スクロールやブロック非表示
				sc2 = 0;
				unloadStage(Sstage, sc);
				unEnemy();
				sc = 0;
				p1x = 0;
				p1y = 0;
				Sstage = clone(stageD[stageNum]);
				loadStage(Sstage, sc);
			}
			
			function menuSet():void {
				loadStage(stage0);
				var titleF:TextFormat = new TextFormat
				titleF.size = 40
				titleF.font = "Meiryo UI Bold"
				titleM.x = 90;
				titleM.y = 50;
				titleM.autoSize = "left"
				titleM.defaultTextFormat = titleF;
				titleM.text = "バーミの冒険";
				titleM.selectable = false;
				stage.addChild(titleM);
				
				var mTxtF:TextFormat = new TextFormat;
				mTxtF.size = 30;
				
				mTxt1.autoSize = "left"
				mTxt1.x = 150;
				mTxt1.y = 130;
				mTxt1.defaultTextFormat = mTxtF;
				mTxt1.text = "スタート";
				mTxt1.selectable = false
				stage.addChild(mTxt1);
				
				mTxt2.autoSize = "left"
				mTxt2.x = 150;
				mTxt2.y = 170;
				mTxt2.defaultTextFormat = mTxtF;
				mTxt2.selectable = false;
				mTxt2.text = "遊び方";
				stage.addChild(mTxt2);
			}
			
			function menu():void {
				var flug1:Boolean = new Boolean(false);//フラグ
				var flug2:Boolean = new Boolean(false);
				if (!HAPF){
					if (stage.mouseX >= mTxt1.x) {
						if (stage.mouseX <= mTxt1.x + mTxt1.width) {
							if (stage.mouseY >= mTxt1.y) {
								if (stage.mouseY <= mTxt1.y + mTxt1.height) {
									flug1 = true;
									p1.visible = true;
									p1.x = mTxt1.x - 30
									p1.y = mTxt1.y + 10
									if (mouseF) {
										p1.visible = true;
										p1.x = 0;
										p1.y = 0;
										mTxt1.visible = false;
										mTxt2.visible = false;
										titleM.visible = false;
										unloadStage(stage0);
										Sstage = clone(stageD[stageNum]);
										loadStage(Sstage);
										gameF = true;
									}
								}
							}
						}
					}
				}
				if (stage.mouseX >= mTxt2.x) {
					if (stage.mouseX <= mTxt2.x + mTxt2.width) {
						if (stage.mouseY >= mTxt2.y) {
							if (stage.mouseY <= mTxt2.y + mTxt2.height) {
								flug2 = true;
								p1.visible = true;
								p1.x = mTxt2.x - 30
								p1.y = mTxt2.y + 10
								if (mouseF) {	//遊び方表示
									HAPF = true;	
									HAP.x = 0
									HAPT.x = 60
									stage.addChild(HAP);
									stage.addChild(HAPT);
								}
							}
						}
					}
				}
				if (HAPF) {
					if (!mouseF) {
						d = true;
					}
					if (mouseF && d) {
						HAPF = false;
						HAP.x = 400;
						HAPT.x = 460;
						HAPT.y = 60;
						d = false;
					}
				}
				if (!flug1 && !flug2) p1.visible = false;
			}
			
			function loadStage(stageo:Array , sc:int = 0):void {
				for (i = 0; i < 15;i++ ) {
					for (ii = sc; ii < 21+sc; ii++) {
						if (stageo[i][ii] == 1) {	//ブロック
							stages[i][ii] = new sBlock;
							stages[i][ii].x = (ii-sc) * 20;
							stages[i][ii].y = i * 20;
							stage.addChild(stages[i][ii]);
						}else if (stageo[i][ii] == 2) {	//コイン
							stages[i][ii] = new sCoin;
							stages[i][ii].x = (ii-sc) * 20;
							stages[i][ii].y = i * 20;
							stage.addChild(stages[i][ii]);
						}else if (stageo[i][ii] == 3) {
							var l:int = enemys.length
							enemys[l] = new sEnemy
							enemys[l].x = (ii-sc) * 20 + 5;
							enemys[l].y = i * 20;
							stage.addChild(enemys[l]);
							enemys[l].RIGHT();
							stageo[i][ii] = 0;
						}
					}
				}
			}
			function unloadStage(stageo:Array, sc:int = 0):void {
				for (i = 0; i < 15;i++ ) {
					for (ii = sc; ii < 21 + sc; ii++) {
						if (stageo[i][ii] > 0 && stageo[i][ii] < 3) {
							stage.removeChild(stages[i][ii]);
							stages[i][ii] = null;
						}
					}
				}
			};
			function unEnemy():void {
				for (i = 0; i < enemys.length; i++ ) {
					if (enemys[i] != null){
						stage.removeChild(enemys[i])
						enemys[i] = null
					}
				}
			}
			function clone(obj:Object):*  
			{  
				var ba:ByteArray = new ByteArray();
				ba.writeObject(obj);
				ba.position = 0;
				return(ba.readObject());
			}  
			//四角の当たり判定
			function rectA(x1:int, y1:int, sizeX1:uint, sizeY1:uint, x2:int, y2:int, sizeX2:uint, sizeY2:uint ):Boolean
			{
				var KEKKA:Boolean = new Boolean(false);
				
				if (x1 + sizeX1 < x2) {
				}else if (x1 > x2 + sizeX2) {
				}else if (y1 + sizeY1 < y2) {
				}else if (y1 > y2 + sizeY2) {
				}else {
					KEKKA = true;
				}
				return KEKKA;
			}
		}
		
	}
}
import adobe.utils.CustomActions;
import flash.display.*
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
class player extends Sprite
{
	[Embed(source = "ba-mi1.jpg")] private static const img1:Class;
	[Embed(source = "ba-mi2.jpg")] private static const img2:Class;
	[Embed(source = "ba-mi3.jpg")] private static const img3:Class;
	private var n:Bitmap = new img1;
	private var r:Bitmap = new img2;
	private var l:Bitmap = new img3;
	public function player():void {
		addChild(n);
	}
	public function NORMAL():void {
		removeChildAt(0);
		addChild(n);
	}
	public function RIGHT():void {
		removeChildAt(0);
		addChild(r);
	}
	public function LEFT():void {
		removeChildAt(0);
		addChild(l);
	}
}
class sBlock extends Shape
{
	public function sBlock():void {
		var g:Graphics = this.graphics;
		g.lineStyle(1, 0x000000);
		g.beginFill(0xFF0000, 1); 
		g.drawRect(0, 0, 20, 20);
	}
}

class sCoin extends Shape
{
	[Embed(source = "coin.mp3")] private static const cS:Class;
	private var s:Sound = new cS;
	private var soundc:SoundChannel = new SoundChannel;
	public function sCoin():void {
		var g:Graphics = this.graphics
		g.lineStyle(1, 0x000000);
		g.beginFill(0xFFFF00);
		g.drawCircle(10, 9, 9);
		var ss:SoundTransform = new SoundTransform;
		ss.volume = 0
		s.play(0, 0, ss);
	}
	public function sounds():void {
		s.play(0, 0);
	}
}

class sEnemy extends Sprite
{
	[Embed(source="eni-_center.png")]private static const img1:Class;
	[Embed(source="eni-_left.png")]private static const img2:Class;
	[Embed(source="eni-_right.png")]private static const img3:Class;
	private var n:Bitmap = new img1;
	private var l:Bitmap = new img2;
	private var r:Bitmap = new img3;
	public var ex:Number = new Number
	public var ey:Number = new Number
	public var exs:Number = new Number(1.5)
	public var eys:Number = new Number(1.5)
	public function sEnemy():void {
		this.addChild(n);
	}
	public function NORMAL():void {
		removeChildAt(0);
		this.addChild(n)
	}
	public function RIGHT():void {
		removeChildAt(0);
		this.addChild(r);
	}
	public function LEFT():void {
		removeChildAt(0);
		this.addChild(l);
	}
}