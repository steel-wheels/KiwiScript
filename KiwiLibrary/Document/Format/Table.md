# Table file format

## File format

The table data must have <code>class</code> property whose value is "TableData".

The <code>type</code> property defines record type.
The <code>values</code> property defines array of record values.

<pre>
{
  // object type
  class: "TableData"

  // record type
  type: {
    field1:   "n"
    field2:   "b"
  }

  // record values
  values: [
    {
        field1: 123
        field2: true
    },
    {
        field1: 456
        field2: false
    }
  ]
}
</pre>

