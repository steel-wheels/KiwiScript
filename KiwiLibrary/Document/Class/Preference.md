# Preference
The *Preference* class is used access system preference values.

## Global variables
<pre>
declare var Preference:         PreferenceIF ;


</pre>

The singleton object of Preference class.
<pre>
interface PreferenceIF {
  system : SystemPreferenceIF ;
  user : UserPreferenceIF ;
  view : ViewPreferenceIF ;
}

</pre>

## Sub-preferences
### System preference
<pre>
interface SystemPreferenceIF {
  version : string ;
  logLevel : number ;
  device : Device ;
  style : InterfaceStyle ;
}

</pre>

### User preference
<pre>
interface UserPreferenceIF {
  homeDirectory : URLIF ;
  language : Language ;
}

</pre>

### View preference
<pre>
interface ViewPreferenceIF {
  rootBackgroundColor : ColorIF ;
  controlBackgroundColor : ColorIF ;
  labelColor : ColorIF ;
  textColor : ColorIF ;
  controlColor : ColorIF ;
  terminalForegroundColor : ColorIF ;
  terminalBackgroundColor : ColorIF ;
  graphicsForegroundColor : ColorIF ;
  graphiceBackgroundColor : ColorIF ;
}

</pre>

# Related links
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md): Developer's home page
* [KiwiLibrary Framework](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/README.md): The framework contains this library.


