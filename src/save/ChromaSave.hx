package save;

import lime.system.System;
import sys.FileSystem;
import sys.io.File;
import haxe.ds.Map;
import Reflect;


class ChromaSave
{
    public var data:Map<String, Dynamic>;
    public var saveFile:String;
    public var saveDir:String;

    public function new(save:String)
    {
        saveDir = System.applicationStorageDirectory;
        saveFile = saveDir + save + ".json";

        if (!FileSystem.exists(saveDir)) {
            FileSystem.createDirectory(saveDir);
        }

        data = new Map<String, Dynamic>();
    }

    public function read():String {
        if (FileSystem.exists(saveFile)) {
            return File.getContent(saveFile);
        }
        return null;
    }

    public function write(contents:String) {
        File.saveContent(saveFile, contents);
    }

    public function parse():Void
    {
        var raw:String = read();
        if (raw == null) {
            data = new Map();
            return;
        }

        var parsed:Dynamic = Json.parse(raw);
        data = new Map<String, Dynamic>();

        for (key in Reflect.fields(parsed)) {
            data.set(key, Reflect.field(parsed, key));
        }
    }

    public inline function set(key:String, v:Dynamic) data.set(key, v);
    public inline function get(key:String) data.get(key);

    public function save():Void {
        write(Json.stringify(data, "\t"));
    }
}
