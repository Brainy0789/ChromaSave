# ChromaSave

ChromaSave is a simple way to store save data using .SAVE!

## Installation
``` bash
haxelib install chromasave
```


## Usage

``` haxe
import save.ChromaSave;

class Main
{
    static function main()
    {
        var chromaSave = new ChromaSave('save'); //the field is the filename saved in app data

        chromaSave.parse(); //parses the json and initializes the save data

        chromaSave.set('field', true); //add a field to the save data

        Sys.println(chromaSave.get('field')); //outputs 'true'

        //There are other functions, but they aren't currently documented, as they are not not needed to use the system effectively.
    }
}
```
