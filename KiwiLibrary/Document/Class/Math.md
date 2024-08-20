# Math class
The variable Math is JavaScriptCore native built-in singleton object.

## Constants
## <code>PI</code>
The constant for <code>PI</code>. The data type is @Double@.
<pre>
const half_pi = PI / 2.0 ;
</pre>

## Class methods
### <code>sin, cos, tan</code>
<pre>
Math.sin(rad) ;
Math.cos(rad) ;
Math.tan(rad) ;
</pre>

#### Parameter
|Name       |Type    |Description                  |
|:--        |:--     |:--                          |
|rad        |Double  |Angle value (Unit: radian)   |

#### Return value
Result of calculation typed <code>Double</code>.
When the parameter is NOT number, the return value is <code>undefined</code>.

### asin, acos
The <code>asin()</code> function computes the principal value of the arc sine of x.
The result is in the range [-pi/2, +pi/2].
The <code>acos()</code> function computes the principle value of the arc cosine of x.
The result is in the range [0, pi].

<pre>
Math.asin(value ;
Math.acos(value) ;
</pre>

#### Parameter
|Name       |Type       |Description                  |
|:--        |:--        |:--                          |
|x          |Double     |The value must be \|x\| <= 1.0 |

#### Return value
arc sine/arc cosine of parameter. The result is in the range [-pi/2, +pi/2] for arcsine and range [0, pi] for cosine.

### <code>atan2</code>
<pre>
Math.atan2(y, x) ;
</pre>

#### Parameter

|Name       |Type             |Description                  |
|:--        |:--              |:--                          |
|y          |Double           |Y position                   |
|x          |Double           |X position                   |

#### Return value
Result of calculation typed <code>Double</code>.
When the parameter is NOT number, the return value is <code>undefined</code>.

### <code>sqrt</code>
Returns the square root of the value.
<pre>
Math.sqrt(src) ;
</pre>

#### Parameter
|Name       |Type             |Description                  |
|:--        |:--              |:--                          |
|src        |Double           |Source value                  |

#### Return value
The square root of the source value.
When the parameter is NOT number, the return value is <code>undefined</code>.

### <code>randomInt</code>
Return the random value between given range/
<pre>
let val = Math.randomInt(min, max) ;
</pre>

#### Parameter
|Name       |Type       |Description                    |
|:--        |:--        |:--                            |
|min        |Int        |Minimum value                  |
|max        |Int        |Maximum value                  |

### <code>clamp</code>
Return the source value with clipping by minimum and maximum value.
<pre>
let val = Math.clamp(src, min, max) ;
</pre>

The result is equals to:
<pre>
let val = max(min(x, max), min) ;
</pre>

#### Parameter
|Name       |Type       |Description                    |
|:--        |:--        |:--                            |
|src        |Number     |Source value                   |
|min        |Number     |Minimum value                  |
|max        |Number     |Maximum value                  |

# Related links
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md): Developer's home page
* [KiwiLibrary Framework](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/README.md): The framework contains this library.


