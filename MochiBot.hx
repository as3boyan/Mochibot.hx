import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.Loader;
import flash.system.Security;
import flash.system.Capabilities;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;

/*

        Usage:

            MochiBot.track(this, "XXXXXXXX");

    */class MochiBot extends Sprite {

	static public function track(parent : Sprite, tag : String) : MochiBot {
		if(Security.sandboxType == "localWithFile")  {
			return null;
		}
		var self : MochiBot = new MochiBot();
		parent.addChild(self);
		Security.allowDomain("*");
		Security.allowInsecureDomain("*");
		var server : String = "http://core.mochibot.com/my/core.swf";
		var lv : URLVariables = new URLVariables();
		Reflect.setField(lv, "sb", Security.sandboxType);
		Reflect.setField(lv, "v", Capabilities.version);
		Reflect.setField(lv, "swfid", tag);
		Reflect.setField(lv, "mv", "8");
		Reflect.setField(lv, "fv", "9");
		var url : String = self.root.loaderInfo.loaderURL;
		if(url.indexOf("http") == 0)  {
			Reflect.setField(lv, "url", url);
		}

		else  {
			Reflect.setField(lv, "url", "local");
		}

		var req : URLRequest = new URLRequest(server);
		req.contentType = "application/x-www-form-urlencoded";
		req.method = URLRequestMethod.POST;
		req.data = lv;
		var loader : Loader = new Loader();
		self.addChild(loader);
		loader.load(req);
		return self;
	}


	public function new() {
		super();
	}
}

