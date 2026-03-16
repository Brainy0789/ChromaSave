package save;

import lime.system.System;
import sys.FileSystem;
import sys.io.File;
import haxe.ds.Map;
import haxe.Json;
import Reflect;


class ChromaSave
{
    public var EXT(default, set):String = 'json';

    public function set_EXT(v:String)
    {
        saveFile = saveDir + save + '.$EXT';
    }
    
    public var json:Dynamic;
    public var save = 'save';
    public var data:Map<String, Dynamic>;
    public var saveFile:String;
    public var saveDir:String;

    public function new(save:String)
    {
        this.save = save;
        saveDir = System.applicationStorageDirectory;
        saveFile = saveDir + save + '.$EXT';

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
        json = parsed;
        data = new Map<String, Dynamic>();

        for (key in Reflect.fields(parsed)) {
            data.set(key, Reflect.field(parsed, key));
        }
    }

    public inline function set(key:String, v:Dynamic) data.set(key, v);
    public inline function get(key:String) return data.get(key);

    public function save():Void {
        write(Json.stringify(data, "\t"));
    }

    public function saveFromJson():Void {
        write(Json.stringify(json, '\t'));
    }
}
