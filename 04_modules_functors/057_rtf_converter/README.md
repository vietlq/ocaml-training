## Rich Text Format Converter

Design the architecture of a command line tool for converting documents between rich text formats, and apply processing passes on them.

Sample commands recognized by the tool:

```bash
rtftool -from latex -to text:out.txt -pass flatten-maths
rtftool -from latex:f.tex -to html:f.html -pass retrieve-urls
```

### General Design

* The Rtf intermediate language module
* A series of input rich text format modules with their own internal representations, either ad-hoc or decorator modules around existing libraries
* Their associated converters to Rtf that may fail if the input document is too complex for the common language
* The same for output formats
* A functor Converter.Make that takes an input and an output format and instantiates a dedicated conversion function
* A registry associating names to first class format and conversion modules and to processing passes
* A main program analyzing the command line to load the appropriate modules from the registry or by dynlinking, and launching the conversion and processing

