package save.util;

import save.ChromaSave;

import flixel.util.FlxSave;
import flixel.FlxG;

class ChromaConvert
{
    static private var isFlixel:Bool = true;

    static public function convertFlxSave(flxSave:FlxSave, savePath:String, merge:Bool = false):ChromaSave
    {
        if (!isFlixel)
        {
            throw 'convertFlxSave requires flixel!';
            return new ChromaSave(savePath);
        }

        var save = new ChromaSave(savePath);

        if (merge) save.parse();

        for (key in Reflect.fields(flxSave.data)) {
            save.set(key, Reflect.field(flxSave.data, key));
        }

        save.save();

        return save;
    }

    inline static public function fromFlxG(savePath:String, merge:Bool = false):ChromaSave
    {
        if (FlxG.save == null) throw "FlxG.save is not initialized!";
        return convertFlxSave(FlxG.save, savePath, merge);
    }
}
