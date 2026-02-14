# ChromaSave

ChromaSave is a simple way to store save data using .JSON!

## Installation
``` bash
haxelib install chromasave
```


## Usage

``` haxe
import save.ChromaSave;
import save.ChromaConvert;

class Main
{
    static function main()
    {
        // Create a new ChromaSave instance for the 'save' file
        var chromaSave = new ChromaSave("save");

        // Parse existing JSON from disk (if it exists)
        chromaSave.parse();

        // Add or update a field in the save data
        chromaSave.set("field", true);

        // Access the value
        Sys.println(chromaSave.get("field")); // outputs 'true'

        // Write the current data to disk
        chromaSave.save();

        // --- Migrating from FlxSave ---
        // Convert FlxG.save to a ChromaSave instance
        chromaSave = ChromaConvert.fromFlxG("save");

        //You can also use any FlxSave instance with this
        chromaSave = ChromaConvert.convertFlxSave(FlxG.save);
    }
}
```
